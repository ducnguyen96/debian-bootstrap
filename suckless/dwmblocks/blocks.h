//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"BTC: ", "curl 'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT' | grep -Po '[0-9]*+[\.]+[0-9]{2}'", 30, 0},
	{"DOT: ", "curl 'https://api.binance.com/api/v3/ticker/price?symbol=DOTUSDT' | grep -Po '[0-9]*+[\.]+[0-9]{2}'", 30, 0},
	{"VIC: ", "curl -H 'Content-Type: application/json' -X POST -d '{\"query\":\"query{watchList(stocks: [\\\"VIC\\\"]){currentPrice}}\"}' https://msh-data.cafef.vn/graphql/ | jq -r '.data.watchList[0].currentPrice'", 60, 0},
	{"Mem:", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g", 30, 0},
	{"Battery:", "upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep percentage | grep -o '[[:digit:]]*'%", 30, 0},
	{"Volume:", "pactl list sinks | grep '^[[:space:]]Volume:' | head -n 1 | awk -F ' / ' '{print $2}'", 10, 0},
	{"", "date '+%b %d (%a) %I:%M%p'", 5, 0}
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
