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

Foi configurado o _Security Group_ com portas acima descritas abertas, conforme solicitado, para permitir acesso público. As portas relacionadas ao ping foram abertas apenas para fins de teste, não fazendo parte do escopo do projeto.

![_Security Group ports_](/pictures/Captura%20de%20tela%20de%202023-01-24%2023-32-08.png)

Depois de criada a instância, subimos o servidor Web Apache, com o seguinte script na área de _user data_:

~~~bash
#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd
~~~
A versão final do arquivo [_user_data.sh_](user_data.sh) conta com todas as implementações que foram necessárias para atender aos requisitos do projeto.


# Configuração no NFS
Conforme podemos verificar no [user_data.sh](/user_data.sh), adicionamos a linha 
~~~bash
sudo yum install amazon-nfs-utils
~~~
que já deveria vir instalado por padrão nas instâncias _Amazon Linux 2_ para trabalhar com _Network File System_.
Para anexar o _nfs_ rodamos o comando:
~~~bash
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport DNS_DO_EFS:/ /PONTO_DE_MONTAGEM
~~~
E por fim, foi criado o diretório dentro do nfs com o comando:
~~~bash
sudo mkdir /mnt/efs/lucasalves
~~~


----
# Verificando status do Apache
O status de funcionamento do Apache pode ser feito por meio do _shell script_ para buscar o código de status. Como requisito da atividade, o script irá buscar o status do Apache e salvar em arquivos de saída separados para serviço online e serviço offline. 

Para garantir a flexibilidade do script, foi adicionado a linha 
~~~bash
ip=$(hostname -I)
~~~
que basicamente busca o endereço IP local da máquina e armazena na variável _ip_.

Para capturar o codigo http do apache, tem-se o comando:
~~~bash
codigo_http=$(curl -s -o /dev/null -I -w "%{http_code}" $ip)
~~~
Onde o argumento `$ip` se refere a saída do comando `hostname -I`, que poderia ser trocado por um outro IP ou endereço web para ser verificado o status do apache rodando em outro _host_.
## Acompanhamento do Apache

Para termos um acompanhamento do status do serviço do servidor Apache, adicionamos a seguinte linha ao arquivo _/etc/crontab_ para que seja exacutado o _script_ [_verifica_apache.sh_](/verifica_apache.sh) a cada 5 minutos.

~~~bash
5 * * * * root verifica_apache.sh
~~~
