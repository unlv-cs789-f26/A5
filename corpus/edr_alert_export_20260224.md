---
id: edr-alert-export-20260224
type: alert_export
date: 2026-02-24
title: EDR Alert Export - 2026-02-24
---

# EDR Alert Export - 2026-02-24

Export from the endpoint detection platform, 2026-02-24, all severities.

```
14:03:07Z  host=VAN-WKS-2210  rule=CRED_LSASS_HANDLE_READ  sev=high
           proc=svcmon.exe  parent=powershell.exe  user=praman
           detail="handle to lsass.exe opened with PROCESS_VM_READ"
14:03:41Z  host=VAN-WKS-2210  rule=FILE_WRITE_SENSITIVE_PATH  sev=medium
           proc=svcmon.exe  path="C:\Users\Public\lsass_2210.tmp"  size=68419584
14:05:12Z  host=VAN-WKS-2210  rule=PERSIST_RUN_KEY_WRITE  sev=high
           proc=svcmon.exe  key="HKCU\...\CurrentVersion\Run\SvcMon"
14:14:55Z  host=VAN-WKS-2210  rule=FILE_DELETE_SELF_ARTIFACT  sev=low
           proc=svcmon.exe  path="C:\Users\Public\lsass_2210.tmp"
19:31:02Z  host=VAN-WKS-4471  rule=SCRIPT_ENCODED_COMMAND  sev=medium
           proc=powershell.exe  parent=excel.exe  user=mdelgado
```

## File hashes observed

- `svcmon.exe` SHA-256 `3b1f7c9a4e0d2a6b8f5c1d3e7a9b0c2d4e6f8a1b3c5d7e9f0a2b4c6d8e0f1a35`
- `svcmon.exe` MD5 `d41d8cd98f00b204e9800998ecf8427e`
- `ledger_q1_adjustments.xlsm` SHA-256
  `7c2e0b5d9a13f846e2c7b0d5a9f3e18c6b402d7f9a1e5c3b8d06f24a7e91b0c3`

## Notes

The dumping tool `svcmon.exe` and the encoded PowerShell on VAN-WKS-4471 share no parent
process. The Excel-launched PowerShell on VAN-WKS-4471 belongs to INC-2026-041; the LSASS
activity on VAN-WKS-2210 belongs to INC-2026-043.

## Process ancestry, VAN-WKS-2210

```
services.exe
 └─ sshd.exe (session from 10.20.4.13)
     └─ cmd.exe
         └─ powershell.exe  -nop -w hidden -enc <redacted>
             └─ svcmon.exe
```

The parent chain shows `svcmon.exe` launched by an encoded PowerShell command, which was
itself launched from an interactive SSH session originating at 10.20.4.13. The asset
inventory maps 10.20.4.13 to the corporate file server.

## Process ancestry, VAN-WKS-4471

```
explorer.exe
 └─ excel.exe  (ledger_q1_adjustments.xlsm)
     └─ powershell.exe  -nop -w hidden -enc <redacted>
```

No child process was created under the PowerShell on VAN-WKS-4471. The encoded command read
the browser credential store and issued a single outbound POST. No file was written to disk
and no persistence mechanism was created, which is why the host was not re-imaged.

## Detection rule coverage

| Rule | Fired | Would have fired earlier if |
|---|---|---|
| CRED_LSASS_HANDLE_READ | yes, at execution | n/a |
| FILE_WRITE_SENSITIVE_PATH | yes | n/a |
| PERSIST_RUN_KEY_WRITE | yes | n/a |
| SCRIPT_ENCODED_COMMAND | yes, medium only | severity raised for Office parents |
| TOOL_TRANSFER_INBOUND_SSH | no rule exists | a rule existed for SSH into SEG-ENG |

The gap in the last row is the reason the arrival of `svcmon.exe` was visible only in
retrospect. The transfer itself raised nothing.

## Retention

This export is retained under the extended one-year retention applied to all campaign
evidence on 2026-03-20.
