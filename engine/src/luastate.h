#pragma once

#include "sol/sol.hpp"

class LuaState{
private:
    LuaState(); // Disallow instantiation outside of the class.
public:
    LuaState(const LuaState&) = delete;
    LuaState& operator=(const LuaState &) = delete;
    LuaState(LuaState &&) = delete;
    LuaState & operator=(LuaState &&) = delete;

    static auto& instance(){
        static sol::state lua;
        return lua;
    }
}; 