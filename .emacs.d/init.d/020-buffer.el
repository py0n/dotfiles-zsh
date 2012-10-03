;; -*- coding: utf-8 -*-

;; Buffer setting

;; iswitchb は、バッファ名の一部の文字を入力することで、選択バッファの
;; 絞り込みを行う機能を実現します。バッファ名を先頭から入力する必要はなく、
;; とても使いやすくなります。

;; iswitchbモードON
(iswitchb-mode 1)

;; C-f, C-b, C-n, C-p で候補を切り替えることができるように。
(add-hook 'iswitchb-define-mode-map-hook
          (lambda ()
            (define-key iswitchb-mode-map "\C-n" 'iswitchb-next-match)
            (define-key iswitchb-mode-map "\C-p" 'iswitchb-prev-match)
            (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
            (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)))

;; iswitchbで補完対象に含めないバッファ
(setq iswitchb-buffer-ignore
      '(
        "*twittering-wget-buffer*"
        "*twittering-http-buffer*"
        "*WoMan-Log*"
        "*SKK annotation*"
        "*Completions*"))

;; buffer-menuはバッファのリストを表示して、ポインタを其のウィンドウに移動する。
;; "C-xC-b"にbuffer-menuを束縛する。
(global-set-key "\C-x\C-b" 'buffer-menu)
