"highlight ColorColumn ctermbg=gray
set colorcolumn=80
"set number

filetype plugin indent on
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
setlocal spell
set re=0
set shortmess=I
set foldmethod=syntax
set nofoldenable

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'neoclide/coc.nvim', { 'branch' : 'release' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdcommenter'
" Make sure prettier is globally installed: npm i -g prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'aserebryakov/vim-todo-lists'
Plug 'metakirby5/codi.vim'
call plug#end()

let g:airline_powerline_fonts = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1
" Open on right
let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize=40

" set rtp+=/usr/local/opt/fzf

colorscheme onedark
syntax on
set number
highlight Normal ctermbg=None
highlight LineNr ctermfg=DarkGrey

" NERDTree shortcuts
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>r :NERDTreeFind<CR>

" FZF shortcuts
nnoremap <leader>l :FZF<CR>

" Rg shortcuts
nnoremap <leader>f :Rg<CR>

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" NERD Commenter config
let g:NERDSpaceDelims = 1

" Support macos clipboard
set clipboard=unnamed

" Set the title of the Terminal to the currently open file
function! SetTerminalTitle()
  let titleString = expand('%:t')
  if len(titleString) > 0
    let &titlestring = expand('%:t')
    " this is the format iTerm2 expects when setting the window title
    let args = "\033];".&titlestring."\007"
    let cmd = 'silent !echo -e "'.args.'"'
    execute cmd
    redraw!
  endif
endfunction
autocmd BufEnter * call SetTerminalTitle()

" Typescript config

let g:coc_global_extensions = ['coc-tsserver']

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Adjust tabs to skip showing nerdtree (and other) buffer names, and instead
" show last open file name.
function! Tabline()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let buflist = tabpagebuflist(tab)
    let bufignore = ['nerdtree', 'tagbar', 'codi', 'help']
    for b in buflist
      let buftype = getbufvar(b, "&filetype")
      if index(bufignore, buftype)==-1 "index returns -1 if the item is not contained in the list
        let bufnr = b
        break
      elseif b==buflist[-1]
        let bufnr = b
      endif
    endfor
    let bufname = bufname(bufnr)
    let bufmodified = getbufvar(bufnr, "&mod")
    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tab .':'
    let s .= (bufname != '' ? '['. fnamemodify(bufname, ':t') . '] ' : '[No Name] ')
    if bufmodified
      let s .= '[+] '
    endif
  endfor
  let s .= '%#TabLineFill#'
  return s
endfunction
set tabline=%!Tabline()
