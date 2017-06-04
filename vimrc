"
" ~/.vimrc
"
" Alberto Pettarin
" alberto@albertopettarin.it
"
" MIT license
" 2017-01-08
"
" Vundle {{{

    set nocompatible              " be iMproved, required
    filetype off                  " required

    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    " alternatively, pass a path where Vundle should install plugins
    "call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    " The following are examples of different formats supported.
    " Keep Plugin commands between vundle#begin/end.
    " plugin on GitHub repo
    " Plugin 'tpope/vim-fugitive'
    " plugin from http://vim-scripts.org/vim/scripts.html
    " Plugin 'L9'
    " Git plugin not hosted on GitHub
    " Plugin 'git://git.wincent.com/command-t.git'
    " git repos on your local machine (i.e. when working on your own plugin)
    " Plugin 'file:///home/gmarik/path/to/plugin'
    " The sparkup vim script is in a subdirectory of this repo called vim.
    " Pass the path to set the runtimepath properly.
    " Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
    " Install L9 and avoid a Naming conflict if you've already installed a
    " different version somewhere else.
    " Plugin 'ascenator/L9', {'name': 'newL9'}

    " my plugins
    " Plugin 'Valloric/YouCompleteMe'
    " Plugin 'python-mode/python-mode'
    Plugin 'ervandew/supertab'
    Plugin 'w0rp/ale'
    Plugin 'davidhalter/jedi-vim'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'

    " All of your Plugins must be added before the following line
    call vundle#end()            " required
    filetype plugin indent on    " required
    " To ignore plugin indent changes, instead use:
    "filetype plugin on
    "
    " Brief help
    " :PluginList       - lists configured plugins
    " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
    " :PluginSearch foo - searches for foo; append `!` to refresh local cache
    " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
    "
    " see :h vundle for more details or wiki for FAQ
    " Put your non-Plugin stuff after this line

" }}}

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
    "set paste                       " Avoid issues when pasting in terminal
    "set visualbell                  " No beeping.
    set lazyredraw                  " Redraw only when we need to
    set wrap                        " Turn on line wrapping
    set ruler                       " Show cursor position
    set number                      " Show line numbers
    "set cursorline                  " Highlight current line
    set laststatus=2                " Always show a status line
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

    " prev/next remap
    noremap b :previous<return>
    noremap m :next<return>

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

    " ALE
    " select linters
    " let g:ale_linters = { 'javascript': ['eslint'], }
    " move between errors/warnings
    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)
    " keep the sign gutter open
    let g:ale_sign_column_always = 1
    " check only on save, not on edit or open
    let g:ale_lint_on_save = 1
    let g:ale_lint_on_text_changed = 0
    let g:ale_lint_on_enter = 0

    " jedi-vim
    " make jedi-vim use tabs when going to a definition
    let g:jedi#use_tabs_not_buffers = 1

    " do not start completion after a dot
    " let g:jedi#popup_on_dot = 0

    " select first line of completion menu
    " let g:jedi#popup_select_first = 0

    " misc
    "let g:jedi#goto_command = "<leader>d"
    "let g:jedi#goto_assignments_command = "<leader>g"
    "let g:jedi#goto_definitions_command = ""
    "let g:jedi#documentation_command = "K"
    "let g:jedi#usages_command = "<leader>n"
    "let g:jedi#completions_command = "<C-Space>"
    "let g:jedi#rename_command = "<leader>r"

    " do not show docstring to popup
    autocmd FileType python setlocal completeopt-=preview

    " disable completion
    " let g:jedi#completions_enabled = 0

    " vim-airline
    let g:airline_theme = 'luna'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'

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
