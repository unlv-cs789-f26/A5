---
id: ti-infrastructure
type: threat_intel
date: 2026-03-10
title: Threat Intelligence - SILVER TAMARIN Infrastructure Indicators
---

# SILVER TAMARIN Infrastructure Indicators

Indicator set circulated 2026-03-10. Every indicator below is attributed to SILVER TAMARIN
with moderate confidence unless stated otherwise.

## Network indicators

| Indicator | Type | Role | First seen |
|---|---|---|---|
| 198.51.100.77 | IPv4 | Command and control | 2026-02-28 |
| cdn-metrics-eu.example.net | domain | Command and control, resolves to 198.51.100.77 | 2026-02-27 |
| 203.0.113.19 | IPv4 | Scanning and exploitation source | 2026-01-30 |
| storage.driftbox-cdn.example.com | domain | Commodity cloud storage, exfiltration | 2026-03-19 |

## Host indicators

| Indicator | Type | Notes |
|---|---|---|
| 3b1f7c9a4e0d2a6b8f5c1d3e7a9b0c2d4e6f8a1b3c5d7e9f0a2b4c6d8e0f1a35 | SHA-256 | Lorenzo Loader, deployed as svcmon.exe |
| 7c2e0b5d9a13f846e2c7b0d5a9f3e18c6b402d7f9a1e5c3b8d06f24a7e91b0c3 | SHA-256 | Weaponised spreadsheet, ledger_q1_adjustments.xlsm |
| SvcMon/1.0 | User-Agent | Beacon user agent |
| MetricsUpload | Scheduled task name | Beacon persistence |

## Attribution notes

The command and control address 198.51.100.77 is attributed to SILVER TAMARIN. It is the
address that the beacon on the affected engineering workstation contacted.

The scanning source 203.0.113.19 is attributed to SILVER TAMARIN scanning infrastructure and
is the source of the CVE-2026-3117 probing recorded against the Vandelay remote access
concentrator.

The cloud storage endpoint storage.driftbox-cdn.example.com is a shared commodity service.
Its appearance is attributed to SILVER TAMARIN only in combination with the rclone user
agent and the matching archive size.

## Indicator handling guidance

Network indicators in this set are suitable for blocking. Host indicators are suitable for
hunting and for retrospective search. The user agent and scheduled task name are weak
indicators on their own and should be used only in combination.

The commodity cloud storage endpoint must not be blocked outright without a business review;
it is a shared service used legitimately by other organisations and, at Vandelay, by one
marketing workflow.

## Retrospective search results at Vandelay

| Indicator | Earliest sighting at Vandelay | Source |
|---|---|---|
| 203.0.113.19 | 2026-02-19 | Perimeter IDS |
| 198.51.100.77 | 2026-02-27 | Web proxy |
| cdn-metrics-eu.example.net | 2026-02-27 | DNS resolver logs |
| SvcMon/1.0 | 2026-03-01 | Perimeter IDS |
| storage.driftbox-cdn.example.com | 2026-03-21 | Web proxy |

The retrospective search covered ninety days of retained telemetry. No sighting of any
indicator predates 2026-02-19.

## Confidence per indicator

The command and control address and its associated domain are attributed with moderate
confidence, on the strength of passive DNS overlap with three prior SILVER TAMARIN intrusions
and the reuse of the same beacon interval and user agent.

The scanning source is attributed with moderate confidence. It has also been used by at least
one unrelated commodity scanning operation, so its presence alone does not establish SILVER
TAMARIN involvement.

The two file hashes are attributed with high confidence. Lorenzo Loader has not been observed
outside SILVER TAMARIN operations.

## Expiry

Network indicators in this set expire for blocking purposes ninety days after first sighting
unless re-confirmed. File hashes do not expire.
