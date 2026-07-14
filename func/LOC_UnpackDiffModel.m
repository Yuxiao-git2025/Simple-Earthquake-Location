function model=LOC_UnpackDiffModel(x,Neve,nDim)
% Convert differential-time optimization vector into model fields.

numLoc=Neve*nDim;

Xeve2D=reshape(x(1:numLoc),Neve,nDim);
Teve=x(numLoc+1:numLoc+Neve);

model.Xeve=zeros(Neve,3);
model.Xeve(:,1:nDim)=Xeve2D;
model.Teve=Teve;
model.Dtsta=[];
end