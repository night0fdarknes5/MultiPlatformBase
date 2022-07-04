#include "test.h"

#include "sol/sol.hpp"

#include <string>
#include <filesystem>

__attribute__((visibility("default"))) void Test()
{
    std::cout << "Hello from Dynamic Lib\n";

    sol::state lua;
    lua.open_libraries(sol::lib::base);
    lua.script("print('hello from dll lua')");

    
    std::string path = std::filesystem::current_path().string() + "/scripts/script1.lua";

    lua.script_file(path);
}