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
