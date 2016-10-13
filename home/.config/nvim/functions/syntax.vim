augroup syntax
  autocmd! BufRead,BufNewFile .babelrc,.jshintrc,.eslintrc set filetype=json
  autocmd! BufRead,BufNewFile *.edn,*.boot set filetype=clojure
augroup END
