#!/bin/bash
# Ubuntu Server Vim Enhancement Setup Script
# Run this script to install and configure Vim with Monokai, line numbers, search, and file finder

set -e  # Exit on any error

echo "🚀 Setting up enhanced Vim on Ubuntu Server..."

# Update package list
echo "📦 Updating package list..."
sudo apt update

# Install required packages
echo "📥 Installing Vim and dependencies..."
sudo apt install -y vim curl git fzf ripgrep

# Create vim directories if they don't exist
echo "📁 Creating Vim directories..."
mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/plugged

# Install vim-plug
echo "🔌 Installing vim-plug plugin manager..."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Backup existing .vimrc if it exists
if [ -f ~/.vimrc ]; then
    echo "💾 Backing up existing .vimrc to ~/.vimrc.backup"
    cp ~/.vimrc ~/.vimrc.backup
fi

# Create the enhanced .vimrc
echo "⚙️ Creating enhanced .vimrc configuration..."
cat > ~/.vimrc << 'EOF'
" Enhanced Vim Configuration for Ubuntu Server
" Optimized for terminal use

call plug#begin('~/.vim/plugged')

" Color scheme
Plug 'crusoexia/vim-monokai'

" File finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" File explorer (lightweight alternative)
Plug 'preservim/nerdtree'

call plug#end()

" =============================================================================
" COLOR SCHEME & TERMINAL SETTINGS
" =============================================================================
syntax enable
set t_Co=256                 " Enable 256 colors in terminal
colorscheme monokai

" Better colors for terminal
if &term =~ '256color'
    set termguicolors
endif

" =============================================================================
" LINE NUMBERS
" =============================================================================
set number                    " Show line numbers
set relativenumber           " Show relative line numbers
set numberwidth=4            " Width of line number column

" =============================================================================
" SEARCH ENHANCEMENTS
" =============================================================================
set hlsearch                 " Highlight search results
set incsearch                " Incremental search
set ignorecase               " Case insensitive search
set smartcase                " Case sensitive if uppercase used
set wrapscan                 " Search wraps around

" Clear search highlighting with Esc
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>

" =============================================================================
" FILE FINDER (FZF) CONFIGURATION
" =============================================================================
" Key mappings for FZF
nnoremap <C-p> :Files<CR>           " Ctrl+P to find files
nnoremap <C-f> :Rg<CR>              " Ctrl+F to search in files
nnoremap <C-b> :Buffers<CR>         " Ctrl+B for buffers
nnoremap <Leader>h :History<CR>     " Leader+H for history

" FZF settings optimized for terminal
let g:fzf_layout = { 'down': '40%' }
let g:fzf_preview_window = []  " Disable preview for better terminal performance

" =============================================================================
" TERMINAL-OPTIMIZED SETTINGS
" =============================================================================
set encoding=utf-8
set backspace=indent,eol,start
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set showmatch
set ruler
set laststatus=2
set wildmenu
set wildmode=list:longest
set scrolloff=3              " Keep 3 lines visible when scrolling
set sidescrolloff=5          " Keep 5 columns visible when scrolling
set mouse=a                  " Enable mouse support (useful in terminal)

" =============================================================================
" STATUS LINE
" =============================================================================
" Simple custom status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

" =============================================================================
" NERDTREE CONFIGURATION
" =============================================================================
" Toggle NERDTree with F2
nnoremap <F2> :NERDTreeToggle<CR>

" Close vim if NERDTree is only window
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" =============================================================================
" USEFUL SERVER-SPECIFIC MAPPINGS
" =============================================================================
" Quick save with Ctrl+S
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

" Quick quit
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wq :wq<CR>

" Navigate between windows easily
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" =============================================================================
" PERFORMANCE SETTINGS FOR SERVER
" =============================================================================
set lazyredraw              " Don't redraw during macros
set ttyfast                 " Faster terminal connection
set updatetime=250          " Faster updates
EOF

# Install Vim plugins
echo "🔌 Installing Vim plugins..."
vim +PlugInstall +qall

echo ""
echo "✅ Vim setup complete!"
echo ""
echo "🎨 Features installed:"
echo "   • Monokai color scheme"
echo "   • Line numbers (absolute + relative)"
echo "   • Enhanced search with highlighting"
echo "   • FZF file finder"
echo "   • NERDTree file explorer"
echo ""
echo "🔧 Key shortcuts:"
echo "   • Ctrl+P     - Find files"
echo "   • Ctrl+F     - Search in files (ripgrep)"
echo "   • Ctrl+B     - Switch buffers"
echo "   • F2         - Toggle file tree"
echo "   • Esc        - Clear search highlighting"
echo "   • Ctrl+S     - Save file"
echo ""
echo "🚀 Run 'vim' to start using your enhanced editor!"
EOF