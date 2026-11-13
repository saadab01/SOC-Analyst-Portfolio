# Public screenshots

These two images are derived from local Windows Event Viewer captures. They are documentation images, not forensic originals. Original captures remain in the private `screenshots/` directory, which Git ignores.

## Local review on 2026-11-13

- `04-failed-logins-redacted.png`: six filtered 4625 entries and the General tab for the event at 00:14:56. The subject account name and computer name are covered.
- `05-event-details-001-redacted.png`: EventData for the event at 00:14:50. The subject account name is covered; no personal computer name is visible.
- No readable personal username, hostname, machine-specific SID, email address, or external IP address was observed in either public capture.
- Visible values such as SYSTEM, WORKGROUP, the standard SIDs `S-1-5-18` and `S-1-0-0`, the system logon identifier `0x3e7`, and loopback address `127.0.0.1` are retained as technical context.
- The third local capture remains private and has not been added here.

Review these exact images with the owner before any GitHub publication. This visual review does not establish forensic authenticity.
