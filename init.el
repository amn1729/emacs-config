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

(add-to-list 'load-path (expand-file-name "~/.emacs.d/highlight-indent-guides-master"))
(require 'highlight-indent-guides)
(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

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

;; Diminish
(use-package diminish)

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
  (setq pulsar-face 'pulsar-magenta)
  (setq pulsar-highlight-face 'pulsar-yellow)
  :init
  (pulsar-global-mode 1))

;; Hungry delete
(use-package hungry-delete
  :config
  (global-hungry-delete-mode))

;; simple modeline
(use-package simple-modeline
  :init
  (simple-modeline-mode 1))

;; Treemacs
(use-package treemacs
  :bind
  (:map global-map
	("C-c \\" . treemacs))
  :config
  (setq treemacs-project-follow-mode t))

(use-package treemacs-projectile
  :after (treemacs projectile))

;; Rust
(use-package rust-mode
  :init
  (setq rust-format-on-save t))

;; Crystal
;; (use-package crystal-mode)

;; Fish shell
(use-package fish-mode)
;; Org
(setq org-src-preserve-indentation t)

;; lsp-mode
;; (use-package lsp-mode
;;   :ensure t
;;   :hook (
;; 	 (web-mode . lsp-deferred)
;; 	 (lsp-mode . lsp-enable-which-key-integration)
;; 	 )
;;   :commands lsp-deferred)


;; (use-package lsp-ui
;;   :ensure t
;;   :commands lsp-ui-mode)
;; (setq lsp-log-io nil) ;; Don't log everything = speed
;; (setq lsp-keymap-prefix "C-c l")
;; (setq lsp-restart 'auto-restart)
;; (setq lsp-ui-sideline-show-diagnostics t)
;; (setq lsp-ui-sideline-show-hover t)
;; (setq lsp-ui-sideline-show-code-actions t)

;; Denote
(use-package denote
  :config
  (setq denote-directory (expand-file-name "/mnt/projects/Notes")))
(global-set-key (kbd "C-c n") 'denote-open-or-create)

;; Org Bullets
(use-package org-bullets
  :hook
  (org-mode . org-bullets-mode))


;; Org Roam
;; (use-package org-roam
;;   :init
;;   (setq org-roam-v2-ack t)
;;   :custom
;;   (org-roam-directory "~/.emacs.d/notes")
;;   :bind (("C-c n l" . org-roam-buffer-toggle)
;;          ("C-c n f" . org-roam-node-find)
;;          ("C-c n i" . org-roam-node-insert))
;;   :config
;;   (org-roam-setup))

;; Rainbow
;; rainbow-mode
(use-package rainbow-mode
  :init (rainbow-mode 1))

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
  (setq dashboard-startup-banner "/home/krishna/.emacs.d/gnu.png")
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents . 6)
			              (projects . 12)))
  )
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))


;; Goto last change
(use-package goto-chg)

;; Avy
(use-package avy
  :config
  (setq avy-background t))

;; Ace jump
;; (use-package ace-jump-mode)

;; Swiper
(use-package swiper
  :bind("M-s" . swiper))

