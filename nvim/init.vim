"-----------------
" map settings
"-----------------
" ':'换成','
let mapleader=","
nmap <leader>wq :wq<CR>
nmap <leader>w :w!<CR>
" 移除 Windows 文件结尾的 `^M`
noremap <leader>m :%s/<C-V><C-M>//ge<CR>
" 切换窗口的键盘映射
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" 直接用方向键切换缓存的键盘映射
map <right> :bn<CR>
map <left>  :bp<CR>
map <up>    :bf<CR>
map <down>  :bl<CR>

"-----------------
" Plugin
"-----------------
call plug#begin()
    Plug 'altercation/vim-colors-solarized' "vim主题
    Plug 'vim-airline/vim-airline'  "vim状态栏
    Plug 'vim-airline/vim-airline-themes'
    Plug 'junegunn/vim-easy-align'  "符号对齐
    Plug '/usr/local/opt/fzf'
    Plug 'junegunn/fzf.vim' " 搜索插件
    Plug 'Yggdroot/indentLine'   "缩进标线
    Plug 'junegunn/vim-easy-align'  "代码对齐
    Plug 'scrooloose/nerdtree'  " 文件管理器
    Plug 'universal-ctags/ctags'    " 代码提纲
    Plug 'tomtom/tcomment_vim'  " 注释
    Plug 'Raimondi/delimitMate' " 补全括号
    Plug 'dense-analysis/ale'     " 代码检测
    Plug 'easymotion/vim-easymotion' " 快速移动
    Plug 'neoclide/coc.nvim', {'branch': 'release'}   " 代码补全框架
call plug#end()

"-----------------
" UI  settings
"-----------------
set guifont=monaco:h16:cUTF-8:qDRAFT    " 字体设置
syntax enable
set background=dark
colorscheme solarized
let g:airline_theme='bubblegum'

"-----------------
" settings
"-----------------
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936 "设置编码
set termencoding=utf-8
set encoding=utf-8
set number      "设置行号
set cursorline  "高亮行
set mouse=a     "启用鼠标
set selection=exclusive
set selectmode=mouse,key
set autoindent  " 自动缩进
set paste   " 设置粘贴模式
set showmatch   " 括号匹配
set smarttab    "智能制表符
set tabstop=4   " 设置Tab长度为4空格
set shiftwidth=4   " 设置自动缩进长度为4空格
set nocompatible    "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set foldenable      " 允许折叠
set showcmd         " 输入的命令显示出来，看的清楚些
set listchars=tab:>-,trail:-    " 显示空格和tab键
set cmdheight=1    " 命令行高度为两行
set laststatus=1   " 显示状态栏
set ruler  " 显示光标当前位置
filetype plugin indent on   " 打开文件类型检测
set incsearch   " 即时显示匹配结果
set hlsearch    " 高亮所有结果
map <silent> <leader><CR> :nohlsearch<CR>
set ignorecase  " 忽略大小写
set smartcase   " 搜索模式里有大写字母，就不再忽略大小写
set formatoptions+=mM   " 在断行、合并(join)行时，针对多字节字符（比如中文）的优化处理
set magic       " 设置魔术
set hidden      " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set autochdir   " 自动切换当前目录为当前文件所在的目录
set nobackup    " 覆盖文件时不备份
set nowritebackup
set noswapfile  " 不用交换文件
set fenc=
set re=1
set lazyredraw  " 切换缓存时不用保存
set synmaxcol=128
syntax sync minlines=256

set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175    " 光标闪烁

au FileType text,markdown,html,xml set wrap  " 设置折行
set linebreak   " 折行时，以单词为界，以免切断单词
set breakindent " 折行后的后续行，使用与第一行相同的缩进

"-----------------
" function settings
"-----------------
" auto fcitx 退出插入模式和命令行模式自动切换
let g:input_toggle = 1
function! Fcitx2en()
    let s:input_status = system("fcitx-remote")
    if s:input_status == 2
        let g:input_toggle = 1
        let l:a = system("fcitx-remote -c")
    endif
