FROM python:3.14-bookworm

WORKDIR /root
COPY requirements.txt .
RUN apt update &&\
    apt upgrade -y &&\
    apt install sudo -y &&\
    apt install pandoc texlive-xetex texlive-fonts-recommended texlive-plain-generic texlive-lang-japanese -y &&\
    useradd -m -s /bin/bash vscode &&\
    echo 'export PATH=/home/vscode/.deno/bin:$PATH' >> /home/vscode/.bashrc &&\
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers &&\
    pip install --no-cache-dir -r requirements.txt &&\
    curl -fsSL https://code-server.dev/install.sh | sh

USER vscode
WORKDIR /home/vscode
RUN python -m bash_kernel.install &&\ 
    curl -fsSL https://deno.land/install.sh | sh &&\
    ./.deno/bin/deno jupyter --install

EXPOSE 8080

CMD ["code-server"]
