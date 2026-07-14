function pair=LOC_GenDiffTime(data)
% Generate same-station,same-phase differential arrival times:
% DeltaT=T(event1)-T(event2)
%
% Station clock error and station-phase random bias cancel in each pair
Neve=data.Neve;
Nsta=data.Nsta;
numPair=Neve*(Neve-1)/2*Nsta*2;
pair.IDeve=zeros(numPair,2);
pair.IDsta=zeros(numPair,1);
pair.IDpha=cell(numPair,1);
pair.diffTime=zeros(numPair,1);
pair.weight=ones(numPair,1);
Namepha=["P","S"];
count=0;
for id1=1:Neve
    for id2=id1+1:Neve
        for id3=1:Nsta
            for phaseId=1:2
                count=count+1;

                phaseName=Namepha{phaseId};

                Xeve1=data.Xeve(id1,:);
                Xeve2=data.Xeve(id2,:);
                Xsta=data.Xsta(id3,:);

                tt1=LOC_CalcTravelTime(Xeve1,Xsta,{phaseName},data.vp,data.vs);
                tt2=LOC_CalcTravelTime(Xeve2,Xsta,{phaseName},data.vp,data.vs);

                t1=tt1+data.Teve(id1)+...
                    data.Dtsta(id3)+data.Dtpha(id3,phaseId);

                t2=tt2+data.Teve(id2)+...
                    data.Dtsta(id3)+data.Dtpha(id3,phaseId);

                pair.IDeve(count,:)=[id1,id2];
                pair.IDsta(count)=id3;
                pair.IDpha{count}=phaseName;
                pair.diffTime(count)=t1-t2;
            end
        end
    end
end
end