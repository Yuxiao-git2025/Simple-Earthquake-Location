function [loss,gradient]=LOC_GenDiffHandle(x,data,pair,huberDelta,nDim)
% Objective function for differential-arrival inversion
%
% Dtsta is intentionally excluded because it is not observable in
% same-station,same-phase differential arrival data
Neve=data.Neve;
model=LOC_UnpackDiffModel(x,Neve,nDim);
predDiffTime=LOC_PredDiffTime(model,data,pair);
residual=predDiffTime-pair.diffTime;
weight=pair.weight;
loss=mean(weight.*LOC_HuberLoss(residual,huberDelta));
if nargout<2
    return;
end
gradResidual=weight.*LOC_HuberDerivative(residual,huberDelta)/numel(residual);

eventId1=pair.IDeve(:,1);
eventId2=pair.IDeve(:,2);

eventPos1=model.Xeve(eventId1,:);
eventPos2=model.Xeve(eventId2,:);
stationPos=data.Xsta(pair.IDsta,:);

distance1=sqrt(sum((eventPos1-stationPos).^2,2));
distance2=sqrt(sum((eventPos2-stationPos).^2,2));

safeDistance1=max(distance1,eps);
safeDistance2=max(distance2,eps);

velocity=LOC_PhaseVelocity(pair.IDpha,data.vp,data.vs);

unitVector1=(eventPos1-stationPos)./safeDistance1;
unitVector2=(eventPos2-stationPos)./safeDistance2;

XeveGrad=zeros(Neve,nDim);
for dimId=1:nDim
    grad1=gradResidual.*unitVector1(:,dimId)./velocity;
    grad2=-gradResidual.*unitVector2(:,dimId)./velocity;

    XeveGrad(:,dimId)=...
        accumarray(eventId1,grad1,[Neve,1],@sum,0)+...
        accumarray(eventId2,grad2,[Neve,1],@sum,0);
end
TeveGrad=...
    accumarray(eventId1,gradResidual,[Neve,1],@sum,0)+...
    accumarray(eventId2,-gradResidual,[Neve,1],@sum,0);
gradient=[XeveGrad(:);TeveGrad];
end