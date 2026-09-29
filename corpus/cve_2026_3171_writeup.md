---
id: cve-2026-3171-writeup
type: vulnerability
date: 2026-03-06
title: Internal Writeup - CVE-2026-3171
---

# Internal Writeup: CVE-2026-3171

Prepared by Nadia Kovac, HRIS application owner.

## What it is

CVE-2026-3171 is an authenticated path traversal flaw in the report rendering component of
Kestrel HRIS, disclosed in vendor advisory KESTREL-SA-2026-007 on 2026-03-04. An
authenticated user of any role can read files readable by the application service account.

## Why it matters to Vandelay

Vandelay runs Kestrel HRIS 9.4.2 on VAN-SRV-APP12. The affected range is 9.0.0 through
9.4.3 inclusive, so the Vandelay deployment is affected. The upgrade to Kestrel HRIS 9.4.4
has not been performed.

Exploitation requires an authenticated session. The groups that can authenticate to Kestrel
HRIS are GRP-HR-READONLY and the application administrators.

## Not to be confused with

CVE-2026-3171 is not CVE-2026-3117. The digits are transposed and the two identifiers are
regularly mixed up in ticket text. CVE-2026-3171 affects Kestrel HRIS and carries a CVSS
base score of 6.5. CVE-2026-3117 affects Aperture SecureEdge VPN and carries a CVSS base
score of 9.8.

No incident in the 2026 campaign involved CVE-2026-3171. The only CVE exploited or attempted
against Vandelay during the campaign was CVE-2026-3117.

## Vandelay exposure assessment as at 2026-03-06

| Question | Answer |
|---|---|
| Do we run the affected product? | Yes, Kestrel HRIS on VAN-SRV-APP12 |
| Is the affected version in our estate? | Yes, version 9.4.2 |
| Is the application internet-facing? | No, it sits in SEG-APP-DMZ and is reachable only internally |
| Who can authenticate to it? | GRP-HR-READONLY members and application administrators |
| Has exploitation been attempted against us? | No |
| Is a fix scheduled? | Upgrade to 9.4.4 proposed, not yet scheduled |

## What an attacker would gain

The application service account can read the application configuration file, which holds the
database connection string for the HRIS datastore. That datastore is separate from the
Meridian Payroll DB and holds employment records rather than payroll records. Disclosure of
the connection string would be significant but would not by itself grant payroll access.

## Priority

Nadia Kovac assessed the remediation priority as medium. The reasoning is that exploitation
requires an authenticated session, the application is not internet-facing, the group of people
who can authenticate is small and known, and no exploitation has been observed anywhere.

The assessment notes that a medium priority is defensible only while the authentication
boundary holds. If any account able to authenticate to Kestrel HRIS were compromised, the
priority would become high immediately.

## Status at the end of March 2026

Kestrel HRIS 9.4.4 had not been applied. VAN-SRV-APP12 is the only host in the estate
carrying an outstanding vulnerability at the March 2026 inventory revision, and
CVE-2026-3171 is that vulnerability.
