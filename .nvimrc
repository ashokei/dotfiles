syntax on

if empty(glob('~/.nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

set undofile                 " Save undo's after file closes
set undodir=$HOME/.nvim/undo " where to save undo histories
set undolevels=1000          " How many undos
set undoreload=10000         " number of lines to save for

set tabstop=2 shiftwidth=2 expandtab

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

call plug#begin('~/.nvim/plugged')
  Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'scrooloose/syntastic'
  Plug 'Valloric/YouCompleteMe'
  Plug 'vim-scripts/a.vim'
call plug#end()

let g:syntastic_cpp_compiler_options = '-std=c++0x'
let g:syntastic_cpp_include_dirs = [ '/mnt/shared/code/openFrameworks/libs/openFrameworks/' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/openFrameworks/3d' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/openFrameworks/communication' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/openFrameworks/gl' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/openFrameworks/math' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/openFrameworks/types' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/openFrameworks/video' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/openFrameworks/app' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/openFrameworks/events' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/openFrameworks/graphics' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/openFrameworks/sound' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/openFrameworks/utils' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/cairo/include' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/cairo/include/cairo' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/freetype/include' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/glu/include' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/poco/include' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/tess2/include' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/fmodex/include' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/glew/include' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/glfw/include' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/glut/include' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/kiss/include' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/openssl/include' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/rtAudio/include' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/videoInput/include' ]
let g:syntastic_cpp_include_dirs += [ '/mnt/shared/code/openFrameworks/libs/FreeImage/include' ]
let g:syntastic_cpp_include_dirs += [ '/usr/include/gstreamer-1.0' ]
let g:syntastic_cpp_include_dirs += [ '/usr/include/glib-2.0' ]
let g:syntastic_cpp_include_dirs += [ '/usr/lib64/glib-2.0/include' ]
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

