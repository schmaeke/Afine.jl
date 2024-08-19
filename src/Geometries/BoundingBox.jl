"A bounding box represented by a center coordinate and its edge lengths."
struct BoundingBox

	"Number of dimensions."
	dimension::Int64

	"Corresponds to the number of dimension with length > 0"
	codimension::Int64

	"Center coordiante of the box."
	centroid::Vector{ Float64 }

	"Lengths in each direction of the box."
	length::Vector{ Float64 }

end # struct


"""
	is_inside( x, bounding_box; ε )

Checks if a coordinate 'x' is localted inside the bounding box. ε is a scalar valued tolerance, which is added on top of the bounding box dimensions on each side.
"""
function is_inside( x::Vector{ Float64 },
										bounding_box::BoundingBox;
										ε::Float64 = 0.0 )::Bool

	return all( broadcast( abs, x - bounding_box.centroid ) .<= 0.5 .* bounding_box.length .+ ε )

end # function


"""
	upper_bound( bounding_box, extreme_directions )

Generates a bounding box which has a length of zero and the upper bound centroid at the given dimensions
"""
function lower_bound( bounding_box::BoundingBox,
											extreme_directions::Array{ Int64 } )::BoundingBox

	centroid = copy( bounding_box.centroid )
	length = copy( bounding_box.length )

	for i in extreme_directions
		centroid[ i ] += 0.5 * length[ i ]
		length[ i ] = 0.0
	end # for

	return BoundingBox( bounding_box.dimension, bounding_box.dimension - length( extreme_directions ), centroid, length )

end # function


"""
	non_zero_directions( bounding_box )

Creates an array with the index of every bounding box direction with length > 0.0.
"""
function non_zero_directions( bounding_box::BoundingBox )::Array{ Int64 }

	return [ i for i = 1 : bounding_box.dimension if bounding_box.length[ i ] > 0.0 ]

end # function


"""
	split( bounding_box, number_of_splits )

Splits a given bounding box according to passed number of desired splits. The result is an array with the shape of 'number_of_splits'.
"""
function split_bounding_box( bounding_box::BoundingBox,
														 number_of_splits::Array{ Int64, 1 } )::Array{ BoundingBox }

	# TODO: Split only along non-zero directions
	Δ_length::Vector{ Float64 } = bounding_box.length ./ number_of_splits
	lower_centroid = bounding_box.centroid - 0.5 .* ( bounding_box.length - Δ_length )
	splits::Array{ BoundingBox } = Array{ BoundingBox }( undef, Tuple( number_of_splits ) )

	for cart_i in CartesianIndices( splits )
		position_offset = [ Float64( cart_i[ i ] ) for i = 1  : length( cart_i ) ] 
		splits[ cart_i ] = BoundingBox( bounding_box.dimension, bounding_box.codimension, lower_centroid .+ ( position_offset .- 1 ) .* Δ_length, Δ_length )
	end # for

	return splits

end # function


"""
	translate_coordinate( x, source_box, target_box )

Translates a coordinate 'x' located inside the source_box and maps it to the target_box.
"""
function translate_coordinate( x::Vector{ Float64 },
															 source_box::BoundingBox,
															 target_box::BoundingBox )::Vector{ Float64 }

	return ( ( x - source_box.centroid ) ./ source_box.length ) .* target_box.length .+ target_box.centroid

end # function


"""
	unit_bounding_box( dimension )

Creates a bounding box of 'dimension' with a centroid at the origin and all edges of length 2.
"""
function unit_bounding_box( dimension::Int64 )::BoundingBox

	return BoundingBox( dimension, dimension, zeros( dimension ), 2.0 .* ones( dimension ) )

end # function


"""
	upper_bound( bounding_box, extreme_directions )

Generates a bounding box which has a length of zero and the lower bound centroid at the given dimensions
"""
function upper_bound( bounding_box::BoundingBox,
											extreme_directions::Array{ Int64 } )::BoundingBox

	centroid = copy( bounding_box.centroid )
	length = copy( bounding_box.length )

	for i in extreme_directions
		centroid[ i ] -= 0.5 * length[ i ]
		length[ i ] = 0.0
	end # for

	return BoundingBox( bounding_box.dimension, bounding_box.dimension - length( extreme_directions ), centroid, length )

end # function


"""
	volume( bounding_box )

A method for computing the volume of a given bounding box. Note, that box dimensions > 0 are respected.
"""
function volume( bounding_box::BoundingBox )::Float64

	return prod( bounding_box.length[ non_zero_directions( bounding_box ) ] )

end # function
