using Plots


function helper( x::Float64, i::Int64 )::Tuple{ Float64, Float64, Float64 }
	a = 1.0
	b = x
	c = 0.0

	for j in 2:i
		c = ( ( 2.0 * j - 1.0 ) * x * b + ( 1.0 - j ) * a ) / j
		a = b
		b = c
	end

	return ( a, b, c )
end


function legendre( x::Float64, i::Int64 )::Float64
	i == 0 && return 1.0
	i == 1 && return x
	return helper( x, i )[ 3 ]
end


function legendre_derivative( x::Float64, i::Int64 )::Float64
	i == 0 && return 0.0
	i == 1 && return 1.0
	abs( x ) == 1.0 && return 0.5 * i * ( i + 1.0 ) * ( i % 2 == 0 ? sign( x ) : 1.0 )
	( a, b, _ ) = helper( x, i )
	return ( i * ( a - x * b ) ) / ( 1.0 - x * x )
end



function legendre( x::Array{ Float64 }, i::Int64 )::Array{ Float64 }
	values::Array{ Float64 } = zeros( size( x ) )
	for j in eachindex( x )
		values[ j ] = legendre_derivative( x[ j ], i )
	end
	return values
end


n = 1000
x_samples = [ x for x in -1:( 2.0 / n ):1 ]
@time y_samples = legendre( x_samples, 1 )

plt = plot( x_samples, y_samples )

for i = 2:10
	@time y_samples2 = legendre( x_samples, i )
	plot!( x_samples, y_samples2 )
end

display( plt )
