module AxisAlignedMapping


	using Geometries


	"""
		Mapping struct for translation of coordiantes between two bounding boxes.
	"""
	struct BoundingBoxMapping <: SpatialMapping
		"Reference domain from which is mapped from"
		Ω_source::BoundingBox
		"Global domain to which is mapped to"
		Ω_target::BoundingBox
	end # struct


	function x( Q::BoundingBoxMapping, ξ::Vector{ Float64 } )::Vector{ Float64 }
		return translate_coordinate( ξ, Q.Ω_source, Q.Ω_target )
	end # function


	function ξ( Q::BoundingBoxMapping, x::Vector{ Float64 } )::Vector{ Float64 }
		return translate_coordinate( x, Q.Ω_target, Q.Ω_source )
	end


	function J( Q::BoundingBoxMapping, ξ::Vector{ Float64 }, i::Int64, j::Int64 )::Float64
		if i != j return 0.0 end # if
		return Q.Ω_target.length[ i ] / Q.Ω_source.length[ j ]
	end # function


end # module
