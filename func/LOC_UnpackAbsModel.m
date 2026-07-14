function model=LOC_UnpackAbsModel(x,Neve,Nsta,nDim)
% Convert optimization vector into model fields.

numLoc=Neve*nDim;

Xeve2D=reshape(x(1:numLoc),Neve,nDim);
Teve=x(numLoc+1:numLoc+Neve);
Dtsta=x(numLoc+Neve+1:numLoc+Neve+Nsta);

model.Xeve=zeros(Neve,3);
model.Xeve(:,1:nDim)=Xeve2D;
model.Teve=Teve;
model.Dtsta=Dtsta;
end