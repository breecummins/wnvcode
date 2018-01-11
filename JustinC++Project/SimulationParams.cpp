/**
 * SimulationParams.cpp
 *
 * Definition file for a storage class to keep track of all of the simulation
 * parameters. All of the tunable parameters intended to be fixed across a batch
 * of simulations are kept here.
 *
 * Written by Justin Walbeck
 */

#include "SimulationParams.h"

namespace WNV {

SimulationParams::SimulationParams(float l_dm,float l_L0,float l_S0,
                                   float l_D,float l_L,float l_U,
                                   float l_Tf,float l_dt,float l_Ng,
                                   int l_wind_mode,int l_tGraph)
                                   : dm(l_dm), L0(l_L0), S0(l_S0), D(l_D),
                                     L(l_L), U(l_U), Tf(l_Tf), dt(l_dt),
                                     Ng(l_Ng), wind_mode(l_wind_mode), tGraph(l_tGraph) {
  T = L0/dm;
  C0 = S0*T;
  nu = D/(dm*L0);
  h = L/Ng;
}

}
