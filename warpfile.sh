#!/usr/bin/bash
out=$(warp-cli status)

dur=0
echo "Connecting"

if [[ "$out" =~ "Connected" ]]; then
	echo "Connected"
else
	status=$(warp-cli connect)
	while true; do
		dur=$((dur+1))
		out=$(warp-cli status)
		if [[ $out =~ "Connected" ]]; then
			break
		fi
		sleep 2

		if [ $dur -gt 40 ]; then
			echo "Taking longer than expected"
			echo "Retrying"
			$(warp-cli disconnect)
			sleep 1
			$(warp-cli connect)
			dur=0
		fi

		if [[ $out =~ "DNS" ]]; then
			echo "Some trouble with DNS resolution"
			sleep 3
		fi
	done
	echo "Connected"
fi
