# Stellar Nursery

## Opinionated template for cosmos blockchains

Nursery is a cosmos blockchain template that stays up to date with the Cosmos ecosystem.  

## Why?

Most cosmos chains are mainly the same under the hood.  Nursery aims to standardize that even further, so that developers can focus on adding new features, instead of rote maintenance.

The first piece of this is just that every chain made with nursery is a fork of this repository so it is eaiser to merge in changes.  We plan to develop a new abstraction, that separates the chain template from your chain's unique features.  If you use only the template it is likely that nursery can even handle upgrades for you!

At Notional we watched chain teams stumble over fairly rote integration work again and again.  Nursery does that so that you don't need to.  


## How?

```bash
curl https://raw.githubusercontent.com/notional-labs/nursery/main/simple-nursery.bash | bash
```

if you don't enjoy that route, then you probably know other ways to use nursery :).

Note that the simple-nursery.bash script assumes that you've got go 1.20+ and the github cli tool installed.  nursery.bash will install them for you, but is still in testing:


```bash
curl https://raw.githubusercontent.com/notional-labs/nursery/main/nursery.bash | bash
```



## What?

So this ealy version has:

* SDK v0.47.x
* Cometbft v0.37.x
* IBC-go v7.0.0
* packet-forward-middleware v7.0.0
* async-icq v7.0.0
* CosmWasm 1.2
* WASMD v0.40.0


#### Planned Features
* ICS Consumer Chains
* ICS Producer Chains
* Mesh producers and consumers
* twasm
* ibc-go v7.1.0 with the wasm client

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
* Cosmos Hub Community (from [prop 104](https://www.mintscan.io/cosmos/proposals/104))
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
  
