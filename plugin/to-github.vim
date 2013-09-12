" The get_browser_command and open_browser functions belong to
" https://github.com/mattn/gist-vim
" Big thank you. Open source ftw
"
function! s:get_browser_command()
  let gist_browser_command = get(g:, 'gist_browser_command', '')
  if gist_browser_command == ''
    if has('win32') || has('win64')
      let gist_browser_command = '!start rundll32 url.dll,FileProtocolHandler %URL%'
    elseif has('mac') || has('macunix') || has('gui_macvim') || system('uname') =~? '^darwin'
      let gist_browser_command = 'open %URL%'
    elseif executable('xdg-open')
      let gist_browser_command = 'xdg-open %URL%'
    elseif executable('firefox')
      let gist_browser_command = 'firefox %URL% &'
    else
      let gist_browser_command = ''
    endif
  endif
  return gist_browser_command
endfunction

function! s:open_browser(url)
  let cmd = s:get_browser_command()
  if len(cmd) == 0
    redraw
    echohl WarningMsg
    echo "It seems that you don't have general web browser. Open URL below."
    echohl None
    echo a:url
    return
  endif
  if cmd =~ '^!'
    let cmd = substitute(cmd, '%URL%', '\=shellescape(a:url)', 'g')
    silent! exec cmd
  elseif cmd =~ '^:[A-Z]'
    let cmd = substitute(cmd, '%URL%', '\=a:url', 'g')
    exec cmd
  else
    let cmd = substitute(cmd, '%URL%', '\=shellescape(a:url)', 'g')
    call system(cmd)
  endif
endfunction

function! ToGithub(count, line1, line2, ...)
  let base_url = 'https://github.com'
  if len(a:000) == 0
    let username = substitute(system('git remote -v | grep -E "origin.*\(fetch\)" | sed -E "s/.*com[:\/](.*)\/.*/\\1/"'), "\n", '', '')
    let repo = substitute(system('git remote -v | grep -E "origin.*\(fetch\)" | sed -E "s/.*com[:\/].*\/(.*).git.*/\\1/"'), "\n", '', '')
  elseif len(a:000) == 1
    let username = a:000[0]
    let repo = substitute(system('git remote -v | grep -E "origin.*\(fetch\)" | sed -E "s/.*com[:\/].*\/(.*).git.*/\\1/"'), "\n", '', '')
  elseif len(a:000) == 2
    let username = a:000[0]
    let repo = a:000[1]
  else
    return 'Too many arguments'
  endif

  let branch = substitute(system('git symbolic-ref --short HEAD'), "\n", '', '')
  let file_path = bufname('%')
  let url = base_url . '/' . username . '/' . repo . '/blob/' . branch . '/' . file_path

  if a:count == -1
    let line = '#L' . line('.')
  else
    let line = '#L' . a:line1 . '-L' . a:line2
  endif

  return s:open_browser(url . line)
endfunction

command! -nargs=* -range ToGithub :call ToGithub(<count>, <line1>, <line2>, <f-args>)
