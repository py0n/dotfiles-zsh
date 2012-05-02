"======================================================================
"
" Vim 7.x 用の設定。
"
" 基本は以下の URL を參照にした。
" http://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
" http://vim.wikia.com/wiki/VimTip1628
" http://vimwiki.net/?vimrc/9
" http://www.kawaz.jp/pukiwiki/?vim#hb6f6961
"
" 本設定ファイルのエンコーディングを指定する
if has('multi_byte')
	scriptencoding utf-8
endif
" vi非互換(Vimの拡張機能を有効にする)
set nocompatible
" *NIX, Win32でのパスの違いを吸収する
if has('win32')
	let $CFGHOME=$HOME.'/vimfiles'
    let $LOCALRC='~/_vimrc.local'
elseif has('unix')
	let $CFGHOME=$HOME.'/.vim'
    let $LOCALRC='~/.vimrc.local'
endif

"======================================================================
" 文字コード関連
" http://www.kawaz.jp/pukiwiki/?vim#cb691f26
"======================================================================
if &encoding !=# 'utf-8'
	set encoding=japan
	set fileencoding=japan
endif
if has('iconv')
	let s:enc_euc = 'euc-jp'
	let s:enc_jis = 'iso-2022-jp'
	" iconvがeucJP-msに対応しているかをチェック
	if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'eucjp-ms'
		let s:enc_jis = 'iso-2022-jp-3'
	" iconvがJISX0213に対応しているかをチェック
	elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'euc-jisx0213'
		let s:enc_jis = 'iso-2022-jp-3'
	endif
	" fileencodingsを構築
	if &encoding ==# 'utf-8'
		let s:fileencodings_default = &fileencodings
		if has('mac')
			let &fileencodings = s:enc_jis .','. s:enc_euc
			let &fileencodings = &fileencodings .','. s:fileencodings_default
		else
			let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
			let &fileencodings = &fileencodings .','. s:fileencodings_default
		endif
		unlet s:fileencodings_default
	else
		let &fileencodings = &fileencodings .','. s:enc_jis
		set fileencodings+=utf-8,ucs-2le,ucs-2
		if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
			set fileencodings+=cp932
			set fileencodings-=euc-jp
			set fileencodings-=euc-jisx0213
			set fileencodings-=eucjp-ms
			let &encoding = s:enc_euc
			let &fileencoding = s:enc_euc
		else
			let &fileencodings = &fileencodings .','. s:enc_euc
		endif
	endif
	" 定数を処分
	unlet s:enc_euc
	unlet s:enc_jis
endif
" 日本語を含まない場合はfileencodingにencodingを使うようにする
if has('autocmd')
	function! AU_ReCheck_FENC()
		if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
			let &fileencoding=&encoding
		endif
	endfunction
	autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
	"set ambiwidth=single
	set ambiwidth=double
endif
" カーソル下の文字コードを取得する
" http://vimwiki.net/?tips%2F98
function! GetB()
	let c = matchstr(getline('.'), '.', col('.') - 1)
	let c = iconv(c, &enc, &fenc)
	return String2Hex(c)
endfunction
" :help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! Nr2Hex(nr)
	let n = a:nr
	let r = ""
	while n
		let r = '0123456789ABCDEF'[n % 16] . r
		let n = n / 16
	endwhile
	return r
endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
func! String2Hex(str)
	let out = ''
	let ix = 0
	while ix < strlen(a:str)
		let out = out . Nr2Hex(char2nr(a:str[ix]))
		let ix = ix + 1
	endwhile
	return out
endfunc

" pathogen.vim
source $CFGHOME/bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" Vundle
" http://vim-users.jp/2011/04/hack215/
filetype off

set runtimepath+=$CFGHOME/vundle.git/
call vundle#rc()

" Alignta
Bundle 'h1mesuke/vim-alignta.git'

" cecutil
Bundle 'vim-scripts/cecutil.git'

" ctrp
Bundle 'kien/ctrlp.vim.git'

" current function info
Bundle 'tyru/current-func-info.vim.git'

" ShowMarks
Bundle 'vim-scripts/ShowMarks.git'

" Neocomplcache
Bundle 'Shougo/neocomplcache.git'

" Omniperl
Bundle 'vim-scripts/omniperl.git'

" perl-support
Bundle 'vim-scripts/perl-support.vim.git'

