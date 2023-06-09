%module(directors="1", moduleimport="import $module") "libA"

%{
#include "A/Foo.h"
%}

%include "A/Foo.h"
