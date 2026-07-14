function x0=LOC_IniAbsModel(Neve,Nsta,nDim)
% Create initial model:
Xeve0=randn(Neve,nDim);
Teve0=randn(Neve,1);
Dtsta0=zeros(Nsta,1);
x0=[Xeve0(:);Teve0;Dtsta0];
end