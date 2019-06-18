
function [res_v,res_r,xdenR]=PdenEnhcce(Iimg,chains,tensgrad,R1,R2,alpha,beta)
N=size(chains,1);
M=size(chains,2);
Weight=zeros(M,N);
yimg=Iimg;
origin=chains(1,1,:);
origin=reshape(origin,1,2);
WI=zeros(N,M);
xdenO=yimg(origin(1),origin(2));
res_v=0;
res_r=0;
for ch=1:N
    tempvar=chains(ch,:,1:2);
    tempvar=reshape(tempvar,M,2); 
    idx = tempvar(:,1) + (tempvar(:,2)-1)*size(yimg,1);
    Pvalues=yimg(idx);
    Gvalues=tensgrad(idx);
    
%     for ii=1:size(tempvar,1)   
%          Pvaluesk(ii)=yimg(tempvar(ii,1),tempvar(ii,2));    
%          Gvaluesk(ii)=tensgrad(tempvar(ii,1),tempvar(ii,2));
%     end
    
    
    dista=realsqrt((tempvar(:,1)-origin(1)).^2+(tempvar(:,2)-origin(2)).^2);
    thR1=size(find(dista<R1),1);
    Gcum=cumsum(abs(diff(Gvalues(1:thR1))));
    Gcumsum=zeros(thR1,1);
    Gcumsum(2:end)=Gcum;
    Origingrad=0;
    Tvar=Gcumsum;
    Tvar=abs(Tvar-Origingrad);
    Invar=double(abs(Pvalues(1:thR1)-yimg(origin(1),origin(2))));
    w=exp(-(1).*(((Invar./alpha)+(Tvar./beta))));
    w(w<0.000000001)=0;
    Weight(1:thR1,ch)=w;
    WI(ch,:)= Pvalues.*(Weight(:,ch));
    xmin=min(Pvalues);
    xmax=max(Pvalues);
    range=xmax-xmin;
      if (range == 0) 
          s = 0.5;
      else
          s = (xdenO- xmin)/range;
      end
    res_v= res_v+ s;
    res_r=res_r+ range; 
end
xden=sum(sum(WI))/sum(sum(Weight));
xdenR=xden;
res_v=res_v/N;
res_v=betacdf(res_v,0.5,0.5);
res_r=res_r/N;
end