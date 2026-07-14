function predTime=LOC_PredAbsTime(model,data)
% Predict absolute arrival time:
% T=t0+distance/velocity+Dtsta
obs=data.obs;
eventPos=model.Xeve(obs.IDeve,:);
stationPos=data.Xsta(obs.IDsta,:);
travelTime=LOC_CalcTravelTime(eventPos,stationPos,obs.IDpha,data.vp,data.vs);
predTime=model.Teve(obs.IDeve)+travelTime+model.Dtsta(obs.IDsta);
end