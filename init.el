
;;(toggle-debug-on-error)

(global-unset-key (kbd "<left>"))
(global-unset-key (kbd "<right>"))
(global-unset-key (kbd "<up>"))
(global-unset-key (kbd "<down>"))
(global-unset-key (kbd "<C-left>"))
(global-unset-key (kbd "<C-right>"))
(global-unset-key (kbd "<C-up>"))
(global-unset-key (kbd "<C-down>"))
(global-unset-key (kbd "<M-left>"))
(global-unset-key (kbd "<M-right>"))
(global-unset-key (kbd "<M-up>"))
(global-unset-key (kbd "<M-down>"))

;; Scroll "other" window by doing M-up and M-down (because the default C-M-S v gets swallowed by iterm2)
(define-key global-map [(meta up)] '(lambda() (interactive) (scroll-other-window -1)))
(define-key global-map [(meta down)] '(lambda() (interactive) (scroll-other-window 1)))
 
;; Melpa package manager https://melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)


;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`/;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)


;;;;;;;;;;;;;;;;;
;; Use-package
(defun install-use-package ()
  (unless (package-installed-p 'use-package)
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))
  (eval-when-compile (require 'use-package)))
(install-use-package)
(eval-when-compile
  (require 'use-package))

  ;;;;;;;;;;;;;;;;;;;
  ;; which-key
  (use-package which-key
  :ensure t
  :config
  (which-key-mode))

;; In Org mode, don't allow invisible edits in collapsed regions.
;; Why would they even enable that.
(setq-default org-catch-invisible-edits 'smart)

;; Smooth in-place scrolling with C-<up> and C-<down>
(defun scroll-down-in-place (n)
  (interactive "p")
  (previous-line n)
  (scroll-down n))

(defun scroll-up-in-place (n)
  (interactive "p")
  (next-line n)
  (scroll-up n))

(global-set-key [mouse-4] 'scroll-down-in-place)
(global-set-key [mouse-5] 'scroll-up-in-place)
(global-set-key [C-up] 'scroll-down-in-place)
(global-set-key [C-down] 'scroll-up-in-place)

 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "gray20" :foreground "white smoke" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 230 :width condensed :foundry "nil" :family "Monaco")))))
  
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes '(tango-dark)))

;; Load config from other files.
;; Stolen from https://github.com/wkirschbaum
(defun setup-custom-config (config-path)

  (setq custom-file (concat config-path "custom.el"))
  (if (file-exists-p custom-file)
      (load custom-file)))

(let ((config-path "~/.emacs.d/"))
  (setup-custom-config config-path))

(defvar will/modules)
(setq will/modules
      '(
        "native"
       ))

(let ((config-path "~/.emacs.d/modules/"))
  (dolist (module will/modules)
    (condition-case err
        (load (concat "~/.emacs.d/modules/" module ".el"))
      (error (display-warning "%s" (error-message-string err))))))
