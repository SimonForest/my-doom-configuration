;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; (after! evil
;;   (map! :nv "t" 'evil-next-line)
;;   )

;; (after! evil-snipe
;;   (map! :map evil-snipe-local-mode-map :n "s" nil)
;;   (map! :nv "s" 'evil-previous-line)
;;   )

(setq doom-localleader-key ",")
(setq doom-localleader-alt-key "C-,")

; https://discourse.doomemacs.org/t/auctex-and-latex-mode/4901
; SF: problème avec doom + emacs < 30. Il se corrige avec la ligne suivante:
; TODO: enlever au passage à emacs 30
(setq major-mode-remap-alist major-mode-remap-defaults)

(map! :after org :localleader :map org-mode-map "i" nil)
(map! :after org :localleader :map org-mode-map "it" #'org-insert-structure-template)

; LATEX-mode
(defun my-insert-bbreak ()
  (interactive)
  (insert TeX-esc "bigbreak\n")
  )
(defun my-insert-mbreak ()
  (interactive)
  (insert TeX-esc "medbreak\n")
  )
(defun my-insert-sbreak ()
  (interactive)
  (insert TeX-esc "smallbreak\n")
  )
(map! :after latex :localleader :map LaTeX-mode-map "," '+latex/compile)
(map! :after latex :localleader :map LaTeX-mode-map "itr" #'my-insert-sbreak)
(map! :after latex :localleader :map LaTeX-mode-map "its" #'my-insert-mbreak)
(map! :after latex :localleader :map LaTeX-mode-map "itt" #'my-insert-bbreak)
(map! :after latex :localleader :map LaTeX-mode-map "." #'LaTeX-mark-environment)
(map! :after latex :localleader :map LaTeX-mode-map "*" #'LaTeX-mark-section)
(map! :after latex :localleader :map LaTeX-mode-map "k" #'TeX-kill-job)
(map! :after latex :localleader :map LaTeX-mode-map "n" #'TeX-next-error)
(map! :after latex :localleader :map LaTeX-mode-map "N" #'TeX-previous-error)
(map! :after latex :localleader :map LaTeX-mode-map "xb" (cmd! (TeX-font nil ?\C-b)))
(map! :after latex :localleader :map LaTeX-mode-map "xi" (cmd! (TeX-font nil ?\C-i)))
(map! :after latex :localleader :map LaTeX-mode-map "xe" (cmd! (TeX-font nil ?\C-e)))
(map! :after latex :localleader :map LaTeX-mode-map "xc" (cmd! (TeX-font nil ?\C-t)))
(map! :after latex :localleader :map LaTeX-mode-map "xr" (cmd! (TeX-font nil ?\C-d)))

; SF: pour info, les leader keys s'affectent par la map override comme dans
(after! projectile
 (map! :leader :nv "SPC" #'execute-extended-command)
  )

(map! :leader :nv "ie" 'find-file)
(map! :leader :n "ii" '+vertico/switch-workspace-buffer)
(map! :n "}" 'save-buffer)

(map! :after vertico :map vertico-map "C-t" 'vertico-next)
(map! :after vertico :map vertico-map "C-s" 'vertico-previous)
(map! :after vertico :leader :nv "rr" 'vertico-repeat)

(map! :after evil :nv "h" 'evil-replace)
(map! :after evil :nv "l" 'evil-change)

(map! :after evil :nv "c" 'evil-backward-char)
(map! :after evil :nv "r" 'evil-forward-char)

(map! :after evil :nv "b" 'evil-backward-word-begin)
(map! :after evil :nv "é" 'evil-forward-word-begin)

(map! :after evil :nv "j" 'evil-find-char-to)

(map! :after evil :n "k" 'evil-substitute)
(map! :after evil :v "k" 'evil-surround-region)

(map! :n "M-t" 'next-buffer)
(map! :n "M-s" 'previous-buffer)

(map! :leader :nv "<tab>" 'mode-line-other-buffer)

(map! :n "C-+" nil)
(map! :n "C--" nil)
(map! "C--" 'doom/decrease-font-size)
(map! "C-+" 'doom/increase-font-size)

(map! :leader :nv "éé" 'delete-other-windows)
(map! :leader :nv "ét" 'split-window-below)
(map! :leader :nv "és" 'split-window-horizontally)

; config mouvement fenêtres
(map! :nvi "C-t" nil)
(map! :nvi "C-s" nil)
(map! :nvi "C-t" 'evil-window-down)
(map! :nvi "C-s" 'evil-window-up)
(map! :g "C-s" 'evil-window-up)
(map! :g "C-t" 'evil-window-down)

; config eshell
(map! :after eshell :map eshell-mode-map "C-s" nil)

; config vterm
(map! :after vterm :map vterm-mode-map "C-s" nil)
(map! :after vterm :map vterm-mode-map "C-t" nil)
(map! :after vterm :map vterm-mode-map :i "C-s" nil)
(map! :after vterm :map vterm-mode-map :i "C-t" nil)

; config raccourcis terminaux
; SF: gros lag d'affichage avec cette commande
; solution temp:
; 1) passer en mode normal
; 2) faire SPC+tab 2x pour changer de fenêtre et revenir
; 3) repasser en mode insertion
(map! :after vertico :leader "'" (cmd! (+vterm/toggle t)))

(map! (:when (modulep! :completion corfu)
  (:after corfu-popupinfo
   :map corfu-popupinfo-map
   ;; "C-h"      #'corfu-popupinfo-toggle
   ;; Reversed because popupinfo assumes opposite of what feels intuitive
   ;; with evil.
   "C-S-t"    #'corfu-popupinfo-scroll-down
   "C-S-s"    #'corfu-popupinfo-scroll-up
   ;; "C-<up>"   #'corfu-popupinfo-scroll-down
   ;; "C-<down>" #'corfu-popupinfo-scroll-up
   ;; "C-S-p"    #'corfu-popupinfo-scroll-down
   ;; "C-S-n"    #'corfu-popupinfo-scroll-up
   ;; "C-S-u"    (cmd!! #'corfu-popupinfo-scroll-down nil corfu-popupinfo-min-height)
   ;; "C-S-d"    (cmd!! #'corfu-popupinfo-scroll-up nil corfu-popupinfo-min-height)
   )
  (:after corfu
          ;; (:map corfu-mode-map
          ;;       (:unless (bound-and-true-p evil-disable-insert-state-bindings)
          ;;         :i "C-@"   #'completion-at-point
          ;;         :i "C-SPC" #'completion-at-point
          ;;         :i "C-n"   #'+corfu/dabbrev-or-next
          ;;         :i "C-p"   #'+corfu/dabbrev-or-last)
          ;;       :n "C-SPC" (cmd! (call-interactively #'evil-insert-state)
          ;;                        (call-interactively #'completion-at-point))
          ;;       :v "C-SPC" (cmd! (call-interactively #'evil-change)
          ;;                        (call-interactively #'completion-at-point)))
          (:map corfu-map
                (:unless (bound-and-true-p evil-disable-insert-state-bindings)
                  :i "C-SPC" #'corfu-insert-separator)
                "C-s" #'corfu-previous
                "C-t" #'corfu-next
                "C-u" (cmd! (let (corfu-cycle)
                              (funcall-interactively #'corfu-next (- corfu-count))))
                "C-d" (cmd! (let (corfu-cycle)
                              (funcall-interactively #'corfu-next corfu-count)))))))
