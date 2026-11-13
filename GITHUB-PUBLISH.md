# Publish this portfolio to GitHub (Windows PowerShell)

1. **Stop for owner review and explicit approval before creating a remote repository, committing publication material, or pushing.** Review the complete proposed file list and these exact public screenshots together. The local installation does not authorize publication.
2. Confirm that Git is installed: `git --version`.
3. Review `screenshots-public/` for any identifiers before publication. Raw `screenshots/`, `evidence/`, and `*.evtx` files are excluded by `.gitignore`.
4. After explicit approval, on https://github.com/new create a **public** repository named `SOC-Analyst-Portfolio`. Do not initialize it with a README (this package includes one).
5. After explicit approval, run these PowerShell commands **from your existing portfolio directory**:

```powershell
Set-Location 'D:\SOC-Analyst-Portfolio'
# Skip git init if the repository has already been initialized locally.
git init
git branch -M main
git add .
git status  # Verify staged files, especially that screenshots/ and evidence/ are absent
git commit -m 'Document Windows failed logon investigation'
git remote add origin https://github.com/YOUR_USERNAME/SOC-Analyst-Portfolio.git
git push -u origin main
```

Replace `YOUR_USERNAME` before running `git remote add origin`. Git may prompt you to sign in through the browser. If `origin` already exists, run `git remote -v` and verify its URL rather than blindly adding another one.

**Publishing is a deliberate user action:** the ZIP is GitHub-ready but is not already posted to your account. Never commit raw logs or unredacted screenshots.
