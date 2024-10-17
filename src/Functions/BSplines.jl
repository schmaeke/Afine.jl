# Most algorithms in this file are taken from "The NURBS Book" by Les Piegel and Wayne Tiller from 1997.


"""
	number_of_basis_functions( p, Ξ )

Computes the number of basis functions for the given arguments.

p is the BSpline basis order.
Ξ is the knot-vector.
"""
function total_number_of_basis_functions( p::Int64,
																					Ξ::Array{ Float64, 1 } )::Int64
	return length( Ξ ) - p - 1
end


"""
	find_span( ξ, p, Ξ )

Perform a binary search to find the span index for the given arguments.

ξ is the location for which to find the span index.
p is the BSpline basis order.
Ξ is the knot-vector.
"""
function find_span( ξ::Float64,
										p::Int64,
										Ξ::Array{ Float64, 1 } )::Int64
	n = total_number_of_basis_functions( p, Ξ )

	# If ξ is located on the upper bound of the knot vector.
	ξ == Ξ[ n ] && return n

	# Perform binary search ( faster than linear search ).
	lower = p + 1
	upper = n + 1
	center = ( lower + upper ) // 2

	while ξ < Ξ[ center ] || ξ >= Ξ[ center + 1 ]
		if ξ < Ξ[ center ]
			upper = center
		else
			lower = center
		end
		center = ( lower + upper ) // 2
	end

	return center
end


"""
	evaluate_bespline_basis( ξ, i, p, Ξ )

Evalutes alle non-zero BSpline basis functions with respect to the given arguments.

ξ is the location of evaluation.
i is the interval location with Ξ[ i ] <= ξ < Ξ[ i + 1 ].
p is the BSpline basis order.
Ξ is the knot-vector.
"""
function evaluate_bspline_basis( ξ::Float64,
																 i::Int64,
																 p::Int64,
																 Ξ::Array{ Float64, 1 } )::Array{ Float64, 1 }
	basis = zeros( p + 1 )
	left = zeros( p + 1 )
	right = zeros( p + 1 )

	basis[ 1 ] = 1.0

	for j in 2:(p + 1)
		left[ j ] = ξ - Ξ[ i - j + 1 ]
		right[ j ] = Ξ[ i + j ] - ξ
		saved = 0.0

		for r in 1:j
			temp = basis[ r ] / ( right[ r + 1 ] + left[ j - r - 1 ] )
			basis[ r ] = saved + right[ r + 1 ] * temp
			saved = left[ j - r - 1 ] * temp
		end

		basis[ j ] = saved
	end

	return basis
end
