if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   "set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin10
   let &termencoding=&encoding
   set fileencodings=utf-8,gbk,ucs-bom,cp936
endif

set nocompatible        " Use Vim defaults (much better!)
set bs=indent,eol,start         " allow backspacing over everything in insert mode
"set ai                 " always set autoindenting on
"set backup             " keep a backup file
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
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
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=^[[4%dm
     set t_Sf=^[[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

"========================================================================================+
"				  VIM 自定义配置及插件管理                                               |
"========================================================================================+
" 通过 Plug 安装管理插件
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'junegunn/vim-easy-align'
" Plugin options
Plug 'nsf/gocode', { 'rtp': 'vim' }
Plug 'https://github.com/luofei614/vim-plug', { 'dir':'~/.vim/my'}
Plug 'AutoComplPop'                  " 自动补全插件
Plug 'OmniCppComplete'
Plug 'SuperTab'
Plug 'vim-dict'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Tagbar'
Plug 'WinManager'
Plug 'taglist.vim'
Plug 'L9'
Plug 'molokai'                       " 主题插件
Plug 'vim-airline'                   " 状态行插件
Plug 'c.vim'                         " C-Support 插件
Plug 'Yggdroot/indentLine'           " 显示空格符以及缩进标识
Plug 'airblade/vim-gitgutter'        " 自动检测文件与git 上的是否有变化
Plug 'motemen/git-vim'               " git 插件
Plug 'scrooloose/syntastic'          " 语法检测插件
Plug 'mileszs/ack.vim'               " 搜索插件
Plug 'dkprice/vim-easygrep'
Plug 'Raimondi/delimitMate'          " 自动补全括号,引号插件
Plug 'scrooloose/nerdcommenter'      " 快速注释插件
Plug 'vim-scripts/vim-auto-save'     " 自动保存插件
Plug 'juneedahamed/svnj.vim'         " svn 插件
Plug 'vcscommand.vim'                " CVS/SVN/SVK/git/hg/bzr插件
Plug 'gdbmgr'                        " 调试插件
Plug 'wakatime/vim-wakatime'         " 记录编程时间
Plug 'xterm-color-table.vim'         " VIM 显示颜色值插件
" Auto Insert code segment
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'           " 自动插入代码块
" Options
Plug 'honza/vim-snippets'
Plug 'doxygen/doxygen'
Plug 'vim-scripts/DoxyGen-Syntax'    " 注释高亮插件
Plug 'vim-scripts/Engspchk'          " 英文拼写检查
Plug 'DoxygenToolkit.vim'

call plug#end()

" vim 基本配置
set t_Co=256                    " 终端使用256位色
colorscheme molokai  		" 配色主题
let g:molokai_original = 1
set guifont=Consolas\ 11
set number                      " 显示行号
set laststatus=2                " 总是显示状态栏
set cmdheight=2                 " 命令行高度
set showcmd
set showmode
set showmatch
set incsearch
set hlsearch
" 自动匹配与光标所在单词相同的
highlight WordUnder guibg=#008080 ctermbg=6
autocmd CursorMoved * exe printf('match WordUnder /\V\<%s\>/', escape(expand('<cword>'), '/\'))
" autocmd CursorHold * exe printf('match WordUnder /\V\<%s\>/', escape(expand('<cword>'), '/\'))
" autocmd CursorMoved * silent! exe printf('match WordUnder /\V\<%s\>/', escape(expand('<cword>'), '/\'))
" autocmd CursorMoved * silent! exe printf('match Underlined /\<%s\>/', expand('<cword>'))
" autocmd CursorHold * silent! exe printf('match Underlined /\<%s\>/', expand('<cword>'))
" 高亮汇编代码
"let filetype_i="asm"
let asmsyntax="nasm"
" au BufNewFile,BufRead *.ASM set filetype=masm
highlight WhitespaceEOL ctermbg=red guibg=red
set cursorline
" autocmd InsertLeave * set nocul
" autocmd InsertEnter * set cul
" autocmd WinLeave * set nocursorline nocursorcolumn
" autocmd WinEnter * set cursorline cursorcolumn
" set cursorline cursorcolumn

set mouse=a
set clipboard+=unnamed
behave mswin

function Maximize_Window()
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction

if has("gui_running")
" 窗口设置
    set guioptions-=L " 去掉左侧滚动条
    set guioptions-=T
    au GUIEnter * call Maximize_Window() " 窗口启动时最大化
endif
set ambiwidth=double

" 取消自动备份
set nobackup
" 自动更新保存
set autoread
set autowrite
set viminfo+=!
"let autosave=5

" 设置编程格式
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent      " 自动对齐
set cindent         " c语言风格
set expandtab       " 使用空格代替tab
set linebreak       " 整词换行
set iskeyword+=_,$,@,%,#,-
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/     " 匹配行尾空格

" 配置 dict 用于自动补全
au FileType c   setlocal dict+=~/.vim/dict/c.dict
au FileType cpp setlocal dict+=~/.vim/dict/cpp.dict
au FileType vim setlocal dict+=~/.vim/dict/vim.dict

" 代码提示菜单配色
highlight Pmenu    guibg=#303030      guifg=white   ctermbg=236   ctermfg=white
highlight PmenuSel guibg=#00afaf      guifg=white   ctermbg=37    ctermfg=white

" 配置 DoxyGen-Syntax
set syntax=cpp.doxygen

" 配置 snipMate
let g:snipMate = get(g:, 'snipMate', {}) " Allow for vimrc re-sourcing
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['ruby'] = 'ruby,rails'

" 配置 EasyGrep
let g:EasyGrepCommand=1
let g:EasyGrepPerlStyle=1

" 配置状态栏airline
let g:airline_theme="molokai"
let g:airline_powerline_fonts=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:airline_section_a       (mode, crypt, paste, spell, iminsert)
"let g:airline_section_b       (hunks, branch)
"let g:airline_section_c       (bufferline or filename)
"let g:airline_section_gutter  (readonly, csv)
"let g:airline_section_x       (tagbar, filetype, virtualenv)
"let g:airline_section_y       (fileencoding, fileformat)
"let g:airline_section_z       (percentage, line number, column number)
"let g:airline_section_error   (ycm_error_count, syntastic, eclim)
"let g:airline_section_warning (ycm_warning_count, whitespace)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_section_warning='%{strftime("%Y-%m-%d %H:%m")}'
" let g:airline_section_y='BN: %{bufnr("%")}'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
let g:airline#extensions#whitespace#enable=0
let g:airline#extensions#whitespace#symbol='!'
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = '|'
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = ''
if !exists('g:airline_symbols')
    let g:airline_symbols={}
endif
nnoremap <C-PageUp> :bp<CR>
nnoremap bp :bp<CR>
nnoremap bn :bn<CR>
nnoremap <C-PageDown> :bn<CR>

" NERDTree配置
let NERDChristmasTree=0
let NERDTreeWinSize=25
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="left"
let NERDTreeMinimalUI=1
"let NERDTreeQuitOnOpen=1
"let NERDTreeShowLineNumbers=1
map <F2> :NERDTreeToggle<CR>
" autocmd VimEnter * nested :NERDTree|2wincmd w
autocmd FileType c,cpp,h,hpp,cc nested :NERDTree|2wincmd w

" Taglist配置
let Tlist_Show_One_File=1
let Tlist_Auto_Update=1
let Tlist_WinWidth=25
" let Tlist_WinHeight=50
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Use_Right_Window=1
let Tlist_Show_Menu=1
let Tlist_Enable_Fold_Column=1
" let Tlist_Auto_Open=1
map <F3> :TlistToggle<CR>
" autocmd VimEnter * nested :Tlist
autocmd FileType c,cpp,h,hpp,cc nested :Tlist

" indentLine配置
"let g:indentLine_char = '┊'
let g:indentLine_char = '¦'
let g:indentLine_fileType = ['c', 'cpp']
let g:indentLine_fileTypeExclude = ['text', 'sh']
let g:indentLine_leadingSpaceEnabled = 1

" 配置 EasyGrep 插件
let g:EasyGrepMode = 2
let g:EasyGrepCommand = 0
let g:EasyGrepRecursive = 1
let g:EasyGrepIgnoreCase = 0
let g:EasyGrepFilesToExclude = "*.bak,*~,cscope.*,*.a,*.o,*.pyc"

" C-Support 配置
let g:C_UseTool_cmake   = 'yes'
let g:C_UseTool_doxygen = 'yes'
let g:C_Printheader = "%<%f%h%m%<  %=%{strftime('%x %X')}   SEITE %N"
"let g:C_Styles = { '*.c,*.h' : 'C', '*.cc,*.cpp,*.c++,*.C,*.hh,*.h++,*.H' : 'CPP' }

" GitGutter 配置
" autocmd User GitGutter call updateMyStatusLine()
let g:gitgutter_sign_column_always = 1
let g:gitgutter_enabled = 0     " 关闭gitgutter 否则vim 会变得很卡

" Auto-Save 配置
let g:auto_save = 1
let g:auto_save_silent = 1
autocmd CursorHoldI * call AutoSave()

" wakatim 配置
let g:wakatime_PythonBinary = '/usr/bin/python'

" 自动补全
let g:acp_behaviorKeywordLength=1
let g:acp_mappingDriven=1

set completeopt=menu,menuone " 关闭智能补全时的预览窗口
let OmniCpp_GlobalScopeSearch=1
let OmniCpp_NamespaceSearch=1
let OmniCpp_DisplayMode=1
let OmniCpp_ShowScopeInAbb=1
let OmniCpp_ShowPrototypeInAbbr=1
let OmniCpp_ShowAccess=1
let OmniCpp_DefaultNamespaces=["std"]
let OmniCpp_MayCompleteDot=1
let OmniCpp_MayCompleteScope=1
let OmniCpp_MayCompleteArrow=1
let OmniCpp_SelectFirstItem=2
let OmniCpp_LocalSearchDecl=1

set tags+=~/.vim/tags/cpp
set tags+=$MyProject/tags

" 快捷键配置
function! SaveFile()  " 保存文件
    exec "w"
endfunction
map  <c-s> :call SaveFile()<CR>
imap <c-s> <ESC>:call SaveFile()<CR>
vmap <c-s> <ESC>:call SaveFile()<CR>
" 全选快捷键
map <C-A> ggVG
map! <C-A> <ESC>ggVG
" 选中状态下复制剪切快捷键
vmap <C-C> Y
vmap <C-X> X
" 粘贴快捷键
vmap <C-V> P
" 撤销快捷键
map <C-Z> u
imap <C-Z> <ESC>u
vmap <C-Z> <ESC>u

" 查询快捷键
nmap <C-F> :promptrepl<CR>
imap <C-F> <ESC> :promptrepl<CR>

" C,C++ 注释快捷键配置
nmap <C-K><C-F> :call FunComment()<CR>
function FunComment()
    let line_num = line(".")
        call append(line_num+0, "\/**")
        call append(line_num+1, " * @name  :")
        call append(line_num+2, " * @brief :")
        call append(line_num+3, " * @param :")
        call append(line_num+4, " * @return:")
        call append(line_num+5, " */")
endfunction

nmap <C-K><C-S> :call StructComment()<CR>
function StructComment()
    let line_num = line(".")
        call append(line_num+0, "\/**")
        call append(line_num+1, " * @name :")
        call append(line_num+2, " * @brief:")
    call append(line_num+3, " */")
endfunction

" 行注释快捷键
map <C-K><C-I> I//<ESC>
map <C-K><C-O> ^xx
imap <C-K><C-I> <ESC>I//
imap <C-K><C-O> <ESc>^xxi

" 块注释
vmap <C-K><C-I> DO*/<ESC>PO/*<ESC>

" C、C++ 编译运行调试快捷键
map <F5> :call CompileGcc() <CR>
imap <F5> <ESC>:call CompileGcc() <CR>
vmap <F5> <ESC>:call CompileGcc() <CR>
func! CompileGcc()
        exec "w"
        exec "!g++ -g % -o %<"
endfunc

map <C-F5> :call CompileRunGcc() <CR>
imap <C-F5> <ESC>:call CompileRunGcc() <CR>
vmap <C-F5> <ESC>:call CompileRunGcc() <CR>
func! CompileRunGcc()
        call CompileGcc()
        call RunGcc()
endfunc

map <F6> :call RunGcc() <CR>
imap <F6> <ESC>:call RunGcc() <CR>
vmap <F6> <ESC>:call RunGcc() <CR>
func! RunGcc()
        exec "! ./%<"
endfunc

map <F7> :call Make() <CR>
imap <F7> <ESC>:call Make() <CR>
vmap <F7> <ESC>:call Make() <CR>
func! Make()
        exec "w"
        exec "! make"
endfunc

map <C-F7> :call MakeClean() <CR>
imap <C-F7> <ESC>:call MakeClean() <CR>
vmap <C-F7> <ESC>:call MakeClean() <CR>
func! MakeClean()
        exec "! make clean"
endfunc

" map <F8> :call RunGdb() <CR>
" imap <F8> <ESC>:call RunGdb() <CR>
" vmap <F8> <ESC>:call RunGdb() <CR>
" func! RunGdb()
"         "call CompileGcc()
"         exec "!gdb ./%<"
" endfunc

map <F8>  :DI <CR>
imap <F8> :DI <CR>

" 配置 F12 生成tags
nmap <F12>      :!ctags -R .<CR>
imap <F12> <ESC>:!ctags -R .<CR>
vmap <F12> <ESC>:!ctags -R .<CR>

" 配置保存退出快捷键
nmap wq :wq<CR>
nmap w  :w<CR>
nmap q  :q<CR>

" 窗口分割后,切换聚焦窗口
map <C-Down>  <C-W>j
map <C-Up>    <C-W>k
map <C-Left>  <C-W>h
map <C-Right> <C-W>l

" 自动插入文件头
autocmd BufNewFile *.[ch],*.hpp,*.cpp,*.cc exec "call SetTitle()"
" 加入注释
func SetComment()
        call append(0,"/**")
        call append(1,   " ******************************************************************************************************")
        call append(2, " * Copyright(C)" .strftime("%Y")." All rights reserved.")
        call append(3, " *")
        call append(4, " * filename  : ".expand("%:t"))
        call append(5, " * author    : Quitin")
        call append(6, " * createtime: ".strftime("%Y-%m-%d"))
        call append(7, " * brief     :")
        call append(8, " *")
        call append(9, " * update    : ".strftime("%Y-%m-%d"))
        call append(10, " *")
        call append(11," ******************************************************************************************************")
        call append(12,"**/")
endfunction

func SetTitle()
"       call SetComment()
    let line_num = line(".")
        if expand("%:e")=='hpp' || expand("%:e")=='h'
        call append(line_num+0, "#ifndef __".toupper(expand("%:t:r"))."_H")
        call append(line_num+1, "#define __".toupper(expand("%:t:r"))."_H")
        call append(line_num+2, "#ifdef __cplusplus")
        call append(line_num+3, "extern \"C\"")
        call append(line_num+4, "{")
        call append(line_num+5, "#endif")
        call append(line_num+6, "")
        call append(line_num+7, "#ifdef __cplusplus")
        call append(line_num+8, "}")
        call append(line_num+9, "#endif")
        call append(line_num+10, "#endif //".toupper(expand("%:t:r"))."_H end")
        "exec '20:'
        elseif expand("%:e")=='c'
        call append(line_num+0, "#include <stdio.h>")
"        call append(line_num+1, "#include <stdlib.h>")
        call append(line_num+1, "#include <string.h>")
        "call append(16, "#include \"".expand("%:t:r").".h\"")
        call append(line_num+2, "")
        call append(line_num+3, "int main(int argc, char* argv[])")
        call append(line_num+4, "{")
        call append(line_num+5, "    return 0;")
        call append(line_num+6, "}")
        "exec '20:'
        elseif expand("%:e")=='cpp'
        call append(line_num+0, "#include <iostream>")
        "call append(14, "#include \"".expand("%:t:r").".h\"")
        call append(line_num+1, "")
        call append(line_num+2, "using namespace std;")
        call append(line_num+3, "")
        call append(line_num+4, "int main(int argc, char* argv[])")
        call append(line_num+5, "{")
        call append(line_num+6, "    return 0;")
        call append(line_num+7, "}")
        "exec '20:'
        endif
endfunc

