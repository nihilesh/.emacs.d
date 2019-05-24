
;; hs-minor-mode for folding source code
(add-hook 'c-mode-common-hook 'hs-minor-mode)

;; Available C style:
;; “gnu”: The default style for GNU projects
;; “k&r”: What Kernighan and Ritchie, the authors of C used in their book
;; “bsd”: What BSD developers use, aka “Allman style” after Eric Allman.
;; “whitesmith”: Popularized by the examples that came with Whitesmiths C, an early commercial C compiler.
;; “stroustrup”: What Stroustrup, the author of C++ used in his book
;; “ellemtel”: Popular C++ coding standards as defined by “Programming in C++, Rules and Recommendations,” Erik Nyquist and Mats Henricson, Ellemtel
;; “linux”: What the Linux developers use for kernel development
;; “python”: What Python developers use for extension modules
;; “java”: The default style for java-mode (see below)
;; “user”: When you want to define your own style
(setq c-default-style "linux") ;; set style to "linux"

(use-package cc-mode
  :init
  (define-key c-mode-map  [(tab)] 'company-complete)
  (define-key c++-mode-map  [(tab)] 'company-complete))

;; Compilation
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))

;; setup GDB
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

;; company complete


;; function-args
(use-package function-args
  :init
  (fa-config-default)
  (define-key c-mode-map  [(tab)] 'company-complete)
  (define-key c++-mode-map  [(tab)] 'company-complete))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.tac\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.tin\\'" . c++-mode))

;; To enable C++ header files in C++ mode
(require 'cl)

(defun file-in-directory-list-p (file dirlist)
  "Returns true if the file specified is contained within one of
the directories in the list. The directories must also exist."
  (let ((dirs (mapcar 'expand-file-name dirlist))
        (filedir (expand-file-name (file-name-directory file))))
    (and
     (file-directory-p filedir)
     (member-if (lambda (x) ; Check directory prefix matches
                  (string-match (substring x 0 (min(length filedir) (length x))) filedir))
                dirs))))

(defun buffer-standard-include-p ()
  "Returns true if the current buffer is contained within one of
the directories in the INCLUDE environment variable."
  (and (getenv "INCLUDE")
       (file-in-directory-list-p buffer-file-name (split-string (getenv "INCLUDE") path-separator))))

(add-to-list 'magic-fallback-mode-alist '(buffer-standard-include-p . c++-mode))



;; Folding
(set-default 'semantic-case-fold t)
(semantic-add-system-include "~/ws/Tac/")
(semantic-add-system-include "/Library/Developer/CommandLineTools/usr/include/c++/v1")
(require 'semantic/bovine/c)
(add-to-list 'semantic-lex-c-preprocessor-symbol-file
             "/usr/local/Cellar/gcc/8.3.0_2/lib/gcc/8/gcc/x86_64-apple-darwin18/8.3.0/include/stddef.h")
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;;sr-speedbar - tree
(use-package sr-speedbar)
;;set sr-speedbar widow font smaller
(make-face 'speedbar-face)
(set-face-font 'speedbar-face "Inconsolata-12")
(setq speedbar-mode-hook '(lambda () (buffer-face-set 'speedbar-face)))
(setq sr-speedbar-skip-other-window-p t)

;; (defun ad-advised-definition-p (definition)
;;   "Return non-nil if DEFINITION was generated from advice information."
;;   (if (or (ad-lambda-p definition)
;;           (macrop definition)
;;           (ad-compiled-p definition))
;;       (let ((docstring (ad-docstring definition)))
;;         (and (stringp docstring)
;;              (get-text-property 0 'dynamic-docstring-function docstring)))))

;; (def advice delete-other-windows (after my-sr-speedbar-delete-other-window-advice activate)
;;   "Check whether we are in speedbar, if it is, jump to next window."
;;   (let ()
;; 	(when (and (sr-speedbar-window-exist-p sr-speedbar-window)
;;                (eq sr-speedbar-window (selected-window)))
;;       (other-window 1)
;;       )))
;; (ad-enable-advice 'delete-other-windows 'after 'my-sr-speedbar-delete-other-window-advice)
;; (ad-activate 'delete-other-windows)

;; keep scrollbar window size after resize
;; (with-current-buffer sr-speedbar-buffer-name
;;   (setq window-size-fixed 'width))

(defun select-next-window ()
  (other-window 1))

;; select previous window for sr-scrollbar
(defun my-sr-speedbar-open-hook ()
  (add-hook 'speedbar-before-visiting-file-hook 'select-next-window t)
  (add-hook 'speedbar-before-visiting-tag-hook 'select-next-window t)
  )

(advice-add 'sr-speedbar-open :after #'my-sr-speedbar-open-hook)


(provide 'setup-c)
