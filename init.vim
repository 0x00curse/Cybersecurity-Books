"  _   ____  __  _  _________  ___  _______  __  _________  ___  _______ 
" | | / / / / / / |/ / ___/ / / \ \/ / __/ |/ / / ___/ __ \/ _ \/ __/ _ \
" | |/ / /_/ / /    / (_ / /_/ / \  / _//    / / /__/ /_/ / // / _// , _/
" |___/\____/ /_/|_/\___/\____/  /_/___/_/|_/  \___/\____/____/___/_/|_|
" Vim customized by Vu Nguyen Coder
" (See my detailed tutorial here: https://youtu.be/Tp8i1EHsQ1Q )
"
" http://youtube.com/VuNguyenCoder
" http://facebook.com/VuNguyenCoder


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set mouse=a 				" Enable mouse
set tabstop=4 				" 
set shiftwidth=4 			" 
set listchars=tab:\¦\ 		" Tab charactor 
set list
set foldmethod=indent 		" 
set foldlevelstart=99 		"  
set number 					" Show line number
set relativenumber

set ignorecase 				" Enable case-sensitive 

" Disable backup
set nobackup
set nowb
set noswapfile

syntax on

" Enable copying from vim to clipboard
if has('win32')
	set clipboard=unnamed  
else
	set clipboard=unnamedplus
endif

" Auto reload content changed outside
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
		\ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == ''
			\ | checktime 
		\ | endif
autocmd FileChangedShellPost *
		\ echohl WarningMsg 
		\ | echo "File changed on disk. Buffer reloaded."
		\ | echohl None


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
"key leader
let mapleader = ";"

" Resize pane

noremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nmap <leader>so :source $HOME\AppData\Local\nvim\init.vim<CR>
noremap <leader>w :w<CR>
noremap <leader>fs :Files<CR>
noremap <leader>qq :q!<CR>
noremap Y y$<CR>

:imap ii <Esc>
noremap <F7> <ESC> :w !python3 <CR>" Search a hightlighted text


" Search a hightlighted text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin list
" (used for Vim-plug - https://github.com/junegunn/vim-plug)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(stdpath('config').'/plugged')
" Theme " Dark theme
	Plug 'joshdick/onedark.vim' 					
"Telescope
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
"vimux
	Plug 'preservim/vimux'

" File browser
	Plug 'preservim/nerdTree' 						" File browser  
	Plug 'Xuyuanp/nerdtree-git-plugin' 				" Git status
	Plug 'ryanoasis/vim-devicons' 					" Icon
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'unkiwii/vim-nerdtree-sync' 				" Sync current file 

" File search
	Plug 'junegunn/fzf', 
		\ { 'do': { -> fzf#install() } } 			" Fuzzy finder 
	Plug 'junegunn/fzf.vim'

" Status bar
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

" Terminal
	Plug 'voldikss/vim-floaterm' 					" Float terminal

" Code intellisense
	Plug 'neoclide/coc.nvim', {'branch': 'release'} " Language server 
	Plug 'jiangmiao/auto-pairs' 					" Parenthesis auto 
	Plug 'alvan/vim-closetag'
	Plug 'mattn/emmet-vim' 
	Plug 'preservim/nerdcommenter' 					" Comment code 
	Plug 'liuchengxu/vista.vim' 					" Function tag bar 
	Plug 'alvan/vim-closetag' 						" Auto close HTML/XML tag 

" Code syntax highlight
	Plug 'yuezk/vim-js' 							" Javascript
	Plug 'MaxMEllon/vim-jsx-pretty' 				" JSX/React
	Plug 'jackguo380/vim-lsp-cxx-highlight'			" C++ syntax
	Plug 'uiiaoo/java-syntax.vim' 					" Java
  
" Debugging
	Plug 'puremourning/vimspector' 					" Vimspector

" Source code version control 
	Plug 'tpope/vim-fugitive' 						" Git

"Python Plugins =============================================
	 Plug 'ivanov/vim-ipython'
" UI related
	 Plug 'chriskempson/base16-vim'
	 Plug 'vim-airline/vim-airline'
	 Plug 'vim-airline/vim-airline-themes'
	 " Better Visual Guide
	 Plug 'Yggdroot/indentLine'
	 " syntax check
	 Plug 'w0rp/ale'
	 " Autocomplete
	 Plug 'ncm2/ncm2'
	 Plug 'roxma/nvim-yarp'
	 Plug 'ncm2/ncm2-bufword'
	 Plug 'ncm2/ncm2-path'
	 Plug 'ncm2/ncm2-jedi'
	 " Formater
	 Plug 'Chiel92/vim-autoformat'

call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""Python Plugins serttings""""""""""""""""""""""""""""""

" vim-autoformat
noremap <F3> :Autoformat<CR>

" NCM2
augroup NCM2
  autocmd!
  " enable ncm2 for all buffers
  autocmd BufEnter * call ncm2#enable_for_buffer()
  " :help Ncm2PopupOpen for more information
  set completeopt=noinsert,menuone,noselect
  " When the <Enter> key is pressed while the popup menu is visible, it only
  " hides the menu. Use this mapping to close the menu and also start a new line.
  inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
  " uncomment this block if you use vimtex for LaTex
  " autocmd Filetype tex call ncm2#register_source({
  "           \ 'name': 'vimtex',
  "           \ 'priority': 8,
  "           \ 'scope': ['tex'],
  "           \ 'mark': 'tex',
  "           \ 'word_pattern': '\w+',
  "           \ 'complete_pattern': g:vimtex#re#ncm2,
  "           \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
  "           \ })
augroup END

" Ale
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['flake8']}

" Airline
let g:airline_left_sep  = ''
let g:airline_right_sep = ''
let g:airline#extensions#ale#enabled = 1
let airline#extensions#ale#error_symbol = 'E:'
let airline#extensions#ale#warning_symbol = 'W:'

""""""""""""""""""""""""""""""""""""""""""""
" Set theme 
colorscheme onedark

" Overwrite some color highlight 
if (has("autocmd"))
	augroup colorextend
		autocmd ColorScheme 
			\ * call onedark#extend_highlight("Comment",{"fg": {"gui": "#728083"}})
		autocmd ColorScheme 
			\ * call onedark#extend_highlight("LineNr", {"fg": {"gui": "#728083"}})
	augroup END
endif

" Disable automatic comment in newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Other setting
for setting_file in split(glob(stdpath('config').'/settings/*.vim'))
	execute 'source' setting_file
endfor


	"Setting vimux 




	"Setting telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


	
