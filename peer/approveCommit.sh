# 1. Get the package ID
    #  peer lifecycle chaincode queryinstalled

CC_PACKAGE_ID=hosp.1.0-1.0:5651fc772cd9c3d342c917aebf6c7d11634c0f62b42a47e121d427f3d920041c 

# 2. Approve the chaincode
peer lifecycle chaincode approveformyorg -n hosp -v 1.0 -C hospitalchannel --sequence 1 --init-required --package-id $CC_PACKAGE_ID

# 3. Check Commit Readiness
peer lifecycle chaincode checkcommitreadiness -n hosp -v 1.0 -C hospitalchannel --sequence 1 --init-required

  #  peer channel getinfo -c channelName -> to see the approve tx

# 4. Commit the chaincode
   peer lifecycle chaincode commit -n hosp -v 1.0 -C hospitalchannel --sequence 1 --init-required

# 5. Check committed
   peer lifecycle chaincode querycommitted -n hosp -C hospitalchannel