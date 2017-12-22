# Learning vimscript the hard way

## Key bindings
#### Always use `nore` to modify the bindings to avoid a recursive call.

> e.g., `nmap g gh` will call g recursively.

#### Operator mappings are under-utilized
| binding | description |
|:-|:-|
|:onoremap b i( |will perform the operation inside parentheses
|:onoremap p i{ |will perform the operation inside brackets

#### Normal! - performs cmds as if it were in normal mode
* does not accept `<cr>`, must use `\r` instead
* if getting complex run within `execute "normla! gg\r"`
* Note: May also use `\<cr>` (see below)

#### `?` performs a search looking backwards (opposit of `/`)
* `?^==\+$` will find lines that have "===" throughout, _before_ the cursor.
* `g_` gets you to the last non-blank char in a line. This is sometimes better than `$` which will
  include the line break

For instance, a binding to change the heading of a markdown file.
  ```
  :onoremap ih :<c-u>execute "normal! ?^#\\+ \r:nohlsearch\rvg_"<cr>
  ```
### Commenting
  ```
  " Vimscript file setting -------------------------{{{
  augroup namegroup
  autocmd!
  autocmd etc..
  augroup END
  " }}}
  ```
### Variables
  | Instantiating |Referencing |Type |
  |:--|:--|:--|
  |let foo = 42|echo foo|user-defined
  |set textwidth=80|echo &textwidth|option
  |let &textwidth = 100 |set textwidth?|setting option as variable
  |let &l:tw = 100|set tw?|local option
  |let @a = "hello"|echo @a or "a|register (to paste "ap)
  |/<search term>|@/|ref to search term
  |yw|@"|ref to yanked word

### Comparisons
*  use `==?` or `==#` for explicit case insensitive, case sensitive comparisons.
*  if use `==`, do so only for integers (integers can also use the above)

### Functions
* Vimscript functions must be named with a capital letter _if they are
  unscoped_.
* They can be passed parameters that can be referenced as follows
  * a:0, a:1 etc..
  * a:000 is a list of the rest

### Normal! not Normal
> Use `:normal!` so that it runs your command _as is_.  Otherwise, `:normal` will
reference the user's mappings of `normal` as it interprets your command.

### Normal! and sending commands via strings
1. There are three layers of invoking command line, `execute` and `/ or ?`
   1. `execute` parses the string and interprets what remains what remains
       1. `execute` ignores string literals '<literal>'
       1. to combine these two methods we use the `.` (concat)
           > `:execute "normal! gg" . '/for .\+ in .\+:' . "\<cr>"`
           > `execute interprets and executes what is in quotes`
           > `execute just passes the <literal>`
   1. `/` and `?` are invoked once the string and string literal are parsed
       1. they accept `strings` or `regular expressions`
           1. the `<literal>` becomes a paramater _as is_
           1. The string in "" is a paramter once parsed as a string

1. String parsing by `execute` means the following
    ```
    * "edmund"     -> edmund (this will be a search term for regex)
    * "fn arg"     -> fn arg
    * "\\+"        -> \+
    * "some .\\+"  -> some .\+
    * "\<cr>"      -> <cr>
    ```
### Vimscript has Four(4) regex engines
> just put `\v` at the beginning of the regex expression to use the 'very magic' version.

### \<cword> means 'word under the cursor'
> `:nnoremap <leader>g :grep -R <cWORD> .<cr>`

### Generating a fully escaped string
>Problem: how to get a word from the buffer into execute to become the arg for
>the function therein.
>Given: We must start with `<cWORD>` for execute to interpret the function
>`expand "<cWORD>" will change the sequence of function calls; <cWORD> first
>before being sent to `execute` => get the word under the cursor to the function
>we are have in the execute string.

```
:nnoremap <leader>g :silent execute "grep! -R " . |
  \ shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>

> grep! avoids us actually navigating to the first search result
> <copen> opens the quickfix window
> <silent> ignores the messages that normally get produced
> NOTE: the <cr> statement is being interpreted by vim (not execute)
```
