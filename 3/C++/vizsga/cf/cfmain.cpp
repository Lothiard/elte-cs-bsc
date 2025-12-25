#include <iostream>
#include "contfind.h"
#include <string>
#include <list>
#include <map>
#include "contfind.h"
#include <algorithm>

const int max = 1000;

int main()
{
  int your_mark = 1;
  /* 2-es */
  std::list<int> la;
  std::list<int> lb;

  la.push_back( 1 );
  lb.push_back( 1 );
  lb.push_back( 1 );
  lb.push_back( 1 );
  std::list<int>::iterator li = lb.begin();
  ++li;

  container_finder<std::list<int> > fli;
  fli.add_container( la ).add_container( lb );


  std::string a[ max ];
  container_finder<std::string> fs;
  for( int i = 0; i < max; ++i )
  {
    a[ i ] = ":-)";
    fs.add_container( a[ i ] );
  }
  std::string s = a[ 0 ];

  fli.which( la.begin() )->push_back( 2 );

  fs.which( a[ max / 2 ].begin() + 2 )->push_back( ')' );

  if ( !fs.which( s.begin() ) && 4 == a[ max / 2 ].size() &&
       !fs.which( a[ 0 ].end() ) && 3 == fli.which( li )->size() )
  {
    your_mark = la.size();
  }

  /* 3-as */
  std::list<int> lc;
  lc.push_back( 2 );

  fli += lc;
  fli -= lb;

  fs += s;
  fs -= a[ 0 ];

  if ( !fs.which( a[ 0 ].begin() + 1 ) && !fli.which ( li ) &&
       lc.front() == your_mark && fli.which( lc.begin() ) )
  {
    your_mark = fs.which( s.begin() + 1 )->size();
  }

  /* 4-es */
  std::list<int> ld = lc;
  fli += lb;
  fli[ li ].push_back( 1 );

  std::string::reverse_iterator ri = a[ 1 ].rbegin() + 2;

  fs[ ri ].push_back( ')' );

  if ( 1U * your_mark == fs.which( s.rbegin() )->size() && 4 == a[ 1 ].size() &&
       !fs.which( s.rend() ) && !fli.which( ld.rbegin() ) )
  {
    your_mark = lb.size();
  }

  /* 5-os */
  container_finder<std::string> z;
  z += s;
  z[ s.rbegin() + 1 ] = "Hello";

  container_finder<std::list<int> > x;
  container_finder<std::list<int> > y;

  x += lc;
  x += la;
  x += lb;

  y += lc;
  y += la;
  y += lc;
  y += lb;

  if ( x == y && y == fli && !( z == fs ) &&
       z != fs && !( y != x ) )
  {
    your_mark = s.size();
  }

    std::cout << (x == y) << (y == fli) << !( z == fs ) <<
       (z != fs) << !( y != x ) << '\n';
  std::cout << "Your mark is " << your_mark;
  std::endl( std::cout );
}
