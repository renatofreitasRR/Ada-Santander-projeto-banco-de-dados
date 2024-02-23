# Projeto Banco de Dados
## ADA Tech - Santander

#### Tecnologias Utilizadas:
* Python
* Pandas
* MatPlotLib
* SQLAlchemy
* PostgreSQL

Este projeto, parte integrante do módulo de banco de dados do curso de engenharia de dados, tem como propósito a criação de um sistema abrangente de gerenciamento e análise de dados. 

Os principais elementos do projeto englobam:

* Manipulação de Tabelas e Tratamento de Dados: Implementação de técnicas avançadas de manipulação de tabelas para garantir a qualidade e integridade dos dados armazenados. Isso inclui a normalização de dados, tratamento de valores ausentes e gestão eficaz de chaves estrangeiras.

* Importação de Arquivo CSV para o Banco de Dados: Desenvolvimento de um módulo de importação que permite aos usuários carregar dados a partir de arquivos CSV para o banco de dados. Essa funcionalidade simplificará a entrada de grandes conjuntos de dados, proporcionando uma forma eficiente de integrar novas informações ao sistema.

* Análise Estatística com SQL, Pandas e Matplotlib: Integração de análise estatística no sistema utilizando SQL para consultas complexas diretamente no banco de dados. Além disso, a incorporação de Pandas permitirá a manipulação eficiente de dados dentro do ambiente Python, enquanto o Matplotlib será empregado para criar visualizações gráficas claras e informativas.

## Como utilizar

O projeto consiste em 4 arquivos bases:

| Ordem de Execução | Arquivo                                                          | Descrição          |
| ----------------- | ---------------------------------------------------------------- | ------------------ |
| 1º                | 1_step_format_values.ipynb                                       |  Arquivo para tratar os dados do csv, gerando um novo csv com os dados tratados                  |
| 2º     | 2_step_create_table_and_import_data_scripts.sql |  Arquivo para criação da tabela e importação do csv tratado             |
| 3º    | 3_step_analytics_queries_and_create_views.sql | Arquivo para criação de consultas e views analíticas dos dados                   |
| 4º      | 4_step_data_analytic_with_python.ipynb |  Arquivo de manipulação das views criadas anteriormente para maior extração de insights e visualização em gráficos             |