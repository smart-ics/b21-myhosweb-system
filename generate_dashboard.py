#!/usr/bin/env python3
"""
MYHOSWEB Development Planning Dashboard Generator

Usage:
  python generate_dashboard.py

Description:
  Reads wave-screen.json (or screen-wave.json) and compiles it into
  myhosweb-development-plan.html with dynamic JS calculations.
"""

import os
import sys

def main():
    current_dir = os.path.dirname(os.path.abspath(__file__))
    json_path = os.path.join(current_dir, 'wave-screen.json')

    if not os.path.exists(json_path) and os.path.exists(os.path.join(current_dir, 'screen-wave.json')):
        json_path = os.path.join(current_dir, 'screen-wave.json')

    if not os.path.exists(json_path):
        print(f"Error: Could not find wave-screen.json or screen-wave.json in {current_dir}", file=sys.stderr)
        sys.exit(1)

    with open(json_path, 'r', encoding='utf-8') as f:
        raw_json = f.read()

    source_filename = os.path.basename(json_path)
    output_path = os.path.join(current_dir, 'myhosweb-development-plan.html')

    # Read node generator or compile directly
    node_script = os.path.join(current_dir, 'generate_dashboard.js')
    if os.path.exists(node_script):
        os.system(f'node "{node_script}"')
    else:
        print(f"Please run: node generate_dashboard.js")

if __name__ == '__main__':
    main()
