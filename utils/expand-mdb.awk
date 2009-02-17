BEGIN {
    SUBDIR["input-method-*"] = "MIM/";
    SUBDIR["font-layouter-*"] = "FLT/";
    SUBDIR["language-name-*"] = "LANGDATA/";
    SUBDIR["standard-language-iso639"] = "LANGDATA/";
    KEY="";
}

/^<item / {
    match($0, "key0=\"[^\"]*");
    KEY=substr($0, RSTART + 6, RLENGTH - 6);
    if (match($0, "key1=\"[^\"]*") > 0) {
	KEY = sprintf("%s-%s", KEY, substr($0, RSTART + 6, RLENGTH - 6));
	if (match($0, "key2=\"[^\"]*") > 0)
	    KEY = sprintf("%s-%s", KEY, substr($0, RSTART + 6, RLENGTH - 6));
    }
    print;
    next;
}

/<filename>[^<]*<\/filename>/ {
    from = match($0, "<filename>");
    HEAD = substr($0, 1, from - 1)
    if (length(HEAD) > 1 && ! match(HEAD, "^[ \t]*$"))
	printf "%s\n", substr($0, 1, from - 1);
    to = match($0, "<\/filename>");
    TAIL = substr($0, to + RLENGTH);
    FILE = sprintf("%s%s", SUBDIR[KEY], substr($0, from+10, to - (from+10)));
    system(sprintf("ls %s/%s | sed -f %s", M17NDB, FILE, SEDFILE));
    if (length(TAIL) > 0 && ! match(TAIL, "^[ \t]*$"))
	print TAIL;
    next;
}

{
    print;
}
