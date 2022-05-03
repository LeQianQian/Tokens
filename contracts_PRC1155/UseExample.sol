// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;
 
import "./ERC1155.sol";
 
contract GameItems is ERC1155 {
    address private founder;
 
    constructor() public ERC1155("https://xxx.com/{id}.json") {
        founder = msg.sender;
    }
 
    function mint(address account, uint256 id, uint256 amount, bytes memory data) public onlyFounder virtual {
        _mint(account, id, amount, data);
	}
 
    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) public onlyFounder virtual {
        _mintBatch(to, ids, amounts, data);
	}
	
    function burn(address account, uint256 id, uint256 value) public virtual {
        require(
            account == _msgSender() || isApprovedForAll(account, _msgSender()),
            "ERC1155: caller is not owner nor approved"
        );
 
        _burn(account, id, value);
    }
 
    function burnBatch(address account, uint256[] memory ids, uint256[] memory values) public virtual {
        require(
            account == _msgSender() || isApprovedForAll(account, _msgSender()),
            "ERC1155: caller is not owner nor approved"
        );
 
        _burnBatch(account, ids, values);
    }
	
    modifier onlyFounder(){
        require(msg.sender == founder, "must be founder");
        _;
    }
 
    function getFounder() public view returns (address) {
        return founder;
    }
}