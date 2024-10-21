module Ansatz

include( "Interpolation.jl" )
export Interpolation

include( "Polynomial.jl" )
export Polynomial
export construct_polynomial, evaluate

include( "IntegratedLegendre.jl" )
export IntegratedLegendreBasis

end # module
