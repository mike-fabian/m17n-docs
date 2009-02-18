BEGIN {
    SUBDIR["input-method-*"] = "MIM/";
    SUBDIR["font-layouter-*"] = "FLT/";
    SUBDIR["language-name-*"] = "LANGDATA/";
    SUBDIR["standard-language-iso639"] = "LANGDATA/";
    KEY="";
    XINCLUDEFMT="<xi:include xmlns:xi=\"http://www.w3.org/2001/XInclude\" parse=\"xml\" href=\"%s\"/>\n";
}

/^<item / {
    match($0, "key0=\"[^\"]*");
    KEY = substr($0, RSTART + 6, RLENGTH - 6);
    for (i = 1; i < 4 && match($0, sprintf("key%d=\"[^\"]*", i)) > 0; i++)
	KEY=KEY"-"substr($0, RSTART + 6, RLENGTH - 6);
    print;
    next;
}

/<filename>[^<]*<\/filename>/ {
    from = match($0, "<filename>[^<]*</filename>");
    to = from + RLENGTH;
    printf "%s", substr($0, 1, from - 1);
    TAIL = substr($0, to);
    FILE = substr($0, from + 10, to - from - 21);
    COMMAND = "cd "M17NDB"/"SUBDIR[KEY]"; ls "FILE;
    COMMAND | getline LINE;
    print "<filename>"LINE"</filename>";
    printf XINCLUDEFMT, M17NDB"/"SUBDIR[KEY]LINE;
    while (COMMAND | getline LINE) {
	print "<filename>"LINE"</filename>";
	printf XINCLUDEFMT, M17NDB"/"SUBDIR[KEY]LINE;
    }
    if (length(TAIL) > 0 && ! match(TAIL, "^[ \t]*$"))
	print TAIL;
    next;
}

{
    print;
}
