# SOC Analyst Portfolio

A hands-on Blue Team / SOC Analyst learning portfolio documenting real observations, technical investigations, and defensible conclusions. Evidence is distinguished from hypotheses, and limitations are reported openly.

## Lab status

| Lab | Topic | Status |
| --- | --- | --- |
| [Lab 01](Lab-01-Windows-Login-Investigation/README.md) | Windows failed logon investigation (Event ID 4625) | Documented case study; attribution inconclusive |
| Lab 02 | Network traffic analysis | Planned |
| Lab 03 | SIEM investigation | Planned |
| Lab 04 | Sysmon detection | Planned |
| Lab 05 | Phishing email analysis | Planned |
| Lab 06 | Incident response case | Planned |

## Skills demonstrated

- Windows Event Viewer: filtering Security events and examining EventData.
- Authentication event analysis: 4625, logon types, NTSTATUS/substatus, source address, process details.
- Timeline construction and conservative SOC triage.
- PowerShell troubleshooting (`Get-WinEvent`) and accurate reporting of unsuccessful data extraction.
- Incident documentation, evidence handling, and public-data sanitization.

## Evidence & privacy

Only sanitized images from `screenshots-public/` are meant for GitHub. Local raw screenshots (`screenshots/`), raw logs, and `evidence/` are excluded by `.gitignore`. Before making the repository public, review every image and file for usernames, machine names, IDs, and private data.

## Scope

This is a personally operated Windows training workstation, not a production enterprise incident. The case uses *existing Windows Security log entries*; no brute-force or attack simulation was conducted as part of the documented work.
