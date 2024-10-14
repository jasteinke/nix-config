    nnoremap n h|xnoremap n h|onoremap n h|
    nnoremap e j|xnoremap e j|onoremap e j|
    nnoremap i k|xnoremap i k|onoremap i k|
    nnoremap o l|xnoremap o l|onoremap o l|

    nnoremap y o|
    nnoremap Y O|

    nnoremap s i|

    nnoremap k n|
    nnoremap K N|

    autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
    autocmd FileType nix    setlocal expandtab shiftwidth=2 softtabstop=2

    set number
    set colorcolumn=80
    set cursorline
    set cursorcolumn
    set relativenumber

    let mapleader=" "

    nnoremap <leader>ff <cmd>Telescope find_files<cr>
    nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    nnoremap <leader>fb <cmd>Telescope buffers<cr>
    nnoremap <leader>fh <cmd>Telescope help_tags<cr>

    let g:airline_theme='catppuccin'

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

    hi clear colorcolumn
    hi link colorcolumn cursorcolumn
    hi clear treesittercontext
    hi link treesittercontext cursorcolumn


