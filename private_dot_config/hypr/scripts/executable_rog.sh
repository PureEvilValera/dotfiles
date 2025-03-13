asusctl fan-curve -m "quiet" -f cpu -D 24:0,61:0,67:10,72:29,75:65,77:101,79:141,99:190;
asusctl fan-curve -m "quiet" -f gpu -D 24:0,61:0,67:10,72:29,75:65,77:101,79:141,99:190;
asusctl fan-curve -m "performance" -f cpu -D 24:0,50:0,55:50,60:103,64:128,68:154,73:192,75:255;
asusctl fan-curve -m "performance" -f gpu -D 24:0,50:0,55:50,60:103,64:128,68:154,73:192,75:255;
asusctl fan-curve -m "balanced" -f cpu -D 20c:0%,48c:0%,51c:18%,54c:22%,57c:27%,61c:40%,65c:46%,98c:52%;
asusctl fan-curve -m "balanced" -f gpu -D 20c:0%,48c:0%,51c:24%,54c:27%,57c:33%,61c:43%,65c:50%,98c:60%;
asusctl fan-curve -m "quiet" -e true;
asusctl fan-curve -m "performance" -e true;
asusctl fan-curve -m "balanced" -e true;
asusctl profile -P "balanced"
