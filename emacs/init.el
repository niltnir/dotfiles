;;;; PACKAGE INSTALLATION
(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d6b05f096d6504aaa0018481dae6fcc9edad1c0658b3f584ea4958edc91714cf" "47a28206b7e6f354732d889b2076caa2a8639f4f558882fec46ba838b66dbed3" default))
 '(package-selected-packages
   '(evil-collection lispyville lispy format-all workgroups2 dashboard airline-themes centaur-tabs linum-relative aggressive-indent origami diminish dtrt-indent color-theme-approximate color-theme-modern helm-projectile projectile helm tide flycheck yasnippet markdown-mode eglot company undo-fu xclip clipetty evil-escape magit evil-commentary evil-surround evil-leader evil cmake-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip ((t (:background "#161E24" :foreground "lightblue4"))))
 '(company-tooltip-annotation ((t (:foreground "#ECFF87"))))
 '(company-tooltip-common ((t (:weight bold :foreground "#1CDDF1"))))
 '(company-tooltip-scrollbar-thumb ((t (:background "lightblue4"))))
 '(company-tooltip-scrollbar-track ((t (:background "#273742"))))
 '(company-tooltip-selection ((t (:background "#273742" :foreground "lightblue4")))))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

;;;; THEME
;;; Replace-Colorthemes
(add-to-list 'custom-theme-load-path (file-name-as-directory "~/.emacs.d/replace-colorthemes"))
(load-theme 'blue-sea t t)
(enable-theme 'blue-sea)

;;; Face Customizations
;; Check M-x list-face-display for more...
;; Emacs Basics
(set-face-foreground 'completions-common-part "turquoise")
(set-face-foreground 'italic "turquoise")
(set-face-foreground 'link "turquoise")
(set-face-foreground 'shadow "lightblue4")

;; Custom-Mode
(add-hook 'custom-mode (lambda ()
			 (set-face-foreground 'custom-variable-tag "turquoise")))

;; EShell
(setq eshell-prompt-function (lambda nil (concat
					  (propertize (eshell/pwd) 'face '(:foreground "cyan"))
					  (propertize " $ " 'face '(:foreground "#AAE9E9")))))
(setq eshell-highlight-prompt nil)

;; Prog-Mode
(set-face-foreground 'error "peachpuff")
(set-face-foreground 'warning "#ECFF87")
(set-face-foreground 'font-lock-warning-face "#ECFF87")
(set-face-foreground 'font-lock-comment-face "lightblue4")
(set-face-italic 'font-lock-comment-face t)
(set-face-foreground 'font-lock-keyword-face "#1CDDF1")
(set-face-italic 'font-lock-function-name-face t)
(set-face-foreground 'font-lock-variable-name-face "turquoise")
(set-face-italic 'font-lock-variable-name-face t)
(set-face-foreground 'font-lock-string-face "#F975FF")
(set-face-italic 'font-lock-string-face t)

;; Region Selection
(set-face-foreground 'highlight "#080808")
(set-face-background 'highlight "#ECFF87")
(set-face-foreground 'isearch "#080808")
(set-face-background 'isearch "#ECFF87")
(set-face-foreground 'region "#080808")
(set-face-background 'region "#ECFF87")

;; Main BG and Frame
(set-face-background 'default "#080808")
(defun set-background-for-terminal (&optional frame)
  (or frame (setq frame (selected-frame)))
  "unsets the background color in terminal mode"
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))
(add-hook 'after-make-frame-functions 'set-background-for-terminal)
(add-hook 'window-setup-hook 'set-background-for-terminal)
(set-face-foreground 'default "#AAE9E9")

(face-spec-set 'vertical-border
	       '((t (:foreground "#080808" :background "#080808"))) 'face-defface-spec)

;;;; BASIC CONFIG
;;; Suppress 'Package cl is deprecated' warning
(setq byte-compile-warnings '(cl-functions))

;;; Suppress 'bytecomp' warning
(defun dont-delay-compile-warnings (fun type &rest args)
  (if (eq type 'bytecomp)
      (let ((after-init-time t))
        (apply fun type args))
    (apply fun type args)))
(advice-add 'display-warning :around #'dont-delay-compile-warnings)

;;; Don't make backup files:
(setq make-backup-files nil)

;;; Remember the cursor position of files when reopening them:
(setq save-place-file "~/.emacs.d/saveplace")
(save-place-mode 1)

;;; Show matching parens:
(show-paren-mode t)

;;; Visual line mode:
(global-visual-line-mode 1)

;;; Prettify-symbols-mode:
(global-prettify-symbols-mode 1)

;;; Auto line break after 80 chars for markdown and text:
(add-hook 'text-mode-hook (lambda ()
                            (turn-on-auto-fill)
                            (set-fill-column 80)))
(add-hook 'markdown-mode-hook (lambda ()
				(turn-on-auto-fill)
				(set-face-foreground 'markdown-header-face "#1CDDF1")
				(set-fill-column 80)))

;;; Line break after 94 chars for Python and C:
(add-hook 'python-mode-hook (lambda ()
                              (set-fill-column 94)))
(add-hook 'c-mode-hook (lambda ()
                         (set-fill-column 94)))

;;; Remove default line number modes:
(linum-mode 0)
(line-number-mode 0)

;;; Kill dired-mode buffer after selecting a file:
(eval-after-load "dired"
  (lambda ()
    (put 'dired-find-alternate-file 'disabled nil)
    (define-key dired-mode-map (kbd "RET") #'dired-find-alternate-file)))

;;; Prefer to split the view horizontally instead of vertically:
(setq
 split-height-threshold 4
 split-width-threshold 40
 split-window-preferred-function 'split-window-really-sensibly)

(defun split-window-really-sensibly (&optional window)
  (let ((window (or window (selected-window))))
    (if (> (window-total-width window) (* 2 (window-total-height window)))
        (with-selected-window window (split-window-sensibly-prefer-horizontal window))
      (with-selected-window window (split-window-sensibly window)))))

(defun split-window-sensibly-prefer-horizontal (&optional window)
  "Based on split-window-sensibly, but designed to prefer a horizontal split,
i.e. windows tiled side-by-side."
  (let ((window (or window (selected-window))))
    (or (and (window-splittable-p window t)
             ;; Split window horizontally
             (with-selected-window window
               (split-window-right)))
	(and (window-splittable-p window)
             ;; Split window vertically
             (with-selected-window window
               (split-window-below)))
	(and
         ;; If WINDOW is the only usable window on its frame (it is
         ;; the only one or, not being the only one, all the other
         ;; ones are dedicated) and is not the minibuffer window, try
         ;; to split it horizontally disregarding the value of
         ;; `split-height-threshold'.
         (let ((frame (window-frame window)))
           (or
            (eq window (frame-root-window frame))
            (catch 'done
              (walk-window-tree (lambda (w)
                                  (unless (or (eq w window)
                                              (window-dedicated-p w))
                                    (throw 'done nil)))
                                frame)
              t)))
	 (not (window-minibuffer-p window))
	 (let ((split-width-threshold 0))
	   (when (window-splittable-p window t)
             (with-selected-window window
               (split-window-right))))))))

;;; Open scratch buffer:
(defun open-scratch-buffer ()
  "Open a scratch buffer."
  (interactive)
  (switch-to-buffer-other-window (get-buffer "*scratch*")))

;;;; GUI MODE
(setq use-dialog-box nil)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;;;; PACKAGES
;;; SLIME
(load (expand-file-name "~/.quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")
;; Load Slime automatically in Lisp buffers
(add-hook 'lisp-mode-hook
	  '(lambda () (unless (get-process "SLIME Lisp")
			(let ((oldbuff (current-buffer)))
			  (slime)
			  (slime-mode 1)
			  (pop-to-buffer-same-window oldbuff)
			  (delete-windows-on "*scratch*")
			  (delete-windows-on "*dashboard*")
			  (sit-for 0.5)
			  (windmove-left)
			  ))))
;; Kill Slime sessions automatically when Lisp buffers close
(add-hook 'kill-buffer-hook
	  '(lambda () (when (derived-mode-p 'lisp-mode)
			(kill-slime))))
(defun kill-slime ()
  (interactive)
  (when (slime-connected-p)
    (slime-quit-lisp)
    (slime-disconnect))
  (slime-kill-all-buffers))
(set-face-foreground 'slime-repl-inputed-output-face "#1CDDF1")

(setq evil-want-keybinding nil)

;;; EVIL-COLLECTION
(use-package evil-collection
  :ensure
  :after evil
  :config
  (setq evil-collection-init '(dired sbcl)))

;;; EVIL-LEADER
(use-package evil-leader
  :ensure
  :after evil
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "m"))

;;; EVIL-SURROUND
(use-package evil-surround
  :ensure
  :after evil
  :config
  (global-evil-surround-mode 1))

;;; EVIL-ESCAPE
(use-package evil-escape
  :ensure
  :after evil
  :config
  (setq-default evil-escape-key-sequence "jk")
  (evil-escape-mode 1))

;;; EVIL-COMMENTARY
(use-package evil-commentary
  :ensure
  :after evil
  :config
  (evil-commentary-mode)
  (evil-define-key 'normal evil-commentary-mode-map
    (kbd "g r") 'evil-commentary))

;;; EVIL
(use-package evil
  :ensure
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
  (setq evil-move-cursor-back nil)
  (setq evil-move-beyond-eol t))

;;; PROJECTILE
(use-package projectile
  :ensure
  :config
  (projectile-mode 1))

;;; UNDO-FU
(use-package undo-fu
  :ensure
  :config
  (evil-set-undo-system 'undo-fu))

;;; CLIPETTY
(use-package clipetty
  :ensure
  :config
  (global-clipetty-mode))

;;; XCLIP
(use-package xclip
  :ensure
  :config
  ;; For some reason, this interferes with the behaviour of evil :q
  (xclip-mode 1))

;;; YASNIPPET
(use-package yasnippet
  :ensure
  :config
  (yas-global-mode 1))

;;; WORKGROUPS2
;; Change prefix key (before activating WG)
;; Use M-x wg-create-workgroup to save save window&buffer layout as a work group.
;; Use M-x wg-open-workgroup to open an existing work group.
;;  Use M-x wg-kill-workgroup to delete an existing work group.
(use-package workgroups2
  :config
  (setq wg-prefix-key "C-c z")
  (setq wg-session-file "~/.emacs.d/.emacs_workgroups")
  (workgroups-mode 1))

;;; CENTAUR-TABS
(use-package centaur-tabs
  :ensure
  :config
  (setq centaur-tabs-set-close-button nil)
  (setq centaur-tabs-show-new-tab-button nil)
  (setq centaur-tabs-set-modified-marker t)
  (setq centaur-tabs-cycle-scope 'tabs)
  (centaur-tabs-mode t)
  ;; Face Customizations
  (face-spec-set 'centaur-tabs-selected
	         '((t (:background "#1CDDF1" :foreground "#080808")))
	         'face-defface-spec)
  (face-spec-set 'centaur-tabs-selected-modified
  	         '((t (:background "#1CDDF1" :foreground "#080808")))
	         'face-defface-spec)
  (face-spec-set 'centaur-tabs-unselected
	         '((t (:background "#080808" :foreground "#1CDDF1")))
	         'face-defface-spec)
  (face-spec-set 'centaur-tabs-unselected-modified
	         '((t (:background "#080808" :foreground "#1CDDF1")))
	         'face-defface-spec)
  (face-spec-set 'centaur-tabs-default
	         '((t (:background "#080808" :foreground "#1CDDF1")))
	         'face-defface-spec)
  (centaur-tabs-headline-match)
  (add-hook 'dired-mode-hook 'centaur-tabs-local-mode))

(defun centaur-tabs-hide-tab (x)
  "Do no to show buffer X in tabs."
  (let ((name (format "%s" x)))
    (or
     ;; Current window is not dedicated window.
     (window-dedicated-p (selected-window))
     ;; Buffer name not match below blacklist.
     (string-prefix-p "*epc" name)
     (string-prefix-p "*helm" name)
     (string-prefix-p "*Helm" name)
     (string-prefix-p "*Compile-Log*" name)
     (string-prefix-p "*lsp" name)
     (string-prefix-p "*company" name)
     (string-prefix-p "*format-all" name)
     (string-prefix-p "*Flycheck" name)
     (string-prefix-p "*tramp" name)
     (string-prefix-p " *Mini" name)
     (string-prefix-p "*help" name)
     (string-prefix-p "*straight" name)
     (string-prefix-p " *temp" name)
     (string-prefix-p "*Help" name)
     (string-prefix-p "*Completions" name)
     (string-prefix-p "*EGLOT" name)
     (string-prefix-p "*slime-events" name)
     (string-prefix-p "*sldb" name)
     (string-prefix-p "*inferior-lisp" name)
     (string-prefix-p "*slime-repl" name)
     (string-prefix-p "*Messages" name)
     (string-prefix-p "*Apropos" name)
     (string-prefix-p "*scratch" name)
     (string-prefix-p "*Faces" name)
     (string-prefix-p "*mybuf" name)
     ;; Is not magit buffer.
     (and (string-prefix-p "magit" name)
	  (not (file-name-extension name))))))

(defun centaur-toggle-cycle-type ()
  "Switches between cycling through tabs and groups."
  (interactive)
  (if (eq centaur-tabs-cycle-scope 'tabs)
      (setq centaur-tabs-cycle-scope 'groups)
    (setq centaur-tabs-cycle-scope 'tabs)))

;;; COMPANY
(use-package company
  :ensure
  :config
  (global-company-mode)
  (add-hook 'after-init-hook 'global-company-mode)
  (setq company-format-margin-function 'company-vscode-dark-icons-margin))

;;; FORMAT-ALL
(use-package format-all
  :ensure
  :config
  (add-hook 'prog-mode-hook 'format-all-mode)
  (add-hook 'markdown-mode-hook 'format-all-mode)
  (add-hook 'format-all-mode-hook 'format-all-ensure-formatter))

;;; EGLOT
(use-package eglot
  :ensure
  :config
  (setq eglot-autoshutdown 1)
  (add-hook 'markdown-mode-hook 'eglot-ensure)
  (add-hook 'latex-mode-hook 'eglot-ensure)
  (add-hook 'tex-mode-hook 'eglot-ensure)
  (add-hook 'js-mode-hook 'eglot-ensure)
  (add-hook 'typescript-mode-hook 'eglot-ensure)
  (add-hook 'c-mode-hook 'eglot-ensure)
  (add-hook 'cpp-edit-mode-hook 'eglot-ensure)
  (add-hook 'shell-mode-hook 'eglot-ensure))

;;; NEOTREE
(use-package neotree
  :ensure
  :config
  (setq neo-smart-open t)
  (define-key evil-normal-state-map (kbd "C-n") nil)
  (global-set-key (kbd "C-n") 'neotree-toggle)
  (define-key neotree-mode-map (kbd "C-n") 'neotree-toggle)
  ;; Face Customizations
  (face-spec-set 'neo-root-dir-face
	         '((t (:foreground "#1CDDF1"))) 'face-defface-spec)
  (face-spec-set 'neo-dir-link-face
	         '((t (:foreground "#1CDDF1"))) 'face-defface-spec)
  (face-spec-set 'neo-file-link-face
	         '((t (:foreground "#AAE9E9"))) 'face-defface-spec)
  (face-spec-set 'neo-expand-btn-face
	         '((t (:foreground "#1CDDF1" :bold t))) 'face-defface-spec))

(defun sl/display-header ()
  "Create the header string and display it."
  ;; The dark blue in the header for which-func is terrible to read.
  ;; However, in the terminal it's quite nice
  (if header-line-format
      nil
    ;; Set the header line
    (if (derived-mode-p 'neotree-mode)
        (progn
	  (setq header-line-format
		(list "")))
      (set-face-foreground 'header-line "#1CDDF1")
      (set-face-background 'header-line "#080808")
      nil)))
(add-hook 'buffer-list-update-hook 'sl/display-header)

(defun neotree-startup ()
  (interactive)
  (neotree-show)
  (set-window-margins (car (get-buffer-window-list (current-buffer) nil t)) 2 2)
  (call-interactively 'other-window))

(if (daemonp)
    (add-hook 'server-switch-hook #'neotree-startup)
  (add-hook 'after-init-hook #'neotree-startup))

;;; FLYSPELL
(use-package flyspell
  :ensure
  :config
  (add-hook 'find-file-hook 'flyspell-on-for-buffer-type)
  (add-hook 'after-change-major-mode-hook 'flyspell-on-for-buffer-type)
  (setq flyspell-issue-message-flag nil))

(defun flyspell-learn-word-at-point ()
  "Takes the highlighted word at point -- nominally a misspelling -- and inserts it into the personal/private dictionary, such that it is known and recognized as a valid word in the future."
  (interactive)
  (let ((current-location (point))
	(word (flyspell-get-word)))
    (when (consp word)
      (flyspell-do-correct
       'save nil
       (car word)
       current-location
       (cadr word)
       (caddr word)
       current-location))))

(defun flyspell-on-for-buffer-type ()
  "Enable Flyspell appropriately for the major mode of the current buffer.  Uses `flyspell-prog-mode' for modes derived from `prog-mode', so only strings and comments get checked.  All other buffers get `flyspell-mode' to check all text.  If flyspell is already enabled, does nothing."
  (interactive)
  (if (not (symbol-value flyspell-mode)) ; if not already on
      (progn
	(if (derived-mode-p 'prog-mode)
	    (progn
					; (message "Flyspell on (code)")
	      (flyspell-prog-mode))
	  ;; else
	  (progn
	    (if (or (derived-mode-p 'neotree-mode)
		    (derived-mode-p 'minibuffer-inactive-mode)
		    (derived-mode-p 'package-menu-mode)
		    (derived-mode-p 'apropos-mode)
		    (derived-mode-p 'help-mode)
		    (derived-mode-p 'dired-mode)
		    (derived-mode-p 'sldb-mode)
		    (derived-mode-p 'slime-repl-mode)
		    (derived-mode-p 'dashboard-mode))
		(flyspell-mode -1)
	      (progn
					; (message "Flyspell on (text)")
		(flyspell-mode 1)))
	    ))
	)))

;;; LISPY
(use-package lispy
  :ensure
  :config
  (add-hook 'lisp-mode-hook (lambda () (lispy-mode 1))))

;;; LISPYVILLE
(use-package lispyville
  :ensure
  :config
  (add-hook 'lispy-mode-hook 'lispyville-mode)
  (setq lispyville-motions-put-into-special t))

;;; MARKDOWN-MODE
(use-package markdown-mode
  :ensure)

;;; TIDE
(use-package tide
  :ensure
  :config
  ;; aligns annotation to the right hand side
  (setq company-tooltip-align-annotations t)
  ;; formats the buffer before saving
  (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'typescript-mode-hook #'setup-tide-mode))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;;; POWERLINE
(use-package powerline
  :ensure
  :config
  (powerline-default-theme))

;;; AIRLINE-THEMES
(use-package airline-themes
  :ensure
  :config
  (setq airline-eshell-colors nil)
  ;; My custom theme based off of base16_snazzy
  ;; airline-nil
  (load-theme 'airline-nil)
  (custom-theme-set-faces
   'airline-nil
   '(minibuffer-prompt
     ((t (:foreground nil :background nil :inherit 'default))))))

;;; ORIGAMI
;; zc - close fold, zo - open fold, zM - close all folds, zR - unfold all
(use-package origami
  :ensure
  :config
  (global-origami-mode 1))

;;; DASHBOARD
(use-package dashboard
  :ensure
  :config
  (dashboard-setup-startup-hook)
  (set-face-foreground 'dashboard-items-face "lightblue4")
  (set-face-foreground 'dashboard-no-items-face "lightblue4")
  (define-key dashboard-mode-map (kbd "C-n") nil)
  (setq left-margin-width 1)
  (setq dashboard-startup-banner 1)
  (setq dashboard-center-content t)
  (setq dashboard-projects-backend 'projectile)
  ;; Bookmarks can be set with C-x r m
  ;; Bookmarks can be listed with C-x r l
  ;; Bookmarks can be deleted with M-x bookmark-delete
  (setq dashboard-items '((projects  . 2)
			  (bookmarks . 2)
			  (recents . 2)))
  (setq dashboard-item-names '(("Recent Files:" . "Recently Opened Files:")))
  (setq dashboard-init-info "NILTNIR ∈ LAMBDUS"))
(setq dashboard-banner-logo-title nil)
(setq dashboard-set-navigator nil)

;;; PAGE-BREAK-LINES
(use-package page-break-lines
  :ensure
  :config
  (global-page-break-lines-mode 1))

;;; LINUM-RELATIVE
(use-package linum-relative
  :ensure
  :config
  (linum-relative-global-mode 1)
  (setq linum-relative-format "%3s  ")
  (setq linum-relative-current-symbol "")
  (define-global-minor-mode linum-relative-global-mode
    linum-relative-mode
    (lambda ()
      (unless
	  (or (derived-mode-p 'eshell-mode)
              (derived-mode-p 'dashboard-mode)
	      (derived-mode-p 'minibuffer-inactive-mode))
        (linum-relative-mode 1))))
  (face-spec-set 'linum-relative-current-face
	         '((t (:inherit linum :foreground "#1CDDF1" :weight bold))) 'face-defface-spec))

;;; SMOOTH-SCROLLING
(use-package smooth-scrolling
  :ensure
  :config
  (smooth-scrolling-mode 1)
  (setq redisplay-dont-pause t
        scroll-margin 10
        scroll-step 1
        scroll-conservatively 10000
        scroll-preserve-screen-position 1
        scroll-up-aggressively 0.01
        scroll-down-aggressively 0.01))

;;; DIMINISH
(use-package diminish
  :ensure
  :config
  (diminish 'visual-line-mode))

(with-eval-after-load 'abbrev (diminish 'abbrev-mode))
(with-eval-after-load 'aggressive-indent (diminish 'aggressive-indent-mode))
(with-eval-after-load 'autopair (diminish 'autopair-mode))
(with-eval-after-load 'undo-tree (diminish 'undo-tree-mode))
(with-eval-after-load 'auto-complete (diminish 'auto-complete-mode))
(with-eval-after-load 'auto-fill (diminish 'auto-fill-mode))
(with-eval-after-load 'clipetty (diminish 'global-clipetty-mode))
(with-eval-after-load 'clipetty (diminish 'clipetty-mode))
(with-eval-after-load 'flycheck (diminish 'flycheck-mode))
(with-eval-after-load 'flyspell (diminish 'flyspell-mode))
(with-eval-after-load 'flymake (diminish 'flymake-mode))
(with-eval-after-load 'format-all (diminish 'format-all-mode))
(with-eval-after-load 'projectile (diminish 'projectile-mode))
(with-eval-after-load 'yasnippet (diminish 'yas-minor-mode))
(with-eval-after-load 'guide-key (diminish 'guide-key-mode))
(with-eval-after-load 'evil-escape (diminish 'evil-escape-mode))
(with-eval-after-load 'evil-commentary (diminish 'evil-commentary-mode))
(with-eval-after-load 'eldoc (diminish 'eldoc-mode))
(with-eval-after-load 'page-break-lines (diminish 'page-break-lines-mode))
(with-eval-after-load 'smartparens (diminish 'smartparens-mode))
(with-eval-after-load 'company (diminish 'company-mode))
(with-eval-after-load 'elisp-slime-nav (diminish 'elisp-slime-nav-mode))
(with-eval-after-load 'git-gutter+ (diminish 'git-gutter+-mode))
(with-eval-after-load 'magit (diminish 'magit-auto-revert-mode))
(with-eval-after-load 'hs-minor-mode (diminish 'hs-minor-mode))
(with-eval-after-load 'xclip (diminish 'xclip-mode))
(with-eval-after-load 'linum-relative (diminish 'linum-relative-mode))
(with-eval-after-load 'slime (diminish 'slime-autodoc-mode))
(with-eval-after-load 'lispy (diminish 'lispy-mode))
(with-eval-after-load 'lispyville (diminish 'lispyville-mode))

;;; DTRT-INDENT
(use-package dtrt-indent
  :ensure
  :config
  (dtrt-indent-mode 1))

;;; AGGRESSIVE-INDENT
(use-package aggressive-indent
  :ensure
  :config
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
  (add-to-list 'aggressive-indent-excluded-modes 'lisp-mode))

;;; COLOR-THEME-APPROXIMATE
(use-package color-theme-approximate
  :ensure
  :config
  (color-theme-approximate-on))

;;;; KEYBINDINGS
;;; Mapping with evil-leader:
(evil-leader/set-key
  "a" "ggyG" ; copy whole file
  "h" 'windmove-left
  "j" 'windmove-down
  "k" 'windmove-up
  "l" 'windmove-right
  "p" 'projectile-command-map
  "d t" 'kill-current-buffer ;delete current tab
  "d w" 'delete-window
  "s" 'open-scratch-buffer
  )

;;; Delete tab when evil-emacs-state is on:
(define-key evil-emacs-state-map (kbd "m d") 'kill-current-buffer)

;;; Mapping for page up/down:
(define-key evil-normal-state-map (kbd "C-k")
  (lambda ()
    (interactive)
    (evil-scroll-up nil)))
(define-key evil-normal-state-map (kbd "C-j")
  (lambda ()
    (interactive)
    (evil-scroll-down nil)))

;;; Remap { to } and } to {
(define-key evil-normal-state-map (kbd "{")
  (lambda ()
    (interactive)
    (evil-forward-paragraph nil)))

(define-key evil-normal-state-map (kbd "}")
  (lambda ()
    (interactive)
    (evil-backward-paragraph nil)))

;;; Mapping for Elisp evaluation in scratch buffer:
;; C-x C-e in Slime is evaluating in minibuffer
;; C-c C-j in Slime is evaluating in REPL
(define-key lisp-interaction-mode-map (kbd "C-c C-j") 'eval-print-last-sexp)

;;; Mapping for pasting clipboard text:
(evil-global-set-key 'normal "p" 'clipboard-yank)

;;; Remapping return key to both create a newline and indent:
(define-key global-map (kbd "RET") 'newline-and-indent)

;;; Jump back from definition (reverse of goto-definition):
(define-key evil-normal-state-map (kbd "g b") 'xref-go-back)

;;; Keybindings for centaur-tabs:
(define-key evil-normal-state-map (kbd "M-0") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 0)))
(define-key evil-normal-state-map (kbd "M-1") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 1)))
(define-key evil-normal-state-map (kbd "M-2") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 2)))
(define-key evil-normal-state-map (kbd "M-3") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 3)))
(define-key evil-normal-state-map (kbd "M-4") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 4)))
(define-key evil-normal-state-map (kbd "M-5") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 5)))
(define-key evil-normal-state-map (kbd "M-6") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 6)))
(define-key evil-normal-state-map (kbd "M-7") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 7)))
(define-key evil-normal-state-map (kbd "M-8") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 8)))
(define-key evil-normal-state-map (kbd "M-9") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 9)))
(define-key evil-insert-state-map (kbd "M-0") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 0)))
(define-key evil-insert-state-map (kbd "M-1") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 1)))
(define-key evil-insert-state-map (kbd "M-2") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 2)))
(define-key evil-insert-state-map (kbd "M-3") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 3)))
(define-key evil-insert-state-map (kbd "M-4") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 4)))
(define-key evil-insert-state-map (kbd "M-5") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 5)))
(define-key evil-insert-state-map (kbd "M-6") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 6)))
(define-key evil-insert-state-map (kbd "M-7") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 7)))
(define-key evil-insert-state-map (kbd "M-8") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 8)))
(define-key evil-insert-state-map (kbd "M-9") (lambda() (interactive) (centaur-tabs-select-visible-nth-tab 9)))
(define-key evil-normal-state-map (kbd "g l") 'centaur-tabs-forward)
(define-key evil-normal-state-map (kbd "g h") 'centaur-tabs-backward)
(define-key evil-normal-state-map (kbd "g t") 'centaur-toggle-cycle-type)
(define-key evil-normal-state-map (kbd "+") 'nil)
(define-key evil-normal-state-map (kbd "+ t") 'centaur-tabs--create-new-tab)

;;; Completion for company:
(define-key company-active-map (kbd "SPC") 'company-complete-selection)
(define-key company-active-map
  (kbd "TAB")
  #'company-complete-common-or-cycle)
(define-key company-active-map
  (kbd "<backtab>")
  (lambda ()
    (interactive)
    (company-complete-common-or-cycle -1)))

;;; Evil usage with neotree:
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)

;;; Flymake functions:
(define-key evil-normal-state-map (kbd "SPC n") 'flymake-goto-next-error)
(define-key evil-normal-state-map (kbd "SPC p") 'flymake-goto-prev-error)

;;; Flyspell functions:
(global-set-key (kbd "C-c s") 'flyspell-learn-word-at-point)
(global-set-key (kbd "<f8>") 'ispell-word)
(global-set-key (kbd "C-S-<f8>") 'flyspell-mode)

;; how to define new commands instead of keysequences when converting vim motions
;; https://emacs.stackexchange.com/questions/15305/call-an-evil-delete-evil-motion-operation-from-elisp
