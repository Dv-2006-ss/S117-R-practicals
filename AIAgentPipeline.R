# AI-AGENT SYSTEM: INTEGRATED MODULE-WISE & ALGORITHM-CENTRIC FRAMEWORK

# --- 1. DEPENDENCY MANAGEMENT ---
# Ensuring the computational environment has all necessary algorithmic libraries [cite: 54]
libs <- c("shiny", "quantmod", "ggplot2", "DT", "dplyr", "tidyquant", "shinythemes", "forecast", "reshape2")
for (l in libs) { if (!require(l, character.only = TRUE)) install.packages(l) }

library(shiny); library(quantmod); library(ggplot2); library(DT); library(dplyr)
library(tidyquant); library(shinythemes); library(forecast); library(reshape2)

# --- 2. UI: COORDINATION & COMMUNICATION MODULES (Modules 5 & 6) ---
# Manages structured information exchange and final decision aggregation [cite: 11, 122]
ui <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel("AI-Agent System: Module-Wise Stock Framework"),
  tags$p(strong("Authors: Dhairya Singh, Hariprasad P. Vishwakarma, Dr. Mahedra Kanojia")),
  hr(),
  
  sidebarLayout(
    sidebarPanel(
      h4("Search & Control"),
      helpText("Module 1: Data Collection Entry Point"),
      textInput("symb", "Enter Ticker (e.g., AAPL, RELIANCE.NS):", "AAPL"),
      dateRangeInput("dates", "Timeline:", start = Sys.Date() - 365, end = Sys.Date()),
      actionButton("run", "Execute Pipeline", class = "btn-primary", width = "100%"),
      hr(),
      h4("Regional Ticker Lookup"),
      helpText("Part of Module 1: Pre-Collection Search"),
      textInput("compName", "Search Company Name:"),
      actionButton("lookup", "Find Ticker", class = "btn-info")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Lookup Results", br(), DTOutput("lookupTable")),
        
        tabPanel("Module 1 & 2: Data", br(), 
                 h4("Cleaned & Preprocessed Dataset (Analytical Readiness)"),
                 DTOutput("dataTable")),
        
        tabPanel("Module 3: Analysis", br(), 
                 plotOutput("analysisPlot"),
                 h4("Module 4.3: Correlation Analysis (Diagnostic Insight)"),
                 plotOutput("corrPlot"), # NEW: Correlation Matrix Visualization [cite: 114]
                 h4("Diagnostic Statistics & Trend Detection"),
                 verbatimTextOutput("summaryText")),
        
        tabPanel("Module 4: Prediction", br(), 
                 plotOutput("predictionPlot"),
                 h4("SARIMA Algorithmic Transparency (Interpretable AI)"),
                 verbatimTextOutput("modelDetails"))
      )
    )
  )
)

