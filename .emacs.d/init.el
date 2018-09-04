(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'which-key)
  (use-package which-key
  :ensure t
  :init
  (which-key-mode)))

(unless (package-installed-p 'beacon)
  (use-package beacon
  :ensure t
  :init
  (beacon-mode 1)))

(unless (package-installed-p 'moe-theme)
  (package-refresh-contents)
  (package-install 'moe-theme))

(defvar my-term-shell "/bin/bash")
(defadvice ansi-term (before force-bash)
  (interactive (list my-term-shell)))
(ad-activate 'ansi-term)
(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "<M-return>") 'ansi-term)

(global-linum-mode t)
(setq scroll-conservatively 100)
(setq ring-bell-function 'ignore)
(setq make-backup-file nil)
(setq auto-save-default nil)
(when window-system (global-hl-line-mode t))
(when window-system (global-prettify-symbols-mode t))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-startup-message t)


;; themes
(require 'moe-theme)
(moe-dark)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (moe-dark)))
 '(custom-safe-themes
   (quote
    ("26d49386a2036df7ccbe802a06a759031e4455f07bda559dcf221f53e8850e69" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (beacon moe-theme which-theme which-key use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
