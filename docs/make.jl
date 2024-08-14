using Documenter
using Feris.Geometries

makedocs(
	sitename = "Feris.jl",
	format = Documenter.HTML(
		# prettyurls only when deploying documentation
		prettyurls = get( ENV, "CI", nothing ) == "true",

		# show sidebar since logo dose not contain the package name
		sidebar_sitename = true
	)
)
