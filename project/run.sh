#!/bin/bash


### a)  misto2numerico

# Cria o transdutor que converte de mmm para mm
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  mmm2mm.txt | fstarcsort > mmm2mm.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait mmm2mm.fst | dot -Tpdf  > mmm2mm.pdf

# Cria o transdutor que processa numeros e '/'
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  numerico2numerico.txt | fstarcsort > numerico2numerico.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait numerico2numerico.fst | dot -Tpdf  > numerico2numerico.pdf

# Cria o transdutor que converte uma data do formato condensado misto para o numérico
fstconcat numerico2numerico.fst mmm2mm.fst > misto2numerico_aux.fst
fstconcat misto2numerico_aux.fst numerico2numerico.fst > misto2numerico.fst
fstdraw --isymbols=syms.txt --osymbols=syms-out.txt  --portrait misto2numerico.fst | dot -Tpdf > misto2numerico.pdf

