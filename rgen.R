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

plotDNA<-function(vec) {
  barplot(table(vec))
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
