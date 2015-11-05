;; -------------------- Full Screen Mode --------------------
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
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
(tabbar-mode t)

;; Set colors
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(font-latex-subscript-face ((t nil)))
 '(font-latex-superscript-face ((t nil)))
 '(linum ((t (:background "#323232" :foreground "#7DDC1F" :weight bold))))
 '(tabbar-default ((t (:background "#666666" :foreground "#7DDC1F" :weight bold))))
 '(tabbar-selected ((t (:inherit tabbar-default :background "#323232")))))
(setq tabbar-background-color "#666666")

(defun tabbar-buffer-groups ()
  "Return the list of group names the current buffer belongs to.
Return a list of one element based on major mode."
  (list
   (cond
    ((or (get-buffer-process (current-buffer))
         ;; Check if the major mode derives from `comint-mode' or
         ;; `compilation-mode'.
         (tabbar-buffer-mode-derived-p
          major-mode '(comint-mode compilation-mode)))
     "Process"
     )
    ;; ((member (buffer-name)
    ;;          '("*scratch*" "*Messages*"))
    ;;  "Common"
    ;;  )
    ((string-equal "*" (substring (buffer-name) 0 1))
     "Common"
     )
    ((eq major-mode 'dired-mode)
     "Dired"
     )
    ((memq major-mode
           '(help-mode apropos-mode Info-mode Man-mode))
     "Help"
     )
    ((memq major-mode
           '(rmail-mode
             rmail-edit-mode vm-summary-mode vm-mode mail-mode
             mh-letter-mode mh-show-mode mh-folder-mode
             gnus-summary-mode message-mode gnus-group-mode
             gnus-article-mode score-mode gnus-browse-killed-mode))
     "Mail"
     )
    (t
     ;; Return `mode-name' if not blank, `major-mode' otherwise.
     (if (and (stringp mode-name)
              ;; Take care of preserving the match-data because this
              ;; function is called when updating the header line.
              (save-match-data (string-match "[^ ]" mode-name)))
         mode-name
       (symbol-name major-mode))
     ))))

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
(load "auctex.el" nil t t)

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




;;(require 'uncrustify)

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

;; -------------------- PDDL codes --------------------
;; (require 'pddl-mode)
;; use pddl-mode for all file with .pddl
;; (add-to-list 'auto-mode-alist '("\\.pddl\\'" . PDDL-mode))

;; -------------------- Default Font --------------------
;; The same font as used in Github
(set-face-attribute 'default t :font "Liberation Mono")