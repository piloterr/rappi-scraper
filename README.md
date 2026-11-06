<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="Rappi Scraper API by Piloterr – scrape Rappi data as JSON" width="100%"></a>
</p>

# Rappi Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr Rappi Scraper API** lets you extract public data from Rappi as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **Rappi Product API** — Fetch one Rappi Mexico product, including the primary store price and the other store offers.
- **Rappi Search API** — Search Rappi Mexico on rappi.com.mx.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [Rappi Product API](#rappi-product-api) | `/v2/rappi/product` | 1 | Fetch one Rappi Mexico product, including the primary store price and the other store offers. The primary price can differ from a search card. |
| [Rappi Search API](#rappi-search-api) | `/v2/rappi/search` | 1 | Search Rappi Mexico on rappi.com.mx. The city resolves to Mexico City. Each row is one store offer, and next is null. |

## Table of contents

- [How it works](#how-it-works)
- [Rappi Product API](#rappi-product-api)
- [Rappi Search API](#rappi-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Official SDKs](#official-sdks)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## Rappi Product API

Fetch one Rappi Mexico product, including the primary store price and the other store offers. The primary price can differ from a search card.

`GET | POST https://api.piloterr.com/v2/rappi/product` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. Product URL on rappi.com.mx, example https://www.rappi.com.mx/p/santa-clara-leche-deslactosada-semidescremada-1-l-14069, or a numeric master id such as 14069. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/rappi/product",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.rappi.com.mx/p/santa-clara-leche-deslactosada-semi-14069",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type RappiProduct = {
  url?: string;
  city?: string;
  name?: string;
  image?: string;
  price?: number;
  offers?: {
    price?: number;
    currency?: string;
    in_stock?: boolean;
    store_id?: number;
    store_url?: string;
    store_name?: string;
    has_discount?: boolean;
    price_display?: string;
    original_price?: unknown;
  }[];
  category?: string;
  currency?: string;
  in_stock?: boolean;
  store_id?: number;
  store_url?: string;
  unit_type?: string;
  product_id?: string;
  store_name?: string;
  unit_price?: string;
  description?: string;
  has_discount?: boolean;
  max_quantity?: number;
  min_quantity?: number;
  presentation?: string;
  price_display?: string;
  original_price?: unknown;
  master_product_id?: number;
  alcoholic_beverage?: boolean;
  has_age_restriction?: boolean;
  [key: string]: unknown;
};

const params = new URLSearchParams({
  "query": "https://www.rappi.com.mx/p/santa-clara-leche-deslactosada-semi-14069",
});

const response = await fetch(`https://api.piloterr.com/v2/rappi/product?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as RappiProduct;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/rappi/product
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.rappi.com.mx/p/santa-clara-leche-deslactosada-semi-14069"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "url": "https://www.rappi.com.mx/p/santa-clara-leche-deslactosada-semi-14069",
  "city": "Ciudad de México",
  "name": "Santa Clara Leche Deslactosada Semidescremada 1 L",
  "image": "https://images.rappi.com.mx/products/40efda20-78c9-4351-b9e1-a860ab740866.png",
  "price": 33,
  "offers": [
    {
      "price": 33,
      "currency": "MXN",
      "in_stock": true,
      "store_id": 1930460513,
      "store_url": "https://www.rappi.com.mx/tiendas/1930460513-city-market",
      "store_name": "City Market",
      "has_discount": false,
      "price_display": "$33.00",
      "original_price": null
    },
    {
      "price": 33,
      "currency": "MXN",
      "in_stock": true,
      "store_id": 1930301321,
      "store_url": "https://www.rappi.com.mx/tiendas/1930301321-la-comer",
      "store_name": "La Comer",
      "has_discount": false,
      "price_display": "$33.00",
      "original_price": null
    }
  ],
  "category": "Leche natural",
  "currency": "MXN",
  "in_stock": true,
  "store_id": 1930460513,
  "store_url": "https://www.rappi.com.mx/tiendas/1930460513-city-market",
  "unit_type": "l",
  "product_id": "975243808",
  "store_name": "City Market",
  "unit_price": "$0.0330/ml",
  "description": "Esta leche te aporta la misma cantidad de calcio, vitaminas y proteínas que la leche normal, pero sin lactosa. Tiene menor porcentaje de …",
  "has_discount": false,
  "max_quantity": 21,
  "min_quantity": 1,
  "presentation": "1 X 1 L",
  "price_display": "$33.00",
  "original_price": null,
  "master_product_id": 14069,
  "alcoholic_beverage": false,
  "has_age_restriction": false
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `url` | string |  |
| `city` | string |  |
| `name` | string |  |
| `image` | string |  |
| `price` | integer |  |
| `offers[]` | object[] |  |
| `offers[].price` | integer |  |
| `offers[].currency` | string |  |
| `offers[].in_stock` | boolean |  |
| `offers[].store_id` | integer |  |
| `offers[].store_url` | string |  |
| `offers[].store_name` | string |  |
| `offers[].has_discount` | boolean |  |
| `offers[].price_display` | string |  |
| `offers[].original_price` | object |  |
| `category` | string |  |
| `currency` | string |  |
| `in_stock` | boolean |  |
| `store_id` | integer |  |
| `store_url` | string |  |
| `unit_type` | string |  |
| `product_id` | string |  |
| `store_name` | string |  |
| `unit_price` | string |  |
| `description` | string |  |

## Rappi Search API

Search Rappi Mexico on rappi.com.mx. The city resolves to Mexico City. Each row is one store offer, and next is null.

`GET | POST https://api.piloterr.com/v2/rappi/search` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. Keyword, example leche, or a rappi.com.mx search URL such as https://www.rappi.com.mx/search?query=leche. A product URL or another country host is rejected. |
| `page` | number | — | Optional. Only page 1 returns rows. Example: 1. Defaults to 1. Page 2 is rejected because the payload has no next page. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/rappi/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "leche",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type RappiSearch = {
  results?: {
    eta?: string;
    url?: string;
    name?: string;
    image?: string;
    price?: number;
    currency?: string;
    in_stock?: boolean;
    store_id?: number;
    store_url?: string;
    unit_type?: string;
    product_id?: string;
    store_name?: string;
    unit_price?: string;
    has_discount?: boolean;
    price_display?: string;
    shipping_cost?: number;
    original_price?: unknown;
    store_promotion?: string;
    has_free_shipping?: boolean;
    master_product_id?: number;
  }[];
  pagination?: {
    next?: unknown;
    page?: number;
    per_page?: number;
    total_pages?: unknown;
    total_results?: unknown;
  };
};

const params = new URLSearchParams({
  "query": "leche",
});

const response = await fetch(`https://api.piloterr.com/v2/rappi/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as RappiSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/rappi/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "leche"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "eta": "9 - 12 min",
      "url": "https://www.rappi.com.mx/p/santa-clara-leche-deslactosada-semidescremada-1-l-14069",
      "name": "Santa Clara Leche Deslactosada Semidescremada 1 L",
      "image": "https://images.rappi.com.mx/products/40efda20-78c9-4351-b9e1-a860ab740866.png?e=webp&q=80&d=130x130",
      "price": 35.9,
      "currency": "MXN",
      "in_stock": true,
      "store_id": 1923301762,
      "store_url": "https://www.rappi.com.mx/tiendas/1923301762",
      "unit_type": "l",
      "product_id": "2109993478",
      "store_name": "Turbo Fresh-Angel Independencia",
      "unit_price": "0.0359/ml",
      "has_discount": false,
      "price_display": "$35.90",
      "shipping_cost": 25,
      "original_price": null,
      "store_promotion": "Hasta 42% Off",
      "has_free_shipping": false,
      "master_product_id": 14069
    }
  ],
  "pagination": {
    "next": null,
    "page": 1,
    "per_page": 208,
    "total_pages": null,
    "total_results": null
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].eta` | string |  |
| `results[].url` | string |  |
| `results[].name` | string |  |
| `results[].image` | string |  |
| `results[].price` | number |  |
| `results[].currency` | string |  |
| `results[].in_stock` | boolean |  |
| `results[].store_id` | integer |  |
| `results[].store_url` | string |  |
| `results[].unit_type` | string |  |
| `results[].product_id` | string |  |
| `results[].store_name` | string |  |
| `results[].unit_price` | string |  |
| `results[].has_discount` | boolean |  |
| `results[].price_display` | string |  |
| `results[].shipping_cost` | integer |  |
| `results[].original_price` | object |  |
| `results[].store_promotion` | string |  |
| `results[].has_free_shipping` | boolean |  |
| `results[].master_product_id` | integer |  |
| `pagination` | object |  |
| `pagination.next` | object |  |
| `pagination.page` | integer |  |
| `pagination.per_page` | integer |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Product | Search |
|---|---|---|
| cURL (Bash) | [`product`](examples/curl/product.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`product`](examples/php/product.php) | [`search`](examples/php/search.php) |
| C# | [`product`](examples/csharp/Product.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`product`](examples/go/product.go) | [`search`](examples/go/search.go) |
| Java | [`product`](examples/java/ProductExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`product`](examples/ruby/product.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`product`](examples/nodejs/product.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — Rappi plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape Rappi?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/rappi/product` **1**, `/v2/rappi/search` **1**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the Rappi API return?

Each endpoint returns structured JSON: **Rappi Product** — `url`, `city`, `name`, `image`, `price`, `offers[]`; **Rappi Search** — `results[]`, `results[].eta`, `results[].url`, `results[].name`, `results[].image`, `results[].price`.

### How do I paginate Rappi results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Official SDKs

Use Piloterr from your own language with a typed client:

| SDK | Package | Install |
| --- | --- | --- |
| Node.js | [`@piloterr/sdk`](https://www.npmjs.com/package/@piloterr/sdk) | `npm install @piloterr/sdk` |
| Python | [`piloterr`](https://pypi.org/project/piloterr/) | `pip install piloterr` |
| Go | [`piloterr-go`](https://pkg.go.dev/github.com/piloterr/piloterr-go) | `go get github.com/piloterr/piloterr-go` |
| .NET | [`Piloterr`](https://www.nuget.org/packages/Piloterr) | `dotnet add package Piloterr` |
| Ruby | [`piloterr`](https://rubygems.org/gems/piloterr) | `gem install piloterr` |
| PHP | [`piloterr/sdk`](https://packagist.org/packages/piloterr/sdk) | `composer require piloterr/sdk` |
| Java | [`piloterr-java`](https://github.com/piloterr/piloterr-java) | build from source, see its README |
| CLI | [`@piloterr/cli`](https://www.npmjs.com/package/@piloterr/cli) | `npm install -g @piloterr/cli` |
| MCP server | [`@piloterr/mcp`](https://www.npmjs.com/package/@piloterr/mcp) | `npx -y @piloterr/mcp` |

## Related scrapers

- [About You Scraper API](https://github.com/piloterr/aboutyou-scraper)
- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Aldi Scraper API](https://github.com/piloterr/aldi-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>Rappi is a trademark of its respective owner. This repository is not affiliated with or endorsed by Rappi. Examples are released under the MIT license.</sub>
