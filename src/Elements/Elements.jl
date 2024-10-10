module Elements

include( "DegreeOfFreedom.jl" )
export DegreeOfFreedom, DoFConstrain
export constrain_dof!

include( "Element.jl" )
export Element

include( "Field.jl" )
export Field

end # module
