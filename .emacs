;;-----------------------------------------------------------------------;;
;;                                 Basic
;;-----------------------------------------------------------------------;;

;;load path for personal files
(add-to-list 'load-path "~/.emacs.d/")

;; enable server mode
;(server-start)

;; add lots of nice feature from Common Lisp
(require 'cl)

;; set same buffer name as filename/path
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)

;; set text mode as the default major mode
(setq default-major-mode 'text-mode)

;; turn onauto fill minor mode whenever entering text mode
(add-hook 'text-mode-hook 'turn-on-auto-fill)
;; turn onauto fill minor mode for all major mode
;(setq-default auto-fill-function 'do-auto-fill)

;; turn on  refill minor mode whenever entering text mode
;(add-hook 'text-mode-hook (lambda ( ) (refill-mode 1)))

;; allow single space to end a sentence
(setq sentence-end-double-space nil)

;; allow emacs to exchange date with other apps
(setq x-select-enable-clipboard t)

;;; npen lisp debugger on error
(setq debug-on-error t)

;; replaced region text with what I type
(delete-selection-mode t)

;;-----------------------------------------------------------------------;;
;;                                 UI
;;-----------------------------------------------------------------------;;

;; hide the toolbar
(tool-bar-mode 0)

;; hide the scolling bar
(scroll-bar-mode nil)

;; hide the menu bar, if you are really a emacs guru
;(menu-bar-mode nil)

;; alwasy show buffer name in the title, even when only on frame exist
(setq frame-title-format "%b")

;;  Support Wheel Mouse Scrolling
(mouse-wheel-mode t)

;; do not show the annoying welcome splash!
(setq inhibit-splash-screen t)

;; for Windows : start with window maximized
;(defun w32-maximize-frame ()
;"Maximize the current frame"
;(interactive)
;(w32-send-sys-command 61488))
;(add-hook 'window-setup-hook 'w32-maximize-frame t)

;; for X11: start with window maximized
;; TODO : not really maxmized!!
(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)

;; another way for X11 : send raw command to WM
;(defun x11-maximize-frame ()
;"Maximize the current frame (to full screen)"
;(interactive)
;(x-send-client-message nil 0 nil "_NET_WM_STATE" 32 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
;(x-send-client-message nil 0 nil "_NET_WM_STATE" 32 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))
;(add-hook 'window-setup-hook 'x11-maximize-frame t)

;;-----------------------------------------------------------------------;;
;;                                 modeline
;;-----------------------------------------------------------------------;;


;; Show line-number in the mode line
(line-number-mode t)

;; Show column-number in the mode line
(column-number-mode t)

;; show file size in mode line
(size-indication-mode t)

;; show current time
(display-time-mode t)

;;-----------------------------------------------------------------------;;
;;                                 colorthemes
;;-----------------------------------------------------------------------;;


;; use different color theme for GUI and TTY
(if window-system
  ;; when GUI in run, use  nice color themes
  (progn
    (load-file "~/.emacs.d/themes/color-theme-almost-monokai.el")
    (color-theme-almost-monokai)
    )
  (require 'color-theme)
  (color-theme-initialize)
  (color-theme-dark-laptop)
  )

;(require 'color-theme)
;(eval-after-load "color-theme"
;'(progn
;(color-theme-initialize)
;(color-theme-hober)))

;;-----------------------------------------------------------------------;;
;;                                spell checking
;;-----------------------------------------------------------------------;;

;; use aspell to fulfil the ispell interface
(setq-default ispell-program-name "aspell")

;; check spelling error on the fly
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(autoload 'flyspell-delay-command "flyspell" "Delay on command." t)
(autoload 'tex-mode-flyspell-verify "flyspell" "" t)
;; turn on automatically for text mode
(add-hook 'text-mode-hook 'flyspell-mode)
;; for source code, only check the comments part
(add-hook 'c-mode-common-hook 'flyspell-prog-mode)
(add-hook 'python-mode-hook 'flyspell-prog-mode)

;; tell flyspell to ignore words composed of only  uppercase letter
;; useful for acronym, such as FOSS, GNU, etc
(defun jin-flyspell-ignore-uppercase (beg end &rest rest)
  (while (and (< beg end)
              (let ((c (char-after beg)))
                (not (= c (downcase c)))))
         (setq beg (1+ beg)))
  (= beg end))
(add-hook 'flyspell-incorrect-hook 'jin-flyspell-ignore-uppercase)


;;-----------------------------------------------------------------------;;
;;                                Abbreviation
;;-----------------------------------------------------------------------;;

;; turn on abbreviation mode
(setq-default abbrev-mode t)

;; save abbrevs when files are saved
(setq save-abbrevs t)


;; tell emacs where to read abbrev definitions
(setq abbrev-file-name "~/.emacs.d/abbrev.el")

;; load definitions
(read-abbrev-file  abbrev-file-name)

;;-----------------------------------------------------------------------;;
;;                                Visual clue
;;-----------------------------------------------------------------------;;

;;  highlight current line
(global-hl-line-mode t)

;; enable syntax highlighting globally
(global-font-lock-mode t)

;; perform  decoration just in time
(jit-lock-mode t )

;; apply decoration of  different level for different mode
;(setq font-lock-maximum-decoration
      ;( ('c-mode . t)
       ;('c++-mode . 2)
       ;('t . 1)
       ;)
      ;)

;; highlight matching parenthesis
(show-paren-mode t)

;; for the sake of color and font in shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; add line number column on the left side
(require 'linum)
(global-linum-mode)
;; another way : do not load until really needed
(autoload 'linum-mode "linum" "toggle line numbers on/off" t)
;; map C-<F5> to toggle this feature
(global-set-key (kbd "C-<f5>") 'linum-mode)
;; always enable this when opening perl script
(add-hook 'perl-mode-hook
          (lambda() (linum-mode 1)))


;; keep cursor at eol, as before pressing up/down
(setq track-eol t)

;;-----------------------------------------------------------------------;;
;;                                File
;;-----------------------------------------------------------------------;;

;;  do not create backup files with '~' suffix
(setq make-backup-files nil)

;; disable auto-save,
(setq auto-save-default nil)

;; put all autosaves in central places, avoding cluttering anywhere
(setq tramp-auto-save-directory "~/.emacs.d/tramp-autosave")

;;default path when opening file
(setq default-directory "~")

;; remember where the cursor is at for every file
(setq save-place-file "~/.emacs.d/saveplaces") ;; keep ~/ clean
(setq-default save-place t)                   ;; activate it for all buffers
(require 'saveplace)                          ;; get the package

;; load permenent macro definitions
(load-file "~/.emacs.d/macros.el")

;; do no put the custom result into .emacs
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; the default tab width is 8
;(setq-default tab-width 4)

;; the default indenet is 4 space
;(setq standard-indent 2)

;; only insert spaecs when TAB is pressed
(setq-default indent-tabs-mode nil)


;;-----------------------------------------------------------------------;;
;;                                Keybindings
;;-----------------------------------------------------------------------;;

;; the default keymapping M-g g is not convenient
(global-set-key "\M-g" 'goto-line)

;; % jump to matching pair, like in vim
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))


;;-----------------------------------------------------------------------;;
;;                                Misc
;;-----------------------------------------------------------------------;;

;; wrap automatically
(toggle-truncate-lines t)

;; wrap at the 78th column
(setq-default fill-column 78)


;; enable commands listed below
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'scroll-right 'disabled nil)

;; make <up> and <down> always scroll one line ; no smart centering
(setq scroll-step 2)

;; scroll only one line when cursor cross the bottom of screen
(setq scroll-conservatively most-positive-fixnum )

;; Handle .gz files
(auto-compression-mode t)

;; allow p-c-m to expand to partial-completion-mode by presssing TAB
(partial-completion-mode t)

; Update string in the first 8 lines looking like Timestamp: <> or " "
(add-hook 'write-file-hooks 'time-stamp)

(setq bookmark-default-file "~/.emacs.d/bookmarks") ;; keep  ~/ clean
(setq bookmark-save-flag 1)                         ;; autosave each change

;; no annoying beep !
(setq visible-bell t)

;;-----------------------------------------------------------------------;;
;;                                C
;;-----------------------------------------------------------------------;;

;; indent switch-case nicely
(c-set-offset 'case-label '+)

;; only show  lines that will be left after `#ifdef' are handled by preprocessro
(hide-ifdef-mode t )



;------------------------ added by Custom Interface ---------------------------------
;------------------------ DO NOT Edit MANUALLY!!!!! ---------------------------------

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(default ((t (:inherit nil :stipple nil :background "#c8d4ba" :foreground "#000000" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 109 :width normal :foundry "unknown" :family "DejaVu Sans YuanTi Mono")))))

;(custom-set-variables
;;; custom-set-variables was added by Custom.
;;; If you edit it by hand, you could mess it up, so be careful.
;;; Your init file should contain only one such instance.
;;; If there is more than one, they won't work right.
;'(size-indication-mode t))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
  '(column-number-mode t)
  '(display-time-mode t)
  '(show-paren-mode t)
  '(size-indication-mode t))
