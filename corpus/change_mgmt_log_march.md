---
id: change-log-march
type: change
date: 2026-03-27
title: Change Management Log - March 2026
---

# Change Management Log - March 2026

Summary of change records raised in March 2026, produced for the monthly operations review.

| Change | Title | Raised | Status |
|---|---|---|---|
| CHG-2026-0884 | Contractor offboarding, D. Whitfield | 2026-03-03 | Not completed |
| CHG-2026-0887 | Quarterly certificate rotation, SEG-EDGE | 2026-03-05 | Completed |
| CHG-2026-0891 | Emergency upgrade of VAN-SRV-VPN01 | 2026-03-10 | Completed |
| CHG-2026-0893 | Block outbound to 198.51.100.77 at perimeter | 2026-03-11 | Completed |
| CHG-2026-0896 | Remove temporary SEG-CORP to SEG-ENG exception | 2026-03-18 | Rejected |
| CHG-2026-0899 | Forensic image retention extension | 2026-03-20 | Completed |
| CHG-2026-0902 | Disable svc_payroll_sync interactive logon | 2026-03-24 | Pending |

## Commentary

Seven change records were raised in March 2026. Four completed, one was rejected, one is
pending and one was never executed.

CHG-2026-0896 proposed removing the temporary firewall exception that permits 22/tcp and
8080/tcp from SEG-CORP to SEG-ENG. It was rejected on 2026-03-18 because the engineering
team still depended on the path for the build pipeline. The exception therefore remained
active throughout the campaign.

CHG-2026-0884 is the only change record raised in March 2026 that was never executed.

## Detail on individual records

**CHG-2026-0887** rotated the TLS certificates on perimeter services in SEG-EDGE. Routine,
completed in the scheduled window, no incidents arising.

**CHG-2026-0893** added 198.51.100.77 to the perimeter blocklist. Raised on 2026-03-11 as an
emergency change on the strength of the beaconing recorded in INC-2026-044, approved and
executed the same day. Outbound traffic to that address ceased immediately.

**CHG-2026-0899** extended evidence retention for the campaign from the standard ninety days
to one year, covering EDR telemetry, proxy logs, mail gateway records and forensic images for
every host named in INC-2026-041 through INC-2026-048.

**CHG-2026-0902** proposes disabling interactive logon for the service account
svc_payroll_sync, addressing Finding AR-04 of the Q1 access review. It is pending the payroll
team's confirmation that the nightly reconciliation job does not depend on interactive logon.

## Deferral statistics

Of the seven records raised in March 2026, one was deferred more than once. Deferrals do not
reset the record's status to overdue, so a repeatedly deferred change produces no
notification. This behaviour is under review following the campaign post-incident review.

Average time from raise to disposition, excluding the record that was never executed, was
3.4 days. The emergency records CHG-2026-0891 and CHG-2026-0893 were both disposed of within
one day of being raised.

## Board membership

The change advisory board's standing membership in March 2026 was Rachel Ocampo (chair),
Alan Ferris, Priya Raman and Nadia Kovac. Sofia Brandt attends when a security incident is
in scope and attended the 2026-03-09 and 2026-03-16 meetings at which identity changes were
deferred.
