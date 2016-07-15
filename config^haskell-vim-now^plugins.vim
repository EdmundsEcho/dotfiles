"call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'                  " Dot . to repeat command
Plug 'christoomey/vim-tmux-navigator'    " Unifies vim with tmux; windows
Plug 'ctrlpvim/ctrlp.vim'                " Fuzzy file finder C-p
Plug 'tpope/vim-commentary'              " Comment in/out with gc
Plug 'thoughtbot/vim-rspec'              " Send commands from vim
Plug 'tpope/vim-dispatch'                " Manages compiler
Plug 'christoomey/vim-tmux-runner'       " Unifies vim with tmux; command
Plug 'xolox/vim-session'                 " Automates saving sessoins <leader>ss
Plug 'xolox/vim-misc'                    " Generic support plugin for xolox
Plug 'kana/vim-submode'                  " Enables repeated use of key after leader

" Add plugins to &runtimepath
call plug#end()
