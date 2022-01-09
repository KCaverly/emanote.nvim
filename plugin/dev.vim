function! ReloadAlpha()
lua << EOF
    for k in pairs(package.loaded) do 
        if k:match("^emanote") then
            package.loaded[k] = nil
        end
    end
EOF
endfunction
" Reload the plugin
nnoremap <Leader>pra :call ReloadAlpha()<CR>
" Test the plugin
nnoremap <Leader>ptt :lua require("emanote").sayHelloWorld()<CR>
