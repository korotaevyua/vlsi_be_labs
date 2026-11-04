#!/usr/bin/env python3
"""Convert this project's Magic DRC text report to a KLayout marker database."""
import argparse
import math
from pathlib import Path
import re
import xml.etree.ElementTree as ET


def convert(source, output):
    if source.resolve() == output.resolve():
        raise ValueError("Input and output paths must differ")
    lines = source.read_text(encoding="utf-8").splitlines()
    statuses = [s.removeprefix("Status: ") for s in lines if s.startswith("Status: ")]
    if not statuses or statuses[-1] not in ("PASS", "FAIL"):
        raise ValueError("DRC report is incomplete or ended with an execution error")
    metadata = {}
    for line in lines:
        if ": " in line:
            key, value = line.split(": ", 1)
            metadata[key] = value
    if metadata.get("Coordinates") != "llx lly urx ury (um)":
        raise ValueError("Expected marker coordinates in micrometres")
    top = metadata["Top cell"]
    groups = []
    current = None
    for line in lines:
        line = line.strip()
        if not line or ": " in line:
            continue
        parts = line.split()
        try:
            coords = tuple(float(v) for v in parts) if len(parts) == 4 else None
        except ValueError:
            coords = None
        if coords is None:
            current = (line, [])
            groups.append(current)
        else:
            if current is None or not all(math.isfinite(v) for v in coords):
                raise ValueError("Invalid marker coordinates")
            if coords[0] >= coords[2] or coords[1] >= coords[3]:
                raise ValueError("Marker rectangle has non-positive size")
            current[1].append(coords)
    count = sum(len(boxes) for _, boxes in groups)
    if count != int(metadata["DRC markers"]) or len(groups) != int(metadata["Rule groups"]):
        raise ValueError("Marker counts do not match the report summary")
    if any(not boxes for _, boxes in groups) or (statuses[-1] == "PASS") != (count == 0):
        raise ValueError("Rule groups or final status are inconsistent")

    root = ET.Element("report-database")
    ET.SubElement(root, "description").text = "Magic SKY130 geometry DRC"
    ET.SubElement(root, "original-file").text = metadata["Input GDS"]
    ET.SubElement(root, "generator").text = "Magic DRC / magic_to_klayout.py"
    ET.SubElement(root, "top-cell").text = top
    ET.SubElement(root, "tags")
    categories = ET.SubElement(root, "categories")
    cells = ET.SubElement(root, "cells")
    cell = ET.SubElement(cells, "cell")
    ET.SubElement(cell, "name").text = top
    items = ET.SubElement(root, "items")
    for index, (rule, boxes) in enumerate(groups, 1):
        match = re.search(r"\(([\w.-]+)\)$", rule)
        name = f"rule_{index}" + (f"_{match[1]}" if match else "")
        category = ET.SubElement(categories, "category")
        ET.SubElement(category, "name").text = name
        ET.SubElement(category, "description").text = rule
        for x1, y1, x2, y2 in boxes:
            item = ET.SubElement(items, "item")
            ET.SubElement(item, "category").text = f"'{name}'"
            ET.SubElement(item, "cell").text = top
            ET.SubElement(item, "visited").text = "false"
            ET.SubElement(item, "multiplicity").text = "1"
            values = ET.SubElement(item, "values")
            ET.SubElement(values, "value").text = f"box: ({x1},{y1};{x2},{y2})"
    ET.indent(root)
    ET.ElementTree(root).write(output, encoding="utf-8", xml_declaration=True)
    return count


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("report", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    try:
        count = convert(args.report, args.output)
    except (OSError, ValueError, KeyError) as error:
        parser.exit(2, f"Conversion error: {error}\n")
    print(f"Saved {count} markers to {args.output}")
