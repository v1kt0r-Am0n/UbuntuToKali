

## **README.md**

# 🛡️ Script de Instalación de Herramientas de Seguridad para Ubuntu  

Este script automatiza la instalación de las **herramientas más utilizadas en Kali Linux**, adaptadas para funcionar en **Ubuntu**. Provee un entorno completo para hacking ético, pruebas de penetración, análisis forense, y auditoría de redes.

---

## 🚀 **Características del Script**  

Este script instala:  
- **Escáneres de red y puertos**: `nmap`, `wireshark`
- **Auditoría Wi-Fi**: `aircrack-ng`, `wifite`
- **Explotación de vulnerabilidades**: `Metasploit`, `Burp Suite`
- **Crackers de contraseñas**: `John the Ripper`, `Hydra`
- **Ingeniería inversa**: `Ghidra`
- **Anonimato en red**: `Tor`, `Proxychains`
- **Escaneo de vulnerabilidades web**: `Nikto`, `SQLmap`
- **Gestión de contenedores**: `Docker`, `OpenVAS`

---

## 📋 **Requisitos**  

- **Ubuntu 20.04 o superior**.
- Acceso a **sudo** (superusuario).
- Conexión a Internet activa.
  
---

## 🛠️ **Uso del Script**

### **Paso 1:** Clona este repositorio o guarda el script.  
```bash
git clone https://github.com/tu_usuario/ubuntu-security-tools.git
cd ubuntu-security-tools
```

### **Paso 2:** Concede permisos de ejecución al script.  
```bash
chmod +x install-kali-tools.sh
```

### **Paso 3:** Ejecuta el script como superusuario.  
```bash
sudo ./install-kali-tools.sh
```

---

## ⚙️ **Herramientas Instaladas**

| **Herramienta**        | **Descripción**                                     |
|------------------------|-----------------------------------------------------|
| **nmap**               | Escaneo de red y puertos.                           |
| **Wireshark**          | Análisis de tráfico de red.                         |
| **Aircrack-ng**        | Cracking de redes Wi-Fi.                            |
| **Metasploit Framework**| Explotación de vulnerabilidades.                   |
| **Burp Suite**         | Pruebas de seguridad web.                           |
| **John the Ripper**    | Cracker de contraseñas.                             |
| **Hydra**              | Ataques de fuerza bruta.                            |
| **Ghidra**             | Ingeniería inversa y análisis binario.              |
| **Nikto**              | Escaneo de vulnerabilidades en servidores web.      |
| **SQLmap**             | Inyección SQL automatizada.                         |
| **Tor & Proxychains**  | Navegación anónima y redireccionamiento de tráfico. |
| **OpenVAS**            | Escáner de vulnerabilidades de red.                 |
| **Docker**             | Gestión de contenedores.                            |

---

## 📌 **Notas Adicionales**  

- **Ghidra:** Se instalará en `/opt/` y se puede ejecutar con el alias `ghidra`.  
- **OpenVAS:** Una vez instalado, debes ejecutarlo con `gvm-start` para iniciar el servicio.  
- **Metasploit:** El script usa el método oficial para actualizar e instalar Metasploit.

---

## 🧹 **Limpieza**

El script ejecuta automáticamente:  
```bash
apt autoremove -y
```
Esto elimina paquetes innecesarios para mantener el sistema limpio y optimizado.

---

## ❗ **Advertencia Legal**

Este script instala herramientas poderosas para auditoría de seguridad. El uso indebido de estas herramientas es **ilegal** sin el consentimiento adecuado.  
**Úsalas de manera ética y solo en sistemas autorizados.**

---

## 📜 **Licencia**

Este proyecto está licenciado bajo la [MIT License](https://opensource.org/licenses/MIT). Puedes usarlo libremente con fines educativos y profesionales.

---

## 🤝 **Contribuciones**

¿Tienes sugerencias o mejoras? ¡Eres bienvenido a contribuir!  
1. Realiza un fork del repositorio.  
2. Crea una nueva rama para tus cambios:  
   ```bash
   git checkout -b feature-mejora
   ```
3. Realiza un **pull request** cuando termines.

---

## 📧 **Contacto**

Si tienes preguntas o necesitas soporte, puedes contactarme en:juliomacias@tuta.io
