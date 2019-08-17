(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq create-lockfiles nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(xterm-mouse-mode)
(global-linum-mode t)
(setq linum-format "%4d \u2502 ")
(setq comment-set-column t)
(setq column-number-mode t)
(setq x-select-enable-primary t)
(setq x-select-enable-clipboard nil)
(setq select-enable-primary t)
(setq select-enable-clipboard  nil)
(setq save-interprogram-paste-before-kill t)
(setq x-select-enable-clipboard-manager t)
(delete-selection-mode 1)

(global-set-key (kbd "<mouse-2>") 'x-clipboard-yank)
(global-set-key (kbd "<mouse-2>") 'clipboard-yank)

(defun scroll-up-1-lines ()
  "Scroll up 1 lines"
  (interactive)
  (scroll-up 1))

(defun scroll-down-1-lines ()
  "Scroll down 1 lines"
  (interactive)
  (scroll-down 1))

(global-set-key (kbd "<mouse-4>") 'scroll-down-1-lines) ;
(global-set-key (kbd "<mouse-5>") 'scroll-up-1-lines) ;

(global-set-key (kbd "C-c o") 'iedit-mode)

(setq gc-cons-threshold 100000000)
(setq inhibit-startup-message t)

(defalias 'yes-or-no-p 'y-or-n-p)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook
          (lambda () (interactive)
            (setq show-trailing-whitespace 1)))

;; use space to indent by default
(setq-default indent-tabs-mode nil)

;; set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 4)

;; Package zygospore
(use-package zygospore
  :bind (("C-x 1" . zygospore-toggle-delete-other-windows)
         ("RET" .   newline-and-indent)))
  ; automatically indent when press RET

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)
(windmove-default-keybindings)

(add-hook 'after-init-hook 'global-company-mode)

;; Which key assistance, courtesy: http://bnbeckwith.com/bnb-emacs/
(use-package which-key
  :ensure t
  :diminish which-key-mode
  :init
  (which-key-mode)
  (which-key-setup-side-window-right-bottom)
  (setq which-key-max-description-length 60))

(defvar display-buffer-same-window-commands
  '(occur-mode-goto-occurrence compile-goto-error))

(add-to-list 'display-buffer-alist
             '((lambda (&rest _)
                 (memq this-command display-buffer-same-window-commands))
               (display-buffer-reuse-window
                display-buffer-same-window)
               (inhibit-same-window . nil)))

(provide 'setup-general)
