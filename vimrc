" .vimrc file modified by Dan Sheffner

" Lots of credit to:
" Sample .vimrc file by Martin Brochhaus
" Presented at PyCon APAC 2012
"
runtime ~/.vim/bundle/pathogen/autoload/pathogen.vim

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" gets rid of extra space
autocmd BufWritePre * %s/\s\+$//e

" map ctrl n to line numbers
:nmap <C-N><C-N> :set invnumber<CR>

nmap <kEnter> <CR>
nmap <S-kEnter> <S-CR>
"nmap <S-Enter> O<Esc>
"nmap <CR> o<Esc>

" Mouse and backspace
set mouse=a " on OSX press ALT and click
set bs=2 " make backspace behave like normal again

" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","

" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" Quicksave command
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>

" Quick quit command
noremap <Leader>e :quit<CR> " Quit current window
noremap <Leader>E :qa!<CR> " Quit all windows

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" easier moving between tabs
"map <Leader>n <esc>:tabprevious<CR>
"map <Leader>m <esc>:tabnext<CR>
nmap <C-e><left> :tabp<cr>
nmap <C-e><right> :tabn<cr>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv " better indentation
vnoremap > >gv " better indentation

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
"au InsertLeave * match ExtraWhitespace /\s\+$/

" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
set background=dark
"colorscheme codedark
"colorscheme jellybeans
colorscheme luna-term
set cursorline
let g:airline_theme = 'base16_colors'
set autoread
set laststatus =2
" Don't show seperators
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
" Enable syntax highlighting
" You need to reload this file for the change to apply
"

" Pathogen load
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on
"C++ formatting
map <C-F> :py3f ~/.clang-format.py<cr>
imap <C-F> <c-o>:py3f ~/.clang-format.py<cr>

" Compile and execute c++ code
set autowrite
nnoremap <C-F5> :!clear && g++ -std=c++14 % -Wall -g -o %.out && ./%.out && rm -rf %.out<CR>

" path to directory where library can be found
 let g:clang_library_path='/usr/lib/llvm-6.0/lib'
 " or path directly to the library file
 let g:clang_library_path='/usr/lib/llvm-6.0/lib/libclang.so.1'

set nocompatible
set nocp

" Showing line numbers and length
set number " show line numbers
set tw=79 " width of document (used by gd)
set nowrap " don't automatically wrap on load
set fo-=t " don't automatically wrap text when typing

" Highlight Extra whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Useful settings
set history=700
set undolevels=700

"" Whitespace
set tabstop=2       " numbers of spaces of tab character
set softtabstop=2   " number columns vim uses when you hit Tab in insert mode
set shiftwidth=2    " numbers of spaces to (auto)indent
set shiftround
set expandtab

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder

" ============================================================================
" Python IDE Setup
" ============================================================================

" Settings for vim-powerline
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
au Filetype python colorscheme valloric
set laststatus=2

" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
  if pumvisible()
    if a:action == 'j'
      return "\<C-N>"
    elseif a:action == 'k'
      return "\<C-P>"
    endif
  endif
  return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

set nofoldenable

" Neocomplete
set wildmenu
set wildmode=list:longest,full

set clipboard=unnamedplus

set pastetoggle=<F2>

" Tab auto complete
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

function! Formatonsave()
  let l:lines="all" "formatdiff = 1
  py3f ~/.clang-format.py
endfunction

"cscope cursor workaround
function! Csc()
  cscope find c <cword>
  copen
endfunction
command! Csc call Csc()

""python with virtualenv support
"py3 << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
  "endifproject_base_dir = os.environ['VIRTUAL_ENV']
  "activate_this = os.path.join(project_base_dir, 'Scripts/activate_this.py')
  "execfile(activate_this, dict(__file__=activate_this))
"EOF

" Search and replace word under cursor using F4
nnoremap <F3> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i
nnoremap <F4> :%s/<c-r><c-w>/<c-r><c-w>/g<c-f>$F/i

let g:NERDCustomDelimiters = { 'c': { 'left': '//','right': '//' } }
let g:NERDCustomDelimiters = { 'cpp': { 'left': '//','right': '' } }
let g:NERDDefaultAlign = 'left'

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = "/home/weirdo/.ycm_extra_conf.py"
autocmd BufNewFile,BufRead /home/weirdo/Desktop/C++_projects/linux/* let g:ycm_global_ycm_extra_conf = "/home/weirdo/Desktop/C++_projects/linux/ycm_extra_conf.py"

" Auto run clang-format while writting
autocmd BufWritePre *.h,*.hpp,*.cc,*.cpp call Formatonsave()
