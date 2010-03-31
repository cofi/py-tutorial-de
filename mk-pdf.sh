#!/bin/sh
fpath=$(readlink -f $0)
dir=$(dirname $fpath)
latexdir=${dir}/build/latex

make latex
cd ${latexdir}
make all-pdf
cd ${dir}

date=`date +%Y-%m-%d`
mv ${latexdir}/python-tutorial.pdf ${dir}/python-tutorial${date}.pdf
