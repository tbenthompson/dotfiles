" SETUP DIRECTIONS:
" General + Python
" * copy .vim and .vimrc to the right locations
" * preferably use vim installed from conda-forge
" * mamba install -c conda-forge vim jedi msgpack-python neovim flake8 ripgrep the_silver_searcher
"
" For Rust
" * curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.local/bin/rust-analyzer
" * chmod +x ~/.local/bin/rust-analyzer
"
" For C++?
" * TODO

set nocompatible              " be iMproved, required
"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Enable syntax highlighting
syntax on
filetype plugin indent on

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
set ofu=syntaxcomplete#Complete

"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" Vim wih default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmode=longest,list,full
set wildmenu

" Show partial commands in the last line of the screen
set showcmd
set noshowmode

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set nohlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline

set autoread                    "Reload files changed outside vim


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set softtabstop=4 
set shiftwidth=4 
set expandtab
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=1

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

set cmdheight=1

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

set history=1000 "Store lots of :cmdline history

"------------------------------------------------------------
" Set up vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'dense-analysis/ale'
Plug 'Shougo/neosnippet.vim'
Plug 'honza/vim-snippets'

" why both deoplete-jedi and jedi-vim? 
" deoplete-jedi for autocomplete, jedi-vim for go-to-definition/etc
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'davidhalter/jedi-vim'

Plug 'sheerun/vim-polyglot'
Plug 'vim-scripts/a.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/imaps.vim'
Plug 'vim-scripts/bufkill.vim'
Plug 'vim-scripts/gitignore'
Plug 'NLKNguyen/papercolor-theme'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'godlygeek/tabular', {'for': ['markdown']}
Plug 'plasticboy/vim-markdown', {'for': ['markdown']}
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'jpalardy/vim-slime'
Plug 'unblevable/quick-scope'
Plug 'machakann/vim-highlightedyank'
Plug 'mhinz/vim-startify'
Plug 'airblade/vim-rooter'
Plug 'justinmk/vim-sneak'
call plug#end()
"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Simplify pane changes so that C-W is not required as much.
let g:BASH_Ctrl_j = 'off'
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" CTRL-V and SHIFT-Insert are Paste
map <C-V> "+gP
map <S-Insert> "+gP

cmap <C-V> <C-R>+
cmap <S-Insert> <C-R>+
imap <S-Insert> <C-V>
vmap <S-Insert> <C-V>

nnoremap <F3> :set invnumber<CR>

"use zq for ctrl-v since we've remapped ctrl-v to be paste
nnoremap zq <c-v>

set clipboard=unnamedplus

nnoremap j gj
nnoremap k gk

" Zoom
function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
        \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<cr>

"------------------------------------------------------------
"- git stuff
nnoremap <leader>gb :Gbrowse<CR>

"------------------------------------------------------------
"- quick-scope -- must be before colorscheme call
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

"------------------------------------------------------------
"- colorscheme
"
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
colorscheme PaperColor

"------------------------------------------------------------
"- https://stackoverflow.com/questions/290465/how-to-paste-over-without-overwriting-register
"
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

" NB: this supports "rp that replaces the selection by the contents of @r
vnoremap <silent> <expr> p <sid>Repl()

"------------------------------------------------------------
"- http://vimcasts.org/episodes/tidying-whitespace/
"
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

autocmd BufWritePre *.py :call <SID>StripTrailingWhitespaces()


"------------------------------------------------------------
"- NERDTree
"
map <F1> :call NERDTreeToggleAndFind()<cr>
map <F2> :NERDTreeToggle<CR>

function! NERDTreeToggleAndFind()
  if (exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1)
    execute ':NERDTreeClose'
  else
    execute ':NERDTreeFind'
  endif
endfunction

"------------------------------------------------------------
"- deoplete + deoplete-jedi + neosnippets + ALE
"
" better completion menu behavior. 
" https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set completeopt-=preview
set completeopt+=longest,menuone,noselect

let g:deoplete#enable_at_startup = 1
imap <C-s>     <Plug>(neosnippet_expand_or_jump)
smap <C-s>     <Plug>(neosnippet_expand_or_jump)
xmap <C-s>     <Plug>(neosnippet_expand_target)
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/plugged/vim-snippets/snippets'


