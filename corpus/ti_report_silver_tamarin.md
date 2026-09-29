---
id: ti-silver-tamarin
type: threat_intel
date: 2026-02-26
title: Threat Intelligence Report - SILVER TAMARIN
---

# Threat Intelligence Report: SILVER TAMARIN

Prepared by the Vandelay threat intelligence function. Confidence: moderate.

## Overview

SILVER TAMARIN is a financially motivated intrusion set active since mid-2024, targeting
mid-size professional services and manufacturing organisations in Europe and North America.
The group is assessed to be a criminal enterprise rather than a state-directed actor.

## Tradecraft

SILVER TAMARIN uses two initial access routes:

1. Spearphishing with macro-enabled spreadsheet attachments (T1566.001), typically themed
   around finance and payroll documents.
2. Exploitation of internet-facing remote access appliances (T1190). The group has been
   observed exploiting CVE-2026-3117 in Aperture SecureEdge VPN since February 2026.

After access the group reliably performs:

- T1059.001 PowerShell for staging.
- T1552.001 Unsecured Credentials: Credentials In Files, reading browser credential stores.
- T1003.001 OS Credential Dumping: LSASS Memory, using a renamed commodity dumper.
- T1547.001 Registry Run Keys / Startup Folder and T1053.005 Scheduled Task for persistence.
- T1078.002 Valid Accounts: Domain Accounts for lateral movement, preferring stolen
  credentials over exploits once inside.
- T1021.001 Remote Desktop Protocol for interactive movement.
- T1071.001 Application Layer Protocol: Web Protocols for command and control.
- T1567.002 Exfiltration to Cloud Storage, using commodity providers and the rclone utility.

SILVER TAMARIN has never been observed deploying ransomware or encrypting victim data.

## Tooling

The group's loader is tracked as Lorenzo Loader, and Lorenzo Loader is used exclusively by
SILVER TAMARIN in current reporting. It is usually delivered as a renamed executable that
mimics a monitoring or telemetry service name.

## Assessment

The techniques recorded across the Vandelay incidents of February and March 2026 match the
SILVER TAMARIN pattern in sequence and in tooling.

## Victimology

Reporting from three commercial intelligence vendors places SILVER TAMARIN's victim set in
professional services, light manufacturing and regional healthcare administration, in
organisations between 200 and 3,000 employees. The group appears to select victims
opportunistically from internet-facing appliance scanning and then to qualify them by
revenue before investing effort. Vandelay Industries fits the profile on size and sector.

## Operating rhythm

Intrusions attributed to the group typically run four to eight weeks from initial access to
exfiltration. The group is patient between stages: staged archives have been observed sitting
untouched on victim hosts for two to three weeks before transfer. This patience is
distinctive and is one of the features that separates SILVER TAMARIN from the smash-and-grab
intrusion sets operating in the same space.

The group prefers to move with stolen credentials rather than exploits once it has a foothold,
which suppresses the exploit-shaped detections most organisations tune for.

## What the group does not do

SILVER TAMARIN has never been observed deploying ransomware, encrypting victim data, or
posting victim names to a leak site. It has not been observed destroying data or interfering
with availability. It has not been observed targeting operational technology. Its monetisation
route is assessed with low confidence to be the resale of stolen documents rather than direct
extortion; no extortion demand attributed to the group has been recovered by any vendor.

## Confidence and gaps

Confidence in the technique set is high, being drawn from multiple independent incident
responses. Confidence in the attribution of any individual piece of infrastructure is moderate
and depends on the indicator. Confidence in the motivation assessment is low.

There is no public reporting linking SILVER TAMARIN to a nation state, and no vendor has
published a country of origin with more than low confidence.

## Relevance to Vandelay

Every technique in the tradecraft section above except ingress tool transfer appears in the
Vandelay incident tickets of February and March 2026. The sequence matches: phishing into a
finance function, credential access, persistence, beaconing, credential-based lateral movement,
staging, then a single bulk transfer to commodity cloud storage after a delay.
