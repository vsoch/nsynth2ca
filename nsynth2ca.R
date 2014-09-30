# This script will match neurosynth terms (525 or 3000) to the cognitive atlas

# Load the Cognitive Atlas Concepts RDA file (created with rdf2rda.R)
load("all_concepts.Rda")

# Read in neurosynth terms
load("neurosynthTerms.Rda")

# Neurosynth does not have terms with more than one word, just get rid of them
todelete = c()
for (c in 1:length(concepts$prefLabel)){
  words = strsplit(concepts$prefLabel[c]," ")[[1]]
  if (length(words)>1){
    todelete = c(todelete,c)
  }
}
concepts = concepts[-todelete,]
cat("There are",nrow(concepts),"concepts remaining.\n")

# If there is an "alt term" with more than one word linked to a single word, the user
# can find that via the single term, not going to maintain it here!

# Match concepts exactly to neurosynth terms - 525
ca.idx = which(tolower(concepts$prefLabel) %in% tolower(nsynth$terms525))
ns.idx = which(tolower(nsynth$terms525) %in% tolower(concepts$prefLabel))
match525 = cbind(concepts[ca.idx,],nsynth$terms525[ns.idx])
colnames(match525)[13] = "neurosynth525term"
cat("There are",nrow(match525),"concepts in the Cognitive Atlas that map to the NeuroSynth 525 database.\n")

# Match concepts exactly to neurosynth terms - 3000
ca.idx = which(tolower(concepts$prefLabel) %in% tolower(nsynth$terms2592))
ns.idx = which(tolower(nsynth$terms2592) %in% tolower(concepts$prefLabel))
match2592 = cbind(concepts[ca.idx,],nsynth$terms2592[ns.idx])
colnames(match2592)[13] = "neurosynth2592term"
cat("There are",nrow(match2592),"concepts in the Cognitive Atlas that map to the NeuroSynth 2592 database.\n")

# Are all of 525 in the larger database?
length(which(nsynth$terms525 %in% nsynth$terms2592))
# Uhoh 443?
missing = nsynth$terms525[-which(nsynth$terms525 %in% nsynth$terms2592)]
cat("There are",length(missing),"terms in the neurosynth 525 database that are not in the new set!\n")
save(missing,file="525TermsMissingIn2592.Rda")

# Save mappings to file
save(match525,match2592,file="nsynth2ca.Rda")