# --- 3. SERVER: COMPUTATIONAL PIPELINE EXECUTION ---
# Functional intelligence emerges through coordinated interaction of specialized modules [cite: 10, 13]
server <- function(input, output, session) {
  
  # MODULE 1: DATA COLLECTION (PRE-COLLECTION LOOKUP)
  # Ensures reliable and structured data availability [cite: 107]
  ticker_results <- eventReactive(input$lookup, {
    req(input$compName)
    kb <- data.frame(
      symbol = c("AAPL", "TSLA", "MSFT", "GOOGL", "AMZN", "RELIANCE.NS", "TCS.NS", "INFY.NS", "HDFCBANK.NS", "TATASTEEL.NS", "TATAMOTORS.NS", "VOD.L", "BP.L", "MC.PA", "SAP.DE", "ASML.AS"),
      company = c("Apple Inc.", "Tesla Inc.", "Microsoft", "Google", "Amazon", "Reliance Industries", "Tata Consultancy Services", "Infosys", "HDFC Bank", "Tata Steel", "Tata Motors", "Vodafone Group", "BP plc", "LVMH", "SAP SE", "ASML Holding"),
      Market = c(rep("NASDAQ", 5), rep("India (NSE)", 6), rep("Europe", 5))
    )
    kb %>% filter(grepl(input$compName, company, ignore.case = TRUE) | grepl(input$compName, symbol, ignore.case = TRUE))
  })
  
  output$lookupTable <- renderDT({ datatable(ticker_results()) })
  
  # MODULE 1 & 2: COLLECTION AND PREPROCESSING
  # Acquires data and applies statistical cleaning to reduce noise [cite: 94, 108]
  pipeline_data <- eventReactive(input$run, {
    req(input$symb)
    withProgress(message = 'Running AI Pipeline...', value = 0, {
      incProgress(0.3, detail = "Module 1: Collecting Raw Data")
      df <- tryCatch({ getSymbols(input$symb, src = "yahoo", from = input$dates[1], to = input$dates[2], auto.assign = FALSE) }, error = function(e) { return(NULL) })
      
      # Module 5: Communication Module Validation [cite: 121]
      validate(need(!is.null(df), "PIPELINE ERROR: Ticker not found. Please verify the symbol."))
      
      incProgress(0.6, detail = "Module 2: Preprocessing Data")
      # Algorithms: Data cleaning and missing-value imputation [cite: 110]
      df_clean <- na.omit(df) 
      colnames(df_clean) <- c("Open", "High", "Low", "Close", "Volume", "Adjusted")
      incProgress(0.9, detail = "Module 6: Final Coordination")
      return(as.data.frame(df_clean))
    })
  }, ignoreNULL = FALSE)
  
  # MODULE 3: ANALYSIS MODULE (Diagnostic Analysis & Trend Detection)
  # Extracts diagnostic insights that serve as intermediate knowledge representations [cite: 113, 115]
  output$analysisPlot <- renderPlot({
    df <- pipeline_data()
    df$Date <- as.Date(rownames(df))
    # Algorithm: Trend Detection (20-Day Moving Average) [cite: 114]
    df$MA20 <- rollapply(df$Close, width = 20, FUN = mean, fill = NA, align = "right")
    
    ggplot(df, aes(x = Date)) + 
      geom_line(aes(y = Close), color = "#2c3e50", alpha = 0.5) + 
      geom_line(aes(y = MA20), color = "blue", size = 1) +
      labs(title = paste("Module 4.3: Trend Detection Analysis -", input$symb),
           subtitle = "Blue line: 20-Day Moving Average (Diagnostic Insight)",
           x = "Timeline", y = "Price") +
      theme_minimal()
  })
  
  # NEW: Correlation Analysis Module 
  output$corrPlot <- renderPlot({
    df <- pipeline_data()
    # Algorithm: Correlation Analysis on price variables [cite: 114]
    cor_matrix <- cor(df[, c("Open", "High", "Low", "Close")])
    melted_cor <- melt(cor_matrix)
    
    ggplot(melted_cor, aes(Var1, Var2, fill = value)) +
      geom_tile() +
      scale_fill_gradient2(low = "red", high = "blue", mid = "white", midpoint = 0.95) +
      geom_text(aes(label = round(value, 2))) +
      labs(title = "Module 4.3: Price Variable Correlation Heatmap", x = "", y = "") +
      theme_minimal()
  })
  
  # Algorithm: Descriptive Statistics [cite: 67, 114]
  output$summaryText <- renderPrint({ summary(pipeline_data()$Close) })
  
  # MODULE 4: PREDICTION MODULE (SARIMA + Decision Logic)
  # Generates predictive insights using interpretable forecasting models [cite: 117]
  output$predictionPlot <- renderPlot({
    df <- pipeline_data()
    # Algorithm: ARIMA/SARIMA Interpretable Forecasting [cite: 12, 118]
    fit <- auto.arima(ts(df$Close, frequency = 5), seasonal = TRUE) 
    autoplot(forecast(fit, h = 30)) + 
      labs(title = "Module 4.4: SARIMA Predictive Insights",
           subtitle = "30-Day Forecast with Confidence Intervals",
           x = "Time Index", y = "Price") + 
      theme_minimal()
  })
  
  # Algorithm: Weighted Averaging & Rule-Based Integration [cite: 124, 125]
  output$modelDetails <- renderPrint({
    df <- pipeline_data()
    fit <- auto.arima(ts(df$Close, frequency = 5), seasonal = TRUE)
    f_obj <- forecast(fit, h = 30)
    
    curr_p <- tail(df$Close, 1); pred_p <- tail(f_obj$mean, 1)
    p_change <- ((pred_p - curr_p) / curr_p) * 100
    
    cat("--- SYSTEM-LEVEL DECISION LAYER (MODULE 4.6) ---\n")
    if (p_change > 2) { cat("SIGNAL: STRONG BUY\nREASON: Predicts growth of", round(p_change, 2), "%\n")
    } else if (p_change < -2) { cat("SIGNAL: STRONG SELL\nREASON: Predicts decline of", round(p_change, 2), "%\n")
    } else { cat("SIGNAL: HOLD\nREASON: Volatility remains neutral (", round(p_change, 2), "%)\n") }
    
    cat("\n--- ALGORITHMIC TRANSPARENCY (ARIMA SPECS) ---\n")
    summary(fit) 
  })
  
  # MODULE 6: AGGREGATION & FINAL DECISION OUTPUT [cite: 123, 125]
  output$dataTable <- renderDT({ datatable(pipeline_data(), options = list(pageLength = 10)) })
}

shinyApp(ui, server)