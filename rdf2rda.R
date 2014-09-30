# This script will parse the all_concepts.rdf into an Rda object
# Because nobody likes using sparql! :O)
library(XML)
# Make sure you are in the working directory with "all_concepts.rdf" file
raw = xmlParse("all_concepts.rdf")
raw <- xmlToList(raw)

# Let's put the concepts into a data frame
cat("Processing",length(raw),"concepts into a data frame...\n")

# Here are the fields
fields = names(raw$Concept)
# I don't want to save all of them
fields = fields[c(1,2,7,8,13,17,18,19,20,21,22,23)]
concepts = array(dim=c(length(raw),12))
colnames(concepts) = fields

for (c in 1:length(raw)){
  concept = raw[c]
  cat("Parsing",c,"of",length(raw),"\n")
  for (o in 1:length(concept$Concept)){
      label = names(concept$Concept[o])
      value = concept$Concept[[o]]
      if (!is.null(value) && label %in% fields){
        concepts[c,label] = value
      }
  }
}

colnames(concepts)[12] = "url"
concepts = as.data.frame(concepts)
# Convert to strings from factors
for (c in 1:ncol(concepts)){
  concepts[,c] = as.character(concepts[,c])
}
save(concepts,file="all_concepts.Rda")