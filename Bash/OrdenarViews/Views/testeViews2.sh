#!/bin/bash
arquivo='lista2.sql'

testeString="([user1]=1 [user2]=2 [user3]=3)"
declare -A usernames=$testeString

totalArray=0
strArray="("
for i in `ls -d *.sql`; do
	if [ ${i} != $arquivo ]; then
		strArray=$strArray"[${i}]=$totalArray "
		ARRAY_VIEWS[totalArray]="${i};"$totalArray
		let "totalArray++"
	fi
done
strArray=$strArray")"
declare -A testeArray=$strArray

echo ${testeArray[@]}

echo ${testeArray[VW_094_COMPAREC_ABSTENCAO_BR.sql]}
testeArray[VW_094_COMPAREC_ABSTENCAO_BR.sql]=99
echo ${testeArray[VW_094_COMPAREC_ABSTENCAO_BR.sql]}

echo ${testeArray[@]}