"------------------------------------------------------------
"- ALE 

let g:ale_completion_autoimport = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black'],
\   'rust': ['rustfmt']
\}
let g:ale_linters = {
\   'python': ['flake8'],
\   'rust': ['rls']
\}
nnoremap <F5> :ALEToggle<CR>

function! ConfigALE()
  if &ft!="python"
    nnoremap <leader>ee :ALEGoToDefinition<CR>
    nnoremap <leader>et :ALEGoToTypeDefinition<CR>
    nnoremap <leader>ew :ALEFindReferences<CR>
    nnoremap <leader>er :ALERename<CR>
  endif
endfunction
au FileType * :call ConfigALE()
nnoremap <F4> :ALEFix<CR>
nnoremap ]a :ALENextWrap<CR>
nnoremap [a :ALEPreviousWrap<CR>
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>

"------------------------------------------------------------
"- jedi-vim
function! ConfigJedi() 
  let g:jedi#popup_on_dot = 0
  let g:jedi#goto_command = "<leader>ee"
  let g:jedi#goto_assignments_command = "<leader>ea"
  let g:jedi#goto_stubs_command = "<leader>es"
  let g:jedi#documentation_command = "<leader>ed"
  let g:jedi#usages_command = "<leader>ew"
  let g:jedi#rename_command = "<leader>er"
  let g:jedi#goto_definitions_command = ""
  let g:jedi#completions_command = "<C-Space>"
endfunction
au FileType python :call ConfigJedi()

"------------------------------------------------------------
"- vim-slime (this needs a little work)
"
" let g:slime_target = "vimterminal"
" let g:slime_no_mappings = 1
" xmap <leader>c <Plug>SlimeRegionSend
" nmap <leader>c <Plug>SlimeParagraphSend
" nmap <leader>v <Plug>SlimeConfig
" let g:slime_cell_delimiter = "#%%"
" nmap <leader>x <Plug>SlimeSendCell

"------------------------------------------------------------
"- fzf.vim for searching files and contents
"
nnoremap <C-P> :GFiles<CR>
nnoremap <leader>p :Files<CR>
nnoremap <leader>f :Rg<CR>
nnoremap <leader>g :Ag<CR>
nnoremap <F6> :Buffers<CR>
tnoremap <F6> <C-w>:Buffers<CR>

"------------------------------------------------------------
"- terminals!
"
tnoremap <leader>' <C-\><C-n>
tnoremap <C-J> <C-W><C-J>
tnoremap <C-K> <C-W><C-K>
tnoremap <C-L> <C-W><C-L>
tnoremap <C-H> <C-W><C-H>

function! TerminalOpen() abort
  let bufnr = term_start(&shell, {'curwin':1})
  call win_gotoid(get(win_findbuf(bufnr), 0))
endfunction
function! TerminalsList()
  return filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&buftype") == "terminal"')
endfunction
function! TerminalStep(step) abort
  let terms = TerminalsList()
  let curidx = index(terms, bufnr("%"))
  let newidx = (curidx + a:step == len(terms)) ? 0 : ((curidx + a:step < 0) ? (len(terms) - 1) : (curidx + a:step)) 
  let newterm = get(terms, newidx)
  execute 'buffer' newterm
endfunction
nnoremap <F12> :call TerminalOpen()<CR>
nnoremap <F11> :call TerminalStep(1)<CR>
nnoremap <F10> :call TerminalStep(-1)<CR>
tnoremap <F12> <C-w>:call TerminalOpen()<CR>
tnoremap <F11> <C-w>:call TerminalStep(1)<CR>
tnoremap <F10> <C-w>:call TerminalStep(-1)<CR>

"------------------------------------------------------------
"- other plugin configuration
let g:sneak#label = 1

nnoremap <leader>m :MarkdownPreview<CR>

" Use CTRL-a for switching between header files and cpp files
nnoremap <C-a> :A<cr>

" close current buffer
nnoremap <leader>d :BD<CR>

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
