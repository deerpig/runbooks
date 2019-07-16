;; Deerpig's Crufty .emacs
;; This dot emacs is a poor example 

;; set the default font -- for unicode-2 emacs

(set-default-font "Deja Vu Sans Mono-12")
;;(require 'unicode-fonts)
;;(unicode-fonts-setup)

 ;;    (set-fontset-font (frame-parameter nil 'font)
 ;;      'han '("cwTeXHeiBold" . "unicode-bmp"))

(eval-when-compile
  (require 'package))
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")
             '("melpa" . "http://melpa.milkbox.net/packages/"))


(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(package-initialize)

;; Load Config Files ====================================

(load "~/.emacs-user-info")
;;(load "~/.emacs-muse")
;;(load "~/.emacs-planner")
;;(load "~/.emacs-bbdb")
;;(load "~/.emacs-packages")

;; Bootstrap 'use-package'

(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(defun my-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my-minibuffer-exit-hook ()
  (setq gc-cons-threshold 800000))

(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)

;; i don't use XEmacs.  This file does not work with XEmacs.
(when (featurep 'xemacs)
  (error "This .emacs file does not work with XEmacs."))

(setq initial-scratch-message nil)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)

;; remove the strange white line between two fringes.
(set-face-attribute 'vertical-border nil :foreground (face-attribute 'fringe :background))

;; set the size of the fringe to half-with, the default is 8
;; which is a bit too big when working with multiple windows.

(fringe-mode 4)


;; Prefer UTF-8 over Latin-1
(set-language-environment 'english)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

;; work-around for error message:
;;  ad-handle-definition: `tramp-read-passwd' got redefined
(setq ad-redefinition-action 'accept)

;; work-around for error message:
;;  void-function fancy-diary-display
(setq diary-display-function 'diary-fancy-display)

;; Start the emacs-client
(server-start)

;; Window Splitting Preference

;; if you have a wide monitor, keep windows as tall and wide as
;; possible and open stuff horizontally rather than vertically.

;;  (setq split-height-threshold nil)
;;  (setq split-width-threshold 0)

;; use bash as the default shell
(setq shell-file-name "bash")
(setq explicit-shell-file-name shell-file-name)

(defun bash ()
  (interactive)
  (let ((binary-process-input t)
        (binary-process-output nil))
    (shell)))

(setq process-coding-system-alist (cons '("bash" . (raw-text-dos . raw-text-unix))
                    process-coding-system-alist))

;; Calendar Style
(setq european-calendar-style t)

;; emacsclient stuff to automatically open new frame and close and
;; clean everything up after you've finished

(add-hook 'server-switch-hook
	  (lambda nil
	    (let ((server-buf (current-buffer)))
	      (bury-buffer)
	      (switch-to-buffer-other-frame server-buf))))

(add-hook 'server-done-hook 'delete-frame)
(add-hook 'server-done-hook (lambda nil (kill-buffer nil)))


;; (global-set-key (kbd "s-0") 'insert-0)

;; (defun insert-0 ()
;;   "Inserts 〇 character"
;;   (interactive)
;;   (insert "〇"))

;; (global-set-key (kbd "M-[") 'insert-lq)

;; (defun insert-lq ()
;;   "Inserts a 「"
;;   (interactive)
;;   (insert "「"))

;; (global-set-key (kbd "M-]") 'insert-rq)

;; (defun insert-rq ()
;;   "Inserts a 」 character"
;;   (interactive)
;;   (insert "」"))

;; (defun insert-bib ()
;;   "Inserts file and keyword fields into a BibTex entry"
;;   (interactive)
;;   (insert "  file      = {~/htdocs/lib/},
;;   keywords  = {}"))

;; use ibuffer
;;(global-set-key (kbd "C-x C-b") 'ibuffer)
;;(autoload 'ibuffer "ibuffer" "List buffers." t)

(global-set-key (kbd "C-M-z") 'iconify-or-deiconify-frame)


;; Stuff for Firefox Conkeror
;;
;; use firefox as default browser
;; (setq browse-url-browser-function 'browse-url-firefox)

;; use iceweasel as default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

(setq x-select-enable-clipboard t) ;; consult clipboard on yanking
(menu-bar-enable-clipboard) ;; turn on the edit menus

;; use ido for buffer matching
;;(ido-mode 'buffer)
;;(setq ido-enable-flex-matching t)

(require 'cl)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "gray12" :foreground "green" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 118 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(cfw:face-day-title ((t :background "grey10")))
 '(cfw:face-default-content ((t :foreground "green2")))
 '(cfw:face-default-day ((t :weight bold :inherit cfw:face-day-title)))
 '(cfw:face-header ((t (:foreground "maroon2" :weight bold))))
 '(cfw:face-holiday ((t :background "grey10" :foreground "purple" :weight bold)))
 '(cfw:face-regions ((t :foreground "cyan")))
 '(cfw:face-saturday ((t :foreground "blue" :weight bold)))
 '(cfw:face-select ((t :background "blue4")))
 '(cfw:face-sunday ((t :foreground "red" :weight bold)))
 '(cfw:face-title ((t (:foreground "darkgoldenrod3" :weight bold :height 2.0 :inherit variable-pitch))))
 '(cfw:face-today ((t :foreground: "cyan" :weight bold)))
 '(cfw:face-today-title ((t :background "red4" :weight bold)))
 '(cfw:face-toolbar-button-off ((t :foreground "cyan" :weight bold)))
 '(cfw:face-toolbar-button-on ((t :foreground "Gray50" :weight bold)))
 '(chronos-notification ((t (:inherit warning :height 4.0))))
 '(chronos-notification-clock ((t (:inherit bold :height 5.0))))
 '(diredp-dir-heading ((t (:foreground "Yellow"))))
 '(diredp-dir-priv ((t (:foreground "cyan"))))
 '(diredp-exec-priv ((t nil)))
 '(diredp-no-priv ((t nil)))
 '(diredp-number ((t (:foreground "gainsboro"))))
 '(diredp-other-priv ((t nil)))
 '(diredp-rare-priv ((t nil)))
 '(diredp-read-priv ((t nil)))
 '(diredp-symlink ((t nil)))
 '(diredp-write-priv ((t nil)))
 '(mode-line ((t (:foreground "#030303" :background "#919191" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil))))
 '(nxml-attribute-value-face ((t (:inherit nxml-delimited-data-face :foreground "#FFA07A"))))
 '(nxml-comment-content-face ((t (:foreground "#FF7F24"))))
 '(nxml-comment-delimiter-face ((t (:inherit nxml-delimiter-face :foreground "#FF7F24"))))
 '(nxml-name-face ((nil (:foreground "#B0C4DE"))))
 '(org-agenda-column-dateline ((t (:inherit default))))
 '(org-block-begin-line ((t (:inherit org-meta-line :background "#002E3F" :foreground "dodger blue"))))
 '(org-date ((((class color) (background dark)) (:foreground "deep sky blue" :underline t))))
 '(org-done ((t (:foreground "DarkOrange1" :weight bold))))
 '(org-footnote ((t (:foreground "dark gray" :weight bold))))
 '(org-hide ((((background dark)) (:foreground "gray12"))))
 '(org-level-1 ((t (:inherit default :foreground "firebrick3" :weight semi-bold :height 1.2))))
 '(org-level-2 ((t (:inherit outline-2 :foreground "DodgerBlue1" :height 1.1))))
 '(org-level-3 ((t (:inherit outline-3 :foreground "maroon3" :height 1.07))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.03))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.03))))
 '(org-level-6 ((t (:inherit outline-6 :height 1.03))))
 '(org-level-7 ((t (:inherit outline-7 :height 1.03))))
 '(org-level-8 ((t (:inherit outline-8 :height 1.03))))
 '(org-quote ((t (:foreground "dark orange"))))
 '(org-special-keyword ((((class color) (min-colors 16) (background dark)) (:foreground "Yellow"))))
 '(org-todo ((t (:foreground "tomato" :weight bold))))
 '(org-warning ((t (:inherit outline-8)))))

;; Display visited file's path in the frame title
 (setq frame-title-format
       '((:eval (if (buffer-file-name)
		    (abbreviate-file-name (buffer-file-name))
		  "%b"))))

;; save a list of open files in ~/.emacs.desktop
;; save the desktop file automatically if it already exists
(setq desktop-save 'if-exists)
(desktop-save-mode 1)

;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(setq desktop-globals-to-save		
      (append '((extended-command-history . 30)
                (file-name-history        . 100)
                (grep-history             . 30)
                (compile-history          . 30)
                (minibuffer-history       . 50)
                (query-replace-history    . 60)
                (read-expression-history  . 60)
                (regexp-history           . 60)
                (regexp-search-ring       . 20)
                (search-ring              . 20)
                (shell-command-history    . 50)
                tags-file-name
                register-alist)))

;; Delete selection on insert
(delete-selection-mode +1)

;; files and buffers not to save
(setq desktop-buffers-not-to-save
        (concat "\\(" "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
	        "\\|\\.emacs\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble"
		"\\|\\.bbdb\\|\\.cyclic-tasks\\)$"))

   (add-to-list 'desktop-modes-not-to-save 'dired-mode)
   (add-to-list 'desktop-modes-not-to-save 'Info-mode)
   (add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
   (add-to-list 'desktop-modes-not-to-save 'fundamental-mode)

;; Use-Package =======================================================

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  (add-to-list 'yas-snippet-dirs (locate-user-emacs-file "snippets")))

;;(add-to-list 'warning-suppress-types '(yasnippet backquote-change))




;;  DIRED ============================================================
;;; Dired+
;; (setq diredp-hide-details-initially-flag nil)

;; (use-package dired+
;;   :ensure t
;;   :init)

;; ;;; Load dired-x stuff
;; (require 'dired-x)

;; (add-hook 'dired-load-hook 
;;           (function (lambda ()
;;                       (load "dired-x")
;;                       ;; Set dired-x variables here.  For example:
;;                       ;; (setq dired-guess-shell-gnutar "gtar")
;;                       (setq dired-omit-files-p t)
;;                       ;; (setq dired-x-hands-off-my-keys nil)
;;                       )))

;; Omit uninteresting files in dired
;; use M-o (toggle-omit-files) to show dot, and other files

;;(setq-default dired-omit-files-p nil) ; this is buffer-local variable

;;(setq dired-omit-files
;;       (concat dired-omit-files "\\|^\\..+$"))

;; Dired Details
;; (require 'dired-details)
;; (dired-details-install)

;; (global-set-key "\C-c\C-b" 'browse-url-of-dired-file)

;; (setq dired-recursive-deletes 'top)

;; Default for `ls switches' in Dired C-u s
;; Must contain `l'.  Hide group, owner, and make file sizes
;; human readable.  Adding an `a' will show hidden dot-files.

;; (setq dired-listing-switches "-la")

;; (add-hook 'dired-mode-hook
;; 	  (lambda ()
;; 	    ;; Set dired-x buffer-local variables here.  For example:
;; 	    ;; (dired-omit-mode 1)
;; 	    ))

;; (defun make-parent-directory ()
;;   "Make sure the directory of `buffer-file-name' exists."
;;   (make-directory (file-name-directory buffer-file-name) t))

;; (add-hook 'find-file-not-found-functions #'make-parent-directory)


;;; Autoload `dired-jump' and `dired-jump-other-window'.
;;; We autoload from FILE dired.el.  This will then load dired-x.el
;;; and hence define `dired-jump' and `dired-jump-other-window'.
;; (define-key global-map "\C-x\C-j" 'dired-jump)
;; (define-key global-map "\C-x4\C-j" 'dired-jump-other-window)

;; (autoload (quote dired-jump) "dired" "\
;;      Jump to Dired buffer corresponding to current buffer.
;;      If in a file, Dired the current directory and move to file's line.
;;      If in Dired already, pop up a level and goto old directory's line.
;;      In case the proper Dired file line cannot be found, refresh the Dired
;;      buffer and try again." t nil)

;; (autoload (quote dired-jump-other-window) "dired" "\
;;      Like \\[dired-jump] (dired-jump) but in other window." t nil)


;; list directories first in dired

;; (defun sof/dired-sort ()
;;   "Dired sort hook to list directories first."
;;   (save-excursion
;;    (let (buffer-read-only)
;;      (forward-line 2) ;; beyond dir. header  
;;      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max))))
;;   (and (featurep 'xemacs)
;;        (fboundp 'dired-insert-set-properties)
;;        (dired-insert-set-properties (point-min) (point-max)))
;;   (set-buffer-modified-p nil))

;;  (add-hook 'dired-after-readin-hook 'sof/dired-sort)

;;; Dired Sort menu
;; (add-hook 'dired-load-hook
;;            (lambda () (require 'dired-sort-menu)))

;; set scroll so that it scrolls the page one line at a time
;; (setq scroll-step 1)

;; Hide uninteresting files including dot files
;; M-o toggles between hidden and all files

;(random t)


;;guess shell command by file extension.
;; (setq dired-guess-shell-alist-user
;;       '(("\\.pdf\\'"  "evince")
;; 	("\\.ps\\'"   "evince")
;; 	("\\.djvu\\'" "djview")
;; 	("\\.mobi\\'" "fbreader")
;; 	("\\.epub\\'" "fbreader")
;; 	("\\.gif\\'"  "evince")
;; 	("\\.jpg\\'"  "viewnior")
;; 	("\\.jpeg\\'"  "viewnior")
;; 	("\\.png\\'"  "viewnior")
;; 	("\\.tif\\'"  "viewnior")
;; 	("\\.tiff\\'"  "viewnior")))

;;====================================;;
;; External path search
;;====================================;;
;;(add-to-list 'load-path "~/emacs-lisp")
;;(add-to-list 'load-path "~/emacs-lisp/test")
;;(add-to-list 'load-path "~/emacs-lisp/emacs-wiki-deerpig")
(add-to-list 'load-path "~/emacs-lisp/docs")
;;(add-to-list 'load-path "~/emacs-lisp/uri")
;;(add-to-list 'load-path "~/emacs-lisp/remember")
;;(add-to-list 'load-path "~/emacs-lisp/psgml")
;;(add-to-list 'load-path "~/emacs-lisp/ecb")
;;(add-to-list 'load-path "~/emacs-lisp/semantic")
;;(add-to-list 'load-path "~/emacs-lisp/tex")
;;(add-to-list 'load-path "~/emacs-lisp/ses")
;(add-to-list 'load-path "~/emacs-lisp/burr")
;;(add-to-list 'load-path "~/emacs-lisp/sxml-mode")
;;(add-to-list 'load-path "~/emacs-lisp/xpath")
;;(add-to-list 'load-path (expand-file-name "~/emacs-lisp/ngnus-0.2/lisp"))
;(add-to-list 'load-path (expand-file-name "~/emacs-lisp/w3/lisp"))
;;(add-to-list 'load-path "~/emacs-lisp/elib-1.0")
;;(add-to-list 'load-path "~/emacs-lisp/regexp-info")
;;(add-to-list 'load-path "~/emacs-lisp/edb")
;;(add-to-list 'load-path "~/emacs-lisp/xtla")
;;(add-to-list 'load-path "~/emacs-lisp/wl/elmo")
;;(add-to-list 'load-path "~/emacs-lisp/etask")
(add-to-list 'load-path "~/emacs-lisp/burs")
;;(add-to-list 'load-path "~/emacs-lisp/atom-blogger")
;;(add-to-list 'load-path "~/emacs-lisp/url")
;;(add-to-list 'load-path "~/emacs-lisp/emacs-atom-api")
;;(add-to-list 'load-path "~/emacs-lisp/nxhtml")
;;(add-to-list 'load-path "~/emacs-lisp/hyperbole")
;;(add-to-list 'load-path "~/emacs-lisp/emacs-jabber")
;;(add-to-list 'load-path "~/emacs-lisp/jd-el")
;;(add-to-list 'load-path "~/emacs-lisp/google-contacts")
;;(add-to-list 'load-path "~/emacs-lisp/multiple-cursors.el")
;;(add-to-list 'load-path "~/emacs-lisp/emacs-async")
;;(add-to-list 'load-path "~/emacs-lisp/helm")

;; visit term buffer

;; (defun visit-term-buffer ()
;;   "Create or visit a terminal buffer."
;;   (interactive)
;;   (if (not (get-buffer "*ansi-term*"))
;;       (progn
;;         (split-window-sensibly (selected-window))
;;         (other-window 1)
;;         (ansi-term (getenv "SHELL")))
;;     (switch-to-buffer-other-window "*ansi-term*")))

;;   (global-set-key (kbd "C-c t") 'visit-term-buffer)

;;====================================;;
;; Opening Stuff in Other Frames
;;====================================;;

;; a lot of this no longer works now that I'm using helm

;;(defun run-command-other-frame (command)
;;   "Run COMMAND in a new frame."
;;   (interactive "CC-x 5 M-x ")
;;   (select-frame (new-frame))
  ;; (call-interactively command)
;;   (call-interactively helm-M-x))

 ;; (global-set-key "\C-x5\M-x" 'run-command-other-frame)

(defun run-info-other-frame ()
   "Run INFO in a new frame."
   (interactive)
   (select-frame (new-frame))
   (info))

 (global-set-key "\C-x5\i" 'run-info-other-frame)

 (defun dired-jump-other-frame ()
    "Run dired-jump in a new frame.  Requires dired-x to be
installed"
    (interactive)
    (select-frame (new-frame))
    (dired-jump))


;; (defun my-bookmark-jump-other-frame (bookmark)
;;   "Jump to bookmark in another frame."
;;   (interactive
;;    (list (bookmark-completing-read "Jump to bookmark (in another frame)"
;;                                    bookmark-current-bookmark)))
;;    (select-frame (new-frame))
;;    (bookmark-jump bookmark))

;; (global-set-key "\C-x5\j" 'my-bookmark-jump-other-frame)


;; (defun my-bookmark-list-other-frame ()
;;   "Open bookmark list in another frame"
;;   (interactive)
;;   (bookmark-bmenu-list)
;;   (switch-to-buffer-other-frame "*Bookmark List*"))

;; (global-set-key "\C-x5\l" 'my-bookmark-list-other-frame)


;;  (defun wiki ()
;;     "Open the wiki table of contents in a new frame"
;;     (interactive)
;;     (select-frame (new-frame))
;;     (find-file "~/wiki/toc.muse"))

;; (define-key global-map "\C-x5\C-j" 'dired-jump-other-frame)

(defadvice bookmark-jump (after bookmark-jump activate)
  (let ((latest (bookmark-get-bookmark bookmark)))
    (setq bookmark-alist (delq latest bookmark-alist))
    (add-to-list 'bookmark-alist latest)))


 (defun find-file-as-root ()
  "Like `ido-find-file, but automatically edit the file with
root-privileges (using tramp/sudo), if the file is not writable by
user."
  (interactive)
  (let ((file (ido-read-file-name "Edit as root: ")))
    (unless (file-writable-p file)
      (setq file (concat "/sudo:root@localhost:" file)))
    (find-file file)))

;; or some other keybinding...
(global-set-key (kbd "C-x F") 'find-file-as-root)

;; Visual feedback on selections
(setq-default transient-mark-mode t)

;; Always end a file with a newline
(setq require-final-newline t)

;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

;; Enable wheelmouse support by default
(cond (window-system
       (mwheel-install)
))

;; get rid of yes-or-no questions - y or n is enough
(defalias 'yes-or-no-p 'y-or-n-p)

;; No, please, no tabs in my programs!
(setq indent-tabs-mode nil)

;; I kinda know my emacs
(setq inhibit-startup-message t)

;; Use aspell on Windows because I can't get hold of a compiled ispell
;;(setq ispell-program-name "/usr/bin/aspell")


(defun smart-open-line ()
  "Insert an empty line after the current line.
Position the cursor at its beginning, according to the current mode."
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))

(global-set-key [(shift return)] 'smart-open-line)

(defun smart-open-line ()
  "Insert an empty line after the current line.
Position the cursor at its beginning, according to the current mode."
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))

(global-set-key [(shift return)] 'smart-open-line)

(setq reftex-default-bibliography "~/")

          (setq reftex-texpath-environment-variables
                '("~/"))
          (setq reftex-bibpath-environment-variables
                '("~/"))

;;===================================;;
;; SLIME & QUACK
;;===================================;;

(add-hook 'emacs-lisp-mode-hook
	  '(lambda ()
	     (interactive)
	     (require 'eldoc)
	     (turn-on-eldoc-mode)
	     (pretty-lambdas)
	     (define-key emacs-lisp-mode-map [(control c) (x)] 'copy-eval-dwim-lisp)
	     ;; Default to auto-indent on Enter
	     (define-key emacs-lisp-mode-map [(control j)] 'newline)
	     (define-key emacs-lisp-mode-map [(control m)] 'newline-and-indent)))

(defun pretty-lambdas ()
  (font-lock-add-keywords
   nil `(("(\\(lambda\\>\\)"
	  (0 (progn (compose-region (match-beginning 1) (match-end 1)
				    ,(make-char 'greek-iso8859-7 107))
		    nil))))))

;; emacs-wget
(autoload 'wget "wget" "wget interface for Emacs." t)
(autoload 'wget-web-page "wget" "wget interface to download whole web page." t)


(setq time-stamp-format (concat "$Id %f %:y-%02m-%02dT%02H:%02M:%02S %u ("  
                          (downcase user-work-location-name) ") $"))

(add-hook 'message-mode-hook
          (lambda () (auto-fill-mode 1) (setq fill-column 60)))

;; Set directory on startup
 (cd "~/")

;; (defun call-occur()
;;   (interactive)
;;    (occur (concat "^  " (current-word) "[^\}]*\},")))

;;  (global-set-key (quote [f3]) 'call-occur)

;; Regexp Info Manual
(require 'info)
(setq Info-default-directory-list 
      (cons "~/emacs-lisp/regexp-info" Info-default-directory-list))
;; Elisp tutorial and manual
(require 'info)
(setq Info-default-directory-list 
      (cons "/usr/local/info" Info-default-directory-list))

(setq Info-default-directory-list 
     (cons "~/emacs-lisp/docs" Info-default-directory-list))


;; Load ReBuilder
(load "re-builder")

;; Unicode insert stuff
;;(load "~/emacs-lisp/unichars.el")
;;(load "~/emacs-lisp/unicode-glyph-list.el")
;;(load "~/emacs-lisp/xmlunicode.el")

;;(global-set-key [(control ?\;)] 'unicode-character-menu-insert)
;;(global-set-key [(control :)] 'unicode-character-shortcut-insert)
;;(global-set-key [(control f2)] 'unicode-greek-menu-insert)

;; Default setting
(setq default-major-mode 'text-mode)

(setq-default transient-mark-mode t)
;;(set-cursor-color "blue")

;; Keys for programming
(define-key ctl-x-map "l" 'goto-line)
;;(define-key ctl-x-map "w" 'emacs-wiki-mode)
;;(define-key global-map "\C-cb" 'build)

;; I'm tired of typing time-stamp
;; don't laugh, it works, but please tell me how to do it the right way...
;; (defun insert-time-stamp ()
;;   "Insert a time stamp at beginning of buffer"
;;   (interactive)
;;         (goto-char (point-min))
;; 	(insert "time-stamp: <>")
;;         (time-stamp)
;;         (goto-char (point-min))
;;         (kill-forward-chars 12)
;;         (goto-char (end-of-line)))


;; Disable the silly ring
(setq ring-bell-function '(lambda()))

;; Save/Read the desktop
(desktop-load-default)
(desktop-read)

;; Particular compilation for jikes and deployement command
(setq build-command "build.bat")

(defun build()
  "Call the build command as an extra compile command"
  (interactive)
  (progn
  (shell-command build-command)))

;;for Windows only
;;(setq compile-command "make.bat")

(global-font-lock-mode)

;; load tags
(if (file-exists-p "~/TAGS")
    (visit-tags-table "~/TAGS"))

;; loads abbrevs
(if (file-exists-p "~/.abbrev_defs")
    (read-abbrev-file "~/.abbrev_defs"))

;; emacs customization menu
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Info-additional-directory-list (quote ("~/local/info")))
 '(backup-directory-alist (quote (("." . "~/backup/emacs"))))
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(calendar-chinese-all-holidays-flag t)
 '(calendar-christian-all-holidays-flag nil)
 '(calendar-date-style (quote iso))
 '(case-fold-search t)
 '(change-log-version-info-enabled t)
 '(chronos-notification-bullet-indent "* ")
 '(chronos-notification-time 30)
 '(column-number-mode t)
 '(comics-select-list (quote ("dilbert" "doonesbury" "Calvin & Hobbes")))
 '(delete-old-versions t)
 '(diary-show-holidays-flag t)
 '(ebib-additional-fields
   (quote
    (crossref url url2 annote abstract keywords file timestamp doi issne issnp)))
 '(ebib-allow-identical-fields t)
 '(ebib-file-associations
   (quote
    (("pdf" . "envice")
     ("ps" . "envice")
     ("djvu" . "djview4")
     ("mobi" . "ebook-viewer")
     ("epub" . "ebook-viewer"))))
 '(ebib-preload-bib-files (quote ("/home/deerpig/org/prim/ref.bib")))
 '(elfeed-goodies/entry-pane-position (quote bottom))
 '(global-font-lock-mode t nil (font-lock))
 '(helm-surfraw-default-browser-function nil)
 '(helm-surfraw-duckduckgo-url "https://duckduckgo.com/?q=%s&kae=t&k5=2&kp=-1")
 '(jabber-connection-type (quote ssl))
 '(jabber-network-server "talk.google.com")
 '(jabber-nickname "deerpig@gmail.com")
 '(jabber-server "gmail.com")
 '(jabber-username "deerpig@gmail.com")
 '(kept-new-versions 4)
 '(kept-old-versions 4)
 '(org-agenda-files
   (quote
    ("~/proj/chenla/primer/index.org" "~/proj/chenla/hoard/read.org" "~/org/blog.org" "~/org/pnca.org" "~/org/farm.org" "~/org/refile.org" "~/org/contacts.org" "~/org/repozit.org" "~/org/kinto.org" "~/org/key.org" "~/org/links.org" "~/org/weather.org" "~/org/chenla.org" "~/org/path.org" "~/org/todo.org" "~/org/habits.org" "~/org/notes.org" "~/org/quotes.org" "~/org/diary.org" "~/org/holidays.org")))
 '(org-babel-load-languages (quote ((emacs-lisp . t))))
 '(org-display-internal-link-with-indirect-buffer nil)
 '(org-link-frame-setup
   (quote
    ((vm . vm-visit-folder-other-frame)
     (gnus . gnus-other-frame)
     (file . find-file))))
 '(org-open-non-existing-files t)
 '(org-return-follows-link t)
 '(org-structure-template-alist
   (quote
    (("s" "#+begin_src ?

#+end_src" "<src lang=\"?\">

</src>")
     ("e" "#+begin_example
?
#+end_example" "<example>
?
</example>")
     ("q" "#+begin_quote
?
#+end_quote" "<quote>
?
</quote>")
     ("v" "#+begin_verse
?
#+end_verse" "<verse>
?
/verse>")
     ("c" "#+begin_center
?
#+end_center" "<center>
?
/center>")
     ("l" "#+begin_latex
?
#+end_latex" "<literal style=\"latex\">
?
</literal>")
     ("L" "#+latex: " "<literal style=\"latex\">?</literal>")
     ("h" "#+begin_html
?
#+end_html" "<literal style=\"html\">
?
</literal>")
     ("H" "#+html: " "<literal style=\"html\">?</literal>")
     ("a" "#+begin_ascii
?
#+end_ascii")
     ("A" "#+ascii: ")
     ("i" "#+index: ?" "#+index: ?")
     ("I" "#+include %file ?" "<include file=%file markup=\"?\">")
     ("r" "#+begin_ruleset ?

#+end_ruleset" "<ruleset>

</ruleset>"))))
 '(org-tab-follows-link nil)
 '(package-selected-packages
   (quote
    (jinja2-mode yaml-mode exwm bongo google-this helm-mu helm-org-contacts helm-mu-contacts helm-contacts helm magit-todos yasnippet moz firefox-controller org-pdfview helm-ag web-mode php-mode transmission grab-x-link ox-tufte pandoc-mode tldr helm-firefox gitlab color-theme browse-at-remote ox-epub helm-projectile projectile spaceline dired-single auctex rainbow-delimiters rainbow-delimeters mastodon eyebrowse interleave org-ref org-octopress mu4e-alert magit buffer-move git dired-quick-sort pomidor dired-k git-timemachine helm-dictionary uuid helm-chronos chronos elfeed-org calfw iedit nyan-mode beacon hungry-delete expand-region which-key ox-reveal key-chord hydra helm-c-yasnippet gruvbox-theme gruvbox org-wiki helm-recoll helm-swoop avy-jump-mode wc-mode eshell-git-prompt helm-bibtex dictionary wwtime findr rainbow-mode quack csv-mode rnc-mode tidy twittering-mode lorem-ipsum boxquote define-word magithub uuidgen helm-unicode use-package cask ecukes feature-mode chef-mode graphviz-dot-mode pinboard-api sicp elfeed-goodies exec-path-from-shell peep-dired ledger-mode org bbdb typo sunrise-commander slime-clj slime powerline paredit org-plus-contrib org-magit org-bullets n3-mode mustache impatient-mode helm-rhythmbox hackernews git-gutter geiser esxml emms elnode elfeed ebib dired-ranger dired-details dired+ debbugs color-theme-approximate char-menu bookmark+)))
 '(pc-select-meta-moves-sexps t)
 '(pc-select-selection-keys-only t)
 '(pc-selection-mode t)
 '(planner-trunk-rule-list
   (quote
    ((planner-date-regexp nil
			  ("2005.*" "WorkStuff" "EmacsHack\\|PlannerHack")))))
 '(quack-default-program "guile")
 '(quack-fontify-style (quote plt))
 '(quack-global-menu-p nil)
 '(quack-pretty-lambda-p t)
 '(quack-programs
   (quote
    ("quile" "bigloo" "csi" "csi -hygienic" "gosh" "gsi" "gsi ~~/syntax-case.scm -" "guile" "guile\\" "kawa" "mit-scheme" "mred -z" "mzscheme" "mzscheme" "mzscheme -M errortrace" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi")))
 '(recentf-exclude
   (quote
    (".*.tidyrc" ".*.news.*" ".*.bbdb" "_hypb" "*.*w3.history")) t)
 '(recentf-max-menu-items 25)
 '(recentf-max-saved-items 150)
 '(safe-local-variable-values
   (quote
    ((org-export-html-style . "   <style type=\"text/css\">
html { font-family: Arial; font-size: 14pt; }
 body { margin-left: 35px; margin-right: 30px; }
 #postamble { font-size: 80%;}
</style>"))))
 '(send-mail-function (quote smtpmail-send-it))
 '(spice-output-local "Gnucap")
 '(spice-simulator "Gnucap")
 '(spice-waveform-viewer "Gwave")
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(tidy-shell-command "/usr/local/bin/tidy")
 '(time-stamp-active t)
 '(vc-handled-backends (quote (CVS)))
 '(version-control t)
 '(visible-bell t)
 '(wwtime-ampm
   (quote
    ("EST" "CST" "MST" "PST" "AKST" "EDT" "CDT" "MDT" "PDT" "AKDT")))
 '(wwtime-default-function (quote wwtime-default-current))
 '(wwtime-display (quote ("SEA" "JST" "PST" "EST")))
 '(wwtime-time-zone-aliases
   (quote
    (("Eastern Standard Time" "EST")
     ("Eastern Daylight Time" "EDT")
     ("Central Standard Time" "CST")
     ("Central Daylight Time" "CDT")
     ("Mountain Standard Time" "MST")
     ("Mountain Daylight Time" "MDT")
     ("Pacific Standard Time" "PST")
     ("Pacific Daylight Time" "PDT")
     ("Alaska Standard Time" "AKST")
     ("Alaska Daylight Time" "AKDT")
     ("SE Asia Standard Time" "SEA"))))
 '(wwtime-time-zones
   (quote
    (("ACST" 9.5 "AU Central Standard Time")
     ("ADT" -3 "Atlantic Daylight Time")
     ("AEST" 10 "AU Eastern Standard/Summer Time")
     ("AKDT" -8 "Alaska Standard Daylight Time")
     ("AKST" -9 "Alaska Standard Time")
     ("AST" -4 "Atlantic Standard Time")
     ("AWST" 8 "AU Western Standard Time")
     ("BST" 1 "British Summer Time")
     ("CDT" -5 "Central Daylight Saving Time")
     ("CEST" 2 "Central Europe Summer Time")
     ("CET" 1 "Central Europe Time")
     ("CST" -6 "Central Standard Time")
     ("EDT" -4 "Eastern Daylight Saving Time")
     ("EEST" 3 "Eastern Europe Summer Time")
     ("EET" 2 "Eastern Europe Time")
     ("EST" -5 "Eastern Standard Time")
     ("GMT" 0 "Greenwich Mean Time")
     ("HST" -10 "Hawaiian Standard Time")
     ("IST" 1 "Irish Summer Time")
     ("JST" 9 "Japan Standard Time")
     ("MDT" -6 "Mountain Daylight Saving Time")
     ("MSD" 4 "Moscow Summer Time")
     ("MSK" 3 "Moscow Time")
     ("MST" -7 "Mountain Standard Time")
     ("NZST" 12 "New Zealand Standard Time")
     ("PDT" -7 "Pacific Daylight Saving Time")
     ("PST" -8 "Pacific Standard Time")
     ("WEST" 1 "Western Europe Summer Time")
     ("WET" 0 "Western Europe Time")
     ("@" 1 "Swatch time")
     ("Y" -12 "Time zone Y")
     ("X" -11 "Time zone X")
     ("W" -10 "Time zone W")
     ("V" -9 "Time zone V")
     ("U" -8 "Time zone U")
     ("T" -7 "Time zone T")
     ("S" -6 "Time zone S")
     ("R" -5 "Time zone R")
     ("Q" -4 "Time zone Q")
     ("P" -3 "Time zone P")
     ("O" -2 "Time zone O")
     ("N" -1 "Time zone N")
     ("Z" 0 "Time zone Z")
     ("A" 1 "Time zone A")
     ("B" 2 "Time zone B")
     ("C" 3 "Time zone C")
     ("D" 4 "Time zone D")
     ("E" 5 "Time zone E")
     ("F" 6 "Time zone F")
     ("SEA" 7 "GMT +7 SE Asia Time")
     ("H" 8 "GMT +8 (Hong Kong)")
     ("I" 9 "Time zone I")
     ("K" 10 "Time zone K")
     ("L" 11 "Time zone L")
     ("M" 12 "Time zone M")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; External packages
;; Practical for the
;; next switch system...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; support for last-load files in [Files] menu
(setq enable-recent-files t)
;; support for buffer converion to HTML -> htmlize-buffer
;;(setq enable-htmlize t)
;; help for buffer switch
(setq enable-iswitch (not (= 21 emacs-major-version)))
;; Java help
;;(setq enable-jtemplate t)
;; Color theme
(setq enable-colortheme t)

;; Enable the mini buffer to resize automatically
;;(setq enable-minibuffer t)
;; Enabled single dired when browsing directory
;;(setq enable-singledired t)
;; Ecb Emacs Code Browser
;;(setq enable-ecb t)
;; Shell toggle
(setq enable-shell-toggle t)
;; Tex helper
(setq enable-tex t)

;; Recent files
(defun start-recent-files()
  "Start recent files"
  (progn
    (require 'recentf)
    (recentf-mode 1)))


;;(require 'dired-single)

;; Resize the mini buffer automatically
;; (defun start-minibuffer()
;;   (progn
;;     (require `rsz-mini)
;;     (resize-minibuffer-mode)))

;; (defun my-dired-init ()x
;;   "Bunch of stuff to run for dired, either immediately or when it's
;;   loaded."
;;   ;; <add other stuff here>
;;   (define-key dired-mode-map [return] 'joc-dired-single-buffer)
;;   (define-key dired-mode-map [mouse-1] 'joc-dired-single-buffer-mouse)
;;   (define-key dired-mode-map "^"
;;     (function
;;        (lambda nil (interactive) (joc-dired-single-buffer "..")))))

;; (defun start-singledired()
;;   (progn
;;     (require 'dired-single)
;;     (if (boundp 'dired-mode-map)
;;         (my-dired-init)
;;       ;; it's not loaded yet, so add our bindings to the load-hook
;;       (add-hook 'dired-load-hook 'my-dired-init))))


;;preview files in dired
;; (use-package peep-dired
;;   :ensure t
;;   :defer t ; don't access `dired-mode-map' until `peep-dired' is loaded
;;   :bind (:map dired-mode-map
;;               ("P" . peep-dired)))

;(setq peep-dired-cleanup-on-disable t)
;;(setq peep-dired-cleanup-eagerly t)
;(setq peep-dired-ignored-extensions '("mkv" "iso" "mp4" "avi" "wmv"))
;(define-key dired-mode-map [P] 'peep-dired)


;;(require 'scholia)
;(require 'burs)

(require 'info)
(setq Info-default-directory-list 
      (cons "~/emacs-lisp/burs" Info-default-directory-list))

;;(require 'chronometer)

;; RCIRC ============================================
;; Register Nick on IRC Servers

;; (rcirc-track-minor-mode 1)
;; (setq rcirc-default-nick "deerpig")
;; (setq rcirc-default-user-name "deerpig")
;; (setq rcirc-default-full-name "Brad Collins")
;; (setq rcirc-server-alist
;;       '(("irc.freenode.net" :channels ("#emacs" "#chenla"))
;; 	("irc.chenla.org" :nick "deerpig" :channels ("#chenla"))
;; 	("keyelementsg.irc.slack.com" :port 6697 :encryption tls
;; 	                            :password "keyelementsg.TK1ri6Z2InjMn6XcJYqI"
;; 	                              :channels ("#general" "random"))))
;; (setq rcirc-authinfo '(("freenode" nickserv "deerpig" "vegetasucks")
;; 		       ("keyelementsg.irc.slack.com" nickserv "deerpig" "keyelementsg.TK1ri6Z2InjMn6XcJYqI")))
;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;  Useful functions   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;convert a buffer from dos ^M end of lines to unix end of lines
(defun dos2unix ()
  (interactive)
    (goto-char (point-min))
      (while (search-forward "\r" nil t) (replace-match "")))

;vice versa
(defun unix2dos ()
  (interactive)
    (goto-char (point-min))
      (while (search-forward "\n" nil t) (replace-match "\r\n")))


(defun numfix ()
  (interactive)
    (goto-char (point-min))
      (while (re-search-forward "^\\([0-9].gif\\)" nil t)
	(replace-match (concat "000" (match-string 0)))))



;; User info
;; (setenv "USER" "deerpig")
;; (setq user-full-name "Brad Collins")
;; (setq user-mail-address "brad@studiojungle.net")

;;  (setq user-work-latitude "13.53.534N")
;;  (setq user-work-longitude "100.36.957E")
;;  (setq user-work-elevation "5M")
;;  (setq user-work-location-name "sui trong")


;; %:a  weekday name: `Monday'.		%#A gives uppercase: `MONDAY'
;; %3a  abbreviated weekday: `Mon'.	%3A gives uppercase: `MON'
;; %:b  month name: `January'.		%#B gives uppercase: `JANUARY'
;; %3b  abbreviated month: `Jan'.	%3B gives uppercase: `JAN'
;; %02d day of month
;; %02H 24-hour clock hour
;; %02I 12-hour clock hour
;; %02m month number
;; %02M minute
;; %#p  `am' or `pm'.			%P  gives uppercase: `AM' or `PM'
;; %02S seconds
;; %w   day number of week, Sunday is 0
;; %02y 2-digit year: `97'		%:y 4-digit year: `1997'
;; %z   time zone name: `est'.		%Z  gives uppercase: `EST'

;; Non-date items:
;; %%   a literal percent character: `%'
;; %f   file name without directory	%F  gives absolute pathname
;; %s   system name
;; %u   user's login name		%U  user's full name
;; %h   mail host name


;; (defun insert-stuff (name)
;;   (interactive "cInsert (D)ate,(E)mail,(I)SO,(N)ame,(F)ilename,(L)oc,(B)XID,(U)UID,(W)iki-note,(T)asks, Fix U(R)L")
;;   (insert (cond ((equal name ?d)(format-time-string "%3b-%m-%Y"))
;; 		((equal name ?e)(insert-email-address))
;; 		((equal name ?i)(format-time-string "%Y-%02m-%02dT%02H:%02M"))
;; 		((equal name ?n)(concat user-full-name " <" 
;;                   user-mail-address ">"))
;; 		((equal name ?f)(format "%s" (buffer-name)))
;; 		((equal name ?l)(concat (capitalize user-work-location-name)
;;                                    " (" user-work-latitude " " 
;;                                    user-work-longitude ")"))
                 
;;                  ((equal name ?b)(insert-bxid))
;;                  ((equal name ?u)(uuid)) 
;;                  ((equal name ?w)(format-time-string "notes-%Y-%m-%d"))
;;                  ((equal name ?t) (planner-authority-task-template))
;;                  ((equal name ?r) (burr-replace-url))
;; 		(t ((equal name ?i)(format-time-string "%Y-%02m-%02dT%02H:%02M"))))))
;; (global-set-key [f1] 'insert-stuff)


;; Inserts the date in the format 
(defun insert-email-address ()
  "Insert `user-email-address' at point."
  (interactive)
  (insert user-mail-address))

;; Inserts the date in the format 
(defun insert-iso ()
  "Insert date at point."
  (interactive)
  (insert (format-time-string "%Y-%02m-%02dT%02H:%02M")))

;; Inserts the date in the format 
(defun insert-date ()
  "Insert date at point."
  (interactive)
       (insert (format-time-string "%d.%m.%Y %H:%M")))

;; Inserts Unix Time

(defun insert-unix ()
  "Insert unix time at point."
  (interactive)
  (insert (format "%s" (float-time)))
  )

;; Insert Sig file of choice

(defun signature (name)
  (interactive "cSig: (M)ailing List Studio(J)ungle, (C)henla, (D)eerpig, (S)tandard")
  (goto-char (point-max))
  (insert "\n")
  (insert-file (cond ((equal name ?e) "~/brad_stuff/emacs.sig")
		     ((equal name ?j) "~/brad_stuff/studiojungle.sig")
		     ((equal name ?c) "~/brad_stuff/chenla.sig")
		     ((equal name ?d) "~/brad_stuff/deerpig.sig")
		     ((equal name ?d) "~/brad_stuff/mail-list.sig")
		     (t "~/brad_stuff/standard.sig"))))
;;(global-set-key [f2] 'signature)


;; Function to insert a commented seperator line: 
;;

(defun insert-comment-heading (comment)
  "Insert COMMENT, followed by \" ---...\".  The line will be
  commented based on which mode you are in." 
  (interactive "sComment: ")
  (insert  comment " " (make-string (- (window-width)
                                       (+ (length comment) 5)
                                       10)
                                    ?-))
  (comment-region (point-at-bol) (point-at-eol))
  (newline))

;; Load TeX File Header 
(load "filehdr.el" t t t)


;; (defun yub (command)
;;   "submit a url-command to yub-nub and return results in a Web Browser."
;;   (interactive "sCommand: ")
;;   (browse-url (concat "http://yubnub.org/parser/parse?command=" command))

;;   )

;;; Load the Chinese version of calendar
;; (require 'cal-china-x)

;;(require 'icalendar)

;;(load "~/emacs-lisp/mst-stamp.el")

;; Load YAML Mode for Burrs

;(require 'burr-mode)
;; (require 'burr-to-html)
;(require 'burr-to-blosxom)
;(require 'chenla-config)
;(require 'yaml-mode)
;(require 'burr-vc)
;(require 'burr-pg-convert)
;(require 'burr-langcode)
;(require 'scribe-to-sxml)
;(require 'scribe)

;(autoload 'skribe-mode "skribe.el" "Skribe mode." t)

;; this variable requires a trailing slash....
;(setq planner-bxid-path "~/work/bram/")

;(global-set-key "\C-h\C-b" 'burr-subfield-help)
;(global-set-key [(control f12)] 'burr-mode)
;(global-set-key [(control f11)] 'planner-mode)
;(global-set-key [(control f5)] 'insert-bxid-planner-links)

;(autoload 'burr-mode "burr-mode" "YAML Burr Editing Mode" t)
;(add-to-list 'auto-mode-alist '("\\.yml$" . burr-mode))
;(add-to-list 'auto-mode-alist '("\\.wiki$" . moinmoin-mode))
;(add-to-list 'auto-mode-alist '("\\.wikm$" . wikipedia-mode))
;(add-to-list 'auto-mode-alist '("\\.skb$" . scribe-mode))
;(add-to-list 'auto-mode-alist '("\\.bmf$" . emacs-lisp-mode))
;(add-hook 'burr-mode-user-hook 'turn-on-font-lock)

;; Add numbers to lines in buffer

  (defun numerotate-line ()
    (interactive)
    (let ((P (point))
  	(max (count-lines (point-min)(point-max)))
  	(line 1))
      (goto-char (point-min))
      (while (< line max)
        (insert (format "%04d " line))
        (beginning-of-line 2)
        (setq line (+ line 1)))
      (goto-char P)))

(put 'narrow-to-region 'disabled nil)

(defun print-list-of-numbers (num)
  "print a list of numbers starting with one."
  (interactive "nNumber: ")
  (setq beg-num 1)
  (while (<= beg-num num)
    (insert (format "  %s. \n" beg-num))
    (setq beg-num (1+ beg-num))))


(defun scratch ()
  "Select the `*scratch*' buffer."
  (interactive)
  (pop-to-buffer "*scratch*"))

(defun loan-payment-calculator (amount rate years)
"Calculate what the payments for a loan of AMOUNT dollars when
annual percentage rate is RATE and the term of the loan is
YEARS years.  The RATE should expressed in terms of the percentage 
\(i.e. \'8.9\' instead of \'.089\'\).  The total amount of
interest charged over the life of the loan is also given."
  (interactive "nLoan Amount: \nnAPR: \nnTerm (years): ")
  (let ((payment (/ (* amount (/ rate 1200)) (- 1 (expt (+ 1 (/ rate 1200)) (* years -12.0))))))
	 (message "%s payments of $%.2f. Total interest $%.2f" 
                  (* years 12) payment (- (* payment years 12) amount))))




;; UUID ====================================================
;; UUID generating functions.

(use-package uuid
  :ensure t)


(defun syntax-highlight-region (start end)
  "Adds <font> tags into the region that correspond to the
current color of the text.  Throws the result into a temp
buffer, so you don't dork the original."
  (interactive "r")
  (let ((text (buffer-substring start end)))
    (with-output-to-temp-buffer "*html-syntax*"
      (set-buffer standard-output)
      (insert "<pre>")
      (save-excursion (insert text))
      (save-excursion (syntax-html-escape-text))
      (while (not (eobp))
	(let ((plist (text-properties-at (point)))
	      (next-change
	       (or (next-single-property-change
		    (point) 'face (current-buffer))
		   (point-max))))
	  (syntax-add-font-tags (point) next-change)
	  (goto-char next-change)))
      (insert "\n</pre>"))))

(defun syntax-add-font-tags (start end)
  "Puts <font> tag around text between START and END."
  (let (face color rgb name r g b)
    (and
     (setq face (get-text-property start 'face))
     (or (if (listp face) (setq face (car face))) t)
     (setq color (face-attribute face :foreground))
     (setq rgb (assoc (downcase color) color-name-rgb-alist))
     (destructuring-bind (name r g b) rgb
       (let ((text (buffer-substring-no-properties start end)))
	 (delete-region start end)
	 (insert (format "<font color=#%.2x%.2x%.2x>" r g b))
	 (insert text)
	 (insert "</font>"))))))

(defun syntax-html-escape-text ()
  "HTML-escapes all the text in the current buffer,
starting at (point)."
  (save-excursion (replace-string "<" "&lt;"))
  (save-excursion (replace-string ">" "&gt;")))


;;(require 'xml-rpc)
;;(require 'lisppaste)

;;(require 'burs-utilities)

;; (use-package flash-paren
;;   :ensure t
;;   :config
;;    (flash-paren-mode 1))

(setq show-paren-delay 0)
(show-paren-mode t)
(setq blink-matching-paren t)
;;(setq blink-matching-paren-distance 256000)
;;(require 'flash-paren)


;; snarfed from Jon Philpott

(defun insert-multiple-yow (n)
  (interactive "nHow many: ")
  (dotimes (i n)
    (insert (yow))))

;; longlines mode

(autoload 'longlines-mode "longlines.el"
   "Minor mode for editing long lines." t)


;; send mail using message-mode when you're not in Gnus?

    (setq mail-user-agent 'message-user-agent)

;;(require 'tagging)


;; I always forget footnote commands start with a capital F!

(footnote-mode)

(defalias 'footnote-add-footnote 'Footnote-add-footnote)
(defalias 'footadd 'Footnote-add-footnote)
(defalias 'footback 'Footnote-back-to-message)
(defalias 'footdelete 'Footnote-delete-footnote)
(defalias 'footgoto  'Footnote-goto-footnote)
(defalias 'footnumber 'Footnote-renumber-footnotes)

(defun join-region (beg end)
   "Apply join-line over region."
   (interactive "r")
   (if mark-active
           (let ((beg (region-beginning))
                         (end (copy-marker (region-end))))
                 (goto-char beg)
                 (while (< (point) end)
                   (join-line 1)))))

;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
;;; Takes a multi-line paragraph and makes it into a single line of text.       
    (defun unfill-paragraph ()
      (interactive)
      (let ((fill-column (point-max)))
        (fill-paragraph nil)))

(global-set-key "\M-#" 'unfill-paragraph)


;;
;; n3 mode
(add-to-list 'load-path "~/emacs-lisp/n3-mode.el")
(autoload 'n3-mode "n3-mode" "Major mode for OWL or N3 files" t)

;; Turn on font lock when in n3 mode
(add-hook 'n3-mode-hook
          'turn-on-font-lock)

(setq auto-mode-alist
      (append
       (list
        '("\\.n3" . n3-mode)
        '("\\.owl" . n3-mode)
	'("\\.trig" . n3-mode))
       auto-mode-alist))

;; From Rodgrigo Lazo

(defun insert-path (file)
  "Inserts a path into the buffer with completion"
  (interactive "Path: ")
  (insert (expand-file-name file)))

(defun kill-entire-line (n)
  "Kill ARG entire lines starting from the one where point is."
  (interactive "*p")
  (beginning-of-line)
  (kill-line n))
(global-set-key "\M-k" 'kill-entire-line)

;;; ===============================
;;;  Browse Apropos URL

;;(require 'browse-apropos-url)
;;(provide 'browse-url)
;;(require 'thingatpt+)

;; Choose commands that mirror DuckDuckGo !bang commands when
;; possible.  !bang should go to search on a site.  !!bangbang should
;; just be a shortcut to a url.  If it's not a search link, default
;; both single and double bang prefix to home page.

;; (setq apropos-url-alist
;;       '( ;; DuckDuckGo is default search engine.
;; 	("^\??:? +\\(.*\\)" .       ;; "?" defaults to DuckDuckGo
;; 	 "http://duckduckgo.com/?q=\\1")
;; 	("^!ddg?:? +\\(.*\\)" .     ;; DuckDuckGo Search
;; 	 "http://duckduckgo.com/?q=\\1")
;;         ("^!!ddg"                   ;; DuckDuckGo Home Page
;; 	 "http://duckduckgo.com")
;; 	("^!bang$" .                ;; DuckDuckGo !bang Page
;; 	 "http://duckduckgo.com/bang.html")
;;         ;; Google Sites ;;;;;;;;;;;;;;;;;;;;;;
;; 	("^gw?:? +\\(.*\\)" .
;;          "http://www.google.com/search?q=\\1")
;; 	("^!g?:? +\\(.*\\)" . 	    ;; Google Web Search
;; 	 "http://www.google.com/search?q=\\1")
;;         ("^!!g$" . 	            ;; Google Home Page
;; 	 "http://google.com/")
;;         ("^!reader?:? +\\(.*\\)" .  ;; Search Google Reader
;;          "http://www.google.com/reader/view/#search/\\1")
;;         ("^!!reader$" .             ;; Google Reader Home
;;          "http://reader.google.com/")
;;         ("^!!voice$" .              ;; Google Voice
;;          "http://voice.google.com/")
;; 	("^!!gmail$" .              ;; GMail
;; 	 "http://mail.google.com/")
;; 	("^!gi:? +\\(.*\\)" .       ;; Google Images
;; 	 "http://images.google.com/images?sa=N&tab=wi&q=\\1")
;; 	("^!!gi$" .                 ;; Google Images
;; 	 "http://images.google.com/")
;; 	("^!gg:? +\\(.*\\)" .       ;; Google Groups
;; 	 "http://groups.google.com/groups?q=\\1")
;;         ("^!gn:? +\\(.*\\)" .       ;; Google News Search
;;          "http://news.google.com/news?sa=N&tab=dn&q=\\1")
;;         ("^!!gn$" .                 ;; Google News Home
;;          "http://news.google.com/")
;; 	;;Blekko ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;         ("^!blekko?:? +\\(.*\\)" .  ;; Blekko Search
;; 	 "http://blekko.com/ws/+\\1")
;; 	("^!!blekko$" .             ;; Blekko Home
;; 	 "http://blekko.com/")
;;         ;; Tech News ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 	("^!/\.$" . ;; Slashdot Home
;;          "http://www.slashdot.org")
;; 	("^!!/\.$" . ;; Slashdot Home
;;          "http://www.slashdot.org")
;;         ("^!bb$" . ;; Boing Boing Home
;;          "http://boingboing.net")
;;         ("^!!bb$" . ;; Boing Boing Home
;;          "http://boingboing.net")
;;         ;; Emacs ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 	("^!emacs:? +\\(.*\\)" . ;; Emacs Wiki Search
;;          "http://www.emacswiki.org/cgi-bin/wiki?search=\\1")
;;         ("^!!emacs$" . ;; Emacs Wiki Home
;;          "http://www.emacswiki.org")
;;         ;;Hacker News ;;;;;;;;;;;;;;;;;;;;;;;;
;; 	("^!hn:? +\\(.*\\)" . ;; Hacker News Search
;; 	"http://www.hnsearch.com/search#request/all&q=\\1")
;; 	("^!!hn$" . ;; Hacker News Home
;; 	"http://news.ycombinator.com")
;; 	;;Torrent Search ;;;;;;;;;;;;;;;;;;;;
;; 	("^!tpb:? +\\(.*\\)" . ;;The Pirate Bay
;; 	"http://thepiratebay.com/search/\\1")
;; 	("^!demon:? +\\(.*\\)" . ;; Demonoid Search
;; 	"https://www.demonoid.me/files/?query=\\1" )
;; 	("^!demonoid:? +\\(.*\\)" . ;; Demonoid Search
;; 	"https://www.demonoid.me/files/?query=\\1" )
;; 	("^!isohunt:? +\\(.*\\)" . ;;ISOHunt
;; 	"https://isohunt.com/torrents/?ihq=\\1" )
;; 	("^!cheggit:? +\\(.*\\)" . ;;Cheggit Search
;; 	"http://cheggit.net/browsetorrents.php?filter=all%3A%5B\\1" )
;; 	("^!!cheggit:? +\\(.*\\)" . ;;Cheggit Home
;; 	"http://cheggit.net/browsetorrents.php" )
;; 	("^!jpop:? +\\(.*\\)" . ;; JPopSuki Artist Search
;; 	"http://jpopsuki.eu/torrents.php?action=advanced&artistname=\\1" )
;; 	;; Content Companies ;;;;;;;;;;;;;;;;;
;; 	("^!amazon:? +\\(.*\\)" . ;; Amazon
;; 	"http://www.amazon.com/s/?&field-keywords=\\1" )
;; 	("^!imdb:? +\\(.*\\)" . ;; IMDB
;; 	"http://www.imdb.com/find?s=all&q=\\1" )
;;         ("^!tmdb:? +\\(.*\\)" . ;; The Movie Database
;; 	"http://www.themoviedb.org/search?search=\\1")
;;         ;; Add Later

;; 	))

;; ===Time Zones =======
;; see http://en.wikipedia.org/wiki/List_of_tz_database_time_zones
;; for list of time zones


(setq display-time-world-list
      '(("America/Los_Angeles" "San Diego")
	("America/New_York" "Boston")
	("Europe/London" "London")
	("Asia/Hong_Kong" "Hong Kong")
	("Asia/Bangkok" "Bangkok")
	("Asia/Tokyo" "Osaka")))

  (global-set-key (kbd "C-c T") 'display-time-world)

;; scratch.el -- create scratch buffer with same major mode as
;; buffer you created it from...

 (autoload 'scratch "scratch" nil t)


(defvar browse-url-firefox-program 'firefox)
(defvar browse-url-kde-program 'firefox)
(defvar browse-url-gnome-moz-program 'firefox)
(defvar browse-url-mozilla-program 'firefox)
(defvar browse-url-galeon-program 'firefox)
(defvar browse-url-netscape-program 'firefox)
(defvar browse-url-mosaic-program 'firefox)
(defvar browse-url-xterm-program 'firefox)

;; Set System time locale
(setq  system-time-locale 'ja_JP)


;; gitlab

;; (setq gitlab-host "https://git.chenla.org"
;;           gitlab-username "deerpig"
;;           gitlab-password "")


;; =========================================================
;; Load literate Org files
;; ---------------------------------------------------------

(load "~/.emacs-helm")
(load "~/.emacs-packages")
(load "~/.emacs-hydra")
(load "~/.emacs-mu4e")
(load "~/.emacs-org")
(load "~/.emacs-irc")
(load "~/.emacs-dired")
(load "~/.emacs-burs")
