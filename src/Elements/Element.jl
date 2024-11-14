import Afine.Ansatz.Interpolation
import Afine.DiscreteGeometries.HyperCube


struct Element

	"Domain of the element."
	domain::HyperCube

	"Interpolation of the element."
	interpolation::Interpolation

end # struct


function interpolate_element_solution( element::Element,
																			 ξ::Vector{ Float64 },
																			 U::Matrix{ Float64 } )::Vector{ Float64 }

	shape_function_values = evaluate_interpolation_shape_functions( element.interpolation, ξ )
	return transpose( U ) * shape_function_values

end
