// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract StudentNFT is ERC721 {
    using Strings for uint256;

    string private _baseTokenURI;

    event StudentNFTCreated(address indexed creator, address indexed recipient, uint tokenId);

    constructor(string memory baseTokenURI) ERC721("StudentNFT", "NFT") {
        _baseTokenURI = baseTokenURI;
    }

    struct StudentInfo {
        uint id;
        string nombres;
        string apellidos;
        string facultad;
        uint semestre;
        string tipoSangre;
        string direccion;
        string universidad;
        string fechaEmision;
    }

    mapping(uint => StudentInfo) private _studentInfo;

    /*function setBaseTokenURI(string memory baseTokenURI) external {
        _baseTokenURI = baseTokenURI;
    }*/

    function generateTokenId(uint _id, string memory _nombres, string memory _apellidos, string memory _direccion, string memory _fechaEmision) internal pure returns (uint){
        uint256 hashResult = uint256((keccak256(abi.encodePacked(_id, _nombres, _apellidos, _direccion, _fechaEmision))));
        return uint64(hashResult);
    }

    function createStudentNFT(
        uint _id,
        string memory _nombres,
        string memory _apellidos,
        string memory _facultad,
        uint _semestre,
        string memory _tipoDeSangre,
        string memory _direccion,
        string memory _universidad,
        string memory _fechaEmision,
        address recipient // direccion del destinatario
    ) public {
        uint tokenId = generateTokenId(_id, _nombres, _apellidos, _direccion, _fechaEmision);
        mintStudentNFTTo(recipient, tokenId, _id, _nombres, _apellidos, _facultad, _semestre, _tipoDeSangre, _direccion, _universidad, _fechaEmision);


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
        string memory _tipoDeSangre,
        string memory _direccion,
        string memory _universidad,
        string memory _fechaEmision
    ) internal {
        _safeMint(to, tokenId);

        _studentInfo[tokenId] = StudentInfo({
            id: _id,
            nombres: _nombres,
            apellidos: _apellidos,
            facultad: _facultad,
            semestre: _semestre,
            tipoSangre: _tipoDeSangre,
            direccion: _direccion,
            universidad: _universidad,
            fechaEmision: _fechaEmision
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
}
