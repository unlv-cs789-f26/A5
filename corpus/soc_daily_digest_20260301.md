---
id: soc-daily-digest-20260301
type: alert_export
date: 2026-03-01
title: SOC Daily Digest - 2026-03-01 (near-duplicate of the IDS export)
---

# SOC Daily Digest - 2026-03-01

Digest circulated to the SOC distribution list. Content is drawn from the perimeter IDS
export covering 00:00 to 23:59 UTC on 2026-03-01, filtered to severity 3 and above.

```
ts=2026-03-01T06:41:12Z sid=2038117 sev=3 msg="ET POLICY Periodic HTTPS beacon pattern"
    src=10.40.12.55 (VAN-WKS-2210) dst=198.51.100.77 dport=443 count=14
ts=2026-03-01T09:12:44Z sid=2019401 sev=4 msg="ET TROJAN Suspicious User-Agent (SvcMon/1.0)"
    src=10.40.12.55 (VAN-WKS-2210) dst=198.51.100.77 dport=443 count=3
ts=2026-03-01T11:02:19Z sid=2101922 sev=3 msg="ET SCAN Aperture SecureEdge management probe"
    src=203.0.113.19 dst=10.10.0.4 (VAN-SRV-VPN01) dport=8443 count=27
ts=2026-03-01T18:55:31Z sid=2038117 sev=3 msg="ET POLICY Periodic HTTPS beacon pattern"
    src=10.40.12.55 (VAN-WKS-2210) dst=198.51.100.77 dport=443 count=61
```

## Digest notes

The beacon signature 2038117 fired 89 times across the day, all from 10.40.12.55, which the
asset inventory maps to VAN-WKS-2210. The destination in every case was 198.51.100.77.

Signature 2101922 fired against the remote access concentrator from 203.0.113.19, the same
source address recorded in INC-2026-042 eleven days earlier.

Kenji Watanabe opened INC-2026-044 from this digest at 06:55 UTC.

## Signature reference

| Signature | Name | Severity | Firings on 2026-03-01 |
|---|---|---|---|
| 2038117 | ET POLICY Periodic HTTPS beacon pattern | 3 | 89 |
| 2019401 | ET TROJAN Suspicious User-Agent (SvcMon/1.0) | 4 | 3 |
| 2101922 | ET SCAN Aperture SecureEdge management probe | 3 | 27 |
| 2044810 | ET INFO Observed DNS query to dynamic DNS domain | 1 | 412 |
| 2013028 | ET POLICY Cleartext credentials over HTTP | 2 | 0 |

Only signatures at severity 3 and above appear in the packet listing above. Signature 2044810
fired 412 times at severity 1 and is excluded; it is a routine informational signature that
fires on ordinary business traffic and is not associated with this campaign.

## Interval analysis

The interval between consecutive firings of signature 2038117 clusters tightly around 293
seconds. Over the 89 firings the mean interval is 293.4 seconds with a standard deviation of
19.6 seconds. Human-driven traffic does not produce that distribution. Automated business
traffic can, but no scheduled business process on the affected host targets an external
address on that cadence.

## What the export does not contain

The IDS sees TLS metadata only. It has no visibility into request or response bodies, so the
export cannot say what was sent or received. Volume and timing are the only evidence
available from this source. Confirming what the beacon carried would require endpoint
telemetry or a decrypting proxy, and Vandelay operates neither for this segment.
