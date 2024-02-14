import { ethers } from "hardhat";
import { RevocNFTStudent } from "../typechain-types";
import { expect } from "chai";

async function main() {
  const [deployer] = await ethers.getSigners();

  // Dirección del contrato RevocNFTStudent.
  const revocNFTStudentAddress = "0xa50a51c09a5c451C52BB714527E1974b686D8e77";
  // TokenId del NFT
  const tokenId: bigint = 1351947349706597035020742220910254269273249441834071231374414548409916295032n; // Reemplaza con el tokenId que deseas verificar

  const revocNFTStudent = await ethers.getContractAt("RevocNFTStudent", revocNFTStudentAddress);

  // Verificar si el NFT ya ha sido dado de baja
  const yaDadoDeBaja = await revocNFTStudent.verificarNFTDadoDeBaja(tokenId);

  if (yaDadoDeBaja) {
    console.log(`El NFT con tokenId ${tokenId} ya ha sido dado de baja anteriormente.`);
  } else {
    // Dar de baja el NFT
    await revocNFTStudent.darDeBajaNFT(tokenId);
    console.log(`El NFT con tokenId ${tokenId} ha sido dado de baja con éxito.`);

    // Verificar nuevamente después de dar de baja
    const ahoraDadoDeBaja = await revocNFTStudent.verificarNFTDadoDeBaja(tokenId);
    console.log(`Verificación después de dar de baja: ${ahoraDadoDeBaja}`);
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
