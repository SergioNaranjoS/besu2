// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RevocNFTStudent {
    mapping(uint => DatosNFTEstudiante) private _datosNFT;

    event NFTDadoDeBaja(address indexed deregistrador, uint indexed tokenId);

    struct DatosNFTEstudiante {
        uint tokenId;
        address deregistrador;
        uint fechaDeBaja;
    }

    function darDeBajaNFT(uint tokenId) public {
        if (verificarNFTDadoDeBaja(tokenId)) {
            revert("NFT ya dado de baja");
        }
        _datosNFT[tokenId].fechaDeBaja = block.timestamp;
        emit NFTDadoDeBaja(msg.sender, tokenId);
    }

    function verificarNFTDadoDeBaja(uint tokenId) public view returns (bool) {
        return _datosNFT[tokenId].fechaDeBaja != 0;
    }
}
