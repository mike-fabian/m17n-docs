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

  gsub!("@seealso", "@par See Also:")
  gsub!("@errors", "@par Errors:")
  gsub!("@returns", "@par Return value:")
  gsub!("@return", "@par Return value:")
 #let doxygen find functions
  gsub!(/[a-zA-Z_]\s\(\)/) {|m| m.delete!(" ")}
 #make variables in function descriptions shown in bold
  gsub!(/\$[A-Z_]+/) {|m| m.delete!("$").reverse.downcase!.concat(" b@").reverse}

   case  $_
     when /^$/
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
     when /\/\*{2,3}ja.*\*\//	#japanese one liner
     when /\/\*\*en.*\*\//	#one liner
     when /\/\*\*\*en.*\*\//	#one liner
        buf.push($_.gsub!(/\/\*+en/, " ").gsub!(/\*\//, " ")).push("\n")
     when /\/\*\*\s.*\*\//	#one liner
     when /\/\*\*\*\s.*\*\//	#one liner
        buf.push($_.gsub!(/\/\*+/, " ").gsub!(/\*\//, " ")).push("\n")

     when /\/\*{1,2}\s|\/\*{2,3}ja|\/\*\*en/
	doxy = -1
     when /\/\*\*\*en/
        buf.push($_.gsub!(/\/\*+en/, " "))
	doxy = 1
     when /\/\*\*\*/	
        buf.push($_.gsub!(/\/\*+/, " "))
	doxy = 1

     when /EXAMPLE_CODE/ 
        buf.push($_.gsub!(/#if EXAMPLE_CODE/, "@code \n"))
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
