// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "lib/openzeppelin-contracts/contracts/token/ERC1155/ERC1155.sol";

contract SoulboundNFT is ERC1155 {
    uint256 public constant MAIN_TOKEN = 0;
    uint256 public constant ITEM_TOKEN_1 = 1;
    uint256 public constant ITEM_TOKEN_2 = 2;
    uint256 public constant ITEM_TOKEN_3 = 3;
    uint256 public constant ITEM_TOKEN_4 = 4;

    mapping(address => bool) public mainTokenOwners;

    constructor(string memory uri) ERC1155(uri) {}

    function mintMainToken(address account) public onlyOwner {
        require(
            !mainTokenOwners[account],
            "This account already owns main token"
        );
        _mint(account, MAIN_TOKEN, 1, "");

        mainTokenOwners[account] = true;
    }

    function mintItemToken(
        address account,
        uint256[] memory amounts
    ) public onlyOwner {
        require(
            mainTokenOwners[account],
            "This account does not own main token"
        );
        uint256[] memory tokenId = [
            ITEM_TOKEN_1,
            ITEM_TOKEN_2,
            ITEM_TOKEN_3,
            ITEM_TOKEN_4
        ];

        _mintBatch(account, tokenId, amounts, "");
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        uint256 amount,
        bytes memory data
    ) public override {
        require(mainTokenOwners[from], "The sender does not own main token");
        require(mainTokenOwners[to], "The receiver does not own main token");
        require(tokenId != MAIN_TOKEN, "Cannot transfer main token");

        super.safeTransferFrom(from, to, tokenId, amount, data);
    }

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory tokenIds,
        uint256[] memory amounts,
        bytes memory data
    ) public override {
        require(mainTokenOwners[from], "The sender does not own main token");
        require(mainTokenOwners[to], "The receiver does not own main token");
        for (uint256 i = 0; i < tokenIds.length; i++) {
            require(tokenIds[i] != MAIN_TOKEN, "Cannot transfer main token");
        }

        super.safeBatchTransferFrom(from, to, tokenIds, amounts, data);
    }
}
