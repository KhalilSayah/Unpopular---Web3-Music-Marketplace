// SPDX-License-Identifier: MIT
// 
//

pragma solidity 0.6.2;
pragma experimental ABIEncoderV2;

import "./nft.sol";

contract piece is TNT721 {

    uint mintIndex;
    uint maxSupply;
    string _uri;
   

    struct Voter {
        uint weight_title; // weight is accumulated by delegation
        uint weight_cover; // weight is accumulated by delegation
        bool voted;  // if true, that person already voted
        address delegate; // person delegated to
        uint vote_title;  // index of the voted proposal
        uint vote_cover;
    }

    struct Proposal_title {
        string name;
        uint count;
    }

    struct Proposal_cover {
        string data;
        uint count;
    }

    Proposal_title[] public titles;
    Proposal_cover[] public covers;


    mapping(address => Voter) public voters;

    

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

    function _addVoter(address _voter) internal {
        Voter memory voter = Voter(1,1,false,_voter,0,0);
        voters[_voter] = voter;
    }

    // a ajouter sur le constructor pour apres
    function defineProposals(string[] memory _tiltles, string[] memory _covers) public {
        for (uint i=0; i < _tiltles.length; i++){
            titles.push(Proposal_title({
                name: _tiltles[i],
                count: 0
            }));
        }
        for (uint i=0; i<_covers.length;i++){
            covers.push(Proposal_cover({
                data: _covers[i],
                count: 0
            }));
        }

    }

    function vote_title(uint proposal) public {
        require(voters[msg.sender].weight_title >0, "Cette address n'a pas assez de Weight pour voter");
        titles[proposal].count += 1;
        voters[msg.sender].weight_title -=1;
        voters[msg.sender].vote_title = proposal;

        
    }

    function vote_cover(uint proposal) public {
        require(voters[msg.sender].weight_cover >0, "Cette address n'a pas assez de Weight pour voter");
        covers[proposal].count += 1;
        voters[msg.sender].weight_cover -=1;
        voters[msg.sender].vote_cover = proposal;
        
    }

    // TITLE WINNER
    function winningTitleProposal() public view
            returns (uint winningProposal_)
    {
        uint winningVoteCount = 0;
        for (uint p = 0; p < titles.length; p++) {
            if (titles[p].count > winningVoteCount) {
                winningVoteCount = titles[p].count;
                winningProposal_ = p;
            }
        }
    }

     // returns the name of the winner
    function winnerTitleName() external view
            returns (string memory winnerName_)
    {
        winnerName_ = titles[winningTitleProposal()].name;
    }



    // COVER WINNER
    function winningCoverProposal() public view
            returns (uint winningProposal_)
    {
        uint winningVoteCount = 0;
        for (uint p = 0; p < covers.length; p++) {
            if (covers[p].count > winningVoteCount) {
                winningVoteCount = covers[p].count;
                winningProposal_ = p;
            }
        }
    }

     // returns the name of the winner
    function winnerCoverName() external view
            returns (string memory winnerName_)
    {
        winnerName_ = covers[winningCoverProposal()].data;
    }



    function mintPiece() public maxSupp() {
        _mint(tx.origin, mintIndex);
        _setTokenURI(mintIndex, _uri);
        mintIndex +=1;
        _addVoter(tx.origin);
    }

    





}