function LOC_PlotObservation(data,eventId)
% Plot station locations and one selected event
isSelected=data.obs.IDeve==eventId;
IDsta=data.obs.IDsta(isSelected);
figure("Color","w");
hold on;
scatter(data.Xsta(IDsta,1),...
    data.Xsta(IDsta,2),...
    90,...
    "^","filled",'MarkerFaceColor',[0 0 0]);
scatter(data.Xeve(eventId,1),...
    data.Xeve(eventId,2),...
    110,...
    "o","filled",'MarkerFaceColor',[0 0 1]);
xlim([0,max(data.Xsta(:,1))*1.1]);
ylim([0,max(data.Xsta(:,2))*1.1]);
xlabel("X");
ylabel("Y");
hold off;
end