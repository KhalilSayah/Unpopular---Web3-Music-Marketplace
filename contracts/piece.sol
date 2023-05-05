// SPDX-License-Identifier: MIT
// 
//

pragma solidity ^0.6.2;

import "./nft.sol";

contract piece is TNT721 {

    uint mintIndex;
    uint maxSupply;
    string _uri;

    

    modifier maxSupp () {
        require(mintIndex < maxSupply);
        _;
    }

    constructor (string memory name, string memory symbol, string memory uri, uint _maxSupply) public TNT721(name, symbol) { 
        
        _mint(tx.origin, mintIndex);
        _setTokenURI(mintIndex, uri);
        mintIndex +=1;
        maxSupply = _maxSupply;
        _uri = uri;

    }

    function mintPiece() public maxSupp() {
        _mint(tx.origin, mintIndex);
        _setTokenURI(mintIndex, _uri);
        mintIndex +=1;

    }





}