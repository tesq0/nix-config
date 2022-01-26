set gdefault
set ignorecase

let mapleader = " "

" ============================================================================
" Movement
" ============================================================================

noremap j h
noremap k j
noremap l k
noremap ; l

" Scroll screen with the cursor
noremap <C-k> 2<C-e>
noremap <C-l> 2<C-y>


" Left / right
noremap <C-j> h
noremap <C-;> l

" Insert mode
inoremap <C-l> <Up>
inoremap <C-k> <Down>
inoremap <C-;> <Right>
inoremap <C-j> <Left>

" Previous / next match
noremap { ,
noremap } ;

noremap <a-k> }
noremap <a-l> {



" ============================================================================
" Visual
" ============================================================================

noremap <a-v> V

" ============================================================================
" Editing
" ============================================================================

" Moving blocks of text in visual mode
vnoremap < <gv
vnoremap > >gv

" Select all text
map <leader>a ggVG

" Copy until the end of the line
noremap Y y$

" Join lines
nnoremap <leader>J J
nnoremap <a-j> J