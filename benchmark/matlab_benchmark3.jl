push!(LOAD_PATH, "./src")
push!(LOAD_PATH, "./data")
using MatlabBenchmark
using SpecialFunctions

tSpan = [0, 2]     # [intial time, final time]
y0 = 0             # intial value
β = 0.5            # order of the derivative
par = β
function F(t,y,β)
    if t > 1
        dy= 1/gamma(2-β)* t ^(1-β) - 2/gamma(3-β) *(t-1) ^(2-β)
    else
        dy= 1/gamma(2-β)*t^(1-β)
    end
    return dy
end
# Jacobian
JF(t, y, β) = t

function Exact(t)
    if t > 1
        y= t .-(t .-1).^2
        else
        y= t
    end
    return y
end

# benchmark FDEsolver for different step size values
benchmark(MatlabBenchmark.Mdata3, F, JF, Exact, tSpan, y0, β, par, H)
