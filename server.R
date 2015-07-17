
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

#   output$distPlot <- renderPlot({
# 
#     # generate bins based on input$bins from ui.R
#     x    <- faithful[, 2]
#     bins <- seq(min(x), max(x), length.out = input$bins + 1)
# 
#     # draw the histogram with the specified number of bins
#     hist(x, breaks = bins, col = 'darkgray', border = 'white')
# 
#   })

  output$Inputs <- renderText({
    len <- input$len
    pcg <- input$pcg
    c2g <- input$c2g
    a2t <- input$a2t
    pcg<-pcg/100
    c2g<-c2g/100
    a2t<-a2t/100
    
    pc=pcg*c2g
    pg=pcg*(1-c2g)
    
    pat=1-pcg
    pa=pat*a2t
    pt=pat*(1-a2t)
    
    paste("A: ", pa*100, " T: ", pt*100," C: ", pc*100," G: ", pg*100,"length= ", len)

  })
  
  dnavec <- reactive({
    len <- input$len
    pcg <- input$pcg
    c2g <- input$c2g
    a2t <- input$a2t
    dnavec<-dnaseq(len, pcg, c2g, a2t)
  })

  
  output$Sequences <- renderText ({
      # seq<-pprintDNA(dnavec(),60)
    seq<-printDNA(dnavec())
  })

  output$Tm <- renderText ({
    calTm(dnavec())
  })
  
#   ntext <- eventReactive(input$hideTm, {
#     calTm(dnavec())
#   })
#   output$Tm <- renderText ({
#     ntext()
#   })

  output$hisPlot <- renderPlot ({
    hideHis<-input$hideHis
    if( hideHis) {
    } else {
      plotDNA(dnavec())
    }
  })  

})





dnaseq<-function(n=100, pcg=50, c2g=50, a2t=50) {
  r<-runif(n)
  vec <- vector()
  
  #pcg, c2g and a2t are percentage  
  pcg<-pcg/100
  c2g<-c2g/100
  a2t<-a2t/100
  
  pc=pcg*c2g
  pg=pcg*(1-c2g)
  
  pat=1-pcg
  pa=pat*a2t
  pt=pat*(1-a2t)
  
  #   print(pcg)
  #   print(pa)
  #   print(pt)
  #   print(pc)
  #   print(pg)
  
  for (i in 1:n) {
    if (r[i] <= pa) {
      vec[i]="A"
    } else if (r[i] <= pa+pt & r[i] > pa) {
      vec[i]="T"
    } else if (r[i] <= pa+pt+pc & r[i] > pa+pt) {
      vec[i]="C"
    } else {
      vec[i]="G"
    }
    
  }
  vec
  #dnaseq=paste(vec, collapse = "")
}


printDNA<-function(vec) {
  dna<-paste(vec, collapse = "")
  dna
}

pprintDNA<-function(vec, width=60) {
  dna<-paste(vec, collapse = "")
  starts<-seq(1,nchar(dna),width)

  dnax<-sapply(starts, function(x) { substr(dna, x, x+width)})
  dnap<-paste(dnax, collapse = "\n")
  cat(dnap)
  dnap
}

plotDNA<-function(vec) {
  barplot(table(vec), main = "Distribution of Bases", col='red', ylab="Number of Bases")
}


calTm<-function(vec) {
  # calculate basic melting temperature for a dna sequence (in str vector)
  len<-length(vec)
  tbl<-table(vec)
  a<-tbl['A']
  t<-tbl['T']
  c<-tbl['C']
  g<-tbl['G']
  
  if (is.na(a)) {
    a=0
  }
  if (is.na(c)) {
    c=0
  }
  if (is.na(t)) {
    t=0
  }
  if (is.na(g)) {
    g=0
  }
  
  if (len < 14) {
    Tm=(a+t)*2+(c+g)*4
  } else {
    Tm=64.9 +41*(g+c-16.4)/(a+t+c+g)
  }
  Tm
}


#dna=dnaseq(1000)
#printDNA(dna)
#calTm(dna)
#plotDNA(dna)