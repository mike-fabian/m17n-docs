(require 'un-define)

(defconst latex-dir
  (format "%s/latex" (nth 2 command-line-args-left)))

(defun parse-toc ()
  (let ((sections nil)
	section-type
	title pos current-section current-subsection)
    (save-excursion
      (find-file (expand-file-name "refman.toc" latex-dir))
      (while (re-search-forward "{\\(sub\\)*section}" nil t)
	(goto-char (1+ (match-beginning 0)))
	(setq section-type (intern (buffer-substring
				    (1+ (match-beginning 0))
				    (1- (match-end 0)))))
	(re-search-forward "{[0-9.]+}")
	(setq title (buffer-substring (1+ (match-beginning 0))
				      (1- (match-end 0))))
	(narrow-to-region (point) (line-end-position))
	(goto-char (point-max))
	(forward-sexp -1)
	(forward-char -1)
	(setq title
	      (concat title " " (buffer-substring (point-min) (point))))
	(widen)
	(let (idx)
	  (while (setq idx (string-match "\\\\discretionary {-}{}{}" title))
	    (setq title (concat (substring title 0 idx)
				(substring title (match-end 0))))))
	(re-search-forward "[0-9]+")
	(setq page (string-to-int (match-string 0)))
	(cond ((eq section-type 'section)
	       (setq current-section (list title page)) 
	       (setq sections
		     (nconc sections (list current-section)))
	       (setq current-subsection nil current-subsubsection nil))
	      ((eq section-type 'subsection)
	       (setq current-subsection (list title page))
	       (setq current-section
		     (nconc current-section (list current-subsection)))
	       (setq current-subsubsection nil))
	      (t
	       (setq current-subsubsection (list title page))
	       (setq current-subsection
		     (nconc current-subsection (list current-subsubsection)))
	       )))
      sections)))

(defun insert-one-line (elt)
  (insert
   (format "[ /Count %d /Page %d/View [/XYZ null null 1.0]/Title ("
	   (length (nthcdr 2 elt)) (+ (nth 1 elt) 4)))
  (let* ((str (encode-coding-string (car elt) 'utf-16-be-dos))
	 (len (length str))
	 (i 0))
    (while (< i len)
      (insert (format "\\%03o" (aref str i)))
      (setq i (1+ i))))
  (insert ") /OUT pdfmark\n"))

(defun write-mokuji ()
  (let ((l (parse-toc)) elt)
    (with-temp-file (expand-file-name "mokuji.ps" latex-dir)
      (set-buffer-multibyte nil)
      (insert "%!PS-Adobe 3.0
%%BeginProlog
/bd {bind def} bind def /fsd {findfont exch scalefont def} bd /sms {setfont moveto show} bd /ms {moveto show} bd systemdict /pdfmark known not {userdict /pdfmark systemdict /cleartomark get put } if
%%EndProlog
%%BeginSetup
")
      (while l
	(setq elt (car l) l (cdr l))
	(insert-one-line elt)
	(let ((ll (nthcdr 2 elt)) ee)
	  (while ll
	    (setq ee (car ll) ll (cdr ll))
	    (insert-one-line ee)
	    (let ((lll (nthcdr 2 ee)) eee)
	      (while lll
		(setq eee (car lll) lll (cdr lll))
		(insert-one-line eee))))))
      (insert "%%EOF\n"))))
