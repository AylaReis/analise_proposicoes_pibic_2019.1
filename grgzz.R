#### OBTENDO NUMERO E TEXTO EMENDA | E FILTRANDO ANO/ PROPOSIÇÕES ####
##### INSTALANDO OS PACOTES PARA WEBSCRAPING 

if(require(tidyverse) == F) install.packages('tidyverse'); require(tidyverse)
if(require(httr) == F) install.packages('httr'); require(httr)
if(require(XML) == F) install.packages('XML'); require(XML);
if(require(xml2) == F) install.packages('xml2'); require(xml2)

if(require(stringr) == F) install.packages('stringr'); require(stringr)

# TRANSFORMANDO BD DE SEL_SIGLAS EM LISTA DE SIGLAS
load("lista-siglas-cd-sel.RData")
lista_siglas_selecionadas <- siglas_sel[["tipoSigla"]]

#SALVANDO AS VARIÁVEIS EM VALOR VAZIO PARA DEPOIS USAR
ano <- NULL
sigla <- NULL  
numero <- NULL
txtEmenta <- NULL
linkInteiroTeor <- NULL

#PERCORRENDO OS DADOS
for(ano_prop in 1988:2018){
  for(sigla_selecionada in lista_siglas_selecionadas){
    ### DEFININDO ENDEREÇO DA WEB DINAMICO VARIANDO ANO E SIGLA
    link_lista_prop <- str_interp("https://www.camara.leg.br/SitCamaraWS/Proposicoes.asmx/ListarProposicoes?sigla=${sigla_selecionada}&numero=&datApresentacaoIni=&datApresentacaoFim=&idTipoAutor=&parteNomeAutor=&ano=${ano_prop}&siglaPartidoAutor=&siglaUFAutor=&generoAutor=&codEstado=&codOrgaoEstado=&emTramitacao=")

     ### OBTER OS DADOS  
    lista_prop_xml <- GET(link_lista_prop)
    
    ### PROCESSAR OS DADOS OBTIDOS
    cont_xml <- xmlParse(lista_prop_xml, encoding = "UTF-8")
    lista_conteudo_proposicoes <- xmlToList(cont_xml)
    
    if(!is.null(lista_conteudo_proposicoes$descricao)){
      if(lista_conteudo_proposicoes$descricao == "A Proposicao procurada nao existe"){
        next
      }
    }
   
    
    ### PEGA O PROXIMO INDICE VAZIO DEPOIS DA ULTIMA POSICAO OCUPADA DO VETOR
    fim <- length(ano)
    for(i in 1:length(lista_conteudo_proposicoes)){
      ano[fim+i] <- lista_conteudo_proposicoes[[i]]$ano
      sigla[fim+i] <- lista_conteudo_proposicoes[[i]]$tipoProposicao$sigla
      numero[fim+i] <- lista_conteudo_proposicoes[[i]]$numero
      txtEmenta[fim+i] <- lista_conteudo_proposicoes[[i]]$txtEmenta
      
      ### DEFINE ENDEREÇO WEB DA PROPOSICAO PARA COLETAR LINK INTEIRO TEOR
      link_prop <- str_interp("https://www.camara.leg.br/SitCamaraWS/Proposicoes.asmx/ObterProposicao?tipo=${sigla_selecionada}&numero=${numero[fim+i]}&ano=${ano_prop}")
      
      ### OBTEM A PAGINA DA PROPOSICAO
      conteudo_proposicao <- GET(link_prop)
      
      ### PROCESSAR OS DADOS OBTIDOS
      cont_xml <- xmlParse(conteudo_proposicao, encoding = "UTF-8")
      prop <- xmlToList(cont_xml)
    
      ### GRAVA O LINK INTEIRO TEOR ENCONTRADO NA PAGINA DA PROPOSICAO
      link_int_teo <- ""
      if(!is.null(prop$LinkInteiroTeor)){
        link_int_teo <- gsub("\r?\n|\r", "", prop$LinkInteiroTeor)
        link_int_teo <- gsub(" ", "", link_int_teo)
        
      }
      
      if(link_int_teo == ""){
        link_int_teo <- "Inexistente"
      }
      
      linkInteiroTeor[fim+i] <- link_int_teo
      
      
      status_message <- str_interp("Processando proposicao #${fim+i}, ano atual: ${ano_prop}, link: ${link_int_teo}")
      print(status_message)
    }
  }
}

tabela_proposicoes_links <- data.frame(ano, sigla, numero, txtEmenta, linkInteiroTeor)
head(tabela_proposicoes_links)



