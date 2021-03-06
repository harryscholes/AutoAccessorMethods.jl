module AutoAccessorMethods

export @auto_accessor_methods

using MacroTools
using MacroTools: postwalk

"""
    @auto_accessor_methods typ [ex=true]

Automatically define accessor methods for fields of a type `typ`. Disable accessor methods
from being exported by setting `ex = false`.

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

Examples:

```jldoctest
julia> using AutoAccessorMethods

julia> @auto_accessor_methods struct MyType
           first_field
           second_field
       end

julia> first_field
first_field (generic function with 1 method)

julia> second_field
second_field (generic function with 1 method)

julia> mt = MyType("Hello", "Goodbye");

julia> first_field(mt)
"Hello"

julia> second_field(mt)
"Goodbye"

```

```jldoctest
julia> using AutoAccessorMethods

julia> @auto_accessor_methods struct MyType{T}
           first_field::T
           second_field::Tuple{T,T}
       end

julia> mt = MyType(1, (2, 3));

julia> first_field(mt)
1

julia> second_field(mt)
(2, 3)

```
"""
macro auto_accessor_methods(expr, ex=true)
    postwalk(expr) do expr
        # Capture the type definition
        @capture(expr, (struct T_{__} fields__ end) | (struct T_ fields__ end)) || return expr

        # Fields
        length(fields) > 0 ||
            throw(ArgumentError("`$T` has no fields"))

        field_names = map(fields) do field
            @capture(field, var_::__) || @capture(field, var_)
            var
        end

        # Accessor methods
        accessors = Expr[]
        for fn in field_names
            push!(
                accessors,
                :($(esc(fn))(x::$(esc(T))) = getfield(x, Symbol($(esc(fn))))),
            )

            if ex
                push!(
                    accessors,
                    :(export $(esc(fn)))
                )
            end
        end

        return quote
            $(esc(expr))
            $(accessors...)
        end
    end
end

# Trival macro to test nested macro invocations
# TODO get this to work when defined in `test/runtests.jl`
macro noop(expr)
    esc(expr)
end

end # module
