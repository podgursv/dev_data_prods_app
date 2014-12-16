library(shiny)

shinyServer(
  function(input, output) {
    nr <- reactive({ as.numeric(input$nr) })
    mu <- reactive({ as.numeric(input$mu) })
    sd <- reactive({ as.numeric(input$sd) })
    q <- reactive({ as.numeric(input$q) })

    ###  put this outside renderPlot, so that it's only re-executed when
    ###  one of the three params nr, mu, or sd changes;
    ###  don't re-generate data if only col or showMed change
    data <- reactive({ rnorm(nr(), mu(), sd()) })

    ###  the graph will be re-created every time one of the nr, mu, or sd changes,
    ###  but not when co, showMed or q change
    output$normGraph <- renderPlot({
      title <- paste("N(mu = ", mu(), ", s = ", sd(), ")")
      hist(x = data(), col = input$co, breaks = 80, main = title, xlab = "data", prob = TRUE)
      if (input$showCurve) lines(density(data()), col = "blue", lwd = 2)
      if (input$showMed) abline(v = median(data()), lwd = 3, col = "red")
      if (!is.na(q())) {
        output$z <- renderText({(q() - mu())/sd()})
        if (q() >= mu()) lt <- FALSE else lt <- TRUE
        output$pv <- renderText(pnorm(q = q(), mean = mu(), sd = sd(), lower.tail = lt))
        abline(v = q(), lwd = 5, col = "black")
      }
      else {
        output$z <- renderText("NA")
        output$pv <- renderText("NA")
      }
    })
  }
)