# vim-to-github

Taking you from Vim to GitHub.

```
:ToGithub
```

Will fire up the browser, opening the file and LOC of the current buffer in GitHub.

Visual mode is supported!

```
:'<,'>ToGithub
```

`ToGithub` makes up the url using [`dvcs-link`](https://gitlab.com/tonchis/dvcs-link)

You can also set a global option to copy the url in the clipboard instead of opening the browser

```
let g:to_github_clip_command = 'pbcopy'
let g:to_github_clipboard = 1
```

## Installation

Requires [`dvcs-link`](https://gitlab.com/tonchis/dvcs-link) to be installed.

[Pathogen](https://github.com/tpope/vim-pathogen) will do

```bash
$ cd ~/.vim/bundle
$ git clone https://github.com/tonchis/vim-to-github.git
```

Or just good old copy and paste.

## Caveats

`:ToGithub` will give you a link to a specific commit. If you work and commit but don't push to GitHub, you will see a 404.

## Thanks

* To [@kandalf](https://github.com/kandalf/) for the initiative!
* To [@mattn](https://github.com/mattn/) for the [Gist](https://github.com/mattn/gist-vim) plugin! I took inspiration (and code) from him.
