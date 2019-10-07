if empty(glob('~/.local/share/nvim/plugged'))
  silent !curl -fLo ~/.local/share/nvim/plugged --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'flazz/vim-colorschemes'
Plug 'jiangmiao/auto-pairs'
Plug 'tyru/caw.vim'
Plug 'tpope/vim-sleuth'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'francoiscabrol/ranger.vim'
Plug 'iberianpig/tig-explorer.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'sheerun/vim-polyglot'
Plug 'thinca/vim-quickrun'
Plug 'itchyny/lightline.vim'
Plug 'djoshea/vim-autoread'
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'burnettk/vim-angular'
Plug 'liuchengxu/vista.vim'
Plug 'fatih/vim-go'
Plug 'soramugi/auto-ctags.vim'

" last
Plug 'ryanoasis/vim-devicons'

call plug#end()

" Util func
function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction

" Vim settings.
set number
set hidden
set nobackup
set nowritebackup
set cursorline
set termguicolors
set mouse=a

set expandtab
set tabstop=2
set shiftwidth=2
set splitright
set splitbelow


" clipboard "
set clipboard+=unnamedplus

" Color settings.
set background=dark
colorscheme PaperColor


let g:quickrun_config={'_': {'split': 'below'}}

" Functions
function! ToggleMouse()
    " check if mouse is enabled
    if &mouse == 'a'
        " disable mouse
        set mouse=
    else
        " enable mouse everywhere
        set mouse=a
    endif
endfunc

" eommands
command! SettingsEdit split | e ~/.config/nvim/init.vim
command! SettingsReload so ~/.config/nvim/init.vim
command! MouseOn set mouse=a
command! MouseOff set mouse=
command! MouseToggle call ToggleMouse()
command! SE SettingsEdit
command! SR SettingsReload


" Keybinds
nnoremap <Space>p :call FZFOpen(':Files')<CR>
nnoremap <Space>P :call FZFOpen(':Commands')<CR>
nnoremap <Space>f :call FZFOpen(':Files')<CR>
nnoremap <Space>g :call FZFOpen(':GFiles')<CR>
nnoremap <Space>c :call FZFOpen(':Commands')<CR>
nnoremap <Space>b :call FZFOpen(':Buffers')<CR>
nnoremap <Space>/ :call FZFOpen(':BLines')<CR>
nnoremap <S-Up> <C-w><Up>
nnoremap <S-Down> <C-w><Down>
nnoremap <S-Right> <C-w><Right>
nnoremap <S-Left> <C-w><Left>
nnoremap <C-q> :bd<CR>
nnoremap <Space>q :bd<CR>
nnoremap q :bd<CR>
nnoremap <Space>kb :NERDTreeToggle<CR>
nnoremap <esc><esc> :noh<CR>
nnoremap s :update<CR>
nnoremap <Space>se :SettingsEdit<CR>
nnoremap <Space>sr :SettingsReload<CR>
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <C-t> :tabnew<CR>
" Keybinds(interactive)
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Keybinds(coc.nvim)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi :call CocAction('doHover')<CR>

" NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden = 1

" FZF
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)


for f in split(glob('~/config/nvim/nvimrc.d/*.vim'), '\n')
    exe 'source' f
endfor
