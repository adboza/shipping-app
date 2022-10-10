# shipping-app
Projeto de app para fretes: Campus Code - TreinaDev Delas!

## Organizando ideias
Backlog do projeto disponível em [Trello](https://trello.com/b/7cgxsT6M/sistema-de-fretes-campus-code-treinadev).

Com a ferramenta online [diagrams.net](https://drive.google.com/file/d/1Etn_Av0fvzO2wcpDEzS7zcoEasQRCqEm/view?usp=sharing) está sendo elaborado um fluxograma para direcionamento de criação de classes do projeto.

**Este projeto é uma realização [Campus Code](https://www.campuscode.com.br/)!**

## Como rodar a aplicação

<p align = "justify"> No terminal, clone o projeto: </p>

```
$ git clone git@github.com:adboza/shipping-app.git
```

<p align = "justify"> Entre na pasta do projeto: </p>

```
$ cd shipping-app
```

<p align = "justify"> Instale as dependencias: </p>

```
$ bin/setup
```

<p align = "justify"> Popule a aplicação: </p>

```
$ rails db:seed
```

<p align = "justify"> Visualize no navegador: </p>

```
$ rails s
```

* Acesse http://localhost:3000/

## Como rodar os testes

```
$ rspec
```

## Informações adicionais

* Usuário regular cadastrado: edna@sistemadefrete.com.br (senha: password)

* Usuário administrador cadastrado: admin@sistemadefrete.com.br (senha: password)

* Para todas categorias de distância, distância mínima é 100 m.

* Gems instaladas: bootstrap, capybara, devise, rspec