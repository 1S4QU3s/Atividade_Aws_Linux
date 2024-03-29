# Projeto_DevSecOps_Compass
Atividade Aws e Linux

Repositorio para a atividade de Linux

Descrição : Criar um ambiente AWS com uma instância EC2 e configurar o NFS para armazenar dados.

A atividade inclui a geração de uma chave pública de acesso, criação de uma instância EC2 com o sistema operacional Amazon Linux 2, geração de um endereço IP elástico e anexá-lo à instância EC2, liberação de portas de comunicação para acesso público, configuração do NFS, criação de um diretório com o nome do usuário no filesystem do NFS, instalação e configuração do Apache, criação de um script para validar se o serviço está online e enviar o resultado para o diretório NFS, e configuração da execução automatizada do script a cada 5 minutos.

# Requisitos

# Instancia EC2 AWS:
- Chave pública para acesso ao ambiente
- Amazon Linux 2
    - t3.small
    - 16 GB SSD
- 1 Elastic IP associado a instancia
- Portas de comunicação liberadas
    - 22/TCP (SSH)
    - 111/TCP e UDP (RPC)
    - 2049/TCP/UDP (NFS)
    - 80/TCP (HTTP)
    - 443/TCP (HTTPS)

#Configurações Linux:

- Configurar o NFS entregue;
- Criar um diretorio dentro do filesystem do NFS com seu nome;
- Subir um apache no servidor - o apache deve estar online e rodando;
- Criar um script que valide se o serviço esta online e envie o resultado da validação para o seu diretorio no nfs;
    - O script deve conter - Data HORA + nome do serviço + Status + mensagem personalizada de ONLINE ou offline;
    - O script deve gerar 2 arquivos de saida: 1 para o serviço online e 1 para o serviço OFFLINE;
    - Execução automatizada do script a cada 5 minutos.


# Instruções de Execução

# Gerar uma chave pública de acesso na AWS e anexá-la à uma nova instância EC2.
- Acessar a AWS na pagina do serviço EC2, e clicar em "Pares de chaves" no menu lateral esquerdo.
- Clicar em "Criar par de chaves".
- Inserir um nome para a chave e clicar em "Criar par de chaves".
- Salvar o arquivo .pem gerado em um local seguro.
- Clicar em "Instâncias" no menu lateral esquerdo.
- Clicar em "Executar instâncias".
- Configurar as Tags da instância (Name, Project e CostCenter) para instâncias e volumes.
- Selecionar a imagem Amazon Linux 2 AMI (HVM), SSD Volume Type.
- Selecionar o tipo de instância t3.small.
- Selecionar a chave gerada anteriormente.
- Colocar 16 GB de armazenamento gp2 (SSD).
- Clicar em "Executar instância".


# Alocar um endereço IP elástico à instância EC2.

- Acessar a AWS na pagina do serviço EC2, e clicar em "IPs elásticos" no menu lateral esquerdo.
- Clicar em "Alocar endereço IP elástico".
- Selecionar o ip alocado e clicar em "Ações" > "Associar endereço IP elástico".
- Selecionar a instância EC2 criada anteriormente e clicar em "Associar".

# Configurar gateway de internet.

- Acessar a AWS na pagina do serviço VPC, e clicar em "Gateways de internet" no menu lateral esquerdo.
- Clicar em "Criar gateway de internet".
- Definir um nome para o gateway e clicar em "Criar gateway de internet".
- Selecionar o gateway criado e clicar em "Ações" > "Associar à VPC".
- Selecionar a VPC da instância EC2 criada anteriormente e clicar em "Associar".

### Configurar rota de internet.

- Acessar a AWS na pagina do serviço VPC, e clicar em "Tabelas de rotas" no menu lateral esquerdo.
- Selecionar a tabela de rotas da VPC da instância EC2 criada anteriormente.
- Clicar em "Ações" > "Editar rotas".
- Clicar em "Adicionar rota".
- Configurar da seguinte forma:
    - Destino: 0.0.0.0/0
    - Alvo: Selecionar o gateway de internet criado anteriormente
- Clicar em "Salvar alterações".

