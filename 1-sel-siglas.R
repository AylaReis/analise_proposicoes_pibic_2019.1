##########################################
### SIGLAS SELECIONADAS DAS PROPOSIÇÕES###
##########################################

##### INSTALANDO OS PACOTES PARA FILTRAR #####
if(require(tidyverse) == F) install.packages('tidyverse'); require(tidyverse)

### SELECIONANDO ENDEREÇO
setwd("/Users/reis/Desktop/AYLA/UFPE/PIBIC, DAVI MOREIRA/banco_dados/analise_proposicoes_pibic_2019.1")
load("lista-siglas-cd.RData")

### SELECIONANDO SIGLAS
siglas_sel <- bd %>% filter(tipoSigla == "PEC"| tipoSigla == "PLC"| tipoSigla == "PLV"| tipoSigla =="PRC"|
                            tipoSigla =="PDS"| tipoSigla == "PL"| tipoSigla == "PLV"| tipoSigla =="PDC"|
                            tipoSigla =="REC"| tipoSigla == "RIC"| tipoSigla == "RCP"| tipoSigla == "MSC"| tipoSigla =="INC")

### SALVANDO BASE DE DADOS
save("siglas_sel", file = "lista-siglas-cd-sel.RData")
