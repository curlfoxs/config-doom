;;; lisp/init-org-roam.el -*- lexical-binding: t; -*-

;; org-roam mode
(use-package org-roam
  :ensure t
  ;; :demand t  ;; Ensure org-roam is loaded by default
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory (expand-file-name "roam" org-directory))
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n L" . org-roam-buffer-display-dedicated)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n I" . org-roam-node-insert-immediate)
         ;; ("C-c n p" . my/org-roam-find-project)
         ;; ("C-c n t" . my/org-roam-capture-task)
         ;; ("C-c n b" . my/org-roam-capture-inbox)
         ("C-c n a" . org-roam-alias-add)
         ("C-c n c" . org-id-get-create)
         :map org-mode-map
         ("C-M-i" . completion-at-point))
  :config
  (org-roam-db-autosync-mode)
  (add-to-list 'display-buffer-alist
               '(("\\*org-roam\\*"
                  (display-buffer-in-direction)
                  (direction . right)
                  (window-width . 0.33)
                  (window-height . fit-window-to-buffer))))
  (setq org-roam-capture-templates
        '(("d" "default" plain
           "%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+AUTHOR: curlfoxs\n#+OPTIONS:  H:2 num:t toc:nil @:t ::t |:t ^:t f:t TeX:t\n#+LATEX_HEADER: \\usepackage{ctex}\n\n- tags ::      :noexport:\n\n* What's ${title}\n\n")
           :unnarrowed t)

          ("l" "programming language" plain
           "* What's ${title}\n\n* Family\n\n* Syntax\n\n* Features\n\n* API\n\n* Enviroment of\n\n* Hacking\nlibrary, package-management, skills\n"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n\n- tags ::      :noexport:\n")
           :unnarrowed t)

          ("b" "book notes" plain
           "\n* Source\n\nAuthor: %^{Author}\nTitle: ${title}\nYear: %^{Year}\n\n* Summary\n\n%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n\n- tags ::      :noexport:\n")
           :unnarrowed t)

          ("p" "project" plain
           "- tags ::      :noexport:\n\n* Goals\n\n%?\n\n** 巨人的肩膀\n\n** 知识组件\n\n** 鲤鱼跃龙门\n\n* Tasks\n\n** PROJECT Tasks \n\n** TODO Add New-inbox tasks\n\n* Dates\n\n* Notes\n\n"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+title: ${title}\n#+filetags: Project\n\n")
           :unnarrowed t)))
  )
