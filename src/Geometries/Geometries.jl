module Geometries

include( "BoundingBox.jl" )
export BoundingBox
export is_inside, translate_coordinate, split_bounding_box, unit_bounding_box, volume

include( "SpatialMapping.jl" )
export SpatialMapping

end # module
