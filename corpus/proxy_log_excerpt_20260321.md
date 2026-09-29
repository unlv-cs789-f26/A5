---
id: proxy-log-20260321
type: log
date: 2026-03-21
title: Web Proxy Log Excerpt - 2026-03-21
---

# Web Proxy Log Excerpt - 2026-03-21

Excerpt covering 03:50 to 04:20 UTC, filtered to uploads larger than 100 MB.

```
03:52:41Z src=10.20.4.13 (VAN-SRV-FILE03) host=storage.driftbox-cdn.example.com
          method=PUT bytes_out=268435456 status=200 ua="rclone/1.66"
03:57:18Z src=10.20.4.13 (VAN-SRV-FILE03) host=storage.driftbox-cdn.example.com
          method=PUT bytes_out=268435456 status=200 ua="rclone/1.66"
04:02:55Z src=10.20.4.13 (VAN-SRV-FILE03) host=storage.driftbox-cdn.example.com
          method=PUT bytes_out=268435456 status=200 ua="rclone/1.66"
04:07:30Z src=10.20.4.13 (VAN-SRV-FILE03) host=storage.driftbox-cdn.example.com
          method=PUT bytes_out=268435456 status=200 ua="rclone/1.66"
04:12:06Z src=10.20.4.13 (VAN-SRV-FILE03) host=storage.driftbox-cdn.example.com
          method=PUT bytes_out=430941184 status=200 ua="rclone/1.66"
```

## Notes

Five PUT requests totalling approximately 1.4 GB from 10.20.4.13, which the asset inventory
maps to VAN-SRV-FILE03. The destination `storage.driftbox-cdn.example.com` is a commodity
cloud storage endpoint and was not on any blocklist at the time.

No traffic to 198.51.100.77 appears in this window; that address was blocked at the
perimeter on 2026-03-11.

The user agent `rclone/1.66` is not part of the Vandelay standard software build.

## Session summary

| Field | Value |
|---|---|
| Source | 10.20.4.13 |
| Destination host | storage.driftbox-cdn.example.com |
| Requests | 5 PUT |
| Total bytes out | 1,504,682,496 |
| Window | 03:52:41Z to 04:12:06Z |
| Duration | 19 minutes 25 seconds |
| Status codes | 200 on every request |
| User agent | rclone/1.66 |
| Proxy category | cloud storage, not blocked |
| Authenticated proxy user | the domain account of the file server session |

Four requests carry exactly 268,435,456 bytes, which is 256 MiB, and the fifth carries the
remainder. A fixed 256 MiB chunk size is the default multipart chunk for several transfer
utilities and is consistent with a single logical object of approximately 1.4 GB.

## Preceding and following activity

The thirty minutes before 03:52 UTC contain no requests from 10.20.4.13 other than routine
operating system telemetry. The thirty minutes after 04:12 UTC contain no requests from that
source at all. There is no reconnaissance of the destination, no test upload and no cleanup
traffic; the transfer starts cold and stops cleanly.

## Comparison with the blocked command and control channel

The command and control address 198.51.100.77 was blocked at the perimeter on 2026-03-11 and
appears nowhere in the proxy record for 2026-03-21. The actor did not attempt to reach it.
Exfiltration used a separate, previously unused destination, which is why the perimeter block
had no effect on this transfer.

## Proxy policy at the time

The web proxy blocks by category and by explicit blocklist. Cloud storage is not a blocked
category at Vandelay because several business workflows depend on it. There is no upload size
limit, no per-destination volume limit and no alert on unusual user agents. The only control
that fired was the cumulative outbound volume rule, and it fired after the transfer finished.
