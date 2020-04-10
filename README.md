# drug_supplychain - supplychain

This awesome project was created automatically with [Convector CLI](https://github.com/worldsibu/convector-cli).
By default new Convector projects locally include [Hurley](https://github.com/worldsibu/hurley) to manage your development environment seamlessly, so you don't have to worry about setting up the network and hard ways to install  and upgrade your chaincodes.

## Pre-requisities

These are the general pre-requisites to run Convector and Hyperledger Fabric:

* Node 8.11.0 (if you have a higher version, use [NVM](https://github.com/nvm-sh/nvm))

* [Docker Community Edition (CE)](https://www.docker.com/docker-community)

* [Convector CLI](https://github.com/worldsibu/convector-cli). Install it globally.
  
    ```javascript
        npm install -g @worldsibu/convector-cli
    ```

* You may as well install [Hurley](https://www.npmjs.com/package/@worldsibu/hurley) globally for easier and more flexible management.

    ```bash
        npm install -g @worldsibu/hurley
    ```

## Kickstart the Blockchain Network

To kickstart the project we will install all the dependencies for chaincode and set up a basic development hyperledger network using hurley with 2 organisation having an admin and a user each. The network will have a solo orderer working for the basic development setup. We will create a default channel named "ch1" and initialise and instantiate the supplychain chaincode on the channel. After the setup is completed the worldstate of the blockchain can be seen on <http://localhost:5084/_utils/#database/ch1_supplychain/_all_docs>

```bash
# Install dependencies - From the root of your project
$ npm i
# Create a new development blockchain network  - From the root of your project
$ npm run env:restart
# Install your smart contract
$ npm run cc:start -- supplychain
```

## Byzantine-Browser Interface

To view the hyperledger blockchain configuration, transactions in each block and various other analysis reagrding the blockchain we will use the [byzantine-browser](https://github.com/in-the-keyhole/byzantine-browser) interface.

```bash
# Install dependencies
$ cd byzantine-browser
$ npm install
$ cd ui
$ npm install
# Creating a build - From ui folder
$ npm run build
# Back to byzantine-browser folder
$ cd ..
```

Add or edit the .env file in the byzantine-browser folder and paste the following:

```bash
USERID=user1
NETWORK_URL=grpc://localhost:7051
EVENT_URL=grpc://localhost:7052
```

Run the surver. The interface can be accesed on <http://localhost:4001/>

```bash
# Run server - From byzantine-browser folder
$ ./runApiServer.sh
```

## Sample Data and Transactions

The deveopment network can be initialised with sample data and sample transactions using the following script.

```bash
# Create sample data and transactions
$ ./createSampleData.sh
```
