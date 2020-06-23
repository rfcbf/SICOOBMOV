# Desenvolvimento

Foi desenvolvido um app conforme solicitação abaixo pelo SICOOB.

Desenvolvido por: Renato Ferraz Castelo Branco Ferreira

email: rfcbf@me.com / renatoferrazdf@gmail.com

Tel: (61) 99368-4628

|  |  |
|--|--|
| <img src="https://github.com/rfcbf/SICOOBMOV/blob/master/Imagens/1.png" width="480" height="720" /> | <img src="https://github.com/rfcbf/SICOOBMOV/blob/master/Imagens/2.png" width="480" height="720" />
| <img src="https://github.com/rfcbf/SICOOBMOV/blob/master/Imagens/3.png" width="480" height="720" /> | <img src="https://github.com/rfcbf/SICOOBMOV/blob/master/Imagens/4.png" width="480" height="720" />
| <img src="https://github.com/rfcbf/SICOOBMOV/blob/master/Imagens/5.png" width="480" height="720" /> | <img src="https://github.com/rfcbf/SICOOBMOV/blob/master/Imagens/6.png" width="480" height="720" />
| <img src="https://github.com/rfcbf/SICOOBMOV/blob/master/Imagens/7.png" width="480" height="720" /> | <img src="https://github.com/rfcbf/SICOOBMOV/blob/master/Imagens/8.png" width="480" height="720" />
| <img src="https://github.com/rfcbf/SICOOBMOV/blob/master/Imagens/9.png" width="480" height="720" /> | <img src="https://github.com/rfcbf/SICOOBMOV/blob/master/Imagens/10.png" width="480" height="720" />

## Instalação e Pré-requistos

1) Maquina com MacOS

2) Xcode

3) Gerenciador de pagote (pod)

4) Baixar esse repositório

5) Descompactar o projeto

6) Abrir o Terminal -> acessar a pasta onde o projeto foi descompactado

7) Executar o comando: "pod install"

8) Executar o comando: "open SICOOBMov.xcworkspace"

9) Quando o projeto estiver aberto no Xcode, executar o app

  
## O que foi feito?
  * Exibir uma lista contendo filmes mais populares.  **OK**:
  * Cada filme apresentará uma imagem e o título do filme;  **OK**:
  * Ao clicar em um filme será exibida uma página com detalhes do filme;  **OK**:
    * Título  **OK**
    * Imagem  **OK**
    * Duração  **OK**
    * Gênero  **OK**:
    * Sinopse  **OK**:
    
### Pontos extras
  Não são obrigatórios, mas seria legal ter no seu projeto:

  * Animações 
  * Testes unitários
  * Testes automatizados
  * Utilização de *frameworks* de terceiros  **OK**:
  * Telas adequadas para diversos tamanhos  **OK**:
  * Utilização de banco de dados  **OK**:
  * Use sua imaginação para aprimorar a experiência do usuário  **OK**:

### Adicionais
  
  * Filtro da tela principal por nome filme;
  * Filtro da tela Favoritos por nome de filme, ano e genero;
  * Carregamento da tela de populares paginada. De 20 registro;
  * Check de conexão com a internet;
  * Adicionei na pagina de detalhe as produtoras.
  
## Bibliotecas usadas

* SwiftyJSON

* SDWebImage

* DeviceKit

* TagListView
  

------------


# Desafio Sicoob - iOS

## O que será avaliado?
Nesse desafio queremos avaliar sua habilidade em desenvolver um aplicativo e avaliar o seu conhecimento.

Inclua suas considerações das atividades em um arquivo de texto ou README dentro do projeto.

Vamos avaliar tudo que você fizer. Envie o que conseguir terminar, mesmo que você não consiga completar todas as tarefas do desafio.

## Tempo de desenvolvimento

7 dias

## Desafio

Nesse desafio, você irá criar um aplicativo que exiba os filmes mais populares usando uma API de Cinema:


### 1. Especificação

Para este desafio é necessário uma listagem para buscar os filmes e quando algum filme for selecionado, deverá exibir uma tela com detalhamento do filme selecionado.

* Exibir uma lista contendo filmes mais populares. Consulte [aqui](https://developers.themoviedb.org/3/movies/get-popular-movies) para obter mais informações;
* Cada filme apresentará uma imagem e o título do filme;
* Ao clicar em um [filme](https://developers.themoviedb.org/3/movies/get-movie-details), será exibida uma página com detalhes do filme;
  * Título
  * Imagem
  * Duração
  * Gênero
  * Sinopse
  
### Pontos extras
Não são obrigatórios, mas seria legal ter no seu projeto:

* Animações
* Testes unitários
* Testes automatizados
* Utilização de *frameworks* de terceiros
* Telas adequadas para diversos tamanhos
* Utilização de banco de dados
* Use sua imaginação para aprimorar a experiência do usuário

### API Utilizada

Utilizaremos a API do `themoviedb.org`
Como criar sua conta gratuita e utilizar a API

* Acesse https://www.themoviedb.org/account/signup para solicitar uma chave
  * Informe uso educacional
  * Você também terá que fornecer algumas informações pessoais para completar o pedido.
  * Você receberá a sua chave por e-mail
  
Para fazer requisições a API de filmes, você deve usar os endpoints abaixo:
`http://api.themoviedb.org/3/movie/popular?api_key=[SUA_CHAVE_DA_API]`

Estudando a API, você vai verificar que no detalhe do filme é fornecido um caminho relativo para a imagem. Por exemplo, o caminho de retorno do cartaz para Capitão Marvel é `/AtsgWhDnHTq68L0lLsUrCnM7TjG.jpg`.
 
A URL é formada por 3 partes :
1. A URL Base: http://image.tmdb.org/t/p/;
2. Então você vai precisar de um "tamanho", que será um dos seguintes procedimentos :
" w92 ", " W154 ", " w185 ", " w342 ", " w500 ", " w780 " , ou " original" . Para a maioria
dos telefones recomendamos a utilização de " w185 ";
3. E, finalmente, o caminho de Cartaz devolvido pela consulta, neste caso
/nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg Combinando as três partes temos:
http://image.tmdb.org/t/p/w185//AtsgWhDnHTq68L0lLsUrCnM7TjG.jpg

