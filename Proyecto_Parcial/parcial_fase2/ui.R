#Curso: Product Development
#Integrantes:
#	Lilian Rebeca Carrera Lemus
#	Jose Armando Barrios Leon
#Tarea: Proyecto Parcial Fase2


if (!require("shinythemes")) install.packages("shinythemes")
if (!require("dashboardthemes")) install.packages("dashboardthemes")

library(shiny)
library(shinydashboard)
library(shinythemes)
library(dashboardthemes)
library(DT)


shinyUI(
    dashboardPage(
        dashboardHeader(
            title = "Presupuesto Gobierno Central Guatemala 2020",
            titleWidth = 2000
        ),
        dashboardSidebar(disable = T),
        dashboardBody(
            shinyDashboardThemes(
                theme = "blue_gradient"
            ), 
            fluidRow(
                box(
                    title = "Ejecucion de Gastos por Entidades", status = "primary",
                    width = 12,
                    plotOutput(outputId = "grafico_entidades")
                ),
                box(title = "Seleccione Entidad:", status = "primary", solidHeader = TRUE,
                    width = 8,
                    selectInput("filtro_entidad",
                                "",
                                choices = "TODAS",
                                selected = "TODAS")
                ),
                box(title = "Descripcion Indicadores:", status = "primary",
                    width = 4,
                    "Vigente: presupuesto disponible (en Q).", br(),
                    "Devengado: presupuesto que se ha ejecutado/gastado (en Q.)", br(),
                    "Porcentaje Ejecucion: porcentaje de lo que se ha ejecutado respecto a lo que queda vigente"
                    
                ),
                box(
                    title = "Ejecucion de Gastos por Tipo de Gasto", status = "primary",
                    width = 8,
                    plotOutput(outputId = "grafico_tipo_gasto",
                               click = 'plot_click')
                ),
                box(title = "Indicadores",  status = "primary", width = 4,
                    fluidRow(
                        valueBoxOutput(width = 12, outputId = "vigente"),
                        valueBoxOutput(width = 12, outputId = "devengado"),
                        valueBoxOutput(width = 12, outputId = "porc_ejecucion")
                    )
                       
                ),
                box(title = "Filtros seleccionados", status = "warning",
                    width = 12,
                    infoBoxOutput(width = 12, outputId = "filtro_e")
                ),

                box(width = 12,
                       dataTableOutput("tabla_datos")
                )
            )     
        )
        
    )
)
