BEGIN {
  filtering = 1;
}

/^.section/ {
  printf "%s",text;
  text=$0"\n";
  next;
}

/^.input{files}/ {
  text="";
  next;
}

/^.printindex/ {
  filtering = 0;
  print "\\input{conclusion.tex}"
}

{
  if (filtering)
    text=text$0"\n";
  else
    print;
}
