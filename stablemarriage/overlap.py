#!/usr/bin/env python

import sys
import os
import argparse
import subprocess
import cPickle as pickle
from path import path
_folder_path = path(os.path.split(os.path.abspath(__file__))[0])

STABLE_MARRIAGE_EXEC = _folder_path / "stable_marriage.py"
REORDER_MNEMONICS_EXEC = _folder_path / "reorder_mnemonics.py"

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('segmentation1')
    parser.add_argument('segmentation2')
    parser.add_argument('num_labels', type=int)
    parser.add_argument('workdir')
    #parser.add_argument('--clobber', action="store_true")
    args = parser.parse_args()

    workdir = path(args.workdir)
    seg1 = path(args.segmentation1)
    seg2 = path(args.segmentation2)
    num_labels = args.num_labels

    overlap_direct_dirpath = workdir / "overlap-direct"
    overlap_ordered_dirpath = workdir / "overlap-ordered"
    overlap_direct_dirpath.makedirs()
    overlap_ordered_dirpath.makedirs()


    # Run segtools-overlap once to get the overlap.tab matrix.
    overlap_cmd = ["segtools-overlap",
                   "--quiet",
                   "--outdir=%s" % overlap_direct_dirpath,
                   "-R", "row.normalize=FALSE",
                   seg1, seg2]
    #print >>sys.stderr, " ".join(overlap_cmd)
    subprocess.check_call(overlap_cmd, stdout=sys.stderr)

    overlap_tab_filepath = overlap_direct_dirpath / "overlap.tab"
    assert overlap_tab_filepath.isfile()

    # Call stable_marriage with overlap.tab to get label_map.tab mappings
    label_map_filepath = overlap_direct_dirpath / "label_map.tab"
    order1_pkl = overlap_direct_dirpath / "order1.pkl"
    order2_pkl = overlap_direct_dirpath / "order2.pkl" # I'm not sure which order is which
    stable_marriage_cmd = [STABLE_MARRIAGE_EXEC,
                           overlap_tab_filepath,
                           label_map_filepath,
                           order1_pkl,
                           order2_pkl,
                           "--algorithm=hungarian",
                           "--guys=%s" % ",".join(map(str, range(num_labels))),
                           "--gals=%s" % ",".join(map(str, range(num_labels)))]
    #print >>sys.stderr, " ".join(stable_marriage_cmd)
    subprocess.check_call(stable_marriage_cmd)

    # Write mnemonics files
    mnemonics1_filepath = overlap_direct_dirpath / "mnemonics1.txt"
    mnemonics2_filepath = overlap_direct_dirpath / "mnemonics2.txt"
    for mnemonics_filepath in [mnemonics1_filepath, mnemonics2_filepath]:
        if not mnemonics_filepath.isfile():
            with open(mnemonics_filepath, "w") as f:
                f.write("old\tnew\n")
                for label_index in range(num_labels):
                    f.write("%s\t%s\n" % (label_index, label_index))

    # Create ordered mnemonics file for this segmentation according to stable marriage
    # to determine the order of the segtools-overlap confusion matrix
    new_mnemonics1_filepath = overlap_direct_dirpath / "mnemonics1_new.txt"
    new_mnemonics2_filepath = overlap_direct_dirpath / "mnemonics2_new.txt"
    reorder_cmd = [REORDER_MNEMONICS_EXEC,
                   order1_pkl,
                   order2_pkl,
                   mnemonics1_filepath,
                   new_mnemonics1_filepath,
                   mnemonics2_filepath,
                   new_mnemonics2_filepath]
    #print >>sys.stderr, " ".join(reorder_cmd)
    subprocess.check_call(reorder_cmd, stdout=sys.stderr)

    # calculate overlap fraction
    #order1 = map(int, pickle.load(open(order1_pkl)))
    #order2 = map(int, pickle.load(open(order2_pkl)))
    #with open(overlap_tab_filepath, "r") as f:
        #overlaps = map(lambda line: map(int, line.split()), f.readlines()[2:])
    #overlaps = [row[1:1+num_labels] for row in overlaps]
    #overlaps += [[0 for i in range(num_labels)] for j in range(num_labels-len(overlaps))]
    #total_bases = sum(map(sum, overlaps))
    #diagonal = 0
    #print >>sys.stderr, "order1:", order1
    #print >>sys.stderr, "order2:", order2
    #print >>sys.stderr, "overlaps:", overlaps
    #for i in range(num_labels): diagonal += overlaps[order2[i]][order1[i]]
    #diagonal_fraction = (float(diagonal) / total_bases)
    #sys.stdout.write(str(diagonal_fraction))

    # Call segtools-overlap again with the ordered mnemonics
    # to create confusion matrix.
    overlap_ordered_cmd = ["segtools-overlap",
                           "--quiet",
                           "--outdir=%s" % overlap_ordered_dirpath,
                           "--mnemonic-file=%s" % new_mnemonics1_filepath,
                           "--feature-mnemonic-file=%s" % new_mnemonics2_filepath,
                           "-R", "row.normalize=FALSE",
                           seg1,
                           seg2]
    #print >>sys.stderr, " ".join(overlap_ordered_cmd)
    subprocess.check_call(overlap_ordered_cmd, stdout=sys.stderr)



