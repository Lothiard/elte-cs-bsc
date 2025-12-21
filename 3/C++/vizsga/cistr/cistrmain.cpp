#include <iostream>
#include "cistring.h"
#include <string>
#include "cistring.h"

const int max = 1000;

int main()
{
  int your_mark = 1;
  /* 2-es */
  case_insensitive_basic_string<char> msg;
  msg.push_back( 'H' );
  msg.push_back( 'e' );
  msg.push_back( 'l' );
  msg.push_back( 'l' );
  msg.push_back( 'o' );
  msg.push_back( '!' );
  const case_insensitive_basic_string<char> cmsg = msg;
  const std::string p = "Ll";

  case_insensitive_basic_string<char> a;
  std::string s;
  for( int i = 0; i < max; ++i )
  {
    a.push_back( 0 == i % 2 ? 'a' : 'A' );
    s.push_back( 0 == i % 3 ? 'a' : 'A' );
  }

  if ( 1 == msg.find( 'E' ) &&
       6 == cmsg.size() &&
       0 == a.find( s ) &&
       0 == cmsg.find( 'h' ) )
  {
    your_mark = cmsg.find( p );
  }

  /* 3-as */
  msg[ 1 ] = 'a';

  case_insensitive_basic_string<wchar_t> wm;
  wm.push_back( L'C' );
  wm.push_back( L'+' );
  wm.push_back( L'+' );

  if ( 1 == wm.find( L'+' ) &&
       0 == wm.find( L"C++" ) &&
       0 == msg.find( "HAL" ) &&
       case_insensitive_basic_string<char>::npos == msg.find( "He" ) &&
       '!' == cmsg[ 5 ] )
  {
    your_mark = wm.size();
  }

  /* 4-es */
  const std::string np = "aAAa";
  int len = np.size();
  if ( 1 == wm.rfind( L"++" ) &&
       case_insensitive_basic_string<char>::npos == cmsg.rfind( "!!!" ) &&
       max - len == a.rfind( np.c_str() ) )
  {
    your_mark = cmsg.rfind( "L" ) + msg.rfind( "ALL" );
  }

  /* 5-os */
  case_insensitive_string cis;
  cis.push_back( '!' );
  std::string t = "heLLo!";
  std::wstring u = L"CPP";
  std::string v( max, 'a' );

  if ( v == a &&
       !( cmsg == msg ) &&
       cmsg == t &&
       !( u == wm ) )
  {
    your_mark = cmsg.find( cis[ 0 ] );
  }

  std::cout << "Your mark is " << your_mark;
  std::endl( std::cout );
}

