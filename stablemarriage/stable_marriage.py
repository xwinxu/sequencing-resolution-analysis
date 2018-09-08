#!/bin/env python
""" docstring """
import sys
import os
import argparse
import logging
import copy
import subprocess
import cPickle as pickle
import numpy as np
import pdb
from munkres import Munkres
from copy import deepcopy
_folder_path = os.path.split(os.path.abspath(__file__))[0]
sys.path.append(_folder_path)


###################################################################################
###################################################################################
# begin code from http://rosettacode.org/wiki/Stable_marriage_problem#Python
# under MIT license
#
# Implements
# matchmaker(guys, gals, guyprefers, galprefers)
# preferences are represented as a dictionary
# {person -> preference order}
# where preference order is a list from highest to lowest preference
# return value is a map
# {gal -> guy}
###################################################################################
guyprefers = {
 'abe':  ['abi', 'eve', 'cath', 'ivy', 'jan', 'dee', 'fay', 'bea', 'hope', 'gay'],
 'bob':  ['cath', 'hope', 'abi', 'dee', 'eve', 'fay', 'bea', 'jan', 'ivy', 'gay'],
 'col':  ['hope', 'eve', 'abi', 'dee', 'bea', 'fay', 'ivy', 'gay', 'cath', 'jan'],
 'dan':  ['ivy', 'fay', 'dee', 'gay', 'hope', 'eve', 'jan', 'bea', 'cath', 'abi'],
 'ed':   ['jan', 'dee', 'bea', 'cath', 'fay', 'eve', 'abi', 'ivy', 'hope', 'gay'],
 'fred': ['bea', 'abi', 'dee', 'gay', 'eve', 'ivy', 'cath', 'jan', 'hope', 'fay'],
 'gav':  ['gay', 'eve', 'ivy', 'bea', 'cath', 'abi', 'dee', 'hope', 'jan', 'fay'],
 'hal':  ['abi', 'eve', 'hope', 'fay', 'ivy', 'cath', 'jan', 'bea', 'gay', 'dee'],
 'ian':  ['hope', 'cath', 'dee', 'gay', 'bea', 'abi', 'fay', 'ivy', 'jan', 'eve'],
 'jon':  ['abi', 'fay', 'jan', 'gay', 'eve', 'bea', 'dee', 'cath', 'ivy', 'hope']}
galprefers = {
 'abi':  ['bob', 'fred', 'jon', 'gav', 'ian', 'abe', 'dan', 'ed', 'col', 'hal'],
 'bea':  ['bob', 'abe', 'col', 'fred', 'gav', 'dan', 'ian', 'ed', 'jon', 'hal'],
 'cath': ['fred', 'bob', 'ed', 'gav', 'hal', 'col', 'ian', 'abe', 'dan', 'jon'],
 'dee':  ['fred', 'jon', 'col', 'abe', 'ian', 'hal', 'gav', 'dan', 'bob', 'ed'],
 'eve':  ['jon', 'hal', 'fred', 'dan', 'abe', 'gav', 'col', 'ed', 'ian', 'bob'],
 'fay':  ['bob', 'abe', 'ed', 'ian', 'jon', 'dan', 'fred', 'gav', 'col', 'hal'],
 'gay':  ['jon', 'gav', 'hal', 'fred', 'bob', 'abe', 'col', 'ed', 'dan', 'ian'],
 'hope': ['gav', 'jon', 'bob', 'abe', 'ian', 'dan', 'hal', 'ed', 'col', 'fred'],
 'ivy':  ['ian', 'col', 'hal', 'gav', 'fred', 'bob', 'abe', 'ed', 'jon', 'dan'],
 'jan':  ['ed', 'hal', 'gav', 'abe', 'bob', 'jon', 'col', 'ian', 'fred', 'dan']}

guys = sorted(guyprefers.keys())
gals = sorted(galprefers.keys())


def check(engaged):
    inverseengaged = dict((v,k) for k,v in engaged.items())
    for she, he in engaged.items():
        shelikes = galprefers[she]
        shelikesbetter = shelikes[:shelikes.index(he)]
        helikes = guyprefers[he]
        helikesbetter = helikes[:helikes.index(she)]
        for guy in shelikesbetter:
            guysgirl = inverseengaged[guy]
            guylikes = guyprefers[guy]
            if guylikes.index(guysgirl) > guylikes.index(she):
                print("%s and %s like each other better than "
                      "their present partners: %s and %s, respectively"
                      % (she, guy, he, guysgirl))
                return False
        for gal in helikesbetter:
            girlsguy = engaged[gal]
            gallikes = galprefers[gal]
            if gallikes.index(girlsguy) > gallikes.index(he):
                print("%s and %s like each other better than "
                      "their present partners: %s and %s, respectively"
                      % (he, gal, she, girlsguy))
                return False
    return True

