

# 如何使用vim配置一个C/C++开发环境

## 补全方案选择

- clangd + coc.nvim

- 为什么使用 coc 而不是 ycm？
	- youcompleteme 可以说是最难安装的一款vim插件，每次安装的体验都可以说是折磨。如果网络条件不好，可能一天下来，代码还没有从github上拉取下来
	- ycm 半异步(可能)的机制在进行大文本文件分析时变得很卡顿, 亲身体验
	- ycm 是基于 python， 可以说是锁死了单线程, coc - type script



## 配置

### 1. 安装 vim-plug

>https://github.com/junegunn/vim-plug

### 2. 安装 coc.nvim

>https://github.com/neoclide/coc.nvim

**Require** : nodejs>=14.14
			vim >= 8.1.1719
			clangd

更新 node : https://blog.csdn.net/qq_22713201/article/details/122486841

### 3. 安装coc插件

1. clangd / coc-clangd
2. coc-json

### 4. 配置文件
- CocConfig
```json
{
"languageserver": {
		"clangd": {
			"command": "clangd",
			"rootPatterns": [
					"compile_flags.txt",
					"compile_commands.json"
			],
			"filetypes": [
					"c",
					"cc",
					"cpp",
					"c++",
					"objc",
					"objcpp"
			],
			"args": [
					// "--completion-style=bundled", // bundled 补全打包为一个建议, 相反为 detailed
					"-j=4",
					"--background-index", // 后台自动分析文件(compile_commands)
					"--clang-tidy",
					// "--pretty", // 美化输出的json
					"--cross-file-rename", // 跨文件重命名变量
					"--function-arg-placeholders=false" // 启用这项时，补全函数时，将会给参数提供占位符，键入后按 Tab 可以切换到下一占位符，乃至函数末k
			]
		},
		"golang": {
			"command": "gopls",
			"rootPatterns": [
					"go.mod"
			],
			"filetypes": [
					"go"
			]
		}
}
}
```
- vimrc

```sh
call plug#begin()

"Plug 'ycm-core/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'scrooloose/nerdtree'  "目录树
Plug 'frazrepo/vim-rainbow' "彩虹括号
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs' "括号配对
Plug 'vim-scripts/a.vim'
Plug 'octol/vim-cpp-enhanced-highlight'


" Theme
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'

" All of your Plugins must be added before the following line
call plug#end()            " required



"Credit joshdick "Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Status Tab
set laststatus=2
set statusline=%1*\%<%.50F\             "显示文件名和文件路径 (%<应该可以去掉)
set statusline+=%=%2*\%y%m%r%h%w\ %*        "显示文件类型及文件状态
set statusline+=%3*\%{&ff}\[%{&fenc}]\ %*   "显示文件编码类型
set statusline+=%4*\ row:%l/%L,col:%c\ %*   "显示光标所在行和列
set statusline+=%5*\%3p%%\%*            "显示光标前文本所占总文本的比例


let g:rainbow_active=1


set encoding=utf-8
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
syntax on
syntax enable
set shiftwidth=4
set tabstop=4
set cindent
set number
set foldmethod=syntax
set autoindent
set showcmd
set mouse=a
set hlsearch
set incsearch

set path^=/usr/include

set list
set listchars=tab:→\ ,eol:↓

filetype indent on

" Command Line View
set wildmode=list:full
"set wildmenu

set background=dark " for the dark version
" set background=light " for the light version
colorscheme onedark


" Make <TAB> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
 inoremap <silent><expr> <TAB>  coc#pum#visible() ? coc#pum#confirm():"\<TAB>"


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader> rn <Plug>(coc-rename)


" hover show detail or 'K'
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction


" Neartree
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>
noremap <C-d> :call SavedAndOpenTerm()<CR>
noremap <C-s> :call SaveAndFormat()<CR>
noremap <C-h> <Plug>(coc-fix-current)

def SavedAndOpenTerm()
        :w
        :bo term
enddef

function SaveAndFormat()
        call CocAction('format')
        :w
endfunction


" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>




" Status Line Color
hi User1 cterm=none ctermfg=27 ctermbg=0
hi User2 cterm=none ctermfg=208 ctermbg=0
hi User3 cterm=none ctermfg=169 ctermbg=0
hi User4 cterm=none ctermfg=100 ctermbg=0
hi User5 cterm=none ctermfg=green ctermbg=0

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" cpp highlight
let g:cpp_class_scope_highlight=1
let g:cpp_variable_highlight=1
let g:cpp_class_decl_highlight=1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
```


- bashrc

```sh
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# ls background color
eval "$(dircolors -p | \
        sed 's/ 4[0-9];/ 01;/; s/;4[0-9];/;01;/g; s/;4[0-9] /;01 /' | \
        dircolors /dev/stdin)"
PROMPT_COMMAND=build_prompt

build_prompt() {
  EXIT=$?               # save exit code of last command
  red='\[\e[0;31m\]'    # colors
  green='\[\e[0;32m\]'
  cyan='\[\e[1;36m\]'
  diy='\[\e[0;25m\]'
  PS1='${debian_chroot:+($debian_chroot)}'  # begin prompt

  if [ $EXIT != 0 ]; then  # add arrow color dependent on exit code
    PS1+="$red"
  else
    PS1+="$green"
  fi

  #PS1+="→$reset  $cyan\W$reset \\$ " # construct rest of prompt
  PS1+="→$reset  $cyan\W$reset $diy$ " # construct rest of prompt
}

alias gr="go run"
alias py="python"
```

