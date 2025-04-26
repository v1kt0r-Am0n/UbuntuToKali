#!/bin/bash

# Colores para mejor visualización
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variables configurables
INSTALL_DIR="$HOME/ethical_hacking_tools"
LOG_FILE="/var/log/ethical_tools_install.log"
TOOLS_DIR="$INSTALL_DIR/git_tools"

# Función para verificar e instalar dependencias básicas
install_dependencies() {
    echo -e "${YELLOW}[+] Instalando dependencias básicas...${NC}"
    sudo apt install -y git curl wget build-essential libssl-dev zlib1g-dev \
        libncurses5-dev libffi-dev libreadline-dev libbz2-dev libsqlite3-dev \
        python3 python3-pip python3-venv ruby perl libpcap-dev libpq-dev \
        libxml2-dev libxslt1-dev libffi-dev libldns-dev libyaml-dev \
        zlib1g-dev gcc make automake autoconf || {
        echo -e "${RED}[-] Error al instalar dependencias básicas${NC}"
        exit 1
    }
}

# Función para verificar si un paquete está instalado
is_installed() {
    dpkg -l | grep -q "$1"
    return $?
}

# Función para verificar el estado de la instalación
check_status() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ $1 instalado/configurado correctamente.${NC}"
        echo "$(date) - $1 instalado correctamente" >> "$LOG_FILE"
        return 0
    else
        echo -e "${RED}❌ Error instalando/configurando $1. Revisa $LOG_FILE para más detalles.${NC}"
        echo "$(date) - Error instalando $1" >> "$LOG_FILE"
        return 1
    fi
}

# Función para instalar desde GitHub
install_from_github() {
    local repo_url="$1"
    local tool_name="$2"
    local install_dir="$TOOLS_DIR/$tool_name"
    
    echo -e "${YELLOW}[+] Instalando $tool_name desde GitHub...${NC}"
    if [ -d "$install_dir" ]; then
        echo -e "${BLUE}[*] $tool_name ya existe, actualizando...${NC}"
        cd "$install_dir" || return 1
        git pull || {
            echo -e "${RED}[-] Error al actualizar $tool_name${NC}"
            return 1
        }
    else
        git clone "$repo_url" "$install_dir" || {
            echo -e "${RED}[-] Error al clonar $tool_name${NC}"
            return 1
        }
        cd "$install_dir" || return 1
    fi
    
    # Intentar instalar si hay un script de instalación
    if [ -f "requirements.txt" ]; then
        pip3 install -r requirements.txt >> "$LOG_FILE" 2>&1
    fi
    
    if [ -f "setup.py" ]; then
        python3 setup.py install >> "$LOG_FILE" 2>&1
    fi
    
    if [ -f "Makefile" ]; then
        make >> "$LOG_FILE" 2>&1
        sudo make install >> "$LOG_FILE" 2>&1
    fi
    
    check_status "$tool_name"
    cd - >/dev/null 2>&1
}

# Función para borrado seguro
install_wipe_tools() {
    echo -e "${PURPLE}[+] Instalando herramientas de borrado seguro...${NC}"
    
    # shred - Borrado seguro básico
    sudo apt install -y coreutils
    
    # wipe - Herramienta más avanzada
    sudo apt install -y wipe || {
        # Si no está en los repositorios, compilar desde fuente
        echo -e "${YELLOW}[*] wipe no está en los repositorios, compilando desde fuente...${NC}"
        wget https://downloads.sourceforge.net/project/wipe/wipe/4.3/wipe-4.3.tar.gz
        tar -xzf wipe-4.3.tar.gz
        cd wipe-4.3 || return 1
        ./configure && make && sudo make install
        cd ..
        rm -rf wipe-4.3*
    }
    
    # secure-delete - Conjunto de herramientas de borrado seguro
    sudo apt install -y secure-delete
    
    # BleachBit - Limpieza gráfica
    sudo apt install -y bleachbit
    
    # ddrescue - Para sobrescribir discos
    sudo apt install -y gddrescue
    
    # nwipe - Herramienta para borrado completo de discos
    sudo apt install -y nwipe
    
    # scrub - Para patrones de borrado complejos
    sudo apt install -y scrub
    
    check_status "Herramientas de borrado seguro"
    
    echo -e "\n${CYAN}Herramientas de borrado seguro instaladas:${NC}"
    echo -e " - ${GREEN}shred${NC}: Borrado seguro básico (incluido en coreutils)"
    echo -e " - ${GREEN}wipe${NC}: Sobrescritura con múltiples pasadas"
    echo -e " - ${GREEN}srm${NC}: De secure-delete, para borrado seguro"
    echo -e " - ${GREEN}bleachbit${NC}: Interfaz gráfica para limpieza"
    echo -e " - ${GREEN}ddrescue${NC}: Para sobrescritura de discos completos"
    echo -e " - ${GREEN}nwipe${NC}: Borrado completo de discos"
    echo -e " - ${GREEN}scrub${NC}: Patrones complejos de borrado"
}

