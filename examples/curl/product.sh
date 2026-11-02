#!/usr/bin/env bash
# Rappi Product API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./product.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/rappi/product" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=https://www.rappi.com.mx/p/santa-clara-leche-deslactosada-semi-14069
