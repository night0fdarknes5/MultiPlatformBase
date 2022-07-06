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


DLL void Test()
{
    //std::cout << "Hello from Dynamic Lib\n";

    sol::state lua;
    lua.open_libraries(sol::lib::base);
    //lua.script("print('hello from dll lua')");
    
    std::string path = std::filesystem::current_path().string() + "/scripts/script1.lua";
    lua.script_file(path);
    
    sol::function TestFunc = lua["TestFunc"];

    lua.set_function("CPPTestFunc",CPPTestFunc);

    TestClass t;

    t.ChangeNum();

    std::cout << t.a << ":" << t.b << std::endl;

    lua.set_function("ChangeNum", &TestClass::ChangeNum, &t);

    TestFunc();

    std::cout << t.a << ":" << t.b << std::endl;


}