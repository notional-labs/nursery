# nursery

## Opinionated template for cosmos blockchains

Nursery is a cosmos blockchain template that stays up to date with the Cosmos ecosystem.  

## Why?

Most cosmos chains are mainly the same under the hood.  Nursery aims to standardize that even further, so that developers can focus on adding new features, instead of rote maintenance.

The first piece of this is just that every chain made with nursery is a fork of this repository so it is eaiser to merge in changes.  We plan to develop a new abstraction, that separates the chain template from your chain's unique features.  If you use only the template it is likely that nursery can even handle upgrades for you!

## Credits

* Every contributor to every cosmos ecosystem library that Nursery consumes, including, but not limited to:
  * cosmos-sdk
  * ibc-go
  * async-icq
  * cosmwasm
    * canonicalized here: <https://github.com/confio/cosmwasm>
  * wasmd
    * canonicalized here: <https://github.com/notional-labs/wasmd>
  * packet-forward-middleware
  * token factory
  * comet-bft
  * iavl
  * cosmos-db
  * tm-db
  * tendermint

Notional's current and former customers:

* Osmosis
* Juno
* Cosmos Hub Community (pending passage of [prop 104](https://www.mintscan.io/cosmos/proposals/104))
* Stride
* Evmos
* Composable
* White Whale / Migaloo
* Quasar
* Pylons
* Jackal
* Craft Economy
* Dig
* Sei

 ...and likely others, as well.  Support over time from the above teams and communities has enabled us to imagine what the ideal new chain might look like.  More recently, it has become time to build that.
  