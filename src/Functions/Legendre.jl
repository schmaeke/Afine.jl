"""
	legendre_helper( x, i )

Computes the values of three consecutive Legendre polynomials P_(i - 2), P_(i - 1) and P_i.

x is the location of evaluation.
i is the desired degree, which must be > 1>
"""
function legendre_helper( x::Float64,
													i::Int64 )::Tuple{ Float64, Float64, Float64 }
	a = 1.0
	b = x
	c = 0.0

	# Use the recusrive definition of the Legendre polynomial.
	for j in 2:i
		c = ( ( 2.0 * j - 1.0 ) * x * b + ( 1.0 - j ) * a ) / j
		a = b
		b = c
	end # for

	return ( a, b, c )
end # function


"""
	legendre( x, i )

Evaluates the i-th Legendre polynomial.

x is the location of evaluation.
i is the desired degree.
"""
function legendre( x::Float64,
									 i::Int64 )::Float64
	# The first two degrees are hard-coded.
	i == 0 && return 1.0
	i == 1 && return x
	return legendre_helper( x, i )[ 3 ]
end # function


"""
	legendre_derivative( x, i )

Evaluates the derivative of the i-th Legendre polynomial.

x is the location of evaluation.
i is the desired degree.
"""
function legendre_derivative( x::Float64,
															i::Int64 )::Float64
	# Thre first two degrees are hard-coded
	i == 0 && return 0.0
	i == 1 && return 1.0

	# The used expression of the derivative becomes singular at the boundaries.
	# Therefore, they are treated seperatly.
	abs( x ) == 1.0 && return 0.5 * i * ( i + 1.0 ) * ( i % 2 == 0 ? sign( x ) : 1.0 )

	( a, b, _ ) = legendre_helper( x, i )
	return ( i * ( a - x * b ) ) / ( 1.0 - x * x )
end  # function
