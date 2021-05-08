;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;No auto-save only hard-core

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Utility
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;No autosave and no backup files
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq auto-save-list-file-name nil)


;;Run emacs as server to start faster
(require 'server)
(if (eq server-process nil)
    (server-start))

;;highlight expression between []{}()
(show-paren-mode t)
(setq show-paren-style 'expression)

;;hotkey to kill buffer
(global-set-key "\C-xc" 'kill-buffer)

;;Scrolling settings, smoother scrolling
(setq scroll-step 1)
(setq scroll-margin 10)
(setq scroll-conservatively 10000)

;;More comfortable buffer swtcher
(global-set-key "\C-xb" '+ivy/switch-buffer)
(setq ivy-use-virtual-buffers t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;C/C++ settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Irony settings
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;;company settings
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(push 'company-lsp company-backends)
(push 'company-irony company-backends)
(add-to-list 'company-backends 'company-c-headers)

(add-to-list 'company-backends 'company-c-headers)
(setq company-backends (delete 'company-semantic company-backend))

;;Semantic
(require 'cc-mode)
(require 'semantic)

(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)

(semantic-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Rust settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq racer-rust-src-path "/home/georgii/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Go settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'go-mode-hook #'lsp-deferred)
;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t) ;;Auto-formatting buffer on save
  (add-hook 'before-save-hook #'lsp-organize-imports t t)) ;;Delete unused imports
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(add-hook 'octave-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (setq tab-width 4)
             (setq indent-line-function (quote insert-tab))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; IRC (ERC) setings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;set the nickname
(setq erc-nick "snake266")
