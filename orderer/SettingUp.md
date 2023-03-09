1. First Export binary to the cli using
   export PATH=${PWD}/bin:$PATH command

2. then generate crypto materials using
   crypogen generate --config=config.yaml

3. then create the genesis block for the network with orderer using
   configtxgen -profile HospitalOrdererGenesis -outputBlock ./hospital-genesis.block -channelID ordererchannel

4. Then create the transaction for the channel using
   configtxgen -profile HospitalChannel -outputCreateChannelTx ./hospital-channel.tx -channelID hospitalchannel

5. create the orderer yaml and up the orderer using
   orderer

To run Orderer using scripts,

    1. . ./env.sh
    2.  ./clean.sh all ( delete ledger data and fresh start)
    3.  ./init.sh all
    4.  ./launch.sh
