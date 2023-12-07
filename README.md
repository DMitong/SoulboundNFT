# Soulbound NFT

Soulbound NFT is a smart contract that implements the ERC1155 token standard with a unique ownership rule. The contract creates a main token that is soulbound to the owner, meaning that it cannot be transferred to anyone else. The contract also creates four item tokens that can only be traded between owners of the main token. The contract can be used to create a game-like scenario where the main token represents a character and the item tokens represent accessories or items related to the character.

## Contract Details

The contract is written in Solidity, a programming language for smart contracts. The contract inherits from the ERC1155 contract from the OpenZeppelin library, which provides a standard implementation of the ERC1155 interface. The contract defines the following constants and variables:

- `MAIN_TOKEN`: A constant that represents the token ID of the main token. The value is set to 0.
- `ITEM_TOKEN_1`: A constant that represents the token ID of the first item token. The value is set to 1.
- `ITEM_TOKEN_2`: A constant that represents the token ID of the second item token. The value is set to 2.
- `ITEM_TOKEN_3`: A constant that represents the token ID of the third item token. The value is set to 3.
- `ITEM_TOKEN_4`: A constant that represents the token ID of the fourth item token. The value is set to 4.
- `mainTokenOwners`: A mapping that stores the owners of the main token. The key is an address and the value is a boolean. The value is initialized to false for all addresses.

The contract defines the following constructor and methods:

- `constructor(string memory uri)`: The constructor that sets the URI for the metadata. The URI is a string that points to a JSON file that contains the metadata for the token types. The metadata should follow the ERC1155 Metadata URI JSON Schema. The constructor calls the ERC1155 constructor with the URI as the argument.
- `mintMainToken(address account) public onlyOwner`: A method that mints the main token for a given address. The method can only be called by the contract owner. The method checks if the address already owns the main token, and if not, it calls the `_mint` method from the ERC1155 contract with the address, the main token ID, and the amount of one as the arguments. The method also sets the mapping value for the address to true.
- `mintItemTokens(address account, uint256[] memory amounts) public onlyOwner`: A method that mints the item tokens for a given address and amounts. The method can only be called by the contract owner. The method checks if the address owns the main token, and if so, it calls the `_mintBatch` method from the ERC1155 contract with the address, an array of the item token IDs, and an array of the amounts as the arguments.
- `safeTransferFrom(address from, address to, uint256 tokenId, uint256 amount, bytes memory data) public override`: A method that overrides the `safeTransferFrom` method from the ERC1155 contract to add custom logic for transferring the tokens. The method checks if the sender and the recipient own the main token, and if so, it allows the transfer of the item tokens. However, it prevents the transfer of the main token, which is soulbound to the owner. The method calls the `super.safeTransferFrom` method with the original arguments.
- `safeBatchTransferFrom(address from, address to, uint256[] memory tokenId, uint256[] memory amounts, bytes memory data) public override`: A method that overrides the `safeBatchTransferFrom` method from the ERC1155 contract to add custom logic for transferring the tokens. The method checks if the sender and the recipient own the main token, and if so, it allows the transfer of the item tokens. However, it prevents the transfer of the main token, which is soulbound to the owner. The method also loops through the array of the token IDs and checks if any of them is the main token ID. The method calls the `super.safeBatchTransferFrom` method with the original arguments.

## Contract Deployment

This contract was deployed using foundry:

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

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
