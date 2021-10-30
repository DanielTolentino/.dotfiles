if !exists('g:loaded_lspsaga') | finish | endif

lua << EOF
local saga = require 'lspsaga'

saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
}

EOF
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
noremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
"nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

nnoremap <silent> <C-j> :Lspsaga diagnostic_jump_next<CR>
"nnoremap <silent>K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent> gp :Lspsaga preview_definition<CR>

"nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>

"nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

