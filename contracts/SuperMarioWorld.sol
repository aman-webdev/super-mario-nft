// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./ERC721.sol";

contract SuperMarioWorld is ERC721{

    string public name;
    string public symbol;
    uint256 public tokenCount;
    mapping(uint256=>string) private _tokenURIs;
    
    constructor(string memory _name, string memory _symbol){
        name=_name;
        symbol=_symbol;
    }

    // TokenURI is a function that points to the metadata which includes the image and the properties that we want to store in an NFT

    function tokenURI(uint256 tokenId) public view returns(string memory){
        require(_owners[tokenId]!=address(0),"Token id does not exist");
        return _tokenURIs[tokenId];
    }

    // Creates a new NFT inside our collection. SuperMarioWorld is a collection which consists of NFTs having each unique id
    function mint(string memory _tokenURI) public {
        tokenCount++;
        _owners[tokenCount]=msg.sender;
        _balances[msg.sender]++;
        _tokenURIs[tokenCount]=_tokenURI;

        emit Transfer(address(0),msg.sender,tokenCount);
       
    }

    function supportsInterface(bytes4 interfaceId) public pure override returns(bool){
        return interfaceId == 0x80ac58cd || interfaceId==0x5b5e139f;
    }


}