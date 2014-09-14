##library("ggplot2")
##"Displaying the top few rows of a dataframe:"
##head(diamonds)
##"Selecting a subset of columns from a dataframe:"
##head(subset(diamonds, select = c(carat, cut)))
##"Selecting a subset of rows from a dataframe:"
##head(subset(diamonds, cut == "Ideal" & price > 5000))
##"Find average price group by color (plyr package is needed)"
##library("plyr", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
##ddply(subset(diamonds, cut == "Ideal" & price > 5000),~color, summarise, o=mean(price, na.rm = TRUE))


#Example of ggplot, but move this line to Pots folder later
ggplot(data = diamonds) + geom_histogram(aes(x = PROCEDURE_ID, PROCEDURE_NAME))


<<<<<<< HEAD
head(procedureT)
ggplot(data = procedureT) + geom_histogram(aes(x = provider_ID))
PROCEDURE_ID + PROCEDURE_NAME
**
=======
>>>>>>> 64e747817b503f54c5ef4f356155b5a5f45c7297

library("ggplot2")
"Displaying the top few rows of a dataframe:"
head(procedureT)
"Selecting a subset of columns from a dataframe:"
head(subset(procedureT, select = c(PROCEDURE_NAME)))
"Selecting a subset of rows from a dataframe:"
<<<<<<< HEAD
head(subset(diamonds, cut == "Ideal" & price > 5000))
"Find average price group by color (plyr package is needed)"
library("plyr", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
ddply(subset(diamonds, cut == "Ideal" & price > 5000),~color, summarise, o=mean(price, na.rm = TRUE))

head(providerT)
statebins_continuous(ppsT, "STATE", "NUM", text_color="black", font_size=3, legend_title="Providers", legend_position="bottom", )


ggplot(data = procedureT) + geom_histogram(aes(x = procedure_ID))
=======
head(subset(procedureT, PROCEDURE_NAME == "DYSEQUILIBRIUM" & PROCEDURE_ID > 100))
>>>>>>> 64e747817b503f54c5ef4f356155b5a5f45c7297
