#!/bin/bash

# Función para verificar si la instalación fue exitosa
verificar_estado() {
    if [ $? -eq 0 ]; then
        echo "✅ $1 instalado correctamente."
    else
        echo "❌ Error instalando $1. Revisa los logs para más detalles."
        exit 1
    fi
}

# Actualizar el sistema y repositorios
echo "🔄 Actualizando el sistema..."
sudo apt update && sudo apt upgrade -y
verificar_estado "Actualización del sistema"

# Instalación de herramientas de red
echo "📡 Instalando herramientas de red..."
sudo apt install -y nmap net-tools wireshark tcpdump
verificar_estado "Nmap, Net-tools, Wireshark, y Tcpdump"

# Instalación de herramientas de escaneo web y vulnerabilidades
echo "🌐 Instalando herramientas para auditoría web..."
sudo apt install -y nikto dirb gobuster sqlmap
verificar_estado "Nikto, Dirb, Gobuster, y SQLmap"

# Instalación de herramientas de sniffing y spoofing
echo "🕵️ Instalando herramientas de sniffing y spoofing..."
sudo apt install -y ettercap-graphical dsniff arpspoof
verificar_estado "Ettercap, Dsniff, y Arpspoof"

# Instalación de Metasploit Framework
echo "🛠️ Instalando Metasploit Framework..."
sudo apt install -y metasploit-framework
verificar_estado "Metasploit Framework"

# Instalación de John the Ripper para cracking de contraseñas
echo "🔓 Instalando John the Ripper..."
sudo apt install -y john
verificar_estado "John the Ripper"

# Instalación de Hydra para fuerza bruta en servicios de red
echo "🔑 Instalando Hydra..."
sudo apt install -y hydra
verificar_estado "Hydra"

# Instalación de Aircrack-ng para auditoría de redes Wi-Fi
echo "📶 Instalando Aircrack-ng..."
sudo apt install -y aircrack-ng
verificar_estado "Aircrack-ng"

# Instalación de herramientas forenses
echo "🔍 Instalando herramientas forenses..."
sudo apt install -y sleuthkit autopsy binwalk
verificar_estado "Sleuthkit, Autopsy, y Binwalk"

# Instalación de herramientas adicionales
echo "🧰 Instalando herramientas adicionales..."
sudo apt install -y hashcat feroxbuster openvpn
verificar_estado "Hashcat, Feroxbuster y OpenVPN"

# Instalación de Docker para usar contenedores de hacking (opcional)
echo "🐳 Instalando Docker..."
sudo apt install -y docker.io
sudo systemctl enable docker --now
verificar_estado "Docker"

# Limpieza de paquetes innecesarios
echo "🧹 Realizando limpieza del sistema..."
sudo apt autoremove -y && sudo apt clean
verificar_estado "Limpieza del sistema"

echo "🎉 Instalación completa. Las herramientas de hacking ético están listas para usar."
