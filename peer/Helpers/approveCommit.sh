CC_PACKAGE_ID=gocc.1.0-1.0:be99a89e88b8a9085164bdb078b4ad1e9c5ce89f72b1da0edbf16f80dd08f7ea

peer lifecycle chaincode approveformyorg -n gocc -v 1.0 -C acmechannel --sequence 1 --init-required --package-id $CC_PACKAGE_ID

peer lifecycle chaincode checkcommitreadiness -n gocc -v 1.0 -C acmechannel --sequence 1 --init-required

peer channel getinfo -c channelName

peer lifecycle chaincode commit -n gocc -v 1.0 -C acmechannel --sequence 1 --init-required

peer lifecycle chaincode querycommitted -n gocc -C acmechannel