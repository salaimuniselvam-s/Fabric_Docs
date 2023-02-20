rm -rf packages #remove recursively and force delete subdirectories
mkdir -p packages  #create directories with subdirectory


CC_LABEL=hosp.1.0-1.0
CC_PACKAGE_FILE=./packages/$CC_LABEL.tar.gz


peer lifecycle chaincode package $CC_PACKAGE_FILE --path ../chaincode --lang node --label $CC_LABEL
# peer lifecycle chaincode package $CC_PACKAGE_FILE -p hospital_chaincode --label $CC_LABEL

peer lifecycle chaincode install $CC_PACKAGE_FILE

peer lifecycle chaincode queryinstalled