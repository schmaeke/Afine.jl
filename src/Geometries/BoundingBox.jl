"A bounding box represented by a center coordinate and its edge lengths."
struct BoundingBox

	"Number of dimensions."
	dimension::Int64

	"Center coordiante of the box."
	centroid::Vector{ Float64 }

	"Lengths in each direction of the box."
	length::Vector{ Float64 }

end # struct


"""
	volume( bounding_box )

A method for computing the volume of a given bounding box.
"""
function volume( bounding_box::BoundingBox )::Float64
	return prod( bounding_box.length )
end # function


"""
	is_inside( x, bounding_box; ε )

Checks if a coordinate 'x' is localted inside the bounding box. ε is a scalar valued tolerance, which is added on top of the bounding box dimension.
"""
function is_inside( x::Vector{ Float64 },
										bounding_box::BoundingBox;
										ε::Float64 = 0.0 )::Bool
	return all( broadcast( abs, x - bounding_box.centroid ) .<= 0.5 .* bounding_box.length .+ ε )
end # function


"""
	split( bounding_box, number_of_splits )

Splits a given bounding box according to passed number of desired splits. The result is an array with the shape of 'number_of_splits'.
"""
function split_bounding_box( bounding_box::BoundingBox,
														 number_of_splits::Array{ Int64, 1 } )::Array{ BoundingBox }
	Δ_length::Vector{ Float64 } = bounding_box.length ./ number_of_splits
	lower_centroid = bounding_box.centroid - 0.5 .* ( bounding_box.length - Δ_length )
	splits::Array{ BoundingBox } = Array{ BoundingBox }( undef, Tuple( number_of_splits ) )

	for cart_i in CartesianIndices( splits )
		pos = [ Float64( cart_i[ i ] ) for i = 1  : length( cart_i ) ] 
		splits[ cart_i ] = BoundingBox( bounding_box.dimension, lower_centroid .+ ( pos .- 1 ) .* Δ_length, Δ_length )
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

Creates a bounding box with 'dimension' with a centroid at the origin and all edges of length 2.
"""
function unit_bounding_box( dimension::Int64 )
	return BoundingBox( dimension, zeros( dimension ), 2.0 .* ones( dimension ) )
end # function
