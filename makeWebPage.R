# Generate web interface

# This script will generate the mapping.js file for the web page to search for a term that is mapped between neurosynth and the Cognitive Atlas.

# Read in the data
load("nsynth2ca.Rda")

outfile = "js/mapping.js"
sink(outfile)
cat("$(function(){\n  var mappings = [\n")

# For each term, print javascript object
# We will do the database with 2592, since it's larger
# Yes this is a lame way to do it :)
for (t in 1:nrow(match2592)){
  cat("{ value: '",match2592[t,"prefLabel"],"', atlas: '",match2592[t,"url"],"' },\n",sep="")
}
cat("  ];\n// setup autocomplete function pulling from mappings[] array\n")
cat("$('#autocomplete').autocomplete({\nlookup: mappings,\nonSelect: function (term) {\nvar thehtml = '<strong>Term Name:</strong> ' + term.value + '<br><br><div id=\"column\"><p>Go <a href=\"http://neurosynth.org/features/' + term.value + '/\" target=\"_blank\">to Neurosynth page</a></p></div><div id=\"column\"><p>Go <a href=\"' + term.atlas +'\" target=\"_blank\">to Cognitive Atlas page</a></p></div>';\n$('#outputcontent').html(thehtml);\n}\n});\n});")
sink()