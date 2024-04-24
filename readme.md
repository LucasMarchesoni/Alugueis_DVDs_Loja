# Locadora - Aluguéis de DVDs

![Logo](/assets/dvd.png)

O projeto consiste na análise de aluguéis de uma locadora.

Para realizar o projeto respondendo as perguntas de negócio, utilizei o SQL para tratamento dos dados e para fazer a análise exploratória e Power BI para visualização e interação com os dados existentes. Além da apresentação feita no Power Point.

## Sobre os dados

A análise foi realizada utilizando a base de dados de uma locadora, os dados foram retirados do site https://www.postgresqltutorial.com.

## Diagrama de relacionamento da base

![DER](/assets/der.png)

## Apresentação

Para a apresentação, possuí duas opções:

### Dashboard:

No dashboard, pode-se conferir quais os indicadores existem para um melhor entendimento e existe a possibilidade de aplicar filtros para diferentes visões.

![Dashboard_Overview](/assets/dashboard_overview.png)

![Dashboard_Lista](/assets/dashboard_lista.png)

**[Clique para ver o dashboard](https://app.powerbi.com/view?r=eyJrIjoiNmFmYzM1MTEtYTU5MC00MGRjLThkNzEtYmY0NTc3ZTBmZDNhIiwidCI6ImE5NjgwMmM4LTA0OTAtNDI3NC1iZDVmLTA5NzIxYWQzOWRjNiJ9)**

### Apresentação em PDF:

Dentro dessa apresentação, é possível extrair insights sobre os principais indicadores da locadora como total de faturamento, total de aluguéis, cliente com mais aluguéis, país e cidades com mais aluguéis, etc.

## Ferramentas

Utilizei as seguintes ferramentas:

- **SQL**: Foi utilizado para realizar a análise exploratória dos dados e tratamento da base original.
- **Power BI**: Foi utilizado para construção do dashboard.
- **PowerPoint**: Foi utilizado para montagem da apresentação.

## Perguntas respondidas

1. **Desempenho de Aluguel:**

   - Qual é o filme mais alugado do último mês?
     - Lust Lock
   - Quais são os cinco filmes menos alugados deste ano?
     - Falcom Volume
     - Forrester Comancheros
     - Drifter Commandments
     - Swarm Gold
     - Seabiscuit Punk
   - Qual a média de dias que um filme permanece alugado?
     - 4,53 dias

2. **Segmentação de Clientes:**

   - Quais são os clientes mais frequentes?
     - Eleanor Hunt
   - Quais cidades tem mais residentes dos nossos clientes?
     - Buenos Aires
   - Quais são os principais tipos de filmes alugados por diferentes grupos demográficos?
     - São Paulo e Documentary/Buenos Aires e Sports

3. **Gestão de Estoque:**

   - Quais filmes estão a mais tempo no estoque?
     - Stallion Sundance

4. **Desempenho da Loja:**

   - Qual loja com mais vendas?
     - Loja 1 possui 8040 vendas.
   - Quais cidades possuem loja?
     - Lethbridge e Woodridge
   - Qual o faturamento de cada loja indicando o valor e a cidade da loja?
     - Lethbridge: R$ 30252,12
     - Woodridge: R$ 31059,92

5. **Análise de Localização:**

   - Qual cidade possui mais clientes?
     - Londres
   - Qual país possui mais clientes?
     - Índia
   - Qual o faturamento por cidade?
     - Saint-Denis: R$ 211.55
     - Cape Coral: R$ 208.58
     - Santa Brbara dOeste: R$ 194.61
     - Apeldoorn: R$ 191.62
     - Molodetno: R$ 189.60
   - Qual o faturamento por país?
     - India: R$ 6034.78
     - China: R$ 5251.03
     - United States: R$ 3685.31
     - Japan: R$ 3122.51
     - Mexico: R$ 2984.82

6. **Eficiência do Staff:**

   - Quais funcionários fizeram mais vendas por cada loja?
     - store | full_name | total_rental
     - 1 | Mike Hillyer | 8040
     - 2 | Jon Stephens | 8004
   - Qual o total de dinheiro cada funcionário vendeu por cada loja?
     - store | full_name | total_amount
     - 2 | Jon Stephens | 7304
     - 1 | Mike Hillyer | 7292

7. **Tendências de Gênero:**

   - Quais são os gêneros mais populares em diferentes países?
     Algumas respostas:
     - Afghanistan: Comedy
     - Algeria: SciFi
     - American Samoa: Sports
     - Angola: Animation
     - Anguilla: Travel

8. **Análise dos filmes:**

   - Quais atores estavam mais presentes nos filmes?
     - Susan Davis, Gina Degeneres, Walter Torn, Mary Keitel.
   - Quais as restrições dos filmes?
     - NC-17, R, G NC-13.
   - Qual o filme mais longo?
     - Muscle Bright

9. **Análise Financeira:**
   - Qual é o filme mais lucrativo?
     - Telegraph Voyage.
   - Qual é a média de receita por aluguel?
     - R$ 4,20
   - Quais clientes fizeram mais compras e qual foi o valor gasto?
     - Eleanor Hunt, 45 compras e total de R$ 211,55
