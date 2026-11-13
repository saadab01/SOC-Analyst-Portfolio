# Incident Investigation Report — SOC-LAB-001

**Report title:** Review of Repeated Windows Failed Logons  
**Report date:** 2026-11-13  
**Case type:** Training / host-based authentication investigation  
**Data source:** Windows Security log (Event Viewer)  
**Owner:** Junior SOC Analyst (portfolio exercise)  
**Disposition:** **Inconclusive — no confirmed compromise**

## 1. Executive summary

A review of the Windows Security log showed **six** Event ID `4625` failed-logon records. Three appeared within **six seconds** on **2026-11-13**. A detailed examination of the event at **00:14:50** showed an interactive failed logon (`LogonType 2`), a localhost source (`127.0.0.1`), a generic authentication failure status (`0xC000006D`), and substatus `0xC0000380` (`STATUS_SMARTCARD_WRONG_PIN`). The failed-account field was not populated. No reliable evidence identified a remote attacker, a successfully compromised account, or a brute-force campaign. The events remain **unattributed**.

## 2. Investigation question

Do the repeated failed logons represent unauthorized authentication attempts, and is there evidence of a successful login or compromise?

## 3. Evidence reviewed

| ID | Evidence | Assessment |
| --- | --- | --- |
| E-01 | [Redacted Event Viewer filtered list](screenshots-public/04-failed-logins-redacted.png) | Six visible 4625 events, with November 13 cluster |
| E-02 | [Redacted EventData detail](screenshots-public/05-event-details-001-redacted.png) | Field-level evidence for 00:14:50 |
| E-03 | PowerShell console output shared during lab | No 4625 matches in attempted query; five 5379 events in separate control query |

Raw unredacted screenshots remain local and are excluded from Git. E-03 is based on provided console output; a raw/exported event-log artifact was not verified.

## 4. Timeline (local clock displayed in Event Viewer)

| Timestamp | Activity |
| --- | --- |
| 2026-11-02 16:38:45 | Failed logon (4625) listed |
| 2026-11-02 16:38:49 | Failed logon (4625) listed |
| 2026-11-04 21:16:31 | Failed logon (4625) listed |
| 2026-11-13 00:14:50 | Failed logon (4625); details examined |
| 2026-11-13 00:14:53 | Failed logon (4625) listed |
| 2026-11-13 00:14:56 | Failed logon (4625) listed |

## 5. Technical findings

### Observations

- **Count:** Six filtered Event ID 4625 records in the Event Viewer capture.
- **Cluster:** Three failures at 00:14:50, 00:14:53, and 00:14:56.
- **Representative event:** `LogonType=2`, `IpAddress=127.0.0.1`, `TargetUserName=-`.
- **Authentication status:** `0xC000006D` indicates failed authentication.
- **Additional status:** `0xC0000380` maps to `STATUS_SMARTCARD_WRONG_PIN` in the Microsoft NTSTATUS reference. This suggests a PIN-related authentication failure code, but does not establish the precise local mechanism or malicious intent.
- **Process:** `C:\Windows\System32\svchost.exe` was recorded as caller process in the representative event.

### Assessment

The short time span is worth flagging, but **localhost does not indicate an external source**, and the target username was not identified. A burst of failed authentication events is insufficient to prove brute-force activity. No associated successful login was verified.

### Tooling discrepancy

Two PowerShell queries filtering Event ID 4625 returned `NoMatchingEventsFound`. A different query returned Security event 5379 records, confirming that the Security log was readable by PowerShell. The discrepancy with the Event Viewer filter was not resolved. A zero-row CSV from the earlier script must not be cited as validated evidence.

## 6. Impact and severity

**Confirmed impact:** None established.  
**Initial priority:** Low / informational in this local training context; reassess if more evidence emerges.  
**Compromise status:** Not confirmed.

## 7. Recommendations

1. Correlate Event ID 4625 with Event ID 4624 over the same time span, using consistent log sources and event record IDs where possible.
2. If available, verify the affected authentication method and whether the user expected PIN/smart-card activity.
3. Investigate the Event Viewer vs. PowerShell discrepancy before claiming programmatic validation.
4. Monitor for renewed failed logons, especially if associated with identifiable accounts or external sources.
5. Preserve original logs locally and sanitize screenshots before publication.

## 8. Conclusion

**The alert was investigated; the root cause remains unknown.** The evidence supports repeated failed local authentication events, not a confirmed external attack, successful access, or data compromise. Further correlation would be required to change this assessment.

## References

- Microsoft, Event ID 4625: https://learn.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4625
- Microsoft, NTSTATUS values: https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-erref/596a1078-e883-4972-9bbc-49e60bebca55
