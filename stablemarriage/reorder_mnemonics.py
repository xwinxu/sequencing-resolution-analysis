#!/bin/env python
""" docstring """
import sys
import os
import argparse
import logging
import subprocess
import cPickle as pickle
import random
_folder_path = os.path.split(os.path.abspath(__file__))[0]
sys.path.append(_folder_path)

def read_mnemonics_file(mnemonics_fname):
    mnemonics = {}
    with open(mnemonics_fname) as f:
        lines = f.readlines()
        lines = lines[1:] # first line is "old new"
        lines = filter(lambda line: (len(line.split()) >= 2) and (line[0] != "#"), lines)
        for line in lines:
            old = line.split()[0]
            new = line.split()[1]
            mnemonics[old] = new
    return mnemonics

def write_ordered_mnemonics_file(mnem, order, fname):
    with open(fname, "w") as out_f:
        out_f.write("old\tnew\n")
        for x in order:
            out_f.write("%s\t%s\n" % (x, mnem[x]))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='docstring')
    parser.add_argument('base_order')
    parser.add_argument('other_order')
    parser.add_argument('base_mnemonic_original')
    parser.add_argument('base_mnemonic_out')
    parser.add_argument('other_mnemonic_original')
    parser.add_argument('other_mnemonic_out')
    args = parser.parse_args()

    base_mnemonics = read_mnemonics_file(args.base_mnemonic_original)
    base_order = pickle.load(open(args.base_order))

    other_mnemonics = read_mnemonics_file(args.other_mnemonic_original)
    other_order = pickle.load(open(args.other_order))

    write_ordered_mnemonics_file(base_mnemonics, base_order, args.base_mnemonic_out)
    write_ordered_mnemonics_file(other_mnemonics, other_order, args.other_mnemonic_out)



