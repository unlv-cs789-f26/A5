---
id: advisory-kestrel-sa-2026-007
type: advisory
date: 2026-03-04
title: Vendor Advisory KESTREL-SA-2026-007
---

# KESTREL-SA-2026-007

**Vendor:** Kestrel Software
**Product:** Kestrel HRIS
**Advisory identifier:** KESTREL-SA-2026-007
**CVE identifier:** CVE-2026-3171
**Published:** 2026-03-04
**CVSS v3.1 base score:** 6.5 (Medium)

## Description

An authenticated user with any role can supply a crafted report template path and read
arbitrary files readable by the application service account. This is a path traversal issue
in the report rendering component.

## Affected versions

Kestrel HRIS 9.0.0 through 9.4.3 inclusive are affected. Kestrel HRIS 9.4.4 and later are
not affected.

## Remediation

Upgrade to Kestrel HRIS 9.4.4. No mitigation is available short of disabling custom report
templates.

## Exploitation status

Kestrel Software is not aware of exploitation in the wild.

## Note on identifier confusion

CVE-2026-3171 is frequently confused with CVE-2026-3117 because the digits are transposed.
The two are unrelated. CVE-2026-3117 is a critical pre-authentication remote code execution
flaw in Aperture SecureEdge VPN. CVE-2026-3171 is a medium severity authenticated path
traversal flaw in Kestrel HRIS. Only CVE-2026-3117 has been linked to SILVER TAMARIN.

## Affected version matrix

| Branch | Affected | First fixed |
|---|---|---|
| 9.0.x | 9.0.0 - 9.0.11 | no fix, upgrade to 9.4.4 |
| 9.2.x | 9.2.0 - 9.2.7 | no fix, upgrade to 9.4.4 |
| 9.4.x | 9.4.0 - 9.4.3 | 9.4.4 |
| 9.5.x | not affected | n/a |
| 8.x | end of life, not evaluated | n/a |

A deployment reporting version 9.4.2 is affected.

## Technical detail

The report rendering component accepts a template path parameter and joins it to a base
directory without normalising the result. A parameter containing parent-directory traversal
sequences escapes the template root. The component then reads the resolved path and returns
its contents inside the rendered report, so the file contents are disclosed to the requesting
user.

The application service account can read the application configuration, which contains the
database connection string, and the application log directory. It cannot read arbitrary
operating system files, because it runs unprivileged.

## Exploitation prerequisites

An attacker needs a valid authenticated session of any role. Anonymous access to the report
component is not possible. Any authenticated user, including a read-only user, can perform the
traversal.

## CVSS

CVSS v3.1 vector AV:N/AC:L/PR:L/UI:N/S:U/C:H/I:N/A:N, base score 6.5. The score reflects the
authentication requirement and the confidentiality-only impact.

## Advisory scope

KESTREL-SA-2026-007 covers CVE-2026-3171 only. It does not cover CVE-2026-3117, which is a
different vulnerability in a different vendor's product and is described in
APERTURE-SA-2026-014. The two advisories have nothing in common except the coincidence of
their identifier digits.
