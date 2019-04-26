(require 'package)
(add-to-list 'package-archives
         '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-general)
(require 'setup-helm)
(require 'setup-helm-gtags)
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)
(require 'setup-c)
(require 'setup-python)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(custom-enabled-themes (quote (manoj-dark)))
 '(custom-safe-themes
   (quote
    ("8329191fba7b72c4d4523ec01bf06cf206d3020d543eb475808f7f980bd3a55e" "47ec21abaa6642fefec1b7ace282221574c2dd7ef7715c099af5629926eb4fd7" default)))
 '(frame-brackground-mode (quote dark))
 '(package-selected-packages
   (quote
    (py-autopep8 material-theme flycheck elpy ein better-defaults sr-speedbar function-args company-c-headers gruber-darker-theme zygospore helm-gtags helm yasnippet ws-butler volatile-highlights use-package undo-tree iedit dtrt-indent counsel-projectile company clean-aindent-mode anzu))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bold ((t (:weight ultra-bold))))
 '(cursor ((t nil)))
 '(error ((t (:foreground "color-196" :weight bold))))
 '(escape-glyph ((t (:foreground "brightwhite"))))
 '(header-line ((t (:inherit (mode-line default)))))
 '(helm-M-x-key ((t (:foreground "brightwhite" :underline t))))
 '(helm-action ((t (:inherit nil))))
 '(helm-buffer-not-saved ((t (:foreground "color-46"))))
 '(helm-buffer-process ((t (:foreground "color-46"))))
 '(helm-candidate-number ((t (:inherit nil))))
 '(helm-candidate-number-suspended ((t (:inherit helm-candidate-number))))
 '(helm-etags-file ((t (:foreground "brightwhite" :underline t))))
 '(helm-ff-socket ((t (:foreground "brightwhite"))))
 '(helm-grep-file ((t (:foreground "brightwhite" :underline t))))
 '(helm-history-remote ((t (:foreground "white"))))
 '(helm-lisp-completion-info ((t (:foreground "color-45"))))
 '(helm-lisp-show-completion ((t (:background "color-46"))))
 '(helm-minibuffer-prompt ((t (:inherit default))))
 '(helm-selection ((t (:background "yellow" :distant-foreground "white"))))
 '(helm-selection-line ((t (:inherit highlight))))
 '(helm-separator ((t nil)))
 '(helm-visible-mark ((t nil)))
 '(highlight ((t nil)))
 '(isearch ((t (:background "palevioletred2" :foreground "brightwhite"))))
 '(line-number ((t (:inherit default))))
 '(line-number-current-line ((t (:inherit nil))))
 '(minibuffer-prompt ((t (:foreground "white"))))
 '(mode-line ((t (:background "yellow" :box (:line-width 1 :style released-button)))))
 '(mode-line-highlight ((t (:box (:line-width 2 :color "color-243" :style released-button)))))
 '(nobreak-hyphen ((t (:foreground "brightgreen"))))
 '(tool-bar ((t (:foreground "color-46" :box (:line-width 1 :style released-button)))))
 '(tty-menu-selected-face ((t nil)))
 '(window-divider ((t nil)))
 '(window-divider-first-pixel ((t nil))))
