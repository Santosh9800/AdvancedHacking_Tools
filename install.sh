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
