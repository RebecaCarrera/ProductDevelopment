library(shiny)
library(DT)
library(dplyr)
library(ggplot2)
library(tidyverse)

shinyServer(function(input, output) {
  
  archivo_carga_1 <- reactive({
    if(is.null(input$upload_file_1)){
      return(NULL)
    }
    #para debuguear
    #browser()
    
    ext <- strsplit(input$upload_file_1$name, split = "[.]")[[1]][2]
    if(ext == 'csv'){
      file_data <- read.csv(input$upload_file_1$datapath)
      return(file_data)
    }
    if(ext == 'tsv'){
      file_data <- read.tsv(input$upload_file_1$datapath)
      return(file_data)
    }
    return(NULL)
    
  })
  
  output$contenido_archivo_1 <- renderTable({
    archivo_carga_1()
  })

  
  archivo_carga_2 <- reactive({
    if(is.null(input$upload_file_2)){
      return(NULL)
    }

    ext <- strsplit(input$upload_file_2$name, split = "[.]")[[1]][2]
    if(ext == 'csv'){
      file_data <- read.csv(input$upload_file_2$datapath)
      return(file_data)
    }
    if(ext == 'tsv'){
      file_data <- readr::read.tsv(input$upload_file_2$datapath)
      return(file_data)
    }
    return(NULL)
    
  })
  
  output$contenido_archivo_2 <- renderDataTable({
    archivo_carga_2() %>%
      datatable(filter = "bottom")
    #DT::datatable(archivo_carga_2())
  })
  
  output$tabla1 <- renderDataTable({
    diamonds %>%
            datatable() %>%
            formatCurrency("price") %>%
            formatString(c("x","y","z"), suffix ="mm")
  })
  
  output$Tabla2 <- renderDataTable({
    mtcars %>%
      datatable(options = list(pageLength=5,
                               lengthMenu = c(5,10,15)
                               ),
                filter='top'
                )
    
  })
  
  output$Tabla3 <- renderDataTable({
    iris %>% datatable(extensions = 'Buttons',
                       options = list(dom= 'Bfrtip',
                                      buttons = c('csv')),
                       rownames = FALSE
                       )
  })
  
  output$tabla4 <- renderDataTable({
    mtcars %>% datatable(selection = 'single')
  })
  
  output$tabla4_single_click <- renderText({
    input$tabla4_rows_selected 
  })
  
  output$tabla5 <- renderDataTable({
    mtcars %>% datatable()
  })
  
  output$tabla5_multi_click <- renderText({
    input$tabla5_rows_selected
  })
  
  output$tabla6 <- renderDataTable({
    mtcars %>% datatable(selection = list(mode= 'single',
                                          target= 'column')
                         )
  })
  
  output$tabla6_single_click <- renderText({
    input$tabla6_columns_selected
  })
  
  output$tabla7 <- renderDataTable({
    mtcars %>% datatable(selection = list(mode= 'multiple',
                                          target= 'column')
                        )
  })
  
  output$tabla7_multi_click <- renderText({
    input$tabla7_columns_selected
  })
  
  output$tabla8 <- renderDataTable({
    mtcars %>% datatable(selection = list(mode= 'single',
                                          target= 'cell')
                          )
  })
  
  output$tabla8_single_click <- renderText({
    input$tabla8_cells_selected
  })
  
  output$tabla9 <- renderDataTable({
    mtcars %>% datatable(selection = list(mode= 'multiple',
                                          target= 'cell')
                        )
  })
  
  output$tabla9_multi_click <- renderText({
    input$tabla9_cells_selected
  })
  
  

})
