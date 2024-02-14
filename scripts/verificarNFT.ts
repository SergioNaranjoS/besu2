import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();

  //Direccion del contrato de verificacion. 
  const StudentNFTVerifierAddress = "0x3484B20600854091C166C062FacAd700123f5f71";
  //TokenId del NFT
  const tokenId: bigint = 1351947349706597035020742220910254269273249441834071231374414548409916295032n; // Reemplaza con el tokenId que deseas verificar

  const StudentNFTVerifier = await ethers.getContractAt("StudentNFTVerifier", StudentNFTVerifierAddress);
  const studentInfo = await StudentNFTVerifier.getStudentInfo(tokenId);
  const isValid = await StudentNFTVerifier.validateNFT(tokenId);

  if (isValid) {
    console.log("Es un NFT válido");
    console.log("Información del estudiante:", studentInfo);
  } else {
    console.log("Es un NFT inválido por la fecha de expiracion");
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
