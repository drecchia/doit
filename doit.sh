#!/bin/sh
# feito por ALASKA - #itapirados / #linuxall
# "Doit - by ALASKA - 05/01/2001"
#
unike="uniq /tmp/teste /tmp/teste2"
function rebok () {
echo "File-Dir `cat /tmp/teste2` extracted"
}
if [ -e /tmp/kitS ];then
rm -rf /tmp/kitS
fi
if [ ! $1 ];then
echo
setterm -bold on 
echo "                          Doit - by ALASKA - 12/01/2001"
setterm -default
echo
echo "     Descompact files type : bz2 , arj , tar , tgz , gz , tar.Z , Z , zip e tar.bz2"
echo "     Usage : doit file"
echo 
exit
fi 
function asktea () {
setterm -bold on -foreground red
echo 'O arquivo contem estes arquivos soltos...'
setterm -foreground green
echo 'Deseja continuar mesmo assim?'
setterm -default
}
function nobugs () {
rm -f /tmp/teste /tmp/teste2
exit
}
if [ ! -e $1 ];then
	setterm -bold on -foreground red
	echo
	echo "  	                         Arkivo inexistente"
	echo
	setterm -default
	nobugs
fi 
setterm -bold on -foreground yellow
echo 'Detecting type of selected file................'
setterm -default
if [ `file -b $1 | grep "tar" | wc -l` = '1' ];then 
	setterm -foreground cyan -bold on
	echo 'File type tar detected...'
	echo 'Doing...'
	setterm -default
	tar tf $1 | cut -d"/" -f1 > /tmp/teste 
	$unike
	if [ `cat /tmp/teste2 | wc -l` = 1 ];then
		tar xf $1
		rebok
		nobugs
	else
		tar tf $1
		asktea
		read ofcourse
		if [ "$ofcourse" = 'y' -o "$ofcourse" = 'Y' -o "$ofcourse" = 's' -o "$ofcourse" = 'S' ];then
 			tar xf $1 
			nobugs
		else
			nobugs
		fi 
	fi 
fi 
if [ `file -b $1 | grep "gzip" | wc -l` = '1' ];then 
	if [ `gunzip -l $1 2> /dev/null | grep -i ".tar" | wc -l` = '1' ];then
		setterm -foreground cyan -bold on
		echo 'File type tgz detected...'
		echo 'Doing .......'
		setterm -default
		tar tzf $1 | cut -d"/" -f1 > /tmp/teste 
		$unike
		if [ `cat /tmp/teste2 |wc -l` = 1 ];then
			tar xzf $1 
			rebok
			nobugs
		else
			tar tzf $1
			asktea
			read vaimesmo 
			if [ "$vaimesmo" = 's' -o "$vaimesmo" = 'S' -o "$vaimesmo" = 'y' -o "$vaimesmo" = 'Y' ];then
			tar xzf $1 
			nobugs
			else
			nobugs
			fi 
		fi 
	else
		setterm -foreground cyan -bold on
		echo 'File type gz detected...'
		echo 'Doing .......'
		frota=`gunzip -l $1 |cut -d'%' -f2|grep -v ratio`
		gunzip $1 
		setterm -default
		echo "File/Dir $frota Extracted"
		nobugs
	fi 
fi 
if [ `file $1 | grep '.Z:' | wc -l` = '1' ];then
	if [ `zcat -l $1 2> /dev/null | grep -i ".tar" | wc -l` = '1' ];then
	setterm -foreground cyan -bold on
	echo 'File type TAR-Compress detected...'
	echo 'Doing...'
	setterm -default
	tar tzf $1 | cut -d"/" -f1 > /tmp/teste 
	$unike
	if [ `cat /tmp/teste2 |wc -l` = 1 ];then
		tar xZf $1 
		rebok
		nobugs
	else
		tar tZf $1
		asktea
		read vimesmo 
		if [ "$vimesmo" = 's' -o "$vimesmo" = 'S' -o "$vimesmo" = 'y' -o "$vimesmo" = 'Y' ];then
			tar xZf $1 
			nobugs
		else
			nobugs
		fi 
	fi 
