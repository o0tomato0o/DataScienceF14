library("ggplot2")
options(java.parameters="-Xmx2g")
library(rJava)
library(RJDBC)

jdbcDriver <- JDBC(driverClass="oracle.jdbc.OracleDriver", classPath="C:/Program Files/Java/jdk1.8.0_20/ojdbc6.jar")

# In the following, use your username and password instead of "CS347_prof", "orcl_prof" once you have an Oracle account
possibleError <- tryCatch(
  jdbcConnection <- dbConnect(jdbcDriver, "jdbc:oracle:thin:@128.83.138.158:1521:orcl", "C##cs347_fao286", "orcl_fao286"),
  error=function(e) e
)
if(!inherits(possibleError, "error")){
  procedureT <- dbGetQuery(jdbcConnection, "select * from PROCEDURES")
  providerT <- dbGetQuery(jdbcConnection, "select * from PROVIDER")
  shinyAT <- dbGetQuery(jdbcConnection, "select * from SHINYT WHERE PROVIDER_STATE = 'TX' ")
  recordT <- dbGetQuery(jdbcConnection, "select * from RECORDS")
  texasOnly <- dbGetQuery(jdbcConnection, "select PROVIDER_STATE, PROVIDER_NAME, PROVIDER_CITY, PROVIDER_ZIP_CODE,  AVERAGE_COVERED_CHARGES, AVERAGE_TOTAL_PAYMENTS, AVERAGE_MEDICARE_PAYMENTS from PROVIDER pr INNER JOIN RECORDS rec ON pr.PROVIDER_ID = rec.PROVIDER_ID AND PROVIDER_CITY = 'Austin' AND PROVIDER_STATE = 'TX'
ORDER BY PROVIDER_NAME")
  dbDisconnect(jdbcConnection)
}
head(recordT)
head(austinOnly)
head(shinyAT)

ggplot(data = shinyAT) + geom_histogram(aes(x = NUM))
ggplot(data = shinyAT) + geom_density(aes(x = NUM,fill = "gray50"))
ggplot(shinyAT, aes(y = NUM, x = PROCEDURE_NAME)) + geom_point()


p <- ggplot(shinyAT, aes(y = NUM, x = PROCEDURE_NAME)) + geom_point(aes(color = NUM))
p + facet_wrap(~NUM) # For ~, see http://stat.ethz.ch/R-manual/R-patched/library/base/html/tilde.html and http://stat.ethz.ch/R-manual/R-patched/library/stats/html/formula.html
p + facet_grid(~NUM)

p <- ggplot(shinyAT, aes(x = NUM)) + geom_histogram(aes(color = NUM), binwidth = max(shinyT$NUM)/30)
p + facet_wrap(~NUM) 
p + facet_grid(~NUM)

