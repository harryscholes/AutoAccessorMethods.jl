using AutoAccessorMethods
using AutoAccessorMethods: @noop
using Test

@testset "AutoAccessorMethods.jl" begin
    @testset "Accessor methods" begin
        include("test_accessor_methods.jl")
    end

    @testset "Exports" begin
        @testset "Don't export" begin
            include("test_do_not_export_methods.jl")
        end
        @testset "Do export" begin
            include("test_export_methods.jl")
        end
    end
end
