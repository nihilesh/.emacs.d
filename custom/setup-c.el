
(use-package cc-mode
  :init
  (define-key c-mode-map  [(tab)] 'company-complete)
  (define-key c++-mode-map  [(tab)] 'company-complete))

;; hs-minor-mode for folding source code
(add-hook 'c-mode-common-hook 'hs-minor-mode)

;; To enable C++ header files in C++ mode
(require 'cl)

;; To enable Tacc files in C++ mode
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.tac\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.tin\\'" . c++-mode))

;; Set Fallback mode to C++ for include folder files
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


;;;;;; Style and Editing
(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (other . "linux"))
      c-basic-offset 4) ;; set style to "linux"

;; Folding
(set-default 'semantic-case-fold t)
(require 'semantic/bovine/c)
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;;;; company complete
;; function-args
(use-package function-args
  :init
  (fa-config-default)
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

;;;; Source Lookup - TAGS/CSCOPE

;; semantic settings
;;(semantic-add-system-include "~/ws/tacc/")
;;(semantic-add-system-include "/Library/Developer/CommandLineTools/usr/include/c++/v1")
;;(add-to-list 'semantic-lex-c-preprocessor-symbol-file
;;             "/usr/local/Cellar/gcc/8.3.0_2/lib/gcc/8/gcc/x86_64-apple-darwin18/8.3.0/include/stddef.h")


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
