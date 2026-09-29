---
id: inc-2026-049
type: incident
date: 2026-04-02
title: INC-2026-049 - Blocked cloud upload attempt from the build server
---

# INC-2026-049

**Opened:** 2026-04-02 02:18 UTC
**Closed:** 2026-04-03 16:30 UTC
**Severity:** High
**Reporting analyst:** Sofia Brandt (Tier 2)

## Summary

At 02:11 UTC the perimeter proxy refused three PUT requests from VAN-SRV-BLD02 to the same
commodity cloud storage service used in INC-2026-048. The requests carried the user agent
`rclone/1.66`, identical to the transfer that exfiltrated 1.4 GB from VAN-SRV-FILE03. No data
left the network: the destination domain had been on the block list since 2026-03-21.

## Affected hosts

- **VAN-SRV-BLD02** - source of the refused requests.

## Techniques observed

- T1567.002 Exfiltration Over Web Service: Exfiltration to Cloud Storage (attempted, blocked).

## Analyst notes

`rclone.exe` was found under a temporary build workspace on VAN-SRV-BLD02, created at
2026-04-01 23:47 UTC by a scheduled build job that had been edited on 2026-03-30. The edit was
made with a service account token that was rotated after INC-2026-047 but not revoked on the
build server's own credential cache. The job was disabled, the cached token was purged, and the
host was re-imaged on 2026-04-03.

This is the first activity linked to the campaign after the exfiltration in INC-2026-048, and it
shows the actor retained a foothold on the build server after the contractor laptop was
recovered.

## Timeline

| Time (UTC) | Event |
|---|---|
| 2026-03-30 | Scheduled build job modified with a cached service account token |
| 2026-04-01 23:47 | `rclone.exe` written to a temporary build workspace |
| 2026-04-02 02:11 | Three PUT requests refused by the perimeter proxy |
| 2026-04-02 02:18 | Proxy alert; ticket opened |
| 2026-04-03 16:30 | Host re-imaged, token purged, ticket closed |
