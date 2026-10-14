" Enable 256 colors:
   set t_Co=256
   set number
   set autoindent
   set encoding=utf-8
   set fileencoding=utf-8
   set textwidth=120
   set tabstop=4
   set shiftwidth=4
   set expandtab
   set softtabstop=4
   set incsearch

   set hidden

" Change how panel split works:
   set splitbelow
   set splitright

" Enable sintax highlighting:
   syntax on
" ctags (recursive search)
   set tags=./tags;,tags;$HOME

" Highlight trailing whitespace and tabs.
highlight ExtraWhitespace ctermbg=brown guibg=brown
highlight Tabs ctermbg=brown guibg=brown

function! DotfilesWhitespace(insert_mode) abort
    " Remove only highlights created by this function.
    for id in get(w:, 'dotfiles_whitespace_ids', [])
        silent! call matchdelete(id)
    endfor

    " While typing, don't highlight whitespace at the cursor.
    let pattern = a:insert_mode
                \ ? '\s\+\%#\@<!$'
                \ : '\s\+$'

    let w:dotfiles_whitespace_ids = [
                \ matchadd('ExtraWhitespace', pattern),
                \ matchadd('Tabs', '\t')
                \ ]
endfunction

augroup DotfilesWhitespace
    autocmd!
    autocmd BufWinEnter,WinEnter * call DotfilesWhitespace(mode() =~# '^i')
    autocmd InsertEnter * call DotfilesWhitespace(1)
    autocmd InsertLeave * call DotfilesWhitespace(0)
augroup END

call DotfilesWhitespace(mode() =~# '^i')

" highligh long lines
   if exists('+colorcolumn')
     set colorcolumn=120
     highlight ColorColumn ctermbg=234
   else
     augroup DotfilesLongLines
       autocmd!
       autocmd BufWinEnter * match ErrorMsg /\%>120v.\+/
     augroup END
   endif

" panel navigation:
   nnoremap <C-J> <C-W><C-J>
   nnoremap <C-K> <C-W><C-K>
   nnoremap <C-L> <C-W><C-L>
   nnoremap <C-H> <C-W><C-H>
