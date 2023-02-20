# Fabric_Docs

### Cryptogen

Crytogen is used to generate Crypto Materials (private/public key pair)

```
 cryptogen showtemplate -> to show sample templates

 cryptogen generate --config= yaml file path -> to generate config files for given yaml

 --output -> to specify output directory

 cryptogen extend --config=Yaml file Path --input=existing crypto materials folder path -> to add new crypto materials without overriding the old Materials
```

### Configtxgen

configtxgen is an utility for managing configuration artifacts.

-> For managing Geneisis Block, Create Channel Tx, Update Anchor Peers Tx
Note: Anchor Peer Update is deprecated in Fabric2.0

configx yaml consists of six sections.

1. Organization -> Lists the member Organisations
2. Orderer -> Configuration for the orderer
3. Application -> Application Configuration
4. Channel -> Channel Related Parameters
5. Capabilities -> Binary Version Management
6. Profiles -> Setup Multiple Configuration in a file

- Creating the genesis block

  - -outputBlock -> to generate genesis block
  - -inspectBlock -> to inspect the genesis block in json

    - Requirements
      - Configuration for Orderer, Orderer Organisation(Msp), Consortium(Msp)
    - Use Case
      - Genesis File Created is Used to launch the orderer
    - How
      - configtxgen -outputBlock ./blockName.block(custom Name given for the block) -profile Sms(Referenced to the profile section in the yaml-Not custom) -channelID ordererChannel(custom channel Name)
      - eg: configtxgen -outputBlock ./genesis.block -profile sms -channelID ordererchannel (Note -> not working in fabric 2.0)

- Creating the Channel Transaction

  - -outputChannelCreateTx -> to generate Channel Transaction
  - -inspectChannelCreateTx -> to inspect the Channel Transaction in json

    - How
      - configtxgen -outputChannelCreateTx ./channelName.tx -profile ChannelNameInTheYaml -channelID customChannelName
      - eg: configtxgen -outputChannelCreateTx ./acme-channel.tx -profile AcmeChannel -channelID acmechannel
    - Use Case
      - The created Transaction is submitted to the network by the peers

- To Update the Anchor Peer Transaction (deprecated in Fabric 2.0)

  - -outputAnchorPeersUpdate -> to generate Anchor Peer Update Transaction
  - -inspectChannelCreateTx -> to inspect the Anchor Peer Update Tx in json

    - How
    - configtxgen -outputChannelCreateTx ./channelName.tx -profile ChannelNameInTheYaml -channelID customChannelName -asOrg orgName
    - eg: configtxgen -outputChannelCreateTx ./acme-channel.tx -profile AcmeChannel -channelID acmechannel -asOrg org1(update only for the org1 )
    - Use Case

      - The created Transaction is submitted to the network by the Org Admin

    - configtxgen -printOrg OrgName -> list the details of org in json

```
 FABRIC_CFG_PATH = path of the config yaml file ( if not set -> pwd)

 Config Can be Overriden by Environment Varible (export CONFIGTX_ORDERER_ORDERERTYPE=kafka(which overrides the orderer in the yaml))
```

### Orderer

Solo,Kafka,Raft for ordering & distribution. Raft(recommended)

- Requirements
  - Genesis Block needed for initialisation
    eg: genesis block -> Orderer -> LedgerData (location is set by config)
  - It needes ordere msp and config in runtime
- UseCase
  - Exposes grpc services to peers and clients
  - support Transport Layer Security(Tls) & for messaging use protobuf
- Orderer Yaml
  1. General -> General Properties of the orderer
  2. FileLedger -> Filesystem Location to which the orderer persists the ledger
  3. Consensus -> Used for managing storage for Orderer Type etcdraft
  4. Kafka -> Kafka Environmental Setup
  5. debug -> Debug Information Control
  6. Operations -> Operations Endpoint used for network monitorling | alerting
  7. Metrics -> Configurations For Collection of Metrics emitted by orderer
- Setting Up

  - Orderer can be set with | without system channel .
    - with system channel -> Bootstrap Method: -> BootstrapFile: genesisFilePath in yaml
    - without system channel -> Bootstrap Method:none
  - In FileLedger subsection, you can specify the path for the ledger in the location field.
  - LocalMSPDir -> Directory for the private crypto material needed by the orderer

