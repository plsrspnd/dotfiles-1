"
" Vim dotfile
" ~/.vimrc
" Name: nil
"
" To-Do List {{{
" -----------------------------------------------------------------------------

"##############################################################################
" LaTeX
"##############################################################################

" High Priority:
"   * Start external command in background.. needed for compiling and opening pdf files.
"   * Allow rubber to compile filenames with spaces.
"   * Get error parser (rubber-info) and autobuild.
" Low Priority:
"   * Configure inoreabbrev,snippets,surround instead of in-LaTeX macros.
"       Which ones should be via LaTeX and others via vim?
"   * Check out surround's macros for auto-completing text like 'div id=' but when you don't want to include an id, it takes it away from the tab.
"   * Later, when you deal with LaTeX plugins, try the IDE stuff like SuperTab.

"##############################################################################
" Plugins
"##############################################################################

" High Priority:
"   * Ctrl-P: get it working.
" Medium Priority:
"   * Anyway to refer to <SID> functions, e.g., Matchit, stuff that don't use <Plug> so you can nnoremap.
"   * NERDCommenter: get it to work for random filetypes (.snippets, i3config, etc.).
"   * NERDTree: see stuff.
"   * SetColors: not sure how to change the runtimepath to ~/.vim/bundle/nil/colors/*.vim. technically, i could always do a symlink.
"   * Powerline: change colors for all modes to suit colorscheme
"   * Repeat: not working with Surround.
"   * Snippets: Fix the auto-reload command to not be so computation heavy.
"   *  How to do snippets inside a snippet? Or perhaps manage more carefully if not.
"   * YankStack: not cycling all the time, never cycling when I paste, screws a shitload of my vimrc behavior.

"##############################################################################
" Misc
"##############################################################################

" High Priority:
"   * The load last file doesn't really work as intended, but it does load *some* last files.
"   * Something weird with having to press the <ENTER> prompt when opening and certain files.
" Low Priority:
"   * Option for "resize" mode of windows, like with i3.
"   * Make InsertCharFunction() an atomic operator, e.g., '.'-able.
"   * C-o and C-p (C-I) not really working as intended. Have it so that it jumps around only in the current file, not whereever.
"       * Stuff about jump lists vs normal motion.
"   * Jump to paragraphs? One that includes <br><br> for html.
"   * Clear error (one great use of this would be for folding so it doesn't output errors when none exists.
"   * Enter url function.
"   * If in same workspace as another Vim file, somehow combine the two into one Vim window, with it split.
"   * Reloading vim doesn't work for everything, namely newly omitted mappings and settings.
"   * Fix $...$ in case there are none.
"   * Have cursor position returned to exact position (i.e. column) not just line position.
"   * The "jump to next/last sentence" doesn't always work as intended.
"   * vim fold text styling. donri is coming up with a plugin for a nice one.

"##############################################################################
" Wishlist
"##############################################################################

" EasyMotion:
"   * This is inspired from the browser search commands. Have the secondary options (e.g. when it spits out the same letter) start double digraphs and trigraphs. This allows you to know exactly the sequence to press, without having to hit one key, wait for your brain to process the next, and hit again.
"   * I want to f/F's to be case-insensitive, but smartcase when I do capitalize.
"   I can do this by setting it to the EasyMotion n/N commands, whilst allowing a one key argument for the find. This also makes it easier in case I screw up so I can cycle with n/N.
"   * Remap operator mode's t/T to <Nop> without affecting f/F's operator mode. Of course, I can always map the t/T to some other obscure keys and just forget about them, but it leaves me with peace of mind to know that whatever two keys they are, they're <Nop>'d.
"   * Include the fold title as part of search.
" NERDTree:
"   * I want you as a Toggle, but I also want you to always autotree node to CWD.
"   * 'cd' doesn't work in the tree, nor does :NERDTreeCWD.
" Misc:
"   * Some plugin to track all the commands I do in normal mode and ex mode. This way, I can see how productive I can be by remapping the keys that take longest or shortest.

" }}}
" Settings {{{
" -----------------------------------------------------------------------------

" Vundle.
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'benjifisher/matchit.zip'
Bundle 'bufexplorer.zip'
Bundle 'dahu/MarkMyWords'
Bundle 'gmarik/vundle'
Bundle 'godlygeek/tabular'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'msanders/snipmate.vim'
Bundle 'nil-/nil'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'sjl/gundo.vim'
Bundle 'skammer/vim-css-color'
"Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
filetype plugin on

