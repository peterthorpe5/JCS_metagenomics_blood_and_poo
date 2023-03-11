

conda install -c bioconda krona

ktUpdateTaxonomy.sh

# https://github.com/marbl/Krona/issues/117

ktImportTaxonomy -m 3 -t 5 *.report.txt -o MRC0123_AmM001WB.kraken.html
