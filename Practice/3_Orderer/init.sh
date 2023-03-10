# Initialize the orderer
# 1. Clean up
# 2. IF $1=all then Copies the YAML files to the current folder
#       Copies the ../../setup/config/simple-two-org/crypto.1/crypto-config.yaml 
#       Copies the ../../setup/config/simple-two-org/policy.1/configtx.yaml 
#       Copies the ../../setup/config/simple-two-org/orderer.1/orderer.yaml 
# 3. Generates the crypto config in this folder
# 4. Generates the Genesis block
# 5. Generates the create channel tx file 
#
# IGNORE the warnings. You will understand these and address it later exercises

#1.
./clean.sh all
mkdir ledgers

BASE_CONFIG_DIR=./config
export PATH=${PWD}/../../bin:$PATH
export FABRIC_CFG_PATH=$PWD

# Change this to see log meesage details
export ORDERER_GENERAL_LOGLEVEL=debug

#2 Copy the YAML files
if [ ! -z $1 ]; then
    if [ $1 == "all" ]; then

        cp $BASE_CONFIG_DIR/crypto-config.yaml .
        cp $BASE_CONFIG_DIR/configtx.yaml .
        cp $BASE_CONFIG_DIR/orderer.yaml .
        echo    'Copied: crypto-config.yaml, configtx & orderer YAML files.'
        
    fi
else
    echo 'Use ./init.sh   all      to initialize crypto-config.yaml, configtx and orderer YAML'
fi


#3. Setup cryptogen for 
echo    '================ Generating crypto-config ================'
rm -rf ./crypto-config 2> /dev/null
cryptogen generate --config=./crypto-config.yaml

#4. Setup the genesis block
echo    '================ Writing genesis ================'
# configtxgen -profile AcmeOrdererGenesis -outputBlock ./acme-genesis.block -channelID ordererchannel
configtxgen -profile HospitalOrdererGenesis -outputBlock ./hospital-genesis.block -channelID ordererchannel


#channel name contains illegal charcter error -> means channelID should be in smallcase

#5. Create the HospitalChannel transaction
echo    '================ Writing HospitalChannel ================'
# configtxgen -profile AcmeChannel -outputCreateChannelTx ./acme-channel.tx -channelID acmechannel
configtxgen -profile HospitalChannel -outputCreateChannelTx ./hospital-channel.tx -channelID hospitalchannel
