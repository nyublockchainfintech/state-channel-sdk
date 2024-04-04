async function main() {
  const {CONTRACT_ADDRESS} = process.env;

  // The contract's address
  const contractAddress = CONTRACT_ADDRESS;

  // The interface of the contract
  const Contract = await ethers.getContractFactory("Storage");

  // Connect to the deployed contract
  const contract = await Contract.attach(contractAddress);

  // Example: calling a getter function of the contract
  const value = await contract.checkBalance();
  console.log("Value:", value.toString());
}
