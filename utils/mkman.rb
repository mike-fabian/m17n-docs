#! /usr/local/bin/ruby
#実行すると/tmp/doxymanをつかってファイルを分け、
#もとのdirectoryにかきなおす。
# see also の中身を woman 向けに書き換える。

usr_dev_ja=$1

currentdir = Dir.pwd
doxywork = currentdir+"doxywork"+usr_dev_ja+"man3"
doxyman3 = currentdir+usr_dev_ja+"man/man3"
doxyman3m = currentdir+usr_dev_ja+"man/man3m"

headertexts = open("doxyhead.txt","r").readlines
 $fdheader = headertexts[0]
 $flheader = headertexts[1]
 $ddheader = headertexts[2]
 $fielddheader = headertexts[3]
 $fieldlheader = headertexts[4]

####  to find data structure documentation files and rewriting them 

def writeuntilsectionheader(buf, text, index)
      for line in text[index .. text.size] 
          if line =~ /^.S(H|S)/ 
             return
          end 
          buf.push(line)
     end
 end

def  writedocumentation(buf, text, index)
      for line in text[index .. text.size] 
          if line =~ /^.SH/ 
             return
          end 
           if 
               line =~ /^.SS\s"(.+)"/
               buf.push(".PP\n\\fB".concat($1).concat("\\fP\n"))
               else
               buf.push(line)
            end
      end
 end


def datastructure(struct)

   text = open(struct.concat(".3"),"r").readlines

   buf = []

#  title
    if tline = text.index("\.SH NAME\n")
     if text[tline+1] =~ /^([\w\s]+)\s\\-\s(.+)$/ 
        buf.push(".SS ".concat($1).concat("\n"))
        buf.push(".PP\n")
        buf.push($2.concat("\n"))
        nl = tline + 2
        writeuntilsectionheader(buf, text, nl)
     else
        if 
        text[tline+1] =~ /^([\w\s]+)\s\\-/ 
        buf.push(".SS ".concat($1).concat("\n"))
        buf.push(".PP\n")
        else
        buf.push(text[tline+1])
        buf.push(".PP\n")   
        end
     end
    end

     if ddline = text.index(text.find{|i| i = $ddheader})
       nl = ddline + 1 
       writeuntilsectionheader(buf, text, nl)
   end

# public types
    if ptline = text.index("\.SS \"Public Types\"\n")
       buf.push("\\fBPublic Types:\\fP\n")
       nl = ptline + 1 
       writeuntilsectionheader(buf, text, nl)
       buf.push(".PP\n")
   end

# member enumeration documentation
   if medline = text.index("\.SH \"MEMBER ENUMERATION DOCUMENTATION\"\n")
      buf.push("\.PP\n\\fBMEMBER ENUMERATION DOCUMENTATION:\\fP\n")
       nl = medline + 1 
       writedocumentation(buf, text, nl)
   end

# data fields
    if dfline = text.index($fieldlheader)
       buf.push("\\fBData Fields:\\fP\n")
       nl = dfline + 1 
       writeuntilsectionheader(buf, text, nl)
       buf.push(".PP\n")
   end

# field documentation
   if fdline = text.index($fielddheader)
      buf.push("\.PP\n\\fBFIELD DOCUMENTATION:\\fP\n")
       nl = fdline + 1 
       writedocumentation(buf, text, nl)
   end

return buf
end

###############################
### ファイル分け

def documentfunc(title, func_text, short_text)
  func_text.grep(/^\.SS/){|i| 
 #自分より後ろだけ
      func_rest =  func_text[func_text.index(i)..func_text.size] 
      documentfunc2(i, title, func_rest, short_text)}
end

def documentfunc2 (dstart, title, func_text, short_text)
 #func_textの最初の行中の関数名
   dstart =~ /\s([a-z_]+)\s\(/
   return if $1 == nil
   fname = $1
   ffname = "\\fB".concat($1.concat("\\fP"))
 #short_textの関数名の２行後がbrief。
   brief =  short_text[short_text.index(short_text.find{|i| i.index(ffname)}) + 2]
 #関数ごとのファイルを作る。
   file = open(doxywork+fname+".3", "w")
   file.puts("@function")
 #ヘッダ
   /^\.TH \"([^"]*)\"\s/ =~ title
   oname = $1
   newtitle = title.gsub(oname, fname.chop.chop)
   file.puts(newtitle)
 #@brief
   file.print("@brief ") 
   if /^.RI/ =~ brief 
      file.puts(brief) 
     else file.print("\n") 
   end
 #ロング
   file.puts(func_text[0])
   for line in func_text[1 .. func_text.size]
     break if /.SS/ =~ line
     file.puts(line)
   end  
   file.flush
   end

