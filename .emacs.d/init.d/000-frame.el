;; -*- coding: utf-8 -*-

(when window-system
  (when emacs23

    ;; Frame (default)

    (setq default-frame-alist
          (append (list
                   ;;'(top    . 50)    ; フレームの Y 位置(ピクセル数)
                   ;;'(left   . 10)    ; フレームの X 位置(ピクセル数)
                   '(width  . 80)    ; フレーム幅(文字数)
                   '(height . 45)    ; フレーム高(文字数)
                   '(font   . "fontset-bsms12") ; フォント
                   '(alpha  . (85 20))
                   ) default-frame-alist))

    ;; Frame (initial)

    (setq initial-frame-alist default-frame-alist)

    ))