" System Settings.
set encoding=utf-8
set showcmd                                  " Display partial commands.
set noerrorbells visualbell t_vb=            " Disable error bells.
augroup stahp
    autocmd!
    autocmd GUIEnter * set visualbell t_vb=  " I need this one to prevent screen flashes.
augroup END
set autochdir                                " Auto-cd into the file's dir.
set hidden                                   " Change buffers without saving.
set shortmess=I                              " Disable intro message.
set mouse=a                                  " Mouse support in terminal.
set autoread                                 " Reload files outside vim.
set clipboard=unnamed                        " Set to system's clipboard register.

" Temp Directories.
set backup                                   " Enable backups.
set noswapfile                               " It's 2013, Vim.
set undofile                                 " Enable persistent undo.
set backupdir=~/.vim/tmp/backup
set undodir=~/.vim/tmp/undo

" Searching, Highlighting, Replacing Settings.
set ignorecase                               " Case-insensitive matching...
set smartcase                                "  except case-sensitive searches.
set incsearch                                " Incremental searching.
set gdefault                                 " Default: Substitute all occurrences only in line.
set wildmenu                                 " Tab-completion features in cmd-line mode.
set wildmode=list:full
set foldmethod=marker                        " Custom folding.
set foldlevelstart=1                         " Only auto-fold up to top level at startup.

" Formatting.
set backspace=indent,eol,start               " Expected backspacing.
set linebreak                                " Don't linebreak words in the middle.
set display=lastline                         " Displays partial wrapped lines.
set cursorline                               " Cursor Highlight, Color
set number                                   " Show absolute number for cursor line.
set relativenumber                           " Line numbers relative to cursor line.
set scrolloff=10                             " Minimum # of lines shown above/below cursor.
set splitbelow                               " Split windows as expected.
set splitright
set wmh=0 wmw=0                              " Only see filename when minimized.
augroup no_indent
    autocmd!
    autocmd FileType * set formatoptions=rol
augroup END

" Tab Settings.
set expandtab                                " Spaces as tabs.
set shiftwidth=4                             " 4-character tabs.
set softtabstop=4                            " Fix it to 4.

" 1 sec <Esc> delay in terminal? Vim pls.
set noesckeys
nnoremap <Esc> <Nop>

" Set floating window size, but not for console Vim.
if has("gui_running")
  set lines=49 columns=129
endif

" Auto-load vimrc on write. The third line is simply to get my formatoptions again when it reloads. Cuz I hate 'em!
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $myvimrc nested source $myvimrc
    autocmd BufWritePost $myvimrc set formatoptions-=c formatoptions-=t formatoptions-=q formatoptions+=r formatoptions+=o formatoptions+=l
augroup END

augroup misc
    autocmd!
    " Remove any trailing whitespace in the file.
    autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
augroup END

" }}}
" Functions {{{
" -----------------------------------------------------------------------------

"##############################################################################
" Better styling of folds.
"##############################################################################
function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('»' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()

"##############################################################################
" When 'dd'ing blank lines, don't yank them into the register.
"##############################################################################
function! DDWrapper()
    if getline('.') =~ '^\s*$'
        normal! "_dd
    else
        normal! dd
    endif
endfunction
nnoremap <silent> dd :call DDWrapper()<CR>:echom ""<CR>

"##############################################################################
" Restore cursor to previous position and auto-open last file.
"##############################################################################

"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%
augroup eidecticmemory
    autocmd!
    " Go to last file if invoked without arguments.
    "Here, I'm opening past .viminfo marks just so that it places them into the buffer and I can :e# right away.
    "It slows down the startup by like half a second, so if you want to make it faster, tone down how many buffers you're opening. I'm going for pure accuracy since my computer is slow as fuck anyways, so I can wait the split second.
    autocmd GUIEnter * nested if
        \ bufname("%") == "" |
        "\   exe "normal! `9" |
        "\   exe "normal! `8" |
        "\   exe "normal! `7" |
        "\   exe "normal! `6" |
        "\   exe "normal! `5" |
        "\   exe "normal! `4" |
        "\   exe "normal! `3" |
        "\   exe "normal! `2" |
        "\   exe "normal! `1" |
        \   exe "normal! `0" |
        \ endif
    " From vimrc_example.vim distributed with Vim 7.
    " " When editing a file, always jump to the last known cursor position.
    " " Don't do it when the position is invalid or when inside an event handler
    " " (happens when dropping a file on gvim).
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

"##############################################################################
" Open URL in browser.
"##############################################################################

" Not working..
function! Browser()
   let line = getline (".")
   let line = matchstr (line, "http[^   ]*")
   exec "!firefox ".line
endfunction

nnoremap <silent> <Leader>] :call Browser()<CR>

