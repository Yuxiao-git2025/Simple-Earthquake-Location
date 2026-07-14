function loss=LOC_ScalarObjective(objective,x)
% Convert a two-output objective function to a scalar function.

loss=objective(x);
end