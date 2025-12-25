#include <iostream>
#include "sorter.h"
#include <deque>
#include <vector>
#include <map>
#include "sorter.h"
#include <list>

struct string_size_less
{

  bool operator()( const std::string& lhs,
                   const std::string& rhs ) const
  {
    return lhs.size() < rhs.size();
  }

};

const int max = 1000;

int main()
{
  int your_mark = 1;
  /* 2-es */
  std::vector<int> v;
  v.reserve( max );
  for( int i = 0; i < max; ++i )
  {
    v.push_back( i % 5 );
  }

  std::deque<double> d;
  d.push_back( 5.42 );
  d.push_back( 2.37 );
  d.push_back( 3.43 );

  sorter<std::deque<double>, double > ds( d );
  sorter<std::vector<int>, int> vs( v );
  vs.sort();
  ds.sort();

  if( 0 == v[ 4 ] && d[ 0 ] < 2.5 && d[ 2 ] > 5.3 && 4 == v[ max - 2 ] )
  {
    ds.reset();
    vs.reset();
    your_mark = v[ 1 ] + ( d[ 0 ] > 5.3 );
  }

  /* 3-as */
  int a[] = { 7, 2, 5, 1, 6 };
  double b[] = { 8.76, 5.88, 6.32 };
  sorter<int*, int> as( a, sizeof( a ) / sizeof( a[ 0 ] ) );
  sorter<double*, double> bs( b, sizeof( b ) / sizeof( b[ 0 ] ) );
  as.sort();
  bs.sort();
  if( 1 == a[ 0 ] && 2 == a[ 1 ] && b[ 0 ] < 5.99 && b[ 2 ] > 8.5 )
  {
    as.reset();
    bs.reset();
    your_mark = ( 7 == a[ 0 ] ) + ( 6 == a[ 4 ] ) + ( b[ 0 ] > 8.25 );
  }

  /* 4-es */
  std::list<double> ld;
  ld.push_back( 4.36 );
  ld.push_back( 2.89 );
  ld.push_back( 6.44 );
  ld.push_back( 5.01 );
  sorter<std::list<double> > ls( ld );

  ls.sort();
  as.sort( std::greater<int>() );

  if( 6 == a[ 1 ] && ld.front() < 2.95 && ld.back() > 6.26 )
  {
    ls.reset();
    your_mark = a[ 4 ] + a[ 3 ] + ( ld.front() > 4.18 );
  }

  /* 5-os */
  std::map<std::string, std::string> mss;
  mss[ "Blabla" ] = "bullshit";
  mss[ "C++" ] = "<3";
  mss[ "Haskell" ] = ":-o";
  sorter<std::map<std::string, std::string> > ms( mss );
  ms.sort( string_size_less() );

  std::map<int, int, std::greater<int> > mii;
  for( int i = 0; i < max; ++i )
  {
    mii[ i ] = 2 * i;
  }
  sorter<std::map<int, int, std::greater<int> > > ams( mii );
  ams.sort();

  if( ":-o" == mss[ "C++" ] && "bullshit" == mss[ "Haskell" ] &&
      2 * ( max - 1 )  == mii[ 0 ] && 2 * ( max - 2 ) == mii[ 1 ] )
  {
    ms.reset();
    your_mark = ( "<3" == mss[ "C++" ] ) + mii[ max - 3 ];
  }

  std::cout << "Your mark is "
            << your_mark
            << std::endl;
}

