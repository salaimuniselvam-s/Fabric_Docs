## Upgrade the Chaincode

1. Set up the Label [name = gocc version = 2.0 Org specific version = 3.0]
   CC_LABEL=gocc.2.0-2.0
   CORE_PEER_ADDRESS=localhost:7051

2. Generate the package
   peer lifecycle chaincode package ./packages/$CC_LABEL.tar.gz --label $CC_LABEL -p chaincode_example02

3. Install the package
   peer lifecycle chaincode install ./packages/$CC_LABEL.tar.gz

peer lifecycle chaincode queryinstalled
CC_PACKAGE_ID=gocc.2.0-3.0:48440424d79ae18c790e790d8241f254593ab552fa6b0dddf4c63fc40af4ad08

4. Approve the chaincode
   peer lifecycle chaincode approveformyorg -n gocc -v 2.0 -C acmechannel --sequence 2 --package-id $CC_PACKAGE_ID --peerAddresses $CORE_PEER_ADDRESS

5. Commit the chaincode
   peer lifecycle chaincode commit -n gocc -v 2.0 -C acmechannel --sequence 2 --peerAddresses $CORE_PEER_ADDRESS

6. Check committed
   peer lifecycle chaincode querycommitted -n gocc -C acmechannel