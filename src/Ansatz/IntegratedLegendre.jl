import Afine.Ansatz.Polynomial

struct IntegratedLegendreBasis <: Interpolation

	polynomial::Array{ Polynomial, 1 }

end
