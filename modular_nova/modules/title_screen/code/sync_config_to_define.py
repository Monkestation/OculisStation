# Syncs the html contents of the title_html.txt config file to the define inside _title_screen_defines.dm
import os

source_file = os.path.join(os.path.dirname(__file__), '_title_screen_defines.dm')
destination_file = os.path.join(os.path.dirname(__file__), '../../../../', 'config/nova/title_html.txt')

with open(source_file, 'r') as src:
    lines = src.readlines()

with open(destination_file, 'r') as dest:
    html_lines = dest.read().splitlines()

html_start = '#define DEFAULT_TITLE_HTML {"'
html_end = '"}'

# skip top comment
html_to_insert = []
skipping_comment = True
for line in html_lines:
    stripped = line.strip()
    if skipping_comment:
        if stripped.startswith('<!--'):
            continue
        if stripped.endswith('-->'):
            skipping_comment = False
            continue
        if stripped == '':
            continue
        if skipping_comment:
            continue
    html_to_insert.append(line)

if html_to_insert:
    preserved_last_line = html_to_insert[-1]
    html_to_insert = html_to_insert[:-1]
else:
    preserved_last_line = ''

new_lines = []
inside_define = False

for line in lines:
    if html_start in line:
        inside_define = True
        new_lines.append(line)
        continue

    if inside_define:
        if html_end in line:
            for html_line in html_to_insert:
                new_lines.append(html_line + '\n')
            new_lines.append(line)
            inside_define = False
        continue

    new_lines.append(line)

with open(source_file, 'w') as src:
    src.writelines(new_lines)

print(f"Config content successfully written back to {source_file}")
