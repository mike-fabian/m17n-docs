/***en
    @mainpage The m17n library documentation

    @section sect2 What is the m17n library?

    The @e m17n @e library is a multilingual text processing library
    for the C language.  m17n is an abbreviation of
    Multilingualization.

    <ul>
    <li>m17n-lib is an open source software.

    <li>m17n-lib is for any Linux/Unix  applications.

    <li>m17n-lib realizes multilingualization of many aspects of applications.
 
    <li>m17n-lib represents multilingual text as an object named
    M-text. M-text is a string with attributes called text properties,
    and designed to substitute for string in C.  Text properties carry
    information required to input, display and edit the  text.

    <li>m17n-lib supports functions to handle M-texts.

    </ul> 


    The @e m17n @e library provides following facilities to handle
    multilingual text.

    <ul>
    <li> @e M-text: A data structure for multilingual text objects.

    <li> Functions for creating and processing M-texts.

    <li> Decoders and encoders for converting M-texts from/to strings
    encoded in various existing formats.

    <li> A huge character space, which contains all the Unicode
    characters and more non-Unicode characters.

    <li> @e Chartable: A data structure that contains per-character
    information effectively.

    <li> Functions for inputting and displaying M-text.
    </ul>

    @section sect1  Why Multilingual? Why Library?

    Multilingualization in software refers to a form of
    internationalization,  where many kinds of cultural conventions,
    such as languages and scripts, can be used simultaneously on the
    software.  In order to share information in the whole world, we
    need a computer environment where support for every language is
    equally easy.

    Currently software developers tend to design and implement
    multilingual facilities on their own,  even though their software
    do not focus on multilingualization or text handling  itself. They
    indeed need strings or text in user interface, but it is
    peripheral at most.  Mozilla, Perl, and Ruby are good
    examples. This situation is waste of time and effort.

    Multilingualization in most software is peripheral, that is,
    multilingual facilities can be isolated from  other (main) parts
    of the software.  At the same time, most software has common
    requirement for their multilingual interfaces. A library that
    fulfils  those requirement can be used from various
    applications and will make software  development more efficient
    and inexpensive.

    @section contact Contact us:

    Global IT Security Group<br>  
    Information¡¡Technology Research Institute<br>  
    Institute of¡¡Advanced Industrial Science and Technology<br>

    E-mail:Mule-aist@m17n.org 

*/
////