" SuperTab
Bundle 'vim-scripts/SuperTab-continued..git'

" unite.vim
Bundle 'Shougo/unite.vim.git'

" unite-outline
Bundle 'h1mesuke/unite-outline.git'

" VCSCommand
Bundle 'vim-scripts/vcscommand.vim.git'

" vim-fugitive
Bundle 'tpope/vim-fugitive.git'

" vim-powerline
Bundle 'Lokaltog/vim-powerline.git'

" vim-ref
Bundle 'thinca/vim-ref.git'

" vim-surround
Bundle 'tpope/vim-surround.git'

set t_Co=256

"======================================================================
" 編集関連
"======================================================================
"ファイルタイプの自動識別を有効にする (':help incompatible-7' を参照)
"更にファイルタイププラグインを有効にする。
filetype plugin indent on
"" ファイルを開く度にカレントディレクトリを変更する
"set autochdir
"オートインデントする
set autoindent
"BSが改行、autoindentを超えて動作する
"オートインデント、改行、インサートモード開始直後にBSキーで
"削除できるようにする
set backspace=indent,eol,start
" Cインデントの設定
set cinoptions+=:0
" クリップボードを共有する
set clipboard+=unnamed
" コマンドラインの高さ
set cmdheight=1
" バックアップを作成しない
set nobackup
"C プログラムの自動インデントを無効にする(smartindent の為)
set nocindent
" 日本語行を連結する際に空白を挿入しない
set formatoptions+=mM
" 新しいバッファを開く際にメッセージを出力しない
" バッファを保存しなくても他のバッファを表示できるようにする
set hidden
"" ヒストリの保存数
"set history=50
"モードラインの有効行を10する
set modeline
set modelines=10
"" マウスを有効にする
"if has('mouse')
"	set mouse=a
"	set ttymouse=xterm2
"endif
"「賢い」インデントする
set smartindent
"" 暫く入力が無い時に保存する
"" http://vim-users.jp/2009/07/hack36/
"autocmd CursorHold  * wall
"autocmd CursorHoldI * wall
"" スワップファイルを作成しない
"set noswapfile
" 8進数を無効にする (C-a, C-xなどに影響する)
set nrformats-=octal
" キーコードは直ぐにタイムアウト、マッピングはタイムアウトしない。
set notimeout ttimeout ttimeoutlen=200
" 上書きに成功した後で削除される
"" Visual blockモードでフリーカーソルを有効にする
"set virtualedit=block
"" カーソルキーで行末/行頭を移動可能に設定
"set whichwrap=b,s,[,],<,>
" 強化されたコマンドライン補完
set wildmenu
"" 画面最下行にルーラを表示する
"set ruler
" バッファが変更されているとき、コマンドをエラーにするのではなく、
" 保存するかどうかを確認する
set confirm
" ファイルの上書きの前にバックアップを作らない
" backupがonで無い限り、いづれにせよ上書き前のバックアップは
set nowritebackup
" 今日の日付を入れておく。
" http://nanasi.jp/articles/howto/file/workingfile.html#id22
if exists("*strftime")
	let $TODAY = strftime('%Y%m%d')
endif

"======================================================================
" 検索関連
"======================================================================
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" grepでackを使ふ
" http://blog.blueblack.net/item_160
" http://d.hatena.ne.jp/secondlife/20080311/1205205348
"set grepprg=ack\ --perl
if findfile("ack-grep", "/usr/bin;") == "/usr/bin/ack-grep"
    set grepprg=ack-grep
else
    set grepprg=ack
endif
if has("autocmd")
	augroup AckGrep
		autocmd QuickfixCmdPost grep cw
	augroup END
endif

"======================================================================
" 装飾関連
"======================================================================
"シンタックスハイライトを有効にする
if has("syntax")
	syntax enable
endif
" 行末の空白を目立たせる。
" 全角空白を目立たせる。
" http://d.hatena.ne.jp/tasukuchan/20070816/1187246177
" http://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample#TOC-4
if has('autocmd') && has('syntax')
	function! VisualizeInvisibleSpace()
		highlight InvisibleSpace term=underline ctermbg=red guibg=red
		match InvisibleSpace /　\|[　	 ]\+$/
	endfunction
	augroup VisualizeInvisibleSpace
		autocmd!
		autocmd BufEnter * call VisualizeInvisibleSpace()
	augroup END
