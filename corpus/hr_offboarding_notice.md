---
id: hr-offboarding-notice
type: hr
date: 2026-03-02
title: Engagement End Notice - Nimbus Consulting Group
---

# Engagement End Notice

HR Operations notice circulated to IT Operations and IAM.

Nimbus Consulting Group's build pipeline modernisation engagement concludes on
**2026-03-06**. The following supplier staff reach their engagement end date:

- Dana Whitfield (`dwhitfield`), sponsor Priya Raman

## Required actions

1. Disable the Vandelay domain account `dwhitfield` by end of business 2026-03-09.
2. Remove `dwhitfield` from all directory groups, specifically GRP-ENG-BUILD and
   GRP-VPN-CONTRACTOR.
3. Recover laptop VAN-LAP-0912 and return it to the corporate pool.
4. Revoke the remote access certificate issued to the contractor.

Tomas Berger raised these actions with IAM on 2026-03-02 and asked Alan Ferris to open a
change record. HR Operations does not have the authority to disable accounts directly and
tracks only that the request was made.

Because the automatic contractor expiry job in the directory service has been disabled
since the January 2026 upgrade, none of these actions occur automatically. Every action on
this list requires a completed change record.

## Tracking

HR Operations tracks only that the request was made and to whom. It does not track
completion. The completion record lives in the change management system against whatever
change record IAM raises in response to this notice.

| Item | Owner | HR tracking status |
|---|---|---|
| Disable `dwhitfield` | IAM (Alan Ferris) | Requested 2026-03-02 |
| Remove group memberships | IAM (Alan Ferris) | Requested 2026-03-02 |
| Recover VAN-LAP-0912 | IT Operations | Requested 2026-03-02 |
| Revoke remote access certificate | IAM (Alan Ferris) | Requested 2026-03-02 |

None of the four items above is marked complete in the HR record. HR Operations does not
chase completion; the framework agreement makes IT Operations and IAM accountable for it.

## Escalation path when actions are not completed

The supplier framework agreement gives HR Operations no escalation route of its own. Tomas
Berger recorded that if the disablement had not happened by the end of the following week he
would raise it with Rachel Ocampo. He did not do so, and the campaign post-incident review
records this as a contributing factor rather than a cause: the process places the whole
weight of the control on one deferred change record with no second check behind it.

## Equipment

Laptop VAN-LAP-0912 was issued to Dana Whitfield on 2026-02-02 and had not been returned as
at the date of this notice. Contractor equipment recovery is a manual process initiated by
IT Operations on receipt of this notice. The laptop remained enrolled in the EDR platform
and connected to the network after the engagement end date.

## Distribution

Circulated 2026-03-02 to Rachel Ocampo, Alan Ferris, Priya Raman and the IT Operations
mailbox. Acknowledged by Alan Ferris on 2026-03-02.
