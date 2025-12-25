#include <iostream>
#include "arraccview.h"
#include <string>
#include <algorithm>
#include <functional>
#include "arraccview.h"

struct longer
{

  std::string operator()( const std::string& lhs,
                          const std::string& rhs ) const
  {
    return lhs.size() < rhs.size() ? rhs : lhs;
  }

};

const int max = 1000;

int main()
{
  int your_mark = 1;
  /* 2-es */
  std::string s[] = { "Hello", "World" };
  array_accumulate_view<std::string> sv( s, sizeof( s ) / sizeof( s[ 0 ] ) );

  int m[]  = { 3, 8, 9 };
  array_accumulate_view<int> mv( m, sizeof( m ) / sizeof( m[ 0 ] ) );
  for( unsigned int i = 0; i < sizeof( m ) / sizeof( m[ 0 ] ); ++i )
  {
    m[ i ] = max;
  }

  int a[] = { 3, 6, 4 };
  array_accumulate_view<int> av( a, sizeof( a ) / sizeof( a[ 0 ] ) );
  ++a[ 1 ];
  ++a[ 2 ];

  double d[] = { 3.7, 4.8 };
  const array_accumulate_view<double> dv( d, sizeof( d ) / sizeof( d[ 0 ] ) );

  if ( dv.at( 1 ) > 8.1 && 5 == a[ 2 ] && 10 == av.at( 1 ) &&
       mv.size() * max == mv.at( 2 ) && 5 == s[ 1 ].size() &&
       "HelloWorld" == sv.at( 1 ) )
  {
    your_mark = dv.size();
  }

  /* 3-as */
  std::string ems[] = { "!", "!!" };
  sv.add( ems, sizeof( ems ) / sizeof( ems[ 0 ] ) );
  int pa[] = { 1, 1, 5 };
  av.add( pa, sizeof( pa ) / sizeof( pa[ 0 ] ) );
  pa[ 0 ] = 2;
  int pb[] = { 4, 3 };
  av.add( pb, sizeof( pb ) / sizeof( pb[ 0 ] ) );

  if( 4 == sv.size() && 18 == av.at( 4 ) && 27 == av[ 6 ] && 8 == av.size() )
  {
    std::string msg = sv[ 3 ];
    your_mark = std::count( msg.begin(), msg.end(), '!' );
  }

  /* 4-es
  int r[] = { 4, 2, 3, 2 };
  array_accumulate_view<int, std::multiplies<int> > rprods( r );
  array_accumulate_view<int, std::multiplies<int> > aprods( a );

  std::string langs[] = { "C++", "Python", "Java", "C", "Clojure" };
  array_accumulate_view<std::string, longer> langsv( langs );

  if( 3 == aprods.size() && 24 == rprods[ 2 ] && langsv[ 3 ] != langsv[ 4 ] &&
      "Python" == langsv[ 2 ] && 21 == aprods[ 1 ]  && 5 == langsv.size() )
  {
    your_mark = rprods.size();
  }
  */

  /* 5-os
  std::string ml[] = { "C#", "Assembly", "Brainfuck" };
  std::string ol[] = { "Objective-C" };
  langsv.add( ml );
  langsv += ol;

  array_accumulate_view<int, std::multiplies<int> > pbv( pb );
  pbv += pa;

  if( 9 == langsv.size() && 120 == pbv[ 4 ] && "Assembly" == langsv[ 6 ] &&
      "C" == langs[ 3 ] && "Python" == langsv[ 3 ] && ol[ 0 ] == langsv[ 8 ] )
  {
    your_mark = pbv.size();
  }
  */
  std::cout << "Your mark is " << your_mark;
  std::endl( std::cout );
}

