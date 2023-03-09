=================================
Updated for Fabric 2.x : May 2020

- # The -asOrg flag now takes MSP ID instead of Org Name

# cp-config.sh

Initializes the configtx config files - use it if you have made changes to the YAML

# Generate the crypto material

- Copy the setup/config/simple-two-org/crypto.1/crypto-config.yaml to cryptogen/simple-two-org
  [Or-Use] ./cp-config.sh

- cd configtx/simple-two-org
- cryptogen generate --config=./crypto-config.yaml

# Generate the genesis

export FABRIC_CFG_PATH=$PWD
configtxgen -profile HospitalOrdererGenesis -channelID hospitalChannel -outputBlock hospital-genesis.block
configtxgen -inspectBlock ./hospital-genesis > hospital-genesis.json

# Generate the channel tx

configtxgen -outputCreateChannelTx ./hospital-channel.tx -profile HospitalChannel -channelID hospitalChannel

configtxgen -inspectChannelCreateTx hospital-channel.tx > hospital-channel.json

# Generate the anchor peer update tx

configtxgen -outputAnchorPeersUpdate ./Hospital1Anchors.tx -profile HospitalChannel -channelID hospitalChannel -asOrg Hospital1MSP

configtxgen -inspectChannelCreateTx Hospital1Anchors.tx

# Print as

configtxgen -printOrg Org1
