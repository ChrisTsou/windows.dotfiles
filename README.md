### Powershell Bootstrap

> [!WARNING]
> this command is for my personal repo replace the repo after --apply

```
iex "&{$(irm 'https://get.chezmoi.io/ps1')} -b '~/bin' -- init --apply ChrisTsou/dotfiles.windows"
```