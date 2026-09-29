#!/usr/bin/env bash
# Option 2 for Part C: Neo4j Community Edition inside the Colab runtime (no account needed).
# It disappears when the runtime ends. Password: cs789-a5-local   Bolt: bolt://localhost:7687
set -e
if ! command -v neo4j >/dev/null 2>&1; then
  mkdir -p /etc/apt/keyrings
  wget -qO- https://debian.neo4j.com/neotechnology.gpg.key | gpg --dearmor --yes -o /etc/apt/keyrings/neotechnology.gpg
  echo 'deb [signed-by=/etc/apt/keyrings/neotechnology.gpg] https://debian.neo4j.com stable latest' > /etc/apt/sources.list.d/neo4j.list
  apt-get -qq update
  DEBIAN_FRONTEND=noninteractive apt-get -qq install -y neo4j > /dev/null
fi
neo4j-admin dbms set-initial-password cs789-a5-local 2>/dev/null || true
# APOC core ships in labs/: LangChain's Neo4jGraph needs apoc.meta.data() to read the schema
if ! ls /var/lib/neo4j/plugins/apoc-*-core.jar >/dev/null 2>&1; then
  cp /var/lib/neo4j/labs/apoc-*-core.jar /var/lib/neo4j/plugins/
  echo 'dbms.security.procedures.unrestricted=apoc.*' >> /etc/neo4j/neo4j.conf
fi
neo4j restart >/dev/null 2>&1 || neo4j start
for i in $(seq 1 60); do
  (echo > /dev/tcp/127.0.0.1/7687) 2>/dev/null && { echo "Neo4j is up: bolt://localhost:7687 (neo4j / cs789-a5-local)"; exit 0; }
  sleep 2
done
echo "Neo4j did not start; see /var/log/neo4j/ and 'neo4j console'"; exit 1
