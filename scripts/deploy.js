const hardhat = require("hardhat");


async function main() {
  // deploying the NFT 721A contract
  const PixelPaddle = await hardhat.ethers.getContractFactory("PixelPaddle");
  let pixelPaddle = await PixelPaddle.deploy();
  await pixelPaddle.waitForDeployment();
  console.log("Pixel Paddle Address ", pixelPaddle.target)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });
