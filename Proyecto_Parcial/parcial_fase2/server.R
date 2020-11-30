#Curso: Product Development
#Integrantes:
#	Lilian Rebeca Carrera Lemus
#	Jose Armando Barrios Leon
#Tarea: Proyecto Parcial Fase2

library(shiny)
library(DT)
library(dplyr)
library(ggplot2)
library(scales)
library(tidyverse)

shinyServer(function(input, output, session) {
    
    observe({
        datos<-archivo_carga_datos()
        ent<-factor(datos$entidad)
        entidades <-levels(ent)
        tod <- c("TODAS")
        t_entidades <- cbind(entidades,tod)
        
        updateSelectInput(session,"filtro_entidad",
                          choices = t_entidades,
                          selected = "TODAS")
        
    })
    
    observe({
        
        query<- parseQueryString(session$clientData$url_search)
        sel_entidad <- query[["entidad"]]
        
        if(!is.null(sel_entidad)){
            updateSelectInput(session,"filtro_entidad",selected = sel_entidad)
        }
        
    })
    
    observe({
        sel_entidad <-input$filtro_entidad
        #updateTextInput(session,"url", value=link_url)
    })
    
    archivo_carga_datos <- reactive({
        datos <- read.csv("Datos/Gastos_GC.csv", sep = ";", header = TRUE, encoding='latin-1')
        return(datos)
        
    })
    
    calcular_vigente <- reactive({
        datos <- archivo_carga_datos()
        
        if(input$filtro_entidad == 'TODAS'){
            vigente <- sum(datos$vigente)
            return(vigente)
        }
        else
        {
            vigente <- datos %>% 
                dplyr::filter(entidad == input$filtro_entidad) %>% 
                dplyr::summarize(vigente =sum(vigente)
                                )
            return(vigente)
        }
        
    })
    
    calcular_devengado <- reactive({
        datos <- archivo_carga_datos()
        
        if(input$filtro_entidad == 'TODAS'){
            devengado <- sum(datos$devengado)
            return(devengado)
        }
        else
        {
            devengado <- datos %>% 
                dplyr::filter(entidad == input$filtro_entidad) %>% 
                dplyr::summarize(devengado =sum(devengado)
                )
            return(devengado)
        }
        
    })
    

    output$grafico_entidades <- renderPlot({
        datos <- archivo_carga_datos()
        
        datos_g_entidades <- datos %>% 
            group_by(entidad) %>% 
            dplyr::summarize(sum_devengado = sum(devengado), 
                             sum_vigente = sum(vigente)
                             )
        
        ggplot(datos_g_entidades) +
            geom_bar(mapping = aes(x = sum_devengado, y = entidad), stat = "identity", fill = 'steelblue') +
            ylab("Entidad") + 
            xlab("Devengado") + 
            scale_x_continuous(labels = comma) +
            ggtitle("Gasto Devengado por Entidad")+
            theme_minimal()
    })
    
    output$vigente <- renderValueBox({
        vig <- calcular_vigente()
        vig <- format(round(as.numeric(vig), 1), nsmall=1, big.mark=",")
        valueBox( vig,
                  subtitle = "Monto Vigente",
                  icon("usd",lib='glyphicon'),
                  color = "green",
                  width = 12
        )
    })
    
    output$devengado <- renderValueBox({
        dev <- calcular_devengado()
        dev <- format(round(as.numeric(dev), 2), nsmall=2, big.mark=",")
        valueBox( dev,
                  subtitle = "Monto Devengado",
                  icon("shopping-cart",lib='glyphicon'),
                  color = "blue",
                  width = 12
        )
    })
    
    output$porc_ejecucion <- renderValueBox({
        
        if(input$filtro_entidad == 'TODAS'){
            p_ejec <- calcular_devengado()/calcular_vigente()
        }
        else
        {
            d <- calcular_devengado()
            v <- calcular_vigente()
            p_ejec <- d$devengado/v$vigente
            
        }
        
        p_ejec <- percent(p_ejec)
        valueBox(
            p_ejec, 
            "Porcentaje Ejecucion",
            icon("stats",lib='glyphicon'),
            color = "purple",
            width = 12)
        
    })
    
    output$filtro_e <- renderInfoBox({
        
        infoBox(input$filtro_entidad,
                title = "Entidad Seleccionada:",
                width = 12
        )
    })
    
    
    calc_grafico_tg <- reactive({
        datos <- archivo_carga_datos()
        
        if(input$filtro_entidad == 'TODAS'){
            
            datos_grafico <- datos %>% 
                group_by(tipo_gasto) %>% 
                dplyr::summarize(devengado = format(round(as.numeric(sum(devengado)), 2), nsmall=2, big.mark=",")
                )
            
            return(datos_grafico)
            
        }
        else
        {
            datos_grafico <- datos %>% 
                dplyr::filter(entidad == input$filtro_entidad) %>%
                group_by(tipo_gasto) %>% 
                dplyr::summarize(devengado = format(round(as.numeric(sum(devengado)), 2), nsmall=2, big.mark=",")
                )
            
            return(datos_grafico)
        }
        
    })
    
    output$grafico_tipo_gasto <- renderPlot({
        datos_grafico <- calc_grafico_tg()
        
        ggplot(datos_grafico,
               aes(x="",y=devengado, fill=tipo_gasto))+
            geom_bar(stat = "identity",
                     color="white")+
            geom_text(aes(label=devengado),
                      position=position_stack(vjust=0.5),color="white",size=6)+
            coord_polar(theta = "y")+
            scale_fill_manual(values=c("black","orange","gray","steelblue"))+
            theme_void()
        
        
    })
    
    calc_tabla <- reactive({
        datos <- archivo_carga_datos()
        
        if(input$filtro_entidad == 'TODAS'){
            
            data_tabla <- datos %>% 
                group_by(grupo_gasto, subgrupo_gasto, renglon) %>% 
                dplyr::summarize(asignado = format(round(as.numeric(sum(asignado)), 2), nsmall=2, big.mark=","),
                                 vigente = format(round(as.numeric(sum(vigente)), 2), nsmall=2, big.mark=","),
                                 devengado = format(round(as.numeric(sum(devengado)), 2), nsmall=2, big.mark=","))
            
                return(data_tabla)
            
        }
        else
        {
            data_tabla <- datos %>% 
                dplyr::filter(entidad == input$filtro_entidad) %>% 
                group_by(grupo_gasto, subgrupo_gasto, renglon) %>% 
                dplyr::summarize(asignado = format(round(as.numeric(sum(asignado)), 2), nsmall=2, big.mark=","),
                                 vigente = format(round(as.numeric(sum(vigente)), 2), nsmall=2, big.mark=","),
                                 devengado = format(round(as.numeric(sum(devengado)), 2), nsmall=2, big.mark=","))
                
                return(data_tabla)
        }

    })
    
    
    output$tabla_datos <- renderDataTable({
        data_tab <- calc_tabla()
        
        names(data_tab) = c("GRUPO GASTO", "SUBGRUPO GASTO", "RENGLON", "ASIGNADO", "VIGENTE", "DEVENGADO")
            
        DT::datatable(data_tab)
    })

})
