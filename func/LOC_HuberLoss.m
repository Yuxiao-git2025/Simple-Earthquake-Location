function loss=LOC_HuberLoss(residual,delta)
% Huber loss:
% 0.5*r^2/delta,for |r|<=delta
% |r|-0.5*delta,for |r|>delta
absResidual=abs(residual);
loss=zeros(size(residual));

isSmall=absResidual<=delta;
loss(isSmall)=0.5*residual(isSmall).^2/delta;
loss(~isSmall)=absResidual(~isSmall)-0.5*delta;
end