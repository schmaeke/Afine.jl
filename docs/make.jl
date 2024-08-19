using Documenter
using Afine.Geometries

makedocs(
	sitename = "Afine.jl",
	format = Documenter.HTML(
		# prettyurls only when deploying documentation
		prettyurls = get( ENV, "CI", nothing ) == "true",

		# show sidebar since logo dose not contain the package name
		sidebar_sitename = true
	)
)

deploydocs(
	rep = "github.com/schmaeke/Afine.jl.git",
)
