module AfineRunTests

using Test

@time @testset "Ansatz" begin include( "Ansatz/runtests.jl" ) end
@time @testset "Functions" begin include( "Functions/runtests.jl" ) end
@time @testset "Geometries" begin include( "Geometries/runtests.jl" ) end

end # module
