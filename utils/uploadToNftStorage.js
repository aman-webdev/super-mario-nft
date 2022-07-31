const { NFTStorage, File } = require('nft.storage')
const mime = require('mime')
const path = require('path')
const fs = require('fs')
require("dotenv").config()
const NFT_STORAGE_KEY = process.env.NFT_STORAGE_KEY ;


 function fileFromPath(filePath) {
    const content =  fs.readFileSync(filePath);
    const type = mime.getType(filePath);
    console.log(type,"Type")
    const result= new File([content], path.basename(filePath), { type })
    
    return result
}

const storeNFT = async()=>{
    const image = fileFromPath("./metadata/mario.jpg")
    console.log(image)
    const nftStorage = new NFTStorage({token:NFT_STORAGE_KEY})

    const result  =await nftStorage.store({
        image,
        name:"Mario",
        description:"Mario is a short, pudgy, Italian plumber who sets out to rescue Princess Peach from the evil villain Bowser",
        attributes:[
            {
                "trait_type":"Strength",
                "value":78,
                "max_value":100
            },
            {
                "trait_type":"Speed",
                "value":85,
                "max_value":100
            },
            {
                "trait_type":"Jump",
                "value":100,
                "max_value":100
            },
            {
                "trait_type":"Intelligence",
                "value":40,
                "max_value":100
            }
        ]
    })

    console.log(result)
}


storeNFT()