const {ethers,network}=require("hardhat")
const verify=require("./verfiy")

const DEV_CHAINS=["hardhat","localhost"]
const TOKEN_URI="ipfs://bafyreic6ateiloyd34zuwgbjebixye7vjtuv3jyyzqybwqcg2y6po2u75a/metadata.json"

const deploy=async()=>{
    const ARGS = ["Super Mario","SMW"]
    const contractFactory = await ethers.getContractFactory("SuperMarioWorld");
    console.log("Deploying Super Mario World...");
    const contract = await contractFactory.deploy("SuperMario","SMW");
    console.log(contract)
    await contract.deployed();

    console.log("Deployed Super Mario World")

    console.log(contract.address)

    await contract.mint(TOKEN_URI)

    if(!DEV_CHAINS.includes(network.name)){
        await verify(contract.address,ARGS)
    }
}

deploy()