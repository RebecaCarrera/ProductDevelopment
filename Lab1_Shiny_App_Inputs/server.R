#Autor: Lilian Rebeca Carrera Lemus
#Carnet: 20008077
#Curso: Product Development
#Laboratorio No.1

library(shiny)
library(readr)

shinyServer(function(input, output) {

    output$slider_io <- renderText({
        paste0(c("Output Slider Input: ", input$slider_input),
               collapse = '')
    })
    
    output$slider_io_2 <- renderText({
        input$slider_input2
    })
    
    output$select_io <- renderText({
        as.character(input$select_input)
    })
    
    output$select_io_multi <- renderText({
         selections<- paste0(input$select_input2, collapse = ', ')
         paste0(c("Selecciones del UI: ", selections), collapse = '')
    })
    
    output$date_io <- renderText({
        paste0(day(input$date_input),'/',month(input$date_input),'/',year(input$date_input))
    })
    
    output$date_range_io <- renderText({
        paste0(day(input$date_range[1]),'/',month(input$date_range[1]),'/',year(input$date_range[1]), 
               ' a ', 
               day(input$date_range[2]),'/',month(input$date_range[2]),'/',year(input$date_range[2]))
    })
    
    output$numeric_io <- renderText({
        input$numeric_input
    })
    
    output$single_box_io <- renderText({
        input$single_box
    })
    
    output$group_box_io <- renderText({
        input$group_box
    })
    
    output$radio_button_io <- renderText({
        input$radio_button
    })
    
    output$text_io <- renderText({
        input$text_input
    })
    
    output$tex_area_io <- renderText({
        input$text_area_input
    })
    
    output$pass_input_io <- renderText({
        input$pass_input
    })
    
    #Botones
    output$action_button_io <- renderText({
        input$action_button
    })
    
    button_link_event = eventReactive(input$action_link, {
        as.character('Ir al siguiente')
    })
    
    output$action_link_io = renderText({
        button_link_event()
    })

})