;; Projectile
(use-package projectile
  :init
  (setq projectile-sort-order 'acces-time)
  ;; (setq projectile-indexing-method 'alien)
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode 1)
  :bind
  ("C-z" . 'projectile-find-file))

;; Which-key
(use-package which-key
  :init
  (which-key-mode))

;; Helm
(use-package helm
  :bind
  ("C-x C-b" . 'helm-buffers-list)
  ("C-c f" . 'helm-find-files)  
  :config
  (add-to-list 'display-buffer-alist
               '("*Help*" display-buffer-same-window))
  (helm-mode 1))

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

;; Web dev
;; emmet
(use-package emmet-mode
  :init
  (emmet-mode 1)
  :bind ("C-j" . emmet-expand-line))

;; Svelte
(use-package svelte-mode)

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

;; Typescript
(use-package typescript-mode
  :init
  (add-hook 'typescript-mode-hook (lambda ()
                                    (when (string-equal "tsx" (file-name-extension buffer-file-name))
                                      (define-key typescript-mode-map "<" 'tsx-electric-lt))))
  :mode (("\\.ts\\'" . typescript-mode)
         ("\\.tsx\\'" . typescript-mode))
  :hook (typescript-mode . setup-tide-mode))

(use-package tide)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  ;; (flycheck-mode +1)
  ;; (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
;; (add-hook 'before-save-hook 'tide-format-before-save)
;; (add-hook 'typescript-mode-hook 'js-mode)   

;; (use-package flycheck
;;   :config
;;   (add-hook 'typescript-mode-hook 'flycheck-mode))

;; ;; Web mode
(use-package web-mode
  :mode (("\\.html?\\'" . web-mode))
  :init
  (add-hook 'web-mode-hook (lambda ()
                             (when (string-equal "tsx" (file-name-extension buffer-file-name))
                               ;; (setup-tide-mode)
                               (define-key web-mode-map "<" 'tsx-electric-lt)

                    )))
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
  :mode "\\.js\\'")

;; prettier-js
(use-package prettier-js
  :after (:any rjsx-mode svelte-mode)
  :hook ((rjsx-mode . prettier-js-mode)
	     (web-mode . prettier-js-mode)
	     (tide-mode . prettier-js-mode)
	     (svelte-mode . prettier-js-mode))
  :config
  (add-hook 'rjsx-mode-hook (lambda()
                              (flycheck-add-mode 'javascript-eslint 'rjsx-mode)))
  :diminish prettier-js-mode)

;; Auto-start on any markup modes
(add-hook 'sgml-mode-hook 'emmet-mode)

;; enable Emmet's css abbreviation.
(add-hook 'css-mode-hook  'emmet-mode)

;; ;; python
;; (use-package py-autopep8
;;   :hook (python-mode . py-autopep8-enable-on-save))

;; Custom functions
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

;; goto-char-right
(defun goto-char-right ()
  (interactive)
  (call-interactively 'avy-goto-char-2)
  (right-char))
(global-set-key (kbd "C-c q") 'goto-char-right)

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
  (other-window 1)
  )

(defun split-below-and-move ()
  (interactive)
  (split-window-below)
  (other-window 1)
  )

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

;; yasnippets
(use-package yasnippet
  :config
  (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
  (yas-global-mode 1))

;; Custom shortcuts

;; avy copy line
(global-set-key (kbd "C-c l") 'avy-copy-line)

;; avy copy region
(global-set-key (kbd "C-c r") 'avy-copy-region)

;; avy move line
(global-set-key (kbd "C-c a") 'avy-move-line)

;; avy move region
(global-set-key (kbd "C-c w") 'avy-move-region)

;; ;; exit insert mode
;; (global-set-key (kbd "C-z") (kbd "<escape>"))

(global-set-key (kbd "C-c b") 'beginning-of-buffer)
(global-set-key (kbd "C-c e") 'end-of-buffer)
(global-set-key (kbd "C-c /") 'comment-line)
(global-set-key (kbd "C-c p") 'point-to-register)
(global-set-key (kbd "C-c v") 'jump-to-register)
(global-set-key (kbd "C-c z") 'projectile-find-file)

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
(global-set-key (kbd "C-c s") 'save-buffer)
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
   '(";" . meow-reverse)
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
   '("q" . save-buffer)
   '("Q" . meow-goto-line)
   '("r" . replace-char-or-meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . goto-last-change)
   '("Z" . goto-last-change-reverse)
   '("'" . repeat)
   '("`" . goto-char-right)
   ;; my shortcuts
   '("\\" . comment-line)
   '("/" . "M-s")
   ;; my shortcuts ends
   '("<escape>" . mode-line-other-buffer))
  )

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

;; theme setting
;; (setq modus-themes-mode-line '(borderless))
;; (setq modus-themes-region '(bg-only))
;; (setq modus-themes-syntax '(alt-syntax))
;; (load-theme 'modus-vivendi t)

;; (setq ef-themes-to-toggle '(ef-spring ef-winter))
(setq ef-themes-to-toggle '(ef-trio-light ef-winter))

(mapc #'disable-theme custom-enabled-themes)
;; (load-theme 'ef-summer t)
(load-theme 'ef-winter t)
(ef-themes-select 'ef-winter)

;; (global-set-key (kbd "C-c t") 'modus-themes-toggle)
(global-set-key (kbd "C-c t") 'ef-themes-toggle)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#21252B" "#E06C75" "#98C379" "#E5C07B" "#61AFEF" "#C678DD" "#56B6C2" "#ABB2BF"])
 '(company-quickhelp-color-background "#3E4452")
 '(company-quickhelp-color-foreground "#ABB2BF")
 '(custom-safe-themes
   '("d2b7abf3fb8e9505a478a04bd6d727a029cab49d58c0fafe271293d095438067" "6976ce7d103d13c56a79cd0305f743ac880dafd52124a05f7163f51bca84e256" "22c213e81a533c259127302ef1e0f2d1f332df83969a1f9cf6d5696cbe789543" "3741b7bfab715b2e62d12ed0b129c6f8345d60f056fce2c0a5de24822876f854" "935cd704a3b4b12c9c0582da1d25437e2802d0f82c5d46de0eb5a968dfad08da" "347313c47366c3cb305fb63dff7df87426061d5529a86c215086fe8581228733" "2a0669753764cc15b818fc882d271fc30850d5a45220a499fb9d835846001b7c" "4e7672ce1015731d9d6955652f8f1b438420f109d15f662a014fa4e992429b9a" "45611797b789abf53e97c43b29c7f10dd6f18971e238e700bc885e702531053a" "04a9d8ab1ba3288f88018d1a2ba84be4c21a3b3c0b479005ac2b2ee7d417caa3" "931ee45708e894d5233fc4a94ae0065c765c1a0aeb1bd8d9feee22f5622f44b4" "9dbd2c6f93cc1774c261f23042be8bf7decc8f6599c21189c04d7791231b2b79" "c01cd0485ce35cf0a19ab91146d2c2b6528ec60ad4c8ffec5b2b7cc4bc05bd80" "01f52ed4dc9cfd4f397eda57c9eb5fea360bd6c18a2684121cc47279bfca5a51" "5ca9d0a5971e42ecee31398533e5b9dfc01c61a69bf3fd69395aa189c792252e" "c77866b9ee1cc2fd95cfb55fe99813b95c10f620f51f210de96c8b8bdead4c46" default))
 '(exwm-floating-border-color "#413f42")
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
   '(lsp-ui company cape corfu magit org-bullets denote treemacs vterm ef-themes markdown-mode tide web-mode flycheck typescript-mode goto-chg pulsar modus-themes svelte-mode atom-one-dark-theme crystal-mode reformatter dart-server flutter lsp-dart dart-mode fish-mode beacon doom-themes lua-mode emacsql-sqlite3 key-chord simple-modeline hungry-delete pandoc-mode highlight-indentation gruvbox-theme helm rust-mode yasnippet multiple-cursors diminish mark-multiple projectile swiper dashboard rainbow-delimiters which-key use-package rjsx-mode rainbow-mode prettier-js emmet-mode avy))
 '(pdf-view-midnight-colors '("#fdf4c1" . "#282828"))
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
;; (custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
;; '(default ((t (:inherit nil :extend nil :stipple nil :background "#20202a" :foreground "#ABB2BF" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "CTDB" :family "JetBrains Mono")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )