async function main() {
  const { ethers } = require("hardhat");

  const StorageContract = await ethers.getContractFactory("Storage");
  const storage = await StorageContract.deploy();
  console.log("Contract Deployed to Address:", storage.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
