/**
 * SimulationParams.h
 *
 * Declaration file for a storage class to keep track of all of the simulation
 * parameters. All of the tunable parameters intended to be fixed across a batch
 * of simulations are kept here.
 *
 * Parameter descriptions taken from setParams.m
 *
 * Written by Justin Walbeck
 */

namespace WNV {

struct SimulationParams {
  SimulationParams(float,float,float,float,float,float,float,float,float,int,int);
  
  float dm; //Characteristic velocity
  float L0; //Characteristic length
  float S0; //concentration from a single chicken
  float D; //diffusion coefficient of CO2 in air
  float T; //characteristic time in seconds
  float C0; //characteristic concentration of odorant
  float nu; //nondimensional viscocity
  float L; //nondimensional length
  float U; //nondimensional source emission per unit time 
  float Tf; //nondimensional time span
  float dt; //nondimensional time step
  float Ng; //grid length in data points
  float h; //distance between grid points
  int wind_mode; //controls mosquito wind-dependent behavior
  int tGraph; //Time steps to render at
};

} //namesace WNV
