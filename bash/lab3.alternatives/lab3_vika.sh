#!bin/bash
fnction func1{
    d=$1 #d - каталог
    cd $d
    ls -A | while read f
        do
            if [[ -d $f ]] ; then
                (func1 $f)
            else
                echo $f | grep '^a'
                if [[ $? == 0 ]]; then
                    newf=`echo $f | sed 's/^a/b'`
                    mv $f $newf
                fi
            fi
        done
}

func1 .
