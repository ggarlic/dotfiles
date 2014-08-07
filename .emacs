(show-paren-mode t)

(load (expand-file-name "~/quicklisp/slime-helper.el"))
;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "/usr/local/bin/sbcl")

(setq package-archives '(
;("gnu" . "http://elpa.gnu.org/packages/")
("melpa" . "http://melpa.milkbox.net/packages/")
("marmalade" . "http://marmalade-repo.org/packages/")
))
;禁止elpa自动加载packages
(setq package-enable-at-startup nil)
;手动初始化之，如此elpa会将packages的路径加入load-path中，免去我们分别手动加入的麻烦了
(package-initialize) 
(put 'upcase-region 'disabled nil)
(require 'color-theme-sanityinc-solarized)
(load-theme 'sanityinc-solarized-dark t)
;(color-theme-sanityinc-solarized-dark)
(setq color-theme-sanityinc-solarized-rgb-is-srgb t)

;exec-path-from-shell   for mac
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;highlight current line
(global-hl-line-mode 1)

(require 'python)
(setq
  python-shell-interpreter "ipython"
  python-shell-interpreter-args ""
  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
  python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
  python-shell-completion-setup-code
    "from IPython.core.completerlib import module_completion"
  python-shell-completion-module-string-code
    "';'.join(module_completion('''%s'''))\n"
  python-shell-completion-string-code
    "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")


(set-frame-font "Monaco-13")
(set-fontset-font
  (frame-parameter nil 'font)
  'han
  (font-spec :family "Hiragino Sans GB" ))

;id-at-point
(autoload 'ido-at-point-mode "ido-at-point")

;yasnippets
(require 'yasnippet)
;(require 'dropdown-list)
(setq yas-prompt-functions '(
                             yas-ido-prompt
                             ;yas/dropdown-prompt
                             yas-completing-prompt))
(yas-load-directory "~/.emacs.d/elpa/yasnippet-20140617.1640/snippets" t)
(yas-global-mode t)

;ido
(require 'ido)
(ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)

;speedbar
(setq speedbar-tag-hierarchy-method nil)
;sr-speedbar
(require 'sr-speedbar)
(global-set-key [(f2)] 'sr-speedbar-toggle)
;(global-set-key (kbd "s-r") 'sr-speedbar-refresh-toggle)
;semantic
(add-hook 'speedbar-load-hook (lambda () (require 'semantic/sb))
                               (semantic-mode t))

;flycheck
(add-hook 'after-init-hook 'global-flycheck-mode)
(setq flycheck-highlighting-mode 'columns)

;undo-tree
(require 'undo-tree)
(global-undo-tree-mode t)
(defadvice undo-tree-visualizer-mode (after undo-tree-face activate)
  (buffer-face-mode))

;auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20140803.2118/dict")
(ac-config-default)
(setq-default ac-sources
      '(
        ac-source-yasnippet
        ac-source-dictionary
        ac-source-abbrev
        ac-source-semantic
        ac-source-words-in-buffer
        ac-source-words-in-same-mode-buffer
        ;; ac-source-imenu
        ac-source-files-in-current-dir
        ac-source-filename
        )
      )
(setq ac-fuzzy-enable t)
(ac-config-default)

;jedi
(add-hook 'python-mode-hook 'jedi:setup
                            (global-set-key (kbd "RET") 'newline-and-indent))
(setq jedi:complete-on-dot t)      
(setq jedi:tooltip-method nil)

;c-mode
(add-hook 'c-mode-hook (lambda () (c-toggle-auto-state)))
;smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;line number
;(require 'linum)
(global-linum-mode)

;git gutter
(require 'git-gutter-fringe)
(global-git-gutter-mode)
