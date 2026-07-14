function velocity=LOC_PhaseVelocity(IDpha,vp,vs)
% Convert phase names into velocity values
numPhase=numel(IDpha);
velocity=zeros(numPhase,1);
isP=strcmp(IDpha,"P");
velocity(isP)=vp;
velocity(~isP)=vs;
end
