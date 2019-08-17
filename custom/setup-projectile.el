;; projectile custom settings

(setq projectile-keymap-prefix (kbd "C-c C-p"))

(use-package projectile
  :diminish projectile-mode
  :init
  (setq projectile-keymap-prefix (kbd "C-c C-p"))
  :config
  (projectile-global-mode))

(setq projectile-project-search-path '("~/ws/"))

(provide 'setup-projectile)
