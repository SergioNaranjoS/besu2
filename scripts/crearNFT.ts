import { ethers } from 'hardhat';
import { StudentNFT } from '../typechain-types';

async function main() {
  const [deployer] = await ethers.getSigners();

  // Obtener la instancia del contrato
  const contractAddress = '0xfeae27388A65eE984F452f86efFEd42AaBD438FD';
  const studentNFTContract = (await ethers.getContractAt(
    'StudentNFT',
    contractAddress,
    deployer
  )) as StudentNFT;

  // Crear un nuevo NFT
  await studentNFTContract.createStudentNFT(
    20181092999,
    'Sergio Salvador',
    'Naranjo Sanchez',
    'Facultad de Sistemas',
    6,
    'O+',
    'Quito, Conocoto2345',
    'EPN - FIS',
    '12-02-2024',
    '0xFE3B557E8Fb62b89F4916B721be55cEb828dBd73'
  );

  
  // Obtener información de un estudiante por tokenId
  const tokenId: bigint = 12122335652588331569n; // Reemplaza con el tokenId real
  const studentInfo = await studentNFTContract.getStudentInfo(tokenId);
  console.log('Información del Estudiante:', studentInfo);
  
  /*
  // Cambiar la URL base del token URI
  const newBaseTokenURI = '';
  await studentNFTContract.setBaseTokenURI(newBaseTokenURI);
  */
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

