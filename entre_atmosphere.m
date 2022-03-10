clear all

R_Terre = 6378137;
G = 6.674*10^(-11);
M_Terre = 5.972*10^24;
rho_0 = 1.292;
P_0 = 101325;

dz = 10;%input("precision en metre: ")
k = 1;

z = 0;
g = -9.81;
P = P_0;
rho = rho_0;

liste_rho(k) = rho_0;
liste_z(k) = z;
liste_P(k) = P;
liste_g(k) = g;

while P > P_0/1000 ;
  
  g = -G*M_Terre/(R_Terre+z)^2;
  
  P = P+ rho*g*dz;
  
  rho = rho_0*P/P_0;
  
  liste_rho(k+1) = rho;
  liste_z(k+1) = z;
  liste_P(k+1) = P;
  liste_g(k+1) = g;
  
  k = k + 1;
  z = z + dz;
endwhile

z

figure 1
plot(liste_z,liste_P)
title("Pression atmospherique en fonction de l altitude")


Cx = 1;
S = 20;     %Surface de l'aeronef
v = -1000;  %vitesse initial aeronef
m = 1000;   %masse aeronef
x = z ;     %altitude d entré en atmosphere 
h = z ;
t = 0;

dt = 1;
n = 1;

acceleration(1) = 0;
vitesse(1) = v;
hauteur(1) = x;
temps(1) = t;

while x > 0 ;   %methode de euler
  
  while x < h ;  %on trouve l'indice de la liste correspondant a l altitude actuelle
    k = k - 1;
    h = liste_z(k);
  endwhile
  
  a = -1/2*S*Cx*abs(vitesse(n))*vitesse(n)*liste_rho(k)/m + liste_g(k);
  v = v + a*dt;
  x = x + v*dt;
  t = t + dt;
  
  acceleration(n+1) = a;
  vitesse(n+1) = v;
  hauteur(n+1) = x;
  temps(n+1) = t;
  
  n = n + 1;
endwhile

figure 2
plot(temps,vitesse)
title("vitesse en fonction du temps")

figure 3
plot(temps,hauteur)
title("altitude en fonction du temps")




