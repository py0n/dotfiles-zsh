;; -*- coding: utf-8 -*-

(load "~/.emacs.d/initfuncs")

;; =========================================================
;; local site-elisp path.
;; =========================================================

(defconst my-autoinst-dir "~/.emacs.d/auto-install")
(defconst my-site-lisp-dir "~/.emacs.d/site-lisp")
(defconst my-ver-dir (format "~/.emacs.d/%s" emacs-version))
(defconst my-ver-lisp-dir (expand-file-name "lisp" my-ver-dir))
(defconst my-ver-site-lisp-dir (expand-file-name "site-lisp" my-ver-dir))

(dolist (dir (list
              my-autoinst-dir
              my-site-lisp-dir
              my-ver-lisp-dir
              my-ver-site-lisp-dir))
  (let ((default-directory dir))
    (add-to-list 'load-path default-directory)
    (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
        (normal-top-level-add-subdirs-to-load-path))))

;; =========================================================
;; Devided Initial Emacs Lisp Files
;; =========================================================

(defconst my-init-lisp-dir "~/.emacs.d/init.d")

(let ((files (mapcar
              (lambda (path) (replace-regexp-in-string "\\.el\\'" "" path))
              (directory-files my-init-lisp-dir 'fullpath "\\.el\\'"))))
  (dolist (file files) (load file)))

;; =========================================================
;; auto-install.el
;; =========================================================

;; http://d.hatena.ne.jp/rubikitch/20091221/autoinstall
;; http://www.emacswiki.org/emacs/AutoInstall

(require 'auto-install)

;; 使ひ方
;;   M-x auto-intall-from-emacswiki RET foobar
;; でダウンロード。其乃後、
;;   * 續けるのであれば"C-cC-c"を、
;;   * 止めるのであれば"C-cC-q"を、
;;   * 古い版との差分を見るのであれば"C-cC-d"を、
;; 押す。

;; インストール先のディレクトリ。
(setq auto-install-directory my-autoinst-dir)

;; Emacs起動時にアップデートされたパッケージを確認する。
(auto-install-update-emacswiki-package-name t)

;; install-elisp.elと互換性確保。
(auto-install-compatibility-setup)

;; AutoInstall時に確認を行ふ。nilにすると勝手に最後迄行く。
(setq auto-install-save-confirm t)
