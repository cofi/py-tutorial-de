#!/bin/sh
dir=$(dirname $(readlink -f $0))
latexdir=${dir}/build/latex
pbranch=$(hg branch)

for branch in "python-3.1" "python-3.2"; do
    hg update ${branch}
    make latex
    cd ${latexdir}
    make all-pdf
    cd ${dir}
    date=$(date +%Y-%m-%d)
    mv ${latexdir}/python-tutorial.pdf ${dir}/tutorial-${branch}-${date}.pdf
done
hg update ${pbranch}
