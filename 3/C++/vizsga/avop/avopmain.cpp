#include <iostream>
#include "arviops.h"
#include <functional>
#include "arviops.h"
#include <string>

struct good_language
{

  bool operator()( const std::string& s ) const
  {
    return "C" == s || "C++" == s;
  }

};

struct is_odd
{

  bool operator()( int i ) const
  {
    return 1 == i % 2;
  }

};

class greater
{

  double b;

public:

  greater( double d ): b( d ) { }

  bool operator()( double d )
  {
    return d > b;
  }

};

struct string_size_less
{

  bool operator()( const std::string& lhs,
                   const std::string& rhs ) const
  {
    return lhs.size() < rhs.size();
  }

};

const int max = 1024;

int main()
{
  int your_mark = 1;
  /* 2-es */
  int m[] = { 0, max };
  ++m[ 0 ];
  int a[] = { 7, 3, 8, 2, 1 };
  double d[] = { 3.5, 7.89, 2.14 };
  std::string s[] = { "C", "C++", "Haskell", "Python" };
  array_view_operations<int> aops( a, sizeof( a ) / sizeof( a[ 0 ] ) );
  array_view_operations<double> dops( d, sizeof( d ) / sizeof( d[ 0 ] ) );
  array_view_operations<std::string> strops( s, sizeof( s ) / sizeof( s[ 0 ] ) );

  strops.reverse();
  aops.reverse();
  dops.reverse();
  dops.reset();

  if( d[ 0 ] > 2.9 && "C++" == s[ 2 ] && d[ 2 ] < 2.3 && 7 == a[ 4 ] )
  {
    your_mark = a[ 1 ];
  }

  /* 3-as */
  aops.shift( 2 );
  strops.shift( 10 );
  dops.shift( -5 );

  int t[] = { 7, 4, 2 };
  if( "C" == s[ 1 ] )
  {
    array_view_operations<int> tops( t, sizeof( t ) / sizeof( t[ 0 ] ) );
    tops.reverse();
  }
  if ( 2 == t[ 2 ] && "C++" == s[ 0 ] && d[ 2 ] > 7.3 && 7 == s[ 3 ].size() )
  {
    your_mark = a[ 0 ];
  }

  /* 4-es */
  dops.sort();
  aops.sort();

  if ( 0 == aops.get_first_index_if( is_odd() ) &&
       3 == aops.get_first_index_if( greater( 4 ) ) &&
       0 == strops.get_first_index_if( good_language() ) &&
       -1 == aops.get_first_index_if( greater( max ) ) )
  {
    your_mark = t[ 1 ];
  }

  /* 5-os */
  std::string langs[] = { "Fortran", "Ada", "Eiffel", "Java", "Go" };
  array_view_operations<std::string> lo( langs );
  lo.sort( string_size_less() );
  lo.shift( 2 );

  strops.sort( string_size_less() );

  aops.sort( std::greater<int>() );
  if( 8 == a[ 0 ] && "Ada" == langs[ 3 ] && "Eiffel" == langs[ 0 ] &&
      "C" == s[ 0 ] && "Haskell" == s[ 3 ] )
  {
    your_mark = a[ 3 ] + a[ 2 ];
  }

  std::cout << "Your mark is " << your_mark << std::endl;
}

