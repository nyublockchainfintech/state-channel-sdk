async function main() {
  require("dotenv").config();
  const { ethers } = require("ethers");

  const contract = require("../artifacts/contracts/Storage.sol/Storage.json");

  const { CONTRACT_ADDRESS, PRIVATE_KEY, API_URL } = process.env;

  // Provider
  const alchemyProvider = new ethers.providers.JsonRpcProvider(API_URL);

  // Signer
  const signer = new ethers.Wallet(PRIVATE_KEY, alchemyProvider);

  // Contract
  const StorageContract = new ethers.Contract(
    CONTRACT_ADDRESS,
    contract.abi,
    signer
  );

  const balance = StorageContract.checkBalance();
  console.log("Balance:" + balance);
}
main();
