# The algorithms for computing Gauss-Legendre points on the fly are taken from:
# - https://people.math.sc.edu/Burkardt/m_src/quadrule/quadrule.html
# - https://people.math.sc.edu/Burkardt/m_src/quadrule/legendre_ss_recur.m
# - https://people.math.sc.edu/Burkardt/m_src/quadrule/legendre_ss_root.m
# - https://people.math.sc.edu/Burkardt/m_src/quadrule/legendre_ss_compute.m

using Afine.Functions


"""
	legendre_ss_recur( x, size, c )

Computes the value of the non-normalized Legendre polynomial.
The function return this value if Pi( x ), P'i( x ) and Pi-1( x ).

x is the location of evaluation.
i is the degree of the polynomial
c is an array containing the recursion coefficients.
"""
function legendre_ss_recur( x::Float64,
														i::Float64,
														c::Array{ Float64, 1} )::( Float64, Float64, Float64 )
  p1 = 1.0
  dp1 = 0.0
  p2 = x
  dp2 = 1.0

  for i in 2:i
    p0 = p1
    dp0 = dp1
    p1 = p2
    dp1 = dp2
		p2 = x * p1 - c[ i ] * p0
		dp2 = x * dp1 + p1 - c[ i ] * dp0
  end # for

	return ( p2, dp2, p1 )
end # function


"""
	legendre_ss_root( x, i, c; max_iter, ε )


"""
function legendre_ss_root( x::Float64,
													 size::Int64,
													 c::Array{ Float64, 1 };
													 max_iter::Int64 = 10,
													 ε::Float64 = 1E-15 )::( Float64, Float64, Float64 )
	p2 = 0.0
	dp2 = 0.0
	p1 = 0.0

  for _ = 1:max_iter
		( p2, dp2, p1 ) = legendre_ss_recur( x, size, c );
    d = p2 / dp2;
    x = x - d;

    if abs( d ) <= ε * ( abs( x ) + 1.0 )
      return;
    end # if
  end # for

	return ( x, dp2, p1 )
end # function



function compute_gauss_legendre_points( size::Int64 )::( Array{ Float64, 1 }, Array{ Float64, 1 } )

  coords = zeros( size )
  weights = zeros( size )
  c = zeros( size )

  for i in 1:size
		c[ i ] = ( ( i - 1.0 ) * ( i - 1.0 ) ) / ( ( 2.0 * i - 1.0 ) * ( 2.0 * i - 3.0 ) )
  end # for

	cc = 2.0 * prod( c[ 2:size ] )

  for i in 1:size
    if i == 1

      r = 2.78 / ( 4.0 + size^2 )
      xtemp = 1.0 - r

    elseif i == 2

      r = 1.0 + 0.06 * ( size - 8.0 ) / size
      xtemp = xtemp - 4.1 * r * ( 1.0 - xtemp )

    elseif i == 3

      r = 1.0 + 0.22 * ( size - 8.0 ) / size
			xtemp = xtemp - 1.67 * r * ( coords[ 1 ] - xtemp )

    elseif i < size - 1

			xtemp = 3.0 * coords[ i - 1 ] - 3.0 * coords[ i - 2 ] + coords[ i - 3 ]

    elseif i == size - 1

      r = 1.0 / ( 1.0 + 0.639 * ( size - 4 ) / ( 1.0 + 0.71 * ( size - 4 ) ) )
			xtemp = xtemp + r * ( xtemp - coords[ i - 2 ] ) / 0.766;

    elseif i == size

      r = 1.0 / ( 1.0 + 0.22 * real( size - 8.0 ) / size )
      xtemp = xtemp + r * ( xtemp - coords( i - 2 ) ) / 1.67

    end # if

		( xtemp, dp2, p1 ) = legendre_ss_root( xtemp, size, c )

		coords[ i ] = xtemp
		weights[ i ] = cc / dp2 / p1

  end # for

	reverse!( coords )
	reverse!( weights )

	return ( coords, weights )
end # function
