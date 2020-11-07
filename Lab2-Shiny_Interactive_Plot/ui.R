library(shiny)
library(DT)

shinyUI(fluidPage(

    titlePanel("Laboratorio2 Shiny Plots"),
    
    tabsetPanel(
        tabPanel('Grafico',
                 h2("Grafico Interactivo"),
                 plotOutput('plot_mtcars',
                            click = 'click_plot',
                            dblclick = 'dblcilck_plot',
                            hover = 'hover_plot',
                            brush = 'brush_plot'
                 ),
                 DT::dataTableOutput('dt_mtcars')
        )
    )

))
