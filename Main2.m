%% >> Relative Location
% Build differential-arrival observations
EvePair=LOC_GenDiffTime(data);
% Check differential predictions using the true model
Timetrue=LOC_PredDiffTime(Modeltrue,data,EvePair);
MSE=mean((Timetrue-EvePair.diffTime).^2);
fprintf("# Differential-arrival MSE: %.4f\n",MSE);


%% Differential-arrival inversion
% Both station clock bias and station-phase random bias are canceled out
IniDiffParam=LOC_IniDiffModel(param.Neve,param.nDim);
IniDiffModel=LOC_UnpackDiffModel(IniDiffParam,param.Neve,param.nDim);
% IniDiffTime=LOC_PredDiffTime(IniDiffModel,data,EvePair);
% IniDiffMSE=mean((IniDiffTime-EvePair.diffTime).^2);
% fprintf("# Initial differential-arrival MSE: %.4f\n",IniDiffMSE);


Handle2=@(x0) LOC_GenDiffHandle(x0,data,EvePair,param.huberDelta,param.nDim);
[x2,loss2]=LOC_Optimizer(Handle2,IniDiffParam,param.maxIter);
NewDiffModel=LOC_UnpackDiffModel(x2,param.Neve,param.nDim);
NewDiffTime=LOC_PredDiffTime(NewDiffModel,data,EvePair);
NewDiffMSE=mean((NewDiffTime-EvePair.diffTime).^2);
fprintf("Optimized differential-arrival MSE: %.4f\n",NewDiffMSE);
% Plots
LOC_PlotDiffLocation(data,NewDiffModel,param);