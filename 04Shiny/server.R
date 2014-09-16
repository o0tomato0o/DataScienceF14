# server.R
library(shiny)

jdbcDriver <- JDBC(driverClass="oracle.jdbc.OracleDriver", classPath="C:/Program Files/Java/jdk1.8.0_20/ojdbc6.jar")
# In the following, use your username and password instead of "CS347_prof", "orcl_prof" once you have an Oracle account
possibleError <- tryCatch(
  jdbcConnection <- dbConnect(jdbcDriver, "jdbc:oracle:thin:@128.83.138.158:1521:orcl", "C##cs347_fao286", "orcl_fao286"),
  error=function(e) e
)
if(!inherits(possibleError, "error")){
  procedureT <- dbGetQuery(jdbcConnection, "select * from procedures")
  providerT <- dbGetQuery(jdbcConnection, "select * from provider")
  recordT <- dbGetQuery(jdbcConnection, "select * from records")
  shinyT <- dbGetQuery(jdbcConnection, "select * from shinyT")
  dbDisconnect(jdbcConnection)
}
datasetInput <- reactive({
  switch(input$shinyT,
         "AL" = shinyT, #subset(shinyT,provider_state == "AL"),
         "AK" = shinyT, #subset(shinyT,provider_state == "AK"),
         "AZ" = shinyT, #subset(shinyT,provider_state == "AZ"),
         "AR" = shinyT #subset(shinyT,provider_state == "AR")
  #       "CA" = CA,         "CO" = CO,         "CT" = CT,         "DE" = DE,
  #       "FL" = FL,         "GA" = GA,         "HI" = HI,         "ID" = ID,
  #       "IL" = IL,         "IN" = IN,         "IA" = IA,         "KS" = KS,
  #       "KY" = KY,         "LA" = LA,         "ME" = ME,         "MD" = MD,
  #       "MA" = MA,         "MI" = MI,         "MN" = MN,         "MS" = MS,
  #       "MO" = MO,         "MT" = MT,         "NE" = NE,         "NV" = NV,
  #       "NH" = NH,         "NJ" = NJ,         "NM" = NM,         "NY" = NY,
  #       "NC" = NC,         "ND" = NH,         "OH" = OH,         "OK" = OK,
  #       "OR" = OR,         "PA" = PA,         "RI" = RI,         "SC" = SC,
  #       "SD" = SD,         "TN" = TN,         "TX" = TX,         "UT" = UT,
  #       "VT" = VT,         "VA" = VA,         "WA" = WA,         "WV" = WV,
  #       "WI" = WI,         "WY" = WY)
)}

output$summary <- renderPrint({
  shinyT <- datasetInput()
  summary(shinyT)
})

#statebins_continuous(ppsT, "STATE", "NUM", text_color="black", font_size=3, legend_title="Providers", legend_position="bottom", )