# returns engagements = {gal: guy}
def matchmaker(guys, gals, guyprefers, galprefers):
    guysfree = guys[:]
    engaged  = {}
    guyprefers2 = copy.deepcopy(guyprefers)
    galprefers2 = copy.deepcopy(galprefers)
    while guysfree:
        guy = guysfree.pop(0)
        guyslist = guyprefers2[guy]
        gal = guyslist.pop(0)
        fiance = engaged.get(gal)
        if not fiance:
            # She's free
            engaged[gal] = guy
            print("  %s and %s" % (guy, gal))
        else:
            # The bounder proposes to an engaged lass!
            galslist = galprefers2[gal]
            if galslist.index(fiance) > galslist.index(guy):
                # She prefers new guy
                engaged[gal] = guy
                print("  %s dumped %s for %s" % (gal, fiance, guy))
                if guyprefers2[fiance]:
                    # Ex has more girls to try
                    guysfree.append(fiance)
            else:
                # She is faithful to old fiance
                if guyslist:
                    # Look again
                    guysfree.append(guy)
    return engaged

test_rosetta_stable_marriage = False
if (test_rosetta_stable_marriage):
    print('\nEngagements:')
    engaged = matchmaker(guys, gals, guyprefers, galprefers)

    print('\nCouples:')
    print('  ' + ',\n  '.join('%s is engaged to %s' % couple
                              for couple in sorted(engaged.items())))
    print()
    print('Engagement stability check PASSED'
          if check(engaged) else 'Engagement stability check FAILED')

    print('\n\nSwapping two fiances to introduce an error')
    engaged[gals[0]], engaged[gals[1]] = engaged[gals[1]], engaged[gals[0]]
    for gal in gals[:2]:
        print('  %s is now engaged to %s' % (gal, engaged[gal]))
    print()
    print('Engagement stability check PASSED'
          if check(engaged) else 'Engagement stability check FAILED')

###################################################################################
# end code from rosetta
###################################################################################
###################################################################################

def weights_to_prefs(people, weights):
    assert(len(people) == len(weights))
    weight_pairs = [[person, weights[person]] for person in people]
    weight_pairs = sorted(weight_pairs, cmp = lambda x,y: -cmp(x[1], y[1]))
    prefs = map(lambda weight_pair: weight_pair[0], weight_pairs)
    return prefs

##############################################################
# Reads an overlap.tab file, as written by segtools-overlap.
# Returns:
# guys - names corresponding with columns in the tab file
# gals - names corresponding with rows in the tab file
# guy_prefs: mapping from guy to list of gals, in order of preference
# guy_prefs: mapping from gal to list of guys, in order of preference
# weight_mat: 2D dictionary of overlaps; indexed weight_mat[gal][guy]
##############################################################
def tab_file_to_preferences(filename, guys, gals):
    data = open(filename).readlines()
    raw_mat = map(lambda row: row.split(), data)

    # the first line is a comment
    raw_mat = raw_mat[1:]

    # the second line is a list of guys
    guys_from_file = raw_mat[0][:-2]
    raw_mat = raw_mat[1:]
    if not guys:
        guys = guys_from_file

    # the first column is a list of gals
    gals_from_file = [raw_mat[i][0] for i in range(len(raw_mat))]
    raw_mat = [raw_mat[i][1:] for i in range(len(raw_mat))]
    if not gals:
        gals = gals_from_file

    # the last two columns are a "none" and "total"
    raw_mat = [raw_mat[i][:-2] for i in range(len(raw_mat))]

    weight_mat = {gal:{guy:0 for guy in guys} for gal in gals}
    for gal_index in range(len(raw_mat)):
        gal = gals_from_file[gal_index]
        for guy_index in range(len(raw_mat[gal_index])):
            guy = guys_from_file[guy_index]
            val = int(raw_mat[gal_index][guy_index])
            weight_mat[gal][guy] = val

    galprefs = {}
    for gal in gals:
        galprefs[gal] = weights_to_prefs(guys, weight_mat[gal])
    guyprefs = {}
    for guy in guys:
        guyprefs[guy] = weights_to_prefs(gals, {gal:weight_mat[gal][guy]
                                                for gal in gals})

    return guys, gals, guyprefs, galprefs, weight_mat

