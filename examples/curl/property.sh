#!/usr/bin/env bash
# ImmobilienScout24 Property API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./property.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/immobilienscout24/property" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=168052908
