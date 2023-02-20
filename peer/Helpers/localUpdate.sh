# 1. Setup the Label
   CC_LABEL=gocc.1.0-2.0
   CORE_PEER_ADDRESS=localhost:7051

# 2. Generate the package
   peer lifecycle chaincode package ./packages/$CC_LABEL.tar.gz --label $CC_LABEL -p chaincode_example02

# 3. Install the package
   peer lifecycle chaincode install ./packages/$CC_LABEL.tar.gz

# 4. Get the package ID
   peer lifecycle chaincode queryinstalled

CC_PACKAGE_ID=gocc.1.0-2.0:bcabff000e5a83ab1136309957cecd5bac200dab479845124dcbdf61706e47bc

# 6. Approve the new package

# Keep the same sequence number

peer lifecycle chaincode approveformyorg -n gocc -v 1.0 -C acmechannel --sequence 1 --init-required --package-id $CC_PACKAGE_ID --peerAddresses $CORE_PEER_ADDRESS

# ---