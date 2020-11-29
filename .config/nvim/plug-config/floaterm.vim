" Floaterm
let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.6
let g:floaterm_height=0.6
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1

let g:which_key_map.t = {
      \ 'name' : '+terminal' ,
      \ ';' : [':FloatermNew --wintype=normal --height=8' , 'terminal'],
      \ 't' : [':FloatermToggle'                          , 'toggle'],
      \ 'g' : [':FloatermNew lazygit'                     , 'git'],
      \ 'v' : [':FloatermNew vifm'                        , 'vifm'],
      \ 'y' : [':FloatermNew ytop'                        , 'ytop'],
      \ }