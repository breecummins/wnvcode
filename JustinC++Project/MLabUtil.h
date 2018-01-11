/**
 * MLabUtil.h
 *
 * Declaration file for a batch of utility functions
 * ported from Matlab to handle matrix manipulation.
 *
 * Written by Justin Walbeck
 */
 
#include "MLabMatrix.h"

namespace WNV {

MLabMatrix zeros(int i, int j);
MLabMatrix ones(int i, int j);
MLabMatrix min(MLabMatrix a);
float min2(MLabMatrix a);
MLabMatrix max(MLabMatrix a);
float max2(MLabMatrix a);
MLabMatrix find(MLabMatrix a);
MLabMatrix m_atan2(MLabMatrix a, MLabMatrix b);
MLabMatrix ismember(MLabMatrix a, MLabMatrix s);
MLabMatrix m_not(MLabMatrix a);
MLabMatrix unique(MLabMatrix a);
bool m_all(MLabMatrix a);
MLabMatrix m_abs(MLabMatrix a);
MLabMatrix rand_m(int i, int j);
MLabMatrix randn_m(int i, int j);
MLabMatrix* meshgrid(MLabMatrix x, MLabMatrix y);
MLabMatrix sort(MLabMatrix a);


}

