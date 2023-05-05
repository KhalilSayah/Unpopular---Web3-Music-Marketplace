// SPDX-License-Identifier: MIT


pragma solidity 0.6.2;

import "./piece.sol";

contract Artist {


    string private A_name;
    address private A_address;
    string private A_data; //URI IPFS
    bool private A_ban;

    uint id_piece;

    

    mapping(uint => piece) public list_piece;

    

    constructor(string memory _name, address _address, string memory _data) public {

        A_name = _name;
        A_address = _address;
        A_data = _data;
        A_ban = true;


    }

    modifier IsActif(){
        require(A_ban==true, "This account has been deleted");
        _;
    }

    modifier IsOwner(){
        require(msg.sender == A_address);
        _;
    }

    

    function getName() public view IsActif returns(string memory)  {
        return A_name;
    }

    function delArist() public {
        A_ban= false;
    }

    function updateArist(string memory _newdata) public {
        A_data = _newdata;
    }

    //function to create a new piece
    function releasePiece (string memory name, string memory symbol, string memory uri, uint _maxSupply) public IsOwner(){

        piece Piece = new piece(name,symbol,uri,_maxSupply);
        list_piece[id_piece] = Piece;
        id_piece +=1;

    }

    //function to mint a new nft from existing piece
    function mintPiece(uint _idPiece) public IsOwner(){
        piece Piece = list_piece[_idPiece];
        Piece.mintPiece();

    }

    
    
}