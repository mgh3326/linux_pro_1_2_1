#!/bin/bash
i=1
function tree_file_info() #트리구조내의 디렉토리나 파일 정보를 출력해주는 함수입니다.
{
echo "	┏[$j] $treefilename"
echo "	┃==========================INFORMATION========================="
echo "	┃[$1mfile type :"`stat -c %F $filename/$treefilename`[0m
echo "	┃file size :"`stat -c %s $filename/$treefilename`
echo "	┃last data modification time :"`stat -c %y $filename/$treefilename`
echo "	┃permission :"`stat -c %a $filename/$treefilename`
echo "	┃absolute path : "`pwd`"/$filename/$treefilename"
echo "	┃relative path : ./$filename/$treefilename"
echo "	┗=============================================================="
j=`expr $j + 1`
}

function order_tree_file() #트리구조 내의 디렉토리 일반파일 특수파일 순으로
{				#출력되도록 하는 함수를 호출합니다.
j=1
for treefilename in `ls $filename | sort` ; do
if [ "`stat -c %F $filename/$treefilename`" = "디렉토리" ]; then #디렉토리 조건
tree_file_info 34 #트리구조내의 디렉토리나 파일 정보를 출력해주는 함수를 호출합니다.
fi			#파라미터의 값으로는 색상의 값을 사용하였습니다.
done
for treefilename in `ls $filename` ; do
if [ "`stat -c %F $filename/$treefilename | cut -c 1-6`" = "일반" ]; then #일반파일 조건
tree_file_info 0
fi
done
for treefilename in `ls $filename` ; do
if [ "`stat -c %F $filename/$treefilename | cut -c 1-3`" != "디" ] && [ "`stat -c %F $filename/$treefilename | cut -c 1-3`" != "일" ]; then #특수파일 조건
tree_file_info 32
fi
done
}

function file_info()#디렉토리나 파일 정보를 출력해주는 함수입니다.
{
echo "┏[$i] $filename"
echo "┃==========================INFORMATION========================="
echo "┃[$1mfile type :"`stat -c %F $filename`[0m
echo "┃file size :"`stat -c %s $filename`
echo "┃last data modification time :"`stat -c %y $filename`
echo "┃permission :"`stat -c %a $filename`
echo "┃absolute path : "`pwd`"/$filename"
echo "┃relative path : ./$filename"
echo "┗=============================================================="
if [ "`file $filename`" = "$filename: directory" ]; then #조건이 디렉토리일때만인 조건입니다.
order_tree_file #트리구조 내의 디렉토리 일반파일 특수파일 순으로
fi			#출력되도록 하는 함수를 호출합니다.
i=`expr $i + 1`
#done
}

function order_file() #파일을 디렉토리 일반파일 특수파일 순으로 출력되도록 하는 함수입니다.
{
for filename in `ls | sort` ; do
if [ "`stat -c %F $filename`" = "디렉토리" ]; then #디렉토리 조건
file_info 34 #디렉토리나 파일 정보를 출력해주는 함수를 호출합니다.
fi		#파라미터로는 색상의 값을 사용하였습니다.
done
for filename in `ls` ; do
if [ "`stat -c %F $filename | cut -c 1-6`" = "일반" ]; then #일반파일 조건
file_info 0
fi
done
for filename in `ls` ; do
if [ "`stat -c %F $filename | cut -c 1-3`" != "디" ] && [ "`stat -c %F $filename | cut -c 1-3`" != "일" ]; then #특수파일 조건

file_info 32
fi
done
}

echo "=== print file information ==="
echo "current directory : "`pwd` #현재 디렉토리의 경로
echo "the number of elements : "`ls | wc -l` #현재 디렉토리의 파일 및 디렉토리 숫자의 총합
order_file #파일을 디렉토리 일반파일 특수파일 순으로 출력되도록 하는 함수를 호출합니다.
