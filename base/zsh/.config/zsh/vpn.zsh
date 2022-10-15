# vpn_config_file=$HOME/downloads/client.ovpn
vpn_config_file=$HOME/downloads/profile-14.ovpn
vpn_username="umang.bhalla"
# vpn_password_file=
# vpn_password="4a=Fyb"
vpn_password="hKOI0Mrn5eIP"


vpnup() {
    # Connect to VPN
printf "%s\n%s\n" "$vpn_username" "$vpn_password"  | openvpn3 session-start --config "$vpn_config_file" 
}

vpnls() {
    # List of VPN sessions
    openvpn3 sessions-list
}

vpndown() {
    # Disconnect from VPN
    openvpn3 session-manage --disconnect --config "$vpn_config_file"
}

vpnhelp() {
    # Help
    printf "Usage: vpn [up|down|ls]\n\n\
\tup: connect to VPN\n\
\tdown: disconnect from VPN\n\
\tls: list VPN sessions\n"
}

vpn2up(){
if ip a | grep tun0 1>2;then
   echo "VPN 🟢 -> 🔴"
   # read -p "Kill VPN?: " -n 1 -r 
   #    if [[ $REPLY == ["Yy"] ]]; then
	sudo pkill openvpn3
      # fi
else
  echo "VPN 🔴 -> 🟢 "
   # read -p "Start VPN?: " -n 1 -r 
   #    if [[ $REPLY == ["Yy"] ]]; then
python -c "$( cat << EOF
import pexpect
from pexpect import popen_spawn
commands = "openvpn3 session-start --config /home/umang/downloads/profile-14.ovpn"
commands_list = commands.split(" ")
username = "umang.bhalla"
password = "hKOI0Mrn5eIP"

session = pexpect.popen_spawn.PopenSpawn(commands)
session.expect("Auth User name: ")
session.sendline(username)
session.expect("Auth Password: ")
session.sendline(password)
print("Connected...")
EOF
)"
      # fi
fi

}
