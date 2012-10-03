;; -*- coding: utf-8 -*-

;; Edit setting

;; 矩形選択。
(setq cua-enable-cua-key nil)
;;(cua-mode t)
;; バックアップファイルを作らない
(setq backup-inhibited t)
;; 行頭の「C-k」は改行も含めて削除する。
(setq kill-whole-line t)
;; 最後の行に改行コードが入つてゐない時は自動的に追加する。
(setq require-final-newline t)
;; Localeに合わせた環境の設定
(set-locale-environment nil)
;; 対応する括弧を光らせる。
(show-paren-mode 1)
;; ツールバーを表示する。
(tool-bar-mode 1)
;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)
;; emacs -nw で起動した時にメニューバーを消す
(when window-system
  (menu-bar-mode 1) (menu-bar-mode -1))
;; タイトルバーにファイル名を表示する
(setq frame-title-format (format "emacs@%s : %%f" (system-name)))

;; mode-line setting

;; カーソルの位置が何行目の何文字目かを表示する
(column-number-mode t)
(line-number-mode t)
;; モードラインに時間を表示する
(display-time)
;; 現在の関数名をモードラインに表示
(which-function-mode 1)

;; Emacsで全角空白、タブ、改行文字を表示させる。
;; http://ubulog.blogspot.com/2007/09/emacs_09.html
(defface my-face-b-1 '((t (:background "bisque2"))) nil)
(defface my-face-b-1 '((t (:background "bisque2"))) nil)
(defface my-face-b-2 '((t (:background "bisque2"))) nil)
(defface my-face-b-2 '((t (:background "bisque2"))) nil)
(defface my-face-u-1 '((t (:foreground "bisque2" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
     ("　" 0 my-face-b-1 append)
     ("\t" 0 my-face-b-2 append)
     ("[ ]+$" 0 my-face-u-1 append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)
(add-hook 'find-file-hooks '(lambda ()
                              (if font-lock-mode
                                  nil
                                (font-lock-mode t))))

;; C-q (fill-paragraph)で日本語の場合、句讀點で改行する。
;; Emacs part 28 955

(defvar line-breakable-char-list '(?、 ?。))

(defun break-paragraph ()
  (interactive)
  (let* ((old (category-table))
         (new (copy-category-table old)))
    (map-char-table (lambda (char category-set)
                      (when (and (aref category-set ?j)
                                 (not (memq char line-breakable-char-list)))
                        (aset category-set ?| nil))) new)
    (set-category-table new)
    (unwind-protect
        (save-excursion
          (let ((end (progn (forward-paragraph) (point))))
            (backward-paragraph)
            (replace-regexp "\\(\\cj\\)\n\\(\\cj\\)" "\\1\\2" nil (point) end)
            (fill-paragraph nil)))
      (set-category-table old))))
