vim.cmd([[
" Color Themes
" ============
" Notes:
" 1. Set before setting the colorscheme
" 2. Visit https://github.com/ryanoasis/nerd-fonts#font-installation
"    to see the range of options for setting icon displays
set termguicolors    " Enable true color support in terminal
set background=dark  " best for my transparent term configuration

" Color scheme
" ============
" Notes:
" 1. This must be at the very end of the file
" 2. Setting termguicolors will alter behavior
" 3. :help colorscheme for more information
try
  " colorscheme nova
  " colorscheme solarized8
"  colorscheme wombat_lua
"-- catch
"  -- echom 'error with colorscheme'
"-- endtry

" Custom colors
" =============
" Notes:
" 1. Overwrites loaded colorscheme
" 2. iTerm2 v3 controls the cursor color and how bold
"    fonts are displayed
" 3. Call :hi to see a full list of syntax objects
" 4. Use :Inspect and :TSNodeUnderCursor

" Use same color behind concealed unicode characters
hi clear Conceal

" useful: https://colorhex.net/78b830
" jsx pretty syntax highlighting
" scheme:
hi YELLOW       guifg=#D0C050
hi RED          guifg=#FF5F55
hi ORANGE       guifg=#D4AC0D
hi TURQUOISE    guifg=#78c0b0
hi PURPLE       guifg=#8048b0
hi GREEN        guifg=#78b830
hi GRAY         guifg=#808080
hi MUTED_GREEN  guifg=#609326
hi MUTED_PURPLE guifg=#BA5D7E
hi MUTED_BLUE   guifg=#83A8C1

hi! link TYPE    TYPE2
hi! link VARIANT TYPE5
" playing with TYPE, use link
" playing with IDENTIFIER, use link
hi YELLOW       guifg=#D0C050
hi TYPE1        guifg=#bc990c
hi TYPE2        guifg=#ecbf0e
hi TYPE3        guifg=#e0c455
hi TYPE4        guifg=#D2BD7F
hi TYPE5        guifg=#B9BA1E
hi MUTED_BROWN  guifg=#A07A2F
hi MUTED_YELLOW guifg=#A79414
hi IDENTIFIER1  guifg=#DBd263
hi IDENTIFIER2  guifg=#f5e77d
hi IDENTIFIER3  guifg=#dbd263
hi! link IDENTIFIER IDENTIFIER2

" playing with FUNCTION, use link
hi FUNCTION1        guifg=#A2CE68
hi FUNCTION2        guifg=#95F5CB
hi FUNCTION3        guifg=#BBC1F6
hi FUNCTION4        guifg=#4F78C2
hi FUNCTION5        guifg=#D3FA73
hi! link FUNCTION FUNCTION5

" playing with STRING, use link
hi STRING1        guifg=#72CF7B gui=italic
hi STRING2        guifg=#78b830 gui=italic
hi STRING3        guifg=#679933 gui=italic
hi STRING4        guifg=#d6d6d6 gui=italic
hi! link STRING STRING1
hi! link LIFETIME STRING2

" playing with COMMENT, use link for both COMMENT & DOCUMENTATION
hi COMMENT1        guifg=#609199 gui=italic
hi COMMENT2        guifg=#8ca375 gui=italic
hi! link COMMENT COMMENT1
hi! link DOCUMENTATION COMMENT2

hi MACRO guifg=#CF745D
hi MYLIB guifg=#4784DF

hi TRAIT  guifg=#A270A7
hi TRAIT2 guifg=#ab8ac1

" Parent highlighting groups
" ==========================
" Note: Normal gui=NONE is required to enable the active/inactive pane
" configuration in tmux (and the like)

hi! link LineNr   COMMENT
hi! link LineNrAbove GRAY
hi! link LineNrBelow GRAY

" ------------------------------------------------------------------------------
" Floating window settings
" ------------------------------------------------------------------------------
" 🔖 :set pumblend=0 ~ opaque
"    See ~/.config/nvm/bundle/nvim-lspconfig/after/ftplugin/lspinfo.lua
"    for popup setting
"
"    blend
" ------------------------------------------------------------------------------
hi! Pmenu        guifg=#ccdddd guibg=#202025
hi! FloatBorder  guifg=#70bdbd guibg=#202025

"
hi! CmpItemAbbrDefault             guifg=#70bdbd
hi! CmpItemMenuDefault             guifg=#bdbd11
hi! CmpItemAbbrMatchDefault        guifg=#11dddd gui=bold
" WIP
hi! CmpItemAbbrMatchFuzzyDefault   guifg=#000000
hi! CmpItemAbbrDeprecatedDefault   guifg=#ffffff
hi! CmpItemKindDefault             guifg=#ffff00
hi! CmpItemKind         guibg=NONE guifg=NONE
"    ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" vim-diminactive
" 🔖 Align the color scheme with tmux active/inactive window
" ------------------------------------------------------------------------------
hi! ColorColumn   ctermbg=235 guibg=#212121  " 1E1E1E is also good
" ------------------------------------------------------------------------------

" Match with Tmux inactive and lualine
" Search - improve contrast and match Airline Theme
hi Search ctermfg=214 ctermbg=238 guifg=#ffa724 guibg=#45413b
hi Visual ctermfg=51  ctermbg=238 guifg=#ACFFFF guibg=#002222

" White space and related
" [link undefined to defined]
hi! NonText           ctermfg=244  guifg=#808080 cterm=NONE gui=NONE
hi! link SpecialKey   NonText

" Messages
hi ErrorMsg           ctermfg=203  guifg=#FF5F55
hi! link Error ErrorMsg
hi WarningMsg         ctermfg=192  guifg=#CAE982
hi! link MoreMsg Question
hi DiagnosticInfo     ctermfg=72   guifg=#808080
hi DiagnosticHint     ctermfg=72   guifg=#588080
hi Todo               ctermfg=234  guifg=#1C1C1C ctermbg=227 guibg=#FFFF5F gui=NONE
hi def link DiagnosticError RED
hi DiagnosticWarn  ctermfg=5 guifg=#B79632

" Tabs
hi link  BufferCurrent       ORANGE
hi link  BufferCurrentMod    TURQUOISE
hi link  BufferVisible       PURPLE
hi link  BufferInactive      GRAY
hi link  BufferTabpages      MUTED_PURPLE
hi link  BufferDefaultInactiveMod MUTED_BROWN

" Window and folds
hi VertSplit    ctermfg=51   guifg=#00FFFF " turquoise
hi StatusLine   ctermfg=51   guifg=#00FFFF " turquoise
hi StatusLineNC ctermfg=51   guifg=#00FFFF " turquoise
hi Folded       ctermfg=250  ctermbg=235 guifg=#A8A8A8 guibg=#262626
hi FoldedColumn ctermfg=250  ctermbg=235 guifg=#A8A8A8 guibg=#262626
hi! link SignColumn LineNr

" JSX
hi link  jsxElement        YELLOW
hi link  jsxAttribute      PURPLE
hi link  jsxComponentName  ORANGE
hi link  jsxTag            TURQUOISE
hi link  jsxTagName        TURQUOISE
hi link  jsxCloseString    YELLOW
hi link  jsxCloseTag       YELLOW
hi link  jsxComment        Comment
hi link  jsxDot            Identifier
hi link  jsxEqual          Type
hi link  jsxEscapeJs       jsxEscapeJs
hi link  jsxNameSpace      RED
hi link  jsxString         String
hi link  jsxPunct          YELLOW

hi link  TSCjsxBraces      GREEN
hi link  jsFuncName        GREEN
hi link  jsFunction        MUTED_YELLOW
hi link  jsBraces          MUTED_GREEN

hi link  jsxClass          ORANGE
hi link  jsxCloseClass     jsxClass
hi link  xmlTagName        jsxClass
hi link  xmlEndTag         jsxClass
hi link  jsClassDefinition jsxClass
hi link  jsObjectKey       Identifier
hi link  xmlAttrib         PURPLE

" treesitter jsx
hi! link @constructor.javascript jsxClass
hi! link @tag.attribute.javascript jsxAttribute
hi! link @none.javascript STRING4

" lsp rust
hi! link @lsp.mod.attribute.rust GRAY
hi! link @lsp.mod.constant.rust ORANGE
hi! link @lsp.type.derive.rust TRAIT
hi! link @lsp.type.enumMember.rust VARIANT
hi! link @lsp.type.interface.rust TRAIT
hi! link @lsp.type.macro.rust MACRO
hi! link @lsp.type.namespace.rust GRAY
hi! link @lsp.type.typeAlias.rust TYPE2
hi! link @lsp.type.unresolvedReference.rust RED
hi! link @lsp.typemod.namespace.declaration.rust MYLIB
hi! link @lsp.typemod.method.trait.rust TRAIT2

" treesitter rust
hi! link @comment.rust COMMENT
hi! link @comment.documentation.rust DOCUMENTATION
hi! link @constant.rust ORANGE
hi! link @function.rust FUNCTION
hi! link @identifier.rust IDENTIFIER
hi! link @include.rust MUTED_BROWN
hi! link @namespace.rust MUTED_YELLOW
hi! link @punctuation.type_param.rust GRAY
hi! link @storageclass.lifetime.rust LIFETIME

" treesitter other
hi! link @comment.vim COMMENT
hi! link @comment.py COMMENT
hi! link @string.documentation.python DOCUMENTATION

]])
