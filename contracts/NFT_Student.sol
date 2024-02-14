// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract StudentNFT is ERC721 {
    using Strings for uint256;

    string private _baseTokenURI;
    uint private _tokenIdCounter;
    uint private retTokenId;

    event StudentNFTCreated(address indexed creator, address indexed recipient, uint tokenId);

    constructor(string memory baseTokenURI) ERC721("StudentNFT", "NFT") {
        _baseTokenURI = baseTokenURI;
        //inicializar tokenId inicial diferente de cero
        _tokenIdCounter = 1;
    }

    struct StudentInfo {
        uint id;
        string nombres;
        string apellidos;
        string facultad;
        uint semestre;
        string universidad;
        uint fechaEmision;
        uint fechaExpiracion;
    }

    mapping(uint => StudentInfo) private _studentInfo;

    //Generacion del TokenId 
    function generateTokenId(uint _id, string memory _nombres, string memory _apellidos, uint  _fechaEmision, uint  _fechaExpiracion) internal view returns (uint){
        uint256 hashResult = uint256((keccak256(abi.encodePacked(_id, _nombres, _apellidos, _fechaEmision, _fechaExpiracion, _tokenIdCounter))));
        hashResult =uint256((keccak256(abi.encodePacked(_tokenIdCounter, _id))));
        return hashResult;
    }

    function createStudentNFT(
        uint _id,
        string memory _nombres,
        string memory _apellidos,
        string memory _facultad,
        uint _semestre,
        string memory _universidad,
        uint  _fechaEmision,
        uint  _fechaExpiracion,
        address recipient // direccion del destinatario
    ) public {
        _tokenIdCounter ++;
        uint tokenId = generateTokenId(_id, _nombres, _apellidos, _fechaEmision, _fechaExpiracion);
        mintStudentNFTTo(recipient, tokenId, _id, _nombres, _apellidos, _facultad, _semestre, _universidad, _fechaEmision, _fechaExpiracion);
        retTokenId = tokenId;
        emit StudentNFTCreated(msg.sender, recipient, tokenId);

    }

    function mintStudentNFTTo(
        address to,
        uint tokenId,
        uint _id,
        string memory _nombres,
        string memory _apellidos,
        string memory _facultad,
        uint _semestre,
        string memory _universidad,
        uint  _fechaEmision,
        uint  _fechaExpiracion
    ) internal {
        _safeMint(to, tokenId);

        _studentInfo[tokenId] = StudentInfo({
            id: _id,
            nombres: _nombres,
            apellidos: _apellidos,
            facultad: _facultad,
            semestre: _semestre,
            universidad: _universidad,
            fechaEmision: _fechaEmision,
            fechaExpiracion: _fechaExpiracion
        });
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory baseURI = _baseTokenURI;
        return bytes(baseURI).length > 0
            ? string(abi.encodePacked(baseURI, tokenId.toString()))
            : '';
    }

    function getStudentInfo(uint tokenId) public view returns (StudentInfo memory) {
        return _studentInfo[tokenId];
    }

    function getTokenId() public view returns (uint){
        return retTokenId;
    }
}
