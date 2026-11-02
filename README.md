<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="ImmobilienScout24 Scraper API by Piloterr – scrape ImmobilienScout24 data as JSON" width="100%"></a>
</p>

# ImmobilienScout24 Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr ImmobilienScout24 Scraper API** lets you extract public data from ImmobilienScout24 as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **ImmobilienScout24 Property API** — Read one ImmobilienScout24 expose by URL or numeric id.
- **ImmobilienScout24 Search API** — Search ImmobilienScout24 by region and property type.

Use it for property price monitoring, market analytics, investment sourcing or rental yield models.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [ImmobilienScout24 Property API](#immobilienscout24-property-api) | `/v2/immobilienscout24/property` | 2 | Read one ImmobilienScout24 expose by URL or numeric id. You get cold rent or purchase price, address, and area. |
| [ImmobilienScout24 Search API](#immobilienscout24-search-api) | `/v2/immobilienscout24/search` | 2 | Search ImmobilienScout24 by region and property type. real_estate_type covers rent, buy, house, and land. Page with pagenumber. |

## Table of contents

- [How it works](#how-it-works)
- [ImmobilienScout24 Property API](#immobilienscout24-property-api)
- [ImmobilienScout24 Search API](#immobilienscout24-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
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

## ImmobilienScout24 Property API

Read one ImmobilienScout24 expose by URL or numeric id. You get cold rent or purchase price, address, and area.

`GET | POST https://api.piloterr.com/v2/immobilienscout24/property` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | The expose id, or the expose page URL. |
| `return_page_source` | boolean | — | When true, return the raw HTML in `result` instead of the parsed expose. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/immobilienscout24/property",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "168052908",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type Immobilienscout24Property = {
  id?: string;
  url?: string;
  city?: string;
  floor?: string;
  price?: number;
  rooms?: number;
  title?: string;
  images?: {
    url?: string;
    caption?: string;
  }[];
  street?: string;
  address?: string;
  currency?: string;
  district?: string;
  features?: string[];
  postcode?: string;
  condition?: string;
  attributes?: {
    label?: string;
    value?: string;
  }[];
  offer_type?: string;
  total_rent?: number;
  address_url?: string;
  description?: string;
  contact_name?: string;
  heating_type?: string;
  listing_type?: string;
  living_space?: number;
  realtor_logo?: string;
  [key: string]: unknown;
};

const params = new URLSearchParams({
  "query": "168052908",
});

const response = await fetch(`https://api.piloterr.com/v2/immobilienscout24/property?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as Immobilienscout24Property;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/immobilienscout24/property
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "168052908"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "id": "168052908",
  "url": "https://www.immobilienscout24.de/expose/168052908",
  "city": "Berlin",
  "floor": "0",
  "price": 362,
  "rooms": 2,
  "title": "Naturverbunden wohnen in kompakter 2-Zimmer-Gartenwohnung mit WBS-140-Förderung",
  "images": [
    {
      "url": "https://pictures.immobilienscout24.de/listings/7059e813-0eb0-4e71-82d6-e98b247a3755-2033933665.jpg/ORIG/resize/1106x830%3E/format/webp/qu…",
      "caption": "Außenvisualisierung"
    }
  ],
  "street": "Hellersdorfer Straße 91",
  "address": "Hellersdorfer Straße 91, Hellersdorf, 12619 Berlin",
  "currency": "EUR",
  "district": "Hellersdorf",
  "features": [
    "Wohnberechtigungsschein erforderlich"
  ],
  "postcode": "12619",
  "condition": "Erstbezug",
  "attributes": [
    {
      "label": "Typ",
      "value": "Erdgeschosswohnung"
    },
    {
      "label": "Etage",
      "value": "0"
    }
  ],
  "offer_type": "rent",
  "total_rent": 569,
  "address_url": "https://orte.immobilienscout24.de/adresse/berlin-12619-hellersdorfer-strasse-nr-91",
  "description": "Die Wohnung wird ausschließlich an einen 2-Personen-Haushalt vermietet, dessen Jahres-Netto-Einkommen die Voraussetzungen für einen Wohnb…",
  "contact_name": "example",
  "heating_type": "Fernwärme",
  "listing_type": "XXL",
  "living_space": 51.7,
  "realtor_logo": "https://pictures.immobilienscout24.de/usercontent/c9e73109-7e88-4e3c-9268-6966f3659c90.JPG/ORIG/resize/150x150%3E/quality/73"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `id` | string |  |
| `url` | string |  |
| `city` | string |  |
| `floor` | string |  |
| `price` | integer |  |
| `rooms` | integer |  |
| `title` | string |  |
| `images[]` | object[] |  |
| `images[].url` | string |  |
| `images[].caption` | string |  |
| `street` | string |  |
| `address` | string |  |
| `currency` | string |  |
| `district` | string |  |
| `features` | string[] |  |
| `postcode` | string |  |
| `condition` | string |  |
| `attributes[]` | object[] |  |
| `attributes[].label` | string |  |
| `attributes[].value` | string |  |
| `offer_type` | string |  |
| `total_rent` | integer |  |
| `address_url` | string |  |
| `description` | string |  |
| `contact_name` | string |  |

## ImmobilienScout24 Search API

Search ImmobilienScout24 by region and property type. real_estate_type covers rent, buy, house, and land. Page with pagenumber.

`GET | POST https://api.piloterr.com/v2/immobilienscout24/search` · **2 credits per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Where to search. |
| `real_estate_type` | string | — | Rent or buy. |
| `page` | number | — | Page number, starting at 1. |
| `return_page_source` | boolean | — | When true, return the raw HTML in `result` instead of the parsed JSON. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/immobilienscout24/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "berlin/berlin",
    },
    timeout=120,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type Immobilienscout24Search = {
  results?: {
    id?: string;
    url?: string;
    city?: string;
    tags?: unknown[];
    price?: number;
    rooms?: number;
    title?: string;
    garden?: boolean;
    images?: string[];
    is_new?: boolean;
    street?: string;
    address?: string;
    balcony?: boolean;
    project?: {
      id?: string;
      url?: string;
      name?: string;
      title?: string;
      address?: string;
      price_display?: string;
      available_from?: string;
      living_space_display?: string;
      grouped_listing_count?: number;
    };
    quarter?: string;
    realtor?: string;
    currency?: string;
    latitude?: number;
    postcode?: string;
    floorplan?: boolean;
    longitude?: number;
    offer_type?: string;
    total_rent?: number;
    house_number?: string;
    listing_type?: string;
    [key: string]: unknown;
  }[];
  pagination?: {
    next?: string;
    page?: number;
    per_page?: number;
    total_pages?: number;
    total_results?: number;
  };
};

const params = new URLSearchParams({
  "query": "berlin/berlin",
});

const response = await fetch(`https://api.piloterr.com/v2/immobilienscout24/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as Immobilienscout24Search;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/immobilienscout24/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "berlin/berlin"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "id": "168052908",
      "url": "https://www.immobilienscout24.de/expose/168052908",
      "city": "Berlin",
      "tags": [],
      "price": 362,
      "rooms": 2,
      "title": "Naturverbunden wohnen in kompakter 2-Zimmer-Gartenwohnung mit WBS-140-Förderung",
      "garden": false,
      "images": [
        "https://pictures.immobilienscout24.de/listings/7059e813-0eb0-4e71-82d6-e98b247a3755-2033933665.jpg/ORIG/legacy_thumbnail/800x600/format/w…"
      ],
      "is_new": false,
      "street": "Hellersdorfer Straße",
      "address": "Hellersdorfer Straße 91, Hellersdorf, Berlin",
      "balcony": false,
      "project": {
        "id": "147913",
        "url": "https://www.immobilienscout24.de/neubau/gesobau-ag/cecilien-carr/147913.html",
        "name": "Cecilien-Carré",
        "title": "Moderne Neubauwohnungen im grünen Berlin-Hellersdorf – WBS 220 erforderlich",
        "address": "Hellersdorfer Straße 91, 12619 Berlin",
        "price_display": "362 - 1.271 €",
        "available_from": "16.10.2026",
        "living_space_display": "52 - 87 m²",
        "grouped_listing_count": 10
      },
      "quarter": "Kaulsdorf (Hellersdorf)",
      "realtor": "GESOBAU AG",
      "currency": "EUR",
      "latitude": 52.52485,
      "postcode": "12619",
      "floorplan": false,
      "longitude": 13.58695,
      "offer_type": "rent",
      "total_rent": 569,
      "house_number": "91",
      "listing_type": "XXL"
    }
  ],
  "pagination": {
    "next": "https://www.immobilienscout24.de/Suche/de/berlin/berlin/wohnung-mieten?pagenumber=2",
    "page": 1,
    "per_page": 20,
    "total_pages": 632,
    "total_results": 13214
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].id` | string |  |
| `results[].url` | string |  |
| `results[].city` | string |  |
| `results[].tags` | any[] |  |
| `results[].price` | integer |  |
| `results[].rooms` | integer |  |
| `results[].title` | string |  |
| `results[].garden` | boolean |  |
| `results[].images` | string[] |  |
| `results[].is_new` | boolean |  |
| `results[].street` | string |  |
| `results[].address` | string |  |
| `results[].balcony` | boolean |  |
| `results[].project` | object |  |
| `results[].quarter` | string |  |
| `results[].realtor` | string |  |
| `results[].currency` | string |  |
| `results[].latitude` | number |  |
| `results[].postcode` | string |  |
| `results[].floorplan` | boolean |  |
| `results[].longitude` | number |  |
| `results[].offer_type` | string |  |
| `results[].total_rent` | integer |  |
| `results[].house_number` | string |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Property | Search |
|---|---|---|
| cURL (Bash) | [`property`](examples/curl/property.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`property`](examples/php/property.php) | [`search`](examples/php/search.php) |
| C# | [`property`](examples/csharp/Property.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`property`](examples/go/property.go) | [`search`](examples/go/search.go) |
| Java | [`property`](examples/java/PropertyExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`property`](examples/ruby/property.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`property`](examples/nodejs/property.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track asking prices and price drops per area.
- **Market analytics** — Measure inventory, days on market and price per m² / sqft.
- **Investment sourcing** — Detect undervalued properties as soon as they are listed.
- **Rental yield models** — Combine sale and rent listings to estimate yields.
- **Proptech products** — Power portals, valuation tools and alerts with structured listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — ImmobilienScout24 plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape ImmobilienScout24?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/immobilienscout24/property` **2**, `/v2/immobilienscout24/search` **2**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the ImmobilienScout24 API return?

Each endpoint returns structured JSON: **ImmobilienScout24 Property** — `id`, `url`, `city`, `floor`, `price`, `rooms`; **ImmobilienScout24 Search** — `results[]`, `results[].id`, `results[].url`, `results[].city`, `results[].tags`, `results[].price`.

### How do I paginate ImmobilienScout24 results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Can I get the raw HTML instead of JSON?

Yes. Set `return_page_source=true` and the response becomes `{"result": "..."}` with the page source.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [Apartments Scraper API](https://github.com/piloterr/apartments-scraper)
- [Argenprop Scraper API](https://github.com/piloterr/argenprop-scraper)
- [Centris Scraper API](https://github.com/piloterr/centris-scraper)
- [Fotocasa Scraper API](https://github.com/piloterr/fotocasa-scraper)
- [Funda Scraper API](https://github.com/piloterr/funda-scraper)
- [Homestra Scraper API](https://github.com/piloterr/homestra-scraper)
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

<sub>ImmobilienScout24 is a trademark of its respective owner. This repository is not affiliated with or endorsed by ImmobilienScout24. Examples are released under the MIT license.</sub>
