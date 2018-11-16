#!/bin/bash
declare -a list
NODE_LIST=({IPBP} BlockProducer {IPFULL} FullNode)
TELEGRAM_API="https://api.telegram.org/bot"
BOT_ID="{BOT_ID}"
CHAT_ID="{CHAT_ID}"
echo ${#NODE_LIST[@]}




while [ true ]; do
        for ((i=0;i<${#NODE_LIST[@]};i+=2))
	do
		echo $i
                echo ${NODE_LIST[$i]}
		curl http://${NODE_LIST[$i]}:8888/v1/chain/get_info > a
                sleep 1
  		a=$(more a )
  		sleep 1
			if [ -z "$a"  ]; then
     				curl -X POST $TELEGRAM_API$BOT_ID/sendMessage -d "chat_id=${CHAT_ID}&text=Nodeos stuck on ${NODE_LIST[$i+1]}">/dev/null 2>/dev/null
     			fi
	done
sleep 5
done
