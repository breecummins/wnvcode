/**
 *
 * DA_grid.cpp
 *
 * Declaration file for a numerical simulation of a diffusion/
 * advection model with hooks for an external source term to be
 * added in.
 *
 * Written by Justin Walbeck
 */

#include "MLabMatrix.h"

namespace WNV {
  
class DA_grid {
public:
  DA_grid(float,float,int,float,MLabMatrix&,MLabMatrix&,MLabMatrix&,MLabMatrix&);
  
  MLabMatrix* getCurrState() {return &C;}
  void iterate();
  
private:
  MLabMatrix C;
  float m_dt, m_h, m_nu;
  int m_Ng;
  
  //Temporary storage space for iterating the system.
  MLabMatrix C_next;
  //Keep space allocated for these so we don't have to re-allocate every cycle.
  //Major space/time tradeoff
  MLabMatrix Cyp,Cym,Cxp,Cxm;
  MLabMatrix dCdyp,dCdym,dCdxp,dCdxm;
  //The care and upkeep of the V term will be handled elsewhere.
  MLabMatrix &m_V1p, &m_V1m, &m_V2p, &m_V2m;

  void SliceC();
  inline void DiffuseC();
  void AdvectC();  
};

}
