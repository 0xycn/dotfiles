(setq make-backup-files nil)
(set-frame-font "JetBrainsMono Nerd Font-16")
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq ring-bell-function 'ignore)
(setq make-backup-files nil)
(scroll-bar-mode -1)

(require 'package)

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("gnu-devel" . "https://elpa.gnu.org/devel/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))

(when (< emacs-major-version 27)
  (package-initialize))

(load-theme 'catppuccin :no-confirm)

(add-hook 'c++-mode-hook 'display-line-numbers-mode)
(add-hook 'c-mode-hook 'display-line-numbers-mode)
(setq linum-format "%3d ")

(setq c-default-style "linux")
(defun my-c-mode-hook ()
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4))

(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

(setq split-width-threshold nil)

(set-frame-parameter nil 'alpha-background 100)
(add-to-list 'default-frame-alist '(alpha-background . 100))

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(defun compile-c-program ()
  (interactive)
  (defvar foo)
  (if (eq system-type 'gnu/linux)
      (setq foo (concat "sh compile.sh"))
    )
    (if (eq system-type 'windows-nt)
      (setq foo (concat "compile.bat"))
    )
  
  (shell-command foo))
 
(global-set-key [C-f1] 'compile-c-program)
(global-set-key (kbd "C-,") 'duplicate-line)

(require 'dashboard)
(setq dashboard-startup-banner "~/.emacs.d/banner.jpg")

(setq dashboard-items nil)

(dashboard-setup-startup-hook)

(electric-pair-mode t)

(require 'company)

(setq company-idle-delay 0.1
      company-minimum-prefix-length 1
      company-tooltip-align-annotations t)

(global-company-mode 1)

(require 'eglot)

;; Start eglot automatically for C and C++
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7fea145741b3ca719ae45e6533ad1f49b2a43bf199d9afaee5b6135fd9e6f9b8"
     "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5"
     "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1"
     "d5fd482fcb0fe42e849caba275a01d4925e422963d1cd165565b31d3f4189c87"
     default))
 '(package-selected-packages
   '(## catppuccin-theme company dashboard dracula-theme
	gruber-darker-theme gruvbox-theme ini-mode lua-mode
	minimal-theme modus-themes org-bullets solarized-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
