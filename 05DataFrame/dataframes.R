library("ggplot2", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
options(java.parameters="-Xmx4g")
library(rJava)
library(RJDBC)
library(grid)
library(scales)
library(gridExtra)
library(RColorBrewer)
library(statebins)
##ggplot2, grid, scales, gridExtra, RColorBrewer

jdbcDriver <- JDBC(driverClass="oracle.jdbc.OracleDriver", classPath="/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home/ojdbc6.jar")
possibleError <- tryCatch(
  # In the following, use your username and password instead of "CS347_prof", "orcl_prof"
  jdbcConnection <- dbConnect(jdbcDriver, "jdbc:oracle:thin:@128.83.138.158:1521:orcl", "C##cs347_fao286", "orcl_fao286"),
  error=function(e) e
)
if(!inherits(possibleError, "error")){
  procedureT <- dbGetQuery(jdbcConnection, "select * from procedures")
  providerT <- dbGetQuery(jdbcConnection, "select * from provider")
  #recordT <- dbGetQuery(jdbcConnection, "select * from records")
  ppsT <- dbGetQuery(jdbcConnection, "select provider_state as state, count(provider_id) as num from provider GROUP BY provider_state")
  drug <- dbGetQuery(jdbcConnection, "select distinct provider_state as state, SUM(total_discharges) as num from dummyT where procedure_id = '917' GROUP by provider_state")
  
  dbDisconnect(jdbcConnection)
}


#Example of ggplot, but move this line to Pots folder later
#ggplot(data = procedureT) + geom_histogram(aes(x = PROCEDURE_ID, PROCEDURE_NAME))



#head(procedureT)
ggplot(data = providerT) + geom_histogram(aes(x = PROVIDER_ID))


#library("ggplot2")
"Displaying the top few rows of a dataframe:"
#head(procedureT)
"Selecting a subset of columns from a dataframe:"
#head(subset(procedureT, select = c(PROCEDURE_NAME)))
"Selecting a subset of rows from a dataframe:"
#head(subset(diamonds, cut == "Ideal" & price > 5000))
"Find average price group by color (plyr package is needed)"

#library("plyr", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
#ddply(subset(diamonds, cut == "Ideal" & price > 5000),~color, summarise, o=mean(price, na.rm = TRUE))

#head(providerT)

#state heatmap
statebins_continuous(ppsT, "STATE", "NUM", text_color="black", font_size=3, legend_title="Providers", legend_position="bottom", brewer_pal = "YlGnBu" )

statebins_continuous(drug, "STATE", "NUM", text_color="black", font_size=3, legend_title="POISONING & TOXIC EFFECTS OF DRUGS W MCC", legend_position="bottom", brewer_pal = "Greens" )


#ggplot(data = procedureT) + geom_histogram(aes(x = procedure_ID))

#head(subset(procedureT, PROCEDURE_NAME == "DYSEQUILIBRIUM" & PROCEDURE_ID > 100))

