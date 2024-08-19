module BoundingBoxTests

using Test
using Afine.Geometries

# setting up some variables for testing
const source_box::BoundingBox = BoundingBox( 2, 0, [  0.0,  0.0 ], [ 2.0, 2.0 ] ) 
const target_box::BoundingBox = BoundingBox( 2, 0, [ -2.0,  1.5 ], [ 2.0, 1.0 ] ) 

const source_point::Vector{ Float64 } = [ -0.5,  0.0 ]
const target_point::Vector{ Float64 } = [ -2.5,  1.5 ]

# is_inside tests
@test is_inside( [ -0.3, 0.4 ], source_box )
@test !is_inside( [ 1.3, 0.4 ], source_box )
@test is_inside( [ 1.3, 0.4 ], source_box, ε = 1.0 )

# translate_coordinate tests
@test translate_coordinate( source_point, source_box, target_box ) == target_point
@test translate_coordinate( target_point, target_box, source_box ) == source_point

# split tests
const splits = split_bounding_box( source_box, [ 2, 4 ] )
const Δ_length = [ 1.0, 0.5 ]
const centroids = [ -0.5 -0.75; 0.5 -0.75; -0.5 -0.25; 0.5 -0.25; -0.5 0.25; 0.5 0.25; -0.5 0.75; 0.5 0.75 ]

for i in eachindex( splits )
	split = splits[ i ]
	@test all( split.length .== Δ_length )
	@test all( split.centroid .== centroids[ i, : ] )
end # for

# volume functions tests
@test volume( source_box ) == 4
@test volume( target_box ) == 2

# unit_bounding_box tests
const unit_box_2d::BoundingBox = unit_bounding_box( 2 )
const unit_box_4d::BoundingBox = unit_bounding_box( 4 )

@test unit_box_2d.dimension == 2 && all( unit_box_2d.centroid .== 0.0 ) && all( unit_box_2d.length .== 2.0 )
@test unit_box_4d.dimension == 4 && all( unit_box_4d.centroid .== 0.0 ) && all( unit_box_4d.length .== 2.0 )

end # module
