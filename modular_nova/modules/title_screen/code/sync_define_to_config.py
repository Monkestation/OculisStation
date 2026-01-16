# Syncs the html contents inside of _title_screen_defines.dm to the title_html.txt config file.
import os

source_file = os.path.join(os.path.dirname(__file__), '_title_screen_defines.dm')
destination_file = os.path.join(os.path.dirname(__file__), '../../../../', 'config/nova/title_html.txt')

with open(source_file, 'r') as src:
  lines = src.readlines()

html_start = '#define DEFAULT_TITLE_HTML {"'
html_end = '"}'
html_content = []
inside_html = False

for line in lines:
  if html_start in line:
    inside_html = True
    html_content.append(line.split(html_start, 1)[1].strip())
  elif inside_html:
    if html_end in line:
      html_content.append(line.split(html_end, 1)[0].strip())
      break
    html_content.append(line.strip("\n"))

existing_comment = ""
if os.path.exists(destination_file):
  with open(destination_file, 'r') as dest:
    for line in dest:
      if line.strip() == "-->":
        existing_comment += line
        break
      existing_comment += line

with open(destination_file, 'w') as dest:
  dest.write(existing_comment)
  dest.write('\n'.join(html_content))

print(f"HTML content successfully extracted to {destination_file}")
