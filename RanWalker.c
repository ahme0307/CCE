#include "mex.h"
#include "math.h"

void mexFunction(int nlhs,mxArray *plhs[],int nrhs, mxArray *prhs[])
{
//RandomW(N,M,row,col,px,py,R1,R2)
//define input parameters
#define N_in prhs[0]
#define M_in prhs[1]
#define row_in prhs[2]
#define col_in prhs[3]
#define px_in  prhs[4]
#define py_in  prhs[5]
#define R1_in  prhs[6]
#define R2_in  prhs[7]
#define PI  3.1416
//define output parameter
#define chains_outx plhs[0] 
#define chains_outy plhs[1]
    
double px,py,row,col, R1,R2, *chainsx,*chainsy;
int N,M;
//Get the values left hand side
N=mxGetScalar(N_in);
M=mxGetScalar(M_in);
row=mxGetScalar(row_in);
col=mxGetScalar(col_in);
px=mxGetScalar(px_in);
py=mxGetScalar(py_in);
R1=mxGetScalar(R1_in);
R2=mxGetScalar(R2_in);
// get pointer to the output
chains_outx=mxCreateDoubleMatrix(M,N,mxREAL);
chains_outy=mxCreateDoubleMatrix(M,N,mxREAL);
chainsx=mxGetPr(chains_outx);
chainsy=mxGetPr(chains_outy);
double neighb_x[8]={1,-1,0, 0,-1,1, 1,-1};
double neighb_y[8]={0, 0,1,-1,-1,1,-1, 1} ;  
int t=0;

while(t<N)
{
double x=px;
double y=py;
chainsx[t*M]=px;
chainsy[t*M]=py;
int flag=1;
double Dt=0;
int count=0;

    for(int step=0;step<M-1;step++)
    {
     if(Dt<R1&flag!=0&step<M/2)
     {
      Dt=sqrt(((chainsx[t*M+step]-px)*(chainsx[t*M+step]-px))+((chainsy[t*M+step]-py)*(chainsy[t*M+step]-py))); 
	  double neighbors_x[8] = {0};
	  double neighbors_y[8] = {0};
      double temp_x;
      double temp_y;
      int nbcount=0;
      int k;
      for(int nb=0;nb<8;nb++)
      {
        temp_x= chainsx[t*M+step]+neighb_x[nb];
        temp_y= chainsy[t*M+step]+neighb_y[nb];
        if (temp_x<row&&temp_x>0&&temp_y<col&&temp_y>0)
        {
            neighbors_x[nbcount]=temp_x;
            neighbors_y[nbcount]=temp_y;
            nbcount++;
        }
      }
       double randtemp=((double)rand()/((double)RAND_MAX));
       k=(int)floor(nbcount*randtemp);
       if(nbcount==0)
       {
         chainsx[t*M+step+1]=chainsx[t*M+step];
         chainsy[t*M+step+1]=chainsy[t*M+step];
       }
       else
       {
           // double t1x = neighbors_x[k];
		   //double t2x = neighbors_y[k];
		   chainsx[t*M+step+1]=neighbors_x[k];
           chainsy[t*M+step+1]=neighbors_y[k];
       }
     }
     else
     {
       flag=0; 
       while(true)
       {
         double rmag;double angle_no;
         double ux,vy;
         double randtemp1=((double)rand()/(double)RAND_MAX);
         rmag=R1+(R2-R1)*randtemp1;
         double randtemp2=(double)rand()/(double)RAND_MAX;
         angle_no=randtemp2*2*PI;
         ux=(double)round(px+rmag*cos(angle_no));
         vy=(double)round(py+rmag*sin(angle_no));
         if (ux<row&&ux>0&&vy<col&&vy>0)
            {
                chainsx[t*M+step+1]=ux;
                chainsy[t*M+step+1]=vy;
               
                break;
            }
       }
     
     
     }
         
    }
t++;
}
return;
}
        
        
  