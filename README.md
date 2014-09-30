# NeuroSynth 2 Cognitive Atlas Mapping

This small package will start with the all_concepts.rda file from the Cognitive Atlas, and do the following:

- parse the rdf into an R data object (.Rda)
- map Cognitive Atlas terms to NeuroSynth terms
- output a .js file for a web interface to link the two

http://www.vbmis.com/bmi/nsynth2ca

### rdf2rda
Converts rdf to rda

### nsynth2ca.R
Maps NeuroSynth to the Cognitive Atlas.  As NeuroSynth only has single word terms, all Cognitive Atlas terms with greater than 1 term are eliminated, and the rest matched by exact match.  This could easily be changed to include more sophisticated matching algorithms.

### makeWebPage.R
Create the mapping.js file for the web page, which allows the user to search for a matched term, and then navigate to either page.  This could also be modified to include more information about the term, however it seems redundant given the direct link to the sources.

