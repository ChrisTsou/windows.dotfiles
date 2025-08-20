# project description
- automate dotfiles and os setup for my personal machines
- Windows-focused chezmoi configuration for setting up development environments

# project structure
## Core Configuration
- `.chezmoiroot` - points to `./root` directory for files
- `root/.chezmoi.toml.tmpl` - main chezmoi config with isAdmin data detection
- `root/.chezmoiignore.tmpl` - conditionally ignores admin-only scripts

## Scripts and Automation
- `.chezmoiscripts/` - chezmoi lifecycle scripts:
  - `run_onchange_before_install-fonts.ps1.tmpl` - installs fonts from assets/
  - `run_onchange_before_install-packages.ps1.tmpl` - installs winget packages
  - `run_onchange_after_debloat.ps1.tmpl` - removes bloatware apps
  - `run_before_setup-wsl.ps1.tmpl` - WSL setup (admin only)
- `scripts/` - utility scripts:
  - `check_admin_privileges.ps1` - detects admin privileges for templating
  - `setup-bitwarden.ps1` - bitwarden setup (currently disabled)

## Assets
- `assets/FiraCodeNerdFont-Regular.ttf` - Nerd Font for terminal
- `assets/packages.txt` - winget package list (dev tools, browsers, utilities)
- `assets/debloat-apps-list.txt` - comprehensive Windows bloatware removal list

## Managed Files
- PowerToys Keyboard Manager config
- Windows Terminal settings and icons
- All files under `root/` get deployed to user's home directory

# instructions
- The main program I use is chezmoi
- all code generated must be idempotent
- try to use chezmoi and its templating to simplify code
- Use PowerShell for Windows automation scripts
- Leverage chezmoi's `{{ .isAdmin }}` data variable for conditional execution
- Follow chezmoi script naming conventions (run_onchange_, run_before_, etc.)
- Store reusable assets in assets/ directory
- Use .tmpl extension for files that need templating

# meta instructions for claude
When working on this project, ALWAYS:
1. **Update this CLAUDE.md file** whenever you make significant changes to reflect new:
   - File structures or relocations
   - Script purposes and functionality
   - Asset additions or modifications
   - Configuration changes
   - New chezmoi features or patterns used
2. **Maintain project structure documentation** - keep the "project structure" section current
3. **Update instructions section** when adding new conventions or patterns
4. **Add new entries to future update instructions** for ongoing maintenance tasks
5. **Document any new chezmoi templating variables or conditional logic** introduced

## memory cleanup and consolidation
Periodically (or when asked to):
1. **Review and consolidate** duplicate or redundant information in this file
2. **Remove outdated entries** that no longer apply to the current project state
3. **Reorganize sections** for better clarity and logical flow
4. **Compress verbose descriptions** while maintaining essential information
5. **Verify accuracy** by cross-referencing with actual project files
6. **Update file paths and references** if they've changed
7. **Merge similar instructions** to reduce repetition

# future update instructions
When updating this project:
1. Check for new winget packages to add to assets/packages.txt
2. Review and update debloat list in assets/debloat-apps-list.txt for new Windows versions
3. Update font assets if newer Nerd Fonts are available
4. Add new managed dotfiles under root/ directory structure
5. Consider adding more conditional logic based on machine type or environment
6. Test all scripts for idempotency - they should be safe to run multiple times
7. Maintain PowerShell script error handling and user feedback messages
8. **Remember to update this CLAUDE.md file** with any structural or functional changes