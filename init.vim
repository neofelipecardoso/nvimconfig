" Configurações básicas
set number              " Mostrar números de linha
set autoindent          " Indentação automática
set tabstop=4           " Número de espaços que uma tabulação representa
set shiftwidth=4        " Tamanho da indentação
set smarttab            " Tab inteligente
set softtabstop=4       " Define o comportamento de tabulação
set mouse=a             " Habilita o uso do mouse
set encoding=UTF-8      " Define a codificação para UTF-8

" Configuração do vim-plug para gerenciar plugins
call plug#begin()

Plug 'tpope/vim-surround'               " Surrounding ysw)
Plug 'preservim/nerdtree'               " NerdTree
Plug 'tpope/vim-commentary'             " Para comentários gcc & gc
Plug 'vim-airline/vim-airline'          " Status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'lifepillar/pgsql.vim'             " PSQL Plugin
Plug 'ap/vim-css-color'                 " CSS Color Preview
Plug 'rafi/awesome-vim-colorschemes'    " Retro Scheme
Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Auto Completion
Plug 'ryanoasis/vim-devicons'           " Developer Icons
Plug 'tc50cal/vim-terminal'             " Vim Terminal
Plug 'preservim/tagbar'                 " Tagbar para navegação no código
Plug 'terryma/vim-multiple-cursors'     " CTRL + N para múltiplos cursores
Plug 'sheerun/vim-polyglot'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dense-analysis/ale'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'davidhalter/jedi-vim'
Plug 'fratajczak/one-monokai-vim'
Plug 'folke/tokyonight.nvim'
Plug 'mhinz/vim-signify'

if (has("nvim"))
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
endif

" Carrega a configuração do Catppuccin com fundo transparente
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

call plug#end()

" Atalhos do NERDTree
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

" Atalho para Tagbar
nmap <F8> :TagbarToggle<CR>

" Desativa a pré-visualização no autocomplete
set completeopt-=preview

lua << EOF
require("catppuccin").setup({
    transparent_background = false, -- Fundo transparente
    flavour = "latte",              -- Escolha o tema: latte, frappe, macchiato, mocha
})
vim.cmd.colorscheme "catppuccin"
EOF

" Configurações para NERDTree
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

" Configuração do vim-airline com símbolos personalizados
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:airline_theme = 'bubblegum'
highlight Visual guifg=#4d4d4d guibg=#b39e92
highlight Normal guibg=#ffe0cc

" Atalho para autocomplete com coc.nvim
inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

" Habilita cores verdadeiras no terminal
set termguicolors

" Ajusta a transparência adicional do fundo
augroup MyColors
  autocmd!
  autocmd ColorScheme * highlight Normal ctermbg=none guibg=none
  autocmd ColorScheme * highlight NonText ctermbg=none guibg=none
augroup END

" --- Notas úteis ---
" :PlugClean :PlugInstall :UpdateRemotePlugins
" :CocInstall coc-python
" :CocInstall coc-clangd
" :CocInstall coc-snippets
" :CocCommand snippets.edit... FOR EACH FILE TYPE
"
" ALE """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
      \'cpp': [],
      \'c': [],
      \'python': ['flake8', 'pyright', 'bandit'],
\}

let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\   'python': ['black', 'isort'],
\}

let g:ale_fix_on_save = 1

let g:coc_global_extensions = [ 'coc-snippets', 'coc-explorer',]

" Coc Snippets """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'


" Coc Explorer """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:nnoremap <space>e :CocCommand explorer<CR>

let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'cocConfig': {
\      'root-uri': '~/.config/coc',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'tab:$': {
\     'position': 'tab:$',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   },
\   'buffer': {
\     'sources': [{'name': 'buffer', 'expand': v:true}]
\   },
\ }

" Use preset argument to open it
nnoremap <space>ed :CocCommand explorer --preset .vim<CR>
nnoremap <space>ef :CocCommand explorer --preset floating<CR>
nnoremap <space>ec :CocCommand explorer --preset cocConfig<CR>
nnoremap <space>eb :CocCommand explorer --preset buffer<CR>

" List all presets
nnoremap <space>el :CocList explPresets

" AutoCMD
function! HighlightWordUnderCursor()
    if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]'
        exec 'match' 'Search' '/\V\<'.expand('<cword>').'\>/'
    else
        match none
    endif
endfunction

autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()

" Python """"""""""""""""""""""""""""""""""""""""""""""
let g:ale_python_flake8_options = '--max-line-length=100 --extend-ignore=E203'
let g:ale_python_black_options = '--line-length 100'
let g:ale_python_isort_options = '--profile black -l 100'
nnoremap tp :!python %<cr>

" Configurações do vim-signify
let g:signify_sign_change = '▌'
let g:signify_sign_delete = '_'
let g:signify_sign_add = '▌'
