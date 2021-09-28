#!/bin/sh

rm -rf $HOME/test
rm $HOME/list1
rm -rf $HOME/man.dir

#1
mkdir $HOME/test

#2
touch $HOME/test/list
ls -1 -p -A -R /etc >> $HOME/test/list

#3
cat $HOME/test/list | grep "/$" | wc -l >> $HOME/test/list
cat $HOME/test/list | grep "^\." | wc -l >> $HOME/test/list

#4
mkdir $HOME/test/links

#5
ln $HOME/test/list $HOME/test/links/list_hlink

#6
ln -s $HOME/test/list $HOME/test/links/list_slink

#7
echo "list_hlink has $(find / -samefile $HOME/test/links/list_hlink 2> /dev/null | wc -l) links"
echo "list has $(find / -samefile $HOME/test/list 2> /dev/null | wc -l) links"
echo "list_slink has $(find / -samefile $HOME/test/links/list_slink 2> /dev/null | wc -l) links"

#8
wc -l $HOME/test/list >> $HOME/test/links/list_hlink

#9
if cmp -s $HOME/test/links/list_hlink $HOME/test/links/list_slink
then
	echo "YES"
fi

#10
mv $HOME/test/list $HOME/test/list1

#11
if cmp -s $HOME/test/links/list_hlink $HOME/test/links/list_slink
then
	echo "YES"
fi

#12
ln $HOME/test/list1 $HOME/list1

#13
find /etc/ -name "*.conf" > $HOME/list_conf

#14
find /etc/ -name "*.d" -type d > $HOME/list_d

#15
cat $HOME/list_conf $HOME/list_d > $HOME/list_conf_d

#16
mkdir $HOME/test/.sub

#17
cp $HOME/list_conf_d $HOME/test/.sub/

#18
cp -b $HOME/list_conf_d $HOME/test/.sub/

#19
ls -A -R -p -1 $HOME/test

#20
man man > $HOME/man.txt

#21
split -b 1024 $HOME/man.txt "$HOME/man.txt_"

#22
mkdir $HOME/man.dir

#23
mv $HOME/man.txt_* $HOME/man.dir

#24
cat $HOME/man.dir/man.txt_* > $HOME/man.dir/man.txt

#25
if cmp -s $HOME/man.txt $HOME/man.dir/man.txt
then
	echo "YES"
fi

#26
echo -e "gfsgsdfgfdsg\ngsggsgre\n" >> $HOME/man.txt
echo -e "fasdfsagiragm\ngergsegresg\n" > $HOME/temp
cat $HOME/man.txt >> $HOME/temp
mv $HOME/temp $HOME/man.txt

#27
diff -u $HOME/man.dir/man.txt $HOME/man.txt > $HOME/man.txt.patch

#28
mv $HOME/man.txt.patch $HOME/man.dir/

#29
patch -f -s $HOME/man.dir/man.txt $HOME/man.dir/man.txt.patch

#30
if cmp $HOME/man.dir/man.txt $HOME/man.txt
then
	echo "YES"
fi
