FROM mcr.microsoft.com/devcontainers/python:3.14-bookworm

WORKDIR /root
COPY requirements.txt .
RUN apt update &&\
    apt upgrade -y &&\
    apt install pandoc texlive-xetex texlive-fonts-recommended texlive-plain-generic texlive-lang-japanese -y &&\
    pip install --no-cache-dir -r requirements.txt &&\
    python -m bash_kernel.install &&\ 
    curl -fsSL https://code-server.dev/install.sh | sh &&\
    curl -fsSL https://deno.land/install.sh | DENO_INSTALL=/usr/local sh

EXPOSE 8080

USER vscode
RUN /usr/local/bin/deno jupyter --install    

CMD ["code-server"]
