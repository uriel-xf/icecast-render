FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

# Prevenir prompts interactivos
RUN apt-get update && apt-get install -y debconf-utils

# Evitar prompt de configuración de icecast2
RUN echo icecast2 icecast2/icecast2-config-setup boolean false | debconf-set-selections

# Instalar icecast2
RUN apt-get install -y icecast2 mime-support && \
    useradd -r icecast && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copiar archivo de configuración
COPY icecast.xml /etc/icecast2/icecast.xml

# Crear carpeta de logs
RUN mkdir -p /var/log/icecast2 && \
    touch /var/log/icecast2/access.log /var/log/icecast2/error.log && \
    chown -R icecast:icecast /etc/icecast2 /var/log/icecast2

EXPOSE 8000

USER icecast

CMD ["icecast2", "-n", "-c", "/etc/icecast2/icecast.xml"]
