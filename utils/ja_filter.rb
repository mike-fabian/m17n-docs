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
  gsub!(/[a-z_]\s\(\)/) {|m| m.delete!(" ")}
 #make variables in function descriptions shown in bold
  gsub!(/\$[A-Z_]+/) {|m| m.delete!("$").reverse.downcase!.concat(" e@").reverse}

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
     when /\/\*{2,3}en.*\*\//	#english one liner is omitted
     when /\/\*{2,3}ja.*\*\//	#one liner
        buf.push($_.gsub!(/\/\*+ja/, " ").gsub!(/\*\//, " "))
     when /\/\*{2,3}.*\*\//	#one liner
        buf.push($_.gsub!(/\/\*+/, " ").gsub!(/\*\//, " "))

     when /\/\*\s|\/\*{2,3}en/
	doxy = -1
     when /\/\*{2,3}ja/
        buf.push($_.gsub!(/\/\*+ja/, " "))
	doxy = 1
     when /\/\*{2,3}/	
        buf.push($_.gsub!(/\/\*+/, " "))
	doxy = 1

     when /EXAMPLE_CODE/ 
        buf.push($_.gsub!(/#if EXAMPLE_CODE/, "@par 例： \n @code \n"))
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
