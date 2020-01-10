apt-get update
apt-get install -y nginx
echo $(hostname) | sudo tee /var/www/html/index.html