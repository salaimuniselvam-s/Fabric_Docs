# 1. Get the package ID
    #  peer lifecycle chaincode queryinstalled

CC_PACKAGE_ID=hosp.1.0-1.0:687e0b285a66ab2465ff67ac7571e5d06f186708233639b17cfcda188ef7ed66 

# 2. Approve the chaincode
peer lifecycle chaincode approveformyorg -n hosp -v 1.0 -C hospitalchannel --sequence 1 --init-required --package-id $CC_PACKAGE_ID

# 3. Check Commit Readiness
peer lifecycle chaincode checkcommitreadiness -n hosp -v 1.0 -C hospitalchannel --sequence 1 --init-required

  #  peer channel getinfo -c channelName -> to see the approve tx

# 4. Commit the chaincode
   peer lifecycle chaincode commit -n hosp -v 1.0 -C hospitalchannel --sequence 1 --init-required

# 5. Check committed
   peer lifecycle chaincode querycommitted -n hosp -C hospitalchannel