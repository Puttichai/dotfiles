;------------------------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "/usr/share/emacs25/site-lisp/emacs-goodies-el/")

;; -------------------- Full Screen Mode --------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(font-latex-fontify-sectioning 1.05 t)
 '(inhibit-startup-screen t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(python-continuation-offset 0)
 '(safe-local-variable-values (quote ((eval TeX-PDF-mode 1))))
 '(show-paren-mode t)
 '(show-paren-mode-t nil))


;; -------------------- Set Frame Size --------------------
;; (add-to-list 'default-frame-alist '(height . 52))
;; (add-to-list 'default-frame-alist '(width . 92))


;; --------------- Foreground and Background Colors ---------------
(add-to-list 'default-frame-alist '(foreground-color . "#FFFFFF"))
(add-to-list 'default-frame-alist '(background-color . "#191919"))


;; -------------------- Column Numbers --------------------
;;Displays column number
(column-number-mode 1)


;; -------------- Customize KB Shortcut ----------------
(global-set-key [f3] 'find-file)
(global-set-key [f4] 'save-buffer)
(global-set-key [f5] 'TeX-command-master)
(global-set-key [f11] 'comment-region)
(global-set-key [f12] 'uncomment-region)


;; -------------------- Tabbar --------------------
;; Turn on tabbar
(require 'tabbar)

;; Set colors
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#191919" :foreground "#FFFFFF" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "unknown" :family "Liberation Mono"))))
 '(bm-persistent-face ((t (:background "green yellow" :foreground "black" :weight extra-bold))))
 '(font-latex-subscript-face ((t nil)))
 '(font-latex-superscript-face ((t nil)))
 '(linum ((t (:background "#191919" :foreground "#7DDC1F" :weight bold))))
 '(tabbar-default ((t (:background "#666666" :foreground "#7DDC1F" :weight bold))))
 '(tabbar-default-face ((t (:inherit variable-pitch :background "gray72" :foreground "red" :height 1.0 :family "Liberation Mono"))))
 '(tabbar-selected ((t (:inherit tabbar-default :background "#191919")))))
(setq tabbar-background-color "#666666")

(tabbar-mode 1)

;; Set Keys for navigating betweeb groups
(global-set-key [M-up] 'tabbar-backward-group)
(global-set-key [M-down] 'tabbar-forward-group)

;; Set Keys for navigating between tabs
(global-set-key [M-left] 'tabbar-backward-tab)
(global-set-key [M-right] 'tabbar-forward-tab)


;; -------------------- Set Print to PS Shortcut --------------------
(global-set-key [M-p] 'ps-spool-buffer)

;; -------------------- Line Numbers --------------------
(require 'linum)
(global-linum-mode 1)

;; ------------------------- AucTeX -------------------------
; (load "auctex.el" nil t t)

;; Fix AucTeX LaTeX syntax
(setq font-latex-fontify-sectioning 'color)
;; Only change sectioning colour
(setq font-latex-fontify-sectioning 'color)
;; super-/sub-script on baseline
(setq font-latex-script-display (quote (nil)))
;; Do not change super-/sub-script font

;; Exclude bold/italic from keywords
(setq font-latex-deactivated-keyword-classes
      '("italic-command" "bold-command" "italic-declaration" "bold-declaration"))

;; Turn on auto-fill mode
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)

;; Set PDF as default
;; (setq TeX-PDF-mode t)

(setq TeX-view-program-selection 
      '((output-pdf "PDF Viewer")
	(output-dvi "DVI Viewer")))

(setq TeX-view-program-list
      '(("PDF Viewer" "okular %o")
	("DVI Viewer" "okular %o")))


;; -------------------- Indentation in C++ --------------------
(defun my-c++-mode-hook ()
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0);; suppress indentation in loops
  (c-set-offset 'innamespace 0);; suppress indentation in namespace
  (c-set-offset 'statement-case-open 0)
  (c-set-offset 'case-label 0)
  (c-set-offset 'brace-list-open 0)
  )


(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'c-mode-hook 'my-c++-mode-hook)




(require 'uncrustify)
(setq uncrustify-args "-l CPP --replace")
(defun my-uncrustify-hook ()
;  (setq uncrustify-uncrustify-on-save t)
;  (add-hook 'uncrustify-init-hooks 'bm-buffer-save)
;  (add-hook 'uncrustify-finish-hooks 'bm-buffer-restore)
;; (message "adding kill hook")
;; (make-local-variable 'kill-buffer-hook)
;; (add-hook 'kill-buffer-hook '(lambda()
;; (interactive)
;; (let* ((uncrustify-current-line (line-number-at-pos)))
;; (save-excursion
;; (message "why sadfasdf")
;; (uncrustify-impl (point-min) (point-max)))
;; (goto-char (point-min)) (forward-line (1- uncrustify-current-line)))))
;; (message "kill hook added")
  (global-set-key (kbd "C-M-]") 'uncrustify)
  (global-set-key (kbd "C-M-\\") 'uncrustify-buffer)
)

; add uncrustify only if ~/.uncrustify.cfg exists
(when (file-readable-p "~/.uncrustify.cfg")
  (add-hook 'c++-mode-hook 'my-uncrustify-hook)
;;  (add-hook 'c-mode-hook 'my-uncrustify-hook)
)


;; -------------------- Pane Management --------------------
;; Focus-follow mouse
(setq mouse-autoselect-window t)

;; Move cursor between panes
(defun move-cursor-next-pane ()
  "Move cursor to the next pane."
  (interactive)
  (other-window 1))

(defun move-cursor-previous-pane ()
  "Move cursor to the previous pane."
  (interactive)
  (other-window -1))

(global-set-key [s-left] 'move-cursor-previous-pane)
(global-set-key [s-right] 'move-cursor-next-pane)

;;----------------- Code Indentation Styles ---------------------- 

;; from
;; http://emacs.stackexchange.com/questions/2/different-indentation-styles-for-different-projects
(defun my-project-name-contains-substring (REGEX)
  (let ((dir (if (buffer-file-name)
                 (file-name-directory (buffer-file-name))
               "")))
    (string-match-p REGEX dir)))

(defun my-ros-python-code-style ()
  (interactive)
  (message "ROS code style!")
  (setq python-indent 2)
  ;; working in /catkin_ws/
  )

(defun my-personal-python-code-style ()
  (interactive)
  (message "My personal code style!")
  (setq python-indent 4)
  )

(defun my-python-environment ()
  (interactive)
  (cond
   ;; company's project for ttag
   ((my-project-name-contains-substring "/catkin_ws/")
    (my-ros-python-code-style))
   ((my-project-name-contains-substring "/git/bimanual/")
    (my-ros-python-code-style))
   ((my-project-name-contains-substring "/git/cri1/")
    (my-personal-python-code-style))
  )
)
(add-hook 'python-mode-hook 'my-python-environment)


;;--------------- Printing
(require 'ps-print)
(when (executable-find "ps2pdf")
  (defun pdf-print-buffer-with-faces (&optional filename)
    "Print file in the current buffer as pdf, including font,
color, and underline information.  This command works only if you
are using a window system, so it has a way to determine color
values.

C-u COMMAND prompts user where to save the Postscript file (which is then
converted to PDF at the same location."
    (interactive (list (if current-prefix-arg
                           (ps-print-preprint 4)
                         (concat (file-name-sans-extension (buffer-file-name))
                                 ".ps"))))
    (ps-print-with-faces (point-min) (point-max) filename)
    (shell-command (concat "ps2pdf " filename))
    (delete-file filename)
    (message "Deleted %s" filename)
    (message "Wrote %s" (concat (file-name-sans-extension filename) ".pdf"))))

(when (executable-find "ps2pdf")
  (defun pdf-print-buffer (&optional filename)
    "Print file in the current buffer as pdf, including font,
color, and underline information.  This command works only if you
are using a window system, so it has a way to determine color
values.

C-u COMMAND prompts user where to save the Postscript file (which is then
converted to PDF at the same location."
    (interactive (list (if current-prefix-arg
                           (ps-print-preprint 4)
                         (concat (file-name-sans-extension (buffer-file-name))
                                 ".ps"))))
    (ps-print-buffer filename)
    (shell-command (concat "ps2pdf " filename))
    (delete-file filename)
    (message "Deleted %s" filename)
    (message "Wrote %s" (concat (file-name-sans-extension filename) ".pdf"))))

(setq ps-print-header nil)


;; -------------------- MATLAB codes --------------------
(setq auto-mode-alist
      (cons
       '("\\.m$" . octave-mode)
       auto-mode-alist))


(setq LaTeX-command-style '(("" "%(PDF)%(latex) -file-line-error %S%(PDFout)")))


;; -------------------- Default Font --------------------
;; The same font as used in Github
(set-face-attribute 'default t :font "Liberation Mono")


;; -------------------- Changing icons for line continuation --------------------
;; information is from 
;; http://stackoverflow.com/questions/26824328/hide-change-emacs-fringe-bent-arrows-due-to-word-wrapping
(define-fringe-bitmap 'right-curly-arrow
  [#b00000000
   #b00000010
   #b00000110
   #b00001110
   #b00011110
   #b00001110
   #b00000110
   #b00000010])
(define-fringe-bitmap 'left-curly-arrow
  [#b00000000
   #b01000000
   #b01100000
   #b01110000
   #b01111000
   #b01110000
   #b01100000
   #b01000000])


;; -------------------- Hide-Show minor mode --------------------
(global-set-key [f6] 'hs-minor-mode)
(global-set-key [f7] 'hs-hide-block)		
(global-set-key [f8] 'hs-show-block)


;; -------------------- Configuring the Scratch's buffer mode --------------------
(setq initial-major-mode 'python-mode)
(setq initial-scratch-message "")


;; Line spacing
(setq-default line-spacing 0.1)


; visual bookmarks
(autoload 'bm-toggle   "bm" "Toggle bookmark in current buffer." t)
(autoload 'bm-next     "bm" "Goto bookmark."                     t)
(autoload 'bm-previous "bm" "Goto previous bookmark."            t)

(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)


;; make bookmarks persistent as default
(setq bm-buffer-persistence 1)

;; Make sure the repository is loaded as early as possible
;(setq bm-restore-repository-on-load t)
(require 'bm)

;; Loading the repository from file when on start up.
(add-hook 'after-init-hook 'bm-repository-load)

;; Restoring bookmarks when on file find.
(add-hook 'find-file-hooks 'bm-buffer-restore)

;; Saving bookmark data on killing a buffer
(add-hook 'kill-buffer-hook 'bm-buffer-save)

;; Saving the repository to file when on exit.
;; kill-buffer-hook is not called when emacs is killed, so we
;; must save all bookmarks first.
;; (add-hook 'kill-emacs-hook '(lambda nil
;;                               (bm-buffer-save-all)
;;                               (bm-repository-save)))

;; Update bookmark repository when saving the file.
;(add-hook 'after-save-hook 'bm-buffer-save)

;; Restore bookmarks when buffer is reverted.
(add-hook 'after-revert-hook 'bm-buffer-restore)

; smoother scrolling
(setq scroll-step 1)
(setq scroll-conservatively 50)
(setq scroll-preserve-screen-position nil)
(defun scroll-down-keep-cursor ()
   ;; Scroll the text one line down while keeping the cursor
  (interactive)
  (scroll-down 1))

(defun scroll-up-keep-cursor ()
   ;; Scroll the text one line up while keeping the cursor
  (interactive)
  (scroll-up 1))

(global-set-key (kbd "<C-down>") 'scroll-up-keep-cursor)
(global-set-key (kbd "<C-up>") 'scroll-down-keep-cursor)
(global-set-key (kbd "C-M-g") 'goto-line)

;; M-n and M-p
(global-unset-key "\M-p")
(global-unset-key "\M-n")

(defun scroll-up-in-place (n)
  (interactive "p")
  (previous-line n)
  (scroll-down n))


(defun scroll-down-in-place (n)
  (interactive "p")
  (next-line n)
  (scroll-up n))

(global-set-key "\M-n" 'scroll-down-in-place)
(global-set-key "\M-p" 'scroll-up-in-place)

;; Fill column
;; (setq default-fill-column 90)
;; (add-hook 'latex-mode-hook '(setq default-fill-column 70))

;; (add-hook 'latex-mode-hook (lambda () (set-fill-column 70)))
;; (add-hook 'python-mode-hook (lambda () (set-fill-column 70)))

(defun customize-fill-column-width ()
  (interactive)
  (if (my-project-name-contains-substring ".tex")
      (add-hook 'latex-mode-hook (lambda () (set-fill-column 70)))
    (setq default-fill-column 90)
    )
  )

; Fix to AucTEX
(require 'cl)

; Change default font for Thai
(set-fontset-font "fontset-default" 'thai (font-spec :family "TH Sarabun New" :size 20))

;; This stuff is copied from Rosen's .emacs file.
;; Open files and goto lines like we see from g++ etc. i.e. file:line#
;; (to-do "make `find-file-line-number' work for emacsclient as well")
;; (to-do "make `find-file-line-number' check if the file exists")
(defadvice find-file (around find-file-line-number
                             (filename &optional wildcards)
                             activate)
  "Turn files like file.cpp:14 into file.cpp and going to the 14-th line."
  (save-match-data
    (let* ((matched (string-match "^\\(.*\\):\\([0-9]+\\):?$" filename))
           (line-number (and matched
                             (match-string 2 filename)
                             (string-to-number (match-string 2 filename))))
           (filename (if matched (match-string 1 filename) filename)))
      ad-do-it
      (when line-number
        ;; goto-line is for interactive use
        (goto-char (point-min))
        (forward-line (1- line-number))))))

;; anzu
(require 'anzu)
(global-anzu-mode +1)

;;
(add-to-list 'auto-mode-alist '("\\.cpp'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Display ANSI colors. Do M-x display-ansi-colors
(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))
