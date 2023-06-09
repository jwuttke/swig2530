#pragma once

class Foo {
public:
    Foo() = default; // required by Swig
    Foo(int i);
private:
    int m_i;
};
