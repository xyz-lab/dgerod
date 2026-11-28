# dgerod

Personal website of Diego ER.

## Publishing

The site is served by GitHub Pages from `main`. To publish, stage the changes
and run, from `main`:

```bash
tools/publish.sh <branch>              # Claude proposes the commit message
tools/publish.sh <branch> -c "<why>"   # ... using this context too
tools/publish.sh <branch> "<message>"  # Use only this message
```

The script commits what is staged on a new branch, pushes it, fast-forwards
`main`, pushes `main` and waits for the Pages build. Unstaged changes are left
as they are. It stops before doing anything if `main` is not in sync with
`origin/main`, or if a staged page uses an image (`src="..."`) that is not in
the repository.

Without a message it runs `claude -p` (Claude Code) on the staged diff, shows
the proposed message and asks whether to use it, edit it or cancel.

After publishing, CSS changes may take up to 10 minutes to show (Pages caches
them); reload with Ctrl+Shift+R.
