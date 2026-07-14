function x0=LOC_IniDiffModel(Neve,nDim)
% Differential-time model has no Dtsta parameters.
Xeve0=randn(Neve,nDim);
Teve0=randn(Neve,1);
x0=[Xeve0(:);Teve0];
end