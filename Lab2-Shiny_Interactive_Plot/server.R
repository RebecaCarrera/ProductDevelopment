library(shiny)
library(ggplot2)
library(dplyr)
library(DT)

out_click<- NULL
out_hover<-NULL

shinyServer(function(input, output) {
    
    p_selected <- reactive({
        if(!is.null(input$click_plot$x)){
            df<-nearPoints(mtcars,input$click_plot,xvar='wt',yvar='mpg')
            out <- df %>% 
                select(wt,mpg)
            out_click <<- rbind(out_click,out) %>% distinct()
            return(out)
        }
        if(!is.null(input$hover_plot$x)){
            df<-nearPoints(mtcars,input$hover_plot,xvar='wt',yvar='mpg')
            out <- df %>% 
                select(wt,mpg)
            out_hover <<- out
            return(out_hover)
        }
        
        if(!is.null(input$dblcilck_plot$x)){
            df<-nearPoints(mtcars,input$dblcilck_plot,xvar='wt',yvar='mpg')
            out <- df %>% 
                select(wt,mpg)
            out_click <<- setdiff(out_click,out)
            return(out_hover)
        }
        
        if(!is.null(input$brush_plot)){
            df<-brushedPoints(mtcars,input$brush_plot,xvar='wt',yvar='mpg')
            out <- df %>% 
                select(wt,mpg)
            out_click <<- rbind(out_click,out) %>% dplyr::distinct()
            return(out_hover)
        }
        
    })
    
    
    opt_plot <- reactive({
        plot(mtcars$wt,mtcars$mpg,xlab="peso del vehiculo", ylab="millas por galon")
        sel_puntos <-p_selected()
        if(!is.null(out_hover)){
            points(out_hover[,1],out_hover[,2],
                   col='gray',
                   pch=16,
                   cex=2)}
        if(!is.null(out_click)){
            points(out_click[,1],out_click[,2],
                   col='green',
                   pch=16,
                   cex=2)}
        
    })
    
    output$plot_mtcars <- renderPlot({
        opt_plot()
    })
    
    
    input_table <- reactive({
        input$click_plot$x
        input$dblcilck_plot$x
        input$brush_plot
        out_click
    })
    
    
    output$dt_mtcars <- DT::renderDataTable({
        input_table() %>% DT::datatable()
        
        if(!is.null(out_hover) & !is.null(out_click)){
            input_table() %>% DT::datatable() 
        }else {
            mtcars %>% DT::datatable()
        } 
        
    })  
    
})
