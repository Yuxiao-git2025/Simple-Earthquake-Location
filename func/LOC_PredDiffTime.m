function predDiffTime=LOC_PredDiffTime(model,data,pair)
% Predict differential arrival time:
% DeltaT=(t01+TT1)-(t02+TT2)
%
% Dtsta is absent because it cancels in the time difference.

eventId1=pair.IDeve(:,1);
eventId2=pair.IDeve(:,2);

eventPos1=model.Xeve(eventId1,:);
eventPos2=model.Xeve(eventId2,:);
stationPos=data.Xsta(pair.IDsta,:);

tt1=LOC_CalcTravelTime(eventPos1,stationPos,pair.IDpha,data.vp,data.vs);
tt2=LOC_CalcTravelTime(eventPos2,stationPos,pair.IDpha,data.vp,data.vs);

predDiffTime=model.Teve(eventId1)+tt1-model.Teve(eventId2)-tt2;
end