import Afine.DiscreteGeometries.Domain
import Afine.DiscreteGeometries.HyperCube


"Definition of a finite element field."
mutable struct Field

	"Number of components of the field."
	variance::Int64

	"Domain of the field (usually denoted as Ω)."
	domain::Domain

	"Arrays of degrees of freedom for each hyper cube in the domain."
	degrees_of_freedom::Dict{ HyperCube, Array{ DegreeOfFreedom } }

	"All elements of this field."
	elements::Array{ Element }

end # struct
