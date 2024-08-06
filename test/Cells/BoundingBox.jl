module BoundingBoxTests

using Test
using Feris.Cells

source_box::BoundingBox = BoundingBox( 2, [  0.0,  0.0 ], [ 2.0, 2.0 ] ) 
target_box::BoundingBox = BoundingBox( 2, [ -2.0,  1.5 ], [ 2.0, 1.0 ] ) 

source_point::Vector{ Float64 } = [ -0.5,  0.0 ]
target_point::Vector{ Float64 } = [ -2.5,  1.5 ]

@test volume( source_box ) == 4
@test volume( target_box ) == 2

@test translate_coordinate( source_point, source_box, target_box ) == target_point
@test translate_coordinate( target_point, target_box, source_box ) == source_point

end # module