# Crear archivo de log
sudo touch "$LOG_FILE"
sudo chown "$USER":"$USER" "$LOG_FILE"
echo "=== Inicio de instalación $(date) ===" > "$LOG_FILE"

# Crear directorios para herramientas
mkdir -p "$INSTALL_DIR" "$TOOLS_DIR"

# Actualizar el sistema
echo -e "${YELLOW}[+] Actualizando el sistema...${NC}"
sudo apt update && sudo apt full-upgrade -y && sudo apt dist-upgrade -y
check_status "Actualización del sistema"

# Instalar dependencias básicas
install_dependencies

# Instalación de herramientas de red
echo -e "${YELLOW}[+] Instalando herramientas de red...${NC}"
sudo apt install -y nmap net-tools wireshark tcpdump netdiscover masscan hping3 \
    iptables iproute2 netcat-openbsd socat sshuttle
check_status "Herramientas de red"

# Instalación de herramientas de escaneo web
echo -e "${YELLOW}[+] Instalando herramientas para auditoría web...${NC}"
sudo apt install -y nikto dirb gobuster sqlmap wfuzz wpscan wapiti \
    whatweb httrack mitmproxy burpsuite zaproxy
pip3 install --upgrade sqlmap >> "$LOG_FILE" 2>&1
check_status "Herramientas de auditoría web"

# Herramientas de sniffing y spoofing
echo -e "${YELLOW}[+] Instalando herramientas de sniffing y spoofing...${NC}"
sudo apt install -y ettercap-graphical dsniff arpspoof driftnet bettercap \
    responder macchanger yersinia
check_status "Herramientas de sniffing y spoofing"

# Metasploit Framework
echo -e "${YELLOW}[+] Configurando Metasploit Framework...${NC}"
sudo apt install -y metasploit-framework
sudo systemctl enable postgresql
sudo systemctl start postgresql
sudo msfdb init
check_status "Metasploit Framework"

# Herramientas de cracking
echo -e "${YELLOW}[+] Instalando herramientas de cracking...${NC}"
sudo apt install -y john hashcat hydra fcrackzip pdfcrack \
    samdump2 rainbowcrack
check_status "Herramientas de cracking"

# Herramientas Wi-Fi
echo -e "${YELLOW}[+] Instalando herramientas para auditoría Wi-Fi...${NC}"
sudo apt install -y aircrack-ng reaver bully kismet wifite \
    hostapd-wpe mdk4 pixiewps
check_status "Herramientas Wi-Fi"

# Herramientas forenses
echo -e "${YELLOW}[+] Instalando herramientas forenses...${NC}"
sudo apt install -y sleuthkit autopsy binwalk foremost volatility \
    guymager dc3dd testdisk photorec scalpel
check_status "Herramientas forenses"

# Herramientas adicionales
echo -e "${YELLOW}[+] Instalando herramientas adicionales...${NC}"
sudo apt install -y openvpn proxychains4 tor ngrep dnsutils whois \
    strace ltrace gdb radare2 exploitdb seclists
