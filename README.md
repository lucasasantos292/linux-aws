<h1 align="Center">
Linux e AWS
</h1>

# Sobre o projeto

O projeto abaixo descrito foi feito com o intuito de realizar as práticas necessárias para fixar os conhecimentos sobre Linux e Amazon Web Services (AWS) como requisitos de atividade no Programa de Bolsas da [Compass UOL](https://compass.uol.en/home).

# Passos Iniciais
## Criação da instância ec2 na AWS


```bash
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
EC2ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
echo '<center><h1>Este Webserver esta LIVE: EC2ID </h1></center>' > /var/www/html/index.txt
sed "s/EC2ID/$EC2ID/" /var/www/html/index.txt > /var/www/html/index.html
```
