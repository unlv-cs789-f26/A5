---
id: pir-campaign-march
type: post_incident_review
date: 2026-03-30
title: Post-Incident Review - February to March 2026 Campaign
---

# Post-Incident Review: February to March 2026 Campaign

Review held 2026-03-30. Chair: Rachel Ocampo. Scope: INC-2026-041 through INC-2026-048.

## Narrative

The campaign ran from 2026-02-16 to 2026-03-21, approximately five and a half weeks. It
began with a phishing email into Finance and ended with a single bulk upload of staged
documents to a commodity cloud storage service.

Confirmed loss is 1.4 GB of departmental documents from the corporate file server. No
payroll records were taken. The Meridian Payroll DB was never reached by the actor.

## Root causes

**RC-1 - Unpatched perimeter appliance.** The remote access concentrator was left on a
version inside the CVE-2026-3117 affected range for twenty-six days after the vendor
advisory, and was only upgraded under emergency change on 2026-03-12. Exploitation was
attempted but never confirmed successful; the exposure was nonetheless unnecessary.

**RC-2 - Identity lifecycle depends on a disabled automation.** The directory service's
automatic contractor expiry job has been off since January 2026. Every contractor removal
now depends on a human-raised change record. One such record was deferred and then
forgotten, and the resulting stale account was used eight days after the engagement ended.

**RC-3 - A forensic hold froze identity hygiene.** The board's decision to freeze
non-emergency identity changes during a forensic hold kept a stale privileged account alive.

**RC-4 - A temporary firewall exception outlived its justification.** Its removal was
proposed and rejected because a business process still depended on it.

**RC-5 - No entity-level view.** Answering "what can this compromised host's owner reach"
required a human to read four separate documents. There is no system that joins hosts,
owners, groups and entitlements.

## Actions

Re-enable the contractor expiry automation; carve identity revocation out of forensic-hold
freezes; add an owner-to-entitlement lookup to the SOC toolchain; re-evaluate RC-4 with a
compensating control rather than an outright rejection.

## Campaign timeline at a glance

| Date | Event | Ticket |
|---|---|---|
| 2026-02-14 | Vendor advisory published for the perimeter appliance vulnerability | none |
| 2026-02-16 | Phishing email opened on a finance workstation; credentials harvested | INC-2026-041 |
| 2026-02-19 | Exploitation attempts against the remote access concentrator | INC-2026-042 |
| 2026-02-24 | Credential dumping on an engineering workstation | INC-2026-043 |
| 2026-03-01 | Command and control beaconing detected | INC-2026-044 |
| 2026-03-05 | Lateral movement by remote desktop; 1.4 GB archive staged | INC-2026-045 |
| 2026-03-06 | Contractor engagement ends; account not disabled | none |
| 2026-03-09 | Anomalous payroll database query volume, later a false positive | INC-2026-046 |
| 2026-03-11 | Command and control address blocked at the perimeter | CHG-2026-0893 |
| 2026-03-12 | Perimeter appliance upgraded under emergency change | CHG-2026-0891 |
| 2026-03-14 | Build server accessed with a stale contractor account | INC-2026-047 |
| 2026-03-21 | Staged archive exfiltrated to commodity cloud storage | INC-2026-048 |

Eight incident tickets were opened during the campaign, numbered INC-2026-041 through
INC-2026-048 consecutively. Three of them carry a Critical rating at the time of this review:
the phishing case after its re-rating, the lateral movement case, and the exfiltration case.
One of the eight, the payroll database ticket, was closed as a false positive.

## What worked

The perimeter block on the command and control address stopped the beaconing immediately and
the actor did not re-establish a channel. The emergency change process worked as designed and
turned a critical appliance vulnerability around in two days once it was prioritised. The
segmentation model held: nothing the actor did brought them within reach of the payroll
database, and the one authentication attempt against it failed on two independent controls.

## What did not work

Detection of bulk egress fired after the transfer was complete. The staged archive sat on disk
for sixteen days and nothing looked at it. Identity revocation was blocked by a control
designed for a different purpose. And the single most useful question after a credential
theft, what can this identity reach, had no owner and no tool.

## Estimate of avoidability

The board's judgement is that completing the offboarding change would have prevented
INC-2026-047 entirely, and that a forced re-enrolment after INC-2026-041 would have prevented
INC-2026-045 and therefore INC-2026-048. Neither measure would have prevented INC-2026-043 or
INC-2026-044, which reached an engineering workstation by a separate route.
