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
  recordT <- dbGetQuery(jdbcConnection, "select * from RECORDS")
  dbDisconnect(jdbcConnection)
}
head(recordT)

ggplot(data = recordT) + geom_histogram(aes(x = AVERAGE_COVERED_CHARGES))
ggplot(data = recordT) + geom_density(aes(x = AVERAGE_MEDICARE_PAYMENTS, method = "glm",fill = "gray50"))
ggplot(recordT, aes(x = AVERAGE_COVERED_CHARGES, y = TOTAL_DISCHARGES)) + geom_point()

##Update these lines, they are references for now:
p <- ggplot(diamonds, aes(x = carat, y = price)) + geom_point(aes(color = color))
p + facet_wrap(~color) # For ~, see http://stat.ethz.ch/R-manual/R-patched/library/base/html/tilde.html and http://stat.ethz.ch/R-manual/R-patched/library/stats/html/formula.html
p + facet_grid(cut ~ clarity)
p <- ggplot(diamonds, aes(x = carat)) + geom_histogram(aes(color = color), binwidth = max(diamonds$carat)/30)
p + facet_wrap(~color) 
p + facet_grid(cut ~ clarity)

