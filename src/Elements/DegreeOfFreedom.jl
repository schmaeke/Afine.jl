import Afine.DiscreteGeometries.HyperCube


"Basic struct of a degree of freedom."
struct DegreeOfFreedom

	"Number of unknowns per degree of freedom."
	variance::Int64

	"True if the DoF is shared across elements."
	shared::Bool

	"Goemetry entity this DoF belongs to."
	topology::HyperCube

end # struct


"Struct of a single DoF constrain."
struct DoFConstrain

	"Number of constrained components."
	size::Int64

	"Inidcies of the constrained DoF components."
	indices::Array{ Int64, 1 }

	"Constrain values."
	values::Array{ Float64, 1 }

end # struct


"""
	constrain_dof!( dof, dof_constrains; component_indices, constrain_values )

Adds a new DoFConstrain to the given dof_constrains dict.
If no values for component_indices is provided, the function assumes, that all components should be constrained.
If no constrain values are provided, everything is set to zero.
"""
function constrain_dof!( dof::DegreeOfFreedom,
												 dof_constrains::Dict{ DegreeOfFreedom, DoFConstrain };
												 component_indices::Array{ Int64, 1 } = [ i for i in 1:dof.variance ],
												 constrain_values::Array{ Float64, 1 } = zeros( dof.variance ) )::DoFConstrain

	@assert length( component_indices ) == length( constrain_values )

	size = length( component_indices )
	constrain = DoFConstrain( size, component_indices, constrain_values )
	dof_constrains.constrains[ dof ] = constrain

	return constrain
end # function
