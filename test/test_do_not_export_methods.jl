using AutoAccessorMethods
using Test

module Mod1
    export U

    using AutoAccessorMethods

    @auto_accessor_methods struct U
        U_1
    end false
end

using .Mod1

u = U(1//2)

@test_throws UndefVarError U_1(u)
@test Mod1.U_1(u::U) == 1//2

using .Mod1: U_1

@test U_1(u::U) == 1//2