check_status "Herramientas adicionales"

# Instalación de Docker
echo -e "${YELLOW}[+] Configurando Docker...${NC}"
sudo apt install -y docker.io docker-compose
sudo systemctl enable docker --now
sudo usermod -aG docker "$USER"
check_status "Docker"

# Instalar herramientas desde GitHub
echo -e "${YELLOW}[+] Instalando herramientas desde GitHub...${NC}"
install_from_github "https://github.com/trustedsec/social-engineer-toolkit" "setoolkit"
install_from_github "https://github.com/lanmaster53/recon-ng" "recon-ng"
install_from_github "https://github.com/beefproject/beef" "beef"
install_from_github "https://github.com/SecureAuthCorp/impacket" "impacket"
install_from_github "https://github.com/gentilkiwi/mimikatz" "mimikatz"
install_from_github "https://github.com/rebootuser/LinEnum" "LinEnum"
install_from_github "https://github.com/derv82/wifite2" "wifite2"
install_from_github "https://github.com/BloodHoundAD/BloodHound" "BloodHound"

# Instalar Python tools
echo -e "${YELLOW}[+] Instalando herramientas de Python...${NC}"
pip3 install --upgrade pip >> "$LOG_FILE" 2>&1
pip3 install scapy pwntools impacket requests beautifulsoup4 lxml >> "$LOG_FILE" 2>&1
check_status "Herramientas de Python"

# Instalar herramientas de borrado seguro
install_wipe_tools

# Configurar aliases y PATH
echo -e "${YELLOW}[+] Configurando entorno...${NC}"
echo "export PATH=\$PATH:$TOOLS_DIR" >> ~/.bashrc
echo "alias ll='ls -la'" >> ~/.bashrc
echo "alias wifi-scan='sudo iw dev wlan0 scan | grep SSID'" >> ~/.bashrc
echo "alias myip='curl ifconfig.me'" >> ~/.bashrc
source ~/.bashrc

# Descargar wordlists comunes
echo -e "${YELLOW}[+] Descargando wordlists comunes...${NC}"
sudo mkdir -p /usr/share/wordlists
sudo wget https://github.com/danielmiessler/SecLists/archive/master.zip -O /usr/share/wordlists/SecLists.zip
sudo unzip /usr/share/wordlists/SecLists.zip -d /usr/share/wordlists/
sudo rm /usr/share/wordlists/SecLists.zip
sudo ln -s /usr/share/wordlists/SecLists-master /usr/share/wordlists/seclists

# Limpieza final
echo -e "${YELLOW}[+] Realizando limpieza...${NC}"
sudo apt autoremove -y && sudo apt clean
check_status "Limpieza del sistema"

# Mostrar resumen
echo -e "\n${GREEN}=== Resumen de la instalación ===${NC}"
echo -e "${GREEN}✔ Todas las herramientas han sido instaladas en $INSTALL_DIR${NC}"
echo -e "${GREEN}✔ Herramientas de GitHub en $TOOLS_DIR${NC}"
echo -e "${GREEN}✔ Los logs de instalación se encuentran en $LOG_FILE${NC}"
echo -e "\n${BLUE}Para usar algunas herramientas como Wireshark, Metasploit o Bettercap, es posible que necesites configuraciones adicionales.${NC}"
echo -e "\n${PURPLE}=== Herramientas de borrado seguro disponibles ===${NC}"
echo -e "shred, wipe, srm, bleachbit, ddrescue, nwipe, scrub"
echo -e "\nEjemplos de uso:"
echo -e "  ${CYAN}shred${NC}: shred -vzn 3 archivo.confidencial"
echo -e "  ${CYAN}wipe${NC}: wipe -rfk /ruta/a/borrar"
echo -e "  ${CYAN}srm${NC}: srm -vz /ruta/a/borrar"
echo -e "  ${CYAN}bleachbit${NC}: bleachbit (interfaz gráfica)"
echo -e "\n${GREEN}🎉 Instalación completada! Reinicia tu terminal para aplicar todos los cambios.${NC}"