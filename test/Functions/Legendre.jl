module LegendreTests

using Test
using Afine.Functions

const x_samples = LinRange( -1.0, 1.0, 150 )

const ε = 1E-14

const eval_func( func, i ) = [ func( x, i ) for x in x_samples ]

# Test Legendre polynomials
const P0( x ) = ones( size( x ) ) .* 1.0
const P1( x ) = x
const P2( x ) = 0.5 .* ( 3.0 .* x.^2 .- 1.0 )
const P3( x ) = 0.5 .* ( 5.0 .* x.^3 .- 3.0 .* x )

@test all( broadcast( abs, P0( x_samples ) - eval_func( legendre, 0 ) ) .< ε )
@test all( broadcast( abs, P1( x_samples ) - eval_func( legendre, 1 ) ) .< ε )
@test all( broadcast( abs, P2( x_samples ) - eval_func( legendre, 2 ) ) .< ε )
@test all( broadcast( abs, P3( x_samples ) - eval_func( legendre, 3 ) ) .< ε )

# Test derivatives of Legendre polynomials
const dP0( x ) = zeros( size( x ) )
const dP1( x ) = ones( size( x ) )
const dP2( x ) = 3.0 .* x
const dP3( x ) = 0.5 .* ( 15.0 .* x.^2 .- 3.0 )

@test all( broadcast( abs, dP0( x_samples ) - eval_func( legendre_derivative, 0 ) ) .< ε )
@test all( broadcast( abs, dP1( x_samples ) - eval_func( legendre_derivative, 1 ) ) .< ε )
@test all( broadcast( abs, dP2( x_samples ) - eval_func( legendre_derivative, 2 ) ) .< ε )
@test all( broadcast( abs, dP3( x_samples ) - eval_func( legendre_derivative, 3 ) ) .< ε )

end # module
