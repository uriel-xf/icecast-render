FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y debconf-utils

# Evita la configuración interactiva
RUN echo icecast2 icecast2/icecast2-config-setup boolean false | debconf-set-selections

# Instala icecast2 y dependencias necesarias
RUN apt-get install -y icecast2 mime-support && \
    useradd -r icecast && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copia config personalizada
COPY icecast.xml /etc/icecast2/icecast.xml

# Configura logs y permisos
RUN mkdir -p /var/log/icecast2 && \
    touch /var/log/icecast2/access.log /var/log/icecast2/error.log && \
    chown -R icecast:icecast /etc/icecast2 /var/log/icecast2

EXPOSE 8000

USER icecast

CMD ["icecast2", "-n", "-c", "/etc/icecast2/icecast.xml"]
