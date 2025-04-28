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

# Target input
read -p "Enter the target domain (example.com): " target

# Create folders
mkdir -p recon/$target

echo -e "${GREEN}[+] Starting Subdomain Enumeration...${NC}"

# Subfinder
subfinder -d $target -silent > recon/$target/subdomains.txt

# Assetfinder
assetfinder --subs-only $target >> recon/$target/subdomains.txt

# Amass Passive
amass enum -passive -d $target >> recon/$target/subdomains.txt

# Sort and unique
sort -u recon/$target/subdomains.txt -o recon/$target/subdomains.txt

echo -e "${GREEN}[+] Subdomain enumeration completed.${NC}"
sleep 1

echo -e "${GREEN}[+] Checking Live Hosts...${NC}"

# Live hosts
cat recon/$target/subdomains.txt | httpx -silent > recon/$target/live_subdomains.txt

echo -e "${GREEN}[+] Live hosts saved.${NC}"
sleep 1

echo -e "${GREEN}[+] Collecting URLs from Gau and Wayback...${NC}"

# URLs
gau $target > recon/$target/urls.txt
waybackurls $target >> recon/$target/waybackurls.txt

sort -u recon/$target/urls.txt -o recon/$target/urls.txt
sort -u recon/$target/waybackurls.txt -o recon/$target/waybackurls.txt

echo -e "${GREEN}[+] URL collection completed.${NC}"
sleep 1

echo -e "${GREEN}[+] Directory Bruteforcing...${NC}"

# Directory bruteforce using ffuf (example)
ffuf -w /usr/share/wordlists/dirb/common.txt -u https://$target/FUZZ -o recon/$target/directories.txt

echo -e "${GREEN}[+] Directory bruteforce completed.${NC}"
sleep 1

echo -e "${GREEN}[+] Scanning for Vulnerabilities with Nuclei...${NC}"

# Nuclei
nuclei -l recon/$target/live_subdomains.txt -o recon/$target/nuclei_scan.txt

echo -e "${GREEN}[+] Vulnerability scanning completed.${NC}"
sleep 1

echo -e "${CYAN}[+] Recon Finished! Check recon/$target folder.${NC}"
