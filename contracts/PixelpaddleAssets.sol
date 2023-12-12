// SPDX-License-Identifier: MIT

pragma solidity 0.8.10;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "erc721a/contracts/ERC721A.sol";

contract PixelPaddle is ERC721A, AccessControl {
    string private _baseTokenURI = "";

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant DISTRIBUTOR_ROLE = keccak256("DISTRIBUTOR_ROLE");

    /**
    @dev modifier to check if msg.sender is minter or admin
    */
    modifier onlyModerator() {
        require(
            hasRole(DEFAULT_ADMIN_ROLE, _msgSender()) || hasRole(MINTER_ROLE, _msgSender()),
            "not minter or admin role"
        );
        _;
    }

    modifier onlyDistributor() {
        require(hasRole(DISTRIBUTOR_ROLE, _msgSender()), "not distributor role");
        _;
    }

    constructor() ERC721A("PixelPaddle", "PixelPaddle") {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    /**
    @dev mint token to user
    @param _user address to which token will be minted
    @param _quantity tokens amount minted to user
    */
    function mint(address _user, uint256 _quantity) external onlyModerator {
        require(_user != address(0), "zero address not allowed");
        _safeMint(_user, _quantity);
    }

    /**
    @dev mint token to user
    @param _user address to which token will be minted
    @param _quantity tokens amount minted to user
    */
    function mintByDistributor(address _user, uint256 _quantity) external onlyDistributor {
        require(_user != address(0), "zero address not allowed");
        _safeMint(_user, _quantity);
    }

    /**
    @dev set base uri for nfts, used for metadata, images, etc
    @param baseURI base uri for nfts
    */
    function setBaseURI(string memory baseURI) public onlyModerator {
        _baseTokenURI = baseURI;
    }

    function grantRoleDistributor(address _distributor) external onlyModerator {
        require(_distributor != address(0), "zero address not allowed");
        _grantRole(DISTRIBUTOR_ROLE, _distributor);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721A, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
