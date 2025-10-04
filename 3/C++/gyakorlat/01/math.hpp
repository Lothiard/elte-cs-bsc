#ifndef MATH_HPP
#define MATH_HPP

#include <cmath>

extern const double pi;

inline double my_tan(double grad)
{
  // TODO: error handling
  return sin(grad) / cos(grad);
}


#endif
