%module(directors="1", moduleimport="import $module") "libB"

%{
#include "A/Foo.h"
#include "B/Bar.h"
%}

%include "B/Bar.h"
