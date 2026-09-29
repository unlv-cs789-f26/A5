---
id: asset-inventory-v1
type: inventory
date: 2026-02-10
title: Vandelay Industries Asset Inventory (Revision 1)
superseded_by: asset-inventory-v2
status: outdated
---

# Asset Inventory - Revision 1

Maintained by IT Operations. Revision 1 is the baseline snapshot taken at the start of
the Q1 review window. **This revision is superseded by Revision 2 dated 2026-03-16 and
must not be used for patch decisions.**

| Host ID | Role | Software / Version | Segment | Primary Owner |
|---|---|---|---|---|
| VAN-WKS-4471 | Finance workstation | Windows 11 23H2 | SEG-FIN-CORE | Marcus Delgado |
| VAN-WKS-2210 | Engineering workstation | Windows 11 23H2 | SEG-ENG | Priya Raman |
| VAN-LAP-0912 | Contractor laptop | Windows 11 22H2 | SEG-CORP | Dana Whitfield |
| VAN-SRV-DB07 | Meridian Payroll DB | MSSQL 2022 | SEG-FIN-CORE | Tomas Berger |
| VAN-SRV-APP12 | Kestrel HRIS application | Kestrel HRIS 9.4.2 | SEG-APP-DMZ | Nadia Kovac |
| VAN-SRV-VPN01 | Remote access concentrator | Aperture SecureEdge VPN 7.2.1 | SEG-EDGE | Rachel Ocampo |
| VAN-SRV-FILE03 | Corporate file server | Windows Server 2022 | SEG-CORP | Rachel Ocampo |
| VAN-SRV-JMP01 | Administrative jump host | Windows Server 2022 | SEG-MGMT | Alan Ferris |
| VAN-SRV-BLD02 | Continuous integration build server | Foundry CI 4.8 | SEG-ENG | Priya Raman |

## Notes at Revision 1

VAN-SRV-VPN01 runs Aperture SecureEdge VPN 7.2.1 and has not been patched since the
appliance was commissioned in 2025. IT Operations has flagged it for an upgrade in the
Q1 maintenance window but no change record exists yet.

VAN-SRV-BLD02 was migrated into SEG-ENG in January 2026 and still carries a temporary
firewall exception permitting inbound 22/tcp and 8080/tcp from SEG-CORP.

Two hosts sit in SEG-FIN-CORE at this revision: VAN-WKS-4471 and VAN-SRV-DB07.

Contractor equipment is tracked separately in the Nimbus Consulting Group engagement
record. VAN-LAP-0912 is the only contractor-issued device currently active.

## Ownership model

"Primary owner" is the person accountable for the asset, and for a workstation or laptop it
is the person to whom the device is issued and who logs on interactively. For a server it is
the operational owner, who may be different from the business owner of the data the server
holds.

VAN-WKS-4471 is issued to Marcus Delgado and sits on his desk in the Finance area. He is its
only interactive user. VAN-WKS-2210 is issued to Priya Raman on the same basis.
VAN-LAP-0912 is issued to Dana Whitfield from the contractor pool.

The primary owner recorded here is the join key between an alert, which names a host, and the
identity records, which name a person. Alerts do not carry owner names, and the identity
records do not carry host identifiers, so this table is the only place the two meet.

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

## Why this revision is retained

Revision 1 is retained only for audit purposes. It records the state of the estate before
the March remediation and is the correct reference for any question about February 2026.
It is the wrong reference for any question about the present state of the estate. Anyone
asking what software a host runs today must use Revision 2.
