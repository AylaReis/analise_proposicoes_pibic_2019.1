##########################################
#####TODAS AS SIGLAS DAS PROPOSIÇÕES######
##########################################

##### INSTALANDO OS PACOTES PARA WEBSCRAPING #####
if(require(tidyverse) == F) install.packages('tidyverse'); require(tidyverse)
if(require(httr) == F) install.packages('httr'); require(httr)
if(require(XML) == F) install.packages('XML'); require(XML);
if(require(xml2) == F) install.packages('xml2'); require(xml2)

### DEFININDO ENDEREÇO DA WEB 
link <- "https://www.camara.leg.br/SitCamaraWS/Proposicoes.asmx/ListarSiglasTipoProposicao"

### OBTER OS DADOS
conteudo <- GET(link) #obtem o codigo fonte

### PROCESSAR OS DADOS OBTIDOS
siglas_xml <- xmlParse(conteudo, encoding = "UTF-8")
siglas_xml

lista_siglas <- xmlToList(siglas_xml)
lista_siglas

names(lista_siglas$sigla)
names
tipoSigla <- NULL
descricao <- NULL

for (i in 1:length(lista_siglas)) {
  tipoSigla[i] <- trimws(lista_siglas[[i]]['tipoSigla'])
  descricao[i] <- trimws(lista_siglas[[i]]['descricao'])
}

bd <- data.frame(tipoSigla, descricao)
bd
### SALVANDO BASE DE DADOS
save("bd", file = "lista-siglas-cd.RData")
