#!/bin/sh
dir=$(dirname $(readlink -f $0))
build=${dir}/build
latexdir=${build}/latex
epubdir=${build}/epub
pbranch=$(hg branch)

cd ${dir}
make clean
for branch in $(hg branches -q); do
    hg update ${branch}
    make latex
    cd ${latexdir}
    make all-pdf
    cd ${dir}
    mv ${latexdir}/python-tutorial*.pdf ${dir}/
    make epub
    mv ${epubdir}/python-tutorial*.epub ${dir}/
done
hg update ${pbranch}
