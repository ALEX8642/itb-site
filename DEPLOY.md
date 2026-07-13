# Deploying itb.guru

Static one-page site served by nginx in Docker, HTTP-only on `127.0.0.1:8080`.
TLS and public routing are handled by the host's existing nginx reverse proxy +
dyndns — this container needs neither.

## Run / update

```sh
docker compose up -d --build     # build image and start (or restart with changes)
```

The site is then at http://127.0.0.1:8080.

## Reverse-proxy snippet (host nginx)

Add to the existing `server` block for itb.guru (the one that terminates TLS):

```nginx
location / {
    proxy_pass http://127.0.0.1:8080;
    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Real-IP $remote_addr;
}
```

## Content toggles

Edit `site.env`, then `docker compose up -d --build`:

| Variable | Effect |
|---|---|
| `SHOW_AVAILABILITY` | Hero availability badge on/off |
| `AVAILABILITY_DATE` | Badge date text, e.g. `"Q3 2026"` |
| `SHOW_LAB` | Lab section + its nav link |
| `SHOW_WRITING` | Writing section + its nav link |

`./build.sh` runs the same build locally into `dist/` if you want to inspect
the output without Docker.

## ⚠ Writing section at cutover

The three post rows still link to the **old WordPress URLs on itb.guru**
(`/2025/09/13/...`). The moment this container replaces WordPress at the
domain, those links 404. Either:

- set `SHOW_WRITING=false` before cutover, or
- migrate the posts first, update the hrefs in `src/index.html`, and add 301
  redirects from the old paths in `nginx.conf`, e.g.:

  ```nginx
  location = /2025/09/13/ai-powered-threat-detection-3-ways-it-saves-businesses-money-and-downtime/ {
      return 301 /posts/ai-powered-threat-detection;
  }
  ```

## Hosting on another machine

The image is self-contained (fonts self-hosted, no external requests) and
`linux/amd64`. Two ways to move it:

**Via GHCR (pullable):**

```sh
docker login ghcr.io -u ALEX8642        # PAT with write:packages scope
docker compose build                    # tags ghcr.io/alex8642/itb-site:latest
docker push ghcr.io/alex8642/itb-site:latest
```

On the target, use a compose file with `image: ghcr.io/alex8642/itb-site:latest`
(no `build:`), then `docker compose pull && docker compose up -d`.

Remember: `site.env` toggles are **baked in at build time** — to change them,
rebuild + re-push from the source checkout, then re-pull.

**Via source:** copy/clone the repo and `docker compose up -d --build` on the
target — works on any architecture.

Either way, point DNS at the new machine. If it has no reverse proxy, add
one + certbot, or switch the image to Caddy for automatic Let's Encrypt.
