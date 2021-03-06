;; package  --- summary
;;; Commentary:

(require 'package)
;;; code:
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;; Enable defer and ensure by default for use-package

(add-to-list 'exec-path "/usr/local/bin" t)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(unless (package-installed-p 'projectile)
  (package-refresh-contents)
  (package-install 'projectile))
(unless (package-installed-p 'counsel-projectile)
  (package-refresh-contents)
  (package-install 'counsel-projectile))

(use-package projectile
:ensure t
:config
(projectile-mode)
(setq projectile-completion-system 'ivy))
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(projectile-mode +1)

(use-package counsel-projectile
:ensure t
:config
(counsel-projectile-mode))




(unless (package-installed-p 'hungry-delete)
  (package-refresh-contents)
  (package-install 'hungry-delete))

(use-package hungry-delete
  :ensure t
  :config
  (global-hungry-delete-mode))

(unless (package-installed-p 'expand-region)
  (package-refresh-contents)
  (package-install 'expand-region))
(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))


(unless (package-installed-p 'neotree)
  (package-refresh-contents)
  (package-install 'neotree))

;; (defun neotree-project-dir ()
;;     "Open NeoTree using the git root."
;;     (interactive)
;;     (let ((project-dir (projectile-project-root))
;;           (file-name (buffer-file-name)))
;;       (neotree-toggle)
;;       (if project-dir
;;           (if (neo-global--window-exists-p)
;;               (progn
;;                 (neotree-dir project-dir)
;;                 (neotree-find file-name)))
;;         (message "Could not find git project root."))))


(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(setq neo-smart-open t)

;;(unless (package-installed-p 'find-file-in-project)
;;  (package-refresh-contents)
;;  (package-install 'find-file-in-project))

;; (global-set-key (kbd "M-p") 'find-file-in-project)
(global-set-key (kbd "H-p") 'projectile-find-file)
(global-set-key (kbd "M-p") 'projectile-find-file)


(unless (package-installed-p 'magit)
  (package-refresh-contents)
  (package-install 'magit))

;; magit 
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x C-n") 'neotree-toggle)
(global-set-key (kbd "H-n") 'neotree-toggle)
;; (global-set-key (kbd "H-x H-n") 'neotree-project-dir) 

(unless (package-installed-p 'all-the-icons)
  (package-refresh-contents)
  (package-install 'all-the-icons))

(setq inhibit-compacting-font-caches t)
(use-package all-the-icons :defer 0.5)


;;(unless (package-installed-p 'smex)
;;  (package-refresh-contents)
;;  (package-install 'smex))




(unless (package-installed-p 'company-lsp)
  (package-refresh-contents)
  (package-install 'company-lsp))

(use-package company-lsp)

(add-hook 'after-init-hook 'global-company-mode)


(unless (package-installed-p 'eglot)
  (package-refresh-contents)
  (package-install 'eglot))
;; 
;; Scala SetUP
;; 
;; Add melpa-stable to your packages repositories
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; Enable defer and ensure by default for use-package
(setq use-package-always-defer t
      use-package-always-ensure t)

;; Enable scala-mode and sbt-mode
(use-package scala-mode
  :mode "\\.s\\(cala\\|bt\\)$")

(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
  ;; allows using SPACE when in the minibuffer
  (substitute-key-definition
   'minibuffer-complete-word
   'self-insert-command
   minibuffer-local-completion-map))

(use-package eglot
  ;; :pin melpa-stable
  ;; (optional) Automatically start metals for Scala files.
  :config
  (add-to-list 'eglot-server-programs '(scala-mode . ("metals-emacs")))
  :hook (scala-mode . eglot-ensure))

(global-set-key (kbd "C-c h") 'eglot-help-at-point)
(global-set-key (kbd "C-c C-r") 'xref-find-definitions-other-window)
(global-set-key (kbd "C-c r") 'xref-find-definitions)

;;(define-key eglot-mode-map (kbd "C-c h") 'eglot-help-at-point)
;; (define-key eglot-mode-map (kbd "<f6>") 'xref-find-definitions)

;; Add melpa to your packages repositories
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(setq use-package-always-defer t
      use-package-always-ensure t)

;; (use-package scala-mode
;;   :mode "\\.s\\(cala\\|bt\\)$")

;; (use-package sbt-mode
;;   :commands sbt-start sbt-command
;;   :config
;;   (substitute-key-definition
;;    'minibuffer-complete-word
;;    'self-insert-command
;;    minibuffer-local-completion-map))

 (use-package flycheck
   :init (global-flycheck-mode))

;; (use-package lsp-mode)


;; (use-package lsp-ui
;;   :hook (lsp-mode . lsp-ui-mode))

;; (use-package lsp-scala
;;   :load-path "~/source/other/lsp-scala"
;;   :after scala-mode
;;   :demand t
;;   :hook (scala-mode . lsp))

;; 
;; 
;; 

;;  (use-package vscode-icon
;;  :ensure t
;;  :commands (vscode-icon-for-file))
(unless (package-installed-p 'dumb-jump)
  (package-refresh-contents)
  (package-install 'dumb-jump))

(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
	 ("M-g j" . dumb-jump-go)
	 ("M-g x" . dumb-jump-go-prefer-external)
	 ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
  :ensure)
;; (global-set-key (kbd "H-f") 'dumb-jump-go)
(global-set-key (kbd "M-g b") 'dumb-jump-back)
(dumb-jump-mode)
;; Reload file automatically if changed on disk
  (global-auto-revert-mode 1)


(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
    (interactive) (revert-buffer t t))

(unless (package-installed-p 'which-key)
  (use-package which-key
  :ensure t
  :init
  (which-key-mode)))
(which-key-mode)
(which-key-setup-side-window-right-bottom)
(setq ido-enable-flex-matching t)
(setq id-everywhere t)
(ido-mode 1)



;; (defalias 'list-buffers 'ibuffer)
;; windowing config
(winner-mode 1)

;; Shift and arrow keys to move cursor
(windmove-default-keybindings)
(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))


(setq ns-function-modifier 'hyper)  ; make Fn key do Hyper
(setq w32-apps-modifier 'hyper)
(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    ))


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
(global-set-key (kbd "<f5>") 'revert-buffer)
;;(global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "M-X") 'smex-major-mode-commands)
;;(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


(global-linum-mode t)
(setq scroll-conservatively 100)
(setq ring-bell-function 'ignore)
(setq make-backup-file nil)
(setq auto-save-default nil)
(when window-system (global-hl-line-mode t))
(when window-system (global-prettify-symbols-mode t))

;; (menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq inhibit-startup-message t)
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
 '(eglot-auto-display-help-buffer t)
 '(eglot-connect-timeout 10)
 '(eglot-sync-connect nil)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (counsel-projectile projectile expand-region hungry-delete find-file-in-project elpa-find-file-in-project magit all-the-icons smex vscode-icon dired-sidebar helm company-lsp lsp-ui lsp-mode ace-window markdown-mode scala-mode beacon moe-theme which-theme which-key use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
