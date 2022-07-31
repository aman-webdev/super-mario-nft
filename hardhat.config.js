require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config()

/** @type import('hardhat/config').HardhatUserConfig */

const RINKEBY_RPC_URL = process.env.RINKEBY_RPC_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const ETHERSCAN_API_KEY = process.env.ETHERSCAN_API_KEY;
const POLYGON_RPC_URL = process.env.POLYGON_RPC_URL;
const POLYGON_API_KEY = process.env.POLYGON_API_KEY;

module.exports = {
  solidity: "0.8.9",
  defaultNetwork:"hardhat",
  etherscan:{
    rinkeby:ETHERSCAN_API_KEY,
    polygonMumbai:POLYGON_API_KEY
  },
  networks:{
    rinkeby:{
      chainId:4,
      url:RINKEBY_RPC_URL,
      account:[PRIVATE_KEY]
      
    },

    mumbai:{
      chainId:80001,
      url:POLYGON_RPC_URL,
      accounts:[PRIVATE_KEY]
    }

    
  },
 
};
