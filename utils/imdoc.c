#include <stdio.h>
#include <string.h>
#include <locale.h>
#include <libgen.h>
#include <m17n.h>

struct CommentList
{
  char line[256];
  struct CommentList *next;
};

void
invalid_file (char *filename)
{
  fprintf (stderr, "Invalid input method file: %s\n", filename);
  exit (1);
}

int
main (int argc, char **argv)
{
  char *file;
  MPlist *plist;
  MSymbol language, name;
  MText *mt;
  FILE *fp;
  char buf[256];
  struct CommentList *head_comment = NULL, *cur_comment = NULL;
  MSymbol Minput_method, Mutf8;

  setlocale (LC_ALL, "");
  M17N_INIT ();
  Minput_method = msymbol ("input-method");
  Mutf8 = msymbol ("utf-8");

  if (argc < 2)
    {
      fprintf (stderr, "Usage: imdoc FILE\n");
      exit (1);
    }
  fp = fopen (argv[1], "r");
  if (! fp)
    {
      fprintf (stderr, "Usage: imdoc FILE\n");
      exit (1);
    }
  while (fgets (buf, 256, fp)
	 && buf[0] != '(')
    {
      if (buf[0] == ';' && buf[1] == ';' && buf[2] == ';')
	{
	  if (! head_comment)
	    {
	      cur_comment = head_comment = alloca (sizeof (struct CommentList));
	    }
	  else
	    {
	      cur_comment->next = alloca (sizeof (struct CommentList));
	      cur_comment = cur_comment->next;
	    }
	  strcpy (cur_comment->line, buf + 4);
	  cur_comment->next = NULL;
	}
    }
  if (! buf[0])
    invalid_file (argv[1]);
  mt = mtext_from_data (buf, strlen (buf), MTEXT_FORMAT_US_ASCII);
  plist = mplist_deserialize (mt);
  m17n_object_unref (mt);
  if (! plist)
    invalid_file (argv[1]);
  plist = mplist_value (plist);
  if (mplist_value (plist) != Minput_method)
    invalid_file (argv[1]);
  plist = mplist_next (plist);
  language = mplist_value (plist);
  plist = mplist_next (plist);
  name = mplist_value (plist);
  plist = mplist_next (plist);
  if (mplist_key (plist) != Mnil)
    language = mplist_value (plist), name = Mnil;
  m17n_object_unref (plist);

  file = basename (strdup (argv[1]));

  if (name != Mnil)
    {
      MPlist *plist;

      printf ("*/\n/***ja\n<li> %s (language:", file);
      if (language == Mt)
	printf ("generic name:%s", msymbol_name (name));
      else
	printf ("%s name:%s", msymbol_name (language), msymbol_name (name));
      printf (")*/\n/***en\n<li> %s (language:", file);
      if (language == Mt)
	printf ("generic name:%s", msymbol_name (name));
      else
	printf ("%s name:%s", msymbol_name (language), msymbol_name (name));
      plist = minput_get_title_icon (language, name);
      if (plist)
	{
	  MText *title = mplist_value (plist);
	  
	  printf ("@htmlonly\n title:\"");
	  plist = mplist_next (plist);
	  mconv_encode_stream (Mutf8, title, stdout);
	  printf ("\"");
	  if (mplist_key (plist) != Mnil)
	    {
	      MText *icon = mplist_value (plist);
	      char *iconfile = mtext_data (icon, MTEXT_FORMAT_US_ASCII,
					   NULL, NULL, NULL);
	      char *base;
	      char cmd[1024];

	      base = basename (strdup (iconfile));
	      sprintf (cmd, "convert -resize 50%% %s images/icon-%s",
		       iconfile, base);
	      system (cmd);
	      printf (" icon:<img src=\"icon-%s\" border=\"1\" style=\"vertical-align:middle;\">\n", base);
	    }
	  else
	    printf (" icon:none\n");
	  printf ("@endhtmlonly\n");
	}
      printf (")*/\n/***\n");
    }
  else
    printf ("<li> %s (extra-name:%s, only for inclusion)\n", file,
	    msymbol_name (name));

  mt = minput_get_description (language, name);
  if (! mt)
    {
      printf ("Not yet officially released.\n");
      exit (0);
    }
  else if (head_comment)
    {
      for (; head_comment; head_comment = head_comment->next)
	{
	  char *p = head_comment->line;

	  if (p[0] == '|' && p[1] == '|')
	    printf ("<tr><td align=\"center\">"), p += 2;
	  while (*p)
	    {
	      if (p[0] == '|')
		{
		  if (p[1] == '|')
		    printf ("</td></tr>"), p += 2;
		  else
		    printf ("</td><td align=\"center\">"), p++;
		}
	      else
		putchar (*p), p++;
	    }
	}
    }
  else
    {
      int len = mtext_len (mt), i, c;
      
      for (i = 0; i < len; i++)
	{
	  c = mtext_ref_char (mt, i);
	  if (c >= 0x100)
	    break;
	}
      if (i < len)
	printf ("@htmlonly\n<div class=\"fragment\"><pre class=\"fragment\">\n");
      else
	printf ("@verbatim\n");
      mconv_encode_stream (Mutf8, mt, stdout);
      if (mtext_ref_char (mt, mtext_len (mt) - 1) != '\n')
	printf ("\n");
      if (i < len)
	{
	  MConverter *converter = mconv_stream_converter (Mutf8, stdout);
	  int from;

	  printf ("</pre></div><p>\n@endhtmlonly\n");
	  printf ("@latexonly\n\\begin{verbatim}\n");
	  if (i > 0)
	    mconv_encode_range (converter, mt, 0, i);
	  for (from = i; i < len; i++)
	    {
	      c = mtext_ref_char (mt, i);
	      if (c >= 0x100)
		{
		  if (i > from)
		    mconv_encode_range (converter, mt, from, i);
		  printf ("U+%04X", c);
		  from = i + 1;
		}
	    }
	  if (i > from)
	    mconv_encode_range (converter, mt, from, i);
	  printf ("\\end{verbatim}\n@endlatexonly\n");
	  mconv_free_converter (converter);
	}
      else
	printf ("@endverbatim\n");
    }

  M17N_FINI ();
  exit (0);
}
