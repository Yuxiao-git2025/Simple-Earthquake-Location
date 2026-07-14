function LOC_PlotAbsLoc(data, invertModel, param)
% Compare true, initial, and inverted locations for absolute arrivals.
% param.Domain: square-domain side length, e.g. 50
figure("Color", "w");
ax = axes;
hold(ax, "on");
% --------------------- Plot events and stations ---------------------
plot(ax, data.Xeve(:,1), data.Xeve(:,2), ...
    "o", "MarkerSize", 10, "LineWidth", 0.9, ...
    "MarkerFaceColor", "none", ...
    "MarkerEdgeColor", [0 0 0], ...
    "LineStyle", "none");
plot(ax, invertModel.Xeve(:,1), invertModel.Xeve(:,2), ...
    "x", "MarkerSize", 18, "LineWidth", 2.2, ...
    "LineStyle", "none", ...
    "MarkerEdgeColor", [0.9098 0.0627 0.4039]);
scatter(ax, data.Xsta(:,1), data.Xsta(:,2), 220, data.Dtsta, ...
    "^", "filled", "MarkerFaceColor", [0 0 0]);
% --------------------- Circular domain boundary ---------------------
domain = param.Domain;
center = [domain / 2, domain / 2];
radius = domain / 2 * sqrt(2);
theta = linspace(0, 2*pi, 361);
xCircle = center(1) + radius * cos(theta);
yCircle = center(2) + radius * sin(theta);
plot(ax, xCircle, yCircle, "-", ...
    "Color", [0.25 0.25 0.25], ...
    "LineWidth", 1.2);
Fun_Decorat;
% Make the displayed plotting range cover the full circle.
xlim(ax, center(1) + [-radius, radius]);
ylim(ax, center(2) + [-radius, radius]);
axis(ax, "equal");
% Optional: removes the rectangular axes outline, leaving the circle as
% the visible model-domain boundary.
box(ax, "off");
hobj = gca;
set(hobj.YAxis, 'Visible', 'off');
xlabel(ax, "Distance");
title(ax,'Absolute Location');
hold(ax, "off");
end
