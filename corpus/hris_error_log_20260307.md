---
id: hris-error-log-20260307
type: log
date: 2026-03-07
title: Kestrel HRIS Application Error Log - 2026-03-07
---

# Kestrel HRIS Application Error Log - 2026-03-07

Application error log from VAN-SRV-APP12 during the maintenance window on 2026-03-07.

```
01:12:04Z ERROR KES-4402 scheduler: reconciliation job handle not acquired, retrying
01:12:34Z ERROR KES-4402 scheduler: reconciliation job handle not acquired, retrying
01:13:04Z FATAL KES-5521 scheduler: reconciliation job aborted, payroll export lock held by
          a stale session; job must be relocated to an alternate host before the next run
01:19:41Z WARN  KES-3310 auth: session token cache flushed during maintenance
02:04:16Z INFO  KES-1000 scheduler: reconciliation job registered on alternate host
```

## Notes

Error code KES-5521 is the fatal scheduler error that aborted the nightly payroll
reconciliation job on 2026-03-07. Nadia Kovac, the HRIS application owner, escalated
KES-5521 to Alan Ferris the same morning.

The remediation for KES-5521 was to relocate the reconciliation job away from VAN-SRV-APP12.
Alan Ferris moved the job to VAN-SRV-JMP01 on 2026-03-07. Nothing else about the job was
changed, and the relocation was not communicated outside IT Operations.

KES-5521 must not be confused with KES-4402, which is a transient retryable warning, or with
KES-3310, which is expected during maintenance.

## Error code reference

| Code | Class | Meaning | Action |
|---|---|---|---|
| KES-1000 | INFO | Job registered successfully | none |
| KES-3310 | WARN | Session token cache flushed | none, expected during maintenance |
| KES-4402 | ERROR | Job handle not acquired, retryable | none, the scheduler retries |
| KES-5521 | FATAL | Job aborted, export lock held by a stale session | relocate the job to an alternate host |
| KES-6100 | FATAL | Datastore unreachable | escalate to the database team |

KES-5521 is the only fatal code in this log excerpt. Its documented remediation is the
relocation of the affected job to an alternate host, and that remediation was applied.

## Consequences of the relocation

The reconciliation job ran from VAN-SRV-JMP01 from 2026-03-07 onward. The first full run on
the alternate host performed a full-table reconciliation rather than the usual incremental
pass, because the job's watermark state did not move with it. That full-table run generated
the elevated read volume that produced an incident ticket two days later.

The relocation was performed as an operational fix on the morning of 2026-03-07 and was not
raised as a change record. Nobody outside IT Operations knew the job's source host had
changed until the SOC asked.

## Escalation record

Nadia Kovac raised KES-5521 with Alan Ferris at 07:40 UTC on 2026-03-07. Alan Ferris applied
the documented remediation at 09:15 UTC. The exchange is recorded in the operations mailbox
and is the only written record that the job moved.

## Why the code matters

Searching the corpus for the words "payroll job failure" will not find this document; the
document does not contain that phrase. Searching for the exact token KES-5521 will find it
immediately. This is a document that rewards knowing the identifier and punishes paraphrase.
