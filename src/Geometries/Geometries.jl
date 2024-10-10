module Geometries

include( "BoundingBox.jl" )
export BoundingBox
export is_inside, lower_bound, non_zero_directions, split_bounding_box, translate_coordinate, unit_bounding_box, upper_bound, volume

include( "HyperCube.jl" )
export HyperCube

include( "Domain.jl" )
export Domain

include( "SpatialMapping.jl" )
export SpatialMapping

# include( "AxisAlignedMapping.jl" )
# export BoundingBoxMapping

end # module
