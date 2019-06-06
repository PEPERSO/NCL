
using Test
using NLPModels
using CUTEst


probs = ["HS" * string(i) for i in 8:12]


include("test_NCLSolve.jl")
include("test_NCLModel.jl")

function test_main(test_NCLModel_command::Bool, test_NCLSolve_command::Bool, test_main_command::Bool) ::Test.DefaultTestSet
    test_NLCModel(test_NCLModel_command)

    test_NCLSolve(test_NCLSolve_command)
    
    if test_main_command
        ρ = 1.
        y = [2., 1.]

        f(x) = x[1] + x[2]
        x0 = [1, 0.5]
        lvar = [0., 0.]
        uvar = [1., 1.]

        lcon = [-0.5,
                -1.,
                -Inf,
                0.5]
        ucon = [Inf,
                2.,
                0.5,
                0.5]
        c(x) = [x[1] - x[2], # linear
                x[1]^2 + x[2], # non linear one, range constraint
                x[1] - x[2], # linear, lower bounded
                x[1] * x[2]] # equality one

        name_nlp = "Unitary test problem"
        nlp = ADNLPModel(f, x0; lvar=lvar, uvar=uvar, c=c, lcon=lcon, ucon=ucon, name=name_nlp)::ADNLPModel

        @testset "NCLSolve" begin
            for name in probs # several tests
                nlp = CUTEstModel(name)
                #println(nlp)
                test_name = name * " problem resolution"
                @testset "$test_name" begin
                    @test NCLSolve(nlp, max_iter_NCL = 30)[2]
                end
                finalize(nlp)
            end
        end

    else
        @testset "Avoid return type bug" begin
            @test true
        end
    end
end

test_main(true,true,true)
