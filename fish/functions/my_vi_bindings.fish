# Key bindings for the vi-mode plugin

function my_vi_bindings
  fish_vi_key_bindings
  bind -M insert -m default df backward-char force-repaint
end
