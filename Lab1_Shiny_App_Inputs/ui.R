#Autor: Lilian Rebeca Carrera Lemus
#Carnet: 20008077
#Curso: Product Development
#Laboratorio No.1

library(shiny)
library(lubridate) #para las fechas

shinyUI(fluidPage(
    titlePanel("Inputs en Shiny"),

    sidebarLayout(
        sidebarPanel(
            sliderInput("slider_input",
                        "Seleccione un valor:",
                        min = 0,
                        max = 100,
                        value = 50,
                        step = 10,
                        post = '%',
                        animate = TRUE
                        ),
            sliderInput("slider_input2",
                        "Seleccione un rango",
                        value = c(0,200),
                        min = 0,
                        max = 200,
                        step = 10
                        ),
            selectInput("select_input",
                        "Seleccione un auto:",
                        choices = rownames(mtcars),
                        selected = "Camaro Z28",
                        multiple = FALSE
                        ),
            selectizeInput("select_input2",
                           "Seleccione autos: ",
                           choices = rownames(mtcars),
                           selected = "Camaro Z28",
                           multiple = TRUE
                           ),
            dateInput("date_input",
                      "Ingrese la fecha: ",
                      value = today(),
                      min = today()-60,
                      max = today()+30,
                      format = 'dd/mm/yyyy',
                      language = 'es',
                      weekstart = 1
                      ),
            dateRangeInput("date_range",
                           "Ingrese Fechas: ",
                           start = today()-7,
                           end = today(),
                           format = 'dd/mm/yyyy', 
                           separator = 'a'
                           ),
            numericInput("numeric_input",
                         "Ingrese un numero: ",
                         value = 10,
                         min = 0,
                         max = 100,
                         step = 1
                         ),
            checkboxInput("single_box",
                          "Seleccione si verdadero: ",
                          value = FALSE
                          ),
            checkboxGroupInput("group_box",
                               "Seleccione opciones: ",
                               choices = LETTERS[1:5]
                               ),
            radioButtons('radio_button', 
                         'Seleccione genero: ', 
                         c('Masculino', 'Femenino'), 
                         selected = 'Masculino'
                         ), 
            textInput("text_input",
                      "Ingrese Texto: "
                      ),
            textAreaInput("text_area_input",
                          "Ingrese Parrafo: "
                          ),
            passwordInput("pass_input",
                          "Ingrese password: "
                          ),
            actionButton("action_button",
                         "Ok",
                         icon = icon('check-circle'), 
                         class = "btn-primary"
                         ),
            actionLink("action_link",
                       "Siguiente",
                       icon = icon("angle-double-right")
                       )
            
        ),

        mainPanel(
            h3("Slider Input sencillo"),
            verbatimTextOutput("slider_io"),
            h3("Slider Input Rango"),
            verbatimTextOutput("slider_io_2"),
            h3("Select Input"),
            verbatimTextOutput("select_io"),
            h3("Select Input Multiple"),
            verbatimTextOutput("select_io_multi"),
            h3("Fecha"),
            verbatimTextOutput("date_io"),
            h3("Rango de Fechas"),
            verbatimTextOutput("date_range_io"),
            h3("Numeric Input"),
            verbatimTextOutput("numeric_io"),
            h3("Single Checkbox"),
            verbatimTextOutput("single_box_io"),
            h3("Grouped Checkbox"),
            verbatimTextOutput("group_box_io"),
            h3("Radio Button"),
            verbatimTextOutput("radio_button_io"),
            h3("Texto"),
            verbatimTextOutput("text_io"),
            h3("Parrafo"),
            verbatimTextOutput("tex_area_io"),
            h3("Password Input"),
            verbatimTextOutput("pass_input_io"),
            h3("Action Button"),
            verbatimTextOutput("action_button_io"),
            h3("Action Link"),
            verbatimTextOutput("action_link_io")
        )
    )
))
