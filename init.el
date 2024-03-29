(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	         '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Live down
;; (custom-set-variables
;;  '(livedown-autostart nil) ; automatically open preview when opening markdown files
;;  '(livedown-open t)        ; automatically open the browser window
;;  '(livedown-port 1337)     ; port for livedown server
;;  '(livedown-browser nil))  ; browser to use

;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-livedown"))
;; (require 'livedown)

;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/highlight-indent-guides-master"))
;; (require 'highlight-indent-guides)
;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/tsi.el-main"))
;; (require 'tsi-typescript)
;; (tsi-typescript-mode t)


;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/tsx-mode.el-master"))
;; (require 'tsx-mode)
;; (tsx-mode t)
;; init.el

;; for terminals
;; (set-face-background 'default "undefined")

;; Basic
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(line-number-mode 1)
(column-number-mode 1)
(electric-pair-mode 1)
(setq byte-compile-warnings '(cl-functions))
;; enable clipboard in emacs
(setq x-select-enable-clipboard t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)


(fset 'yes-or-no-p 'y-or-n-p)

(setq-default shell-file-name "/bin/bash")
(setq-default explicit-shell-file-name "/bin/bash")

(setq org-blank-before-new-entry t)

(setq scroll-conservatively 100)
(setq make-backup-files nil)
(setq auto-save-default nil)
(global-display-line-numbers-mode)
(global-hl-line-mode t)
(global-subword-mode 1)
(setq-default c-basic-offset 4)
(setq org-image-actual-width nil)
(setq display-line-numbers-type 'relative)
;; Transparency
;;(set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
;;(set-frame-parameter (selected-frame) 'alpha <both>)
;; (set-frame-parameter (selected-frame) 'alpha 86)
;; (add-to-list 'default-frame-alist '(alpha 86))

;; Manual pacs
(add-to-list 'load-path "~/.emacs.d/manual-packages/ef-themes")
(require 'ef-themes)

(use-package indent-bars
  :load-path "~/.emacs.d/manual-packages/indent-bars"
  :hook ((python-mode web-mode typescript-mode) . indent-bars-mode))

;; Prettify symbols
(global-prettify-symbols-mode t)
(use-package pretty-mode
  :init (global-pretty-mode t)
  :config
  (pretty-deactivate-groups
   '(:equality :ordering :ordering-double :ordering-triple
               :arrows :arrows-twoheaded :punctuation
               :logic :sets))
  (pretty-activate-groups
   '(:sub-and-superscripts :greek :arithmetic-nary)))

(defun prettify-typescript-symbols ()
   (mapc (lambda (pair) (push pair prettify-symbols-alist))
         '(;; Syntax
           ("function" .      #x0192)
           ;; ("() =>" .      #x0192)
           ("&&" .      #x2227)
           ("||" .      #x2228)
           ("some" .      #x2203)
           ("async" .      #x2732)
           ("===" .      #x2261)
           ("!==" .      #x2262)
           ;; ("not" .      #x2757)
           ;; ("in" .       #x2208)
           ;; ("not in" .   #x2209)
           ("() =>" .   #x27f4)
           ("()=>" .   #x27f4)
           ("return" .   #x27fc)
           ("yield" .    #x27fb)
           ("forEach" .      #x2200)
           ;; Base Types
           ("int" .      #x2124)
           ("number" .    #x2115)
           ("string" .      #x1d54a)
           ("true" .     #x1d54b)
           ("false" .    #x1d53d)
           ;; Mypy
           ;; ("Dict" .     #x1d507)
           ;; ("Array" .     #x2112)
           ("Array" .     #x24B6)
           ;; ("Tuple" .    #x2a02)
           ("Set" .      #x2126)
           ;; ("Iterable" . #x1d50a)
           ;; ("Any" .      #x2754)
           ;; ("Union" .    #x22c3)
           )))
(add-hook 'typescript-mode-hook 'prettify-typescript-symbols)
(add-hook 'tide-mode-hook 'prettify-typescript-symbols)
(add-hook 'rjsx-mode-hook 'prettify-typescript-symbols)

(add-hook
 'python-mode-hook
 (lambda ()
   (mapc (lambda (pair) (push pair prettify-symbols-alist))
         '(;; Syntax
           ("def" .      #x0192)
           ("not" .      #x2757)
           ("in" .       #x2208)
           ("not in" .   #x2209)
           ("return" .   #x27fc)
           ("yield" .    #x27fb)
           ("for" .      #x2200)
           ;; Base Types
           ("int" .      #x2124)
           ("float" .    #x211d)
           ("str" .      #x1d54a)
           ("True" .     #x1d54b)
           ("False" .    #x1d53d)
           ("some" .      #x2203)
           ;; Mypy
           ("Dict" .     #x1d507)
           ("List" .     #x2112)
           ("Tuple" .    #x2a02)
           ("Set" .      #x2126)
           ("Iterable" . #x1d50a)
           ("Any" .      #x2754)
           ("Union" .    #x22c3)))))    

;; theme setting
(mapc #'disable-theme custom-enabled-themes)

;; (setq ef-themes-to-toggle '(ef-trio-dark ef-trio-light))
;; (setq ef-themes-to-toggle '(ef-trio-light ef-autumn))

;; ;; (load-theme 'ef-summer t)
;; ;; (load-theme 'ef-winter t)
;; (ef-themes-select 'ef-trio-dark)

(global-set-key (kbd "C-c s") 'ef-themes-toggle)
(use-package modus-themes
  :config
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil)
  ;; Maybe define some palette overrides, such as by using our presets
  (setq modus-themes-common-palette-overrides
        '(
          ;; (bg-mode-line-active bg-magenta-intense)
          (fringe unspecified)
          (fg-mode-line-active fg-main)
          (bg-region bg-lavender) ; try to replace `bg-ochre' with `bg-lavender', `bg-sage'
          (fg-region unspecified)
          (fg-line-number-inactive "gray50")
          (fg-line-number-active fg-main)
          (bg-line-number-inactive unspecified)
          (bg-line-number-active unspecified)
          (border-mode-line-active unspecified)
          (border-mode-line-inactive unspecified)))
  :bind
  ("<f5>" . modus-themes-toggle))
  ;; Load the theme of your choice.
  (load-theme 'modus-vivendi-tinted t)
;; (load-theme 'ef-elea-dark t)

;; Abbreviation
;; (abbrev-table-put typescript-mode-abbrev-table :regexp "\\(?:^\\|[\t\s]+\\)\\(?1:[;_].*\\|.*\\)")
;; (abbrev-table-put web-mode-abbrev-table :regexp "\\(?:^\\|[\t\s]+\\)\\(?1:[;_].*\\|.*\\)")
;; (add-hook 'prog-mode-hook 'abbrev-mode)
;; (abbrev-table-put global-abbrev-table :regexp "\\(?:^\\|[\t\s]+\\)\\(?1:[;_].*\\|.*\\)")

;; (abbrev-table-put global-abbrev-table :case-fixed t)
;; (dolist (table abbrev-table-name-list)
;;     (abbrev-table-put (symbol-value table) :regexp "\\(?:^\\|[\t\s]+\\)\\(?1:[;_].*\\|.*\\)"))
;; (dolist (table abbrev-table-name-list)
;;   (abbrev-table-put (symbol-value table) :case-fixed t))
;; (setq-default abbrev-mode t)

;; Diminish
(use-package diminish)

;; Rg
(use-package rg)

;; ;; Beacon
;; (use-package beacon
;;   :init
;;   (beacon-mode 1))

(use-package pulsar
  :config
  (setq pulsar-pulse-functions
	    ;; NOTE 2022-04-09: The commented out functions are from before
	    ;; the introduction of `pulsar-pulse-on-window-change'.  Try that
	    ;; instead.
	    '(recenter-top-bottom
          move-to-window-line-top-bottom
          reposition-window
          beginning-of-buffer
          end-of-buffer
          ;; bookmark-jump
          other-window
          ;; delete-window
          ;; delete-other-windows
          forward-page
          backward-page
          scroll-up-command
          scroll-down-command
          ;; windmove-right
          ;; windmove-left
          ;; windmove-up
          ;; windmove-down
          ;; windmove-swap-states-right
          ;; windmove-swap-states-left
          ;; windmove-swap-states-up
          ;; windmove-swap-states-down
          ;; tab-new
          ;; tab-close
          ;; tab-next
          org-next-visible-heading
          org-previous-visible-heading
          org-forward-heading-same-level
          org-backward-heading-same-level
          outline-backward-same-level
          outline-forward-same-level
          outline-next-visible-heading
          outline-previous-visible-heading
          outline-up-heading))

  (setq pulsar-pulse-on-window-change t)
  (setq pulsar-pulse t)
  (setq pulsar-delay 0.055)
  (setq pulsar-iterations 10)
  (setq pulsar-face 'pulsar-green)
  (setq pulsar-highlight-face 'pulsar-yellow)
  :init
  (pulsar-global-mode 1))

;; Hungry delete
(use-package hungry-delete
  :config
  (global-hungry-delete-mode))

;; ;; simple modeline
;; (use-package simple-modeline
;;   :init
;;   (simple-modeline-mode 1))

;; mood modeline
(use-package mood-line
  :init
  (mood-line-mode)
  :config
  (setq mood-line-glyph-alist mood-line-glyphs-fira-code))

(use-package embrace)
(use-package expand-region)

(use-package all-the-icons)

;; Treemacs
(use-package treemacs
  :bind
  (:map global-map
	    ("C-c \\" . treemacs))
  :config
  (setq treemacs-project-follow-mode t)
  (treemacs-load-all-the-icons-with-workaround-font "Victor Mono"))

(use-package treemacs-projectile
  :after (treemacs projectile))

;; (use-package treemacs-all-the-icons
;;   :init
;;   (treemacs-load-theme "all-the-icons"))

;; Dired
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))
;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(add-hook 'dired-mode-hook 'dired-hide-details-mode)

;; Hydra
(use-package hydra)
(defhydra hydra-zoom (global-map "<f2>")
  "zoom"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out"))

(defhydra hydra-bookmarked-files (:color blue)
  "Bookmarked files"
  ("a" (ido-find-file-in-dir (expand-file-name "~/.config/awesome")) "Awesome")
  ("c" (ido-find-file-in-dir (expand-file-name "~/.config")) "Config")
  ("e" (find-file (expand-file-name "~/.emacs.d/init.el")) "Emacs")
  ("g" (ido-find-file-in-dir "/mnt/projects/Git") "Git")
  ("h" (ido-find-file-in-dir "/mnt/projects/Haskell") "Haskell")
  ("l" (ido-find-file-in-dir "/mnt/projects/Perl") "Perl")
  ("p" (ido-find-file-in-dir "/mnt/projects") "Projects")
  ("r" (ido-find-file-in-dir "/mnt/projects/Rust") "Rust")
  ("R" (ido-find-file-in-dir "/mnt/projects/React") "React")
  ("t" (ido-find-file-in-dir "/mnt/projects/Typescript") "Typescript")
  ("y" (ido-find-file-in-dir "/mnt/projects/Python") "Python"))
(global-set-key (kbd "C-c q") 'hydra-bookmarked-files/body)

;; Rust
(use-package rust-mode
  :init
  (setq rust-format-on-save t))

;; Ocaml
(use-package caml
  :config
  (add-to-list 'auto-mode-alist '("\\.ml[iylp]?$" . caml-mode))
  (autoload 'caml-mode "caml" "Major mode for editing OCaml code." t)
  (autoload 'run-caml "inf-caml" "Run an inferior OCaml process." t)
  (autoload 'camldebug "camldebug" "Run ocamldebug on program." t)
  (add-to-list 'interpreter-mode-alist '("ocamlrun" . caml-mode))
  (add-to-list 'interpreter-mode-alist '("ocaml" . caml-mode))
  (if window-system (require 'caml-font))
)

;; Haskell
(use-package haskell-mode)

;; Fish shell
(use-package fish-mode)
;; Org
(setq org-src-preserve-indentation t)

;; Denote
(use-package denote
  :config
  (setq denote-directory (expand-file-name "/mnt/projects/Notes")))
(global-set-key (kbd "C-c n") 'denote-open-or-create)

;; Org Bullets
(use-package org-bullets
  :hook
  (org-mode . org-bullets-mode))

;; Rainbow
;; rainbow-mode
(use-package rainbow-mode
  :bind ("M-p" . rainbow-mode))

(use-package rainbow-delimiters
  :init (rainbow-delimiters-mode 1)
  :hook (prog-mode . rainbow-delimiters-mode)
  )

;; Dashboard
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  ;; (setq dashboard-startup-banner 'logo)
  ;; (setq dashboard-startup-banner "/home/krishna/.emacs.d/black_hole.png")
  (setq dashboard-startup-banner "/home/krishna/.emacs.d/gnu-2.png")
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents . 6)
			              (projects . 10)))
  )
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))


;; Goto last change
(use-package goto-chg)

;; Avy
(use-package avy
  :config
  (setq avy-keys '(?c ?i ?e ?a ?, ?. ?h ?t ?s))
  (setq avy-background t))

;; Ace jump
;; (use-package ace-jump-mode)

;; Swiper
(use-package swiper
  :bind("M-s" . swiper))

;; Projectile
(use-package projectile
  :init
  (projectile-mode 1)
  :config
  (setq projectile-indexing-method 'hybrid)
  (setq projectile-sort-order 'access-time)
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  :bind
  ("C-z" . 'projectile-find-file))


;; Which-key
(use-package which-key
  :init
  (which-key-mode))

;; Enable vertico
(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

(use-package consult
  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key (kbd "M-.")
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")
  (autoload 'projectile-project-root "projectile")
  (setq consult-project-function (lambda (_) (projectile-project-root)))
  :bind
  ("C-x C-b" . 'consult-buffer)
  ;; ("M-s" . 'consult-line)
  )

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Helm
;; (use-package helm
;;   :bind
;;   ("C-x C-b" . 'helm-buffers-list)
;;   ;; ("C-c f" . 'helm-find-files)  
;;   :config
;;   (add-to-list 'display-buffer-alist
;;                '("*Help*" display-buffer-same-window))
;;   (helm-mode 1))

(use-package company
  :init
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 1)
  (setq company-selection-wrap-around t)
  :config
  (global-company-mode t)
  :bind
  ("C-<tab>" . dabbrev-expand)
  :diminish company-mode)

;; Multiple-cursors
(use-package multiple-cursors
  :bind ("C-;" . 'mc/mark-next-like-this))

;; yasnippets
(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1))

;; auto-yasnippets
(use-package auto-yasnippet
  :bind
  ("C-c C-y w" . #'aya-create)
  ("C-c C-y TAB" . #'aya-expand)
  ("C-c C-y SPC" . #'aya-expand-from-history)
  ("C-c C-y d" . #'aya-delete-from-history)
  ("C-c C-y c" . #'aya-clear-history)
  ("C-c C-y n" . #'aya-next-in-history)
  ("C-c C-y p" . #'aya-previous-in-history)
  ("C-c C-y s" . #'aya-persist-snippet)
  ("C-c C-y o" . #'aya-open-line))


;; Web dev
;; emmet
(use-package emmet-mode
  :init
  (emmet-mode 1)
  :bind ("C-j" . emmet-expand-line))

;; Svelte
;; (use-package svelte-mode)

;; Origami
;; (use-package origami
;;   :init (global-origami-mode)
;;   :bind ("C-c u f" . origami-toggle-node))

(defun tsx-electric-lt (n)
  (interactive "p")
  (if (/= n 1)
      (insert (make-string n ?<))
    (if (save-excursion
          (forward-comment most-negative-fixnum)
          (skip-chars-backward "\n\r")
          (or (= (point) (point-min))
              (memq (char-before) (append "=(?:>}&|{," nil))
              (let ((start (- (point) 6)))
                (and (>= start (point-min))
                     (string= (buffer-substring start (point)) "return")))))
        (progn (insert "</>")
               (backward-char 2))
      (insert "<"))))

;; (defun tsx-comment-region (func)
;;   (unless (use-region-p)
;;     (error "need an active region"))
;; (let ((res (funcall func (buffer-substring (mark) (point)))))
;;   (delete-region (region-beginning) (region-end))     (insert res)))

;; (defun tsx-comment (text)
;;   (concat "{/*" text "*/}")
;;   )

;; (defun my/test ()
;;   (interactive)
;;   (apply-to-region 'foo))


;; Tide
(use-package tide)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (diminish tide-mode)
  (define-key tide-mode-map (kbd "M-,") 'tide-references)
  (company-mode +1))

;; Lsp , tree sitter, tsx
;; (use-package lsp-mode
;;   :commands (lsp lsp-deferred)
;;   :config
;;   (lsp-enable-which-key-integration t)
;;   (setq lsp-headerline-breadcrumb-enable nil))

;; (use-package lsp-ui)

;; (use-package tree-sitter
;;   :ensure t
;;   :diminish tree-sitter-mode
;;   :config
;;   ;; activate tree-sitter on any buffer containing code for which it has a parser available
;;   (global-tree-sitter-mode)
;;   ;; you can easily see the difference tree-sitter-hl-mode makes for python, ts or tsx
;;   ;; by switching on and off
;;   (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;; (use-package tree-sitter-langs
;;   :ensure t
;;   :after tree-sitter)

(use-package typescript-mode
  ;; :after tree-sitter
  :mode ("\\.ts\\'" "\\.tsx\\'")
  :hook ((typescript-mode . setup-tide-mode)
         (typescript-mode . prettier-js-mode))
  :init
  (add-hook 'typescript-mode-hook
            (lambda ()
              (abbrev-table-put typescript-mode-abbrev-table :regexp "\\(?:^\\|[\t\s]+\\)\\(?1:[;_].*\\|.*\\)")
              (abbrev-mode)
              (define-key web-mode-map "<" 'tsx-electric-lt))))


;; (use-package typescript-mode
;;   ;; :after tree-sitter
;;   :hook ((typescript-mode . prettier-js-mode)
;;          (typescript-mode . setup-tide-mode))
;;   :config
;;   ;; we choose this instead of tsx-mode so that eglot can automatically figure out language for server
;;   ;; see https://github.com/joaotavora/eglot/issues/624 and https://github.com/joaotavora/eglot#handling-quirky-servers
;;   (define-derived-mode typescriptreact-mode typescript-mode
;;     "TypeScript TSX")

;;   ;; use our derived mode for tsx files
;;   (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescriptreact-mode))
;;   ;; by default, typescript-mode is mapped to the treesitter typescript parser
;;   ;; use our derived mode to map both .tsx AND .ts -> typescriptreact-mode -> treesitter tsx
;;   (add-to-list 'tree-sitter-major-mode-language-alist '(typescriptreact-mode . tsx)))
;; (add-hook 'typescriptreact-mode-hook (lambda ()
;;                                        (when (string-equal "tsx" (file-name-extension buffer-file-name))
;;                                          (web-mode +1)
;;                                          ;; (setq-local comment-use-syntax nil)
;;                                          ;; (setq-local comment-start-skip "[[:space:]]*\\(//+\\|{?/\\*+\\)")
;;                                          ;; (setq-local comment-end-skip "\\(\\*+/}?[[:space:]]*\\)\n?\\|\n")
;;                                          ;; (setq-local comment-start "{/\*")
;;                                          ;; (setq-local comment-end   "\*/}")
;;                                          (define-key typescript-mode-map "<" 'tsx-electric-lt))))


;; ;; Web mode
(use-package web-mode
    :hook (web-mode . prettier-js-mode)
  :mode (("\\.html?\\'" . web-mode)
         ("\\.tsx\\'" . web-mode))
  :init
  (add-hook 'web-mode-hook (lambda ()
                             (when (string-equal "tsx" (file-name-extension buffer-file-name))
                               (setup-tide-mode)
                               (abbrev-table-put web-mode-abbrev-table :regexp "\\(?:^\\|[\t\s]+\\)\\(?1:[;_].*\\|.*\\)")
                               (abbrev-mode)
                               (define-key web-mode-map "<" 'tsx-electric-lt))))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-block-padding 2
        web-mode-comment-style 2
        web-mode-enable-auto-closing t 
        web-mode-enable-css-colorization t
        web-mode-enable-auto-pairing t
        web-mode-enable-comment-keywords t
        web-mode-enable-current-element-highlight t
    	web-mode-enable-auto-indentation nil
    	web-mode-enable-auto-quoting nil
        web-mode-content-types-alist
        '(("jsx" . "\\.tsx\\'"))
        )
  ;; enable typescript-tslint checker
  ;; (flycheck-add-mode 'typescript-tslint 'web-mode)  
  )

;; rjsx
(use-package rjsx-mode
  :init
  (setq create-lockfiles nil)
  :diminish rjsx-mode
  :mode "\\.jsx\\'")

;; prettier-js
(use-package prettier-js
  :hook ((rjsx-mode . prettier-js-mode)
	     (js-mode . prettier-js-mode)
	     (tide-mode . prettier-js-mode)
         (typescript-mode . prettier-js-mode))
  ;; :config
  ;; (add-hook 'rjsx-mode-hook (lambda()
  ;;                             (flycheck-add-mode 'javascript-eslint 'rjsx-mode)))
  :diminish prettier-js-mode)

;; Auto-start on any markup modes
(add-hook 'sgml-mode-hook 'emmet-mode)

;; enable Emmet's css abbreviation.
(add-hook 'css-mode-hook  'emmet-mode)

;; ;; python
;; (use-package py-autopep8
;;   :hook (python-mode . py-autopep8-enable-on-save))

;; Ligatures
(use-package ligature
  :config
  (ligature-set-ligatures '(web-mode)
                          '("<!--" "-->" "</>" "</" "/>" "!==" "===" "=>" ">=" "<="))
  (ligature-set-ligatures '(typescript-mode) '("!==" "===" "=>" ">=" "<="))
  (global-ligature-mode t))

;; Custom functions
(defun package-upgrade-all ()
  "Upgrade all packages automatically without showing *Packages* buffer."
  (interactive)
  (package-refresh-contents)
  (let (upgrades)
    (cl-flet ((get-version (name where)
                (let ((pkg (cadr (assq name where))))
                  (when pkg
                    (package-desc-version pkg)))))
      (dolist (package (mapcar #'car package-alist))
        (let ((in-archive (get-version package package-archive-contents)))
          (when (and in-archive
                     (version-list-< (get-version package package-alist)
                                     in-archive))
            (push (cadr (assq package package-archive-contents))
                  upgrades)))))
    (if upgrades
        (when (yes-or-no-p
               (message "Upgrade %d package%s (%s)? "
                        (length upgrades)
                        (if (= (length upgrades) 1) "" "s")
                        (mapconcat #'package-desc-full-name upgrades ", ")))
          (save-window-excursion
            (dolist (package-desc upgrades)
              (let ((old-package (cadr (assq (package-desc-name package-desc)
                                             package-alist))))
                (package-install package-desc)
                (package-delete  old-package)))))
      (message "All packages are up to date"))))

(defun wrap-in-type (name &optional add-comma?)
  (meow-mark-symbol 1)
  (if add-comma?
      (insert ", "))
  (insert ">")
  (backward-char 4)
  (meow-reverse)
  (insert name "<")
  (forward-char 1)
  (meow-mark-symbol 1)
  (if add-comma?
    (forward-char 2))
  (meow-cancel-selection))

(defun wrap-in-omit ()
  (interactive)
  (wrap-in-type "Omit" t))

(defun wrap-in-pick ()
  (interactive)
  (wrap-in-type "Pick" t))

(defun wrap-in-array ()
  (interactive)
  (wrap-in-type "Array"))

(defun wrap-in-maybe ()
  (interactive)
  (wrap-in-type "Maybe"))

(defun wrap-with-angle-brackets ()
  (interactive)
  (wrap-in-type ""))

(defun sort-imports-of-buffer ()
  (interactive)
  (shell-command-on-region (point-min) (point-max) "/mnt/projects/Perl/muy-importante/main.pl" nil t))

(defhydra hydra-ts-react (:color blue)
  "TS/React helpers"
  ("a" (wrap-in-array) "wrap in Array")
  ("i" (sort-imports-of-buffer) "Sort Imports")
  ("m" (wrap-in-maybe) "wrap in Maybe")
  ("o" (wrap-in-omit) "wrap in Omit")
  ("p" (wrap-in-pick) "wrap in Pick")
  ("s" (sx-props-to-attrs) "sx-props-to-attrs")
  ("t" (wrap-with-angle-brackets) "wrap in < >")
  ("d" (dashboard-refresh-buffer) "Dashboard"))
(global-set-key (kbd "C-c u") 'hydra-ts-react/body)

(defhydra hydra-avy (:color blue)
  "Avy copy/move"
  ("l" avy-copy-line "Copy line")
  ("r" avy-copy-region "Copy region")
  ("m" avy-move-line "Move line")
  ("w" avy-move-region "Move region"))
(global-set-key (kbd "C-c a") 'hydra-avy/body)

;; (defhydra hydra-embrace (:color blue)
;;   "Embrace"
;;   ("a" embrace-add "Add")
;;   ("c" embrace-change "Change")
;;   ("d" embrace-delete "Delete"))
;; (global-set-key (kbd "C-c l") 'hydra-embrace/body)

;; Macro aliases
(defalias 'end-delete
   (kmacro "C-e C-d"))

(defalias 'text-children
   (kmacro "j m g C-SPC C-e s k x h a SPC c h i l d r e n = \" <escape> p l a SPC / <escape> j x x s k x g"))

(defalias 'remove-useless-braces
   (kmacro "C-s { \" <return> <left> <backspace> C-s \" } <return> <backspace>"))

(defalias 'sx-props-to-attrs
   (kmacro "C-a C-s : <return> h c = SPC C-b C-d C-e , C-SPC C-a C-M-% [ , C-f + $ <return> <return> SPC C-a C-s = <return> C-SPC C-e { <escape> j"))

(defalias 'remove-font-prop
   (kmacro "C-a C-s f o n t <return> b s SPC m l"))

(defalias 'use-text
   (kmacro "SPC y T y p o g r a h <backspace> p h y <return> T e x t <return> ! SPC b C-s T e x t <return> b s <backspace> <backspace> C-s a p p / c o m m <return> C-r i m p o r t <return> e e i T e x t , <escape> C-s T e x t <return>"))

(defalias 'to-unit
   (kmacro "W SPC ( h i u n i t <escape>"))

(defhydra hydra-macros (:color blue)
  "Saved Macros"
  ("c" text-children "Text-Children")
  ("f" remove-font-prop "Remove-Font-Prop")
  ("r" remove-useless-braces "Remove-Useless-Braces")
  ("s" sx-props-to-attrs "Sx-Props-To-Attrs")
  ("t" use-text "use-text")
  ("u" to-unit "to-unit"))
(global-set-key (kbd "C-c r") 'hydra-macros/body)

;; (defun wrap-in-hooks (beg end hook)
;;   (interactive "r")
;;   (save-excursion
;;     (narrow-to-region beg end)
;;     (set-mark nil)
;;     (goto-char (point-min))
;;     (insert "use" hook "(\n\t() => ")
;;     (goto-char (point-max))
;;     (insert ",\n\t[]\n)")
;;     (widen)))


(defun projectile-find-file-in-current-directory ()
  (interactive)
(projectile-find-file-in-directory (file-name-directory buffer-file-name)))


(defun capitalize-first-char (&optional string)
  "Capitalize only the first character of the input STRING."
  (when (and string (> (length string) 0))
    (let ((first-char (substring string nil 1))
          (rest-str   (substring string 1)))
      (concat (capitalize first-char) rest-str))))

(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-c d") 'kill-current-buffer)

;; goto-char-2-right
(defun goto-char-2-right ()
  (interactive)
  (call-interactively 'avy-goto-char-2)
  (right-char +2))

;; goto-char-right
(defun goto-char-right ()
  (interactive)
  (call-interactively 'avy-goto-char)
  (right-char +1))

;; move-region-up-down
(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (beginning-of-line)
    (when (or (> arg 0) (not (bobp)))
      (forward-line)
      (when (or (< arg 0) (not (eobp)))
        (transpose-lines arg))
      (forward-line -1)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
        arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
        arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(global-set-key (kbd "C-,") 'move-text-up)
(global-set-key (kbd "C-.") 'move-text-down)

(defun split-right-and-move ()
  (interactive)
  (split-window-right)
  (other-window 1))

(defun split-below-and-move ()
  (interactive)
  (split-window-below)
  (other-window 1))

(defun replace-char ()
  (interactive)
  (let ((mychar (read-char "replace with:")))
    (if (= ?\C-\[ mychar)
        (message "Cancelled replace")
      (delete-char 1)
      (insert mychar))))

(defun replace-char-or-meow-replace ()
  (interactive)
  (if (use-region-p)
      (meow-replace)
    (replace-char)))

;; Custom shortcuts

;; ;; exit insert mode
;; (global-set-key (kbd "C-z") (kbd "<escape>"))

(global-set-key (kbd "C-c b") 'beginning-of-buffer)
(global-set-key (kbd "C-c e") 'end-of-buffer)
(global-set-key (kbd "C-c /") 'comment-line)
(global-set-key (kbd "C-c p") 'point-to-register)
(global-set-key (kbd "C-c v") 'jump-to-register)
(global-set-key (kbd "C-c z") 'projectile-find-file)
(global-set-key (kbd "C-c i") 'projectile-find-file-in-current-directory)

;; delete-line
;; (global-set-key (kbd "C-'") (kbd "abc C-a C-k C-k"))

;; kill region (cut)
(global-set-key (kbd "M-k") 'kill-region)

;; terminal
;; (global-set-key (kbd "C-c [") 'ansi-term)
;; (global-set-key (kbd "C-c t") (kbd "C-c w b C-c [ C-m"))

(global-set-key (kbd "C-c ,") 'split-below-and-move)
(global-set-key (kbd "C-c .") 'split-right-and-move)
(global-set-key (kbd "C-c o") 'other-window)

;; save-buffer
(global-set-key (kbd "C-c t") 'save-buffer)
(global-set-key (kbd "C-c y") 'query-replace)
;; org-mode-src
;; (global-set-key (kbd "C-c s r") (kbd "C-c C-, s"))

;; copy region
;; (global-set-key (kbd "C-w") 'copy-region-as-kill)

;; yas-expand
(global-set-key (kbd "C-o") 'yas-expand)

;; Meow setup
(defun meow-setup ()
  ;; (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev))
  (meow-leader-define-key
   ;; SPC j/k will run the original command in MOTION state.
   '("j" . "H-j")
   '("k" . "H-k")
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . save-buffer)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-reverse)
   '("Q" . meow-goto-line)
   '("r" . replace-char-or-meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   ;; '("v" . meow-visit)
   '("v" . goto-char-2-right)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . goto-last-change)
   '("Z" . goto-last-change-reverse)
   '("'" . er/expand-region)
   '("`" . goto-char-2-right)
   ;; my shortcuts
   '("\\" . comment-line)
   '("/" . "M-s")
   '("=" . end-delete)
   '("<" . embrace-commander)
   ;; my shortcuts ends
   '("<escape>" . mode-line-other-buffer))
    (meow-thing-register 'angle '(regexp "<" ">") '(regexp "<" ">"))
    (add-to-list 'meow-char-thing-table '(?a . angle)))

(require 'meow)
(meow-setup)
(meow-global-mode 1)

(diminish 'which-key-mode)
(diminish 'projectile-mode)
(diminish 'eldoc-mode)
(diminish 'subword-mode)
(diminish 'helm-mode)
(diminish 'yas-minor-mode)
(diminish 'hungry-delete-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-color-background "#3E4452")
 '(company-quickhelp-color-foreground "#ABB2BF")
 '(custom-safe-themes
   '("64204b9e3ad01000654d5524d2904fc8fa28aafc168f48660897ddfe36a2bfd5" "6c01b5d4faa0f143055e63c9fba8e23e9160f181e54b14b46d56410811edbc9e" "6ed8a3705a4296955010ecfcf808f02ac0d52985373e07c63f7fe5bc85206bb4" "f7b6b207d7a6318ea5d33ca2dea51483350d0c26beb986f008d63258b9c112ab" "d9c038dc91688c433de8e83709449563ec6475b900a21d7016856035ae4dcd32" "0d12b08dec64641c5df1a13d2c52ad678f6235a9b1c86041ea457fc1a71651dc" "2d09bd884d697b48b380b48117ccaebd8e99fe1cb242e31675dcec5724c603f6" "f84dbe5cfa80aa6774c57fef30d76bcdeb71bd0077665fb74f75728c42f5675d" "2ef84b2c7ad4810912a095993ca8bdf386e1fd7f97842b57aac62dddb2bba211" "71acf47cc8cd4158e52ef63a9f8c4d128aa33d6772a0106b5a72757486047e08" "65a1a112abd99456167df57ce2cfff42ed137c4f9146e75b2ae9812499689c3a" "9b64a681308383067359cf06bfa6a1bc4fa75c5b68182e4d6ba4d1816277d70e" "b95f61aa5f8a54d494a219fcde9049e23e3396459a224631e1719effcb981dbd" "0170347031e5dfa93813765bc4ef9269a5e357c0be01febfa3ae5e5fcb351f09" "788121c96b7a9b99a6f35e53b7c154991f4880bb0046a80330bb904c1a85e275" "b5fab52f16546a15f171e6bd450ff11f2a9e20e5ac7ec10fa38a14bb0c67b9ab" "2d035eb93f92384d11f18ed00930e5cc9964281915689fa035719cab71766a15" "f490984d405f1a97418a92f478218b8e4bcc188cf353e5dd5d5acd2f8efd0790" "28a104f642d09d3e5c62ce3464ea2c143b9130167282ea97ddcc3607b381823f" "35c096aa0975d104688a9e59e28860f5af6bb4459fd692ed47557727848e6dfe" "5a00018936fa1df1cd9d54bee02c8a64eafac941453ab48394e2ec2c498b834a" "249e100de137f516d56bcf2e98c1e3f9e1e8a6dce50726c974fa6838fbfcec6b" "06ed754b259cb54c30c658502f843937ff19f8b53597ac28577ec33bb084fa52" "e266d44fa3b75406394b979a3addc9b7f202348099cfde69e74ee6432f781336" "e8567ee21a39c68dbf20e40d29a0f6c1c05681935a41e206f142ab83126153ca" "a131602c676b904a5509fff82649a639061bf948a5205327e0f5d1559e04f5ed" "c95813797eb70f520f9245b349ff087600e2bd211a681c7a5602d039c91a6428" "2ce76d65a813fae8cfee5c207f46f2a256bac69dacbb096051a7a8651aa252b0" "11cc65061e0a5410d6489af42f1d0f0478dbd181a9660f81a692ddc5f948bf34" "9cd57dd6d61cdf4f6aef3102c4cc2cfc04f5884d4f40b2c90a866c9b6267f2b3" "74e2ed63173b47d6dc9a82a9a8a6a9048d89760df18bc7033c5f91ff4d083e37" "f00a605fb19cb258ad7e0d99c007f226f24d767d01bf31f3828ce6688cbdeb22" "6128465c3d56c2630732d98a3d1c2438c76a2f296f3c795ebda534d62bb8a0e3" "d516f1e3e5504c26b1123caa311476dc66d26d379539d12f9f4ed51f10629df3" "3c7a784b90f7abebb213869a21e84da462c26a1fda7e5bd0ffebf6ba12dbd041" "30dc9873c16a0efb187bb3f8687c16aae46b86ddc34881b7cae5273e56b97580" "dde643b0efb339c0de5645a2bc2e8b4176976d5298065b8e6ca45bc4ddf188b7" "bfc0b9c3de0382e452a878a1fb4726e1302bf9da20e69d6ec1cd1d5d82f61e3d" "e09401ab2c457e2e4d8b800e1c546dbc8339dc33b2877836ba5d9b6294ae6e55" "d2b7abf3fb8e9505a478a04bd6d727a029cab49d58c0fafe271293d095438067" "6976ce7d103d13c56a79cd0305f743ac880dafd52124a05f7163f51bca84e256" "22c213e81a533c259127302ef1e0f2d1f332df83969a1f9cf6d5696cbe789543" "3741b7bfab715b2e62d12ed0b129c6f8345d60f056fce2c0a5de24822876f854" "935cd704a3b4b12c9c0582da1d25437e2802d0f82c5d46de0eb5a968dfad08da" "347313c47366c3cb305fb63dff7df87426061d5529a86c215086fe8581228733" "2a0669753764cc15b818fc882d271fc30850d5a45220a499fb9d835846001b7c" "4e7672ce1015731d9d6955652f8f1b438420f109d15f662a014fa4e992429b9a" "45611797b789abf53e97c43b29c7f10dd6f18971e238e700bc885e702531053a" "04a9d8ab1ba3288f88018d1a2ba84be4c21a3b3c0b479005ac2b2ee7d417caa3" "931ee45708e894d5233fc4a94ae0065c765c1a0aeb1bd8d9feee22f5622f44b4" "9dbd2c6f93cc1774c261f23042be8bf7decc8f6599c21189c04d7791231b2b79" "c01cd0485ce35cf0a19ab91146d2c2b6528ec60ad4c8ffec5b2b7cc4bc05bd80" "01f52ed4dc9cfd4f397eda57c9eb5fea360bd6c18a2684121cc47279bfca5a51" "5ca9d0a5971e42ecee31398533e5b9dfc01c61a69bf3fd69395aa189c792252e" "c77866b9ee1cc2fd95cfb55fe99813b95c10f620f51f210de96c8b8bdead4c46" default))
 '(fci-rule-color "#3E4451")
 '(highlight-indent-guides-method 'character)
 '(highlight-tail-colors ((("#393b35") . 0) (("#343b40") . 20)))
 '(jdee-db-active-breakpoint-face-colors (cons "#19181A" "#FCFCFA"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#19181A" "#A9DC76"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#19181A" "#727072"))
 '(livedown-autostart nil)
 '(livedown-browser nil)
 '(livedown-open t)
 '(livedown-port 1337)
 '(lsp-file-watch-ignored-directories
   '("[/\\\\]\\.git\\'" "[/\\\\]\\.github\\'" "[/\\\\]\\.circleci\\'" "[/\\\\]\\.hg\\'" "[/\\\\]\\.bzr\\'" "[/\\\\]_darcs\\'" "[/\\\\]\\.svn\\'" "[/\\\\]_FOSSIL_\\'" "[/\\\\]\\.idea\\'" "[/\\\\]\\.ensime_cache\\'" "[/\\\\]\\.eunit\\'" "[/\\\\]\\.yarn\\'" "[/\\\\]\\.fslckout\\'" "[/\\\\]\\.tox\\'" "[/\\\\]dist\\'" "[/\\\\]dist-newstyle\\'" "[/\\\\]\\.stack-work\\'" "[/\\\\]\\.bloop\\'" "[/\\\\]\\.metals\\'" "[/\\\\]target\\'" "[/\\\\]\\.ccls-cache\\'" "[/\\\\]\\.vscode\\'" "[/\\\\]\\.venv\\'" "[/\\\\]\\.mypy_cache\\'" "[/\\\\]\\.deps\\'" "[/\\\\]build-aux\\'" "[/\\\\]autom4te.cache\\'" "[/\\\\]\\.reference\\'" "bazel-[^/\\\\]+\\'" "[/\\\\]\\.lsp\\'" "[/\\\\]\\.clj-kondo\\'" "[/\\\\]\\.shadow-cljs\\'" "[/\\\\]\\.babel_cache\\'" "[/\\\\]\\.cpcache\\'" "[/\\\\]\\checkouts\\'" "[/\\\\]\\.gradle\\'" "[/\\\\]\\.m2\\'" "[/\\\\]bin/Debug\\'" "[/\\\\]obj\\'" "[/\\\\]_opam\\'" "[/\\\\]_build\\'" "[/\\\\]\\.elixir_ls\\'" "[/\\\\]\\.direnv\\'"))
 '(objed-cursor-color "#CC6666")
 '(org-capture-templates
   '(("s" "structure" table-line
      (file "~/org/structure.org")
      "")
     ("n" "notes" entry
      (file "~/org/notes.org")
      "* Notes %?")
     ("t" "todo" entry
      (file+headline "/home/krishna/.emacs.d/todo.org" "Tasks")
      "* TODO [#A] %?")))
 '(package-selected-packages
   '(all-the-icons tuareg caml merlin haskell-mode rg poet-theme rust-mode compat orderless embrace expand-region wfnames nerd-icons pretty-mode all-the-icons-dired-mode all-the-icons-dired posframe popup meow js2-mode ivy ht helm-core git-commit f emacsql-sqlite emacsql dash bind-key async all-the-icons-nerd-fonts kaolin-themes treemacs-all-the-icons auto-yasnippet vterm string-inflection ligature sort-words origami mood-line consult consult-projectile vertico tree-sitter-langs tree-sitter company cape magit org-bullets denote treemacs markdown-mode tide web-mode flycheck typescript-mode goto-chg pulsar modus-themes atom-one-dark-theme crystal-mode reformatter dart-server flutter lsp-dart dart-mode fish-mode beacon doom-themes lua-mode emacsql-sqlite3 key-chord simple-modeline hungry-delete pandoc-mode highlight-indentation gruvbox-theme helm yasnippet multiple-cursors diminish mark-multiple projectile dashboard rainbow-delimiters which-key use-package rjsx-mode rainbow-mode prettier-js emmet-mode avy))
 '(rustic-ansi-faces
   ["#2D2A2E" "#CC6666" "#A9DC76" "#FFD866" "#78DCE8" "#FF6188" "#78DCE8" "#FCFCFA"])
 '(tetris-x-colors
   [[229 192 123]
    [97 175 239]
    [209 154 102]
    [224 108 117]
    [152 195 121]
    [198 120 221]
    [86 182 194]])
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#cc6666")
     (40 . "#de935f")
     (60 . "#f0c674")
     (80 . "#b5bd68")
     (100 . "#8abeb7")
     (120 . "#81a2be")
     (140 . "#b294bb")
     (160 . "#cc6666")
     (180 . "#de935f")
     (200 . "#f0c674")
     (220 . "#b5bd68")
     (240 . "#8abeb7")
     (260 . "#81a2be")
     (280 . "#b294bb")
     (300 . "#cc6666")
     (320 . "#de935f")
     (340 . "#f0c674")
     (360 . "#b5bd68")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight regular :height 120 :width normal :foundry "UKWN" :family "Iosevka Comfy")))))
