#! /usr/bin/ruby

buf = [] 
doxy = 0

def commentblock(buf)
    unless buf == []	
      print "/** "	
      buf.each do |i| print i end
      print "*/\n"	
    end	
   end	

while gets

  gsub!("@seealso", "@par 参照:")
  gsub!("@errors", "@par エラー:")
  gsub!("@returns", "@par 戻り値:")
  gsub!("@return", "@par 戻り値:")
 #let doxygen find functions
  gsub!(/[a-zA-Z_]\s\(\)/) {|m| m.delete!(" ")}
 #make variables in function descriptions shown in bold
  gsub!(/\$[A-Z_]+/) {|m| m.delete!("$").reverse.downcase!.concat(" b@").reverse}

   case  $_
     when /^\s*$/
	if doxy == 1 
           buf.push($_)
	   end
     when /\/\/\/\// 
    	commentblock(buf)
    	buf = []
   
     when /\/\*\s.*\*\//	# /* comment */ type comment
	if doxy == 1		
	buf.push($_.gsub!(/\*\//, " ").gsub!(/\/\*/, "//")) # should be included only in the example code
	else
          if doxy == 0 
    	  commentblock(buf)
    	  buf = []
	  print $_.gsub!(/\/\*\s.*\*\//," ")	            # should be omiited in code
	  end
	end
     when /\/\*{2,3}en.*\*\//	#english one liner is omitted
     when /\/\*\*ja.*\*\//	#one liner
     when /\/\*\*\*ja.*\*\//	#one liner
        buf.push($_.gsub!(/\/\*+ja/, " ").gsub!(/\*\//, " "))
     when /\/\*\*\s.*\*\//	#one liner
     when /\/\*\*\*\s.*\*\//	#one liner
        buf.push($_.gsub!(/\/\*+/, " ").gsub!(/\*\//, " ")).push("\n")

     when /\/\*{1,2}\s|\/\*{2,3}en|\/\*\*ja/  #this is not for Ja nor users
	doxy = -1
     when /\/\*\*\*ja/
        buf.push($_.gsub!(/\/\*+ja/, " "))
	doxy = 1
     when /\/\*\*\*/	
        buf.push($_.gsub!(/\/\*+/, " "))
	doxy = 1

     when /EXAMPLE_CODE/ 
        buf.push($_.gsub!(/#if EXAMPLE_CODE/, "\n \n @par 例： \n @code"))
	doxy = 1

     when /#endif/
	if doxy == 1
           buf.push($_.gsub!(/#endif/, "@endcode"))
	else
           commentblock(buf)
    	   buf = []
	   print $_
	end
        doxy = 0
     when /\*\//
	if doxy == 1
           buf.push($_.gsub!(/\*\//, " "))
	end
        doxy = 0
     else 
	case doxy 
	  when -1
  	  when 1	
           buf.push($_) 
	  else 
       	   commentblock(buf)
    	   buf = []
	   print($_)
        end
   end
end

commentblock(buf)

# Local Variables:
# coding: euc-jp
# End: