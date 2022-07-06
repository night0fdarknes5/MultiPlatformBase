#include "test.h"

#include "sol/sol.hpp"

#include <iostream>
#include <string>

int main(int argc, char** argv)
{
    std::cout << "Hello World!\n";
    
    __declspec(dllimport) void Test();
    Test();

    sol::state lua;
    lua.open_libraries(sol::lib::base);
    lua.script("print('Hello from app lua')");

    std::string s;
    std::cin >> s;

    return 0;
}