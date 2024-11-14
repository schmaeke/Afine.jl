abstract type SpatialMapping end

function J( Q::SpatialMapping, ξ::Vector{ Float64 }, i::Int64, j::Int64 )::Float64
	error( "Function not implented for given mapping type" )
end # function


function J( Q::SpatialMapping, ξ::Vector{ Float64 } )::Matrix{ Float64 }

	mat::Matrix{ Float64 } = zeros( 3, 3 )

	for i in 1:3
		for j in 1:3

			mat[ i, j ] = J( Q, ξ, i, j )

		end # for
	end # for

end # function
