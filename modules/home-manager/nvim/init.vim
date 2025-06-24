set termguicolors
set background=light

nnoremap n h|xnoremap n h|onoremap n h|
nnoremap e j|xnoremap e j|onoremap e j|
nnoremap i k|xnoremap i k|onoremap i k|
nnoremap o l|xnoremap o l|onoremap o l|

nnoremap y o|
nnoremap Y O|

nnoremap s i|

nnoremap k n|
nnoremap K N|

nnoremap ZQ :q<CR>
nnoremap ZW :w<CR>

autocmd FileType markdown setlocal spell spelllang=en_us
autocmd FileType nix setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

set number
set colorcolumn=80
set cursorline
set cursorcolumn
set relativenumber
"set autochdir

let mapleader=" "

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

let g:airline_theme = 'base16_solarized_light'
" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

hi clear cursorcolumn
hi link cursorcolumn cursorline
hi clear treesittercontext
hi link treesittercontext cursorline
hi clear colorcolumn
hi link colorcolumn cursorline

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_strikethrough = 1

let g:netrw_browsex_viewer = 'google-chrome-beta'
