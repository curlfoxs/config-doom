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
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))

(setq doom-font "Cascadia Mono PL Regular-9")
;; 给unicode字符集设置专门的显示字体
;; (dolist (charset '(kana han symbol cjk-misc bopomofo))
;; (set-fontset-font (frame-parameter nil 'font)
;; charset (font-spec :family "Microsoft Yahei" :size 14)))
(set-fontset-font t 'unicode (font-spec :family "Noto Color Emoji" :size 14))
(set-fontset-font t '(#x2ff0 . #x9ffc) (font-spec :family "Sarasa Mono Slab SC" :size 18 :weight 'bold))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'modus-operandi)
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-monokai-pro)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Google-drive/org")


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

;; 1. key-mapping 快捷键设置
;;
(map! :map 'override
      ;; "C-k" #'sp-kill-sexp
     "M-." #'+lookup/definition
     "C-d" #'sp-kill-sexp
     )

(map!
      "C-d" #'sp-kill-sexp
      "M-p" #'lsp-ui-find-prev-reference
      "M-n" #'lsp-ui-find-next-reference
      "M-o" #'+lookup/references
      "C-<left>" #'previous-buffer
      "C-<right>" #'next-buffer
      "C-s" #'save-buffer
      "C-c c" #'org-capture
      "C-c l" #'org-store-link
      "C-c a" #'org-agenda
      "C-c o j" #'org-clock-goto
      "C-c o l" #'org-clock-in-last
      "C-c o i" #'org-clock-in
      "C-c o o" #'org-clock-out)

(map! :map evil-normal-state-map
      "C-d" #'sp-kill-symbol
      "M-." #'+lookup/definition
      "e" #'er/expand-region)

(map! :map evil-normal-state-map
      :prefix "SPC"
      "r" #'consult-recent-file
      "j s" #'consult-lsp-file-symbols
      "j S" #'consult-lsp-symbols
      )

;; 2. Unicode设置： emacs utf-8-unix (no BOM) coding system
;;
(set-charset-priority 'unicode)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-clipboard-coding-system 'euc-cn)
(setq system-time-locale "C")


;; 3. org.el
(load! "lisp/init-org-roam")

;; 4. half-transparency 半透明毛玻璃设置
(defun toggle-transparency ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter
     nil 'alpha
     (if (eql (cond ((numberp alpha) alpha)
                    ((numberp (cdr alpha)) (cdr alpha))
                    ;; Also handle undocumented (<active> <inactive>) form.
                    ((numberp (cadr alpha)) (cadr alpha)))
              100)
         '(90 . 80) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)


;; 5. minimap 右侧导航栏滚动条
;; (minimap-mode nil)

;; 6. llvm 设置 - clangd、clang-tidy、clang-format
(setq flycheck-gcc-language-standard "c++17")
(setq lsp-clients-clangd-executable "C:/Program Files/LLVM/bin/clangd.exe")
(setq lsp-clients-clangd-args '("--clang-tidy" "-j=4" "--background-index" "--completion-style=detailed" "--header-insertion=never"))

(setq clang-format-executable "C:/Program Files/LLVM/bin/clang-format.exe")
