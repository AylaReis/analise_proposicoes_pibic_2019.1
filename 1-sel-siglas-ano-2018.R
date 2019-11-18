### PROPOSIÇÕES SELECIONADAS POR ANO - 2018 ###


##### INSTALANDO OS PACOTES PARA WEBSCRAPING 

if(require(tidyverse) == F) install.packages('tidyverse'); require(tidyverse)
if(require(httr) == F) install.packages('httr'); require(httr)
if(require(XML) == F) install.packages('XML'); require(XML);
if(require(xml2) == F) install.packages('xml2'); require(xml2)


### MOSTRANDO AS SIGLAS QUE JA FORAM SELECIONADAS
siglas_sel

### TRANSFORMANDO EM LISTA POR ELEMENTO
siglas_sel_xml <- as.list(siglas_sel$tipoSigla)
siglas_sel_xml

cont_2018_xml <- list()

### PERCORRENDO OS DADOS 
for(i in 1:length(siglas_sel_xml)){
  link_lista_prop_2018 <- str_interp("https://www.camara.leg.br/SitCamaraWS/Proposicoes.asmx/ListarProposicoes?sigla=${siglas_sel_xml[[i]]}&numero=&datApresentacaoIni=&datApresentacaoFim=&idTipoAutor=&parteNomeAutor=&ano=2018&siglaPartidoAutor=&siglaUFAutor=&generoAutor=&codEstado=&codOrgaoEstado=&emTramitacao=")

   ## OBTER OS DADOS
  lista_prop_2018_xml <- GET(link_lista_prop_2018)
  
  ## PROCESSANDO OS DADOS OBTIDOS
  cont_2018_xml[[i]] <- xmlParse(lista_prop_2018_xml, encoding = "UTF-8")
 
}


### SALVANDO BASE DE DADOS DE PÁGINAS DAS SIGLAS SELECIONADAS - 2018
save("cont_2018_xml", file = "1-sel-siglas-ano-2018.RData")



