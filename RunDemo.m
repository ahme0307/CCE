
% Demo for Stochastic Capsule Endoscopy Image Enhancement. The input image can be of format (jpg, bmp)
% If your input image is off different format change bmpfiles = dir([IO_Folder '/*.bmp']); accordingly
%Please dont forget to cite Mohammed, Ahmed, Ivar Farup, Marius Pedersen, Øistein Hovde, and Sule Yildirim Yayilgan. "Stochastic capsule endoscopy image enhancement." Journal of Imaging 4, no. 6 (2018): 75.

clc; 
clear all
IO_Folder='.\Input_images';
result_Fol='.\Output_images\';
bmpfiles = dir([IO_Folder '/*.bmp']);
pngfiles = dir([IO_Folder '/*.jpg']);
%Parameters of the algorithm 
R1=10 ; % Inner readius
R2=800; % Outer radius
N=20; % number of Iterations
M=250; % Number of samples
alpha=10; % Intensity penality 
beta=10; % gradient penality 
gamma1= 0.5; % mixing for D1
gamma2= 0.3; % mixing for D2

bmpfiles=[bmpfiles;pngfiles];
for fcount=1:size(bmpfiles,1)
filename = [IO_Folder '/' bmpfiles(fcount).name];
imO=imread(filename);
imD=im2double(imread(filename));
if size(imD,3)==3
    pout = rgb2ycbcr(imO);
else
    pout=imD;
end
im=double(pout(:,:,1))/255;
xdenR=zeros(size(im));
res_v=zeros(size(im));
res_r=zeros(size(im));
tensgrad=tensorgrad(imO);

for ch=1:size(im,3)
    img=im(:,:,ch);
   [col,row]=size(img);
   temp=zeros(N,M,2);
    for x=1:size(img,2)-1
        tStartensor = tic; 
        
       for y=1:size(img,1)-1
          tStarden = tic; 
          [tx,ty]=RanWalker(N,M,size(img,1)-2,size(img,2)-2,y,x,R1,R2);
          [res_vp,res_rp,xdenRp]=PdenEnhcce(img,cat(3,tx'+1,ty'+1),tensgrad,R1,R2,alpha,beta);
          xdenR(y,x,ch)=xdenRp;
          res_v(y,x,ch)=res_vp;
          res_r(y,x,ch)=res_rp; 
       end
          tElapsed = toc(tStartensor);
          counter=strcat(num2str(tElapsed),' time and iteration  =', num2str(x))
    end
    
      
end
F(:,:,1)=uint8(res_v*255);
pout = rgb2ycbcr(imO);
F(:,:,2)=pout(:,:,2);
F(:,:,3)=pout(:,:,3);
Frgb=ycbcr2rgb(F);
D1=img-xdenR;
D2=res_v-xdenR;
D=gamma1*(D1)+gamma2*(D2);
t=xdenR+2.5*D;
F1(:,:,1)=uint8(t.*255);
F1(:,:,2)=pout(:,:,2);
F1(:,:,3)=pout(:,:,3);
F1rgb=ycbcr2rgb(F1);
[~,name,ext] = fileparts(filename);
imwrite(xdenR,strcat([result_Fol,name],'_',num2str(alpha),'C_',num2str(beta),'_','nxden_grey','.png'));
imwrite(img,strcat([result_Fol,name],'_',num2str(alpha),'C_',num2str(beta),'_','orig_gray','.png'));
imwrite(F1rgb,strcat([result_Fol,name],'_',num2str(alpha),'C_',num2str(beta),'_','stoch_rgbnn','.png'));
vars = {'F','Frgb','F1'};
clear(vars{:})
end