else
	setterm -foreground cyan -bold on
	echo 'File type Compress detected...'
	echo 'Doing...'
	setterm -default
	zcat $1 | cut -d"/" -f1 > /tmp/teste
	$unike
	if [ `cat /tmp/teste2 |wc -l` = 1 ];then	
		uncompress $1 
        	rebok 
        	nobugs
        else
		zcat $1
		asktea
		read vaimemo
		if [ "$vaimemo" = 's' -o "$vaimemo" = 'S' -o "$vaimemo" = 'y' -o "$vaimemo" = 'Y' ];then
			uncompress $1
			nobugs
		else
			nobugs
		fi 
	fi 
fi 
fi
if [ `file -b $1 | grep 'Zip' | wc -l` = '1' ];then
	setterm -foreground cyan -bold on
	echo 'File type Zip detected...'
	echo 'Doing...'
	setterm -default
	zipinfo $1 |grep -v "Archive:"|grep -v "files,"|grep -v "file," |cut -d":" -f2|cut -d" " -f2| cut -d"/" -f1 > /tmp/teste
	$unike
	if [ `cat /tmp/teste2 |wc -l` = '1' ];then
		unzip $1 &> /dev/null 
		rebok
		nobugs
	else
		zipinfo $1
		asktea
		read vamula
		if [ "$vamula" = 's' -o "$vamula" = 'S' -o "$vamula" = 'y' -o "$vamula" = 'Y' ];then
			unzip $1 &> /dev/null 
			nobugs
		else
			nobugs
		fi
	fi
fi 
if [ `file -b $1 | grep 'bzip2' | wc -l` = '1' ];then
 	if [ `echo $1 | grep -i '.tar'| wc -l` = '1' -o `echo $1 | grep -i '.tbz2'| wc -l` = '1' ];then
	setterm -foreground cyan -bold on
        echo 'File type TAR-Bzip2 detected...'
        echo 'Doing...'
        setterm -default	
	tar tyf $1 | cut -d"/" -f1 > /tmp/teste
	$unike
	if [ `cat /tmp/teste2 | wc -l` = '1' ];then
		tar xyf $1 
		rebok
		nobugs	
	else
		tar tyf $1
		asktea	
		read tonessa
		if [ "$tonessa" = 'y' -o "$tonessa" = 'Y' -o "$tonessa" = 's' -o "$tonessa" = 'S' ];then
			tar xyf $1 
			nobugs
		else
			nobugs
		fi

	fi
	else
		setterm -foreground cyan -bold on
        	echo 'File type Bzip2 detected...'
        	echo 'Doing...'
        	setterm -default
		bunzip2 -v $1 
		nobugs
fi
fi 
if [ `file -b $1 | grep "tar" | wc -l` = '0' ];then
if [ `file -b $1 | grep "gzip" | wc -l` = '0' ];then
if [ `file -b $1 | grep 'Zip' | wc -l` = '0' ];then
if [ `file $1 | grep '.Z:' | wc -l` = '0' ];then
if [ `file -b $1 | grep 'bzip2' | wc -l` = '0' ];then
if [ `file -b $1 | grep 'ARJ' | wc -l` = '0' ];then
echo
echo "                            Tipo de arkivo nao Suportado"
echo
nobugs
fi
fi
fi
fi
fi
fi
if [ `file -b $1 | grep 'ARJ' | wc -l` = '1' ];then
	setterm -foreground cyan -bold on
	echo 'File type ARJ detected...'
	echo 'Doing...'
        setterm -default
	unarj l $1 | grep -v Filename|grep -v files|grep -v UNARJ | grep -v arj|grep -v Archive|cut -d" " -f1| grep -v "-" > /tmp/teste
	$unike
	if [ `cat /tmp/teste2 |wc -l` = 2 ];then
		unarj e $1 &> /dev/null 
		rebok
		nobugs
	else
		unarj l $1 | grep -v Filename|grep -v files|grep -v UNARJ | grep -v arj|grep -v Archive|cut -d" " -f1| grep -v "-"
		asktea
		read pross
		if [ "$pross" = 's' -o "$pross" = 'S' -o "$pross" = 'Y' -o "$pross" = 'y' ];then
			unarj e $1 &> /dev/null 
			nobugs
		else
			nobugs
		fi
	fi
fi
