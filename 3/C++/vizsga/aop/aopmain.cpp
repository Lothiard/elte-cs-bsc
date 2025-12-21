#include <iostream>
#include "accop.h"
#include <map>
#include <list>
#include <vector>
#include <set>
#include <string>
#include <deque>
#include "accop.h"
#include <algorithm>

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
  std::list<double> c;
  c.push_back( 12.34 );

  std::vector<int> v;
  v.reserve( max );
  for( int i = 0; i < max; ++i )
  {
    v.push_back( i );
  }

  std::vector<int> o;
  o.push_back( max - 1 );

  std::set<std::string> s;
  s.insert( "Hello" );
  s.insert( "World" );
  std::set<std::string>::iterator si = s.begin();
  ++si;

  access_operations<std::list<double> > ac( c );
  access_operations<std::vector<int> > av( v );
  const access_operations<std::vector<int> > cav( v );
  access_operations<std::set<std::string> > as( s );

  if ( av.is_valid( v.begin() + max / 2 ) && cav.is_valid( max - 1 ) &&
       !av.is_valid( o.begin() ) && !ac.is_valid( c.end() ) &&
       !av.is_valid( -1 ) && !av.is_valid( max ) && as.is_valid( si ) )
  {
    your_mark += ac.is_valid( c.begin() );
  }

  /* 3-as */
  std::deque<int> d;
  d.push_back( your_mark );
  access_operations<std::deque<int> > ad( d );

  av.is_valid( 0 ) && ++av[ 0 ];
  ad.is_valid( 0 ) && ++ad[ 0 ];

  if ( cav.is_valid( 1 ) && 1 == cav[ 1 ] && av[ 0 ] == av[ 1 ] &&
       ad.is_valid( d.begin() ) && !ad.is_valid( d.end() ) )
  {
    your_mark = ad[ 0 ];
  }

  /* 4-es */
  std::string msg = "Hello World";
  access_operations<std::string> amsg( msg );

  if ( !ac.is_valid( 0 ) && !ac.is_valid( 1 ) &&
       !as.is_valid( 0 ) && !as.is_valid( 1 ) &&
       amsg.is_valid( msg.begin() + your_mark ) &&
       amsg.is_valid( your_mark ) && !amsg.is_valid( max ) &&
       your_mark == d.size() + s.size() )
  {
    your_mark += as.is_valid( s.begin() );
  }

  /* 5-os */
  std::map<std::string, int, string_size_less> m;
  m[ "C++" ] = 5;
  m[ "Pascal" ] = 3;
  m[ "Fortran" ] = 1;
  std::map<std::string, int, string_size_less>::iterator mi = m.begin();
  ++mi;
  access_operations<std::map<std::string, int, string_size_less> > am( m );
  const access_operations<std::map<std::string,
                                   int,
                                   string_size_less> > cam( m );

  am[ "Modula" ] = 4;

  std::map<int, int> x;
  x[ max ] = max;
  access_operations<std::map<int, int> > ax( x );

  if ( am.is_valid( "Ada" ) && !ax.is_valid( max - 1 ) && ax.is_valid( max ) &&
       am.is_valid( "Python" ) && !am.is_valid( "Java" ) && am.is_valid( mi ) &&
       !ax.is_valid( 0 ) && max == ax[ max ] && your_mark == am[ "Eiffel" ] &&
       5 == cam[ ":-o" ] && !am.is_valid( m.end() ) && ax.is_valid( x.begin() ) )
  {
    your_mark = am[ ":-)" ];
  }

  std::cout << "Your mark is " << your_mark;
  std::endl( std::cout );
}

