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


function is_inside( x::Vector{ Float64 },
										bounding_box::BoundingBox )::Bool
	for i = 1 : bounding_box.dimension

		if bounding_box.length[ i ] == 0.0
			return false
		end # if

		if abs( x[ i ] - bounding_box.centroid[ i ] ) > bounding_box.length[ i ]
			return false
		end # if

	end # for

	return true
end # function


function translate_coordinate( x::Vector{ Float64 },
															 source_box::BoundingBox,
															 target_box::BoundingBox )::Vector{ Float64 }
	return ( ( x - source_box.centroid ) ./ source_box.length ) .* target_box.length .+ target_box.centroid
end # function
