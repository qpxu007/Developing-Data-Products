
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Random DNA Sequence Generator"),
  

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      p('Please select length of the target DNA and base composition (A, T, C, G) using sliding bars below:'),
      sliderInput("len",
                  "Length of the DNA sequence:",
                  min = 1,
                  max = 1000,
                  value = 100),

      sliderInput("pcg",
                  "Percentage of CG bases:",
                  min = 0,
                  max = 100,
                  value = 50),
      sliderInput("c2g",
                  "Percentage of C in C/G:",
                  min = 0,
                  max = 100,
                  value = 50),
      sliderInput("a2t",
                  "Percentage of A in A/T:",
                  min = 0,
                  max = 100,
                  value = 50),
      
      checkboxInput("hideHis",
                  "Hide Distribution of Bases", FALSE),
      
      tags$img(src="DNA.png", width="40%"), h5("Further info @ ", a("Rpubs", href="http://rpubs.com/qpxu007/92787"))
    ),

    
    # Show a plot of the generated distribution
    mainPanel(
      h3("Inputs"),
      verbatimTextOutput("Inputs"),
      h3("DNA Sequence Generated"),
      verbatimTextOutput("Sequences"),
      h3("The Basic Melting Temperature (Tm)"),
      verbatimTextOutput("Tm"),
      #h3("Distribution of Bases"),
      plotOutput("hisPlot")
    )
  )
))
