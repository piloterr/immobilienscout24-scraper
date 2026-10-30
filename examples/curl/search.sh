#!/usr/bin/env bash
# ImmobilienScout24 Search API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./search.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/immobilienscout24/search" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=berlin/berlin
