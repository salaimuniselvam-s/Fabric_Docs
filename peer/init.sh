# Initializes the setup
# Init.sh all overrwites the core

# Initializes the node
WAIT_TIME=5s
ORDERER_ADDRESS="localhost:7050"

#1.  Kill the peer process if it is running
killall peer

#2 Sets up the environment
. env.sh


#3 Cleanup the peer
echo   '1. Clean up all executed'
if [ "$1" == "all" ]; then
    ./clean.sh   all
else 
    ./clean.sh
fi

#4 Check if orderer is up
if pgrep -x "orderer" > /dev/null
then
    echo "2. Orderer is running."
else
    echo "2. Please launch the Orderer & run init again"
    exit 1
fi

# peer node start

#5 Create the channel
echo   '3. Creating the channel: hospitalchannel - may fail if already created'
peer channel create -o localhost:7050 -c hospitalchannel  -f $CONFIG_DIRECTORY/hospital-channel.tx 

#dialing: dial tcp [::1]:7051: connect: connection refused" - peer is not running


# If channel already created then -  use the following to fetch channel genesis
#peer channel fetch 0 -o localhost:7050  -c hospitalchannel  hospitalchannel.block

#6 Launch the peer in background
peer node start  &

#7 Wait for the peer to launch
echo   '4. Sleeping for WAIT_TIME'
sleep   $WAIT_TIME

#8 Join the channel
echo   '5. Joining channel'
peer channel join -o $ORDERER_ADDRESS -b ./hospitalchannel.block
# Orderer is not needed..
# Error: received bad response, status 500: Invalid chain ID, hospitalchannel -> not yet joined the channel


#9 Check if the join was successful
# echo   '6. Listing channel'
peer channel list

#10 Kill the peer
# echo   '7. Kill the peer process'
killall peer

# echo "All Steps Executed."
echo "Launch Peer using ./start-node.sh"


# After
#  ./install.sh
#  ./approveCommit.sh
#  ./initQI.sh

# Expect block, but got status: &{NOT_FOUND} -> you have to specify the channel name, while fetching the details. eg: peer channel fetch config -c hospitalchannel

# configtxgen -outputAnchorPeersUpdate  ./updateTx.tx -profile hospitalchannel -channelID hospitalchannel -asOrg Org1

#peer channel update -f ./updateTx.tx -o localhost:7050 -c hospitalchannel

# configtxlator proto_decode --type common.Block --input hospitalchannel.block --output ./test.json