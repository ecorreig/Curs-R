library(dplyr)
library(glue)
library(tibble)
library(ggplot2)
library(shiny)
library(gganimate)

options(warn = -1)

# Paràmetres de la distribució de rendes (Catalunya aprox.)
# Renda mediana ~25000€, mitjana ~30000€ (distribució log-normal)
meanlog <- log(25000)
sdlog <- 0.6

# Funció per generar la població
generate_population <- function(n = 100000) {
  tibble(
    income = rlnorm(n, meanlog = meanlog, sdlog = sdlog)
  )
}

# APLICACIÓ SHINY INTERACTIVA AMB ANIMACIÓ
ui <- fluidPage(
  titlePanel("Teorema Central del Límit - Distribució de Rendes"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("sample_size", "Mida de mostra:",
                  min = 1, max = 200, value = 30, step = 5),
      actionButton("start_animation", "Començar Simulació!", class = "btn-primary"),
      actionButton("stop_animation", "Parar", class = "btn-secondary"),
      br(), br(),
      textOutput("sample_counter")
    ),
    
    mainPanel(
      plotOutput("population_plot", height = "300px"),
      plotOutput("clt_plot", height = "300px")
    )
  )
)

server <- function(input, output, session) {
  
  sample_num <- 100
  refresh_rate <- 200  # ms
  
  # Filtrar la població per evitar outliers extrems
  population <- generate_population() |> 
    filter(income <= 1.5e05)  # Eliminar outliers extrems
  
  # Timer reactiu per l'animació
  timer <- reactiveTimer(refresh_rate)
  
  # Variables reactives per l'animació
  values <- reactiveValues(
    sample_means = numeric(0),
    current_sample = 0,
    is_animating = FALSE
  )
  
  # Començar animació
  observeEvent(input$start_animation, {
    values$sample_means <- numeric(0)
    values$current_sample <- 0
    values$is_animating <- TRUE
  })
  
  # Parar animació
  observeEvent(input$stop_animation, {
    values$is_animating <- FALSE
  })
  
  # Lògica d'animació amb timer
  observeEvent(timer(), {
    if (values$is_animating && values$current_sample < sample_num) {
      # Generar nova mostra i calcular mitjana
      new_sample <- sample(population$income, input$sample_size)
      new_mean <- mean(new_sample)
      
      values$sample_means <- c(values$sample_means, new_mean)
      values$current_sample <- values$current_sample + 1
      
      # Parar quan arribem a 100
      if (values$current_sample >= sample_num) {
        values$is_animating <- FALSE
      }
    }
  })
  
  output$sample_counter <- renderText({
    glue("Mostres generades: {values$current_sample} / {sample_num}")
  })
  
  output$population_plot <- renderPlot({
    population |>
      ggplot(aes(x = income)) +
      geom_histogram(bins = 100, fill = "lightblue", alpha = 0.7) +
      geom_vline(xintercept = mean(population$income), 
                 color = "red", size = 1, linetype = "dashed") +
      scale_x_continuous(limits = c(0, 1.5e05)) +
      labs(title = "Distribució de la Població (Log-normal)",
           x = "Renda anual", y = "Freqüència") +
      theme_minimal()
  })
  
  output$clt_plot <- renderPlot({
    
    y_limit <- ceiling(sample_num * 0.4 / sqrt(input$sample_size))
    
    if (length(values$sample_means) == 0) {
      # Gràfic buit al començament
      tibble(x = numeric(0), y = numeric(0)) |>
        ggplot(aes(x = x)) +
        geom_vline(xintercept = mean(population$income), 
                   color = "red", size = 1, linetype = "dashed") +
        scale_x_continuous(limits = c(0, 1.5e05)) +
        scale_y_continuous(limits = c(0, y_limit)) +
        labs(title = "Distribució de les Mitjanes Mostrals",
             x = "Mitjana de la mostra", y = "Freqüència") +
        theme_minimal()
    } else {
      tibble(sample_mean = na.omit(values$sample_means)) |>
        ggplot(aes(x = sample_mean)) +
        geom_histogram(bins = 100, fill = "lightgreen", alpha = 0.7) +
        geom_vline(xintercept = mean(population$income), 
                   color = "red", size = 1, linetype = "dashed") +
        scale_x_continuous(limits = c(0, 1.5e05)) +
        scale_y_continuous(limits = c(0, y_limit)) +
        labs(title = paste("Distribució de les Mitjanes Mostrals (n =", input$sample_size, ")"),
             x = "Mitjana de la mostra", y = "Freqüència") +
        theme_minimal()
    }
  })
}

# Per executar l'app:
shinyApp(ui, server)
