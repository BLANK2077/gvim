"1 .vimrc default 
set encoding=utf-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8

let mapleader="'"
"window motion key
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <s-j> <c-w>+
nnoremap <s-k> <c-w>-
nnoremap <c-[> <c-w>]

"map open or auto source .vimrc
nnoremap <leader>ev :sp ~/.vimrc<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>

"save files as windows
nnoremap <c-s> :w!<cr>

"在所有模式下都允许使用鼠标，还可以是n,v,i,c等
set mouse=a

" =========
" 功能函数
" =========
" 获取当前目录
func! GetPWD()
    return substitute(getcwd(), "", "", "g")
endf


" =========
" 环境配置
" =========

" 保留历史记录
set history=400

" 命令行于状态行
set ch=1
set wrap
set stl=\ [File]\ %F%m%r%h%y[%{&fileformat},%{&fileencoding}]\ %w\ \ [PWD]\ %r%{GetPWD()}%h\ %=\ [Line]\ %l,%c\ %=\ %P 
set ls=2

" 制表符
set tabstop=4
set smarttab
set shiftwidth=4
set softtabstop=4

" 行控制
set linebreak
set nocompatible
set textwidth=80
set wrap

" 行号和标尺
set number
set ruler
"set rulerformat=%15(%c%V\ %p%%%)


" 控制台响铃
:set noerrorbells
:set novisualbell
:set t_vb= "close visual bell

" 插入模式下使用 <BS>、<Del> <C-W> <C-U>
set backspace=indent,eol,start


" 标签页
set tabpagemax=20
set showtabline=1

" 缩进 智能对齐方式
set autoindent
"set smartindent

" 自动重新读入
set autoread

"代码折叠
"设置折叠模式
set foldcolumn=2
"光标遇到折叠，折叠就打开
"set foldopen=all
"移开折叠时自动关闭折叠
"set foldclose=all
"zf zo zc zd zr zm zR zM zn zi zN
"依缩进折叠
"   manual  手工定义折叠
"   indent  更多的缩进表示更高级别的折叠
"   expr    用表达式来定义折叠
"   syntax  用语法高亮来定义折叠
"   diff    对没有更改的文本进行折叠
"   marker  对文中的标志折叠
set foldmethod=syntax
"启动时不要自动折叠代码
set foldlevel=100
"依标记折叠
""set foldmethod=marker


"设定文件浏览器目录为当前目录
set bsdir=buffer

" 自动切换到文件当前目录
set autochdir

"在查找时忽略大小写
set ignorecase
set incsearch
set hlsearch

"设置命令行的高度
set cmdheight=2

"显示匹配的括号
set showmatch

"增强模式中的命令行自动完成操作
set wildmenu

"实现全能补全功能，需要打开文件类型检测
filetype plugin indent on
"打开vim的文件类型自动检测功能
"filetype on


" 恢复上次文件打开位置
"set viminfo='10,\"100,:20,%,n~/.viminfo
set viminfo=\"50,'1000,h,f1,rA:,r$TEMP:,r$TMP:,r$TMPDIR:,:500,!


" =========
" 图形界面
" =========
if has('gui_running')
    " 只显示菜单
    set guioptions=mcr

    " 高亮光标所在的行
    set cursorline
	set cursorcolumn

    " 编辑器配色
	colorscheme desert

endif

"设置VIM状态栏
set laststatus=2 "显示状态栏(默认值为1, 无法显示状态栏)
set statusline=  "[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]
set statusline+=%1*%-3.3n%0*\ " buffer number
set statusline+=%f\ " file name
set statusline+=%h%1*%m%r%w%0* " flag
set statusline+=[
if v:version >= 600
    set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
    set statusline+=%{&fileencoding}, " encoding
endif
set statusline+=%{&fileformat}] " file format
set statusline+=\        
set statusline+=0x%-8B " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset
if filereadable(expand("~/vimfiles/plugin/vimbuddy.vim"))
    set statusline+=\ %{VimBuddy()} " vim buddy
endif

"设置无备份文件
set writebackup
set nobackup


""""""""""""""""""""""""""""'
"" plugin configure
""""""""""""""""""""""""""""

"2 sv/uvm syntax color support
"support by vhda/verilog_systemverilog.vim 
syntax enable
syntax on
filetype plugin indent on

