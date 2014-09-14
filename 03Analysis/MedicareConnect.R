"
Put the following into .bash_profile 
export JAVA_HOME=`/usr/libexec/java_home` 
. ./.bash_profile 

Download ojdbc6.jar into ~/Downloads 
sudo mv ~/Downloads/ojdbc6.jar $JAVA_HOME 
"
# In the following, use your path instead of /Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home
# For Windows, your Java Home folder should be similar to: C:/Program Files/Java/jdk1.8.0_20

Sys.setenv(JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home')
options(java.parameters="-Xmx4g")
library(rJava)

# Output Java version
.jinit()
print(.jcall("java/lang/System", "S", "getProperty", "java.version"))

# Load RJDBC library
library(RJDBC)

jdbcDriver <- JDBC(driverClass="oracle.jdbc.OracleDriver", classPath="C:/Program Files/Java/jdk1.8.0_20/ojdbc6.jar")

# The following data.frame will be used as the default if emps can't be loaded from Oracle.
proc1 <- 1
proc2 <- 'Broken Shoulder'
procedureT <- data.frame(proc1,proc2)
col_headings <- c('PROCEDURE_ID', 'PROCEDURE_NAME')
names(procedureT) <- col_headings

possibleError <- tryCatch(
  # In the following, use your username and password instead of "CS347_prof", "orcl_prof"
  jdbcConnection <- dbConnect(jdbcDriver, "jdbc:oracle:thin:@128.83.138.158:1521:orcl", "C##cs347_fao286", "orcl_fao286"),
  error=function(e) e
)
if(!inherits(possibleError, "error")){
  procedureT <- dbGetQuery(jdbcConnection, "select * from procedures")
  providerT <- dbGetQuery(jdbcConnection, "select * from provider")
  recordT <- dbGetQuery(jdbcConnection, "select * from records")
  ppsT <- dbGetQuery(jdbcConnection, "select provider_state as state, count(provider_id) as num
from provider
GROUP BY provider_state;")
  dbDisconnect(jdbcConnection)
}

<<<<<<< HEAD


#provider per state table
possibleError <- tryCatch(
  # In the following, use your username and password instead of "CS347_prof", "orcl_prof"
  jdbcConnection <- dbConnect(jdbcDriver, "jdbc:oracle:thin:@128.83.138.158:1521:orcl", "C##cs347_fao286", "orcl_fao286"),
  error=function(e) e
)
if(!inherits(possibleError, "error")){
  ppsT <- dbGetQuery(jdbcConnection, "select provider_state as state, count(provider_id) as num
from provider
GROUP BY provider_state")
  dbDisconnect(jdbcConnection)
}






=======
>>>>>>> 64e747817b503f54c5ef4f356155b5a5f45c7297
