"
" ~/.vimrc
"
" Alberto Pettarin
" alberto@albertopettarin.it
"
" MIT license
" 2017-01-08
"

" Initialization {{{
    " Use Vim settings, rather than Vi
    set nocompatible

    " Apply syntax highlighting
    syntax on

    " Jump to the last position when reopening a file
    if has("autocmd")
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal g'\"" | endif
    endif

    " Indent according to filetype
    if has("autocmd")
      filetype indent on
    endif
" }}}

" Visual and GUI {{{
    set title                       " Set the terminal's title
    set mouse=a                     " Enable mouse usage (all modes) in terminals
    "set visualbell                  " No beeping.
    set lazyredraw                  " Redraw only when we need to
    set wrap                        " Turn on line wrapping
    set ruler                       " Show cursor position
    set number                      " Show line numbers
    "set cursorline                  " Highlight current line
    "set laststatus=2                " Always show a status line
    set scrolloff=3                 " Show 3 lines of context around the cursor
    set display+=lastline           " Display as much as possibe of a window's last line
    set showcmd                     " Show (partial) command in status line.
" }}}

" Backup and Undo {{{
    "set nobackup                    " No backups
    "set nowritebackup               " No backups
    "set noswapfile                  " No swap file
    set autoread                    " Automatically re-read files changed outside Vim
    set autowrite                   " Automatically save before commands like :next and :make
    if has('persistent_undo')       " Enable persistent undo
        set undolevels=5000
        set undodir=$HOME/.VIMUNDO
        set undofile
    endif
    set updatecount=50              " Autosave every 50 keystrokes
    set fileformats=unix,mac,dos    " Prefer Unix, but handle Mac and DOS line end chars
" }}}

" TAB and BS {{{
    set backspace=indent,eol,start  " Natural backspace
    set tabstop=4                   " Replace tabs with 4 spaces
    set shiftwidth=4                " Indent by 4 spaces
    set expandtab                   " Add appropriate number of spaces to yield a tab
" }}}

" Find {{{
    set showmatch                   " Show matching brackets.
    set ignorecase                  " Do case insensitive matching
    set smartcase                   " Do smart case matching
    set incsearch                   " Incremental search
    set hlsearch                    " Highlight matches
    set hidden                      " Hide buffers when they are abandoned
" }}}

" Folds {{{
    set foldenable                  " Enable folding
    set foldmethod=indent           " fold based on indent level
    set foldlevelstart=5            " open most folds by default
    set foldnestmax=10              " 10 nested fold max
    set foldminlines=2              " do not fold if less than 2 lines
" }}}

" Colors {{{
    " highlight trailing spaces
    " from http://vim.wikia.com/wiki/Highlight_unwanted_spaces
    highlight ExtraWhitespace ctermbg=darkred guibg=darkred
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkred guibg=darkred
    autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL

    " highlight non-ASCII characters
    highlight NonASCII ctermbg=darkblue guibg=darkblue
    autocmd ColorScheme * highlight NonASCII ctermbg=darkblue guibg=darkblue
    autocmd BufEnter * syn match NonASCII /[^\x00-\x7F]/ containedin=ALL

    " set color scheme to stingray
    set t_Co=256
    colors stingray
" }}}

" Browse inside containers {{{
    "au BufReadCmd  *.epub  call zip#Browse(expand("<amatch>")) " supported Vim 8
    au BufReadCmd   *.abz   call zip#Browse(expand("<amatch>"))
    au BufReadCmd   *.cbz   call zip#Browse(expand("<amatch>"))
    au BufReadCmd   *.e0    call zip#Browse(expand("<amatch>"))
" }}}

" Key bindings {{{
    " make comma the new <Leader>
    let mapleader=","

    " map jk combination to ESC in insert mode
    inoremap jk <esc>

    " turns off search highlighting
    nnoremap <Leader><space> :noh<CR>
    nnoremap <Leader>. :noh<CR>

    " space open/closes folds
    nnoremap <space> za

    " open Ack/SilverSearch
    nnoremap <leader>a :Ack<CR>

    " toggle gundo
    nnoremap <leader>u :GundoToggle<CR>
" }}}

" Plugins {{{
    " DISABLED
    " CtrlP
    "set runtimepath^=~/.vim/bundle/ctrlp.vim
    "let g:ctrlp_match_window = 'bottom,order:ttb'
    "let g:ctrlp_switch_buffer = 0
    "let g:ctrlp_working_path_mode = 0
    "let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

    " DISABLED
    " Ack/SilverSearch
    "if executable('ag')
    "    let g:ackprg = 'ag --vimgrep --smart-case'
    "    cnoreabbrev ag Ack
    "    cnoreabbrev aG Ack
    "    cnoreabbrev Ag Ack
    "    cnoreabbrev AG Ack
    "endif
" }}}

" Autogroups {{{
    augroup configgroup
        autocmd!
        autocmd VimEnter * highlight clear SignColumn
        autocmd BufWritePre *.py,*.js,*.txt,*.hs,*.java,*.md :call <SID>StripTrailingWhitespaces()
        autocmd FileType java setlocal noexpandtab
        autocmd FileType java setlocal list
        autocmd FileType java setlocal listchars=tab:+\ ,eol:-
        autocmd FileType java setlocal formatprg=par\ -w80\ -T4
        autocmd FileType python setlocal commentstring=#\ %s
        autocmd BufEnter Makefile setlocal noexpandtab
        autocmd BufEnter *.sh setlocal tabstop=2
        autocmd BufEnter *.sh setlocal shiftwidth=2
        autocmd BufEnter *.sh setlocal softtabstop=2
    augroup END
" }}}

" Custom functions {{{

" Strips trailing whitespace at the end of files.
" This is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" }}}

" vim:foldmethod=marker:foldlevel=0
