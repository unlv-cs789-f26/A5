---
id: cve-2026-3117-writeup
type: vulnerability
date: 2026-02-18
title: Internal Writeup - CVE-2026-3117
---

# Internal Writeup: CVE-2026-3117

Prepared by Sofia Brandt for the Vandelay vulnerability review board.

## What it is

CVE-2026-3117 is a pre-authentication stack buffer overflow in the session negotiation
handler of Aperture SecureEdge VPN, disclosed in vendor advisory APERTURE-SA-2026-014 on
2026-02-14. Successful exploitation yields code execution as root on the appliance.

## Why it matters to Vandelay

Vandelay operates one Aperture SecureEdge VPN appliance. The management interface listens
on 8443/tcp and, at the time of writing, is reachable from the internet.

The affected range is 7.0.0 through 7.2.3 inclusive. Any appliance in that range should be
treated as exploitable by an unauthenticated attacker.

## Detection

The exploitation attempt produces a distinctive request to the management interface. The
perimeter IDS signature 2101922 fires on the pattern. Signature 2101922 firings should be
correlated with the appliance version recorded in the current asset inventory revision.

## Exploitation in the wild

Public reporting associates CVE-2026-3117 exploitation with the intrusion set tracked as
SILVER TAMARIN, which uses it for initial access. Exploitation of CVE-2026-3117 maps to
T1190 Exploit Public-Facing Application.

## Recommendation

Upgrade to Aperture SecureEdge VPN 7.2.6. Do not rely on the management-interface access
restriction alone; the restriction has not been implemented at Vandelay.

## Vandelay exposure assessment as at 2026-02-18

| Question | Answer |
|---|---|
| Do we run the affected product? | Yes, one appliance |
| Is the affected version in our estate? | Yes, the appliance runs 7.2.1 |
| Is the vulnerable interface reachable from the internet? | Yes, on both 8443/tcp and 443/tcp |
| Is a compensating control in place? | No |
| Has exploitation been attempted against us? | Yes, recorded in INC-2026-042 |
| Has exploitation succeeded against us? | No evidence of success |

## Recommended verification steps

Read the appliance build string from the console rather than from the inventory, because the
inventory is only as current as its last revision. Check the appliance uptime counter for a
discontinuity. Check the session table for entries with an empty realm field. Check `/tmp`
for files owned by root created outside a maintenance window.

Sofia Brandt performed all four checks on 2026-02-19 and found nothing anomalous.

## Argument for out-of-band patching

The affected code path runs before authentication, the exploit requires no user interaction,
and the appliance sits at the perimeter with no control in front of it. The only variable
under Vandelay's control is the version. Waiting for a maintenance window converts a
one-hour planned outage into an indefinite exposure window whose length is set by the
attacker's patience rather than by Vandelay's schedule.

This argument was made to Rachel Ocampo on 2026-02-19 and was not accepted at the time. It
was accepted on 2026-03-10 after threat intelligence linked exploitation of the vulnerability
to an actor already assessed as present in the Vandelay environment.

## Distinction from a similarly numbered identifier

CVE-2026-3117 is not CVE-2026-3171. Anyone searching ticket text for one will find the other.
CVE-2026-3117 is the Aperture SecureEdge VPN pre-authentication remote code execution flaw
with a CVSS base score of 9.8. It is the only CVE relevant to the perimeter appliance.
