peer chaincode invoke --isInit -n gocc -C acmechannel -c '{"Args":["init","a","100","b","200"]}'

peer chaincode query -C acmechannel -n gocc -c '{"Args":["query","a"]}'

peer chaincode invoke -C acmechannel -n gocc -c '{"Args":["invoke","a","b","10"]}'