using Afine.Geometries


"Quadrature point data type"
struct QuadraturePoint

	"A global quadrature point index. Can be used e.g. in the context of assigning history variables."
	index::Int64

	"Coordinate of the quadrature point."
	ξ::Vector{ Float64 }

	"Weight of the quadrature points."
	w::Float64

end # struct


"""
	map_quadrature_points_to_bounding_box( quadrature_points, target_box; source_box, mapping )

Maps a given set of quadrature points on a target bounding box with optional mapping.
"""
function map_quadrature_points_to_bounding_box( quadrature_points::Array{ QuadraturePoint },
																								target_box::BoundingBox;
																								source_box::BoundingBox = unit_bounding_box( target_box.dimension ) )::Array{ QuadraturePoint } # TODO: Encorperating the mapping in this method would be nice

	weight_scaling = volume( source_box ) / volume( target_box )
	mapped_quadrature_points = Array{ QuadraturePoint }( undef, size( quadrature_points ) )

	for i in eachindex( quadrature_points )
		source_point = quadrature_points[ i ]
		mapped_quadrature_points[ i ] = QuadraturePoint( source_point.index, translate_coordinate( source_point.ξ, source_box, target_box ), source_point.w * weight_scaling )
	end # for

	return mapped_quadrature_points

end # function


"""
	tensor_product_points_from_1d( Ω, ξ, w )

Generates higher dimensional quadrature points by taking the tensor product of 1d quadrature points.
"""
function tensor_product_points_from_1d( Ω::BoundingBox,
																				ξ::Array{ Array{ Float64 } },
																				w::Array{ Array{ Float64 } } )::Array{ QuadraturePoint }
	directions = non_zero_directions( Ω )

	if length( directions ) != length( ξ ) || length( directions ) != length( w )
		error( "There number of provided 1D quadratures does not match the dimension of the domain" )
	end # if

	for i in eachindex( directions )
		
	end # for
	
end # function
