# drug_supplychain - supplychain

This awesome project was created automatically with [Convector CLI](https://github.com/worldsibu/convector-cli).
By default new Convector projects locally include [Hurley](https://github.com/worldsibu/hurley) to manage your development environment seamlessly, so you don't have to worry about setting up the network and hard ways to install  and upgrade your chaincodes.

## Start

```javascript
# Install dependencies - From the root of your project
npm i
# Create a new development blockchain network  - From the root of your project
npm run env:restart
# Install your smart contract
npm run cc:start -- supplychain
# Make a testing call to create a record in the ledger
# Beware that the first call may fail with a timeout! Just happens the first time
hurl invoke supplychain supplychain_create "{\"name\":\"my first request\",\"id\":\"0001\",\"created\":0,\"modified\":0}"
```

## About Hurley

You may as well install **Hurley** globally for easier and more flexible management.

`npm i -g @worldsibu/hurley`

Since with Hurley globally you have control over everything, some things that you can do, for example, is installing a Convector Smart Contract with a different name than the one you used for your project.

```javascript
# Use the same package
# Install a new chaincode with the same source code but the name 'anothernameforyourcc'
hurl install anothernameforyourcc node
```

Other complex tasks you may need is installing to a different channel.

```javascript
# Use the same package
# Be sure you started your environment with more than one channel running 'hurl new --channels 2'. Otherwise this will throw an error.
hurl install anothernameforyourcc node --channel ch2
```

---

If you don't want to, don't worries! This project works right away.

## Start - if you have Hurley globally

### Bring your project to life

```javascript
# Install dependencies - From the root of your project
npm i
# Create a new development blockchain network  - From the root of your project
hurl new
```

### Install and upgrade chaincodes

```javasrcipt

# Package your smart contract's code  - From the root of your project
npm run cc:package -- supplychain org1
# Install to your blockchain - From the root of your project
hurl install supplychain node -P ./chaincode-supplychain
# Install in debug mode, this will run the chaincode server locally so you can debug
hurl install supplychain node -P ./chaincode-supplychain --debug

# Upgrade your existing chaincode - From the root of your project
hurl upgrade supplychain node 1.2 -P ./chaincode-supplychain
```

## Start - if you don't have Hurley globally

### Bring your project to life

```javascript
# Install dependencies - From the root of your project
npm i
# Create a new development blockchain network  - From the root of your project
npm run env:restart
```

### Install and upgrade chaincodes

```javascript
# Install to your blockchain - From the root of your project
npm run cc:start -- supplychain

# Upgrade your existing chaincode - From the root of your project
npm run cc:upgrade -- supplychain 1.2
```

## Tests

```javascript
npm run test
```

> Check all the information to work with Convector [in the DOCS site](https://docs.covalentx.com/convector).

## Collaborate to the Convector Suite projects

* [Discord chat with the community](https://community.covalentx.com)
* [Convector projects](https://github.com/worldsibu)
