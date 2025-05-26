" no compatible
set nocompatible

" enable mouse
set mouse=a

" Enable True Color in Terminal
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

" Syntax highlighting
syntax on
" Onedark colorscheme
" colorscheme onedark

" vim-airline configs
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='dark'

" switch windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" utf-8 by default
set encoding=utf8

" remap leader key
let mapleader=";"

" switch buffers
map <leader>p :bp<cr>
map <leader>n :bn<cr>

" show line numbers
set number
" set line number color
" ref: https://stackoverflow.com/questions/237289/vim-configure-line-number-coloring
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Switch relative line number
map <leader>l :set invrelativenumber<CR>

" 
" NERDTree Configurations
" 

" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Open the existing NERDTree on each new tab.
" autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" insert character before cursor using ,sX
" ref: https://superuser.com/questions/581572/insert-single-character-in-vim
nmap <silent> ,s "=nr2char(getchar())<cr>P

" Close buffer without quitting vim
" ref: https://stackoverflow.com/questions/1444322/how-can-i-close-a-buffer-without-closing-the-window
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>


" vista.vim configuration

map <leader>v :Vista!!<CR>

" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }


" resize panes without pain
" Vertical: Alt + Shift + `-/+`
" Horizontal: Alt + `-/+`
nnoremap <A-+> 1<C-w>+
nnoremap <A-_> 1<C-w>-
nnoremap <A--> 1<C-w><
nnoremap <A-=> 1<C-w>>

" copy to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y 
nnoremap <leader>Y "*y
vnoremap <leader>Y "*y
