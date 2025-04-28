# 🗳️ **Election Smart Contract** 🎉

This repository contains a smart contract written in Solidity for **electoral voting**. The contract allows for the creation of elections, voting by participants, and getting election results.

---

## 📝 **Features**

- **Create an Election**: Organize a new election with candidates and set a voting period.
- **Vote in Elections**: Registered users can vote for a candidate in a specific election during the active period.
- **Get Election Results**: Retrieve the winner of an election.
- **Track Voters**: Ensures each participant votes only once in an election.

---

## ⚙️ **Technologies Used**

- **Solidity**: Smart contract programming language.
- **Ethereum**: Blockchain platform for deploying and interacting with the contract.
- **VS Code IDE**: For compiling and deploying the smart contract.

---

## 🚀 **Contract Overview**

This contract provides basic functionality for an **election system** where:

- **Election Creation**: The contract owner can create an election, set a start and end time, and define candidates.
- **Voting**: Users can vote for one candidate during the active election window.
- **Election Result**: The contract can return the winner based on vote counts.

---

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

