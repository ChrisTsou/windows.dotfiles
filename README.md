### Powershell Bootstrap

> [!WARNING]
> this command is for my personal repo replace the repo after --apply

```
# First, bypass execution policy
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
# Download and store the script
$script = irm 'https://get.chezmoi.io/ps1'
# Execute with parameters
& ([scriptblock]::Create($script)) -b '~/bin' -- init --apply ChrisTsou/dotfiles.windows
```