endfunction
set ttimeoutlen=150
autocmd InsertLeave * call Fcitx2en() "退出插入模式

" 高亮不想要的空格，比如行尾
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches() " for performance

" 保存时自动删除行尾空格
func! DeleteTrailingWS()
    exec "normal mz"
    %s/\s\+$//ge
    exec "normal `z"
endfunc
au BufWrite * :call DeleteTrailingWS()
map <leader>W :call DeleteTrailingWS()<CR>

"-----------------
" Plugin settings
"-----------------
" nerdtree
nmap <F2> :NERDTreeToggle<CR> " F2 快速切换

" ctags
 nmap <F8> :TagbarToggle<CR>

" delimitMate
" For Python docstring.
au FileType python let b:delimitMate_nesting_quotes = ['"']

" indentLine
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0
let g:indentLine_char = '|'

" easy-motion
let g:EasyMotion_leader_key = '<Leader>'

" fzf
function! OpenFloatingWin()
	let opts = {
				\ 'relative': 'editor',
				\ 'row': 1,
                                \ 'col': 71,
				\ 'width': 71,
				\ 'height': 37 / 2
				\ }
	let buf = nvim_create_buf(v:false, v:true)
	let win = nvim_open_win(buf, v:true, opts)

        call setwinvar(win, '&winhl', 'Normal:Chenfa')

	setlocal
				\ buftype=nofile
				\ nobuflisted
				\ bufhidden=hide
				\ nonumber
				\ norelativenumber
				\ signcolumn=no
endfunction
" 让输入上方，搜索列表在下方
let $FZF_DEFAULT_OPTS = '-i --layout=reverse --color=hl:50,hl+:200,info:88,fg+:0,bg+:150'
let $FZF_DEFAULT_COMMAND ='fd --type f --hidden --color=never -E .git'
" 打开 fzf 的方式选择 floating window
let g:fzf_layout = { 'window': 'call OpenFloatingWin()' }

" coc.nvim
" 解决coc启动稍微延迟问题
let g:coc_start_at_startup=0
function! CocTimerStart(timer)
    exec "CocStart"
endfunction
call timer_start(500,'CocTimerStart',{'repeat':1})
"解决coc.nvim大文件卡死状况
let g:trigger_size = 0.5 * 1048576

augroup hugefile
  autocmd!
  autocmd BufReadPre *
        \ let size = getfsize(expand('<afile>')) |
        \ if (size > g:trigger_size) || (size == -2) |
        \   echohl WarningMsg | echomsg 'WARNING: altering options for this huge file!' | echohl None |
        \   exec 'CocDisable' |
        \ else |
        \   exec 'CocEnable' |
        \ endif |
        \ unlet size
augroup END
" 其他coc.nvim相关配置（详情，请参考coc的文档配置）
inoremap <silent><expr> <m-,> coc#refresh()
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <leader>h :call CocAction('doHover')<cr>

command! -nargs=* Cocformat call CocActionAsync('format')
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('jumpDefinition')
    endif
endfunction
autocmd FileType css,html let b:coc_additional_keywords = ["-"]
autocmd FileType php let b:coc_root_patterns = ['.htaccess', '.phpproject']
autocmd FileType javascript let b:coc_root_patterns = ['.jsproject']
autocmd FileType java let b:coc_root_patterns = ['.javasproject']
autocmd FileType python let b:coc_root_patterns = ['.pyproject']
autocmd FileType c,cpp let b:coc_root_patterns = ['.htaccess', '.cproject']
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'
let g:coc_filetype_map = {
        \ 'html.swig': 'html',
        \ 'wxss': 'css',
        \ }
command! -nargs=0 OR
        \ :call CocActionAsync('runCommand', 'tsserver.organizeImports')
"let $NVIM_COC_LOG_LEVEL='debug'
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
nnoremap <silent> ,y  :<C-u>CocList -A --normal yank<cr>
autocmd FileType tex let b:coc_pairs = [["$", "$"]]
nmap <f4> <Plug>(coc-translator-p)
