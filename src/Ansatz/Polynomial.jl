"Definition of a basic polynomial."
struct Polynomial

	"Degree of the polynomial."
	degree::Int64

	"Maximum derivtative available for this polynomial."
	maximum_derivative::Int64

	"Coefficients of the polynomial. First index is derivative order and second one are the individual coefficients."
	coefficients::Array{ Array{ Float64, 1 }, 1 }

end # struct


"""
	construct_polynomial( coefficients, maximum_derivative_needed )

Creates a new polynomial and computes corresponding derivatives from the initial coefficients.
"""
function construct_polynomial( coefficients::Array{ Float64 },
															 maximum_derivative_needed::Int64 )::Polynomial

	degree = length( coefficients ) - 1

	if  degree < maximum_derivative_needed
		@warn "Maximum derivative needed ($(maximum_derivative_needed)) is higher than polynomial degree ($(degree))!"
		maximum_derivative_needed = degree
	end # if

	full_coefficients = Array{ Array{ Float64, 1 }, 1 }( undef, maximum_derivative_needed + 1 )

	full_coefficients[ 1 ] = coefficients

	for i in 2:( maximum_derivative_needed + 1 )
		full_coefficients[ i ] = zeros( length( full_coefficients[ i - 1 ] ) - 1 )

		for j in 1:length( full_coefficients[ i ] )
			full_coefficients[ i ][ j ] = j * full_coefficients[ i - 1 ][ j + 1 ]
		end # for

	end # for

	return Polynomial( degree, maximum_derivative_needed, full_coefficients )
end # function


"""
	evaluate( polynomial, x; order )

Evaluates a polynomial at a given position x. The order parameter referes to the order of the derivative to use.
"""
function evaluate( polynomial::Polynomial,
									 x::Float64;
									 order::Int64 = 0 )::Float64

	if order > polynomial.degree
		@warn "Accessing derivatives ($(order)) beyond the degree of the polynomial ($(polynomial.degree))!"
		return 0.0
	end # if

	a = polynomial.coefficients[ order + 1 ]
	len = length( a )
	y = a[ len ]

	for i in ( len - 1 ):-1:1
		y = y * x + a[ i ]
	end # for

	return y
end # function


"""
	evaluate( polynomial, x; order )

Evaluates a polynomial at a given positions x. The order parameter referes to the order of the derivative to use.
"""
function evaluate( polynomial::Polynomial,
									 x::Array{ Float64 };
									 order::Int64 = 0 )::Array{ Float64 }

	y = zeros( size( x ) )

	for i in eachindex( x )
		y[ i ] = evaluate( polynomial, x[ i ]; order = order )
	end # for

	return y
end # function
