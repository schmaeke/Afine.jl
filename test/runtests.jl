module FerisRunTests

using Test

@time @testset "Geometries" begin include( "Geometries/runtests.jl" ) end

end # module
