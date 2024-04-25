const dotenv = require('dotenv');
dotenv.config();
const ethers = require("ethers");
const contract = require("../artifacts/contracts/ChessGame.sol/ChessGame.json");

const { CONTRACT_ADDRESS, PRIVATE_KEY, API_URL } = process.env;

// Provider
const alchemyProvider = new ethers.providers.JsonRpcProvider(API_URL);

// Signer
const signer = new ethers.Wallet(PRIVATE_KEY, alchemyProvider);

// Contract
const ChessContract = new ethers.Contract(
  CONTRACT_ADDRESS,
  contract.abi,
  signer
);

async function main() {
  try {
    const txResponse = await ChessContract.createGame({value: ethers.utils.parseEther("0.001")});
    const txReceipt = await txResponse.wait(); // wait for the transaction to be mined
    console.log("The transaction is:", txReceipt);
    // If the game ID is emitted as an event, you'll need to parse the event logs
  } catch (error) {
    console.error("Error creating game:", error);
  }
}

main();
