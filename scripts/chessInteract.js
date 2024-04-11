// functions called by frontend
require("dotenv").config();
import { ethers } from "ethers";
const { CONTRACT_ADDRESS, PRIVATE_KEY, API_URL } = process.env;

// Provider
const alchemyProvider = new ethers.providers.JsonRpcProvider(API_URL);

// Signer
const signer = new ethers.Wallet(PRIVATE_KEY, alchemyProvider);


async function closeGame() {}

async function openGame() {}

async function challenge() {}