endif
" 挿入モードの際、ステータスラインの色を変更する
if has('autocmd') && has('syntax')
	function! IntoInsertMode()
		highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none
	endfunction
	function! OutInsertMode()
		highlight StatusLine guifg=darkblue guibg=white gui=none ctermfg=blue ctermbg=grey cterm=none
	endfunction
	augroup InsertHook
		autocmd!
		autocmd InsertEnter * call IntoInsertMode()
		autocmd InsertLeave * call OutInsertMode()
	augroup END
endif
"行番号を表示しない
set nonumber
" 音を鳴らさない、画面更新をしない
set noerrorbells
set novisualbell
"set visualbell t_vs=
" マクロ実行中に画面作業画を行わない
set lazyredraw
" Winでディレクトリパスの区切り文字に「/」を使えるように
if exists('+shellslash')
	set shellslash
endif
"括弧入力時の対応する括弧を表示
set showmatch
" 括弧の対応表示時間
set showmatch matchtime=1
" タブの左側にカーソル表示
" http://hatena.g.hatena.ne.jp/hatenatech/20060515/1147682761
" ※末尾の空白は必要。
set listchars=tab:\ \ 
set list
"タブ幅を設定する
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0
"入力中のコマンドをステータスに表示する
set showcmd
"検索結果文字列のハイライトを有効にする
set hlsearch
"ステータスラインを常に表示
set laststatus=2
"ステータスラインに文字コード、改行文字およびメソッド名を表示する
"要 current-func-info.vim
set statusline=%<%f\ [%{cfi#get_func_name()}()]\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%{'['.GetB().']'}%=%l,%c%V%8P
" タイトルを表示
set title

"======================================================================
" キーマップ定義
"======================================================================
"" バッファ移動用キーマップ
"" QuickBuf を入れたのでコメントアウト。
"" F2: 前のバッファ
"" F3: 次のバッファ
"" F4: バッファ削除
"map <F2> <ESC>:bp<CR>
"map <F3> <ESC>:bn<CR>
map <F4> <ESC>:bw<CR>
"表示行単位で行移動する
nnoremap j gj
nnoremap k gk
"フレームサイズを怠惰に変更する
map <kPlus> <C-W>+
map <kMinus> <C-W>-
"" ヘルプ検索
"nnoremap <F1> K
" 現在開いているviスクリプトを実行する
nnoremap <F8> :source %<CR>
" 強制終了保存を無効にする
nnoremap ZZ <Nop>
" ヒットした検索後が画面の中段に来るように
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

"======================================================================
" QuickBuf : Very small, clean but quick and POWERFUL buffer manager!
" http://www.vim.org/scripts/script.php?script_id=1910
" http://nanasi.jp/articles/vim/qbuf_vim.html
"======================================================================
let g:qb_hotkey="<F3>"

"======================================================================
" vtreeexplorer : tree based file explorer - the original
" http://www.vim.org/scripts/script.php?script_id=184
" http://d.hatena.ne.jp/obys/20061119/1163939621
"======================================================================
let g:treeExplVertical=1

"======================================================================
" Cscope
" http://cscope.sourceforge.net/
" http://blog.miraclelinux.com/penguin/2007/02/vi_7fa6.html
"======================================================================
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
	" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
	map g<C-]> :cs find 3 <C-R>=expand("<cword>")<CR><CR>
	map g<C-\> :cs find 0 <C-R>=expand("<cword>")<CR><CR>
endif

"======================================================================
" GUI設定
"======================================================================
if has("gui_running")
	" フォントを設定する
	if has("gui_gtk2")
		set guifont=MS\ Gothic\ 10
		if has("xim")
			" GTK2版gVimで"BadWindow (invalid Window parameter)"エラーが
			" 出ない樣に。
			" http://memo.officebrook.net/20080306.html
			" http://d.hatena.ne.jp/pasela/20080709/gvim
			set imactivatekey=C-space
		endif
	elseif has("gui_win32")
		set guifont=M+1VM+IPAG_circle:h10:cSHIFTJIS:w
		set guifontwide=MS\ Gothic:h10:cSHIFTJIS:w
	endif
	" 色テーマを設定する
	colorscheme evening
	" 插入モードや檢索で日本語入力状態になるのを防ぐ。
	" http://memo.officebrook.net/20080312.html
	" http://d.hatena.ne.jp/pasela/20080709/gvim
	if has("multi_byte_ime") || has("xim")
		set iminsert=0
		set imsearch=0
		inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
		nnoremap / :set imsearch=0<CR>/
		nnoremap ? :set imsearch=0<CR>?
	endif
endif

"======================================================================
" プラグイン設定 (Plugin)
"======================================================================
" Align
" http://nanasi.jp/articles/vim/align/align_vim_ext.html
" Alignを日本語環境で使用する
let g:Align_xstrlen=3
" AlignCtrlで変更した設定を初期状態に戻す
command! -nargs=0 AlignReset call Align#AlignCtrl("default")

" eregex.vim
" http://vim.wikia.com/wiki/Perl_compatible_regular_expressions#eregex.vim
" http://kaworu.jpn.org/kaworu/2010-11-28-1.php
"nnoremap / :M/
"nnoremap ./ /
"nnoremap :s :S
"nnoremap :g :G
"nnoremap :v :V
"
" Kwbd
" バッファを削除してもウィンドウのレイアウトを崩さない
" http://nanasi.jp/articles/vim/kwbd_vim.html
command! Kwbd let kwbd_bn= bufnr("%")|enew|exe "bdel ".kwbd_bn|unlet kwbd_bn

" neocomplcache
let g:neocomplcache_enable_at_startup = 1

" unite.vim
" http://d.hatena.ne.jp/ruedap/20110110/vim_unite_plugin
" http://d.hatena.ne.jp/ruedap/20110117/vim_unite_plugin_1_week
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" unite.vim上でのキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    " 単語単位からパス単位で削除するように変更
    imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
    " ESCキーを2回押すと終了する
    nmap <silent><buffer> <ESC><ESC> q
    imap <silent><buffer> <ESC><ESC> <ESC>q
endfunction

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

"======================================================================
" 以降、ファイルタイプ別の編集設定。
"======================================================================

"======================================================================
" Binary File
"======================================================================
" バイナリ編集(xxd)モード（vim -b での起動、もしくは *.bin で発動します）
" help xxd
" http://www.kawaz.jp/pukiwiki/?vim#ib970976
" http://jarp.does.notwork.org/diary/200606a.html#200606021
if has('autocmd')
	augroup BinaryXXD
		autocmd!
		autocmd BufReadPre  *.bin let &binary=1
		autocmd BufReadPost *.bin if &binary | silent %!xxd -g 1
		autocmd BufReadPost *.bin set ft=xxd | endif
		autocmd BufWritePre *.bin if &binary | %!xxd -r | endif
		autocmd BufWritePost *.bin if &binary | silent %!xxd -g 1
		autocmd BufWritePost *.bin set nomod | endif
	augroup END
endif

"======================================================================
" Haskell mode for Vim
"======================================================================
if has('autocmd')
	augroup EditHaskell
		autocmd!
		autocmd! BufRead,BufNewFile *.hs set filetype=haskell
		autocmd FileType haskell compiler ghc
		autocmd FileType haskell set nosmartindent
	augroup END
endif

let g:haddock_browser = "firefox"

"======================================================================
" For C (':h ft-c-omni' を参照)
"======================================================================
if has('autocmd')
	augroup EditC
		autocmd!
		autocmd FileType c set omnifunc=ccomplete#Complete
	augroup END
endif

"======================================================================
" For CSS (':h ft-css-omni' を参照)
"======================================================================
if has('autocmd')
	augroup EditCSS
		autocmd!
		autocmd FileType css set omnifunc=csscomplete#CompleteCSS
	augroup END
endif

"======================================================================
" For JavaScript (':h ft-javascript-omni' を参照)
"======================================================================
if has('autocmd')
	augroup EditJavaScript
		autocmd!
		autocmd FileType javascript set shiftwidth=2
		autocmd FileType javascript set softtabstop=2
		autocmd FileType javascript set tabstop=2
		autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
	augroup END
endif

"======================================================================
" For PHP (':h ft-php-omni' を参照)
"======================================================================
if has('autocmd')
	augroup EditPHP
		autocmd!
		autocmd! BufRead,BufNewFile *.inc set filetype=php
		autocmd FileType php set omnifunc=phpcomplete#CompletePHP
"	Exuberant ctags 5.7j1 が UTF-8 のソースでは
"	うまく動かないのでコメントアウト。
"	autocmd FileType php nmap <silent> <F4>
"		\ :!ctags -f %:p:h/tags
"		\ -R
"		\ --jcode=utf8
"		\ --exclude=*.js
"		\ --exclude=*.css
"		\ --exclude=*.htm
"		\ --exclude=.snapshot
"		\ --langmap="php:+.inc"
"		\ -h ".php.inc"
"		\ --totals=yes
"		\ --tag-relative=yes
"		\ --PHP-kinds=+cf-v %:p:h<CR>
"	autocmd FileType php set tags=./tags,tags
	augroup END
endif

"======================================================================
" For Perl
"======================================================================
if has('autocmd')
	augroup EditPerl
		autocmd!
		autocmd! BufRead,BufNewFile *.cgi set filetype=perl
		autocmd! BufRead,BufNewFile *.tdy set filetype=perl
		autocmd FileType perl set expandtab
		autocmd FileType perl set smarttab
		" Vimでカーソル下のPerlモジュールを開く
		" http://d.hatena.ne.jp/spiritloose/20060817/1155808744
		autocmd FileType perl set isfname-=-
		" bonnu
		autocmd BufWritePost,FileWritePost *.p[lm] !perl -MFindBin::libs -wc <afile>
	augroup END
endif

" perl-support.vim
let g:Perl_PerlcriticSeverity = 1

" Perltidy (Perl Hacks #7)
" http://perltidy.sourceforge.net/
map ,pt <ESC>:%! perltidy<CR>
map ,ptv <ESC>:%'<, '>! perltidy<CR>

"======================================================================
" For Python
"======================================================================
if has('autocmd')
	augroup EditPython
		autocmd!
		autocmd FileType python set expandtab
		autocmd FileType python set smarttab
		autocmd FileType python set omnifunc=pythoncomplete#Complete
		" http://vim.sourceforge.net/scripts/script.php?script_id=30
		" autocmd FileType python source $HOME/.vim/plugin/python.vim
	augroup END
endif

" PythonTidy
" http://cheeseshop.python.org/pypi/PythonTidy/
map ,yt <ESC>:%! pythontidy<CR>
map ,ytv <ESC>:%'<, '>! pythontidy<CR>

"======================================================================
" For R
"======================================================================
if has('autocmd')
	augroup EditR
		autocmd!
		autocmd BufRead,BufNewFile *.R set filetype=r
	augroup END
endif

"======================================================================
" For Ruby (':h ft-ruby-omni' を参照)
"======================================================================
if has('ruby') && has('autocmd')
	augroup EditRuby
		autocmd!
		autocmd FileType ruby set omnifunc=rubycomplete#CompleteTags
		autocmd FileType ruby set noexpandtab
	augroup END
endif

let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

"======================================================================
" For SQL (':h ft-sql-omni' を参照)
"======================================================================
if has('autocmd')
	augroup EditSQL
		autocmd!
		autocmd FileType sql set omnifunc=sqlcomplete#CompleteTags
	augroup END
endif

"======================================================================
" For XHTML (':h ft-xhtml-omni' を参照)
"======================================================================
if has('autocmd')
	augroup EditHTML
		autocmd!
		autocmd! BufRead,BufNewFile *.tmpl set filetype=html
		autocmd FileType html set expandtab
		autocmd FileType html set shiftwidth=2
		autocmd FileType html set smarttab
		autocmd FileType html set softtabstop=2
		autocmd FileType html set tabstop=2
		autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
		set expandtab
	augroup END
endif

"======================================================================
" For XML (':h ft-xml-omni' を参照)
"======================================================================
if has('autocmd')
	augroup EditXML
		autocmd!
		autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
	augroup END
endif

"======================================================================
" For Other (':h ft-syntax-omni' を参照)
" ※これが一番最後。
"======================================================================
if has("autocmd") && exists("+omnifunc")
	augroup EditOther
		autocmd!
		autocmd Filetype *
			\   if &omnifunc == "" |
			\           setlocal omnifunc=syntaxcomplete#Complete |
			\   endif
	augroup END
endif

"======================================================================
" その他
"======================================================================
" vimrcをリロードする
command! ReloadVimrc source $MYVIMRC

" 外部ファイルを読み込む
" http://vim-users.jp/2009/12/hack108/
if filereadable(expand($LOCALRC))
	source $LOCALRC
endif
