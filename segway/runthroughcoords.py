# input.bed is a file with lines like "chr1 0 8000", you can use the same --include-coords if you're using that
# fancy.genomedata is your archive
from genomedata import Genome
import sys
import numpy

LOD = numpy.array([])
HOD = numpy.array([])

#data is a numpy array
def get_nonzero_min(data, zero):
    #test1 = numpy.zeros(10)
    #test1[5] = 5
    #print("test1:", test1)
    #test1_result = get_nonzero_min(test1, 0)
    #print("Should be 5:", test1_result)
    if type(data) == list:
        temp = numpy. concatenate(([data[0]], [data[1]]))
        ma = numpy.ma.masked_equal(temp, 0.0, copy=False)
    else:
        ma = numpy.ma.masked_equal(data, 0.0, copy=False)
    return ma.min()

with Genome(str(sys.argv[1])) as genome:
    with open(str(sys.argv[2])) as bedfile:
        for line in bedfile:
            print(line)
            bed_items = line.strip().split()
            chr_name = bed_items[0]
            start = int(bed_items[1])
            end = int(bed_items[2])

            # HERE IS YOUR GENOMEDATA DATA, a numpy array
            print("data grabbing")
            data = genome[chr_name][start:end]
            print("min&max")
            min = get_nonzero_min(data,0)
            max = data.max()
            print("concatenation")
            LOD = numpy.concatenate((LOD, numpy.array([min])))
            HOD = numpy.concatenate((HOD, numpy.array([max])))
        print(LOD.min(), HOD.max())
