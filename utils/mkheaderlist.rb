#! /usr/bin/ruby

def nextheader(text,index)
  header = text[index+1..text.size].find{|i| i =~ /\.S(S|H)/} 
  return header
  end

grouptext = open("SampleGroup.3","r").readlines.reverse

fd = grouptext.index(grouptext.find{|i| i =~ /SampleFunction/})
fdheader = nextheader(grouptext,fd)

restofthetext =  grouptext[fd+1..grouptext.size]

fl = restofthetext.index(restofthetext.find{|i| i =~ /SampleFunction/})
flheader = nextheader(restofthetext,fl)

dd = grouptext.index(grouptext.find{|i| i =~ /long group document/})
ddheader = nextheader(grouptext,dd)

####
structext = open("SampleStructure.3","r").readlines.reverse

fieldd = structext.index(structext.find{|i| i =~ /SampleField/})
fielddheader = nextheader(structext,fieldd)

restofstructext =  structext[fieldd+1..structext.size]

fieldl = restofstructext.index(restofstructext.find{|i| i =~ /SampleField/})
fieldlheader = nextheader(restofstructext, fieldl)

print fdheader, flheader, ddheader, fielddheader, fieldlheader
