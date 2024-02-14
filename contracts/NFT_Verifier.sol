// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import libraries
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "./NFT_Student.sol"; // Import the StudentNFT contract;

// Definicion del verificador
contract StudentNFTVerifier {
    StudentNFT private studentNFTContract;

    constructor(address studentNFTAddress) {
        studentNFTContract = StudentNFT(studentNFTAddress);
    }

    //Funciones que reciben el tokenId de un NFT
    function validateNFT(uint tokenId) public view returns (bool) {
        StudentNFT.StudentInfo memory studentInfo = studentNFTContract.getStudentInfo(tokenId);
        return validateDate(studentInfo.fechaExpiracion);
    }

    function getStudentInfo(uint tokenId) public view returns (StudentNFT.StudentInfo memory) {
        return studentNFTContract.getStudentInfo(tokenId);
    }

    function validateDate(uint fechaExpiracion) public view returns (bool) {
        // Comparar con la fecha actual
        return fechaExpiracion > block.timestamp;
    }
    
    //Recibir el token id
    //verificar el token enviaod sea el mismo
    //verificar el estado del estudiante
    //Verificar fechas

    //retornar un boolean

}
