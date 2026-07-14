function travelTime=LOC_CalcTravelTime(Xeve,Xsta,IDpha,vp,vs)
% Calculate theoretical P/S travel times
% Xeve and Xsta must have the same number of rows
% IDpha is a cell array such as {"P";"S";"P"}
distance=sqrt(sum((Xeve-Xsta).^2,2));
velocity=LOC_PhaseVelocity(IDpha,vp,vs);
travelTime=distance./velocity;
end
