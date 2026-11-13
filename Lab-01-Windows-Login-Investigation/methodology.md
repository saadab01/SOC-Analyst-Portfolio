# Lab 01 — Investigation Methodology

## 1. Scope and evidence rules

This investigation concerns pre-existing Windows Security events on a local Windows workstation. No attacker IP, breached account, or successful compromise is asserted without evidence. No attack was generated during the documented workflow.

## 2. Open and filter Security events

1. Open **Event Viewer** (`eventvwr.msc`).
2. Navigate to **Windows Logs > Security**.
3. Select **Filter Current Log...** and enter Event ID `4625`.
4. Observe the resulting count and timestamps. The filter showed **6 events** at the time of capture.

**Public evidence:** [`04-failed-logins-redacted.png`](screenshots-public/04-failed-logins-redacted.png).

## 3. Build the visible timeline

The Event Viewer list showed these six events (local clock display):

| Date | Time | Event ID | Observation |
| --- | --- | --- | --- |
| 2026-11-02 | 16:38:45 | 4625 | Failed logon shown in list |
| 2026-11-02 | 16:38:49 | 4625 | Failed logon shown in list |
| 2026-11-04 | 21:16:31 | 4625 | Failed logon shown in list |
| 2026-11-13 | 00:14:50 | 4625 | Failed logon; detailed fields reviewed |
| 2026-11-13 | 00:14:53 | 4625 | Failed logon shown in list |
| 2026-11-13 | 00:14:56 | 4625 | Failed logon; General tab shown |

**Observed cluster:** three entries in six seconds on November 13. This count and concentration justify triage, not an automatic verdict of brute force.

## 4. Inspect one representative event

Select the **2026-11-13 00:14:50** Event ID `4625`, then expand **Details > Friendly View > EventData**.

| Field | Observed value | Interpretation |
| --- | --- | --- |
| `LogonType` | `2` | Interactive logon |
| `Status` | `0xC000006D` | `STATUS_LOGON_FAILURE`; invalid username or authentication information |
| `SubStatus` | `0xC0000380` | `STATUS_SMARTCARD_WRONG_PIN` per Microsoft NTSTATUS reference |
| `TargetUserName` | `-` | Target account not identified in this event |
| `IpAddress` | `127.0.0.1` | Localhost, not evidence of external origin |
| `ProcessName` | `C:\Windows\System32\svchost.exe` | Windows service host path shown in event |
| `LogonProcessName` | `User32` | Logon process as recorded |
| `AuthenticationPackageName` | `Negotiate` | Windows authentication package as recorded |

**Public evidence:** [`05-event-details-001-redacted.png`](screenshots-public/05-event-details-001-redacted.png).

The substatus has a known code description, but the exact user interaction or underlying Windows component that produced it was **not** established. Do not assume Windows Hello, smart-card hardware, or an attacker based solely on this code.

## 5. Attempted PowerShell collection

First, a date-filtered query was attempted:

```powershell
Get-WinEvent -FilterHashtable @{
    LogName   = 'Security'
    Id        = 4625
    StartTime = [datetime]'2026-11-13 00:14:40'
    EndTime   = [datetime]'2026-11-13 00:15:05'
}
```

**Observed result:** `NoMatchingEventsFound`.

Then the same event ID was requested without a time filter:

```powershell
Get-WinEvent -FilterHashtable @{
    LogName = 'Security'
    Id = 4625
} -MaxEvents 20
```

**Observed result:** `NoMatchingEventsFound`.

A control query confirmed the PowerShell session *could* read the Security log:

```powershell
Get-WinEvent -LogName Security -MaxEvents 5 |
    Select-Object TimeCreated, Id, RecordId
```

**Observed result:** five recent events with Event ID `5379` were returned; this proves basic log readability but **does not explain** the failed 4625 queries.

The initial extraction script printed `Events analyzed: 0` and a misleading success message. Any CSV produced from that run is **not a valid source of 4625 evidence**. No successful PowerShell 4625 extraction is claimed.

## 6. Findings and limitations

- The Event Viewer screenshot documents six visible failed logons.
- One representative event is confirmed to have an interactive logon type and a loopback source.
- Three close timestamps are an investigation lead, not proof of automated guessing.
- No verified 4624 successful-login correlation was completed.
- The identity behind these attempts and cause of the discrepancy with PowerShell were not established.
- Other event-level field values for the remaining 4625 records have not all been independently verified.

## 7. Public evidence handling

- Keep original captures under local `screenshots/` (ignored by Git).
- Share only redacted copies under `screenshots-public/`.
- Do not commit raw `.evtx` files, private logs, hostnames, usernames, machine IDs, or authentication material.
- Screenshots document UI observations; they are not tamper-proof forensic images.

## 8. Final classification

**Investigated; cause undetermined. No confirmed brute force or compromise.**

## References

- https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4625
- https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-erref/596a1078-e883-4972-9bbc-49e60bebca55