##############################################################
# This function is used when one of the two mapping algorithms (hungarian
# or stable marriage) have already generated a mapping (engagements).
# This function returns the optimal ordering of the guy-gal pairs
# along the diagonal of the confusion matrix such that the weight
# far from the diagonal of the confusion matrix is minimized.  This
# problem can be solved by finding the order of the eigenvalues of
# the Laplacian matrix.  For more info, see:
# http://cstheory.stackexchange.com/questions/8878/algorithm-for-ordering-a-list-under-a-similarity-function
##############################################################
def eigen_order(guys, gals, weight_mat, engagements):
    overlap_mat = [[-weight_mat[gal][guy]
                    for guy in guys]
                   for gal in gals]
    overlap_mat = np.matrix(overlap_mat)
    # order rows such that the guy-gal engagements appear on the diagonal
    rev_engagements = {engagements[gal]:gal for gal in gals}
    row_order = [gals.index(rev_engagements[guy]) for guy in guys]
    overlap_mat_ord = overlap_mat[row_order]

    # make the matrix symmetrical by adding it to its transpose
    overlap_mat_symm = (overlap_mat_ord + overlap_mat_ord.T)/2

    # diagonal := sum(overlaps)
    for i in range(overlap_mat_symm.shape[0]):
        overlap_mat_symm[i,i] = sum(overlap_mat_symm[i].flat) - overlap_mat_symm[i,i]

    # order the diagonal in the order of the eigenvalues of the matrix
    eigval, eigvec = np.linalg.eig(overlap_mat_symm)
    diag_order = map(lambda x: x[1],
                     sorted([(eigval[i], i) for i in range(len(eigval))],
                            key = lambda x: x[0]))
    #ret = overlap_mat_symm[diag_order].T[diag_order].T

    #print >>sys.stderr, "rev_engagements:", rev_engagements

    guy_order = [guys[i] for i in diag_order]
    gal_order = [rev_engagements[guy] for guy in guy_order]

    return guy_order, gal_order

def hungarian(guys, gals, weight_mat):
    neg_weight_mat = [[-weight_mat[gal][guy]
                       for guy in guys]
                      for gal in gals]
    m = Munkres()
    indexes = m.compute(neg_weight_mat)
    #print >>sys.stderr, "indexes:", indexes
    #engagements = {guys[i] : gals[j] for i,j in indexes}
    engagements = {gals[j] : guys[i] for i,j in indexes}
    #print >>sys.stderr, "engagements: ", engagements

    return engagements


def main():
    parser = argparse.ArgumentParser(description='docstring')
    parser.add_argument('input_overlap', type=str, action='store', help='argument help')
    parser.add_argument('mapping', type=str, action='store', help='argument help')
    parser.add_argument('guy_order')
    parser.add_argument('gal_order')
    parser.add_argument('--guys', default=None, help="comma-delimited list of guys")
    parser.add_argument('--gals', default=None, help="comma-delimited list of gals")
    parser.add_argument('--algorithm', choices=["stable_marriage", "hungarian"], default="stable_marriage")
    parser.add_argument('--verbose', action='store_true')
    args = parser.parse_args()

    if args.guys: args.guys = args.guys.split(",")
    if args.gals: args.gals = args.gals.split(",")

    guys, gals, guyprefs, galprefs, weight_mat = tab_file_to_preferences(args.input_overlap, args.guys, args.gals)

    if args.algorithm == "stable_marriage":
        engagements = matchmaker(guys, gals, guyprefs, galprefs)
    elif args.algorithm == "hungarian":
        engagements = hungarian(guys, gals, weight_mat)

    total_bases = sum([sum(weight_mat[gal].values()) for gal in weight_mat])
    #diagonal_bases = sum([weight_mat[gal][engagements[gal]] for gal in weight_mat])
    diagonal_bases = sum([weight_mat[engagements[gal]][gal] for gal in weight_mat]) # I'm 99% sure this is the right one (8/24/12)
    if args.verbose:
        print >>sys.stderr, "diagonal_bases: ", diagonal_bases
        print >>sys.stderr, "total_bases: ", total_bases
    assert (total_bases != 0)
    diagonal_fraction = float(diagonal_bases) / total_bases
    sys.stdout.write(str(diagonal_fraction))


    guy_order, gal_order = eigen_order(guys, gals, weight_mat, engagements)
    if args.verbose:
        print >>sys.stderr, "guy_order:", guy_order
        print >>sys.stderr, "gal_order:", gal_order
        print >>sys.stderr, "set(zip(guy_order, gal_order)):", set(zip(gal_order, guy_order))
        print >>sys.stderr, "set(engagements.items())", set(engagements.items())
    assert set(zip(gal_order, guy_order)) == set(engagements.items())

    with open(args.guy_order, "w") as f: pickle.dump(guy_order, f)
    with open(args.gal_order, "w") as f: pickle.dump(gal_order, f)

    with open(args.mapping, "w") as f:
        f.write("# first column is objects read from left side of tab file\n")
        f.write("# second column is objects read from top of tab file\n")
        for x in engagements:
            if args.verbose:
                print >>sys.stderr, "%s is paired with %s" % (x, engagements[x])
            f.write("%s\t%s\n" % (x, engagements[x]))

    #preferences_to_tab_file(guys, gals, engagements, args.input_overlap, args.sorted_overlap)




if __name__ == '__main__':
    main()







