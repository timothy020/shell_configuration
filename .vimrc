" 导入其他配置文件
source ~/.vim/coc.vim

" 设置LEADER键为空格
let mapleader=" "

" 启用vim-rainbow_active插件
let g:rainbow_active = 1

" 鼠标定位
set mouse=a

syntax on 
set encoding=utf-8
set number
set relativenumber

set hlsearch
set incsearch
set smartcase

set wrap

set showcmd
set wildmenu

nnoremap s <nop>
nnoremap S :w<CR>
nnoremap Q :q<CR>
nnoremap R :source $MYVIMRC<CR>

nnoremap J j5
nnoremap K k5
nnoremap H h5
nnoremap L l5

nnoremap n nzz
nnoremap N Nzz
nnoremap <LEADER><CR> :nohlsearch<CR>

" 将Vim复制的内容传输到系统剪贴板
if has('clipboard')
    " macOS 建议使用 unnamed，或者两者都加上
    " unnamed     -> 使用 * 寄存器 (macOS 标准剪贴板)
    " unnamedplus -> 使用 + 寄存器 (X11 剪贴板)
    set clipboard=unnamed,unnamedplus
endif

" Tab长度
set tabstop=2
set shiftwidth=2
set softtabstop=2

" NerdTree
autocmd BufWritePost * NERDTreeRefreshRoot
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <C-n> :NERDTreeFocus<CR>

" vim分屏
" 切换buffer
nnoremap <C-a> :bn<CR>
nnoremap <C-d> :bp<CR>

" 切换windos
nnoremap <LEADER>s <C-W>s
nnoremap <LEADER>v <C-W>v

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-w> <C-w>w

" 调节windos大小
nnoremap <C-[> <C-w>+
nnoremap <C-]> <C-w>-
nnoremap <C-;> <C-w>>
nnoremap <C-'> <C-w><

" 按两下 Esc 消除高亮
noremap <Esc><Esc> :nohl<CR>

" 配置复制内容到系统剪贴板"

"	配置插件
call plug#begin()

" List your plugins here
Plug 'vim-airline/vim-airline'
Plug 'connorholyday/vim-snazzy'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'frazrepo/vim-rainbow'

call plug#end()
