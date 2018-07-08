/* This program finds an optimal controller for the linear system x(k+1) = A x(k) + B u(k) where A=[0.16   2.16] and B = [-1] using Heuristic Dynamics Programming.                                                                                       [-0.16 -1.16]         [ 1] */

#include<cstdio>
#include<iostream>
#include<cmath>
#include<cstdlib>
#include <fstream>
#include <ctime>
#include <string>

using namespace std;

#define ns 2 //number of system states
#define tmax 50 //maximum time step
#define eta 0.7 //learning rate for actor
#define etb 0.7 //learning rate for critic

void write(double x[ns+1][tmax], double u[tmax], double V[tmax], double a[ns+1], double b[ns+1])
{
    ofstream bub("snac.txt");

    if(bub.is_open())

    {

     for(int r=1;r<=tmax;r++)

        bub<< x[1][r]<<" "<<x[2][r]<<" "<<u[r]<<" "<<V[r]<<" "<<a[1]<<" "<<a[2]<<" "<<b[1]<<" "<<b[2]<<"\n";

    }

    else cout<<"Unable to onpen file"<<endl;
}



void sys(int i, double x[ns+1][tmax], double u[tmax]) //system definition
{
  
  x[1][i+1] =  0.16 * x[1][i] + 2.16 * x[2][i] - u[i];
  x[2][i+1] = -0.16 * x[1][i] - 1.16 * x[2][i] + u[i];  
   
}

void weight(double a[ns+1], double b[ns+1]) //initializing the parameters of the actor and critic
{
    int k;

    for(k=1; k<= ns; k++)
      {
	a[k] =  (double)rand()/(RAND_MAX);

	b[k] =  (double)rand()/(RAND_MAX);
      }
}


void actor(int i, double a[ns+1], double x[ns+1][tmax], double u[tmax]) //computation of the actor output or control input 
{
  int k;

  // a[1] = 0.1546;
//   a[2] = 1.4537;

  // a[1] = 0.1572;
//   a[2] = 1.3087;

  u[i] = 0;

  for(k=1; k<=ns; k++)
 
    u[i] = u[i] + a[k] * x[k][i];   

}

void critic(int i, double b[ns+1], double x[ns+1][tmax], double V[tmax]) //computing critic output
{
  int k;
  
  V[i] = 0;

  for(k=1; k<=ns; k++)
 
    V[i] = V[i] + b[k] * x[k][i] * x[k][i];   
  
}


void util(int i, double u[tmax], double x[ns+1][tmax], double L[tmax]) //defining the utility function
{
  int k;

  L[i] = 0;

  for(k=1; k<=ns; k++)
    
    L[i] =  L[i] + x[k][i] * x[k][i];

  L[i] = L[i] + 0.1 * u[i] * u[i];

}


void cr_updt(int i, double b[ns+1], double Vd, double V[tmax], double x[ns+1][tmax]) //update routine for the critic
{

  int k;
  double E, delb[ns+1]; 
  
  E = Vd - V[i]; 

  for(k=1; k<=ns; k++)

    delb[k] = - E * x[k][i] * x[k][i];

  for(k=1; k<=ns; k++)
    
    b[k] = b[k] - etb * delb[k];

} 


void ac_updt(int i, double a[ns+1], double b[ns+1], double ud, double u[tmax], double x[ns+1][tmax]) //actor update
{

  int k;
  double E, dela[ns+1]; 

  ud = - 5 * ( -2 * x[1][i+1] * b[1] + 2 * x[2][i+1] * b[2] ); //desired value for the actor
  
  E = ud - u[i];

  for(k=1; k<=ns; k++)

    dela[k] = - E * x[k][i];

  for(k=1; k<=ns; k++)
    
    a[k] = a[k] - eta * dela[k];

} 

void opt_ctrl(int i, double V[tmax], double Uk[tmax])
{
 int k;
 
 for(k=1;k<=ns;k++)
    Uk[i] = -V[i];

}

main()

{
  int i;
  double x[ns+1][tmax], u[tmax], a[ns+1], b[ns+1], Vd, ud,Uk[tmax], V[tmax], L[tmax];

  srand(time(0));

  weight(a, b);

  x[1][1] = 0.7;
  x[2][1] = 0.2; //initial states

  for(i=1; i<tmax; i++)

    {
//      actor(i, a, x, u);

//      util(i, u, x, L);

      critic(i, a, x, V);

      opt_ctrl(i, V, Uk);

      sys(i, x, Uk);
      
      critic(i+1, b, x, V);

      Vd = L[i] + V[i+1];

      cr_updt(i, b, Vd, V, x);
     
//      ac_updt(i, a, b, ud, u, x);
       
      cout << x[1][i] << ' ' << x[2][i] << ' ' << u[i] << ' ' << V[i] << ' ' << a[1] << ' ' << a[2] << ' ' << b[1] << ' ' << b[2] << endl;

      write( x , u, V, a, b);
      
    }

}


