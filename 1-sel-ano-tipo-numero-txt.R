###OBTENDO NÚMERO E TEXTO DA EMENTA###
###2018- PL###

##### INSTALANDO OS PACOTES PARA WEBSCRAPING 

if(require(tidyverse) == F) install.packages('tidyverse'); require(tidyverse)
if(require(httr) == F) install.packages('httr'); require(httr)
if(require(XML) == F) install.packages('XML'); require(XML);
if(require(xml2) == F) install.packages('xml2'); require(xml2)

### DEFININDO ENDEREÇO DA WEB 
link_listar_proposicoes <- paste0("https://www.camara.leg.br/SitCamaraWS/Proposicoes.asmx/ListarProposicoes?sigla=pl&numero=&datApresentacaoIni=&datApresentacaoFim=&idTipoAutor=&parteNomeAutor=&ano=2018&siglaPartidoAutor=&siglaUFAutor=&generoAutor=&codEstado=&codOrgaoEstado=&emTramitacao=")

### OBTER OS DADOS
conteudo_proposicoes <- GET(link_listar_proposicoes)

### PROCESSAR OS DADOS OBTIDOS
tipoProposicao_xml <- xmlParse(conteudo_proposicoes, encoding = "UTF-8")
tipoProposicao_xml

lista_conteudo_proposicoes <- xmlToList(tipoProposicao_xml)
lista_conteudo_proposicoes

names(lista_conteudo_proposicoes$proposicao) #lista de variáveis

ano <- NULL
sigla <- NULL  
numero <- NULL
txtEmenta <- NULL

for(i in 1:length(lista_conteudo_proposicoes)){
  ano[i] <- lista_conteudo_proposicoes[[i]]$ano
  sigla[i] <- lista_conteudo_proposicoes[[i]]$tipoProposicao$sigla
  numero[i] <- lista_conteudo_proposicoes[[i]]$numero
  txtEmenta[i] <- lista_conteudo_proposicoes[[i]]$txtEmenta
}

ano
sigla
numero
txtEmenta
numero

bd2 <- data.frame(ano, sigla, numero, txtEmenta)
head(bd2)


