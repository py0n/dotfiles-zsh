;; -*- coding: utf-8 -*-

(when window-system
  (when emacs23

    ;; Color Theme

    ;; http://ftp.twaren.net/Unix/NonGNU/color-theme/
    ;; http://www.cs.cmu.edu/~maverick/GNUEmacsColorThemeTest/
    ;; http://www.emacswiki.org/emacs/ColorTheme
    ;; http://www.nongnu.org/color-theme/

    (require 'color-theme)
    (color-theme-initialize)
    (color-theme-robin-hood)

    ))
