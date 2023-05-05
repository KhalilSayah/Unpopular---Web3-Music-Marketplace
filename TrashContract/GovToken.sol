// SPDX-License-Identifier: MIT

pragma solidity 0.6.2;

import "./MintableTNT20.sol";

contract GovToken is MintableTNT20 {

    constructor() MintableTNT20 ("Unpopular","UNP",8,100000000000,true){}


}

