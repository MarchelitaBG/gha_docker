# ================================
# Dockerfile
# Laboratorio DevOps
# ================================

# Imagen base
FROM ubuntu:24.04

# Información del autor
LABEL maintainer="Edison Naranjo"
LABEL course="DevOps Profesional"
LABEL description="Imagen Ubuntu personalizada para laboratorios Docker"

# Evita preguntas durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Variables de entorno
ENV APP_NAME="Laboratorio Docker"
ENV VERSION="1.0"
ENV TZ="America/Guayaquil"

# Actualizar repositorios e instalar paquetes
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y \
        apache2 \
        curl \
        wget \
        vim \
        nano \
        htop \
        iputils-ping \
        net-tools \
        dnsutils \
        unzip \
        git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Crear un directorio para la aplicación
WORKDIR /opt/laboratorio

# Crear una página web sin utilizar archivos externos
RUN echo "<!DOCTYPE html>" > /var/www/html/index.html && \
    echo "<html>" >> /var/www/html/index.html && \
    echo "<head><title>Docker DevOps</title></head>" >> /var/www/html/index.html && \
    echo "<body>" >> /var/www/html/index.html && \
    echo "<h1>Laboratorio Docker</h1>" >> /var/www/html/index.html && \
    echo "<h2>Curso de Profesionalización en DevOps</h2>" >> /var/www/html/index.html && \
    echo "<p>Imagen creada completamente desde un Dockerfile.</p>" >> /var/www/html/index.html && \
    echo "</body>" >> /var/www/html/index.html && \
    echo "</html>" >> /var/www/html/index.html

# Crear un usuario no privilegiado
RUN useradd -m -s /bin/bash devops

# Exponer el puerto HTTP
EXPOSE 80

# Comando que se ejecutará al iniciar el contenedor
CMD service apache2 start && tail -f /dev/null