####rewriting each man file
### rewriting a man file for a function

def frewrite(text)
# let the library name appear in the header 
  buf = [text[0].gsub!("\" \"", "\" \"\" \"")]

  title =  text[0].split(" ")[1].chop!.reverse.chop!.reverse

  if text.index("\\fBReturns: \\fP\n")  == nil
   print  title, ": Returns not described\n" 
   end  
  if text.index("\\fBErrors: \\fP\n")  == nil
   print  title, ": Errors not described\n" 
   end

  buf.push(".ad l\n.nh\n.SH NAME\n")
#  if @brief is given  
  if text[1] =~ /\"\\fI(.+)\\fP\"/
     buf.push(title.concat(" \- ").concat($1))
     else buf.push(title)
  end

  synopsys = text.find{|line| line =~ /\.SS/} 
  buf.push("\n\n.SH SYNOPSIS").push(formatsynopsys(synopsys)).push("\n")

  description = text[text.index(synopsys)+2..text.size]
  if 
    description == []
    print title, ": No description found\n"
    else
    buf.push("\n.SH DESCRIPTION\n").push(womanrewrite(desrewrite(description)))
  end
 return buf
end

####synopsys section of a function

def formatsynopsys(line)
  line.chop!.chop!.reverse!.chop!.chop!.chop!.chop!.chop!.reverse!

