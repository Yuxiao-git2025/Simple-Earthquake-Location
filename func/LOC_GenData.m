function data=LOC_GenData(param)
% Generate stations, events, and absolute-arrival observations
% Simply the 2D Simulator
data.vp=param.vp;
data.vs=param.vs;
data.Nsta=param.Nsta;
data.Neve=param.Neve;

data.Xsta=rand(param.Nsta,3)*param.Domain;
data.Xsta(:,3)=0;

data.Xeve=rand(param.Neve,3)*param.Domain;
data.Xeve(:,3)=0;

data.Teve=rand(param.Neve,1)*param.Domain/param.vp; % Occurrence time

disterp=0.8;
data.Dtsta=(rand(param.Nsta,1)-0.5)*disterp;   % Station arrival bias
data.Dtpha=(rand(param.Nsta,2)-0.5)*disterp;   % Phase(P/S) bias

% Constructing the observation array: event, station, P/S
Nobs=param.Neve* param.Nsta* 2;
obs.IDeve=zeros(Nobs,1);
obs.IDsta=zeros(Nobs,1);
obs.IDpha=cell(Nobs,1);
obs.Tpha=zeros(Nobs,1);
% obs.Wpha=ones(Nobs,1);
obs.Wpha=repmat([1;0.6],Nobs/2,1); % Usually P>S

Namepha=["P","S"];
count=0;
for id1=1:param.Neve
    for id2=1:param.Nsta
        for id3=1:2
            count=count+1;

            whichpha=Namepha{id3};
            Xeve=data.Xeve(id1,:);
            Xsta=data.Xsta(id2,:);
            travelTime=LOC_CalcTravelTime(Xeve,Xsta,{whichpha},data.vp,data.vs);

            obs.IDeve(count)=id1;
            obs.IDsta(count)=id2;
            obs.IDpha{count}=whichpha;
            obs.Tpha(count)=data.Teve(id1)+travelTime+...
                data.Dtsta(id2)+data.Dtpha(id2,id3);
        end
    end
end
data.obs=obs;
end