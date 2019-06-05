# NCL Method

This package is an implementation of the NCL method, designed by Mike Saunders, Dominique Orban, Kenneth Judd and Ding Ma. Details can be found following the link : https://www.researchgate.net/publication/325480151_Stabilized_Optimization_Via_an_NCL_Algorithm.

The objective is to solve an optimisation problem, using IPOPT/KNITRO as subproblem solver.



## Functions

### NCLSolve

Their are two implementation of this function, one taking an AbstractNLPModel in argument, the other a NCLModel (created by NCLModel())