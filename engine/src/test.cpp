#include "test.h"

#include "sol/sol.hpp"

#include <string>
#include <filesystem>

class TestClass
{
public:
    int a = 0;
    int b = 10;
    void ChangeNum()
    {
        a++;
        b--;
    }
};

void CPPTestFunc()
{
    std::cout << "CPP Test function\n";
};

//__attribute__((visibility("default"))) void Test()
__declspec(dllexport) void Test()
{
    std::cout << "Hello from Dynamic Lib\n";

    sol::state lua;
    lua.open_libraries(sol::lib::base);
    lua.script("print('hello from dll lua')");
    
    std::string path = std::filesystem::current_path().string() + "/scripts/script1.lua";
    lua.script_file(path);
    
    sol::function TestFunc = lua["TestFunc"];

    lua.set_function("CPPTestFunc",CPPTestFunc);

    TestFunc();
}