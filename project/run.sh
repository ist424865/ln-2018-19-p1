#!/bin/bash


### a) misto2numerico

# Cria o transdutor que converte de mmm para mm
fstcompile --isymbols=syms.txt --osymbols=syms.txt  a/mmm2mm.txt | fstarcsort > a/mmm2mm.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait a/mmm2mm.fst | dot -Tpdf  > a/mmm2mm.pdf

# Cria o transdutor que processa numeros
fstcompile --isymbols=syms.txt --osymbols=syms.txt  a/numerico2numerico.txt | fstarcsort > a/numerico2numerico.fst

# Cria o transdutor que processa barras
fstcompile --isymbols=syms.txt --osymbols=syms.txt  a/barra.txt | fstarcsort > a/barra.fst

# Cria o transdutor que converte uma data do formato condensado misto para o numérico
fstconcat a/numerico2numerico.fst a/barra.fst > a/numerico_barra.fst
fstconcat a/numerico_barra.fst a/mmm2mm.fst > a/misto2numerico_aux.fst
fstconcat a/misto2numerico_aux.fst a/barra.fst > a/misto2numerico_barra.fst
fstconcat a/misto2numerico_barra.fst a/numerico2numerico.fst > a/misto2numerico.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  --portrait a/misto2numerico.fst | dot -Tpdf > a/misto2numerico.pdf


### b) pt2en

# Cria o transdutor que converte os meses de EN para PT
fstcompile --isymbols=syms.txt --osymbols=syms.txt  b/mm_en2pt.txt | fstarcsort > b/mm_en2pt.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait b/mm_en2pt.fst | dot -Tpdf  > b/mm_en2pt.pdf

# Cria o transdutor que converte uma data de EN para PT
fstconcat a/numerico_barra.fst b/mm_en2pt.fst > b/en2pt_aux.fst
fstconcat b/en2pt_aux.fst a/numerico_barra.fst > b/en2pt_barra.fst
fstconcat b/en2pt_barra.fst a/numerico2numerico.fst > b/en2pt.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt  --portrait b/en2pt.fst | dot -Tpdf > b/en2pt.pdf

# Cria o transdutor que converte uma data de PT para EN
fstinvert b/en2pt.fst > b/pt2en.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait b/pt2en.fst | dot -Tpdf  > b/pt2en.pdf


### c) numerico2texto

# Cria o transdutor que converte dia para texto
fstcompile --isymbols=syms.txt --osymbols=syms.txt  c/dia.txt | fstarcsort > c/dia.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait c/dia.fst | dot -Tpdf  > c/dia.pdf

# Cria o transdutor que converte mes para texto
fstcompile --isymbols=syms.txt --osymbols=syms.txt  c/mes.txt | fstarcsort > c/mes.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait c/mes.fst | dot -Tpdf  > c/mes.pdf

# Cria o transdutor que converte ano para texto
fstcompile --isymbols=syms.txt --osymbols=syms.txt  c/ano.txt | fstarcsort > c/ano.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait c/ano.fst | dot -Tpdf  > c/ano.pdf

# Cria o transdutor que adiciona o de entre frações da data
fstcompile --isymbols=syms.txt --osymbols=syms.txt  c/de.txt | fstarcsort > c/de.fst

# Cria o transdutor que converte uma data numerica para texto
fstconcat c/dia.fst c/de.fst > c/diade.fst
fstconcat c/diade.fst c/mes.fst > c/diademes.fst
fstconcat c/diademes.fst c/de.fst > c/diademesde.fst
fstconcat c/diademesde.fst c/ano.fst > c/numerico2texto.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait c/numerico2texto.fst | dot -Tpdf  > c/numerico2texto.pdf


### d) misto2texto e data2texto

# Cria o transdutor que converte do formato condensado misto para texto
fstcompose a/misto2numerico.fst c/numerico2texto.fst > d/misto2texto.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait d/misto2texto.fst | dot -Tpdf  > d/misto2texto.pdf

# Cria o transdutor que converte de qualquer formato para texto
fstunion c/numerico2texto.fst d/misto2texto.fst > d/data2texto.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait d/data2texto.fst | dot -Tpdf  > d/data2texto.pdf


### e) Testa os trandutores

# Cria os trandutores com as datas

# 83562 - Rui Ribeiro: 23/08/2015
fstcompile --isymbols=syms.txt --osymbols=syms.txt  e/83562_misto.txt | fstarcsort > e/83562_misto.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait e/83562_misto.fst | dot -Tpdf  > e/83562_misto.pdf

fstcompile --isymbols=syms.txt --osymbols=syms.txt  e/83562_numerico.txt | fstarcsort > e/83562_numerico.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait e/83562_numerico.fst | dot -Tpdf  > e/83562_numerico.pdf

# 70119 - André Rodrigues: 10/04/2010
fstcompile --isymbols=syms.txt --osymbols=syms.txt  e/70119_misto.txt | fstarcsort > e/70119_misto.fst
fstdraw    --isymbols=syms.txt --osymbols=syms.txt --portrait e/70119_misto.fst | dot -Tpdf  > e/70119_misto.pdf

# Testa o misto2numerico
fstcompose e/83562_misto.fst a/misto2numerico.fst > e/83562_misto_numerico.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait e/83562_misto_numerico.fst | dot -Tpdf > e/83562_misto_numerico.pdf

# Testa o pt2en
fstcompose e/83562_misto.fst b/pt2en.fst > e/83562_misto_en.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait e/83562_misto_en.fst | dot -Tpdf > e/83562_misto_en.pdf

# Testa o numerico2texto
fstcompose e/83562_numerico.fst c/numerico2texto.fst > e/83562_numerico_texto.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait e/83562_numerico_texto.fst | dot -Tpdf > e/83562_numerico_texto.pdf

# Testa o misto2texto
fstcompose e/83562_misto.fst d/misto2texto.fst > e/83562_misto_texto.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait e/83562_misto_texto.fst | dot -Tpdf > e/83562_misto_texto.pdf

# Testa o data2texto
fstcompose e/83562_misto.fst d/data2texto.fst > e/83562_misto_data_texto.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait e/83562_misto_data_texto.fst | dot -Tpdf > e/83562_misto_data_texto.pdf

fstcompose e/83562_numerico.fst d/data2texto.fst > e/83562_numerico_data_texto.fst
fstdraw --isymbols=syms.txt --osymbols=syms.txt --portrait e/83562_numerico_data_texto.fst | dot -Tpdf > e/83562_numerico_data_texto.pdf