#  line.gsub!(/\\fP\s*/,"\n.ft\n")
#  line.gsub!(/\\fB/,"\n.ft B\n")

  line.gsub!(/\s(\w*)\)/){"\n\\fI" << $1 << "\\fP)"}
  line.gsub!(/\s(\w*),/){"\n\\fI" << $1 << "\\fP,"}
  line.gsub!(/\s(\w*)\s\(/){"\n\\fB" << $1 << "\\fP ("}
end

####non-synopsys section of a function

def desrewrite(text)

#removing identation
  text.grep(/^\\fB.+\\fP/){|line| 
                     ind = text.index(line)
                     text.delete_at(ind+1)  if text[ind+1] == (".in +1c\n")}


  text.each_with_index{|line,i|

#removing "More..."  hyperlink
  line.gsub!(/More.../,"")
# ? ad hoc 
  line.gsub!(/^\.TP/,"")

#headers
  line.gsub!(/^\\fBReturn value:\\fP/,"\n.SH RETURNS\n.PP")
  line.gsub!(/^\\fBSee Also:\\fP/,"\n.SH \"SEE ALSO\"\n.PP")
  line.gsub!(/^\\fBErrors:\\fP/,"\n.SH ERRORS\n.PP")

  line.gsub!(/^\\fB(.+)\\fP/){"\n.SS " << $1}

#removing indentation
 if text[i - 1] =~ /^.PP/
    if line =~ /^\s./
   line.reverse!.chop!.reverse!
  end
 end

# removing the results of doxygen bug 
# \fP required for . , ; and <> 
   line.gsub!(/\s*(\\fP)+\s*(,|\.|;)\s+/){"\\fP" << $2 << "\n.ft R\n"}

   line.gsub!(/(\\fP)+\s*>/,"\\fP>")
   line.gsub!(/<\s+\\f(P|I|B|C|)/){"<\\f" << $1}


   line.gsub!(/\s*(\\fP)+\s+/,"\n.ft R\n")

   line.gsub!(/\s+\\f(I|C)\\fB\s*/,"\n.ft B\n")
   line.gsub!(/\s+\\f(B|I)\\fC\s*/,"\n.ft C\n")
   line.gsub!(/\s+\\f(B|C)\\fI\s*/,"\n.ft I\n")
   line.gsub!(/\s+\\fB\s*/,"\n.ft B\n")
   line.gsub!(/\s+\\fC\s*/,"\n.ft C\n")
   line.gsub!(/\s+\\fI\s*/,"\n.ft I\n")

  }

return text
end

def womanrewrite(text)

  if sasectionstart  = text.index(text.find{|line| line =~ /^\.SH\s"SEE ALSO"/})
     aftersasection = text[sasectionstart+1 .. text.size]
    if sasectionend = aftersasection.index(aftersasection.find{|line| line =~ /^\.SH/})
        for line in text[sasectionstart+1 .. sasectionend + sasectionstart]
            line.gsub!(/(\w*)\\fP\(\)/){ $1 << "(3)\\fP"}
        end
      else
        for line in text[sasectionstart+1 .. text.size]
            line.gsub!(/(\w*)\\fP\(\)/){ $1 << "(3)\\fP"}
       end
     end
  end
  return text
end

# rewriting a man file for a non-function

def orewrite(text)
  buf = []
  structures = ["\.SH \"Data Structure Documentation\"\n"]

  if ddind = text.index($ddheader)
     if odind = text.index(text.find{|line| line =~ /\.SH\s+.+\s+DOCUMENTATION/})
    unless
     text[ddind+1 .. odind-1].find{|line| line =~ /^[^\.]/}  
     text = text[0 .. ddind-1] + text[odind .. text.size] 
  end  end  end

  text.each_with_index{|line,i|
             line.gsub!(/More.../,"")

     # let the library name appear in the header 
              if line =~ /^.TH/
                 line = line.gsub!("\" \"", "\" \"\" \"")
     	      end

     # finding structure documentations and merging into "structures"
             if line =~ /^\.RI\s\"struct\s\\fB(.*)\\fP\"/
                structures.push(datastructure($1))
             end

     #removing indentation
      	     if text[i - 1] =~ /^.PP/
              if line =~ /^\s./
               line.reverse!.chop!.reverse!
               end
             end

     #removing extra "-"
             if text[i - 1] =~ /^.SH\sNAME/
                if line =~ /\\-/
	          unless line =~ /\\-\s./
                  line.chop!.chop!.chop!.chop!
                  end
               end
             end

     #removing author section
             line.gsub!(/^\.SH\s\"AUTHOR\"/,"")
             line.gsub!("Generated automatically by Doxygen for m17n_test from the source code.","")

             line.gsub!(/\\fP\s+,/,"\\fP,")
             line.gsub!(/\\fP\s+\./,"\\fP.")
             line.gsub!(/\\fC\\fB(\w+)\\fP\\fP/){"\\fB" << $1 << "\\fP"}

      buf.push(line)
  }

  unless structures == ["\.SH \"Data Structure Documentation\"\n"]
  
  if dindex = buf.index(buf.find{|line| line =~ /\.SH\s+.+\s+DOCUMENTATION/i})
     buf = buf[0 .. dindex-1] + structures + buf[dindex .. buf.size]
     else 
     buf = buf + structures
   end
  end 

 return buf
end

#############################dividing files

Dir.mkdir "doxywork/man3" unless FileTest.directory? "doxywork/man3"
Dir.mkdir "man" unless FileTest.directory? "man"
Dir.mkdir "man/man3m" unless FileTest.directory? "man/man3m"

Dir.chdir("usr/man/man3")

Dir.open(".").each{|filename|
     if FileTest.directory? filename 
	next
     end   

     if filename =~ /\.c\./
        next
     end   

     file = open(filename,"r") 
     text = file.readlines
     title = text[0]

   if
      sfunctionstart = text.index(text.find{|i| i == $flheader})
        if sfunctionend = text.index(text[sfunctionstart+1 .. text.size].find{|i| i =~ /^\.SS|^\.SH/})
        short_text = text[sfunctionstart .. sfunctionend - 1] 
       else
        short_text = text[sfunctionstart .. text.size - 1] 
       end

   if lfunctionstart = text.index(text.find{|i| i == $fdheader})
      if lfunctionend = text.index(text[lfunctionstart+1 .. text.size].find{|i| i =~ /^\.SH/})
         func_text = text[lfunctionstart .. lfunctionend - 1] 
         group_text = text[0 .. lfunctionstart - 1] + text[lfunctionend ..text.size]
       else 
         func_text = text[lfunctionstart .. text.size]
         group_text = text[0 .. lfunctionstart - 1]
      end
      else 
       func_text = [] 
       group_text = text  
   end

   documentfunc(title, func_text, short_text)

  else
  
  group_text = text
  
  end
   
  filetowrite = open("../../../doxywork/man3/".concat(filename),"w")
  print "filetowrite=", filetowrite
  filetowrite.puts(group_text)
  filetowrite.flush
}

Dir.chdir(currentdir)
#############################rewriting files

Dir.chdir("doxywork/man3")

Dir.open(".").each{|filename|
unless FileTest.directory? filename

   print "PROCESSING: ", filename, "\n"

    file = open(filename,"r") 
    text = file.readlines

 if /@function/ =~ text[0]  
    buf = frewrite(text[1..text.size])
    else buf = orewrite(text)
 end

  filetowrite = open("../../man/man3m/".concat(filename).concat("m"),"w")
  filetowrite.puts(buf)
  filetowrite.flush

end
}


# Dir.chdir("/tmp/doxyman")

# Dir.open(".").each{|f|  File.delete(f) if FileTest.file?(f)}
