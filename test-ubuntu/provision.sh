apt-get update
apt-get install -y nginx
apt-get install -y git

echo "
server {
    listen 80;
    location / {
        proxy_pass http://localhost:5123;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection keep-alive;
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
" > /etc/nginx/sites-available/default 
echo '#############'
echo '/etc/nginx/sites-available/default:'
cat /etc/nginx/sites-available/default 

service nginx start

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-trusty-prod trusty main" > /etc/apt/sources.list.d/dotnetdev.list'

sudo apt-get install -y dotnet-sdk-2.0.0

echo 'cd /home/vagrant' > run.sh
echo 'rm -rf pdf-support' >> run.sh
echo 'git clone https://github.com/AntonyBaasan/pdf-support' >> run.sh
echo 'dotnet build pdf-support/pdf-merge-server/' >> run.sh
echo 'dotnet run --project pdf-support/pdf-merge-server/webapi/webapi.csproj' >> run.sh

echo '#############'
echo 'run.sh content:'
cat run.sh