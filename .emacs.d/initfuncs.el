;; -*- coding: utf-8 -*-

;; OSを判別する。

(defvar run-unix
  (or (equal system-type 'gnu/linux)
      (equal system-type 'usg-unix-v)))

(defvar run-w32
  (and (null run-unix)
       (or (equal system-type 'windows-nt)
           (equal system-type 'ms-dos))))

;; バージョンを判別する。

(defvar emacs23
  (string-match "^23\." emacs-version))


