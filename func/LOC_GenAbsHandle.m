function [loss,gradient]=LOC_GenAbsHandle(x,data,reg,huberDelta,nDim)
% Objective function for absolute-arrival inversion
%
% loss=mean(weight*Huber(predicted-observed))+reg*mean(abs(Dtsta))
Neve=data.Neve;
Nsta=data.Nsta;
model=LOC_UnpackAbsModel(x,Neve,Nsta,nDim);
predTime=LOC_PredAbsTime(model,data);

residual=predTime-data.obs.Tpha;
weight=data.obs.Wpha;
loss=mean(weight.*LOC_HuberLoss(residual,huberDelta));
loss=loss+reg*mean(abs(model.Dtsta));
if nargout<2
    return;
end
% Gradient calculation for fminunc.
% dLoss/dPred is first obtained,then mapped to every model parameter.
gradResidual=weight.*LOC_HuberDerivative(residual,huberDelta)/numel(residual);

IDeve=data.obs.IDeve;
IDsta=data.obs.IDsta;

eventPos=model.Xeve(IDeve,:);
stationPos=data.Xsta(IDsta,:);

distance=sqrt(sum((eventPos-stationPos).^2,2));
safeDistance=max(distance,eps);

velocity=LOC_PhaseVelocity(data.obs.IDpha,data.vp,data.vs);
unitVector=(eventPos-stationPos)./safeDistance;

XeveGrad=zeros(Neve,nDim);

for dimId=1:nDim
    localGrad=gradResidual.*unitVector(:,dimId)./velocity;
    XeveGrad(:,dimId)=accumarray(IDeve,localGrad,[Neve,1],@sum,0);
end
TeveGrad=accumarray(IDeve,gradResidual,[Neve,1],@sum,0);
DtstaGrad=accumarray(IDsta,gradResidual,[Nsta,1],@sum,0);
% L1 regularization suppresses the trade-off between Dtsta and Teve.
DtstaGrad=DtstaGrad+reg*sign(model.Dtsta)/Nsta;
gradient=[XeveGrad(:);TeveGrad;DtstaGrad];
end