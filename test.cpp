#include <cstdio>
#include <boost/format.hpp>

int f() { printf("hello\n"); return 0; }
int g() { printf("boost format %s\n", (boost::format("%d:%d:%d") % 1 % 2 % 3).str().c_str()); return 0; }
