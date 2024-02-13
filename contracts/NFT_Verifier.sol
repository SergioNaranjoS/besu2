// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import libraries
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./NFT_Student.sol"; // Import the StudentNFT contract;

// Definition of the NFT verification contract
contract NFTVerifier is Ownable {
    // Address of the student ERC721 contract
    StudentNFT private _studentNFTContract;

    // Constructor that receives the address of the StudentNFT contract
    constructor(address studentNFTContractAddress) Ownable(msg.sender) {
        _studentNFTContract = StudentNFT(studentNFTContractAddress);
    }

    // Function to verify the existence of an NFT
    function verifyNFT(uint tokenId) external view returns (bool exists) {
        exists = (_studentNFTContract.ownerOf(tokenId) != address(0));
    }
}
