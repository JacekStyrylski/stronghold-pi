FROM arm64v8/ubuntu:focal
RUN apt-get update
RUN apt-get install -y wget
RUN wget -O cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64
RUN mv cloudflared /usr/local/bin
RUN chmod +x /usr/local/bin/cloudflared
RUN cloudflared -v
CMD [ "/usr/local/bin/cloudflared", "proxy-dns" ]
