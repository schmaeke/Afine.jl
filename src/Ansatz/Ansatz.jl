module Ansatz

include( "Polynomial.jl" )
export Polynomial
export construct_polynomial, evaluate

include( "ShapeFunction.jl" )
export ShapeFunction

end # module
