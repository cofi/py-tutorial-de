#!/bin/sh
dir=$(dirname $(readlink -f $0))
latexdir=${dir}/build/latex
branch=$(hg branch)

make latex
cd ${latexdir}
make all-pdf
cd ${dir}

date=$(date +%Y-%m-%d)
mv ${latexdir}/python-tutorial.pdf ${dir}/tutorial-${branch}-${date}.pdf
