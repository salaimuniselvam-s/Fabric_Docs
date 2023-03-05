./server.sh start
./server.sh enroll
./register-enroll-admins.sh
. ./setclient.sh acme admin
fabric-ca-client register --id.type user --id.name jdoe --id.secret pw --id.affiliation acme.logistics

. ./setclient.sh acme jdoe

fabric-ca-client enroll -u http://jdoe:pw@localhost:7054

. ./add-admincerts.sh acme jdoe

./setup-org-msp.sh admin
./setup-org-msp.sh budget
./setup-org-msp.sh orderer

# in orderer multi org ca folder
./generate-genesis.sh
./register-enroll-orderer.sh
./generate-channel-tx.sh
cd ../../peer/multi-org-ca/
./sign-channel-tx.sh acme
cd ../../orderer/multi-org-ca/
orderer  #launch orderer
# new terminal cd peer/multi-org-ca
./submit-create-channel.sh acme admin

#setting up anchor peer
./register-enroll-peer.sh acme peer1
./launch-peer.sh acme peer1
. set-env.sh acme admin #setting up the msp otherwise error -> Cannot run peer because cannot init crypto, specified path "/ca/multi-org-ca/client/acme/admin/msp" does not exist or cannot be accessed: stat /ca/multi-org-ca/client/acme/admin/msp: no such file or director
peer channel list
./join-airline-channel.sh acme peer1
peer channel list
#adding an regular peer
./register-enroll-peer.sh acme peer2
./launch-peer.sh acme peer1 7050
./launch-peer.sh acme peer2 8050
ps -eal | grep peer #check whether peer is launched or not
. ./set-env.sh acme peer2 8050 admin
peer channel fetch  0 -c airlinechannel -o localhost:7050
. ./set-env.sh acme peer2 8050 admin
peer channel join -o localhost:7050 -b airlinechannel_0.block
./validate-with-chaincode-2.sh

# 18.Updating the network config
#in peer multi-org-ca
. ./set-env.sh acme peer1 7050 admin
./fetch-config-json.sh ordererchannel
./generate-config-update.sh ordererchannel
./sign-config-update.sh acme #sign by acme
./sign-config-update.sh orderer admin #sign by acme
./submit-config-update-tx.sh acme admin ordererchannel
./fetch-config-json.sh ordererchannel # to validate the max_message

#Receipe - Adding a new member org
#check --> ./register-enroll-admins.sh
. set-identity.sh acme admin
./fetch-config-json.sh airlinechannel
./add-member-org.sh
./generate-config-update.sh airlinechannel