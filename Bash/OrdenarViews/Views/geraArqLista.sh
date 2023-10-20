#!/bin/bash
#caminhoProc='/procs/'
#deResourceToViews='../plsql/views'
#deViewsToResource='../../resources'
prefixoProc='/procs/'
prefixoViews='/views/'
arquivo='lista2.sql'

function printArray()
{
	for array in ${ARRAY_VIEWS[@]}; do
		echo $array
	done
}
function printArray2()
{
	for array in ${ARRAY_TEMP[@]}; do
		echo $array
	done
}
function populaArquivo()
{
	for array in ${ARRAY_VIEWS[@]}; do
		echo "${prefixoViews}$(buscaValor 1 ${array})" >> "$arquivo" &
	done
}

function buscaValor()
{
	if [ $1 = 1 ]; then
		awk -F ';' '{print $1}' <<< $2
	elif [ $1 = 2 ]; then
		awk -F ';' '{print $2}' <<< $2
	elif [ $1 = 3 ]; then
		awk -F ';' '{print $3}' <<< $2
	fi
}

function buscaIndex()
{
	for array in "${ARRAY_VIEWS[@]}"; do
#echo $(buscaValor 1 ${array})" | "$1
		if [ $(buscaValor 1 ${array}) = $1 ]; then
			#echo "Indice: "$(buscaValor 2 ${array})
			echo $(buscaValor 2 ${array})
		fi
	done
}

function atualizaArray()
{
	contaArrayViews=$1
	ARRAY_TEMP=( ${ARRAY_VIEWS[@]} )
	#printArray2
	ARRAY_TEMP[$1]=$2";"$1
	for ((iA=$1+1;iA<totalArray;iA++));
	do
		if [ $(buscaValor 1 ${ARRAY_VIEWS[$contaArrayViews]}) = $2 ]; then
			let "contaArrayViews++"
		fi
		ARRAY_TEMP[iA]=$(buscaValor 1 ${ARRAY_VIEWS[$contaArrayViews]})";"$iA
		testeArray[$(buscaValor 1 ${ARRAY_VIEWS[$contaArrayViews]})]=$iA
		let "contaArrayViews++"
	done
	unset ARRAY_VIEWS
	#printArray2
	ARRAY_VIEWS=( ${ARRAY_TEMP[@]} )
}

declare -a ARRAY_VIEWS
totalArray=0
echo "" > $arquivo &

#cd "$deResourceToViews"
strArray="("
echo "====================Popula Array===================="
for i in `ls -d *.sql`; do
	if [ ${i} != $arquivo ] && [ ${i} != "geraArqLista.sh" ] && [ ${i} != "testeViews.sh" ] && [ ${i} != 'testeViews2.sh' ]; then
		strArray=$strArray"[${i}]=$totalArray "
		ARRAY_VIEWS[totalArray]="${i};"$totalArray
		let "totalArray++"
	fi
	#nomeArquivo=$(echo ${ARRAY_VIEWS[totalArray]} |sed -s 's/.sql//g')
	#echo "$nomeArquivo"
	#for arq in $(grep -i -l -w $nomeArquivo *); do
	#	if [ "$arq" != ${ARRAY_VIEWS[totalArray]} ]; then
	#		echo "Arquivo "${ARRAY_VIEWS[totalArray]}" existe na view $arq"
	#	fi
	#done

	#echo "${prefixoViews}${i}" >> "$deViewsToResource"/"$arquivo" &
done
strArray=$strArray")"
declare -A testeArray=$strArray

contador=0
continua='S'

while [ $continua = 'S' ]
do
let "contador++"
continua='N'
	echo "====================while===================="
	for ((index=0;index<totalArray;index++));
	do
		echo "====================For $index===================="
		indicePai=$index
		#echo "====================buscaValor===================="
		nomeViewArray=$(buscaValor 1 ${ARRAY_VIEWS[index]})
		#echo "nomeViewArray:"$nomeViewArray
		#echo "====================nomeArquivo===================="
		nomeArquivo=$(echo $nomeViewArray |sed -s 's/.sql//g')
		#echo "====================For grep===================="
		for arq in $(grep -i -l -w $nomeArquivo *.sql); 
		do
			if [ $arq != $nomeViewArray ]; then
				#echo "====================buscaIndex===================="
				#indiceFilho=$(buscaIndex $arq)
				#echo $(buscaIndex $arq)
				indiceFilho=${testeArray[$arq]}
				echo $nomeArquivo $indicePai $arq $indiceFilho
				#echo $indiceFilho
				if [ $indicePai -gt $indiceFilho ]; then
					#echo $indiceFilho $nomeViewArray $arq
					echo "====================atualizaArray===================="
					atualizaArray $indiceFilho $nomeViewArray $arq
					continua='S'
					indicePai=$indiceFilho
				fi				
				#echo "A view $nomeViewArray $index existe na view $arq "$indiceFilho
			fi
		done
		#echo "número: ${ARRAY_VIEWS[$index]}"
	done
done

populaArquivo

#nomeFilha="Natália;Rodrigues;Canuto"
#nF=$(buscaValor 2 $nomeFilha)
#echo "nF:"$nF
#awk -F ';' '{print $3}' <<< $nomeFilha
#cd "$deViewsToResource"
#echo "Etapa1:"${ARRAY_VIEWS[@]}


#while IFS= read -r linha || [[ -n "$linha" ]]; do
#  echo "$linha"
#done < "$arquivo"
#	if [ $contador = 3 ]; then
#	break;
#	fi