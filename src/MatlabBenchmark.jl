module MatlabBenchmark

using Plots                            # plot data on execution times
using SpecialFunctions, LinearAlgebra  # define differential equation
using BenchmarkTools, TimerOutputs     # benchmark julia solver
using CSV, DataFrames                  # read csv file into a DataFrame
using MittagLeffler                    # define exact solution
using FFTW                             # FDE solver dependency

# define array with multiple step size values
H = [2. ^(-i) for i in 2:8]

# include benchmark function
include("benchmark.jl")
include("main.jl")
include("main_Jacob.jl")
include("SupFuns.jl")
include("SupFuns_Jacob.jl")
include("dummy_fun.jl")

# extract data on execution time of MATLAB solver
Mdata1 = CSV.read("data/Bench1.csv", DataFrame, header = 0)
Mdata2 = CSV.read("data/Bench2.csv", DataFrame, header = 0)
Mdata3 = CSV.read("data/Bench3.csv", DataFrame, header = 0)
Mdata4 = CSV.read("data/Bench4.csv", DataFrame, header = 0)
Mdata5 = CSV.read("data/Bench5.csv", DataFrame, header = 0)
Mdata6 = CSV.read("data/Bench6.csv", DataFrame, header = 0)

# export H and benchmark
export(FDEsolver)
export(benchmark)
export(H)

end
