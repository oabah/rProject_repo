

require(xml2)
URL <- "C:/Users/Ojoniko Nathan Abah/Desktop/CyberBullying_RProject/rProject_repo/cyberbullying_dataset/DataReleaseDec2011/XMLMergedFile.xml"
XML_data <- read_xml(URL)

XML_List <- as_list(XML_data)
