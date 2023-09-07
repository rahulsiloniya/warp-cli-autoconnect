#!/usr/bin/bash
out=$(warp-cli status)

function catchit {
	echo "Disconnected"
	tmp=$(warp-cli disconnect)
	exit
}

trap catchit 2 

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
			temp=$(warp-cli disconnect)
			sleep 1
			temp=$(warp-cli connect)
			dur=0
		fi

		if [[ $out =~ "DNS" ]]; then
			echo "Some trouble with DNS resolution"
			sleep 3
		fi
	done
	echo "Connected"
fi
