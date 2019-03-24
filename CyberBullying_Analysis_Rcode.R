#This example requires xml2 R package
require(xml2)

#Parse XML from an online document found at the URL specified below
URL <- "C:/Users/Ojoniko Nathan Abah/Desktop/CyberBullying_RProject/rProject_repo/cyberbullying_dataset/DataReleaseDec2011/XMLMergedFile.xml"
XML_data <- read_xml(URL)

#Save all nodes related to Net Income or Loss as defined by US GAAP
Nodes <- xml_find_all(XML_data, "//CYBERBULLYWORD")

#Convert the node structure into a character vector
bullyword <- as.character(Nodes)

#Retreive values for all Net Income or Loss elements and save them into a vetcor
#These are dollar values for each Net Income or Loss item reported in the 10Q document
Nodes_Values <- xml_find_all(XML_data, "//SEVERITY")
severity <- as.character(Nodes_Values)

#Bind the vectors together as columns and convert the structure into a data frame
#The data frame contains two columns and four rows
LABElData <- data.frame(cbind(bullyword,severity))

