function [ ELEMENTS,coords1,coords2 ] = L_triangulation( nx,ny,L1,L2)
%TRIANGULACE Triangulation of a rectangular domain.
%   nx,ny   numbers of nodes on both sides
[coords1,coords2]=meshgrid(linspace(0,L1,nx),linspace(0,L2,ny));
coords1=coords1(:); coords2=coords2(:);
idx=reshape(1:nx*ny,ny,nx);
idx1=idx(1:end-1,1:end-1); idx1=idx1(:)';
idx2=idx(1:end-1,2:end); idx2=idx2(:)';
idx3=idx(2:end,2:end); idx3=idx3(:)';
idx4=idx(2:end,1:end-1); idx4=idx4(:)';
EL1=[idx1; idx1];
EL2=[idx2; idx3];
EL3=[idx3; idx4];
ELEMENTS=[EL1(:) EL2(:) EL3(:)];

temp=(coords1<1)&(coords2<1);
remaining_POINTS=find(temp==false);

temp1=coords1(ELEMENTS);
temp2=coords2(ELEMENTS);
removed_ELEMENTS=any(temp1<1,2)&any(temp2<1,2);

ELEMENTS_new=0*ELEMENTS;
for i=1:length(remaining_POINTS)
    ELEMENTS_new(ELEMENTS==remaining_POINTS(i))=i;
end
ELEMENTS=ELEMENTS_new(~removed_ELEMENTS,:);
coords1=coords1(remaining_POINTS);
coords2=coords2(remaining_POINTS);
end

