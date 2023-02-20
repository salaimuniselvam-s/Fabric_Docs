# =====================
# Init, Query & Invoke
# =====================

# Make sure that sample chaincode is committed

# Refer to the commands above

# Ensure that env is setup in the terminal

. env.sh

# 1. Init the chaincode
   peer chaincode invoke --isInit -n hosp -C hospitalchannel -c '{"Args":["init","a","100","b","200"]}'

# 2. Query the chaincode
   peer chaincode query -C hospitalchannel -n hosp -c '{"Args":["query","a"]}'

# 3. Invoke the chaincode
   peer chaincode invoke -C hospitalchannel -n hosp -c '{"Args":["invoke","a","b","10"]}'