"3 基于tags自动跳转
set tags=./tags
set tags+=/usr/synopsys/L-2016.06/etc/uvm-1.1/.tags
nnoremap <leader>tt :tnext<CR>  
nnoremap <leader>tp :tpre<CR>  
nnoremap <leader>tl :tselect <c-R>0<CR>

"4 自动补全
"Plug 'othree/vim-autocomplpop'
"Auto completion using the TAB key " 自动补全括号，引号
"This function determines, wether we are on 
"the start of the line text(then tab indents) 
"or if we want to try auto completion 
function! InsertTabWrapper() 
     let col=col('.')-1 
     if !col || getline('.')[col-1] !~ '\k' 
         return "\<TAB>" 
     else 
         return "\<C-N>" 
     endif 
endfunction 
"Remap the tab key to select action with InsertTabWrapper 
inoremap <TAB> <C-R>=InsertTabWrapper()<CR>

"5.基于语法自动折叠
filetype plugin indent on
let g:verilog_syntax_fold_lst = "function,task"

"6.NEEDTree目录树管理
nnoremap <C-n> :NERDTreeToggle<CR>

"7 广义标签跳转 matchit
runtime! macros/matchit.vim
if exists('loaded_matchit')
  let b:match_ignorecase=0
  let b:match_words=
			  \'<begin>:<end>,' .
			  \'<if>:<else>,' .
			  \'<module>:<endmodule>,' .
			  \'<class>:<endclass>,' .
			  \'<program>:<endprogram>,' .
			  \'<clocking>:<endclocking>,' .
			  \'<property>:<endproperty>,' .
			  \'<sequence>:<endsequence>,' .
			  \'<package>:<endpackage>,' .
			  \'<covergroup>:<endgroup>,' .
			  \'<primitive>:<endprimitive>,' .
			  \'<specify>:<endspecify>,' .
			  \'<generate>:<endgenerate>,' .
			  \'<interface>:<endinterface>,' .
			  \'<function>:<endfunction>,' .
			  \'<task>:<endtask>,' .
			  \'<case>|<casex>|<casez>:<endcase>,' .
			  \'<fork>:<join>|<join_any>|<join_none>,' .
			  \'`ifdef>:`else>:`endif>,'
endif

"8.quickfix && errorformat
set makeprg=vcs
"autocmd BufReadPost *.sv,*.v :VerilogErrorFormat vcs 0
nnoremap <leader>fmt :VerilogErrorFormat vcs 0<cr>
nnoremap cn :cn<cr>
nnoremap cp :cp<cr>
nnoremap cl :cl<cr>
nnoremap cw :cw 10<cr>
"
"9.tag浏览 tagbar
nmap <F8> :TagbarToggle<CR>
"
"10.文本内跳转 easymotion
"'easymotion/vim-easymotion'

"11.模糊搜索 fzf
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
let g:fzf_action = { 'ctrl-e': 'edit' }
"<Leader>f在当前目录搜索文件
nnoremap <silent> <Leader>f :Files<CR>
"<Leader>b切换Buffer中的文件
nnoremap <silent> <Leader>b :Buffers<CR>
"<Leader>p在当前所有加载的Buffer中搜索包含目标词的所有行，:BLines只在当前Buffer中搜索
nnoremap <silent> <Leader>p :Lines<CR>
"<Leader>h在Vim打开的历史文件中搜索，相当于是在MRU中搜索，:History：命令历史查找
nnoremap <silent> <Leader>h :History<CR>

"12. vim-surround
"Plug 'tpope/vim-surround'
"
"13.gutentags
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
" 配置 ctags 的参数 "
let g:gutentags_ctags_extra_args = ['-R', '--languages=systemverilog', '--extra=+q','--fields=+i']
"let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
"let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

call plug#begin('~/.vim/plugged')
 Plug 'junegunn/vim-easy-align'
 Plug 'preservim/nerdtree'
 Plug 'vhda/verilog_systemverilog.vim'
 Plug 'preservim/tagbar'
 Plug 'easymotion/vim-easymotion'
 Plug 'tpope/vim-surround'
 Plug 'ludovicchabant/vim-gutentags'
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 Plug 'junegunn/fzf.vim'
call plug#end()

echo ">^.^< update the vimrc"
