"Perpsective of one hyper cube on another hyper cube."
struct Perspective

	"Bounding box of this the hyper cube from this perspective."
	bounding_box::BoundingBox

	"Polarity of the orientation of the different dimensions from this perspective."
	orientation_polarity::Array{ Bool, 1 }

end # struct


"Definition of a hyper cube."
struct HyperCube

	"Spatial dimension of the hyper cube."
	dimension::Int64

	"Codimension of the hyper cube (global dimension - hyper cube dimension)."
	codimension::Int64

	"Mesh level this hypercube is located on."
	level::Int64

	"List of faces of the hyper cube."
	faces::Array{ HyperCube }

	"Dict of perspectives from other hyper cubes on this cube."
	perspectives::Dict{ HyperCube, Perspective }

	"Parent of this hyper cube."
	parent::HyperCube

	"Olverlays of this hyper cube."
	overlays::Array{ HyperCube }

end # struct
