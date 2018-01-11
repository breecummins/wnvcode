/**
 * MLabMatrix.cpp
 *
 * Define file for MLabMatrix class, which is designed to imitate
 * both in syntax and features MATLAB style matrix manipulation.
 * This particular instance is geared towards single-core execution,
 * and should eventually be supplanted by a version supporting
 * data storage and manipulation across a multi-core system.
 *
 * Written by Justin Walbeck
 */

#include "MLabMatrix.h"
#include "stdlib.h"
#include <new> //for std::bad_alloc
#include <string.h> //for memcpy of all things

namespace WNV {

MLabMatrix::MLabMatrix(int x, int y) {
  m_nrows = x;
  m_ncols = y;
  m_data = (float*) malloc(sizeof(float) * (x*y));
  if (m_data == NULL)
    throw new std::bad_alloc();
}

MLabMatrix::MLabMatrix() {
  this->m_data = NULL;
}

MLabMatrix::MLabMatrix(int x, int y, float d) {
  m_nrows = x;
  m_ncols = y;
  m_data = (float*) malloc(sizeof(float) * (x*y));
  if (m_data == NULL)
    throw new std::bad_alloc();
  int numel = x*y;
  if (m_data != NULL) {
    while (numel-- > 0) { //fill() implementation
      m_data[numel] = d;
    }
  }
}

/**
 * Because we store the matrix in active memory we can't
 * rely on C++ to auto-generate a copy constructor. It
 * doesn't handle pointers well.
 */
MLabMatrix::MLabMatrix(const MLabMatrix& copy) {
  this->m_nrows = copy.m_nrows;
  this->m_ncols = copy.m_ncols;
  this->m_data = (float*) malloc(sizeof(float) * (m_nrows*m_ncols));
  if (m_data == NULL)
    throw new std::bad_alloc();
  memcpy(this->m_data, copy.m_data, sizeof(float) * (m_nrows*m_ncols));
}


MLabMatrix::~MLabMatrix() {
  free(m_data);
}

MLabMatrix& MLabMatrix::operator=(const MLabMatrix &rhs) {
  //Make sure we aren't trying anything like (a=a)
  //While this is *technically* valid it can cause problems
  //with the following memcpy call.
  if (this == &rhs) return *this;

  if (rhs.m_data == NULL)
    return *this;

  //Sanity checks
  if (this->m_data == NULL) {
    //Can happen in the case of array allocation. We're an empty
    //matrix, so define ourselves now.
    this->m_data = (float*) malloc(sizeof(float) * (rhs.m_nrows*rhs.m_ncols));
    this->m_nrows = rhs.m_nrows;
    this->m_ncols = rhs.m_ncols;
    memcpy(this->m_data,rhs.m_data, sizeof(float) * (m_nrows*m_ncols));
  } else {
    if (rhs.m_nrows != this->m_nrows || rhs.m_ncols != this->m_ncols)
      throw new std::logic_error("Error: Matrix Dimension Mismatch in assignment operation");
    //Do the actual conversion
    memcpy(this->m_data, rhs.m_data, sizeof(float) * (m_nrows*m_ncols));
  }
  return *this;
}

MLabMatrix& MLabMatrix::operator+=(const MLabMatrix &rhs) {
  //Sanity checks
  if (this->m_data != NULL && rhs.m_data != NULL) {
    if (rhs.m_nrows != this->m_nrows || rhs.m_ncols != this->m_ncols)
      throw new std::logic_error("Error: Matrix Dimension Mismatch in addition operation");
  
    int numel = m_nrows*m_ncols;
    while (numel-- > 0) {
      m_data[numel] += rhs.m_data[numel];
    }
  }
  return *this;
}

MLabMatrix& MLabMatrix::operator-=(const MLabMatrix &rhs) {
  //Sanity checks
  if (this->m_data != NULL && rhs.m_data != NULL) {
    if (rhs.m_nrows != this->m_nrows || rhs.m_ncols != this->m_ncols)
      throw new std::logic_error("Error: Matrix Dimension Mismatch in subtraction operation");
  
    int numel = m_nrows*m_ncols;
    while (numel-- > 0) {
      m_data[numel] -= rhs.m_data[numel];
    }
  }
  return *this;
}

MLabMatrix& MLabMatrix::operator*=(const MLabMatrix &rhs) {
  //Require equivalently sized matrices
  if (this->m_nrows != rhs.m_nrows || this->m_ncols != rhs.m_ncols)
    throw new std::logic_error("Error: Matrix Dimension Mismatch in multiplication operation");
  
  //Go with the (relatively) inefficient n^3 algorithm
  MLabMatrix temp(m_nrows,m_ncols,0);
  for (int i = 0; i < m_nrows; i++) {
    for (int j = 0; j < m_ncols; j++) {
      for (int k = 0; k < m_nrows; k++) {
        temp(i,j) += m_data[i + k*m_nrows] * rhs.m_data[k+j*rhs.m_nrows];
      }
    }
  }

  memcpy(this->m_data, temp.m_data, sizeof(float) * (m_nrows*m_ncols));
  return *this;
}

MLabMatrix& MLabMatrix::operator+=(const float &rhs) {
  //Sanity checks
  if (this->m_data != NULL) {
    int numel = m_nrows*m_ncols;
    while (numel-- > 0) {
      m_data[numel] += rhs;
    }
  }
  return *this;  
}

MLabMatrix& MLabMatrix::operator-=(const float &rhs) {
  //Sanity checks
  if (this->m_data != NULL) {
    int numel = m_nrows*m_ncols;
    while (numel-- > 0) {
      m_data[numel] -= rhs;
    }
  }
  return *this;  
}

MLabMatrix& MLabMatrix::operator*=(const float &rhs) {
  //Sanity checks
  if (this->m_data != NULL) {
    int numel = m_nrows*m_ncols;
    while (numel-- > 0) {
      m_data[numel] *= rhs;
    }
  }
  return *this;
}

MLabMatrix& MLabMatrix::operator/=(const float &rhs) {
  //Sanity checks
  if (this->m_data != NULL) {
    int numel = m_nrows*m_ncols;
    while (numel-- > 0) {
      m_data[numel] /= rhs;
    }
  }
  return *this;
}

MLabMatrix MLabMatrix::operator+(const MLabMatrix &rhs) {
  return (MLabMatrix(*this) += rhs);
}

MLabMatrix MLabMatrix::operator-(const MLabMatrix &rhs) {
  return (MLabMatrix(*this) -= rhs);
}

MLabMatrix MLabMatrix::operator*(const MLabMatrix &rhs) {
  //Handle this separately from the *= implementation
  //as here we can multiply non-square matrices.
  
  //Enforce MxNxP matrix sizing
  if (this->m_ncols != rhs.m_nrows)
    throw new std::logic_error("Error: Matrix Dimension Mismatch in multiplication operation");
  
  //Go with the (relatively) inefficient n^3 algorithm
  MLabMatrix temp(m_nrows,rhs.m_ncols,0);
  for (int i = 0; i < this->m_nrows; i++) {
    for (int j = 0; j < rhs.m_ncols; j++) {
      for (int k = 0; k < m_ncols; k++) {
        temp.m_data[i+j*m_nrows] += m_data[i + k*m_nrows] * rhs.m_data[k+j*rhs.m_nrows];
      }
    }
  }

  return temp;
}

/**
 *An unfortunate quirk in Matlab syntax makes this unavoidable. It somewhat
 *breaks the established flow of nice operator overloading, but there really
 *isn't an alternative.
 */
MLabMatrix MLabMatrix::Mult(MLabMatrix &rhs) {
  //Require equivalently sized matrices
  if (this->m_nrows != rhs.m_nrows || this->m_ncols != rhs.m_ncols)
    throw new std::logic_error("Error: Matrix Dimension Mismatch in piecewise multiplication operation");

  MLabMatrix temp(*this);
  int numel = m_nrows*m_ncols;
  while (numel-- > 0) {
    temp.m_data[numel] = rhs.m_data[numel];
  }
  return temp;
}

MLabMatrix operator+(MLabMatrix o1, float o2) {
  MLabMatrix temp(o1);
  int numel = temp.m_nrows*temp.m_ncols;
  while (numel-- > 0) {
    temp.m_data[numel] += o2;
  }
  return temp;
}

/**
 * Allow for arbitrary ordering of piecewise atrithmetic
 * operations. Declared as inline to optimize away nested
 * function calls.
 */
MLabMatrix operator+(float o1, MLabMatrix o2) {
  return operator+(o2,o1);
}

MLabMatrix operator-(MLabMatrix o1, float o2) {
  MLabMatrix temp(o1);
  int numel = temp.m_nrows*temp.m_ncols;
  while (numel-- > 0) {
    temp.m_data[numel] -= o2;
  }
  return temp;
}

MLabMatrix operator-(float o1, MLabMatrix o2) {
  return operator-(o2,o1);
}

MLabMatrix operator*(MLabMatrix o1, float o2) {
  MLabMatrix temp(o1);
  int numel = temp.m_nrows*temp.m_ncols;
  while (numel-- > 0) {
    temp.m_data[numel] *= o2;
  }
  return temp;
}

MLabMatrix operator*(float o1, MLabMatrix o2) {
  return operator*(o2,o1);
}

MLabMatrix operator/(MLabMatrix o1, float o2) {
  MLabMatrix temp(o1);
  int numel = temp.m_nrows*temp.m_ncols;
  while (numel-- > 0) {
    temp.m_data[numel] /= o2;
  }
  return temp;
}

MLabMatrix operator/(float o1, MLabMatrix o2) {
  return operator/(o2,o1);
}

MLabMatrix MLabMatrix::operator==(const MLabMatrix &rhs) {
  MLabMatrix temp(this->m_nrows, this->m_ncols, 0);
  int numel = this->m_nrows*this->m_ncols;
  while (numel-- > 0) {
    if (this->m_data[numel] == rhs.m_data[numel])
      temp.m_data[numel] = 1;
  }
  return temp;
}

MLabMatrix MLabMatrix::operator!=(const MLabMatrix &rhs) {
  MLabMatrix temp(this->m_nrows, this->m_ncols, 0);
  int numel = this->m_nrows*this->m_ncols;
  while (numel-- > 0) {
    if (this->m_data[numel] != rhs.m_data[numel])
      temp.m_data[numel] = 1;
  }
  return temp;
}

MLabMatrix MLabMatrix::operator<=(const MLabMatrix &rhs) {
  MLabMatrix temp(this->m_nrows, this->m_ncols, 0);
  int numel = this->m_nrows*this->m_ncols;
  while (numel-- > 0) {
    if (this->m_data[numel] <= rhs.m_data[numel])
      temp.m_data[numel] = 1;
  }
  return temp;
}

MLabMatrix MLabMatrix::operator>=(const MLabMatrix &rhs) {
  MLabMatrix temp(this->m_nrows, this->m_ncols, 0);
  int numel = this->m_nrows*this->m_ncols;
  while (numel-- > 0) {
    if (this->m_data[numel] >= rhs.m_data[numel])
      temp.m_data[numel] = 1;
  }
  return temp;
}

MLabMatrix MLabMatrix::operator<(const MLabMatrix &rhs) {
  MLabMatrix temp(this->m_nrows, this->m_ncols, 0);
  int numel = this->m_nrows*this->m_ncols;
  while (numel-- > 0) {
    if (this->m_data[numel] < rhs.m_data[numel])
      temp.m_data[numel] = 1;
  }
  return temp;
}

MLabMatrix MLabMatrix::operator>(const MLabMatrix &rhs) {
  MLabMatrix temp(this->m_nrows, this->m_ncols, 0);
  int numel = this->m_nrows*this->m_ncols;
  while (numel-- > 0) {
    if (this->m_data[numel] > rhs.m_data[numel])
      temp.m_data[numel] = 1;
  }
  return temp;
}

MLabMatrix MLabMatrix::operator==(const float &rhs) {
  MLabMatrix temp(this->m_nrows, this->m_ncols, 0);
  int numel = this->m_nrows*this->m_ncols;
  while (numel-- > 0) {
    if (this->m_data[numel] == rhs)
      temp.m_data[numel] = 1;
  }
  return temp;
}

MLabMatrix MLabMatrix::operator!=(const float &rhs) {
  MLabMatrix temp(this->m_nrows, this->m_ncols, 0);
  int numel = this->m_nrows*this->m_ncols;
  while (numel-- > 0) {
    if (this->m_data[numel] != rhs)
      temp.m_data[numel] = 1;
  }
  return temp;
}

MLabMatrix MLabMatrix::operator<=(const float &rhs) {
  MLabMatrix temp(this->m_nrows, this->m_ncols, 0);
  int numel = this->m_nrows*this->m_ncols;
  while (numel-- > 0) {
    if (this->m_data[numel] <= rhs)
      temp.m_data[numel] = 1;
  }
  return temp;
}

MLabMatrix MLabMatrix::operator>=(const float &rhs) {
  MLabMatrix temp(this->m_nrows, this->m_ncols, 0);
  int numel = this->m_nrows*this->m_ncols;
  while (numel-- > 0) {
    if (this->m_data[numel] >= rhs)
      temp.m_data[numel] = 1;
  }
  return temp;
}

MLabMatrix MLabMatrix::operator<(const float &rhs) {
  MLabMatrix temp(this->m_nrows, this->m_ncols, 0);
  int numel = this->m_nrows*this->m_ncols;
  while (numel-- > 0) {
    if (this->m_data[numel] < rhs)
      temp.m_data[numel] = 1;
  }
  return temp;
}

MLabMatrix MLabMatrix::operator>(const float &rhs) {
  MLabMatrix temp(this->m_nrows, this->m_ncols, 0);
  int numel = this->m_nrows*this->m_ncols;
  while (numel-- > 0) {
    if (this->m_data[numel] > rhs)
      temp.m_data[numel] = 1;
  }
  return temp;
}

float& MLabMatrix::operator()(int i, int j) {
  //Sanity checks
  if (this->m_data != NULL) {
    if (i < 0 || i >= m_nrows || j < 0 || j >= m_ncols)
      throw new std::logic_error("Error: Index out of bounds");
    else
      return m_data[i + j*m_nrows];
  }
}

//Treat the matrix like it was a 1D vector.
float& MLabMatrix::operator()(int i) {
  //Sanity checks
  if (this->m_data != NULL) {
    if (i < 0 || i >= m_nrows*m_ncols)
      throw new std::logic_error("Error: Index out of bounds");
    else
      return m_data[i];
  }
}

MLabSubMatrix MLabMatrix::operator()(Mat_i* i) {
  return MLabSubMatrix(*this,i);
}

MLabSubMatrix MLabMatrix::operator()(Mat_i* i, Mat_i* j) {
  return MLabSubMatrix(*this,i,j);
}

std::ostream &operator<<(std::ostream &stream, MLabMatrix a) {
  for (int i = 0; i < a.m_nrows; i++) {
    stream << std::endl;
    for (int j = 0; j < a.m_ncols; j++) {
      stream << a.m_data[i+j*a.m_nrows] << '\t';
    }
  }
  stream << std::endl;
  return stream;
}

MLabMatrix MLabMatrix::transpose() {
  MLabMatrix temp(this->m_ncols, this->m_nrows,0);
  for (int i = 0; i < m_nrows; i++) {
    for (int j = 0; j < m_ncols; j++) {
      temp.m_data[j+i*m_ncols] = m_data[i+j*m_nrows];
    }
  }
  return temp;
}

int MLabMatrix::length() {
  if (m_nrows >= m_ncols)
    return m_nrows;
  else
    return m_ncols;
}

MLabMatrix MLabMatrix::size() {
  MLabMatrix result(1,2);
  result(0) = m_nrows;
  result(1) = m_ncols;
  return result;
}

void MLabMatrix::reshape(int x, int y) {
  int numel_old = m_nrows * m_ncols;
  int numel_new = x*y;
  if (numel_old != numel_new)
    throw new std::logic_error("Error: To reshape the number of elements must not change.");
  m_nrows = x;
  m_ncols = y;
}

MLabSubMatrix::MLabSubMatrix(MLabMatrix& sup, Mat_i* ind) : m_supData(sup) {
  int end_l = sup.m_nrows*sup.m_ncols - 1;
  int length = determine_length(ind,end_l);

  //Do class initialization
  m_nrows = length;
  m_ncols = 1;
  m_data = (float*) malloc(sizeof(float) * (length));
  if (m_data == NULL)
    throw new std::bad_alloc();
    
  //Fill out the actual values
  fill_map_1d(ind, end_l);
}

MLabSubMatrix::MLabSubMatrix(MLabMatrix& sup, Mat_i* ind_i, Mat_i* ind_j) : m_supData(sup) {
  int end_i = sup.m_nrows-1;
  int end_j = sup.m_ncols-1;
  
  int length_i = determine_length(ind_i,end_i);
  int length_j = determine_length(ind_j,end_j);
  
  //Do class initialization
  m_nrows = length_i;
  m_ncols = length_j;
  m_data = (float*) malloc(sizeof(float) * (m_nrows*m_ncols));
  if (m_data == NULL)
    throw new std::bad_alloc();
  
  //Fill in the values
  fill_map_2d(ind_i,ind_j,end_i,end_j);
}

MLabMatrix& MLabSubMatrix::operator=(const MLabMatrix &rhs) {
  //Perform the assignment operation on the super-matrix and then return
  //a reference to it. This is consistent with Matlab's syntax, which doesn't
  //allow nested submatrix indexing.
  
  //san check
  if (rhs.m_nrows != this->m_nrows || rhs.m_ncols != this->m_ncols)
    throw new std::logic_error("Error: Array Dimension Mismatch in submatrix assignment");
  
  int numel = rhs.m_nrows*rhs.m_ncols;
  while (numel-- > 0) {
    m_supData.m_data[(int) (this->m_data[numel])] = rhs.m_data[numel];
  }
  
  return m_supData;
}

MLabSubMatrix::operator MLabMatrix() {
  MLabMatrix a(m_nrows,m_ncols,0);
  int numel = m_nrows*m_ncols;
  while (numel-- > 0) {
    a.m_data[numel] = m_supData.m_data[(int)(m_data[numel])];
  }
  return a;
}

void MLabSubMatrix::fill_map_2d(Mat_i* ind_i, Mat_i* ind_j, int dim_i, int dim_j) {
  if (ind_i[0].op == 0 || ind_j[0].op == 1) {
    return;
  }
  
  //Fill in the first column with the i-index pattern. We can
  //then use this as a base to fill in all of the columns.
  fill_map_1d(ind_i,dim_i);
  
  //Now, since the pattern of each column will remain the same
  //and just change by a constant offset, fill in the remaining columns.
  for (int i = 1; i < m_ncols; i++) {
    memcpy(this->m_data+(i*m_nrows), this->m_data, sizeof(float) * m_nrows);
  }
  
  //Now we just need to offset each column according to the pattern
  //passed in as ind_j. Code largely copied from 'fill_map_1d'
  if (ind_j[0].op == 3) {
    std::cout << "whats going on" << std::endl;
    //Handle the all case.
    for (int i = 0; i < m_ncols; i++) {
      for (int j = 0; j < m_nrows; j++) {
        m_data[j + i*m_nrows] += i*(dim_i+1);
      }
    }
    return;
  }
  
  int index = 0;
  int write_ptr = 0;
  //Note that any san checks on the well-formedness of the input
  //string would have already been performed.
  while (ind_j[index].op != 0) {
    if (ind_j[index].op == 2 || ind_j[index].op == 1) {
      int mapped_column = get_int(ind_j[index],dim_j);
      for (int i = 0; i < m_nrows; i++) {
        this->m_data[write_ptr++] += mapped_column*m_nrows;
      }
    }
    if (ind_j[index+1].op == 4) { //handle 'to' operator
      int index_1 = get_int(ind_j[index],dim_j);
      int index_2 = get_int(ind_j[index+2],dim_j);      
      for (int i = index_1+1; i <= index_2; i++) {
        for (int j = 0; j < m_nrows; j++) {
          this->m_data[write_ptr++] += (float) (i*m_nrows);
        }
      }
      index += 2;
    }
    index++;
  }  
}

void MLabSubMatrix::fill_map_1d(Mat_i* ind,int dim_l) {
  if (ind[0].op == 0) {
    return;
  }
  
  if (ind[0].op == 3) {
    for (int i = 0; i < m_nrows; i++) {
      this->m_data[i] = (float) i;
    }
    return;
  }
  
  int index = 0;
  int write_ptr = 0;
  //Note that any san checks on the well-formedness of the input
  //string would have already been performed.
  while (ind[index].op != 0) {
    if (ind[index].op == 2 || ind[index].op == 1)
      this->m_data[write_ptr++] = get_int(ind[index],dim_l);
    if (ind[index+1].op == 4) { //handle 'to' operator
      int index_1 = get_int(ind[index],dim_l);
      int index_2 = get_int(ind[index+2],dim_l);      
      for (int i = index_1+1; i <= index_2; i++) {
        this->m_data[write_ptr++] = (float) i;
      }
      index += 2;
    }
    index++;
  }
}

int MLabSubMatrix::get_int(Mat_i a, int l) {
  if (a.op == 2)
    return a.index;
  else {
    return (l+a.index);
  }
}

int MLabSubMatrix::determine_length(Mat_i* ind, int dim_l) {
  //Handle san check
  if (ind[0].op == 0) {
    return 0;
  }
  
  //Handle 'all' case
  if (ind[0].op == 3)
    return dim_l+1;
  
  //Handle the bulk of the cases
  int index = 0;
  int length = 0;
  while (ind[index].op != 0) {
    if (ind[index].op == 2 || ind[index].op == 1)
      length++;
    else
      throw new std::logic_error("Error: Malformed subindexing string");
    if (ind[index+1].op == 4) { //Handle 'to' operator
      if (ind[index+2].op != 2 && ind[index+2].op != 1)
        throw new std::logic_error("Error: Malformed subindexing string");
      int index_1 = get_int(ind[index],dim_l);
      int index_2 = get_int(ind[index+2],dim_l);
      length += index_2 - index_1;
      index += 2;
    }
    index++;
  }
  return length;
}

Mat_i Mat_i::operator+(int i) {
  return (Mat_i(index+i,op));
}

Mat_i Mat_i::operator-(int i) {
  return (Mat_i(index-i,op));
}

Mat_i Mat_i::operator*(int i) {
  return (Mat_i(index*i,op));
}

Mat_i Mat_i::operator/(int i) {
  return (Mat_i(index/i,op));
}

Mat_i operator+(int i, Mat_i j) {
  return(Mat_i(j.index,j.op)+i);
} 

Mat_i operator-(int i, Mat_i j) {
  return(Mat_i(j.index,j.op)-i);
} 

Mat_i operator*(int i, Mat_i j) {
  return(Mat_i(j.index,j.op)*i);
} 

Mat_i operator/(int i, Mat_i j) {
  return(Mat_i(j.index,j.op)/i);
} 

} //namespace WNV

