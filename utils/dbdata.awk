BEGIN {
  print "/***";
}

/".*\.(tbl|mim|tab|flt)"/ {
  FROM=match($0, "\".*\.(tbl|mim|tab|flt)\"") + 1;
  LEN=RLENGTH-2;
  FILE=substr($0, FROM, LEN);
  system("sed -n '/^[;#][;#]* <li>/,/^$/s/^[;#][;#]* *//p' "FILE);
  printf "\n";
}

/^;; / {
  print substr($0, 4);
}

END {
  print "*/";
}
