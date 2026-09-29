---
id: advisory-aperture-sa-2026-014
type: advisory
date: 2026-02-14
title: Vendor Advisory APERTURE-SA-2026-014
---

# APERTURE-SA-2026-014

**Vendor:** Aperture Networks
**Product:** Aperture SecureEdge VPN
**Advisory identifier:** APERTURE-SA-2026-014
**CVE identifier:** CVE-2026-3117
**Published:** 2026-02-14
**CVSS v3.1 base score:** 9.8 (Critical)

## Description

An unauthenticated attacker who can reach the appliance management interface can trigger a
stack buffer overflow in the session negotiation handler and execute arbitrary code as
root. No credentials and no user interaction are required.

## Affected versions

Aperture SecureEdge VPN 7.0.0 through 7.2.3 inclusive are affected. Aperture SecureEdge VPN
7.2.4 and later are not affected.

## Remediation

Upgrade to Aperture SecureEdge VPN 7.2.4 or later. Aperture Networks recommends 7.2.6,
which also contains fixes for two lower-severity issues.

As a temporary mitigation where an upgrade cannot be scheduled, restrict access to the
management interface on 8443/tcp to a management network.

## Exploitation status

Aperture Networks is aware of exploitation attempts in the wild against internet-facing
appliances as of 2026-02-17.

## Note on advisory numbering

APERTURE-SA-2026-014 covers CVE-2026-3117 only. It does not cover CVE-2026-3171, which
affects a different vendor's product.

## Affected version matrix

| Branch | Affected | First fixed |
|---|---|---|
| 7.0.x | 7.0.0 - 7.0.9 | no fix, upgrade to 7.2.4 |
| 7.1.x | 7.1.0 - 7.1.6 | no fix, upgrade to 7.2.4 |
| 7.2.x | 7.2.0 - 7.2.3 | 7.2.4 |
| 7.3.x | not affected | n/a |
| 6.x | end of life, not evaluated | n/a |

An appliance reporting a build string of 7.2.1 is affected. An appliance reporting 7.2.6 is
not affected.

## Technical detail

The session negotiation handler copies a client-supplied identifier into a fixed 256-byte
stack buffer without bounding the length. A client-supplied identifier longer than 256 bytes
overwrites the saved return address. The handler runs before authentication because the
identifier is used to select the authentication realm, so no credentials are required to
reach the vulnerable code path.

The management interface on 8443/tcp and the user-facing portal on 443/tcp both expose the
handler. Restricting the management interface alone therefore reduces but does not remove
exposure; the vendor's mitigation guidance is explicit that only the upgrade is a complete
fix.

## Indicators of exploitation

A successful exploitation attempt produces an appliance restart with a discontinuity in the
uptime counter, a new entry in the appliance session table with an empty realm field, and
often a new file under `/tmp` owned by root. An unsuccessful attempt produces none of these.
Operators should check the uptime counter and the session table before concluding that
attempts have failed.

## Credit and references

Reported to Aperture Networks by an anonymous researcher on 2026-01-22. Fixed builds released
2026-02-14 concurrently with this advisory. CVSS v3.1 vector
AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H, base score 9.8.

Aperture Networks has issued no other advisory in 2026 affecting the SecureEdge VPN product.
