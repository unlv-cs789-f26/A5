---
id: network-segments
type: reference
date: 2026-02-11
title: Vandelay Industries Network Segmentation Model
---

# Network Segmentation Model

Vandelay Industries operates six routed segments behind a single perimeter firewall pair.
Segment-to-segment traffic is default-deny; every permitted flow below is an explicit rule.

## Segments

- **SEG-EDGE** - Internet-facing DMZ. Contains the remote access concentrator. All inbound
  remote access sessions terminate here before being forwarded.
- **SEG-CORP** - General corporate LAN. Laptops, the corporate file server, printers.
  Remote access sessions from SEG-EDGE are forwarded into SEG-CORP by default.
- **SEG-ENG** - Engineering network. Engineering workstations and the continuous
  integration build server.
- **SEG-FIN-CORE** - Finance core. The most restricted user-facing segment. Holds the
  Meridian Payroll DB and finance workstations.
- **SEG-APP-DMZ** - Internal application tier hosting the Kestrel HRIS application.
- **SEG-MGMT** - Management network. Contains the administrative jump host. SEG-MGMT can
  reach every other segment; no segment can initiate a connection into SEG-MGMT except
  from an authenticated administrative session.

## Permitted inter-segment flows

| Source | Destination | Ports | Notes |
|---|---|---|---|
| SEG-EDGE | SEG-CORP | 445, 3389, 443 | Default landing zone for remote access |
| SEG-CORP | SEG-ENG | 22, 8080 | Temporary exception for the build server |
| SEG-CORP | SEG-APP-DMZ | 443 | HRIS web access |
| SEG-FIN-CORE | SEG-FIN-CORE | 1433 | Payroll database access is intra-segment only |
| SEG-MGMT | any | any | Administrative jump host |

A remote access session that lands in SEG-CORP cannot reach SEG-FIN-CORE directly. Reaching
the Meridian Payroll DB requires either a host already inside SEG-FIN-CORE or a session
relayed through the administrative jump host in SEG-MGMT.

## Remote access path in detail

A remote user authenticates to the concentrator in SEG-EDGE. On success the session is
assigned an address inside SEG-CORP and is thereafter treated as a corporate LAN host for
firewall purposes. There is no per-user segmentation at the network layer; every remote
session lands in the same place regardless of who the user is. Differentiation between users
is done at the directory layer, by group membership, and not here.

The single exception is the contractor exception recorded in the Q1 access review, which
extends contractor remote sessions into SEG-ENG. That exception is implemented as a firewall
rule keyed on the address pool assigned to contractor sessions, not on identity.

## Reaching the finance core

SEG-FIN-CORE accepts inbound connections on 1433/tcp only from within SEG-FIN-CORE itself and
from SEG-MGMT. It accepts nothing from SEG-CORP, SEG-ENG, SEG-EDGE or SEG-APP-DMZ. In
practice this means there are exactly two ways to reach the Meridian Payroll DB: from a host
that already sits in SEG-FIN-CORE, or by relaying through the administrative jump host in
SEG-MGMT.

Both routes require credentials that the database itself will accept, so the network path is
necessary but not sufficient. An attacker holding a session inside SEG-CORP has neither.

## Egress

All segments may initiate outbound HTTPS on 443/tcp through the web proxy. There is no
allowlist; the proxy blocks only categories and explicitly blocklisted destinations. This is
the reason a bulk upload to a commodity cloud storage provider from SEG-CORP is permitted by
policy, and it is the control gap that the campaign post-incident review recommends closing.

## Change history

The temporary exception permitting 22/tcp and 8080/tcp from SEG-CORP into SEG-ENG was added
on 2026-01-08 to support the build pipeline modernisation engagement. It was documented as
temporary with an intended life of six weeks. It was still in place at the end of March 2026.
