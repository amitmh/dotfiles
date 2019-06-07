(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
;; Enable defer and ensure by default for use-package

(add-to-list 'exec-path "/usr/local/bin" t)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(unless (package-installed-p 'smex)
  (package-refresh-contents)
  (package-install 'smex))

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

(use-package vscode-icon
  :ensure t
  :commands (vscode-icon-for-file))

(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))
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
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


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
    (smex vscode-icon dired-sidebar helm company-lsp lsp-ui lsp-mode ace-window markdown-mode scala-mode beacon moe-theme which-theme which-key use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
