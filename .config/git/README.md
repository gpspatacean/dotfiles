## Git config override mechanism
`config` file includes as a last step `custom.gitconfig` customization file.
It can be used to add or override setup - e.g. override `user.username/user.email` with work user/email instead of personal ones.

Git doesn't seem to complain if `custom.gitconfig` does not exist. If it will start complaining, `custom.gitconfig` can be added to git, and then have its changes ignored:
`git update-index --skip-worktree <file>`. This can be reverted with `git update-index --no-skip-worktree <file>`.
