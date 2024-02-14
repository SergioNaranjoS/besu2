import { ethers } from 'hardhat';
import { StudentNFT } from '../typechain-types';

async function main() {
  const [deployer] = await ethers.getSigners();

  // Obtener la instancia del contrato
  const contractAddress = '0x3Ace09BBA3b8507681146252d3Dd33cD4E2d4F63';
  const studentNFTContract = (await ethers.getContractAt(
    'StudentNFT',
    contractAddress,
    deployer
  )) as StudentNFT;
  
  //------------------------------------------------------------
  //NFT valido
  await studentNFTContract.createStudentNFT(
    201810929,
    'Juan Pedro',
    'Pablo Sanchez',
    'Facultad de Sistemas',
    5,
    'EPN - FIS',
    1707930000,
    1739552400,
    '0xFE3B557E8Fb62b89F4916B721be55cEb828dBd73'
  );
  // Obtener información de un estudiante por tokenId
  const tokenId: bigint = await studentNFTContract.getTokenId(); // Reemplaza con el tokenId real
  const studentInfo = await studentNFTContract.getStudentInfo(tokenId);
  console.log('Id del token creado: ', tokenId);
  console.log('Información del Estudiante:', studentInfo);

  /*
  //-------------------------------------------------------
  //NFT invalido por fecha
  await studentNFTContract.createStudentNFT(
    201910929,
    'Sergio Salvador',
    'Naranjo Sanchez',
    'Facultad de Sistemas',
    9,
    'EPN - FCA',
    '12-02-2024',
    '12-03-2024',
    '0x42699A7612A82f1d9C36148af9C77354759b210b'
  );
  // Obtener información de un estudiante por tokenId
  const tokenId1: bigint = await studentNFTContract.getTokenId(); // Reemplaza con el tokenId real
  const studentInfo1 = await studentNFTContract.getStudentInfo(tokenId1);
  console.log('Id del token creado: ', studentNFTContract.getTokenId());
  console.log('Información del Estudiante:', studentInfo1);
  */
  //-------------------------------------------------
  /*
    //NFT revocado
    await studentNFTContract.createStudentNFT(
      202010929,
      'Sergio Salvador',
      'Naranjo Sanchez',
      'Facultad de Electrica',
      7,
      'EPN - FIS',
      '12-02-2024',
      '12-03-2024',
      '0x2E1f232a9439C3D459FcEca0BeEf13acc8259Dd8'
    );
    // Obtener información de un estudiante por tokenId
    const tokenId: bigint = await studentNFTContract.getTokenId(); // Reemplaza con el tokenId real
    const studentInfon= await studentNFTContract.getStudentInfo(tokenId);
    console.log('Id del token creado: ', studentNFTContract.getTokenId());
    console.log('Información del Estudiante:', studentInfo);
    */
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

