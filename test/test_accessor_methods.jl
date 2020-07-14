using AutoAccessorMethods
using Test

@auto_accessor_methods struct T
    T_1
    T_2
end

@test hasmethod(T_1, Tuple{T})
@test hasmethod(T_2, Tuple{T})
@test_throws UndefVarError hasmethod(T_3, Tuple{T})

t = T(1, 2)
@test T_1(t::T) == 1
@test T_2(t::T) == 2

t = T(1.0, 2.0)
@test T_1(t::T) == 1.0
@test T_2(t::T) == 2.0

@auto_accessor_methods @noop @noop @noop @noop struct T1
    T1_1
    T1_2
end

t = T1(3, 4.0)
@test T1_1(t::T1) == 3
@test T1_2(t::T1) == 4.0


@auto_accessor_methods struct W{T1, T2}
    W_1::T1
    W_2::T2
    W_3::Tuple{T1,T2}
end

w = W{Int64,Float64}(10, 100.0, (2, 3.0))
@test W_1(w::W) == 10
@test W_2(w::W) == 100.0
@test W_3(w::W) == (2, 3.0)
@test W_1(w::W) isa Int64
@test W_2(w::W) isa Float64
@test W_3(w::W) isa Tuple{Int64, Float64}

# @auto_accessor_methods struct X1
#     X1_1
# end alias=Dict(:X1_1 => :X1_2)
#
# @test hasmethod(X1_1, Tuple{X1})
# @test hasmethod(X1_2, Tuple{X1})
#
# @auto_accessor_methods struct X2
#     X2_1
# end alias=Dict(:X2_1 => [:X2_2, :X2_3])
#
# @test hasmethod(X2_1, Tuple{X2})
# @test hasmethod(X2_2, Tuple{X2})
# @test hasmethod(X2_3, Tuple{X2})