"##############################################################################
" Fold all toggle.
"##############################################################################
let g:foldtoggle = 0
function! FoldAllToggle()
  if g:foldtoggle == 0
    let g:foldtoggle = 1
    normal! zR
  else
    let g:foldtoggle = 0
    normal! zM
  endif
endfunction
noremap <silent> <S-Space> :call FoldAllToggle()<CR>
" A temporary workaround for terminal Vim, since foldlevelstart ain't working.
"noremap <silent> <S-F1> :call FoldAllToggle()<CR>
if !has('gui_running')
augroup auto_fold
    autocmd!
    autocmd VimEnter * call FoldAllToggle()
augroup END
endif

"##############################################################################
" Insert Character Function.
"##############################################################################
"Taken from a plugin. This makes it an atomic operator, e.g., you can '.' it. Also, you get a neat cursor shader and can specify how many characters in particular.
let loaded_InsertChar = 1
function! InsertChar(count)
	call inputsave()
	let l:count = a:count
	if ! l:count
		call inputrestore()
		return
	endif
	let l:inserted = ''
	let l:old_match = matcharg(1)
	let l:old_eventignore = &eventignore
	set eventignore+=insertenter,insertleave
	try
		execute 'normal! i' . repeat('_', l:count) . "\<ESC>" . repeat('h', l:count - 1)

		for l:pos in range(l:count)
			execute 'match Error /\%#' . repeat('.', l:count - l:pos) . '/'
			redraw
			let l:char = getchar(0)
			if ! l:char
				redraw
				echohl MoreMsg
				echo 'Char ' . (l:pos + 1) . '/' . l:count . ': '
				echohl None
				let l:char = getchar()
				echo
			endif
			if l:char == 27
				execute 'normal! ' . repeat('h', l:pos) . repeat('x', l:count)
				return
			endif
			undojoin
			execute 'normal! r' . nr2char(l:char)
			let l:inserted .= nr2char(l:char)
			if l:char != 13 && (l:count - l:pos) > 1
				execute 'normal! l'
			endif
		endfor
		silent! call repeat#set('i' . l:inserted . "\<ESC>", -1)
	finally
		if type(l:old_match) == type([]) && strlen(l:old_match[0]) && strlen(l:old_match[1])
			execute 'match' l:old_match[0] '/' . l:old_match[1] . '/'
		else
			match
		endif
		let &eventignore = l:old_eventignore
		call inputrestore()
	endtry
endfunction
" I use both 's' and 'S' more often than I use default 's'. The default warrants enough use to be a single keypress (as opposed to 'cl') but I liked Append and InsertChar() even more. Also, this places the 's' default right next to 'x/c' which seems more natural in that perspective.
" Have to do autocmd for now, because of weird YankStack.
augroup fuck_you_yankstack
    autocmd!
    autocmd VimEnter * nnoremap s :<C-U>call InsertChar(v:count1)<CR>
    autocmd VimEnter * nnoremap S l:<C-U>call InsertChar(v:count1)<CR>
augroup END

"Use 'z' as 's' instead.
nnoremap z s
vnoremap z s

" }}}
" Unmappings {{{
" -----------------------------------------------------------------------------
" These are keys that are useless for me, and I accidentally hit.

