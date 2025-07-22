FROM moul/icecast

EXPOSE 8000

COPY icecast.xml /etc/icecast2/icecast.xml

CMD ["icecast", "-c", "/etc/icecast2/icecast.xml"]
