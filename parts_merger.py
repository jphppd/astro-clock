#!/usr/bin/blender
from math import pi, cos, sin, sqrt
from pathlib import Path
import bpy
import mathutils
import sys
import re

sys.path.append(str(Path(__file__).parent.absolute()))


from utils.constants.clock_to_sun.structure import DATA as CLOCK_TO_SUN_STRUCT
from utils.constants.moon_to_zodiac.structure import DATA as MOON_TO_ZODIAC_STRUCT
from utils.constants.sun_to_lunar_nodes.structure import (
    DATA as SUN_TO_LUNAR_NODES_STRUCT,
)
from utils.constants.sun_to_lunar_phases.structure import (
    DATA as SUN_TO_LUNAR_PHASES_STRUCT,
)
from utils.constants.sun_to_moon.structure import DATA as SUN_TO_MOON_STRUCT
from utils.constants.constants import DATA as CONSTANTS
from utils.constants.structure import DATA as STRUCT_CONSTANTS


SCALE = 1e-3 * CONSTANTS["global_scale"]
GT = CONSTANTS["layer_thickness"] * SCALE

OFFSET_CARRIER = {}
OFFSET_CARRIER["1"] = 0
OFFSET_SUN_TO_MOON = 1
OFFSET_MOON_TO_ZODIAC = OFFSET_SUN_TO_MOON + 1
OFFSET_CARRIER["2"] = OFFSET_MOON_TO_ZODIAC + 5
OFFSET_CLOCK_TO_SUN = OFFSET_CARRIER["2"] + 1
OFFSET_SUN_TO_LUNAR_PHASES = OFFSET_CLOCK_TO_SUN + 1
OFFSET_SUN_TO_LUNAR_NODES = OFFSET_SUN_TO_LUNAR_PHASES + 3
OFFSET_CARRIER["3"] = OFFSET_SUN_TO_LUNAR_NODES + 2
OFFSET_TYMPAN = OFFSET_CARRIER["3"] + 1

STRUCT = {
    "sun_to_moon": {"offset": OFFSET_SUN_TO_MOON, **SUN_TO_MOON_STRUCT},
    "moon_to_zodiac": {"offset": OFFSET_MOON_TO_ZODIAC, **MOON_TO_ZODIAC_STRUCT},
    "clock_to_sun": {"offset": OFFSET_CLOCK_TO_SUN, **CLOCK_TO_SUN_STRUCT},
    "sun_to_lunar_phases": {
        "offset": OFFSET_SUN_TO_LUNAR_PHASES,
        **SUN_TO_LUNAR_PHASES_STRUCT,
    },
    "sun_to_lunar_nodes": {
        "offset": OFFSET_SUN_TO_LUNAR_NODES,
        **SUN_TO_LUNAR_NODES_STRUCT,
    },
}


COLORS = {
    "sun_to_moon": (0, 153, 0),
    "moon_to_zodiac": (255, 0, 0),
    "clock_to_sun": (255, 255, 0),
    "clock_internal_shaft": (255, 255, 0),
    "sun_to_lunar_phases": (204, 51, 255),
    "sun_to_lunar_nodes": (0, 51, 204),
    "structure": (235, 228, 155),
    "spacers": (235, 228, 155),
    "shafts": (255, 184, 51),
    "carrier_1": (255, 184, 51),
    "carrier_2": (255, 184, 51),
    "carrier_3": (255, 184, 51),
    "moon_shaft": (0, 153, 0),
    "moon_internal_shaft": (0, 153, 0),
    "zodiac_shaft": (255, 0, 0),
    "lunar_phases_shaft": (204, 51, 255),
    "lunar_nodes_shaft": (0, 51, 204),
    "sun_shaft": (255, 255, 0),
    "tympan": (179, 179, 204),
    "astro_night": (106, 13, 131),
    "morning_astro_twilight": (238, 93, 108),
    "morning_nautical_twilight": (251, 144, 98),
    "morning_civil_twilight": (238, 175, 97),
    "evening_astro_twilight": (238, 93, 108),
    "evening_nautical_twilight": (251, 144, 98),
    "evening_civil_twilight": (238, 175, 97),
    "motor_case": (235, 228, 155),
    "motor_cap": (235, 228, 155),
}


def set_view():
    area = next(area for area in bpy.context.screen.areas if area.type == "VIEW_3D")
    region = area.spaces[0].region_3d
    region.view_perspective = "ORTHO"
    vm = mathutils.Matrix(
        (
            (-sqrt(3), sqrt(3), 0, 0),
            (-1, -1, 2, 0),
            (sqrt(2), sqrt(2), sqrt(2), -sqrt(12)),
            (0, 0, 0, 1),
        )
    )
    region.view_matrix = vm
    region.view_distance = 0.5


