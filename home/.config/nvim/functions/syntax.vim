augroup syntax
  autocmd! BufRead,BufNewFile .babelrc,.jshintrc,.eslintrc set filetype=json
  autocmd! BufRead,BufNewFile *.boot set filetype=clojure
  autocmd! BufRead,BufNewFile *.hst set syntax=sh
augroup END
