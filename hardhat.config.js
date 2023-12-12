require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.10",
  networks: {
    xrpls:{
      url:"https://rpc-evm-sidechain.xrpl.org",
      chainId: 1440002,
      accounts: [`0x${process.env.DEPLOYER_PRIVATE_KEY}`],
    },
  },
};
