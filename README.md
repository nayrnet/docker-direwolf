# 📡 direwolf
A multi-platform image for running [Direwolf] for APRS projects

## tags:
 - latest - built off dev branch (1.7.x)
 - stable - built off main branch (1.6.x)

## built with:
 - runs as non-root user
 - rtl-sdr
 - netcat
 - hamlib2
 - gpsd

## notes:
This is a slightly customized version that I use for https://igate.nayr.net, it can run as a standard standalone docker install but has been specifically crafted for:
 - netcat is included so you can pipe the output via IP, I use this for the web tail to a sidecar.
 - direwolf stats patch of my own creation to enable SBEACON support, this is a hack to dump internal stats to a file that can be scraped externally.
   - this is harmless, with below config it will dump stats out to /tmp/dw-stats.txt every 5m
     - SBEACON	sendto=IG delay=00:30 every=5
   - requires a metrics scraping sidecar, /tmp ramdisk and start script to copy /usr/local/bin/dw-* scripts to /tmp for sidecar.
I with further testing and development I intend to release both docker-compose and helm charts to easily and quickly deploy your own igate site like mine.

## Installing
### Docker
Direwolf main branch:
`docker pull nayr/direwolf:stable`

Direwolf dev branch:
`docker pull nayr/direwolf:latest`

## Docker Componse (soon)
 Full Standalone Stack with:
 - direwolf (stable or dev)
   - telegraf sidecar to scrape metrics
   - frontail sidecar to direwolf Web Console
 - InfluxDB
 - Grafana
 - Postgres
 - Nginx

### Kubernetes (soon)
 Helm Install HA Stack with:
 - direwolf (stable or dev)
   - telegraf sidecar to scrape metrics
   - frontail sidecar to direwolf Web Console
 - InfluxDB Operator for HA Setup
 - Grafana
 - Postgres Operator for HA Setup
 - Node Feature Discovery to find nodes with required hardware.

## Environment Variables

| Variable    | Required | Description |
|-------------|-----------|-------------|
| `CALLSIGN`  | Yes | Your callsign & SSID, example `N0CALL-10` |
| `PASSCODE`  | Yes | Passcode for igate login, [find passcode here] |
| `LATITUDE`  | Yes | Latitude for PBEACON, example `42^37.14N` |
| `LONGITUDE` | Yes | Longitude for PBEACON, example `071^20.83W` |
| `COMMENT`   | No  | Override PBEACON default comment, do not use the `~` character |
| `SYMBOL`    | No  | APRS symbol for PBEACON, defaults to `igate` |
| `IGSERVER`  | No  | Override with the APRS server for your region, default for North America `noam.aprs2.net` |
| `ADEVICE`   | No  | Override Direwolf's ADEVICE for digipeater, default is `stdin null` for receive-only igate |
| `FREQUENCY` | No  | Override `rtl_fm` input frequency, default `144.39M` North America APRS |
| `DW_STANDALONE` | No | Set to any value to disable rtl_fm, useful in digipeater applications. Must also set `ADEVICE` |
| `DWARGS` | No | Set to add/pass any arguments to the direwolf executable, example `-t 0` for no color logs |

[Direwolf]: https://github.com/wb2osz/direwolf
[find passcode here]: https://w2b.ro/tools/aprs-passcode/
[k3s]: https://k3s.io
