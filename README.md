
# Projeto: ETL de Planilhas Excel e Construção de BI de Vendas com Apache Hop e PostgreSQL

## Objetivo

Este repositório contém o projeto **Live Xperium Hop**, que integra pipelines de dados, workflows e dashboards em Power BI. O projeto utiliza Apache Hop para realizar ETL, juntamente com PostgreSQL para armazenamento estruturado dos dados.

![Arquitetura do Projeto](media/arquitetura.png)

### Ferramentas Utilizadas
- **Apache Hop**:
  - Orquestração de pipelines ETL.
  - Automação de transformações e fluxos de dados.
- **PostgreSQL**:
  - Armazenamento e modelagem dos dados de vendas.
  - Criação de tabelas dimensionais e de fatos.
- **Power BI**:
  - Criação de dashboards e relatórios interativos de vendas.

### Fontes de Dados
- **Planilhas Excel**:
- Metas.xlsx: Contém dados relacionados a metas de vendas por vendedor e suas métricas.
- Produtos.xlsx: Contém informações detalhadas dos produtos, como nome, grupo, custo e etc.
- Vendas.xlsx: Dados sobre vendas realizadas, com campos esperados como Data da Venda, nf, cod produto, - Quantidade Vendida, Valor Unitário e etc.
- Vendedores.xlsx: Informações sobre vendedores, incluindo  nome e equipe de trabalho e url da imagem do vendendor.

---

## Arquitetura de Dados

### 1. **ETL**
- **Extração**:
  - Leitura de dados a partir de arquivos Excel.
- **Transformação**:
  - Limpeza e validação dos dados.
  - Conversão de formatos (e.g., datas e valores numéricos).
  - Cálculo de métricas, como o valor total das vendas (`Quantidade Vendida x Valor Unitário`).
- **Carga**:
  - Inserção dos dados processados no PostgreSQL em tabelas de dimensão e fato.

### 2. **Modelagem de Dados**

![Arquitetura do Projeto](media/modelagem.png)
- **Dimensões**:
  - `dproduto`: Detalhes sobre os produtos.
  - `dcliente`: Informações sobre os clientes.
  - `dCalendario`: Estruturação temporal para análise por períodos.
  
  **Nota**: A dimensão **`dCalendario`** foi criada utilizando fórmulas DAX diretamente no arquivo do Power BI, fornecendo uma estrutura temporal completa para análise por períodos específicos.
- **Fatos**:
  - `fvendas`: Registro consolidado das vendas com métricas calculadas.
  - `fmetas`: Registro consolidado das metas com métricas calculadas.

---

## Estrutura do Repositório

A estrutura do repositório é organizada da seguinte forma:

```plaintext
LIVE_XPERIUM_HOP/
│
├── datasets/              # Arquivos de dados utilizados pelos pipelines
├── metadata/              # Configurações e metadados para os pipelines
├── pipelines/             # Pipelines de ETL do Apache Hop
├── workflow/              # Workflows para orquestração dos processos
│
├── .gitignore             # Arquivos e diretórios ignorados pelo Git
├── dashboard_vendas.pbix  # Dashboard de vendas no Power BI
├── project-config.json    # Configuração do projeto no Apache Hop
└── README.md              # Documentação do projeto
```

---

## Pré-requisitos

Certifique-se de que os seguintes softwares estão instalados na sua máquina:

