BEGIN {
  print "/***";
}

/".*\.(mim|flt|fst|tbl)"/ {
  FROM=match($0, "\".*\\.(mim|flt|fst|tbl)\"") + 1;
  LEN=RLENGTH-2;
  FILE=substr($0, FROM, LEN);
  DIR=FILENAME;
  gsub("/[^/]*$", "", DIR)
  system("utils/dbdata.sh "DIR" "FILE);
  printf "\n";
}

/^;;;/ {
  print substr($0, 5);
}

END {
  print "*/";
}
