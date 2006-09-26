#include <stdio.h>
#include <string.h>
#include <locale.h>
#include <m17n.h>

int
main (int argc, char **argv)
{
  char *file;
  MPlist *plist;
  MSymbol language, name;
  MText *mt;

  setlocale (LC_ALL, "");
  M17N_INIT ();

  if (argc < 3)
    {
      fprintf (stderr, "Usage: imdoc FILE (input-method LANG NAME [EXTRA])\n");
      exit (1);
    }
  file = argv[1];
  mt = mtext_from_data (argv[2], strlen (argv[2]), MTEXT_FORMAT_US_ASCII);
  plist = mplist_deserialize (mt);
  m17n_object_unref (mt);
  plist = mplist_value (plist);
  plist = mplist_next (plist);
  language = mplist_value (plist);
  plist = mplist_next (plist);
  name = mplist_value (plist);
  plist = mplist_next (plist);
  if (mplist_key (plist) != Mnil)
    language = mplist_value (plist), name = Mnil;
  m17n_object_unref (plist);
  mt = minput_get_description (language, name);
  if (! mt)
    {
      fprintf (stderr, "Invalid IM name: %s %s\n", argv[1] ,argv[2]);
      exit (1);
    }
#if 0
  if (argc < 5)
    {
      if (language == Mt)
	printf ("<li> %s (language:generic name:%s)\n", file, argv[3]);
      else
	printf ("<li> %s (language:%s name:%s)\n", file, argv[2], argv[3]);
    }
  else
    printf ("<li> %s (extra-name:%s, only for inclusion)\n", file, argv[4]);
#endif
  printf ("@verbatim\n");
  mconv_encode_stream (msymbol ("utf-8"), mt, stdout);
  printf ("\n@endverbatim\n");

  M17N_FINI ();
  exit (0);
}