- [Apache Hop](https://hop.apache.org/)
- [PostgreSQL](https://www.postgresql.org/)
- [Power BI Desktop](https://powerbi.microsoft.com/)
- [Git](https://git-scm.com/)

---

## Configuração do Ambiente

### 1. Clone este repositório
```bash
git clone https://github.com/seu_usuario/seu_repositorio.git
cd LIVE_XPERIUM_HOP
```
### 2. Configure o PostgreSQL

1. **Instale o PostgreSQL**  
   - Baixe e instale o PostgreSQL em sua máquina seguindo as instruções disponíveis no site oficial: [PostgreSQL](https://www.postgresql.org/download/).

2. **Crie o banco de dados para o projeto**  
   - Após a instalação, acesse o terminal ou a interface gráfica do PostgreSQL (como o pgAdmin ou DBver) e crie um banco de dados para o projeto executando o comando SQL abaixo:  
   ```sql
   CREATE DATABASE DW;
   ```

3. **Configure as tabelas e conexões**  
   - Execute os scripts SQL fornecidos no arquivo `dw_vendas` para criar as tabelas e configurar o ambiente de dados.  
   - Utilize o **DBver** (ferramenta usada na aula) para conectar o PostgreSQL ao ambiente local e executar os scripts.  
     - Certifique-se de configurar a conexão no DBver com as seguintes informações:  
       - **Host**: `localhost`  
       - **Port**: 5430 (porta utilizada na aula).  
         - **Nota**: Se você instalou o PostgreSQL diretamente na sua máquina, provavelmente a porta padrão será 5432. Ajuste de acordo com sua instalação.  
       - **Database**: `DW`  
       - **Username**: Nome de usuário configurado durante a instalação (exemplo: `postgres`).  
       - **Password**: Senha definida durante a instalação.  

4. **Teste a conexão**  
   - No **DBver**, teste a conexão com o banco de dados para garantir que tudo esteja funcionando corretamente.  
   - Certifique-se de que as tabelas foram criadas conforme o script SQL executado.

### 3. Configure o Apache Hop

1. **Baixe e instale o Apache Hop**  
   - Acesse o site oficial do Apache Hop: [Apache Hop](https://hop.apache.org/).  
   - Faça o download da versão compatível com o sistema operacional de sua máquina.  
   - Extraia o conteúdo do arquivo e siga as instruções de instalação específicas para seu sistema operacional.

2. **Abra o Apache Hop e crie um projeto**  
   - No Apache Hop, acesse o menu principal e selecione **File > New > Project**, conforme especificado na aula.  
   - Dê um nome ao projeto e, na configuração do diretório, selecione a pasta que você clonou do repositório Git como o diretório principal do projeto.
s
3. **Crie as variáveis de conexão para o banco PostgreSQL**  
   - No Apache Hop, acesse **Manage > Connections** e clique em **New** para adicionar uma conexão ao banco de dados PostgreSQL.  
   - Preencha os campos com as informações da conexão:  
     - **Name**: Escolha um nome para identificar a conexão.  
     - **Database type**: PostgreSQL.  
     - **Host**: Endereço do servidor (use `localhost` para conexões locais).  
     - **Port**: Utilize a porta 5430, conforme especificado na aula.  
       - **Nota**: Caso você tenha instalado o PostgreSQL em sua máquina, a porta padrão é 5432. Ajuste o valor de acordo com sua instalação.  
     - **Database name**: DW.  
     - **Username**: Nome de usuário para autenticação.  
     - **Password**: Senha correspondente.  
   - Clique em **Test Connection** para validar a configuração.  
   - Salve a conexão.


---

## Executando os Pipelines

1. Inicie o Apache Hop e carregue os pipelines do diretório `pipelines`.
2. Configure as conexões com o banco de dados utilizando os arquivos em `metadata`.
3. Execute os workflows do diretório `workflow` para orquestrar os processos ETL.

---

## Dashboard em Power BI

O arquivo `dashboard_vendas.pbix` contém o dashboard de vendas. Para utilizá-lo:

1. **Abra o arquivo no Power BI Desktop**  
   - Certifique-se de que o Power BI Desktop esteja instalado e atualizado em sua máquina.

2. **Atualize as conexões de dados para o ambiente configurado**  
   - Configure as credenciais e os parâmetros para conectar ao banco de dados PostgreSQL utilizando as informações do ambiente criado.

3. **Publique o relatório no Power BI Service (se necessário)**  
   - Caso deseje compartilhar o dashboard, publique-o no Power BI Service e configure o agendamento de atualização, se necessário.

> **Nota**: Em alguns casos, pode ser necessário instalar o conector do PostgreSQL para que o Power BI consiga se conectar ao banco de dados. Consulte a [documentação oficial do Power BI](https://learn.microsoft.com/en-us/power-query/connectors/postgresql) para mais informações sobre como instalar e configurar o conector.


---

## Contribuição

Contribuições são bem-vindas! Para contribuir:

1. Faça um fork do projeto.
2. Crie uma branch para suas alterações (`git checkout -b feature/nova-feature`).
3. Envie suas alterações (`git push origin feature/nova-feature`).
4. Abra um Pull Request.

---

## Direitos de Uso

Este projeto tem como objetivo demonstrar um processo de ETL utilizando Apache Hop. O conteúdo deste repositório pode ser utilizado livremente, desde que o autor não seja responsabilizado por eventuais danos ou problemas decorrentes do uso.

Exigido | Permitido | Proibido
:---: | :---: | :---:
Aviso de licença e direitos autorais | Uso comercial | Responsabilidade Assegurada
 || Modificação ||	
 || Distribuição ||	
 || Sublicenciamento || 



---

## Contato

Dúvidas ou sugestões? Entre em contato:
- **Email**: alexdesousapereiraa@gmail.com
- **LinkedIn**: [Alex Pereira](https://www.linkedin.com/in/alex-pereira-analista-dados-sqldevelope-businessanalytics-datascience/)
