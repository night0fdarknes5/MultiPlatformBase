
#pragma once

#if defined(__APPLE__)
#define MAC
#endif

#if defined(WIN64) || defined(WIN32)
#define WINDOWS
#endif

#if defined(unix) || defined(__unix__) || defined(__unix)
#define LINUX
#endif

#ifdef DLLEXPORT
#ifdef _MSC_VER
#define DLL __declspec(dllexport)
#else
#define DLL __attribute__((visibility("default")))
#endif
#else
#ifdef _MSC_VER
#define DLL __declspec(dllimport)
#else
#define DLL 
#endif
#endif