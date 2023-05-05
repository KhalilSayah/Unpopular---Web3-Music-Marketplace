// SPDX-License-Identifier: MIT

//this contract is a Factory that can deploy Artistes and manage them
//Funct : 
// - Deploy a new Artiste
// - Mapp this artiste - address - ID 
// - Delete artiste (setup visibility)
// - Store the data off chain of this Artiste 

pragma solidity 0.6.2;

import "./artist.sol";

contract app {

    Artist artist;

    address owner;
    uint256 unique_id;
    mapping(address => Artist) public listartists;
    mapping(address => bool) AddExist;

    constructor () public {
        owner = msg.sender;
    }

    event New_Artist(
        address indexed _artist,
        string _name
    );
    



    modifier OnlyOwner(){
        require(msg.sender == owner);
        _;
    }

    modifier IsUnique(address _address){
        require(AddExist[_address] ==false);
        _;

    }

    function CreateArtist(string memory _name, address _address, string memory _data) public OnlyOwner() IsUnique(_address) {
        artist = new Artist(_name,_address,_data);
        listartists[_address] = artist;
        AddExist[_address] = true;
        unique_id += 1;
        emit New_Artist(address(artist), _name);
    }

    function GetArtist(address _address) public view returns(string memory){
        Artist _artist = listartists[_address];
        return _artist.getName();
    }

    function BanArtist(address _address) public OnlyOwner {
        Artist _artist = listartists[_address];
        _artist.delArist();

    }

    function DelArtist(address _address) public OnlyOwner {
        Artist _artist = listartists[_address];
        _artist.delArist();
        AddExist[_address] = false;

    }

    function UpdateArtsit(address _address, string memory _newdata) public OnlyOwner {
        Artist _artist = listartists[_address];
        _artist.updateArist(_newdata);

    }

    






}