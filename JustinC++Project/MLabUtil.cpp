#include "MLabUtil.h"
#include <float.h>
#include "math.h"

#include <iostream>

namespace WNV {
          
MLabMatrix zeros(int i, int j = 1) {
  return MLabMatrix(i,j,0);
}

MLabMatrix ones(int i, int j = 1) {
  return MLabMatrix(i,j,1);
}

MLabMatrix min(MLabMatrix a) {
  MLabMatrix dims = a.size();
  MLabMatrix temp(1,(int) dims(1),FLT_MAX);
  for (int i = 0; i < dims(0); i++) {
    for (int j = 0; j < dims(1); j++) {
      if (a(i,j) < temp(0,j))
        temp(0,j) = a(i,j);
    }
  }
  return temp;
}

float min2(MLabMatrix a) {
  MLabMatrix dims = a.size();
  float temp = FLT_MAX;
  for (int i = 0; i < dims(0); i++) {
    for (int j = 0; j < dims(1); j++) {
      if (a(i,j) < temp)
        temp = a(i,j);
    }
  }
  return temp;
}

MLabMatrix max(MLabMatrix a) {
  MLabMatrix dims = a.size();
  MLabMatrix temp(1,(int) dims(1),FLT_MIN);
  for (int i = 0; i < dims(0); i++) {
    for (int j = 0; j < dims(1); j++) {
      if (a(i,j) > temp(0,j))
        temp(0,j) = a(i,j);
    }
  }
  return temp;
}

float max2(MLabMatrix a) {
  MLabMatrix dims = a.size();
  float temp = FLT_MIN;
  for (int i = 0; i < dims(0); i++) {
    for (int j = 0; j < dims(1); j++) {
      if (a(i,j) > temp)
        temp = a(i,j);
    }
  }
  return temp;
}

MLabMatrix find(MLabMatrix a) {
  //Because matrices are not currently growable,
  //this must be done in a two-stage process. Could
  //be refactored to use std libraries...
  
  //First, enumerate all of the offending values.
  int numel = 0;
  MLabMatrix dims = a.size();
  for (int i = 0; i < dims(0); i++) {
    for (int j = 0; j < dims(1); j++) {
      if (a(i,j) != 0) {
        numel++;
      }
    }
  }
  
  //Now, build the actual matrix
  MLabMatrix result(numel,1,0);
  int index = 0;
  //Do it all over again...
  for (int j = 0; j < dims(1); j++) {
    for (int i = 0; i < dims(0); i++) {
      if (a(i,j) != 0) {
        result(index) = i + j*dims(0);
        index++;
      }
    }
  }
  return result;
}

MLabMatrix m_atan2(MLabMatrix a, MLabMatrix b) {
  MLabMatrix dims1 = a.size();
  MLabMatrix dims2 = b.size();
  if (dims1(0) != dims2(0) || dims1(1) != dims2(1)) {
    throw new std::logic_error("Error: Matrix Dimension Mismatch in atan2 function");    
  }
  MLabMatrix result((int)dims1(0),(int)dims1(1),0);
  int numel = (int) (dims1(0)*dims1(1));
  while (numel-- > 0) {
    result(numel) = atan2(a(numel),b(numel));
  }
  return result;
}

MLabMatrix ismember(MLabMatrix a, MLabMatrix b) {
  //This is really inefficient. sorting 'b' beforehand
  //would probably speed things up but any way you slice
  //it this is a lot of comparisions.

  MLabMatrix dims_a = a.size();
  MLabMatrix result((int)dims_a(0),(int)dims_a(1),0);
  MLabMatrix dims_b = b.size();
  int b_numel = (int) (dims_b(0) * dims_b(1));
  for (int j = 0; j < dims_a(0); j++) {
    for (int k = 0; k < dims_a(1); k++) {
      for (int i = 0; i < b_numel; i++) {
        if (a(j,k) == b(i)) result(j,k) = 1.0f;
      }
    }
  }
  return result;
}

MLabMatrix m_not(MLabMatrix a) {
  MLabMatrix result(a);
  MLabMatrix dims = result.size();
  for (int i = 0; i < dims(0); i++) {
    for (int j = 0; j < dims(1); j++) {
      if (result(i,j) == 0.0f) {
        result(i,j) = 1.0f;
      } else {
        result(i,j) = 0.0f;
      }
    }
  }
  return result;
}

MLabMatrix unique(MLabMatrix a) {
  MLabMatrix b = sort(a);
  int write_ptr = 1;
  int read_ptr = 1;
  MLabMatrix dims = b.size();
  int numel = (int) (dims(0) * dims(1));
  //There is a potential for a chain of superflous
  //writes here as read and write 'pointers' are
  //initially synchronized.
  while (read_ptr < numel) {
    if (b(read_ptr) != b(read_ptr-1))
      b(write_ptr++) = b(read_ptr++);
    else
      read_ptr++;
  }
  
  b.reshape(numel,1);
  return b;
}

bool m_all(MLabMatrix a) {
  MLabMatrix dims = a.size();
  for (int i = 0; i < dims(0); i++) {
    for (int j = 0; j < dims(1); j++) {
      if (a(i,j) == 0)
        return false;
    }
  }
  return true;
}

MLabMatrix m_abs(MLabMatrix a) {
  MLabMatrix results(a);
  MLabMatrix dims = a.size();
  for (int i = 0; i < dims(0); i++) {
    for (int j = 0; j < dims(1); j++) {
      results(i,j) = fabs(a(i,j));
    }
  }
  return results;
}

MLabMatrix rand_m(int i, int j) {
  MLabMatrix result(i,j,0);
  for (int ind_i = 0; ind_i < i; ind_i++) {
    for (int ind_j = 0; ind_j < j; ind_j++) {
      result(ind_i,ind_j) = ((float) rand()) / RAND_MAX;
    }
  }
  return result;
}

//box_muller actually calculates two normally distributed
//values at once, and it's actually kinda expensive (a square
//root and a log) so we return both of them.
void box_muller(float mean, float std_dev, float* ret) {
  float cart_x, cart_y, rad;

  do {
    //First, generate two uniformally distributed values
    cart_x = 2.0f * rand() / RAND_MAX - 1;
    cart_y = 2.0f * rand() / RAND_MAX - 1;
    rad = cart_x * cart_x + cart_y * cart_y;
  } while (rad == 0.0 || rad > 1.0f); //avoid outlier "problem" cases

  float d = sqrt(-2.0f * log(rad) / rad);
  
  ret[0] = d*cart_x*std_dev + mean;
  ret[1] = d*cart_y*std_dev + mean;
}

MLabMatrix randn_m(int i, int j) {
  MLabMatrix result(i,j,0);
  float norm_dist[2];

  int numel = i*j;
  if (numel % 2 == 1) {
    //We get two numbers, so handle the odd case
    box_muller(0.0f,1.0f,&norm_dist[0]);
    result(numel--) = norm_dist[0];
  }
  
  while (numel > 0) {
    box_muller(0.0f,1.0f,&norm_dist[0]);
    result(numel--) = norm_dist[0];
    result(numel--) = norm_dist[1];
  }
  
  return result;
}

MLabMatrix* meshgrid(MLabMatrix x, MLabMatrix y) {
  int num_rows = y.length();
  int num_cols = x.length();
  MLabMatrix* result = new MLabMatrix[2];
  result[0] = MLabMatrix(num_rows,num_cols);
  result[1] = MLabMatrix(num_rows,num_cols);
  for (int i = 0; i < num_rows; i++) {
    for (int j = 0; j < num_cols; j++) {
      result[0](i,j) = x(j);
      result[1](i,j) = y(i);
    }
  }
  return result;
}

//Helper function to the quicksort implementation
//in sort() below.
inline int partition(MLabMatrix& mat, int left, int right) {
  float temp = 0.0f;
  //Pivot around the middle value of the array. Could
  //experiment with different methods of selecting this
  //value.
  float pivot = mat((left+right)/2);
  while (left <= right) {
    while (mat(left) < pivot) left++;
    while (mat(right) > pivot) right--;
    if (left <= right) { //Handle reaching the pivot
      temp = mat(left);
      mat(left) = mat(right);
      mat(right) = temp;
      left++;
      right--;
    }
  }
  return left;
}

void quicksort(MLabMatrix& mat, int left, int right) {
  //Perform in-place quicksort algorithm.
  int i = partition(mat,left, right);
  if (left < i-1) quicksort(mat,left,i-1);
  if (i < right) quicksort(mat,i,right);
}

MLabMatrix sort(MLabMatrix a) {
  //In particular, quicksort
  MLabMatrix result(a);
  MLabMatrix dims = a.size();
  int length = (int) (dims(0)*dims(1));
  quicksort(result,0,length-1);
  result.reshape(length,1);
  return result;
}

}