def new_material(name):
    material = bpy.data.materials.new(name=name)
    for index in range(3):
        material.diffuse_color[index] = COLORS[name][index] / 255
    return material


def load_collections(collec_path: Path, parts: dict, parent_collec):
    collec_name = collec_path.stem
    if collec_name in ["utils"]:
        return
    elif collec_name != "parts":
        collec_object = bpy.data.collections.new(collec_name)
        parent_collec.children.link(collec_object)
    else:
        collec_object = parent_collec

    if collec_name in COLORS:
        collec_material = new_material(collec_name)

    for item_path in sorted(collec_path.iterdir()):
        if item_path.is_dir():
            parts[item_path.stem] = {}
            load_collections(item_path, parts[item_path.stem], collec_object)

        if item_path.is_file() and item_path.suffix == ".stl":
            part_name = item_path.stem
            bpy.ops.wm.stl_import(
                filepath=str(item_path),
                global_scale=SCALE,
                forward_axis="X",
                up_axis="Y",
            )
            parts[part_name] = bpy.context.scene.objects[part_name]

            for c in parts[part_name].users_collection:
                c.objects.unlink(parts[part_name])

            collec_object.objects.link(parts[part_name])
            material = (
                new_material(part_name) if part_name in COLORS else collec_material
            )
            parts[part_name].data.materials.append(material)


def translate(part, radius: float, rotation: float, depth: float, mirror=False):
    bpy.ops.object.select_all(action="DESELECT")
    part.select_set(True)
    if mirror:
        bpy.ops.transform.rotate(
            value=pi,
            orient_axis="Z",
        )
    bpy.ops.transform.translate(
        value=[depth, cos(rotation) * radius * SCALE, sin(rotation) * radius * SCALE]
    )
    part.select_set(False)


def rotate(part, rotation: float):
    bpy.ops.object.select_all(action="DESELECT")
    part.select_set(True)
    bpy.ops.transform.rotate(
        value=-rotation,
        orient_axis="X",
    )
    part.select_set(False)


def position_spacers(parts):
    translate(
        parts["c1_c2"],
        STRUCT_CONSTANTS["carrier_outer_radius"] * CONSTANTS["global_scale"],
        0,
        (OFFSET_CARRIER["1"] + 1) * GT,
    )
    translate(
        parts["c2_c3"],
        STRUCT_CONSTANTS["carrier_outer_radius"] * CONSTANTS["global_scale"],
        0,
        (OFFSET_CARRIER["2"] + 1) * GT,
    )


def position_shafts(parts):
    translate(
        parts["shafts"]["moon_shaft"], 0, 0, (STRUCT["sun_to_moon"]["offset"] - 1) * GT
    )
    translate(
        parts["shafts"]["zodiac_shaft"],
        0,
        0,
        (STRUCT["moon_to_zodiac"]["offset"] + 3) * GT,
    )
    translate(
        parts["shafts"]["lunar_nodes_shaft"],
        0,
        0,
        (STRUCT["sun_to_lunar_nodes"]["offset"] + 1) * GT,
    )
    translate(
        parts["shafts"]["sun_shaft"], 0, 0, (STRUCT["clock_to_sun"]["offset"] - 2) * GT
    )
    translate(
        parts["shafts"]["moon_internal_shaft"],
        STRUCT["sun_to_moon"]["2_r"] * CONSTANTS["global_scale"],
        STRUCT["sun_to_moon"]["theta"],
        GT,
    )
    translate(
        parts["shafts"]["lunar_phases_shaft"],
        STRUCT["sun_to_lunar_phases"]["5_r"] * CONSTANTS["global_scale"],
        STRUCT["sun_to_lunar_phases"]["theta"],
        (STRUCT["sun_to_lunar_phases"]["offset"] + 3) * GT,
    )
    translate(
        parts["shafts"]["clock_internal_shaft"],
        STRUCT["clock_to_sun"]["4_r"] * CONSTANTS["global_scale"],
        STRUCT["clock_to_sun"]["theta"] + STRUCT["clock_to_sun"]["4_theta"],
        (STRUCT["clock_to_sun"]["offset"]) * GT,
    )


