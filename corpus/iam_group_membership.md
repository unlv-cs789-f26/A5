---
id: iam-group-membership
type: iam
date: 2026-02-13
title: Directory Group Membership Export
---

# Directory Group Membership Export

Export produced by Alan Ferris, IAM Administrator, from the Vandelay directory service.
Membership is listed by group. Service accounts are prefixed `svc_`.

## GRP-FIN-PAYROLL-RW
- Marcus Delgado (Senior Financial Analyst, Finance)
- Tomas Berger (HR Operations Lead)
- svc_payroll_sync (service account, owned by Tomas Berger)

## GRP-ENG-BUILD
- Priya Raman (Platform Engineer)
- Dana Whitfield (Contractor, Nimbus Consulting Group)

## GRP-VPN-CONTRACTOR
- Dana Whitfield (Contractor, Nimbus Consulting Group)
- Omar Ceylan (Contractor, Halberd Systems)

## GRP-IT-JUMP
- Rachel Ocampo (Director of IT Operations)
- Alan Ferris (IAM Administrator)

## GRP-HR-READONLY
- Tomas Berger (HR Operations Lead)
- Nadia Kovac (HRIS Application Owner)

## SOC-ANALYSTS
- Sofia Brandt (SOC Analyst, Tier 2)
- Kenji Watanabe (SOC Analyst, Tier 1)

## Administrator notes

Marcus Delgado is a member of GRP-FIN-PAYROLL-RW. This membership was granted on his
transfer into Finance in 2024 and has been renewed at every access review since.

Dana Whitfield holds membership in both GRP-ENG-BUILD and GRP-VPN-CONTRACTOR. Contractor
memberships are supposed to expire automatically at contract end; the automatic expiry job
has been disabled since a directory upgrade in January 2026 and memberships now require a
manual removal change record.

The service account svc_payroll_sync is a member of GRP-FIN-PAYROLL-RW and is used by the
nightly payroll reconciliation job.

## Account inventory

| Account | Display name | Type | Status at export | Created |
|---|---|---|---|---|
| mdelgado | Marcus Delgado | employee | enabled | 2024-03-11 |
| praman | Priya Raman | employee | enabled | 2023-08-01 |
| tberger | Tomas Berger | employee | enabled | 2021-06-14 |
| nkovac | Nadia Kovac | employee | enabled | 2022-11-02 |
| rocampo | Rachel Ocampo | employee | enabled | 2020-01-20 |
| aferris | Alan Ferris | employee | enabled | 2021-02-08 |
| sbrandt | Sofia Brandt | employee | enabled | 2023-04-17 |
| kwatanabe | Kenji Watanabe | employee | enabled | 2025-09-29 |
| dwhitfield | Dana Whitfield | contractor | enabled | 2026-02-02 |
| oceylan | Omar Ceylan | contractor | enabled | 2025-11-10 |
| svc_payroll_sync | Payroll reconciliation | service | enabled | 2021-07-05 |

## How to read this export

Each person is listed under every group they belong to. The export does not say what a group
can reach; that information lives in the privileged access review. Answering a question of
the form "what can this person get to" therefore needs both documents, and answering "which
person owns this machine" needs the asset inventory as well.

Marcus Delgado appears in exactly one group in this export. Dana Whitfield appears in two.
Tomas Berger appears in two. Rachel Ocampo and Alan Ferris appear in one each.

## Known weaknesses in identity hygiene

The automatic contractor expiry job has been disabled since the directory upgrade on
2026-01-11. Alan Ferris raised this with the change advisory board on 2026-01-14 and the
re-enablement was scheduled and then deferred twice. While it is disabled, a contractor's
group memberships survive their engagement end date until a change record removes them by
hand.

Nested groups are not in use at Vandelay. Every membership shown is direct, which makes the
export complete but also means an entitlement change requires touching every group
individually.

Service accounts are not subject to the joiner-mover-leaver process at all. svc_payroll_sync
has not had its password rotated since 2024 and has no named human owner in the directory;
Tomas Berger is recorded as its owner only in this export's annotations.
