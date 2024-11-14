struct Mesh

	"Number of topological dimension of this mesh"
	dimension::Int64

	"Codimension of this mesh (sptial dimesnion - dimension of this mesh)"
	codimension::Int64

	"Array of all hyper cubes of this mesh"
	cubes::Array{ HyperCube }

end # struct
