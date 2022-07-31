// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract ERC721 {
    event ApprovalForAll(
        address indexed _owner,
        address indexed _operator,
        bool _approved
    );
    event Approval(
        address indexed _owner,
        address indexed _approved,
        uint256 _tokenId
    );

    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);

    mapping(address => uint256) internal _balances; // How many tokens does an address have
    mapping(uint256 => address) internal _owners; // who owns a particular token
    mapping(address => mapping(address => bool)) private _operatorApprovals;  // an address which has approved another address for all the tokens 
    mapping(uint256 => address) private _tokenApprovals; // which is the approved address for a particular token id

    // Returns the number of NFTs assigned to an owner
    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "Address is zero");
        return _balances[owner];
    }

    // Finds the owner of an NFT
    function ownerOf(uint256 tokenId) public view returns (address) {
        require(_owners[tokenId] != address(0), "TokenId does not exist");
        return _owners[tokenId];
    }

    // Enables or disables an operator(contract) to manage all of msg.senders assets
    function setApprovalForAll(address operator, bool approved) public {
        _operatorApprovals[msg.sender][operator] = approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }

    // Checks if an operator is approved for another address
    function isApprovedForAll(address _owner, address _operator)
        public
        view
        returns (bool)
    {
        return _operatorApprovals[_owner][_operator];
    }

    // Updates an approved address for an NFT
    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(
            msg.sender == owner || isApprovedForAll(owner, msg.sender),
            "Msg.sender is not the owner or an approved operator"
        );
        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    // Gets the approved address for a single NFT
    function getApproved(uint256 _tokenId) public view returns (address) {
        require(_owners[_tokenId] != address(0), "TokenId does not exist");
        return _tokenApprovals[_tokenId];
    }

    // Transfers ownership of an NFT
    function transferFrom(address from, address to, uint256 tokenId) public{
        address owner = ownerOf(tokenId);
        require(msg.sender==owner || getApproved(tokenId)==msg.sender || 
        isApprovedForAll(owner,msg.sender) ,
        "Msg.sender is not approved or the owner ");
        require(from==owner,"From address is not the owner");
        require(to!=address(0),"To is address zero");
        require(_owners[tokenId]!=address(0),"Token id does not exist");

        approve(address(0),tokenId);

        _balances[from]--;
        _balances[to]++;
        _owners[tokenId]=to;

        emit Transfer(from,to,tokenId);
    }

    // Standard transferFrom and checks if onERC721Received is implemented when sending to smart contracts
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public {
        require(_checkOnERC721Received(),"Recevier not implemented");
        transferFrom(from,to,tokenId);
    }

    function safeTransferFrom(address from ,address to ,uint256 tokenId) public{
           safeTransferFrom(from,to,tokenId,""); 
    }

    function _checkOnERC721Received() private pure returns(bool){
            return true;
    }

    // EIP165: Query if a contract implements another interface 
    function supportsInterface(bytes4 interfaceId) public pure virtual returns(bool){
            return interfaceId==0x80ac58cd; 
    }
}
