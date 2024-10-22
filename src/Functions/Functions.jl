module Functions

include( "Legendre.jl" )
export legendre, legendre_derivative, legendre_integrated, legendre_norm

include( "BSplines.jl" )
export total_number_of_basis_functions, find_span, evaluate_bspline_basis

include( "NURBS.jl" )

end # module
