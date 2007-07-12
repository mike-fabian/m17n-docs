BEGIN {
  print "/***";
}

/"LANGUAGE.tbl"/ {
  DIR=FILENAME;
  gsub("/[^/]*$", "", DIR)
  system("utils/dbdata.sh "DIR"/LANGDATA LANGUAGE.tbl");
  printf "\n";
  next;
}

/".*\.(fst|tbl)"/ {
  FROM=match($0, "\".*\\.(mim|flt|fst|tbl)\"") + 1;
  LEN=RLENGTH-2;
  FILE=substr($0, FROM, LEN);
  DIR=FILENAME;
  gsub("/[^/]*$", "", DIR)
  system("utils/dbdata.sh "DIR" "FILE);
  printf "\n";
  next;
}

/".*\.mim"/ {
  FROM=match($0, "\".*\\.mim\"") + 1;
  LEN=RLENGTH-2;
  FILE=substr($0, FROM, LEN);
  DIR=FILENAME;
  gsub("/[^/]*$", "", DIR)
  system("utils/dbdata.sh "DIR"/MIM "FILE);
  printf "\n";
  next;
}

/".*\.flt"/ {
  FROM=match($0, "\".*\\.flt\"") + 1;
  LEN=RLENGTH-2;
  FILE=substr($0, FROM, LEN);
  DIR=FILENAME;
  gsub("/[^/]*$", "", DIR)
  system("utils/dbdata.sh "DIR"/FLT "FILE);
  printf "\n";
  next;
}

/^;;;/ {
  print substr($0, 5);
}

END {
  print "*/";
}
