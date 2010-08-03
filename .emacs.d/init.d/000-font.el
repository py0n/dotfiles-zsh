;; -*- coding: utf-8 -*-

(when window-system
  (when emacs23

    ;; Font & Frame setting

    ;; フォントの設定に關しては以下の頁を參考にした。
    ;; http://emacs.g.hatena.ne.jp/sakito/20100127
    ;; http://ynomura.dip.jp/archives/2010/05/emacsx_window.html
    ;; http://ynomura.dip.jp/archives/2010/05/emacsx_window2.html

    ;; Bitsream Vera Sans MonoとMS Gothicのバランスの良い比率は
    ;; (12, 14), (13, 16)の組み合はせ。

    (create-fontset-from-ascii-font
     "Bitstream Vera Sans Mono:style=Regular:slant=normal:weight=normal:size=12"
     nil "bsms12")
    (set-fontset-font "fontset-bsms12" 'japanese-jisx0213-1
                      (font-spec :family "MS Gothic" :size '14) nil 'append)
    (set-fontset-font "fontset-bsms12" 'japanese-jisx0213-2
                      (font-spec :family "MS Gothic" :size '14) nil 'append)
    (set-fontset-font "fontset-bsms12" 'unicode
                      (font-spec :family "MS Gothic" :size '14) nil 'append)
    ))
