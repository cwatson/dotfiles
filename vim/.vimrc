" .vimrc
" Maintained by Christopher G. Watson <cwa135@alum.mit.edu>
"

" General settings {{{
set nocompatible

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set guifont="Courier 10 Pitch"
  set guioptions-=T
endif

colorscheme torte
set background=dark
set number                      " Always show line numbers
set relativenumber              " Show line numbers relative to cursor line
set ruler		                " Show the cursor position all the time
set showcmd		                " Display incomplete commands
set showmatch
"}}}

" Editing behavior {{{
set updatetime=250
set tabstop=4                   " A tab is 4 spaces
set shiftwidth=4                " Number of spaces for auto-indent
set smarttab                    " Insert tabs at start of line based on sw, not ts
set expandtab                   " Expand tabs by default
set softtabstop=4               " When hitting <BS>, pretend like a tab is removed
set autoindent                  " Always set autoindenting on
set backspace=indent,eol,start  " Allow backspacing over everything in insert mode
set history=50		            " Keep 50 lines of command line history
set hlsearch                    " Highlight search terms
set incsearch		            " Do incremental searching
set smartcase                   " Ignore case if search pattern is all lower
"}}}
" Fold settings {{{
set foldenable
set foldcolumn=2
au FileType sh let g:sh_fold_enabled=4
au FileType sh set foldmethod=syntax
au FileType vim set foldmethod=marker
"}}}

" Key mappings {{{
" Don't use Ex mode, use Q for formatting
map Q gq
let g:BASH_Ctrl_j = 'off'
let g:R_Ctrl_j = 'off'
inoremap jk <ESC>
inoremap <ESC> <nop>
nnoremap <C-c> :bp\|bd #<CR>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>
nnoremap <Leader><space> :nohlsearch<CR>
" Press <tab> to match pairs
nnoremap <tab> %
vnoremap <tab> %
" Mappings for vertical splits
nnoremap <Leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"}}}

