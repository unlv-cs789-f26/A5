---
id: soc-shift-notes-20260305
type: notes
date: 2026-03-05
title: SOC Shift Handover Notes - 2026-03-05
---

# SOC Shift Handover Notes - 2026-03-05

Outgoing: Kenji Watanabe (Tier 1). Incoming: Sofia Brandt (Tier 2).

## Open at handover

- **INC-2026-044** - beaconing from VAN-WKS-2210 to 198.51.100.77 still active. Perimeter
  block requested; the change record has not been raised yet. Expect it early next week.
- **INC-2026-045** - opened this evening at 21:18 UTC. Remote desktop session into the
  corporate file server from a Finance workstation using valid credentials. Sofia Brandt has
  taken it.

## Notes passed on

The post-incident review for INC-2026-041 was held this afternoon. The outcome is that the
February phishing case is re-rated Critical because the credentials taken then were used
tonight. Kenji Watanabe asked that Tier 1 be told the Medium rating was not a triage error;
the runbook simply did not ask the follow-up question.

Rachel Ocampo has asked for a forensic hold on the two hosts involved in INC-2026-045. Note
that the hold will block the Monday identity maintenance slot, including the contractor
offboarding change that has been sitting in the queue since 2026-03-03.

Kenji Watanabe flagged that nobody has checked what the Finance workstation's owner has
access to. That check was not done during INC-2026-041 and has still not been done.

## Nothing else open

No other incidents were open at handover. INC-2026-042 and INC-2026-043 are closed.

## Housekeeping

Ticket queue at handover: two open, six closed in the last thirty days. No tickets awaiting
Tier 1 triage. The evidence collection for INC-2026-043 is complete and the sample has come
back from analysis; the report names the family and confirms the beacon configuration, which
means INC-2026-043 and INC-2026-044 are the same tooling on the same host and should probably
have been one ticket.

## Things Kenji Watanabe would do differently

Two observations passed on informally rather than as findings.

The first is that the beacon on the engineering workstation was visible in retained proxy data
from 2026-02-27, two days before anyone looked. Nothing alerts on periodic outbound traffic
until the IDS signature fires, and the IDS signature needs a certain volume before it trips.

The second is that nobody has looked at what the archive staged tonight on the file server
actually contains, or set an alert for it moving. It is 1.4 GB sitting in a temp directory
and the only thing watching it is the forensic hold, which prevents Vandelay touching it but
does not prevent anyone else touching it.

## Requests to the incoming shift

Chase the perimeter block change for the beaconing destination; it has been pending since
Monday. Confirm with IT Operations whether the finance workstation from tonight's incident
was ever re-imaged after the February phishing case, because the notes suggest it was not.
Ask IAM whether the contractor offboarding change has a new execution date now that the
maintenance slot is cancelled.

None of these three items had been actioned when the next handover took place.
