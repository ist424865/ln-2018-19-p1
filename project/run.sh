#!/bin/bash


### a) misto2numerico

# Cria o transdutor que converte de mmm para mm
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  a/mmm2mm.txt | fstarcsort > a/mmm2mm.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait a/mmm2mm.fst | dot -Tpdf  > a/mmm2mm.pdf

# Cria o transdutor que processa numeros e '/'
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  a/numerico2numerico.txt | fstarcsort > a/numerico2numerico.fst

# Cria o transdutor que converte uma data do formato condensado misto para o numérico
fstconcat a/numerico2numerico.fst a/mmm2mm.fst > a/misto2numerico_aux.fst
fstconcat a/misto2numerico_aux.fst a/numerico2numerico.fst > a/misto2numerico.fst
fstdraw --isymbols=syms.txt --osymbols=syms-out.txt  --portrait a/misto2numerico.fst | dot -Tpdf > a/misto2numerico.pdf


### b) pt2en

# Cria o transdutor que converte os meses de PT para EN
fstcompile --isymbols=syms.txt --osymbols=syms-out.txt  b/en2pt.txt | fstarcsort > b/en2pt.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait b/en2pt.fst | dot -Tpdf  > b/en2pt.pdf

# Cria o transdutor que converte os meses de EN para PT
fstinvert b/en2pt.fst > b/pt2en.fst
fstdraw    --isymbols=syms.txt --osymbols=syms-out.txt --portrait b/pt2en.fst | dot -Tpdf  > b/pt2en.pdf


### c) numerico2texto


