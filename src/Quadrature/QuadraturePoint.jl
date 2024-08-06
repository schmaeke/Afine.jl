"Quadrature point data type"
struct QuadraturePoint

	"A global quadrature point index. Can be used e.g. in the context of assigning history variables."
	index::Int64

	"Coordinate of the quadrature point."
	ξ::Vector{ Float64 }

	"Weight of the quadrature points."
	w::Float64

end # struct
