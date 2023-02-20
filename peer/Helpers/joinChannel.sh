. .env.sh

peer channel join -o localhost:7050 -b ./acmechannel.block

peer channel list

rm -rf packages #remove recursively and force delete subdirectories
mkdir -p packages  #create directories with subdirectory
CC_LABEL=gocc.1.0-1.0
CC_PACKAGE_FILE=./packages/$CC_LABEL.tar.gz

peer lifecycle chaincode package $CC_PACKAGE_FILE -p chaincode_example02 --label $CC_LABEL

peer lifecycle chaincode install $CC_PACKAGE_FILE

peer lifecycle chaincode queryinstalled