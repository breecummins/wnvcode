/**
 * MLabMatrix.h
 *
 * Declaration file for a Matrix class with features similar to those
 * of the MATLAB environment with respect to matrix operations.
 * Note some 'important' features (such as growable matrices) are
 * omitted and should be coded around.
 *
 * Written by Justin Walbeck
 */
 
#include <iostream>
#include <stdexcept>

namespace WNV {

/**
 *Utility structure for doing matrix subindexing.
 */
struct Mat_i {
  Mat_i(int i, int j) : index(i), op(j) {}
  Mat_i(int i) : index(i), op(2) {if (i == -1) op = 0;}
  Mat_i(float f) : index((int)f), op(2) {}
  int index, op;
    
  Mat_i operator+(int i);
  Mat_i operator-(int i);
  Mat_i operator*(int i);
  Mat_i operator/(int i);
};

Mat_i operator+(int i, Mat_i j);

#define end   Mat_i(0,1)
#define to    Mat_i(0,4)
#define all   Mat_i(0,3)

class MLabSubMatrix;

/**
 *The actual matrix object itself.
 */
class MLabMatrix {
public:
  MLabMatrix(int x, int y); //constructor with dimensions filled in
  MLabMatrix(int x, int y, float d); //[X,Y] sized matrix with all vals = d
  MLabMatrix(const MLabMatrix& copy); //Copy constructor
  
  ~MLabMatrix();
  
  //Matrix math operator overloading.
  MLabMatrix& operator=(const MLabMatrix &rhs);
  MLabMatrix& operator+=(const MLabMatrix &rhs);
  MLabMatrix& operator-=(const MLabMatrix &rhs);
  MLabMatrix& operator*=(const MLabMatrix &rhs);
  MLabMatrix& operator+=(const float &rhs);
  MLabMatrix& operator-=(const float &rhs);
  MLabMatrix& operator*=(const float &rhs);
  MLabMatrix& operator/=(const float &rhs);
  MLabMatrix operator+(const MLabMatrix &rhs);
  MLabMatrix operator-(const MLabMatrix &rhs);
  MLabMatrix operator*(const MLabMatrix &rhs);
  //Handle special case 'dot' Matrix by Matrix multiplication
  MLabMatrix Mult(MLabMatrix &rhs);
  //Piecewise "dot" operator overloading. Only supports floats
  friend MLabMatrix operator+(MLabMatrix o1, float o2);
  friend MLabMatrix operator+(float o1, MLabMatrix o2);
  friend MLabMatrix operator-(MLabMatrix o1, float o2);
  friend MLabMatrix operator-(float o1, MLabMatrix o2);
  friend MLabMatrix operator*(MLabMatrix o1, float o2);
  friend MLabMatrix operator*(float o1, MLabMatrix o2);
  friend MLabMatrix operator/(MLabMatrix o1, float o2);
  friend MLabMatrix operator/(float o1, MLabMatrix o2);
  //Logical comparision operators. Returns piecewise results of
  //given logical operation. Non-bool return means don't try to
  //use this class with 'std' data structures
  MLabMatrix operator==(const MLabMatrix &rhs);
  MLabMatrix operator!=(const MLabMatrix &rhs);
  MLabMatrix operator<=(const MLabMatrix &rhs);
  MLabMatrix operator>=(const MLabMatrix &rhs);
  MLabMatrix operator<(const MLabMatrix &rhs);
  MLabMatrix operator>(const MLabMatrix &rhs);
  MLabMatrix operator==(const float &rhs);
  MLabMatrix operator!=(const float &rhs);
  MLabMatrix operator<=(const float &rhs);
  MLabMatrix operator>=(const float &rhs);
  MLabMatrix operator<(const float &rhs);
  MLabMatrix operator>(const float &rhs);
  //Finally, indexing operators. See below for submatrix indexing
  float& operator()(int i, int j);
  float& operator()(int i);
  MLabSubMatrix operator()(Mat_i* i,Mat_i* j);
  MLabSubMatrix operator()(Mat_i* i);
  //Allows for printing to an ostream object (for debugging)
  friend std::ostream &operator<<(std::ostream &stream, MLabMatrix a);
  
  //Various utility functions
  MLabMatrix transpose();
  int length();
  MLabMatrix size();
  void reshape(int x, int y);

  MLabMatrix(); //def. constructor. Declared public to handle array
                //inititialization. Don't use this.
  
//Internal data representation and other such unsundry things  
protected:
          
  friend class MLabSubMatrix;
  
  float* m_data;
  int m_nrows, m_ncols;
};

/**
 *A special matrix object to handle subindexing. Because subindexing can
 *be used to both reference and assign a submatrix, we need to accomodate
 *this. As such, any time a typecast to 'MLabMatrix' is made, we 'collapse'
 *this submatrix notation into a brand new MLabMatrix. Because assignment
 *does not require a typecast, we can still handle this bit of MatLab
 *syntax.
 */
class MLabSubMatrix {
public:
  MLabSubMatrix(MLabMatrix&, Mat_i*);
  MLabSubMatrix(MLabMatrix&, Mat_i*, Mat_i*);
  
  MLabMatrix& operator=(const MLabMatrix &rhs);
  operator MLabMatrix();

private:
  float* m_data;
  int m_nrows, m_ncols;
  MLabMatrix& m_supData; //Pointer to super-matrix data pointer.
  
  int determine_length(Mat_i*,int);
  int get_int(Mat_i a, int l);
  void fill_map_1d(Mat_i*,int);
  void fill_map_2d(Mat_i*,Mat_i*,int,int dim_j);
};

} //namespace WNV
