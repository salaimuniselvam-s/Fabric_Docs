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

[configtxgen](https://hyperledger-fabric.readthedocs.io/en/release-2.5/commands/configtxgen.html?highlight=configtxgen#configtxgen)

```
The configtxgen command allows users to create and inspect channel config related artifacts. The content of the generated artifacts is dictated by the contents of configtx.yaml.
Usage of configtxgen:
  -asOrg string
        Performs the config generation as a particular organization (by name), only including values in the write set that org (likely) has privilege to set
  -channelCreateTxBaseProfile string
        Specifies a profile to consider as the orderer system channel current state to allow modification of non-application parameters during channel create tx generation. Only valid in conjunction with 'outputCreateChannelTx'.
  -channelID string
        The channel ID to use in the configtx
  -configPath string
        The path containing the configuration to use (if set)
  -inspectBlock string
        Prints the configuration contained in the block at the specified path
  -inspectChannelCreateTx string
        Prints the configuration contained in the transaction at the specified path
  -outputAnchorPeersUpdate string
        [DEPRECATED] Creates a config update to update an anchor peer (works only with the default channel creation, and only for the first update)
  -outputBlock string
        The path to write the genesis block to (if set)
  -outputCreateChannelTx string
        The path to write a channel creation configtx to (if set)
  -printOrg string
        Prints the definition of an organization as JSON. (useful for adding an org to a channel manually)
  -profile string
        The profile from configtx.yaml to use for generation.
  -version
        Show version information

```
