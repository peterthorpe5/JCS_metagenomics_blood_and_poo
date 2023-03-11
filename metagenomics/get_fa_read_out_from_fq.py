
######################################################################
# Title: get fq file #
######################################################################

""" This script uses Biopython magic to iterate through a fastq file
and remove duplicate names

why? : obvs"""

# imports
from Bio.SeqIO.QualityIO import FastqGeneralIterator
import os
from sys import stdin,argv
import sys
from optparse import OptionParser


def filter_my_fastq_file (in_fastq, wantedfile, out_fastq):
    """funct to parse fq file. collect names in a set.
    if name not in set write out fq entry
    """
    in_file = open(in_fastq)
    out_file = open(out_fastq, "w")
    dup_count = 0 
    wanted = open(wantedfile, "r")
    name_set = set([])
    # enumerate is a way of counting i
    names = wanted.readlines()
    #print names
    wanted_data = [line.replace("\t", "").rstrip("\n") for line in names
              if line.strip() != ""]
    name_set = set([])
    for i in wanted_data:
        if not i.startswith("#"):
            name_set.add(i)
    #print wanted_data
    count = 0
    for i, (title, seq, qual) in enumerate(FastqGeneralIterator(in_file)):
        # write this to a file
        for name in name_set:
            if name in title:
                count = count + 1
                #title = "read_num_%d" % count
                print(name, title)
                out_file.write(">%s\n%s\n" % (title, seq.upper()))

    out_file.close()
    in_file.close()



if "-v" in sys.argv or "--version" in sys.argv:
    print("v0.0.1")
    sys.exit(0)


usage = """Use as follows:


python get_fastq....py -i infile.fastq  -o outfile.fq


dedup names in fq file.
"""

parser = OptionParser(usage=usage)
parser.add_option("-i", "--in", dest="in_file", default=None,
                  help="Output filename .fastq",
                  metavar="FILE")

parser.add_option("-w", "--wanted", dest="wanted", default=None,
                  help="Output filename .fastq",
                  metavar="FILE")
parser.add_option("-o", "--output", dest="out_file", default=None,
                  help="Output filename - formatted as fastq",
                  metavar="FILE")



(options, args) = parser.parse_args()

infile = options.in_file
wanted =  options.wanted
outfile = options.out_file

if __name__ == '__main__':
    filter_my_fastq_file(infile, wanted, outfile)
                           
