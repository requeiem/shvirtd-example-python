#!/bin/bash
echo 'Запускаю скрипт'
echo 'Изменяю директорию на /opt'
cd /opt || exit 1

echo 'Установка Docker'
sudo apt-get update || exit 1
sudo apt-get install ca-certificates curl -y || exit 1
sudo install -m 0755 -d /etc/apt/keyrings || exit 1
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc || exit 1
sudo chmod a+r /etc/apt/keyrings/docker.asc || exit 1
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null || exit 1
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y || exit 1
sudo docker run hello-world || exit 1

echo 'Копирую репозиторий со сборкой'
sudo git clone https://github.com/requeiem/shvirtd-example-python.git || exit 1

echo 'Переход в директорию проекта'
cd shvirtd-example-python || exit 1

echo 'Создаю и активирую виртуальное окружение'
sudo apt install python3.10-venv -y || exit 1
sudo apt install python3-pip -y || exit 1
sudo python3 -m venv venv || exit 1
source venv/bin/activate || exit 1
sudo docker compose build || exit 1
sudo docker compose up -d || exit 1
echo docker ps -a || exit 1
echo "Готово!"
