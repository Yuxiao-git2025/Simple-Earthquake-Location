function dev=LOC_HuberDerivative(residual,delta)
% Derivative of Huber loss with respect to residual
dev=zeros(size(residual));
isSmall=abs(residual)<=delta;
dev(isSmall)=residual(isSmall)/delta;
dev(~isSmall)=sign(residual(~isSmall));
end