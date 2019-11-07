
for(ano in 1988:2018){
  for(sigla in lista_siglas){
    comb <- str_interp("Ano: ${ano} | Sigla: ${sigla}")
    print(comb)
    
    <- get(comb)
    for(num in numero){
      link_item <- str_interp("https://www.camara.leg.br/SitCamaraWS/Proposicoes.asmx/ObterProposicao?tipo=${sigla}&numero=${i}&ano=${ano}")
      
      conteudo_proposicao <- GET(link_item)
      
      cont_xml <- xmlParse(conteudo_proposicao, encoding = "UTF-8")
      prop <- xmlToList(cont_xml)
      
      print(prop$LinkInteiroTeor)
    }
  }
}

