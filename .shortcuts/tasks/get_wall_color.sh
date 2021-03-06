#!/bin/bash

BRIGHTNESS_FILTER='
import sys
import colorsys

colours = []
for line in sys.stdin:
    line = line.strip()
    og_line = str(line)
    if line.startswith("#"):
        line = line[1:]
    r = int(line[0:2], 16) / 255
    g = int(line[2:4], 16) / 255
    b = int(line[4:6], 16) / 255
    hsl = colorsys.rgb_to_hls(r, g, b)
    text = "#000000" if hsl[1] >= .49 else "#FFFFFF"
    colours.append([og_line, (r, g, b), text])

chosen_colours = []
regected_colors = []
print("Rejecting colours with s < 0.20 or v < 0.30", file=sys.stderr)
for colour in colours:
    og_line, (r, g, b), __ = colour
    hsv = colorsys.rgb_to_hsv(r, g, b)
    l, m = (regected_colors, "\033[31mR\033[0m") if hsv[1] < 0.2 or hsv[2] < 0.3 else (chosen_colours, "\033[32mC\033[0m")
    l.append(colour)
    print(
        "{} {:02d}:".format(m, len(regected_colors) + len(chosen_colours)),
        og_line,
        "r: {:03}".format(r * 255),
        "g: {:03}".format(g * 255),
        "b: {:03}".format(b * 255),
        "h: {:.2f} s: {:.2f} v: {:.2f}".format(*hsv),
        file=sys.stderr
    )

def rgb_distance(c0, c1):
    _, rgb0, _ = c0
    _, rgb1, _ = c1
    return ((rgb0[0] - rgb1[0]) * (rgb0[0] - rgb1[0])
        + (rgb0[1] - rgb1[1]) * (rgb0[1] - rgb1[1])
        + (rgb0[2] - rgb1[2]) * (rgb0[2] - rgb1[2]))

if len(chosen_colours) < 3:
    chosen_colours = chosen_colours + regected_colors

first = chosen_colours[0]
contrast = chosen_colours[1]
max_distance = rgb_distance(first, chosen_colours[1])
for c in chosen_colours[2:]:
    d = rgb_distance(first, c)
    if d > max_distance:
        max_distance = d
        contrast = c

second = chosen_colours[1 if contrast != chosen_colours[1] else 2]

for c, _, t in [first, second, contrast]: print(c)
'
convert "$1" +dither -colors 10 histogram: |
    sed -n '/comment={/,/^}/p' |
    sed -E 's/comment=\{\s*|\}|^\s*//g' |
    awk '/[0-9]e\+[0-9]/ { split($0, s, "e+"); base=s[1]; split(s[2], ss, ":"); exponent=ss[1]; print((base * (10^exponent)) ":" ss[2]); }
         $0 !~ /[0-9]e\+[0-9]/ {print}' |
    sort -nr |
    grep -aoP '#[a-fA-F0-9]{6}' |
    python3 -c "$BRIGHTNESS_FILTER" |
    head -1 |
    tr -d '\n'
