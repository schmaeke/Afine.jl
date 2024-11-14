module Quadrature

include( "QuadraturePoint.jl" )
export QuadraturePoint
export map_quadrature_points_to_bounding_box, tensor_product_points_from_1d

include( "GaussLegendre.jl" )
export compute_gauss_legendre_points

end # module
