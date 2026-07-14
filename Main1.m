% Synthetic earthquake location:
% XA.,Yu 2026
% 1-1. Generate absolute-arrival observations
% 1-2. Invert absolute arrival times
% 2-1. Generate differential-arrival observations
% 2-2. Invert differential arrival times
clc;clear;

%% >> Define synthetic model
rng(2025);
param.vp=6.0;     % Unit: Km/s
param.vs=param.vp/1.73;
param.Nsta=10;     % Station Nums (>5)
param.Neve=30;    % Event Nums
param.Domain=30; % Unit: Km
param.nDim=2;     % Location 2D
param.maxIter=500;
param.huberDelta=1.0;
param.reg=0.001;

data=LOC_GenData(param);

%% >> Check the prediction using the known model
Modeltrue.Xeve=data.Xeve;
Modeltrue.Teve=data.Teve;
Modeltrue.Dtsta=data.Dtsta;
Timetrue=LOC_PredAbsTime(Modeltrue,data);
MSE=mean((Timetrue-data.obs.Tpha).^2);
fprintf("# Absolute-arrival MSE: %.4f\n",MSE);
% (Note: This is not zero because phase-dependent random pick bias is not inverted)


%% >> Absolute Location
% The quantities to be inverted include event location, time, and station correction terms
IniAbsParam=LOC_IniAbsModel(param.Neve,param.Nsta,param.nDim);
IniAbsModel=LOC_UnpackAbsModel(IniAbsParam,param.Neve,param.Nsta,param.nDim);
% IniAbsTime=LOC_PredAbsTime(IniAbsModel,data);
% IniAbsMSE=mean((IniAbsTime-data.obs.Tpha).^2);
% fprintf("# Initial Time MSE: %.4f\n",IniAbsMSE);


Handle1=@(x0) LOC_GenAbsHandle(x0,data,param.reg,param.huberDelta,param.nDim);
[x1,loss1]=LOC_Optimizer(Handle1,IniAbsParam,param.maxIter);
NewAbsModel=LOC_UnpackAbsModel(x1,param.Neve,param.Nsta,param.nDim);
NewAbsTime=LOC_PredAbsTime(NewAbsModel,data);
NewAbsMSE=mean((NewAbsTime-data.obs.Tpha).^2);
fprintf("# Optimized-arrival MSE: %.4f\n",NewAbsMSE);
% Plots
LOC_PlotAbsLoc(data,NewAbsModel,param);

