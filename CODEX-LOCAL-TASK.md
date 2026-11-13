# Codex task — install the SOC portfolio on my Windows PC

**Execution environment:** Codex must operate with access to this Windows computer's local filesystem, not only a remote/cloud workspace.

Target location: `D:\SOC-Analyst-Portfolio`.
Downloaded archive: `%USERPROFILE%\Downloads\SOC-Analyst-Portfolio-GitHub-Ready.zip`.
Standalone import script (if downloaded): `%USERPROFILE%\Downloads\IMPORT-SOC-PORTFOLIO-TO-D.ps1`.

## Task

1. Inspect `D:\SOC-Analyst-Portfolio` and the ZIP. Confirm that `D:` exists and the ZIP contains `SOC-Analyst-Portfolio\README.md`. If the ZIP is missing, stop and tell me what to download; do not fabricate files.
2. Merge ZIP contents into `D:\SOC-Analyst-Portfolio`. **Never delete or overwrite my work without a backup.** In particular, retain all existing local `screenshots\` and `evidence\` folders. For conflicting files, store a dated original copy in `.local-backups\` (which must be ignored by Git).
3. Prefer executing `IMPORT-SOC-PORTFOLIO-TO-D.ps1` from Downloads. If that script is missing, safely perform the same import using PowerShell.
4. Verify these Lab 01 files exist: `README.md`, `methodology.md`, `incident-report.md`, `screenshots-public\04-failed-logins-redacted.png`, `screenshots-public\05-event-details-001-redacted.png`. Verify the root README and `.gitignore` exist.
5. Ensure all six lab folders exist. Within each, ensure `screenshots\` and `evidence\` directories exist; do not invent lab investigation results or screenshots for Labs 02–06.
6. Inspect `.gitignore` and make sure original `screenshots\`, raw `evidence\`, `*.evtx`, and `.local-backups\` cannot be committed by `git add .`.
7. Review public screenshots for visible usernames, hostnames, account identifiers and other sensitive information. If uncertain, stop before any GitHub push and tell me which captures need manual redaction.
8. Use English professional Markdown for all report files. Maintain the following verified Lab 01 facts and uncertainties: six 4625 events shown by Event Viewer; three timestamps at 00:14:50, 00:14:53, 00:14:56 on 2026-11-13; one inspected event has `LogonType 2`, `127.0.0.1`, `0xC000006D`, `0xC0000380`, target username blank, and `svchost.exe`. PowerShell filtering for 4625 produced no results although the Security log was readable. Do not describe a confirmed attack, successful login, or attacker.
9. Show me the resulting file tree and `git status --short` if this is a Git repository. If Git is not initialized, you may initialize it locally, but **do not publish to a public GitHub repository or push private material without my explicit review and approval**.
10. Explain exactly what was created/updated, what remained untouched, any backups, and what step remains before GitHub publication.

No exploitation, simulated brute force, unnecessary software installs, or changes to Windows security settings are needed.