"Aside from , the \ commands are all up for grabs, as well as all <F1-12> keys, and the <M-> keys.
" The non-! is for general modes, and ! for inserty modes.
"I go through every single key in every single mode and all three modifiers. Starting from top-left to right then down.
noremap ` <Nop>
"Umm...you're useless.
noremap ~ <Nop>
"I don't know how to use you yet.
noremap ! <Nop>
"My elitist setup has no need for register commands.
noremap @ <Nop>
"I don't need to complicate myself with 'nearest to cursor' searches.
noremap # <Nop>
"<Tab>'s faster foo.
"I need you for now because I don't know how to not map <Tab> without recursive.
"noremap % <Nop>
"Eh, you're marginally useful but so far away that if I ever want you more to '0w', I'd remap you anyways.
noremap ^ <Nop>
"Same as #.
noremap * <Nop>
"I-I like you guys, but you're so far away! W/E/B/gE's better.
noremap ( <Nop>
noremap ) <Nop>
nnoremap ) ^
"Why not j/k?
noremap - <Nop>
noremap _ <Nop>
noremap + <Nop>
noremap = <Nop>
"I have no need for you when you just do h's job at such a slower pace. You're fired!
noremap <BS> <Nop>
"Same but with b's job? WHAT??
noremap <S-BS> <Nop>
"Uhh..no. I don't need to adapt to MS-Window's ZXCV system to take away from <C-V>.
"I use you for BufExplorer because you're such an easy key.
vnoremap <C-q> <Nop>
onoremap <C-q> <Nop>
noremap! <C-q> <Nop>
" Made custom commands for the window scrolling I want.
noremap <C-w> <Nop>
"No, I have smooth scroll.
noremap <C-y> <Nop>
"You're too obscure! But I like your trivia(l) use in visual mode hehe, paired with u's.
nnoremap U <Nop>
onoremap U <Nop>
"Wow! You're so obscure and you do..a cursor seach or a k. No thanks.
noremap! <C-P> <Nop>
noremap <C-p> <Nop>
"I don't know how to use you guys efficiently.
"Set ] to <C-]>. I use <C-]> all the time (in :help). I never use default ] for anything.
noremap [ <Nop>
noremap { <Nop>
noremap } <Nop>
noremap <C-]> <Nop>
"I..don't even know what you do. But I can't remove you because you make Vim a madman unmapped.
"noremap | <Nop>
" s (normal) is set to InsertChar(), s (visual) is set to 'S' (for surround), and s (operator) works for default surround.
" S is covered by 'cc'.
" S (normal) is set to AppendChar(), S (operator) is used for surround.
vnoremap S <Nop>
"Bound you to [s]plit horizontally with BufExplorer.
vnoremap <C-s> <Nop>
onoremap <C-s> <Nop>
"I have a sweet SmoothScroll instead.
noremap <C-f> <Nop>
"I need to know how to use g other than for gg..
"noremap gg <Nop>
"noremap g gg
"I use Powerline instead.
noremap <C-g> <Nop>
noremap gQ <Nop>
"I use H and L for tab cycling, but that only requires normal mode.
vnoremap H <Nop>
onoremap H <Nop>
vnoremap L <Nop>
onoremap L <Nop>
"I use <C-h> and <C-l> for window cycling, but that only requires normal mode.
vnoremap <C-h> <Nop>
noremap! <C-h> <Nop>
vnoremap <C-l> <Nop>
noremap! <C-l> <Nop>
"I use J and K for join and split lines, but tha tonly reqiures normal mode.
vnoremap J <Nop>
onoremap J <Nop>
vnoremap K <Nop>
onoremap K <Nop>
" My uber motion skills don't require marks.
" Mapped ' to '. since that's the 'Go to last edit' is only reason I hit that key anyways.
" My uber pasting setup doesn't require different registers.
noremap " <Nop>
" I'll never use you nor can I even find you in :help.
noremap <C-CR> <Nop>
noremap! <C-CR> <Nop>
" My uber cursor setup doesn't require centering nor folding.
" z (normal) is set to s.
vnoremap z <Nop>
onoremap z <Nop>
noremap Z <Nop>
noremap <C-z> <Nop>
noremap! <C-z> <Nop>
"You're so full of trivia Vim.
"Bound you to split vertically in BufExplorer.
vnoremap <C-x> <Nop>
onoremap <C-x> <Nop>
noremap! <C-x> <Nop>
"I no need crazy terminal hijinks.
"I use you for NERDTree because you're such an easy press.
vnoremap <C-c> <Nop>
onoremap <C-c> <Nop>
noremap! <C-c> <Nop>
"I have SmoothScroll.
noremap <C-b> <Nop>
noremap! <C-b> <Nop>
"I have SmoothScroll.
noremap <C-n> <Nop>
noremap! <C-n> <Nop>
" My uber motion skills don't require marks.
noremap m <Nop>
" My uber cursor setup doesn't require centering.
noremap M <Nop>

" All the other keyboard keys.
noremap <Del> <Nop>
noremap <Home> <Nop>
noremap <End> <Nop>
noremap <PageUp> <Nop>
noremap <PageDown> <Nop>
noremap <Left>  <Nop>
noremap <Right> <Nop>
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap! <Home> <Nop>
noremap! <End> <Nop>
noremap! <PageUp> <Nop>
noremap! <PageDown> <Nop>
noremap! <Left> <Nop>
noremap! <Right> <Nop>
noremap! <Up> <Nop>
noremap! <Down> <Nop>
noremap <S-Home> <Nop>
noremap <S-End> <Nop>
noremap <S-PageUp> <Nop>
noremap <S-PageDown> <Nop>
noremap <S-Left> <Nop>
noremap <S-Right> <Nop>
noremap <S-Up> <Nop>
noremap <S-Down>  <Nop>
noremap! <S-Home> <Nop>
noremap! <S-End> <Nop>
noremap! <S-PageUp> <Nop>
noremap! <S-PageDown> <Nop>
noremap! <S-Left> <Nop>
noremap! <S-Right> <Nop>
noremap! <S-Up> <Nop>
noremap! <S-Down> <Nop>
noremap <C-Home> <Nop>
noremap <C-End> <Nop>
noremap! <C-Home> <Nop>
noremap! <C-End> <Nop>

augroup plugin_stahp
    autocmd!
    " BufExplorer:
    autocmd VimEnter * unmap <Leader>bv
    autocmd VimEnter * unmap <Leader>bs
    " EasyMotion: It provides an option to turn them all off, but that requires changing keys through the default source code (I think?).
    " Swap two chars.
    autocmd VimEnter * nnoremap t xph
    autocmd VimEnter * vnoremap t <Nop>
    autocmd VimEnter * nnoremap T <Nop>
    autocmd VimEnter * vnoremap T <Nop>
    autocmd VimEnter * unmap <Leader><Leader>w
    autocmd VimEnter * unmap <Leader><Leader>W
    autocmd VimEnter * unmap <Leader><Leader>b
    autocmd VimEnter * unmap <Leader><Leader>B
    autocmd VimEnter * unmap <Leader><Leader>e
    autocmd VimEnter * unmap <Leader><Leader>E
    autocmd VimEnter * unmap <Leader><Leader>ge
    autocmd VimEnter * unmap <Leader><Leader>gE
    autocmd VimEnter * unmap <Leader><Leader>j
    autocmd VimEnter * unmap <Leader><Leader>k
    autocmd VimEnter * unmap <Leader><Leader>n
    autocmd VimEnter * unmap <Leader><Leader>N
    " Matchit:
    autocmd VimEnter * unmap g%
    autocmd VimEnter * unmap [%
    autocmd VimEnter * unmap ]%
    autocmd VimEnter * unmap a%
augroup END

" }}}
" Mappings {{{
" -----------------------------------------------------------------------------

"##############################################################################
" General
"##############################################################################

let mapleader = ","
noremap ; :
nnoremap x "_x

" Save.
nnoremap <silent> <C-s> :silent update<CR>:echom ""<CR>:call LaTeXBuild()<CR>
vnoremap <silent> <C-s> <Esc>:silent update<CR>:echom ""<CR>:call LaTeXBuild()<CR>
inoremap <silent> <C-s> <Esc>:silent update<CR>:echom ""<CR>:call LaTeXBuild()<CR>

" cd to current directory.
nnoremap <Leader>cdc :cd ~<CR>
nnoremap <Leader>cdd :cd ~/Desktop<CR>

" Delete without yanking.
nnoremap <Leader>c "_c
vnoremap <Leader>c "_c
nnoremap <Leader>C "_C
vnoremap <Leader>C "_C
nnoremap <Leader>d "_d
vnoremap <Leader>d "_d
nnoremap <Leader>D "_D
vnoremap <Leader>D "_D
nnoremap <Leader>x "_dl
vnoremap <Leader>x "_dl

" Toggle highlight search.
" They both have their uses. I like having not seen highlights until I want them to appear.
"nnoremap <silent> <Leader><Space> :set nohlsearch<CR>
nnoremap <silent> <Leader><Space> :set hlsearch!<CR>

" Insert new line without going to Insert mode.
noremap <S-CR> O<Esc>
noremap <CR> o<Esc>

" For cmdline-editing, use <C-f> to use the cmdline-window, :q to quit, <CR> to execute.
set cmdwinheight=1
" I forget why I needed this one.
augroup Cmd_Enter
    autocmd!
    autocmd CmdwinEnter * noremap <buffer> <CR> <CR>
augroup END
" Trying this one for now since <C-f> seems to spit out errors on occasion.
cnoremap <silent> <C-f> <C-f>

" Insert new line without Insert mode and fix cursor.
nnoremap <Leader><CR> o<Esc>k
nnoremap <Leader><S-CR> O<Esc>j

" Go to next/previous sentence. Their defaults go to WORD, but I never prefer WORD to word anyways.
noremap W )
noremap B (
noremap E )hh
noremap gE (hh
onoremap W )
onoremap B (
onoremap E )hh
onoremap gE (hh
" Go to next/previous paragraph.
" Useful mostly for essays/large paragraph writing. Very rare, hence the obscure yet natural keys.
" Possibly swap real-line moving and paragraph moving commands.
nnoremap <Leader>j }
nnoremap <Leader>k {

" Move between wrapped lines.
noremap <silent> j gj
noremap <silent> k gk
" Move between real lines.
noremap gj j
noremap gk k

" Half-page scrolling.
noremap <C-j> <C-d>
noremap <C-k> <C-u>

" Toggle folds with <space>.
" The echom is just my cheap way (probably a better way) to hide errors in case there's no fold.
nnoremap <Space> za
":echom ""<CR>

" Keep selection after indent.
vnoremap < <gv
vnoremap > >gv

" Move through command-line history.
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

" Select all text.
nnoremap <C-a> ggVG

" Split line (sister to [J]oin lines).
nnoremap K i<CR><Esc>k$

" Execute macros (q).
noremap Q @

" Edited last opened file.
nnoremap <silent> <C-e> :silent e#<CR>

" Goto function (primarily for :help) more accessibly.
noremap ] <C-]>

" Go to last edited location.
nnoremap ' '.

"##############################################################################
" Buffers, Windows, & Tabs
"##############################################################################

" Buffers:
"BufExplorer/NERDTree commands.

" Window: Splits.
"BufExplorer/NERDTree commands.
"<C-w>             Close window.
" Window: Resize.
noremap <silent> <F1> <C-w>+
noremap <silent> <F2> <C-w>-
noremap <silent> <F3> <C-w>>
noremap <silent> <F4> <C-w><
noremap <silent> <F5> <C-w>=
" Window: Arrangement.
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction
function! DoWindowSwap()
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    let markedBuf = bufnr( "%" )
    exe 'hide buf' curBuf
    exe curNum . "wincmd w"
    exe 'hide buf' markedBuf
endfunction
nnoremap <silent> <Leader>m :call MarkWindowSwap()<CR>
nnoremap <silent> <Leader><Leader>m :call DoWindowSwap()<CR>
" Window: Cycle navigation.
nnoremap <c-h> <C-w>W
nnoremap <c-l> <C-w>w

" Tabs:
noremap <silent> <C-w> :q<CR>
noremap! <silent> <C-w> :q<CR>
nnoremap <silent> H :tabp<CR>
nnoremap <silent> L :tabn<CR>

" }}}
" Plugins {{{
" -----------------------------------------------------------------------------

"##############################################################################
" Buffer Explorer
"##############################################################################

" I use these splits instead of the defined commands since occasionally BufExplorer collapses the extra split when I don't want that!
nnoremap <silent> <C-c> :silent BufExplorer<CR>
nnoremap <silent> <C-x> <C-w>s:silent BufExplorer<CR>
nnoremap <silent> <C-v> <C-w>v:silent BufExplorer<CR>
noremap <silent> <C-t> :tabe<CR>:silent BufExplorer<CR>
noremap! <silent> <C-t> :tabe<CR>:silent BufExplorer<CR>

"##############################################################################
" Colors/Powerline
"##############################################################################

colorscheme nil
syntax enable
set guioptions=
set notitle
"set guifont=uushi
set guifont=lemon
let g:Powerline_symbols="fancy"
set laststatus=2
set noshowmode
call Pl#Theme#RemoveSegment('mode_indicator')
call Pl#Theme#RemoveSegment('fileformat')
call Pl#Theme#RemoveSegment('fileencoding')
call Pl#Theme#RemoveSegment('lineinfo')

"##############################################################################
" Ctrl-P
"##############################################################################

let g:ctrlp_map = '<C-f>'
let g:ctrlp_cmd = 'CtrlP'
" I really don't see why /I/ have to do this, but whatever.
set wildignore+=*.doc,*.docx,*.epub,*.flac,*.lnk,*.mobi,*.mkv,*.pdf,*.ods,*.xlsx

"##############################################################################
" EasyMotion
"##############################################################################

" Sorted by closest keys to center of homekeys, with RHS as priority (because I'm right-handed and f/F is on the LHS which may require a LHS shift change). Then since it's pretty random anyways, I just swapped two's based on matchups on which I would prefer. Also note that you want something still good as your last choice, since it will invariably come up for a search requiring >= 2 presses. I went with H since it was kind of random between g and a anyways and it alternates hands after a possible chord press. For the more canonical route go with the default alphabet.
let g:EasyMotion_keys = 'jklfdsaguiotrewqnmvcpxzbyKLFDSAHGUIOTREWQNMVCPXZBYh'

" f/F keys are defaulted to EasyMotion for normal/visual, and for operator mode (primarily d/c/y), they're set to t/T's instead. This makes it so that I only need two keys for mega-navigations, where other such motions are useless compared to my omn f/F.
let g:EasyMotion_mapping_f = 'f'
let g:EasyMotion_mapping_F = 'F'
let g:EasyMotion_mapping_t = 't'
let g:EasyMotion_mapping_T = 'T'
augroup tilthefs
    autocmd!
    autocmd VimEnter * omap f t
    autocmd VimEnter * omap F T
augroup END

"##############################################################################
" Gundo
"##############################################################################

nnoremap <C-u> :GundoToggle<CR>

"##############################################################################
" Matchit
"##############################################################################

map <Tab> %
" The new "go back to back". This is because <Tab> is equivalent to <C-i>.
noremap <C-p> <C-i>

"##############################################################################
" MarkMyWords
"##############################################################################

nnoremap <silent> <Leader>h :silent MMWSelect helpmark<CR>

"##############################################################################
" NERDCommenter
"##############################################################################

" Technically, <BS> isn't healthy here since I merely need an empty key there, but I dunno how to do it.
vmap <silent> <Leader>cc <plug>NERDCommenterAlignBoth<BS>gv
vmap <silent> <Leader>cs <plug>NERDCommenterSexy<BS>gv
vmap <silent> <Leader>cu <plug>NERDCommenterUncomment<BS>gv
" For commenting Snippets plugin.
"let g:NERDCustomDelimiters = {
"        \ 'snippets': { 'left': '#' },
" Apparently .tex works. But why not .asdf or .snippets?
        "\ 'tex': { 'left': '#' }
"\ }
"The defaults don't work either.
    "let g:NERDCustomDelimiters = {
        "\ 'ruby': { 'left': '#', 'leftAlt': 'FOO', 'rightAlt': 'BAR' },
        "\ 'grondle': { 'left': '{{', 'right': '}}' }
    "\ }

"##############################################################################
" NERDTree
"##############################################################################

nnoremap <silent> <C-q> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1
let NERDTreeShowBookmarks=1
let NERDTreeShowHidden=1

"##############################################################################
" Set Color
"##############################################################################

augroup color_scheme
    autocmd!
    autocmd VimEnter * silent SetColors all
augroup END
nnoremap <silent> <Leader>e :call NextColor(-1)<CR>
nnoremap <silent> <Leader>r :call NextColor(1)<CR>

"##############################################################################
" Snipmate
"##############################################################################

let g:snippets_dir = '~/.vim/bundle/nil/snippets'

" To reload the snippets whenever I rewrite them.
augroup snippets
    autocmd!
    " Works only for .snippets. Will reload them all once I leave its buffer.
    " This doesn't quite work out.
    " autocmd FileType snippets BufLeave call ReloadAllSnippets()
    "
    " This one does work, but it's computationally unpleasant in that I don't need to call it for /every/ file.
    autocmd BufWritePost * call ReloadAllSnippets()
augroup END

"##############################################################################
" Surround
"##############################################################################

" Let 's' be the surround function for visual mode. This defaults to 'S', but I can always 'c' in visual mode over 's' anyways.
vmap s <Plug>VSurround
" So the '\' surround command does '\[...\]'.
let g:surround_92 = "\\[\r\\]"
" Remaps \[ as shortcut to in-line surround with '\[...\]'. It requires 'map' since I need the above hotkey for 's\'.
nmap <silent> \[ yss\

" Parity Dollar Sign.

" Bug: It spits out an error if there's no '$' in the buffer.
" '$' acts like this: map! modes            Default;
"                     Normal mode           if even # of '$', then surround inner WORD with '$';
"                                           if odd $ of '$',  then append '$';
"                     Operator/Visual mode  Surround with '$' with a single key.
function! ParityDollarSign()
    normal! mz
    "Note there's no g flag because I have it as default.
    %s/\$//n
    let i = split(v:statusmsg)[0]
    if i % 2
        normal! `za$
    else
        normal! `zviW
        normal s$
        normal! E
    endif
endfunction

augroup tex_only
    autocmd!
    autocmd FileType tex nnoremap <buffer> <silent> $ :call ParityDollarSign()<CR>
augroup END

"##############################################################################
" YankRing:
"##############################################################################
" Uncomment when I put in YankRing again.
"""nnoremap <silent> <Leader>p :YRShow<CR>
"""" Clipboard unnnamed doesn't work with YankRing since it remaps p and P to something stupid. Here I'm resetting it to work again.
"augroup yanks
"   autocmd!
    """autocmd VimEnter * unmap p
    """autocmd VimEnter * unmap P
"augroup END
"""let g:yankring_min_element_length = 2

"Both Yank plugins fuck too much mapping behavior over. Also, YankStack doesn't even get a list and it fucks things over anyways, so why no YankRing?
    ""YankStack:
    ""No default keys.
    "let g:yankstack_map_keys = 0
    ""Cycle through yanks. nmap is necessary.
    ""Use <C-n>,<C-p>.
    "nmap <leader>p <Plug>yankstack_substitute_older_paste
    "nmap <leader>P <Plug>yankstack_substitute_newer_paste
    ""List yanks.
    ""nnoremap <silent> <Leader>p :Yanks<CR>
    ""So it works with clipboard=unnamed.
    "augroup yanks
        "autocmd!
        "autocmd VimEnter * unmap p
    "augroup END
" Make shift operators consistent.
    "call yankstack#setup()
nnoremap Y y$

" Command-line/Insert paste shortcuts.
cnoremap <C-v> <C-R>*<BS>
"inoremap <C-v> <C-R>*

" }}}
" Specific Filetypes {{{
" -----------------------------------------------------------------------------

"##############################################################################
" LaTeX
"##############################################################################
" Always use LaTeX. It's 2013 Vim. Who needs TeX?
let g:tex_flavor = "latex"

" Macros.
augroup latex
    autocmd!
    autocmd FileType plaintex,tex call LaTeXAbbrev()
augroup END

function! LaTeXAbbrev()
    inoreabbrev tt <c-r>=<sid>Expr('tt', '\text')<cr>
    inoreabbrev latex <c-r>=<sid>Expr('latex', '\LaTeX')<cr>
endfunction

"This allows abbreviations starting with \.
function! s:Expr(default, repl)
  if getline('.')[col('.')-2]=='\'
    return "\<bs>".a:repl
  else
    return a:default
  endif
endfunction

" Temporary.
function! LaTeXBuild()
    if &filetype=='tex'
" pdflatex for TeX Live doesn't support aux directory, only output-dir.
        "silent !start /min pdflatex -aux-directory="/home/nil/.vim/auxiliary" "%"
" rubber doesn't accept spaces in file names. And since I don't get a minimixed window prompt for linux, don't do silent for now.
         "silent !rubber -d "%"
         !rubber -d "%"
         silent !rubber --clean "%"
    endif
endfunction

" This would work if only I could execute it somehow in the background..
function! OpenPDF()
  silent !zathura "%:r".pdf
endfunction

"##############################################################################
" Autosave
"##############################################################################
"This prevents auto-saving unsaved files or unnecessarily, and hides command-line spam.
 "This works perfectly, but since my computer fucks up right now when I try to save shit, comment out for now.
"function! FileUpdate()
    "if expand("%") == ""
    "else
        "silent update
        "call LaTeXBuild()
    "endif
"endfunction

"augroup always_update
"   autocmd!
"    autocmd CursorMoved,CursorMovedI * call FileUpdate()
"augroup END

 "Only in .tex files: Call function whenever cursor changes text in either normal or insert mode.
"augroup always_update_tex
   "autocmd!
   "autocmd FileType tex :autocmd CursorMoved,CursorMovedI * call FileUpdate()
""       How to leave this autocmd when I'm not in .tex?
"augroup END
"
"##############################################################################
" LaTeX Auto-Compile & Error Parser
"##############################################################################
" Enable auto-compile current document.
"
" Enable rubber-info to parse log for errors/warnings.
"augroup rubber
    "autocmd!
    "autocmd FileType tex set makeprg=rubber-info\ t.log
    "autocmd FileType tex set errorformat=%f:%l:\ %m
"augroup END
" Other: latexmk (more updated; not user-friendly, no log parser/bad error support, incomplete displays), rubber (outdated, incomplete displays).
"
"augroup AutorunTexbuild
    "autocmd!
    "autocmd FileType tex :if !exists('b:runtexbuild') | call system('$vim/vimfiles/bundle/texbuild-master/texbuild '.shellescape(@%)) | let b:runtexbuild=1 | endif
    "autocmd VimLeave * :call system('killall -TERM texbuild')
"augroup END
"
"augroup latex_stuff
    "autocmd!
    "autocmd FileType tex set makeprg=pdflatex\ \-file\-line\-error\ \-interaction=nonstopmode
    "autocmd FileType tex set errorformat=%f:%l:\ %m
"augroup END

" }}}
