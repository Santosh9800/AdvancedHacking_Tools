#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner
echo -e "${GREEN}"
echo "  ███████╗ █████╗ ███╗   ██╗████████╗ ██████╗ ███████╗██╗  ██╗"
echo "  ██╔════╝██╔══██╗████╗  ██║╚══██╔══╝██╔═══██╗██╔════╝██║  ██║"
echo "  ███████╗███████║██╔██╗ ██║   ██║   ██║   ██║███████╗███████║"
echo "  ╚════██║██╔══██║██║╚██╗██║   ██║   ██║   ██║╚════██║██╔══██║"
echo "  ███████║██║  ██║██║ ╚████║   ██║   ╚██████╔╝███████║██║  ██║"
echo "  ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝ ╚══════╝╚═╝  ╚═╝"
echo ""
echo "        👑  Name    : Santosh Chhetri"
echo "        📺  Channel : Master in White Devil"
echo -e "${NC}"

# Real IP & Location Details
echo -e "${GREEN}\n🌍 Fetching Public IP & Geo Info...${NC}"
ipinfo=$(curl -s ipinfo.io)

ip=$(echo "$ipinfo" | grep ip | cut -d '"' -f4)
city=$(echo "$ipinfo" | grep city | cut -d '"' -f4)
region=$(echo "$ipinfo" | grep region | cut -d '"' -f4)
country=$(echo "$ipinfo" | grep country | cut -d '"' -f4)
loc=$(echo "$ipinfo" | grep loc | cut -d '"' -f4)
org=$(echo "$ipinfo" | grep org | cut -d '"' -f4)
timezone=$(echo "$ipinfo" | grep timezone | cut -d '"' -f4)

latitude=$(echo "$loc" | cut -d ',' -f1)
longitude=$(echo "$loc" | cut -d ',' -f2)

# Location Map URL
map_url="https://www.google.com/maps/search/?api=1&query=$latitude,$longitude"

# Output
echo -e "${CYAN}🔍 Real IP       : $ip"
echo -e "🏙️ City           : $city"
echo -e "🌐 Region         : $region"
echo -e "🗺️ Country        : $country"
echo -e "📍 Coordinates    : $loc"
echo -e "🛰️ ISP            : $org"
echo -e "🕒 Timezone       : $timezone"
echo -e "🗺️ Map Location   : $map_url${NC}"

# OS and Linux Distro Detection
echo -e "${GREEN}\n🧠 Detecting OS and Distro Info...${NC}"

os_type=$(uname -o)
kernel=$(uname -r)
hostname=$(hostname)
arch=$(uname -m)

# Detect Distro
if [ -f /etc/os-release ]; then
    distro=$(grep '^NAME=' /etc/os-release | cut -d '=' -f2 | tr -d '"')
    version=$(grep '^VERSION=' /etc/os-release | cut -d '=' -f2 | tr -d '"')
else
    distro="Unknown"
    version="Unknown"
fi

# Device Detection (for Android/Termux)
termux_check=$(uname -a | grep -i android)
if [ -n "$termux_check" ]; then
    distro="Termux / Android"
fi

echo -e "${CYAN}💻 OS Type        : $os_type"
echo -e "🐧 Distro         : $distro"
echo -e "🔢 Version        : $version"
echo -e "🧬 Architecture   : $arch"
echo -e "⚙️ Kernel         : $kernel"
echo -e "💡 Hostname       : $hostname${NC}"

echo -e "${GREEN}\n✅ All Sensitive System Info Captured. Ready to Rock!${NC}"

echo -e "${GREEN}[+] Updating System Packages...${NC}"
sudo apt update -y && sudo apt upgrade -y

echo -e "${GREEN}[+] Installing GoLang...${NC}"
sudo apt install golang-go -y

echo -e "${GREEN}[+] Installing Basic Tools (git, curl, wget, etc.)...${NC}"
sudo apt install git curl wget -y

echo -e "${GREEN}[+] Installing subfinder...${NC}"
GO111MODULE=on go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
cp ~/go/bin/subfinder /usr/local/bin/

echo -e "${GREEN}[+] Installing assetfinder...${NC}"
go install github.com/tomnomnom/assetfinder@latest
cp ~/go/bin/assetfinder /usr/local/bin/

echo -e "${GREEN}[+] Installing amass...${NC}"
sudo snap install amass

echo -e "${GREEN}[+] Installing httpx...${NC}"
GO111MODULE=on go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
cp ~/go/bin/httpx /usr/local/bin/

echo -e "${GREEN}[+] Installing gau...${NC}"
go install github.com/lc/gau/v2/cmd/gau@latest
cp ~/go/bin/gau /usr/local/bin/

echo -e "${GREEN}[+] Installing waybackurls...${NC}"
go install github.com/tomnomnom/waybackurls@latest
cp ~/go/bin/waybackurls /usr/local/bin/

echo -e "${GREEN}[+] Installing ffuf...${NC}"
go install github.com/ffuf/ffuf@latest
cp ~/go/bin/ffuf /usr/local/bin/

echo -e "${GREEN}[+] Installing nuclei...${NC}"
GO111MODULE=on go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
cp ~/go/bin/nuclei /usr/local/bin/

echo -e "${GREEN}[+] All tools installed successfully!${NC}"

echo -e "${CYAN}[+] Installation Completed. You are ready for Bug Hunting!${NC}"
