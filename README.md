# sghaze-api

A simple webservice for fetching the Pollutant Standards Index (PSI) reading from http://www.nea.gov.sg/psi/.

I tried to find an existing server for something like this, but couldn't. I
found similar web apps and scrapers in various languages, but they had too many
dependencies, so I rolled this lightweight one.

Currently it just returns the latest 3-hr measurement for each of the 5 areas,
because that's all I wanted.

# Public server

I'm running a server at http://sghaze.herokuapp.com/

```
$ curl http://sghaze.herokuapp.com
{"North":"56","South":"56","East":"56","West":"56","Central":"56"}⏎
```

# Running

This should suffice as long as you have Rack installed:

```
rackup
```
