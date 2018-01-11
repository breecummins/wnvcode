/**
 *
 * DA_grid.cpp
 *
 * Implementation file for a numerical simulation of a diffusion/
 * advection model on a square grid with hooks for an external
 * source term to be added in.
 *
 * Written by Justin Walbeck
 */

#include "DA_grid.h"

namespace WNV {

DA_grid::DA_grid(float dt, float h, int Ng, float nu,
                 MLabMatrix& V1p, MLabMatrix& V1m, MLabMatrix& V2p, MLabMatrix& V2m)
                 : m_dt(dt), m_h(h), m_Ng(Ng), m_nu(nu), m_V1p(V1p), m_V1m(V1m), m_V2p(V2p), m_V2m(V2m) {
  C = MLabMatrix(Ng,Ng,0);
  C_next = MLabMatrix(Ng,Ng,0);
  Cyp = MLabMatrix(Ng,Ng,0);
  Cym = MLabMatrix(Ng,Ng,0);
  Cxp = MLabMatrix(Ng,Ng,0);
  Cxm = MLabMatrix(Ng,Ng,0);
  dCdyp = MLabMatrix(Ng,Ng,0);
  dCdym = MLabMatrix(Ng,Ng,0);
  dCdxp = MLabMatrix(Ng,Ng,0);
  dCdxm = MLabMatrix(Ng,Ng,0);
}

void DA_grid::iterate() {
  C_next = C;

  //This process does not include the source term. Handle this separately
  //AFTER calling this method.
  SliceC();
  DiffuseC();
  AdvectC();
  
  C = C_next;
}

/**
 *Update each of the 'slices' to the current frame
 */
void DA_grid::SliceC() {
  Mat_i cyp_i[5] = {1,to,end,end,-1};
  Mat_i cyp_j[2] = {all,-1};

  Mat_i cym_i[5] = {0,0,to,end-1,-1};
  Mat_i cym_j[2] = {all,-1};

  Mat_i cxp_i[2] = {all,-1};
  Mat_i cxp_j[5] = {1,to,end,end,-1};

  Mat_i cxm_i[2] = {all,-1};
  Mat_i cxm_j[5] = {0,0,to,end-1,-1};
  
  Cyp = C(cyp_i,cyp_j);
  Cym = C(cym_i,cym_j);
  Cxp = C(cxp_i,cxp_j);
  Cxm = C(cxm_i,cxm_j);
}

/**
 *Perform the actual diffusion operation.
 */
inline void DA_grid::DiffuseC() {
  C_next += m_nu*(m_dt/(m_h*m_h))*(Cxp+Cxm+Cyp+Cym-4*C);
}

/**
 *Advect the odorant
 */
inline void DA_grid::AdvectC() {
  dCdxp = (Cxp-C)/m_h;
  dCdxm = (Cxm-C)/m_h;
  dCdyp = (Cyp-C)/m_h;
  dCdym = (Cym-C)/m_h;
  
  C_next += -m_dt*(m_V1p.Mult(dCdxm) + m_V1m.Mult(dCdxp) + m_V2p.Mult(dCdym) + m_V2m.Mult(dCdyp));
}

}
