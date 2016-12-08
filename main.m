%MSI Ex 6

%Hendrik Vloet, Mn.: 4324249
%Michael Floßmann 4348852
%Stephan Schraivogel, Mn.: 4318010


%% Import data
clear all; clc; close all;

wind_speed = import_data('produkt_wind_Terminwerte_19550101_20151231_01346.txt');

wind_speed= wind_speed(wind_speed~= -999);

%% Run stuff

figure(1)
histogram(wind_speed);
title('Wind speed histogram')
lx= xlabel('$\frac{m}{s}$');
set(lx,'Interpreter','Latex');
ylabel('Total frequency')

%x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options) 

x0 = [1,1]; % Make a starting guess at the solution
options= [];
%anonymous function
%Erster Term darf wegen Abh. von lambda und k nicht gestrichen werden bei Minimierung
obj = @(x) length(wind_speed).*log(x(1)/x(2)) + sum( (x(2)-1).*log(x(1)./wind_speed) + (wind_speed./x(1)).^x(2));
x =fmincon(obj,x0,[],[],[],[],[],[],@confun,options);

%Hier stimmt was nicht, und zwar gewaltig. Alles Blut unterlaufen! :D
weibull_fit= @(v) (x(2)/x(1)).*(v./x(1)).^(x(2)-1).*exp(-(v./x(1)).^x(2));
hold on;
plot(linspace(0,30,100), (weibull_fit(linspace(0,30,100)))*8479)