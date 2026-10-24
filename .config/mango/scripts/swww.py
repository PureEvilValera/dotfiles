import os
from random import randrange

awww_output = str(os.popen("awww query").read())
awww_output = awww_output.split(" ")
path = awww_output[len(awww_output) - 1].replace("\n", "")
current = path.split("/")
current = current[len(current) - 1]

images = os.listdir(path.replace(current, ""))
for_hyprlock = "hyprlock.png"

if for_hyprlock in images:
    images.pop(images.index(for_hyprlock))

next = images.index(current) + 1

if next >= len(images):
    next = images[0]
else:
    next = images[next]

next = path.replace(current, next)

awww_command = f"awww img {next} --transition-step 90 --transition-angle 45 --transition-type outer --transition-fps 60 --transition-pos {float(randrange(1, 9, 1)) / 10},{float(randrange(0, 10, 1)) / 10}"

ln_command = f"ln -s -f {next} {path.replace(current, for_hyprlock)}"

os.system(awww_command)
os.system(ln_command)
