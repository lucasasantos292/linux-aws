<h1 align="Center">
Linux e AWS
</h1>

# Sobre o projeto

O projeto abaixo descrito foi feito com o intuito de realizar as práticas necessárias para fixar os conhecimentos sobre Linux e [Amazon Web Services(AWS)](https://aws.amazon.com/pt) como requisitos de atividade no Programa de Bolsas da [Compass UOL](https://compass.uol.en/home).

# Passos Iniciais
## Criação da instância ec2 na AWS
Inicialmente foi criada uma instância EC2 na Amazon web Services obedecendo os seguintes requisitos: 
- Família t3.small 
- 16GB de memória SSD
- Elastic IP associado
- Chave Pública para acesso ao ambiente
- Portas de comunicação para acesso
público: (22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80
/TCP, 443/TCP).

Depois de criada a instância, subimos o servidor Web Apache, com o seguinte script na área de _user data_:

```bash
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
```
A versão final do arquivo [_user_data.sh_](user_data.sh) conta com todas as implementações que foram necessárias para atender aos requisitos do projeto.