- Cryto Service Provider in Orderer

  - Orderer use csp for cryptographic functions.
  - Implementations

    - Through Software or HardWare Csp (Pkcs#11 -> platform independant standard)
    - In general section, under BCCSP(Blockchain Crypto Service Provider) you have to specify those details of the csp.
    - Note: BCCSP setup must be consistent across network.

    ```
    # BCCSP Setup
    BCCSP:
        # Setup to use the Software CSP
        Default: SW
        SW:
            HASH: SHA2
            Security: 256
            # Using the default 'LocalMSPDir/keystore'
            FileKeyStore:
                Keystore:
    ```

- gRpc Setup for Orderer
  - Listen Address: IP Address on which orderer will accept incoming Connections
  - Listen Port: Port Number (default 7050)
  - eg: Orderer -> grpc Connection -> peers
  - keepAlive for daemon process
  - grpc supports Tls/ssl Integration (used for client & server authentication)
- Orderer Setup in Production
  - solo (single point of failure & which is build in the orderer binary of hlf),kafka(depecrated),Preferred is etcdraft.
  - kafka
    - Always setup as a cluster & hlf channels are created as topics
    - avoids single point of failure.
    - high performance & high througput
    - have to modify the orderer type to kafka in the config file & need to the give the kafka configuration in the orderer yaml.

### Peer

- Peer Process is a node in the HL network.
- Its also used as utility for managing the peer & network configuration ( core.yaml )
- Exposes Grpc like orderer and also levarages CSP like orderer
- eg command: peer lifecycle chaincode (peer node start | pause | resume | reset | rollback)
- demo-> simple-two-org( peer & orderer folder)

- Peer Channel Command

  - create -> create the channel on the network
  - join -> peer joins the specified channel
  - list -> list the channels that peer has joined
  - fetch -> performs an operation on orderer to fetch a block
  - getInfo -> gets Information on the specifed channel
  - signConfigTx -> For signing the config transaction file
  - update -> update the existing channel config

  - CreateChannel Command
    - requires createChannel Transaction file created by the configtxgen ( -f or file ./transactionfile)
    - requires channelId ( -c or -channelId) & optional timeout
    - orderer addresses is provided by -o flag (eg: -o localhost:7050)
    - peer uses core.yaml & channelTx -> invoke orderer through grpc -> orderer create the channel
      - then genisis block for the channel is created on the peer ledger
      - other members can get the copy of the genesis block by fetch
    - executed by admin of the args
  - JoinChannel command
    - requires the genesis block for the channel (eg: peer channel join -b ./filePathOfTheGenisisBlockOfChannel)
    - executed by admin of the args
    - to list the channels which peer joined -> peer channel list

  ```
  peer channel create -o localhost:7050 -c acmechannel -f $CONFIG_DIRECTORY/acme-channel.tx


  launch -> peer node start -o localhost:7050

  join-> peer channel join -o localhost:7050 -b ./acme-channel.block

  list -> peer channel list
  ```

  - In a Fabric Network, Peer will create channel through orderer by using **peer channel create** command, it will generate the genesis block for the channel. Other Orgs want to join the channel can get the genesis block through **peer channel fetch** command and then can join it..

  - Peer channel fetch
    - fetch command fetches the specified block from the orderer
      eg: peer channel fetch -o ordererPortAddr -c channelID --flags
      flags -> oldest,newest,config (for updating the channel configuration),BlockNumber
  - Peer channel getinfo

    - getinfo gets the channel information from the local blockChain
      (current height and blockHashes)
      eg: peer channel getinfo -c channelName

  - peer channel signconfigtx and update

    - TO update the configuration of the existing channel , first some org need to fetch the latest config using **peer channel fetch config -o ordererAddress -c channelName** command, update it using **configxlator** tool, if needed it has to sign by the other organisation using **peer channel signconfigtx** command, then it will submitted to the network by using **peer channel update** command.

    - signconfigtx enables the admin to sign the updated config by using adminIdentity
    - workflow: updatedCOnfig -> peer binary signed it by using admins msp -> signedUpdatedConfig( 1. admin certificate is added , 2. payload added by admin's key)
    - file updated not regenerted ( verify it by size of the config file)
    - does not need to submit the tx to orderer
    - eg: peer channel signconfigtx -f ./filePathOfTheUpdatedConfig
    - To view the genesisChannelBlock in json, use -> configtxlator proto_decode --type common.Block --input acmechannel.block --output ./test.json

  - peer channel update
    - it enables the admin to submit the signedUpdatedConfig to the orderer
    - eg: peer channel update -f ./filePathOfTheUpdatedConfig -o ordererAddress -c channelName

### Chaincode LifeCycle

It involves Chaincode Development, Installation , Approving and committing on the channel.

- Develop the smartcontract and pack the chaincode which result in chaincode.tar.gz which contains code.tar.gx and metadata.json.
- Package needs to be installed on peers and approve it by the orgs before using it.
- package id must be same within org but does not need to be same across orgs.
- peer lifecycle chaincode commands (package | install | queryInstalled)
