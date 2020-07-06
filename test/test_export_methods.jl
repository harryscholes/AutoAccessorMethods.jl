using AutoAccessorMethods
using Test

module Mod2
    export V

    using AutoAccessorMethods

    @auto_accessor_methods struct V
        V_1
    end true
end

using .Mod2

v = V(1//2)

@test V_1(v::V) == 1//2
