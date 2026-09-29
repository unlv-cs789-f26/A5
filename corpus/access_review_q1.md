---
id: access-review-q1
type: iam
date: 2026-02-20
title: Q1 2026 Privileged Access Review
---

# Q1 2026 Privileged Access Review

Reviewer: Rachel Ocampo, Director of IT Operations. Scope: every directory group that
grants access to a system classified Confidential or above.

## Entitlements by group

| Group | Reachable system | Access level | Protocol / port | Decision |
|---|---|---|---|---|
| GRP-FIN-PAYROLL-RW | VAN-SRV-DB07 (Meridian Payroll DB) | read/write | 1433/tcp | Recertified |
| GRP-ENG-BUILD | VAN-SRV-BLD02 (Foundry CI build server) | administrator | 22/tcp, 8080/tcp | Recertified |
| GRP-VPN-CONTRACTOR | SEG-CORP remote access | network | 443/tcp | Recertified with exception |
| GRP-IT-JUMP | VAN-SRV-JMP01 (administrative jump host) | administrator | 3389/tcp | Recertified |
| GRP-HR-READONLY | VAN-SRV-APP12 (Kestrel HRIS) | read-only | 443/tcp | Recertified |

## Findings

**Finding AR-01.** GRP-FIN-PAYROLL-RW grants read/write access to the Meridian Payroll DB
on VAN-SRV-DB07. Any member of GRP-FIN-PAYROLL-RW can read and modify payroll records.
This is the highest-value entitlement in scope.

**Finding AR-02.** GRP-VPN-CONTRACTOR was granted an exception permitting contractor
remote sessions to reach SEG-ENG in addition to SEG-CORP. The exception was approved by
Rachel Ocampo on 2026-01-19 to let Nimbus Consulting Group staff use the build server. It
has no expiry date. This exception means a contractor VPN session can reach VAN-SRV-BLD02.

**Finding AR-03.** GRP-IT-JUMP grants administrator access to VAN-SRV-JMP01. Because
SEG-MGMT can initiate connections into every segment, a member of GRP-IT-JUMP can reach the
Meridian Payroll DB indirectly through the jump host.

**Finding AR-04.** The service account svc_payroll_sync holds the same entitlement as human
members of GRP-FIN-PAYROLL-RW but has no interactive logon restriction. Accepted as a risk
by Rachel Ocampo pending the Q2 review.

No group memberships were revoked during this review.

## Method

Every group in scope was exported from the directory service on 2026-02-13 and reconciled
against the entitlement records held by each system owner. Where the two disagreed, the
system owner's record was treated as authoritative and a correction was raised against the
directory.

Membership itself is not reproduced in this document. This review records what each group
can reach, not who is in it. The membership export of 2026-02-13 is the companion document
and must be read alongside this one to answer any question about a named individual.

## Systems in scope and their classification

| System | Host | Classification | Owner |
|---|---|---|---|
| Meridian Payroll DB | VAN-SRV-DB07 | Restricted | Tomas Berger |
| Foundry CI build server | VAN-SRV-BLD02 | Confidential | Priya Raman |
| Kestrel HRIS | VAN-SRV-APP12 | Restricted | Nadia Kovac |
| Administrative jump host | VAN-SRV-JMP01 | Restricted | Alan Ferris |
| Corporate file server | VAN-SRV-FILE03 | Confidential | Rachel Ocampo |

The Meridian Payroll DB on VAN-SRV-DB07 holds salary, bank and tax records for every
Vandelay employee and is the only system in scope classified Restricted that contains
financial personal data.

## Exceptions carried forward

Two exceptions were carried forward from the 2025 Q4 review without change: the contractor
segment exception described in Finding AR-02, and the absence of an interactive logon
restriction on service accounts described in Finding AR-04.

## Sign-off

Reviewed and signed by Rachel Ocampo on 2026-02-20. Countersigned by Alan Ferris. The next
review is scheduled for 2026-05-15.

Rachel Ocampo noted in the sign-off that the review answers the question "what can this group
reach" but that no one in the organisation routinely asks the reverse question, "which groups
can reach this system", or the joined question, "given a compromised host, what can its
owner's groups reach". Those questions require combining this document with the asset
inventory and the membership export.
