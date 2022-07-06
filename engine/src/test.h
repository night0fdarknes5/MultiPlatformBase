#pragma once

#include <iostream>

//__attribute__((visibility("default"))) void Test();
__declspec(dllexport) void Test();