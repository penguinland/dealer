#!/usr/bin/python3
"""
This code was made by Alan Davidson <alan.davidson@gmail.com> on Dec 22, 2025.

This script generates the precomputed table in prerand.c. That file was then
edited further to include some documentation and a helper function. See that
file for details.
"""

def make_list(i):
    vals = ["{:3}".format(x % i) for x in range(1024)]
    for i in range(1024 % i):
        vals[-(i+1)] = " HI"
    return vals


def print_list(i):
    l = make_list(i)
    print(f"    // randint({i})")
    print("    //   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F")
    for j in range(1024 // 16):
        # The [1:] at the end removes the leading space at the beginning
        print("    {}  // {:02X}".format((",".join(l[16*j:16*(j+1)])[1:]), j))
    print("")

if __name__ == "__main__":
    for i in range(52):
        print_list(i + 1)
