import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log('Deploying contracts with the account:', deployer.address);

  const Contract = await ethers.getContractFactory('StudentNFT');
  const contract = await Contract.deploy('identificacion');

  console.log('Contract address:', contract.target);

  // Deploy NFTVerifier contract
   const NFTVerifier = await ethers.getContractFactory('StudentNFTVerifier');
   const nftVerifierContract = await NFTVerifier.deploy(contract.target);
 
   console.log('NFTVerifier contract address:', nftVerifierContract.target);

   //Deploy NFT Valid contract
   const NFTRevoc = await ethers.getContractFactory('RevocNFTStudent');
   const nftRevocContract = await NFTRevoc.deploy();
 
   console.log('NFTRevoc contract address:', nftRevocContract.target);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });

