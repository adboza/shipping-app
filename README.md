# shipping-app
Projeto de app para fretes: Campus Code - TreinaDev Delas!

## Tabela de Conteúdos
  * [Organizando ideias](#organizando-ideias)
  * [Como rodar a aplicação](#como-rodar-a-aplicação)
  * [Informações adicionais](#informações-adicionais)
  * [Feedback do curso Treinadev](#feedback-do-curso-treinadev)

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


## Informações adicionais

* Usuário regular cadastrado: edna@sistemadefrete.com.br (senha: password)

* Usuário administrador cadastrado: admin@sistemadefrete.com.br (senha: password)

* Para todas categorias de distância, distância mínima é 100 m.

* Gems instaladas: bootstrap, capybara, devise, rspec

## Feedback do curso Treinadev
## e contextualização do projeto

### Este texto é uma carta à pessoa que acessará este projeto.

<p align = "justify">Primeiramente gostaria de agradecer a qualidade do conteúdo das aulas e do apoio recebido até o momento durante este curso. </p>
<p align = "justify">Como o feedback por parte da Campus Code será feito por escrito, considerei importante fornecer neste momento também um de minha parte, que será mantido neste arquivo até o início da segunda etapa deste treinamento.</p>
<p align = "justify">Este programa até agora trouxe para mim uma grande oportunidade de direcionamento de estudos e de carreira, sendo que além do aprendizado estou achando de grande valor o contato direto com as colegas de curso, instrutores e instrutoras que espero reencontrar na empresa onde irei atuar nos próximos anos.</p>
<p align = "justify">Esta aplicação foi desenvolvida para neste momento poder realizar de forma simplificada a maioria das tarefas apresentadas como requisitos do sistema, demonstrando o entendimento do conteúdo do curso em cada funcionalidade e na construção de forma incremental do sistema.</p>
<p align = "justify">Atualmente é possível realizar as seguintes tarefas nesta aplicação:</p>
<ul>
<li align = "justify"> Um usuário administrador é capaz de criar uma ordem de serviço, acessando o menu “Ordens de serviço” e a partir da mesma tela um usuário regular é capaz de visualizar ordens pendentes e inicializar a entrega por meio do botão “Iniciar ordem de entrega” com a visualização prévia das modalidades disponíveis para entrega e respectivos prazos e custos;</li>
<li align = "justify"> O veículo que fará a entrega é associado automaticamente pelo sistema, e tem seu status atualizado também de forma automática. Um usuário administrador pode por meio do menu “Veículos” cadastrar novos veículos, e alterar o status individual de disponibilidade do mesmo por meio da opção “Editar cadastro”. Um usuário regular consegue pesquisar por placa,visualizar a frota e o status individual de cada veículo;</li>
<li align = "justify"> A finalização as ordens de entrega pode ser feita por usuários regulares, acessando detalhes da ordem com código de rastreio com entrega finalizada, acessando “Editar ordem de entrega” e informando a data de recebimento. Caso a data de recebimento seja com atraso será exigido o preenchimento do campo “Justificativa de atraso”;</li>
<li align = "justify"> As modalidades de entrega podem ser cadastradas, e atualizadas por meio do menu “Modalidades de entrega” por usuário administrador. Novos preços por distância, prazo de entrega, categoria de peso e tipos de veículos para a modalidade podem ser cadastrados e editados pelo usuário administrador. A funcionalidade de desativação da modalidade pode ser acessada editando a modalidade;</li>
<li align = "justify"> Um usuário não logado na aplicação é capaz de pesquisar e visualizar o detalhamento completo do andamento do frete, pesquisando o código de rastreio da entrega;</li>
<li align = "justify"> Foi priorizada a integração das telas do sistema para disponibilizar uma <strong>aplicação funcional</strong> atendendo requisitos mínimos de sistema;</li>
<li align = "justify"> Todas funcionalidades foram desenvolvidas por TDD, sendo que estes testes assim como o sistema também estão evoluindo de forma incremental.</li>
</ul>
<p align = "center"> <strong>Muito obrigada por ler até aqui!</strong></p>