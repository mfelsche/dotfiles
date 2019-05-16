set nocompatible
set exrc
set secure

let mapleader = ','
set enc=utf-8

syntax on

packadd minpac
call minpac#init()
call minpac#add('mileszs/ack.vim')
call minpac#add('altercation/vim-colors-solarized')
call minpac#add('ctrlpvim/ctrlp.vim')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('derekwyatt/vim-scala')
call minpac#add('vim-scripts/taglist.vim')
call minpac#add('scrooloose/nerdtree')
call minpac#add('Xuyuanp/nerdtree-git-plugin')
call minpac#add('jistr/vim-nerdtree-tabs')
call minpac#add('vim-syntastic/syntastic')
call minpac#add('jakwings/vim-pony')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-fugitive')
call minpac#add('neoclide/vim-node-rpc')
call minpac#add('neoclide/coc.nvim')

filetype plugin indent on

set wildmenu

set hidden " you can change buffers without saving

set history=100 " keep 100 lines of CommandLine history

set nowrap

set ignorecase
set smartcase
set autoindent
set smartindent

set backupdir=$HOME/.vim/backup

" default tab stuff
set backspace=2
set tabstop=4
set shiftwidth=4
set expandtab

syntax match Special '\t'
set selection=exclusive

set number
set ruler
set cursorline
set cursorcolumn
set showcmd
set novisualbell
set scrolloff=10
set showmatch
set colorcolumn=80,120
set noswapfile
set title

set hlsearch
set incsearch
set gdefault   " global substitution by default

set list
set listchars=tab:▸\ ,eol:¬,trail:.,nbsp:%

"copy to clipboard
set clipboard+=unnamed

" trim trailing whitespaces
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,scala,python,pony autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" use mouse
"set mouse=a

au FileType python setl expandtab sw=4 ts=4 softtabstop=4
au FileType c setl sw=2 ts=2 laststatus=2 textwidth=80 
au FileType cpp setl sw=2 ts=2 laststatus=2 textwidth=80
au FileType pony setl sw=2 ts=2 laststatus=2 textwidth=80
  au FileType markdown setl sw=2 ts=2 laststatus=2 wrap showbreak="------>\" cpoptions+=n linebreak
set langmenu=en

set helplang=en

highlight ExtraWhitespace ctermbg=red guibg=blue
:match ExtraWhitespace /\s\+$/

let NERDTreeShowHidden=1 
map <C-n> :NERDTreeTabsToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"ctags
set tags=./tags,$HOME/.tags,tags;

"taglist
let Tlist_Use_Right_Window = 1
"let Tlist_Inc_Winwidth = 0
"let Tlist_WinWidth = 45
let Tlist_GainFocus_On_ToggleOpen= 1
let Tlist_Ctags_Cmd = 'ctags'
let Tlist_Show_One_File = 1
let tlist_pony_settings='pony;a:actor;b:behavior;c:class;f:function;i:interface;p:primitive;t:trait;y:type'

map <Leader>t :TlistToggle<CR>

set term=screen-256color
set t_Co=256
set background=dark
let g:solarized_termcolor=256
"let g:solarized_visibility = "high"
"let g:solarized_contrast = "high"
colorscheme solarized

"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces

"airline
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'

"set gfn=Droid\ Sans\ Mono\ Dotted\ for\ Powerline\ Regular, 10

"tab navigation
nnoremap H gT
nnoremap L gt

"reloading changed files
set autoread
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

au BufRead,BufNewFile *.sbt set filetype=scala
" Configuration for coc.nvim

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Some server have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=3

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }



" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
