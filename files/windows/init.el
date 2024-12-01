;;; init.el --- early bird  -*- no-byte-compile: t -*-
;;; Commentary:
;;; Code:

;; Requirements:
;; git command for straight
;; M-x all-the-icons-install-fonts for all-the-icons
;; gcc to build sqlite3 for org-roam
;; NixOS only: nix rather than straight.el to install vterm
;; Devdocs: use devdocs install to install documentation

;; emacs-client. can maybe start through nix?
;; (server-start)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;             OPTIMISATION           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Adjust garbage collection thresholds during startup, and thereafter
(setq gc-cons-threshold (* 128 1024 1024) )
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 20 1024 1024) )))

;; no need to resize anything since xmonad deals with it already
(setq frame-inhibit-implied-resize t)

(setq-default
 inhibit-startup-screen t               ; Disable start-up screen
 inhibit-startup-message t              ; Disable startup message
 inhibit-startup-echo-area-message t    ; Disable initial echo message
 initial-scratch-message ""             ; Empty the initial *scratch* buffer
 initial-buffer-choice t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               STRAIGHT             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; replaced by elpaca

;; ;; saves some time on startup by changing when straight looks for changes
;; (setq straight-check-for-modifications '(check-on-save find-when-checking))
;; (setq straight-check-for-modifications nil) ;; doom style
;; 
;; ;; fix for version 29.1
;; (define-obsolete-variable-alias
;;   'native-comp-deferred-compilation-deny-list
;;   'native-comp-jit-compilation-deny-list
;;   "Renamed in emacs#95692f6")
;; 
;; (custom-set-variables
;;  '(straight-base-dir "~/.emacs.d/files/straight/")
;;  '(straight-build-cache-fixed-name "~/.emacs.d/files/straight/build-cache.el"))
;; 
;; ;; straight (requires git)
;; (defvar bootstrap-version)
;; (let ((bootstrap-file
;;        (expand-file-name "files/straight/repos/straight.el/bootstrap.el" user-emacs-directory))
;;       (bootstrap-version 5))
;;   (unless (file-exists-p bootstrap-file)
;;     (with-current-buffer
;;         (url-retrieve-synchronously
;;          "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
;;          'silent 'inhibit-cookies)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp))
;;     ;; move straight away from the base directory. combine it with no-littering.el
;;     (rename-file "~/.emacs.d/straight/" "~/.emacs.d/files/")
;;     (find-file "~/.emacs.d/files/")) ;; it's dirty but it works
;;   (load bootstrap-file nil 'nomessage))
;; 
;; ;; prevents the user from relying on package-install
;; (put 'package-install 'disabled "\nDO NOT USE package-install anymore.\nRely on straight-use-package instead")
;; 
;; ;; Disable package.el in favour of straight.el
;; (setq package-enable-at-startup nil)
;; 
;; ;; Install use-package with straight-use-package
;; ;; use-package is part of emacs from 29.1
;; ;; (straight-use-package 'use-package)
;; 
;; ;; configure use-package to always use straight
;; (use-package straight
;;   :custom (straight-use-package-by-default t))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               ELPACA               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar elpaca-core-date '(20241109)) ;; set to the build date of Emacs

(defvar elpaca-installer-version 0.8)
(defvar elpaca-directory (expand-file-name "files/elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil
                              :files (:defaults (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (call-process "git" nil buffer t "clone"
                                       (plist-get order :repo) repo)))
                 ((zerop (call-process "git" nil buffer t "checkout"
                                       (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (add-to-list 'load-path "c:/Users/Faroneel/AppData/Roaming/.emacs.d/files/elpaca/repos/elpaca/")
     
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

;; Disable package.el in favour of elpaca.el
(setq package-enable-at-startup nil)

;; Install use-package support
(elpaca elpaca-use-package
  ;; Enable :elpaca use-package keyword.
  (elpaca-use-package-mode)
  ;; Assume :elpaca t unless otherwise specified.
  (setq use-package-always-ensure t))

;; fix to reload package
(defun elpaca-use-package--maybe (fn &rest args)
  "Temporarily disable `elpaca-use-package-mode' for FN with ARGS if :elpaca nil."
  (let* ((pargs (cdr-safe args))
         (declared (member :elpaca pargs)))
    (if (and (not (eq this-command 'eval-last-sexp))
             (or (cadr declared)
                 (and (not declared) use-package-always-ensure)))
        (apply fn args)
      (setq args (cl-loop for i below (length args)
                          for arg = (nth i args)
                          if (eq arg :elpaca) do (cl-incf i)
                          else collect arg))
      (elpaca-use-package-mode -1)
      (unwind-protect
          (apply fn args)
        (elpaca-use-package-mode 1)))))


;; Uncomment for systems which cannot create symlinks (like windows 10):
;; (when (eq system-type 'windows-nt)
;;  (elpaca-no-symlink-mode))
(elpaca-no-symlink-mode)

;; hack to use find-file at c:/Users/<name>/
;; (setq default-directory "C:/Users/Faroneel/" )
(setq default-directory "~/../../")

(setq package-archives
      '(("gnu-elpa" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               GENERAL              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Block until current queue processed. replaces (elpaca-wait)
(use-package general
  :ensure (:wait t)
   :demand t)

;; switch to bindings list when opened
(defun general-list-keybindings ()
  (interactive)
  (general-describe-keybindings)
  (pop-to-buffer "*General Keybindings*")
  (delete-other-windows))

(general-define-key
 ;; undo
 [remap suspend-frame] 'undo)

;; Shortcuts
(general-define-key
 ;; eval buffer quickly
 ;; note: # can be used before a lambda which may be byte compiled
 ;; "C-c x" #'(lambda () (interactive) (save-buffer) (eval-buffer) (message "buffer evaluation complete"))
 :keymaps 'emacs-lisp-mode-map
 "C-c x" 'eval-region-or-buffer)

;; (put 'downcase-region 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;              LISP FILES            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (load-file "~/.emacs.d/straight.el")
(load-file "~/.emacs.d/elpaca.el")

;; (load-file "~/.emacs.d/custom/pull-down-packages.el")
;; (load-file "~/.emacs.d/custom/pull-down-guide.el")

;; (load-file "~/.emacs.d/custom/preferences.el")

;; set custom file in which emacs will add stuff on its own
(setq custom-file "~/.emacs.d/custom/customize.el")
(load custom-file)

;;; init.el ends here

;; (defun load-user-file (file)
;;   "Add FILE to configuration (located in directory: packages)."
;;   (interactive "f")
;;   "Load a file from the packages ~/.emacs/directory"
;;   (load-file (expand-file-name (concat file ".el") (concat "~/.emacs.d/packages/"))))
;; 
;; (load-user-file "programming/latex-straight")
