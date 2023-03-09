# Demostrates how the TLS can be enabled using the vars
export  FABRIC_CFG_PATH=$PWD

echo $PWD

# Enable the TLS
export  ORDERER_GENERAL_TLS_ENABLED=true
# Setup the Private key, Certificate & Root CA Certs
export  ORDERER_GENERAL_TLS_PRIVATEKEY=./crypto-config/ordererOrganizations/hospital.com/orderers/orderer.hospital.com/tls/server.key
export  ORDERER_GENERAL_TLS_CERTIFICATE=./crypto-config/ordererOrganizations/hospital.com/orderers/orderer.hospital.com/tls/server.crt
export  ORDERER_GENERAL_TLS_ROOTCAS=[./crypto-config/ordererOrganizations/hospital.com/orderers/orderer.hospital.com/tls/ca.crt]

# You may override this *but* make sure you adjust the clean.sh accordingly
export ORDERER_FILELEDGER_LOCATION=../ledgers

# Start the orderer
orderer