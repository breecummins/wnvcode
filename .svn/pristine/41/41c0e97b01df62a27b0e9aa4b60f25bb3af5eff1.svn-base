#include "mex.h"

/*
 * flux.c - implements the upwinding in C
 * compile as "mex -largeArrayDims flux.c"
 *
*/

/* the gateway function */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
  double *C,*Cxp,*Cxm,*Cyp,*Cym;
  double  *um, *vm, *up, *vp;
  double *lupp,*lupm,*lump,*lumm;
  double *lvpp,*lvpm,*lvmp,*lvmm;
  double *Flxx,*Flxy;
  mwSize mrows,ncols;
  
  /*  check for proper number of arguments */
  /* NOTE: You do not need an else statement when using mexErrMsgTxt
     within an if statement, because it will never get to the else
     statement if mexErrMsgTxt is executed. (mexErrMsgTxt breaks you out of
     the MEX-file) */
  if(nrhs!=17) 
    mexErrMsgTxt("17 inputs required.");
  if(nlhs!=2) 
    mexErrMsgTxt("Two outputs required.");
    
  /*  create pointers to the input matrices */
  C = mxGetPr(prhs[0]);
  Cxp = mxGetPr(prhs[1]);
  Cxm = mxGetPr(prhs[2]);
  Cyp = mxGetPr(prhs[3]);
  Cym = mxGetPr(prhs[4]);
  um = mxGetPr(prhs[5]);
  vm = mxGetPr(prhs[6]);
  up = mxGetPr(prhs[7]);
  vp = mxGetPr(prhs[8]);
  lupp = mxGetPr(prhs[9]);
  lupm = mxGetPr(prhs[10]);
  lump = mxGetPr(prhs[11]);
  lumm = mxGetPr(prhs[12]);
  lvpp = mxGetPr(prhs[13]);
  lvpm = mxGetPr(prhs[14]);
  lvmp = mxGetPr(prhs[15]);
  lvmm = mxGetPr(prhs[16]);
  
  /*  get the dimensions of the input matrices */
  mrows = mxGetM(prhs[0]);
  ncols = mxGetN(prhs[0]);
  
  /*  set the output pointers to the output matrix */
  plhs[0] = mxCreateDoubleMatrix(mrows,ncols, mxREAL);
  plhs[1] = mxCreateDoubleMatrix(mrows,ncols, mxREAL);
  
  /*  create a C pointer to a copy of the output matrix */
  Flxx = mxGetPr(plhs[0]);
  Flxy = mxGetPr(plhs[1]);
  
  /*  do the computation */
  mwSize i,j,count=0;
  
  for (i=0; i<ncols; i++) {
    for (j=0; j<mrows; j++) {
	/* only increment the pointer to C once per loop */
      *(Flxx+count) = ( *(C+count) * *(lupp+count) + *(Cxp+count) * *(lupm+count) ) * *(up+count) - ( *(Cxm+count) * *(lump+count) + *C * *(lumm+count) ) * *(um+count);
      *(Flxy+count) = ( *C * *(lvpp+count) + *(Cyp+count) * *(lvpm+count) ) * *(vp+count) - ( *(Cym+count) * *(lvmp+count) + *C * *(lvmm+count) ) * *(vm+count);
      count++; 
	}
  }
}


