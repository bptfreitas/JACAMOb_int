#!/bin/bash

> libjasonint.h

echo "#ifndef __LIBJASONINT_H__" >> libjasonint.h
echo "#define __LIBJASONINT_H__" >> libjasonint.h

for header in $( ls jason*.h); do 

    echo "#include <$header> " >> libjasonint.h

done

echo "#endif" >> libjasonint.h