def position_gears(parts):
    for c in [
        "clock_to_sun",
        "sun_to_moon",
        "sun_to_lunar_phases",
        "moon_to_zodiac",
        "sun_to_lunar_nodes",
    ]:
        s = STRUCT[c]
        for part in parts[c].values():
            if m := re.match(f"{c}_gear_(\d[a-z]?)", part.name):  # type: ignore
                gear_idx = m[1]
                translate(
                    part,
                    s[f"{gear_idx}_r"] * CONSTANTS["global_scale"],
                    s["theta"] + s.get(f"{gear_idx}_theta", 0),
                    (s["offset"] + s.get(f"{gear_idx}_offset", 0)) * GT,
                    mirror=s.get(f"{gear_idx}_mirror", False),
                )


def position_structure_carrier(parts, carrier_idx):
    if f"c{carrier_idx}_carrier" in parts:
        translate(
            parts[f"c{carrier_idx}_carrier"], 0, 0, OFFSET_CARRIER[carrier_idx] * GT
        )

    if f"c{carrier_idx}_carrier_1" in parts:
        rotate(parts[f"c{carrier_idx}_carrier_1"], pi)
        translate(
            parts[f"c{carrier_idx}_carrier_1"],
            0,
            0,
            (OFFSET_CARRIER[carrier_idx] + 1 / 2) * GT,
            mirror=True,
        )

    if f"c{carrier_idx}_carrier_2" in parts:
        translate(
            parts[f"c{carrier_idx}_carrier_2"],
            0,
            0,
            (OFFSET_CARRIER[carrier_idx] + 1 / 2) * GT,
        )


def position_structure_carrier_components(parts, carrier_idx):
    translate(parts[f"c{carrier_idx}_carrier"], 0, 0, OFFSET_CARRIER[carrier_idx] * GT)
    rotate(parts[f"c{carrier_idx}_hub"], 3 / 10 * pi)
    translate(parts[f"c{carrier_idx}_hub"], 0, 0, OFFSET_CARRIER[carrier_idx] * GT)
    sectors = {
        "clock_to_sun": CLOCK_TO_SUN_STRUCT,
        "sun_to_moon": SUN_TO_MOON_STRUCT,
        "sun_to_lunar_phases": SUN_TO_LUNAR_PHASES_STRUCT,
        "moon_to_zodiac": MOON_TO_ZODIAC_STRUCT,
        "sun_to_lunar_nodes": SUN_TO_LUNAR_NODES_STRUCT,
    }

    for sector_name, sector in sectors.items():
        sector_name = f"c{carrier_idx}_sector_{sector_name}"
        if sector.get(f"c{carrier_idx}_mirror", False):
            translate(
                parts[sector_name],
                0,
                0,
                GT,
                mirror=True,
            )
            rotate(parts[sector_name], pi)
        rotate(parts[sector_name], sector["theta"])
        translate(parts[sector_name], 0, 0, OFFSET_CARRIER[carrier_idx] * GT)


def position_structure(parts):
    for carrier_idx in map(str, range(1, 4)):
        position_structure_carrier(parts[f"carrier_{carrier_idx}"], carrier_idx)


def position_tympan(parts):
    for part in parts.values():
        translate(part, 0, 0, OFFSET_TYMPAN * GT)
        bpy.data.objects.remove(part)


def position_motor(parts):
    translate(
        parts["motor_case"],
        STRUCT["clock_to_sun"]["1_r"] * CONSTANTS["global_scale"],
        3 / 2 * pi,
        (OFFSET_CARRIER["2"] + 1 / 2) * GT,
    )
    translate(
        parts["motor_cap"],
        STRUCT["clock_to_sun"]["1_r"] * CONSTANTS["global_scale"],
        3 / 2 * pi,
        (OFFSET_CARRIER["2"] + 1 / 2) * GT,
    )


def clean_first_elements():
    for obj in bpy.data.objects:
        bpy.data.objects.remove(obj)
    for collec in bpy.context.scene.collection.children:
        bpy.context.scene.collection.children.unlink(collec)


def main():
    parts = {}
    top_level_collection = bpy.context.scene.collection
    load_collections(Path("parts"), parts, top_level_collection)
    bpy.ops.object.select_all(action="DESELECT")

    position_gears(parts)
    position_shafts(parts)
    position_structure(parts["structure"])
    position_spacers(parts["structure"]["spacers"])
    position_tympan(parts["tympan"])
    position_motor(parts["motor"])

    set_view()


if __name__ == "__main__":
    clean_first_elements()
    main()
    bpy.ops.wm.save_as_mainfile(filepath="clock.blend")
