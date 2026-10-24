import os
from random import randrange

awww_output = str(os.popen('awww query').read())
awww_output = awww_output.split(" ")
path = awww_output[len(awww_output) - 1].replace('\n', '')

print(path)
