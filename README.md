to-github-vim
=============

Taking you from Vim to GitHub.

```
:ToGithub
```

Will fire up the browser, opening the file and LOC of the current buffer in GitHub.

Visual mode is supported!

```
:'<,'>ToGithub
```

`ToGithub` makes up the url from the origin fetch url in your `$ git remote -v`.

If you need to hit another username do:

```
:ToGithub username
```

It's the same to replace the repo name:

```
:ToGithub username repo
```

Installation
------------

[Pathogen](https://github.com/tpope/vim-pathogen) will do

```bash
$ cd ~/.vim/bundle
$ git clone https://github.com/tonchis/to-github-vim.git
```

Or just good old copy and paste.

Thanks
------

* To [@kandalf](https://github.com/kandalf/) for the initiative!
* To [@mattn](https://github.com/mattn/) for the Gist plugin! I took inspiration (and code) from him.

