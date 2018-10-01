#!/bin/bash


################### Exercicio a ################
#
# Compila e gera a versão gráfica do transdutor que tem "potato"
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  mmm2mm.txt | fstarcsort > mmm2mm.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait mmm2mm.fst | dot -Tpdf  > mmm2mm.pdf

fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  numerico2numerico.txt | fstarcsort > numerico2numerico.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait numerico2numerico.fst | dot -Tpdf  > numerico2numerico.pdf

################### Testa os tradutores ################
#
# Compila e gera a versão gráfica do transdutor que traduz Inglês em Português
fstconcat numerico2numerico.fst mmm2mm.fst > misto2numerico.fst
fstdraw --isymbols=syms.txt --osymbols=syms-out.txt  --portrait misto2numerico.fst | dot -Tpdf > misto2numerico.pdf
