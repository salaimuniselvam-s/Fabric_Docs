WAIT_TIME=5s
ORDERER_ADDRESS="localhost:7050"

#1.  Kill the peer process if it is running
killall peer

#2 Sets up the environment
. env.sh

./clean.sh   all

#4 Check if orderer is up
if pgrep -x "orderer" > /dev/null
then
    echo "2. Orderer is running."
else
    echo "2. Please launch the Orderer & run init again"
    exit 1
fi

echo   '3. Creating the channel: acmechannel - may fail if already created'
peer channel create -o $ORDERER_ADDRESS -c acmechannel -f $CONFIG_DIRECTORY/acme-channel.tx

#6 Launch the peer in background
peer node start  

# ./joinChannel.sh 
# ./approveCommit.sh 
# ./queryInvoke.sh
# ./localUpdate.sh
# ./UpgradeChaincode.sh
