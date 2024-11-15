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

;; (setq doom-font "Cascadia Code Regular-9")
;; (setq doom-font "Cascadia Mono PL Regular-11")
(setq doom-font "Fixedsys Excelsior 3.01-12")
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
;; (setq doom-theme 'doom-monokai-pro)
;; (setq doom-theme 'srcery)
 (setq doom-theme 'doom-zenburn)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
;; (setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/storage/org")


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


;; 1. 个人使用习惯 key-mapping 快捷键设置
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
;; 让evil模式更好用
; https://github.com/syl20bnr/spacemacs/issues/9740
(with-eval-after-load 'evil (defalias #'forward-evil-word #'forward-evil-symbol))

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


;; 3. org强大工具使用之org.el和org-roam.el。还是继续使用purcell大师的时间管理配置。
(after! org
  (load! "lisp/init-org"))
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

;; 6. cpp编程相关之llvm 设置 - clangd、clang-tidy、clang-format
(setq llvm-bin-path "D:/pkg/llvm/bin/")
(setq clangd-bin-path (expand-file-name "clangd.exe" llvm-bin-path))
(setq clangformat-bin-path (expand-file-name "clang-format.exe" llvm-bin-path))
(setq flycheck-gcc-language-standard "c++17")

(setq clang-format-executable clangformat-bin-path)
(setq lsp-clients-clangd-executable clangd-bin-path)
(setq lsp-clients-clangd-args '("--clang-tidy" "-j=4" "--background-index" "--completion-style=detailed"))
;; --compile-commands=<path> 指定编译命令文件的路径
;; --header-insertion=<mode> 控制头文件的插入模式 never,  main, includes (includes可能已废弃, 可能是默认的方式)
;; --cross-file-rename 启用跨文件重命名功能 (可能已废弃)
;; --fallback-style-<style> 设置代码格式化的风格
;; --limit-results=<number> 设置每个代码不全请求返回的最大结果数量。可以用于限制大型项目中的补全建议
;; --enable-config 启用配置文件的支持。允许从.clangd文件中读取配置
;; --suggest-missing-includes 启用此选项后，clangd会在使用符号时，建议可能缺失的头文件


;; LSP 提供的format有bug
; Use clang-format instead of the lsp provided formatter, which doesn't appear to work.
; https://github.com/hlissner/doom-emacs/issues/1652
(setq +format-with-lsp nil)
(use-package clang-format
  :ensure t
  :hook ((c-mode c++-mode) . (lambda ()
                               (setq clang-format-style "file"))))
(defun my-cpp-mode-hook ()
  ;; 设置cpp style
  (setq c-default-style "user"
        c-basic-offset 4
        indent-tabs-mode t
        clang-format-style-option "file"
        ))
(add-hook 'c++-mode-hook 'my-cpp-mode-hook)
(setq-default evil-shift-width 4)       ;; 设置 Evil 模式的缩进宽度
(setq-default tab-width 4)               ;; 设置 Tab 的宽度
(setq-default indent-tabs-mode t)        ;; 启用 Tab 缩进

;; 8.1 临时禁用save-place功能。因为pdf和epub阅读会有冲突，后面有空再看看。
(remove-hook 'find-file-hook #'save-place-find-file-hook)
(remove-hook 'after-save-hook #'save-place-to-alist)
(setq save-place-mode nil)
;; 8.2 设置pdf-view的外观，为了方便摸鱼，设置成黑底白字。
;; windows编译pdf-tools， 可以使用scoop和msys2
;; pdf-view-midnight-minor-mode 启用黑皮肤
;; 黑皮肤颜色设置可用： (setq pdf-view-midnight-colors '("#f8f8f2" . "#282a36"))
(use-package pdf-tools
  :config
  (defun apply-pdf-tools-theme ()
    "Make `pdf-tools' 'theme' match Emacs theme."
    (if (eq (modus-themes--current-theme) modus-vivendi)
        (pdf-view-midnight-minor-mode 1)
      (pdf-view-midnight-minor-mode -1)))
  :hook
  (pdf-tools-enabled-hook . apply-pdf-tools-theme))

;; 9. 配合z-lib和epub阅读器，直接在写银行相关软件的同时，最大程度地进行摸鱼。这里是对epub阅读器的配置。
;;
;; Nov.el for EPUB
(use-package nov
  :mode ("\\.epub\\'" . nov-mode)
  :config
  (setq nov-text-width 80))

;; 10. 安装 srcery 主题
;;
(use-package! srcery-theme
  :config
  (setq doom-theme 'srcery)
  )

;; 11. 自动保存
;;
(setq auto-save-visited-interval 15) ;; 每15秒自动保存
(setq auto-save-interval 200) ;; 每200字符自动保存
(auto-save-visited-mode +1)
(add-function :after after-focus-change-function (lambda () (save-some-buffers t))) ;; Auto save buffers on focus lost
(add-function :after after-focus-change-function (lambda () (evil-normal-state))) ;; Exit insert mode on focus loss


;; 12. 让自动补全更好用, company 自动补全设置
;;
(setq company-continue-previous-commands t) ;; 允许连续选择补全
(company-quickhelp-mode t)

;; 13. 提供更好用的lsp符号高亮。 和visual studio assist的符号高亮颜色保持一致，养成直观的条件反射
(setq lsp-semantic-tokens-enable t)
;; (after! lsp-mode
;;   ;; 在这里添加你的 face 定义和 lsp 语义标记配置
;;   (custom-set-faces
;;    '(lsp-face-semhl-class ((t (:foreground "gold" :slant italic))))
;;    '(lsp-face-semhl-variable ((t (:foreground "silver"))))
;;    '(lsp-face-semhl-function ((t (:foreground "#FF8000"))))))

(after! lsp-mode
  (custom-set-faces
   ;; Classes, structs, enums, interfaces, typedefs
   '(lsp-face-semhl-class ((t (:foreground "#FBB829" :slant italic :weight bold)))) ;; gold
   '(lsp-face-semhl-enum ((t (:foreground "#FBB829" :slant italic :weight bold)))) ;; gold
   '(lsp-face-semhl-struct ((t (:foreground "silver" :slant italic :weight bold))));; silver
   '(lsp-face-semhl-interface ((t (:foreground "silver" :slant italic :weight bold))));; silver
   '(lsp-face-semhl-type ((t (:foreground "silver" :slant italic :weight bold))));; silver

   ;; Variables
   '(lsp-face-semhl-variable ((t (:foreground "gray")))) ;; bright-white
   '(lsp-face-semhl-parameter ((t (:foreground "gray"))))
   '(lsp-face-semhl-member ((t (:foreground "gray"))))
   '(lsp-face-semhl-property ((t (:foreground "#918175")))) ;; bright-black
   '(lsp-face-semhl-constant ((t (:foreground "#FF5C8F")))) ;; bright-magentn

   ;; default-Libray
   '(lsp-face-semhl-default-library ((t (:foreground "#B9771E")))) ;; 棕色比较合适

   ;; Functions/methods
   '(lsp-face-semhl-function ((t (:foreground "#FF8000")))) ;; orange
   '(lsp-face-semhl-method ((t (:foreground "#FF8000"))))
   '(lsp-face-semhl-static ((t (:foreground "#FF8000"))))

   ;; Preprocessor macros
   ;; '(lsp-face-semhl-macro ((t (:foreground "#BD63C5"))))

   ;; Local symbols in bold
   '(lsp-face-semhl-local ((t (:weight bold))))))

(defun my-custom-keyword-faces ()
  "Customize faces for keywords and constants."
  (set-face-attribute 'font-lock-keyword-face nil
                      :foreground "#EF2F27" ;; red
                      :weight 'bold)
  (set-face-attribute 'font-lock-constant-face nil
                      :foreground "#EF2F27"
                      :weight 'bold))

(add-hook 'after-load-theme-hook 'my-custom-keyword-faces)
