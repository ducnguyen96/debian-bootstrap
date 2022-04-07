//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"Mem:", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g", 30, 0},
	{"Battery:", "upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | grep -o '[[:digit:]]*'%", 30, 0},
	{"Volume:", "amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }'", 10, 0},
	{"", "date '+%b %d (%a) %I:%M%p'", 5, 0}
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
