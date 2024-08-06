module FerisRunTests

using Test

@time @testset "Cells" begin include( "Cells/runtests.jl" ) end

end # module
