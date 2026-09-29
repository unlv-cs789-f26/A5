---
id: asset-inventory-v2
type: inventory
date: 2026-03-16
title: Vandelay Industries Asset Inventory (Revision 2, current)
supersedes: asset-inventory-v1
status: current
---

# Asset Inventory - Revision 2 (current)

This revision supersedes Revision 1 dated 2026-02-10. It incorporates the emergency VPN
upgrade performed under CHG-2026-0891 and the decommissioning of contractor equipment.

| Host ID | Role | Software / Version | Segment | Primary Owner |
|---|---|---|---|---|
| VAN-WKS-4471 | Finance workstation | Windows 11 23H2 | SEG-FIN-CORE | Marcus Delgado |
| VAN-WKS-2210 | Engineering workstation | Windows 11 23H2 | SEG-ENG | Priya Raman |
| VAN-LAP-0912 | Contractor laptop (pending collection) | Windows 11 22H2 | SEG-CORP | Dana Whitfield |
| VAN-SRV-DB07 | Meridian Payroll DB | MSSQL 2022 | SEG-FIN-CORE | Tomas Berger |
| VAN-SRV-APP12 | Kestrel HRIS application | Kestrel HRIS 9.4.2 | SEG-APP-DMZ | Nadia Kovac |
| VAN-SRV-VPN01 | Remote access concentrator | Aperture SecureEdge VPN 7.2.6 | SEG-EDGE | Rachel Ocampo |
| VAN-SRV-FILE03 | Corporate file server | Windows Server 2022 | SEG-CORP | Rachel Ocampo |
| VAN-SRV-JMP01 | Administrative jump host | Windows Server 2022 | SEG-MGMT | Alan Ferris |
| VAN-SRV-BLD02 | Continuous integration build server | Foundry CI 4.8 | SEG-ENG | Priya Raman |

## Changes since Revision 1

VAN-SRV-VPN01 was upgraded from Aperture SecureEdge VPN 7.2.1 to Aperture SecureEdge VPN
7.2.6 on 2026-03-12 under change record CHG-2026-0891. The appliance is no longer affected
by CVE-2026-3117.

VAN-SRV-APP12 remains on Kestrel HRIS 9.4.2 and is still within the range affected by
CVE-2026-3171. A vendor patch is scheduled but not yet applied.

The temporary firewall exception on VAN-SRV-BLD02 permitting inbound 22/tcp and 8080/tcp
from SEG-CORP was still in place at the time of this revision.

VAN-LAP-0912 has not been physically returned. Its Vandelay domain account remains
enabled pending completion of CHG-2026-0884.

## Addressing

| Host ID | IPv4 | Segment |
|---|---|---|
| VAN-WKS-4471 | 10.60.7.22 | SEG-FIN-CORE |
| VAN-WKS-2210 | 10.40.12.55 | SEG-ENG |
| VAN-LAP-0912 | 10.20.9.61 (DHCP) | SEG-CORP |
| VAN-SRV-DB07 | 10.60.1.30 | SEG-FIN-CORE |
| VAN-SRV-APP12 | 10.30.2.8 | SEG-APP-DMZ |
| VAN-SRV-VPN01 | 10.10.0.4 | SEG-EDGE |
| VAN-SRV-FILE03 | 10.20.4.13 | SEG-CORP |
| VAN-SRV-JMP01 | 10.60.1.9 | SEG-MGMT |
| VAN-SRV-BLD02 | 10.40.3.17 | SEG-ENG |

## Ownership model

Primary owner is the person accountable for the asset. For workstations and laptops it is
the person to whom the device is issued and who logs on interactively. VAN-WKS-4471 is
issued to Marcus Delgado. VAN-WKS-2210 is issued to Priya Raman. VAN-LAP-0912 is issued to
Dana Whitfield.

This table is the join between host identifiers, which is what alerts contain, and person
names, which is what the identity records contain.

## Patch posture at this revision

| Host ID | Outstanding vulnerability | Status |
|---|---|---|
| VAN-SRV-VPN01 | CVE-2026-3117 | Remediated 2026-03-12 by upgrade to 7.2.6 |
| VAN-SRV-APP12 | CVE-2026-3171 | Outstanding; Kestrel HRIS 9.4.4 not yet applied |
| VAN-SRV-BLD02 | none | Rebuilt from known-good image 2026-03-17 |
| VAN-WKS-2210 | none | Re-imaged 2026-03-01 |

Only one host in the estate carries an outstanding vulnerability at this revision, and it is
VAN-SRV-APP12.

## Accuracy statement

Revision 2 is accurate as at 2026-03-16. It replaces Revision 1 in full. Where the two
revisions disagree, Revision 2 is correct and Revision 1 describes a state that no longer
exists. The most significant disagreement is the version of the remote access concentrator.
