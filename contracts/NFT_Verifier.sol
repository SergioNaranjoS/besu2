// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import libraries
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "./NFT_Student.sol"; // Import the StudentNFT contract;
import "./NFT_Revoc.sol"; //importar el validador de revocacion

// Definicion del verificador
contract StudentNFTVerifier {
    StudentNFT private studentNFTContract;
    RevocNFTStudent private revocNFTContract;

    constructor(address studentNFTAddress, address revocNFTAddress) {
        studentNFTContract = StudentNFT(studentNFTAddress);
        revocNFTContract = RevocNFTStudent(revocNFTAddress);
    }

    //Funciones que reciben el tokenId de un NFT
    function validateNFT(uint tokenId) public view returns (bool) {
        StudentNFT.StudentInfo memory studentInfo = studentNFTContract.getStudentInfo(tokenId);
        return validateDateRevoc(studentInfo.fechaExpiracion, tokenId);
    }

    function getStudentInfo(uint tokenId) public view returns (StudentNFT.StudentInfo memory) {
        return studentNFTContract.getStudentInfo(tokenId);
    }

    function validateDateRevoc(uint fechaExpiracion, uint tokenId) public view returns (bool) {
        // Comparar con la fecha actual
        if (fechaExpiracion > block.timestamp && !revocNFTContract.verificarNFTDadoDeBaja(tokenId)) {
            return true;
        }else {
            return false;
        }
    }

}
