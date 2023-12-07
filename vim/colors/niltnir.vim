highlight clear 
if exists("syntax_on") 
 syntax reset 
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark
let g:colors_name='niltnir'

highlight Normal ctermfg=7
highlight Title ctermfg=86
highlight Comment ctermfg=8

" magenta
highlight Constant ctermfg=5
highlight String ctermfg=5
highlight link Character String

" palegreen
highlight Number ctermfg=10
highlight link Boolean Number
highlight link Float Number

" turquoise
highlight Identifier ctermfg=80
" aquamarine
highlight Function ctermfg=86

highlight link Statement Normal
" main cyan highlight color
highlight link Conditional 6
highlight link Repeat Conditional
highlight link Label Conditional
highlight link Operator Normal
highlight link Keyword Conditional
" highlight Exception

" highlight PreProc
highlight Include ctermfg=6
highlight link Define Include
highlight link Macro Define
" highlight PreCondit

highlight link Type Normal
" highlight StorageClass
" highlight Structure
" highlight Typedef

highlight Special ctermfg=11
highlight link SpecialChar Special
highlight link Tag Special
highlight link Delimiter Normal
highlight link SpecialComment Special
" highlight Debug

" highlight Underlined

highlight link Ignore Comment

highlight Error ctermfg=5 ctermbg=0

" highlight Todo

" completion and spelling
highlight FgCocHintFloatBgCocFloating ctermfg=6 ctermbg=0
highlight Pmenu ctermfg=6 ctermbg=0
highlight SpellBad ctermfg=5 ctermbg=NONE
highlight SpellLocal ctermbg=NONE
highlight SpellCap ctermbg=NONE

" tabs
highlight TablineFill ctermfg = 0
highlight Tabline ctermbg=0 cterm=bold
highlight Tabline ctermfg = 6
highlight TablineSel ctermbg = 6
highlight TablineSel ctermfg = 0

" nerdtree
highlight Directory ctermfg=6
highlight NERDTreeCWD ctermfg=5
highlight link NERDTreeExecFile ModeMsg
"highlight NERDTreeToggleOn ctermfg=1
"highlight NERDTreeToggleOff ctermfg=4
"highlight NERDTreeRO ctermfg=4
"highlight NERDTreeCurrentNode ctermfg=4

" splits
highlight VertSplit ctermbg=0 ctermfg=0

" linum
highlight LineNr ctermfg=8
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
hi CursorLineNR cterm=bold ctermfg=6
set cursorline

" vimwiki
highlight VimwikiHeader1 ctermfg=80 cterm=bold,italic,underline
highlight VimwikiHeader2 ctermfg=80 cterm=bold,italic
highlight link VimwikiHeader3 VimwikiHeader2
highlight link VimwikiHeader4 VimwikiHeader2
highlight link VimwikiHeader5 VimwikiHeader2
highlight link VimwikiHeaderChar Comment
