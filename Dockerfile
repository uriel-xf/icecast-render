FROM debian:bullseye-slim

# Desactiva prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive

# Instalar Icecast y soporte MIME
RUN apt-get update && \
    apt-get install -y icecast2 mime-support && \
    useradd -r icecast && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copiar la configuración
COPY icecast.xml /etc/icecast2/icecast.xml

# Permisos y logs
RUN chown -R icecast:icecast /etc/icecast2 && \
    mkdir -p /var/log/icecast2 && \
    chown -R icecast:icecast /var/log/icecast2

EXPOSE 8000

# Ejecutar como usuario no-root
USER icecast

CMD ["icecast2", "-n", "-c", "/etc/icecast2/icecast.xml"]
