shinyUI(
  fluidPage(
    titlePanel("Normal Distribution"),
    sidebarLayout(
      sidebarPanel(
        sliderInput("nr", "Sample Size", value = 300, min = 300, max = 900, step = 50),
        textInput(inputId = "mu", label = "Mean", value = 0),
        textInput(inputId = "sd", label = "Std Dev", value = 1),
        p("-----------------"),

        selectInput(inputId = "co", "Color",
                    choices = c("lightblue", "lightgreen", "salmon", "yellow"),
                    selected = "lightblue"),
        checkboxInput(inputId = "showMed", "Show Median", value = FALSE),
        checkboxInput(inputId = "showCurve", "Show Density Curve", value = FALSE),
        p("-----------------"),

        textInput(inputId = "q", label = "Quantile", value = 0),
        p("Z-Score:"), textOutput("z"),
        p("One Tail p-Value:"), textOutput("pv")
      ),
      mainPanel(
        plotOutput("normGraph"),
        h4("Usage"),
        p("Define the normal distribution by selecting values for mean and standard deviation, as well as the sample size."),
        p("Optionally, adjust the graphic looks by selecting the color, as well as turning on/off the visibility of the density curve and/or median."),
        p("Optionally, input quantile values, and obtain the corresponding Z-score and one-tail p-values.")
      )
    )
  )
)