" Vundle stuff {{{
"-------------------------------------------------------------------------------
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins {{{
"===============================================================================
" Git-related {{{
"---------------------------------------
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'junegunn/gv.vim'
"}}}

" Change/improve visuals {{{
"---------------------------------------
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'luochen1990/rainbow'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'rickhowe/diffchar.vim'
Plugin 'chrisbra/csv.vim'
Plugin 'chrisbra/Colorizer'
"Plugin 'chrisbra/changesPlugin'
"}}}

" Programming improvements {{{
"---------------------------------------
Plugin 'jcf/vim-latex'
Plugin 'xuhdev/vim-latex-live-preview'
"Plugin 'jalvesaq/Nvim-R'
Plugin 'vim-scripts/Vim-R-plugin'
Plugin 'w0rp/ale'                           "Asynchronous Lint Engine
" Snippets, utilties, movement
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'geoffharcourt/vim-matchit'
Plugin 'wellle/tmux-complete.vim'
"}}}

" Markdown {{{
"---------------------------------------
Plugin 'godlygeek/tabular'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'plasticboy/vim-markdown'
"}}}

" Note-taking {{{
"---------------------------------------
Plugin 'chikamichi/mediawiki.vim'
Plugin 'xolox/vim-notes'
Plugin 'xolox/vim-misc'
" Plugins to make vim-orgmode work properly
Plugin 'jceb/vim-orgmode'
Plugin 'tpope/vim-speeddating'
Plugin 'jkramer/vim-checkbox'
Plugin 'itchyny/calendar.vim'
Plugin 'chrisbra/NrrwRgn'
Plugin 'vim-scripts/SyntaxRange'
Plugin 'tpope/vim-repeat'
Plugin 'dhruvasagar/vim-table-mode'
"}}}
"}}}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"-------------------------------------------------------------------------------
"}}}
" Plugin settings {{{
"===============================================================================
set statusline+=%{fugitive#statusline()}
let g:csv_comment = '#'

" Nvim-R settings {{{
"---------------------------------------
"let g:R_setwidth = 0
"let g:R_start_libs = 'base,graphics,grDevices,methods,parallel,stats,utils,brainGraph,cairoDevice,data.table,foreach,ggplot2,gridExtra,Hmisc,igraph,MASS,Matrix,mediation,oro.nifti,permute,RcppEigen,RGtk2'
"let g:R_in_buffer = 1
"let g:R_tmux_split = 1
"let g:R_rconsole_width = 0
"let g:R_rconsole_height = 36
let g:vimrplugin_start_libs = 'base,stats,graphics,grDevices,utils,methods,igraph,brainGraph,ggplot2'
let g:ScreenImpl = 'Tmux'
let g:vimrplugin_vsplit = 'shell'
let g:ScreenShellInitialFocus = 'shell'
" instruct to use your own .screenrc file
"let g:R_noscreenrc = 1
" For integration of r-plugin with screen.vim
"let g:R_screenplugin = 1

" see R documentation in a Vim buffer
let vimrplugin_vimpager = 'vertical'
"let g:R_nvimpager = 'tab'

let g:vimrplugin_underscore = 0
let g:vimrplugin_assign = 0
let g:vimrplugin_rnowebchunk = 0
let g:vimrplugin_insert_mode_cmds = 0

let vimrplugin_synctex = 0
let g:vimrplugin_openpdf = 1
let g:vimrplugin_latexcmd = 'pdflatex'
let g:rplugin_pdfviewer = 'xpdf'

let g:rplugin_vimcomport = 1
"let g:R_underscore = 0
"let g:R_assign = 0
"let g:R_rnowebchunk = 0
"let g:R_insert_mode_cmds = 0
"let g:rrst_syn_hl_chunk = 1
"
"let R_synctex = 0
"let g:R_openpdf = 1
"let g:R_latexcmd = ['pdflatex', '-shell-escape']
"let g:R_pdfviewer = ''
"let g:R_texerror = 1
"
"let g:R_objbr_opendf = 1
"let g:R_objbr_allnames = 0
"let g:R_objbr_place = 'script,right'
"
"let g:rplugin_vimcomport = 1
"}}}

" ale/lintr defaults {{{
"---------------------------------------
let g:ale_r_lintr_options = "lintr::with_defaults(object_name_linter=NULL, infix_spaces_linter=NULL, single_quotes_linter=NULL, line_length_linter(100), object_usage_linter=NULL)"
nnoremap <silent> <C-k> :ALEPreviousWrap<CR>
nnoremap <silent> <C-j> :ALENextWrap<CR>
"}}}

" vim-latex {{{
"---------------------------------------
let g:tex_flavor = 'latex'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_ViewRule_pdf = 'xpdf'
let g:Tex_MultipleCompileFormats='pdf'
let g:Tex_SmartKeyDot=0

let g:livepreview_previewer = ''
"}}}

" vim-orgmode {{{
"---------------------------------------
let g:org_agenda_files = ['/home/cwatson/Dropbox/packages/brainGraph.other/brainGraph.org', '/home/cwatson/Dropbox/packages/brainGraph.UserGuide/todos_userGuide.org', '/home/cwatson/Dropbox/Work/grants/grants.org', '/home/cwatson/Dropbox/TODO.org', '/home/cwatson/Dropbox/Work/BCH/bch.org']
let g:org_todo_keywords = ['TODO', 'STARTED', '|', 'DONE', 'CANCELED']
let g:org_todo_keyword_faces = [['TODO', [':foreground red', ':background black', ':weight bold']], ['STARTED', [':foreground white', ':background blue', ':weight bold']], ['DONE', [':foreground green', ':background black', ':weight bold']], ['CANCELED', [':foreground green', ':background black', ':weight bold']]]
let g:org_indent = 1
"}}}

" utl; open links {{{
let g:utl_cfg_hdl_scm_http_system = "!xdg-open '%u'"
let g:utl_cfg_hdl_scm_mailto = "!firefox '%u'"
"https://mail.google.com/mail/?extsrc=mailto&url='%s
"}}}

" vim-indent-guides stuff {{{
"---------------------------------------
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=lightgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=white
"}}}

" rainbow parentheses {{{
"---------------------------------------
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
\   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'r': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/\[\[/ end=/\]\]/'],
\       },
\       'mediawiki': {
\           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/\[\[/ end=/\]\]/'],
\       }
\   }
\}
"}}}

" vim-airline {{{
"---------------------------------------
set laststatus=2
let g:airline_theme = 'ayu_mirage' " 'hybrid' 'cool' 'light' 'molokai' 'base16_brewer'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#csv#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#branch#enabled = 1
"}}}
"}}}

" tagbar
nmap <F8> :TagbarToggle<CR>

" Only do this part when compiled with support for autocommands. {{{
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
"  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " Python stuff {{{
  "---------------------------------------
  autocmd BufRead *.py set nowrap
  autocmd BufRead *.py set cinwords=if,elif,else,for,while,try,except,finally,def,class
  autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
  "}}}

  " Set filetypes for certain extensions {{{
  autocmd BufNewFile,BufRead *.Rscript set ft=r
  autocmd BufNewFile,BufRead *.littler set ft=r
  autocmd BufNewFile,BufRead *.Rnw set ft=rnoweb
  autocmd BufNewFile,BufRead *.cl[os] set ft=tex
  autocmd BufNewFile,BufRead *.tikz set ft=tex
  autocmd BufNewFile,BufRead *.rsync set ft=rsync
  autocmd BufNewFile,BufRead DESCRIPTION set ft=rdesc
  autocmd BufNewFile,BufRead current_message.txt set ft=mail
  autocmd BufNewFile,BufReadPre *pentadactylrc set ft=vim
  "}}}

  " Remap <Leader> for TeX {{{
  autocmd BufNewFile,BufReadPre * let g:mapleader = '\\'
  autocmd BufNewFile,BufReadPre *.Rnw let g:mapleader = ';'
  autocmd BufNewFile,BufReadPre *.tex let g:mapleader = ';'
  "}}}

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80
  autocmd FileType sh setlocal textwidth=80
  autocmd FileType tex setlocal textwidth=80
  autocmd FileType rnoweb setlocal textwidth=80
  autocmd FileType r setlocal textwidth=80
  autocmd FileType org setlocal textwidth=0

  " Spacing should be 2 for R- and HTML-related files
  autocmd FileType r setlocal ts=2 sw=2 sts=2
  autocmd FileType rnoweb setlocal ts=2 sw=2 sts=2
  autocmd FileType html setlocal ts=2 sts=2 sw=2
  autocmd FileType scss setlocal ts=2 sts=2 sw=2

  autocmd FileType man set norelativenumber

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else
  set autoindent		" always set autoindenting on
endif " has("autocmd")
"}}}
