require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */

const { POLYGON_MUMBAI_URL, MNEMONIC } = process.env;

module.exports = {
  solidity: "0.8.19",
  networks: {
    polygon_mumbai: {
      url: POLYGON_MUMBAI_URL,
      accounts: MNEMONIC,
    }
  }
};