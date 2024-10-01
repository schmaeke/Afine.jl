module PolynomialTests

using Test
using Afine.Ansatz

const polynomial::Polynomial = construct_polynomial( [ 3.0, -4.5, 3.0 ], 2 )

const ε = 1E-15

const f( x ) = 3.0 .* x.^2 .- 4.5 .* x .+ 3.0
const dfdx( x ) = 6.0 .* x .- 4.5
const df2dx2( x ) = 6.0 .* ones( length( x ) )

const x_samples = [ x for x in -10:0.25:10 ]

@test all( broadcast( abs, f( x_samples ) - evaluate( polynomial, x_samples ) ) .< ε )
@test all( broadcast( abs, dfdx( x_samples ) - evaluate( polynomial, x_samples; order = 1 ) ) .< ε )
@test all( broadcast( abs, df2dx2( x_samples ) - evaluate( polynomial, x_samples; order = 2 ) ) .< ε )

end # module
