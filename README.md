# AutoAccessorMethods

[![Build Status](https://travis-ci.com/harryscholes/AutoAccessorMethods.jl.svg?branch=master)](https://travis-ci.com/harryscholes/AutoAccessorMethods.jl)
[![Coverage](https://codecov.io/gh/harryscholes/AutoAccessorMethods.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/harryscholes/AutoAccessorMethods.jl)

Automatically define accessor methods for fields of a type.

`@auto_accessor_methods` transforms the following code:

```julia
@auto_accessor_methods struct T
    x
    y
end
```

into:

```julia
export x, y

struct T
    x
    y
end

x(obj::T) = obj.x
y(obj::T) = obj.y
```

This package is inspired by [AutoHashEquals.jl](https://github.com/andrewcooke/AutoHashEquals.jl).
