(setq make-backup-files nil)
(set-frame-font "consolas 16")
(menu-bar-mode -1)
(tool-bar-mode -1)
(setq ring-bell-function 'ignore)
(setq make-backup-files nil)

(require 'package)

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("gnu-devel" . "https://elpa.gnu.org/devel/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))

(when (< emacs-major-version 27)
  (package-initialize))

(load-theme 'gruber-darker :no-confirm)

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
(dashboard-setup-startup-hook)

(electric-pair-mode t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(org-modern org-bulletproof which-key treesit-auto tree-sitter spacemacs-theme solarized-theme org-bullets monokai-theme monokai-pro-theme lsp-ui gruber-darker-theme dracula-theme dashboard dap-mode company catppuccin-theme atom-one-dark-theme atom-dark-theme)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
