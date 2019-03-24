#This example requires xml2 R package
require(xml2)

#Parse XML
URL <- "C:/Users/Ojoniko Nathan Abah/Desktop/CyberBullying_RProject/rProject_repo/cyberbullying_dataset/DataReleaseDec2011/XMLMergedFile.xml"
XML_data <- read_xml(URL)

#retrieve text case
Nodes_0 <- xml_find_all(XML_data, "//TEXT")
cases <- as.character(Nodes_0)

#retrieve answer
Nodes_1 <- xml_find_all(XML_data, "//ANSWER")
bully_or_not <- as.character(Nodes_1)

#retrieve bullyword
Nodes_2 <- xml_find_all(XML_data, "//CYBERBULLYWORD")
bullyword <- as.character(Nodes_2)

#Retreive severity
Nodes_3 <- xml_find_all(XML_data, "//SEVERITY")
severity <- as.character(Nodes_3)

#Bind the vectors together as columns and convert the structure into a data frame
LABElData <- data.frame(cbind(cases,bully_or_not,bullyword,severity))

