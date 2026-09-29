---
id: auth-log-20260314
type: log
date: 2026-03-14
title: Authentication Log Excerpt - 2026-03-14
---

# Authentication Log Excerpt - 2026-03-14

Excerpt from the directory service authentication log, 18:45 to 19:30 UTC.

```
18:52:11Z  event=4624 logon_type=3  user=praman     src=10.40.12.55   host=VAN-SRV-BLD02  result=success
19:01:44Z  event=4624 logon_type=10 user=dwhitfield src=10.20.9.61    host=VAN-SRV-BLD02  result=success
19:06:02Z  event=4672 user=dwhitfield host=VAN-SRV-BLD02 privileges="SeDebugPrivilege,SeBackupPrivilege"
19:11:37Z  event=4624 logon_type=3  user=svc_payroll_sync src=10.60.1.9 host=VAN-SRV-DB07 result=success
19:22:50Z  event=4625 logon_type=3  user=dwhitfield src=10.20.9.61    host=VAN-SRV-DB07   result=failure
           status=0xC000006D reason="account not authorised for this resource"
```

## Notes

The address 10.20.9.61 is the DHCP lease held by VAN-LAP-0912 on 2026-03-14. The address
10.60.1.9 belongs to VAN-SRV-JMP01.

The account `dwhitfield` authenticated successfully to VAN-SRV-BLD02 at 19:01 UTC and was
granted administrative privileges at 19:06 UTC. Eight days after the engagement end date of
2026-03-06, the account was still enabled.

The same account failed to authenticate to VAN-SRV-DB07 at 19:22 UTC. The log records the
status code but not the cause. Establishing why the attempt was refused needs the directory
group membership export and the network segmentation model; neither is reproduced here.

## Event reference

| Event ID | Meaning |
|---|---|
| 4624 | Successful logon |
| 4625 | Failed logon |
| 4672 | Special privileges assigned to a new logon |
| Logon type 3 | Network logon |
| Logon type 10 | RemoteInteractive, that is, remote desktop |

## Reading the sequence

The 18:52 entry is Priya Raman's routine network logon to the build server from her
engineering workstation and is unrelated to the incident.

The 19:01 entry is a remote desktop logon by `dwhitfield` from the contractor laptop's DHCP
address. The 19:06 entry shows that the same logon session was granted SeDebugPrivilege and
SeBackupPrivilege, which the build server assigns to members of its administrator group.

The 19:11 entry is the nightly reconciliation service account connecting to the payroll
database from the administrative jump host. It is routine for the period after 2026-03-07 and
unrelated to the contractor session.

The 19:22 entry is the failure that generated the alert. Status 0xC000006D with the recorded
reason indicates the account authenticated but was refused authorisation for the resource.

## What the log does not show

The log records the account and the source address. It does not record who was at the
keyboard. Establishing whether the person to whom the account belongs used it, or whether the
credentials were held by someone else, requires evidence this log cannot supply.

The log also does not explain why the account was still able to authenticate eight days after
the engagement end date. That explanation is in the change management record.

## Retention

Directory authentication logs are retained for ninety days as standard, extended to one year
for the campaign window under CHG-2026-0899.
