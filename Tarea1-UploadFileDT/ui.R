library(shiny)
library(DT)

shinyUI(fluidPage(

    titlePanel("Cargar Archivos y DataFrames"),
    tabsetPanel(tabPanel("Cargar Archivo",
                         sidebarLayout(
                             sidebarPanel(
                                 h2("Subir Archivo"),
                                 fileInput("upload_file_1",
                                           label = "Seleccione un archivo",
                                           buttonLabel="Cargar")
                                 ),
                              mainPanel(
                                 tableOutput("contenido_archivo_1")
                                  )
                           )
                        ),
                tabPanel("Cargar Archivo DT",
                         sidebarLayout(
                             sidebarPanel(
                                 h2("Subir Archivo"),
                                 fileInput("upload_file_2",
                                           label = "Seleccione un archivo",
                                           buttonLabel="Cargar",
                                           accept = c(".csv", ".tsv"))
                             ),
                             mainPanel(
                                 dataTableOutput("contenido_archivo_2")
                             )
                           )
                        ),
                tabPanel("DT Option",
                         h2("Formato Columna"),
                         hr(),
                         fluidRow(column(width=12, 
                                         dataTableOutput("tabla1")
                                         )
                                  ),
                         h2("Opciones"),
                         hr(),
                         fluidRow(column(width=12,
                                         dataTableOutput("Tabla2")
                                        )
                                  ),
                         h2("Boton Guardar CSV"),
                         hr(),
                         fluidRow(column(width=12,
                                         dataTableOutput("Tabla3")
                                         )
                                  )
                         ),
                tabPanel("Clicks en tabla",
                         fluidRow(column(width=12,
                                         h2("Click en una fila"),
                                         dataTableOutput("tabla4"),
                                         verbatimTextOutput("tabla4_single_click")
                                         )
                                  ),
                         fluidRow(column(width=12,
                                         h2("Click en multiples fila"),
                                         dataTableOutput("tabla5"),
                                         verbatimTextOutput("tabla5_multi_click")
                                        )
                                    ),
                         fluidRow(column(width=12,
                                         h2("Click en una columna"),
                                         dataTableOutput("tabla6"),
                                         verbatimTextOutput("tabla6_single_click")
                                        )
                                    ),
                         fluidRow(column(width=12,
                                         h2("Click en multiples columnas"),
                                         dataTableOutput("tabla7"),
                                         verbatimTextOutput("tabla7_multi_click")
                                        )
                                    ),
                         fluidRow(column(width=12,
                                         h2("Click en una celda"),
                                         dataTableOutput("tabla8"),
                                         verbatimTextOutput("tabla8_single_click")
                                        )
                                    ),
                         fluidRow(column(width=12,
                                         h2("Click en multiples celdas"),
                                         dataTableOutput("tabla9"),
                                         verbatimTextOutput("tabla9_multi_click")
                                         )
                                    )
                         )
                )


))