# Configurar regras de segurança.
- Acessar a AWS na pagina do serviço EC2, e clicar em "Segurança" > "Grupos de segurança" no menu lateral esquerdo.
- Selecionar o grupo de segurança da instância EC2 criada anteriormente.
- Clicar em "Editar regras de entrada".
- Configurar as seguintes regras:
    Tipo | Protocolo | Intervalo de portas | Origem | Descrição
    ---|---|---|---|--
    SSH | TCP | 22 | 0.0.0.0/0 | SSH
    TCP personalizado | TCP | 80 | 0.0.0.0/0 | HTTP
    TCP personalizado | TCP | 443 | 0.0.0.0/0 | HTTPS
    TCP personalizado | TCP | 111 | 0.0.0.0/0 | RPC
    UDP personalizado | UDP | 111 | 0.0.0.0/0 | RPC
    TCP personalizado | TCP | 2049 | 0.0.0.0/0 | NFS
    UDP personalizado | UDP | 2049 | 0.0.0.0/0 | NFS

# Configurar o NFS com o IP fornecido

- Criar um novo diretório para o NFS usando o comando `sudo mkdir /mnt/nfs`.
- Montar o NFS no diretório criado usando o comando `sudo mount IP_OU_DNS_DO_NFS:/ /mnt/nfs`.
- Verificar se o NFS foi montado usando o comando `df -h`.
- Configurar o NFS para montar automaticamente no boot usando o comando `sudo nano /etc/fstab`.
- Adicionar a seguinte linha no arquivo `/etc/fstab`:
    ```
    IP_OU_DNS_DO_NFS:/ /mnt/nfs nfs defaults 0 0
    ```
- Salvar o arquivo `/etc/fstab`.
- Criar um novo diretório para o usuário isaque usando o comando `sudo mkdir /mnt/nfs/isaque`.
-  Após configurar executar o comando " sudo service nfs status" para verificar de obteve êxito:

![image](https://github.com/1S4QU3s/Atividade_Aws_Linux/assets/159395767/94d044da-a34c-4810-85c4-f88f67d3ffc3)

  ### Configurar o Apache.

- Executar o comando `sudo yum update -y` para atualizar o sistema.
- Executar o comando `sudo yum install httpd -y` para instalar o apache.
- Executar o comando `sudo systemctl start httpd` para iniciar o apache.
- Executar o comando `sudo systemctl enable httpd` para habilitar o apache para iniciar automaticamente.
- Executar o comando `sudo systemctl status httpd` para verificar o status do apache.
- Configurações adicionais do apache podem ser feitas no arquivo `/etc/httpd/conf/httpd.conf`.
- para parar o apache, executar o comando `sudo systemctl stop httpd`.

![image](https://github.com/1S4QU3s/Atividade_Aws_Linux/assets/159395767/efd71bab-06fc-40e3-b9bb-f467cedf39b3)



### Configurar o script de validação.

- Crie um novo arquivo de script usando o comando "nano validScript.sh".
- Adicione as seguintes linhas de código no arquivo de script:
    ```bash
    #!/bin/bash
    # Script que verifica o status do serviço httpd e salva o resultado em um arquivo no diretório /mnt/nfs/isaque
    
    DATA=$(date +%d/%m/%Y)
    HORA=$(date +%H:%M:%S)
    SERVICO="httpd"
    STATUS=$(systemctl is-active $SERVICO)
   
    if [ $STATUS == "active" ]; then
        MENSAGEM="O $SERVICO está ONLINE"
        echo "$DATA $HORA - $SERVICO - active - $MENSAGEM" >> /mnt/nfs/isaque/online.txt
    else
        MENSAGEM="O $SERVICO está offline"
        echo "$DATA $HORA - $SERVICO - inactive - $MENSAGEM" >> /mnt/nfs/isaque/offline.txt
    fi
    ```
- Salve o arquivo de script.
- Execute o comando `chmod +x validScript.sh` para tornar o arquivo de script executável.
- Execute o comando `./validScript.sh` para executar o script.

#Configurar a execução do script de validação a cada 5 minutos usando o crontab 
   *Configurar o cronjob.
    - Execute o comando `crontab -e` para editar o cronjob.
    - Adicione a seguinte linha de código no arquivo de cronjob:
    ```bash
    */5 * * * * /home/ec2-user/validScript.sh
    ```
- Salve o arquivo de cronjob.
- Execute o comando `crontab -l` para verificar se o cronjob foi configurado corretamente.

- Agora navegue até o diretório onde estão as 2 saidas do script e execute "cat" nos dois arquivos:
  
  ![image](https://github.com/1S4QU3s/Atividade_Aws_Linux/assets/159395767/7db44afe-3de8-49c1-ba81-071f60f8cca9)

- o resultado vai ser listado abaixo:

  ![image](https://github.com/1S4QU3s/Atividade_Aws_Linux/assets/159395767/f40c5f4c-9f38-4494-b045-7e2a839725cd)



