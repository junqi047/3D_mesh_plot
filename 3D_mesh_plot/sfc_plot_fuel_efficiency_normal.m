function sfc_plot_fuel_efficiency_normal(torque,rps,sfc,fignmbr)
%
%
%          Musseldiagram och konturplot över sfc
%
%          funktion sfc_plot(torque,rpsec,sfc,lambda,fignmbr)
%
%               torque  = utmoment [Nm]
%               rps     = varv per sekund [rps]
%               sfc     = specifik bränsleförbrukning [kg/J]
%               lambda  = normerat luft-/bränsleförhållande
%               fignmbr = figurnummer   
%
%
%          Funktionen skapar ett musseldiagram och en konturplot  
%          över specifik bränsleförbrukningen som funktion av 
%          moment och varvtal. Olämpliga mätvärden (de för vilka 
%	   lambda < 0.96 tas bort.
%
%          Figurerna ritas i figur 'fignmbr' och 'fignmbr'+1.
%
%          (Uppdaterad 2002-09-20)
%
%
%          

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%    Skriven av YN    %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Plockar bort element ur datamängden som är opålitliga
% pga dåliga arbetsområden för sensorerna
% len = length(torque);
% index = setdiff(1:len,union(find(torque<15),find(lambda<0.95)));
M     = torque;
rpsec = rps;
sfc = sfc;


% Skapar ett rutnät, och interpolerar sedan fram en 
% tredimensionell yta ovanp?detta
% [X,Y] = meshgrid(min(M):(max(M)-min(M))/61:max(M),...
%     min(rpsec):(max(rpsec)-min(rpsec))/61:max(rpsec));
[X,Y] = meshgrid(min(M):(max(M)-min(M))/100:max(M),...
    min(rpsec):(max(rpsec)-min(rpsec))/100:max(rpsec));
Z = griddata(M,rpsec,sfc,X,Y);
%pp=max(sfc);
Xmin = min(min(X));  Xmax = max(max(X));
Ymin = min(min(Y));  Ymax = max(max(Y));
Zmin = min(min(Z));  Zmax = max(max(Z));


% X_max=M([1 5 9 19 32 46 57 66 75 83 90]);
% Y_max=rps([1 5 9 19 32 46 57 66 75 83 90])*60;
% Z_max=sfc([1 5 9 19 32 46 57 66 75 83 90]);

% Plottar ett musseldiagram
if nargin<5
  fignmbr = 4;
end

figure(fignmbr); clf; 
mesh(X,Y*60,Z);hold on;
%view(42.5,25)
xlabel('Torque [Nm]');
ylabel('Engine speed [rpm]');
zlabel('Fuel efficiency [%]');
%axis([0 Xmax 0 Ymax*60 Zmin Zmax]);
colorbar('location','eastoutside')
%title('2D engine map  ');
print('-dpdf','engine_map_short_fuel_efficiency_1_normal')
exportfig(gcf,'engine_map_short_fuel_efficiency_1_normal.eps','bounds','tight','Color','rgb','FontMode','fixed','FontSize',16,'height',20,'width',16);


figure(fignmbr+1);clf
mesh(X,Y*60,Z);hold on;
xlabel('Torque [Nm]');
ylabel('Engine speed [rpm]');
zlabel('Fuel efficiency [%]');
%axis([0 Xmax 0 Ymax*60 Zmin Zmax]);
colorbar('location','eastoutside')
%title('2D engine map  ');
% plot3(M,rps*60,sfc,'o');
print('-dpdf','engine_map_short_fuel_efficiency_2_normal')
exportfig(gcf,'engine_map_short_fuel_efficiency_2_normal.eps','bounds','tight','Color','rgb','FontMode','fixed','FontSize',16,'height',20,'width',16);


figure(fignmbr+2); clf; 
mesh(X,Y*60,Z);hold on;
%view(42.5,25)
xlabel('Torque [Nm]');
ylabel('Engine speed [rpm]');
zlabel('Fuel efficiency [%]');
%axis([0 Xmax 0 Ymax*60 Zmin Zmax]);
%title('2D engine map (Relation between Engine speed, Torque and Residual gas fraction) ');
hold on;
colorbar('location','eastoutside')
% plot3(X_max,Y_max,Z_max,'o');
print('-dpdf','engine_map_short_fuel_efficiency_3_normal')
exportfig(gcf,'engine_map_short_fuel_efficiency_3_normal.eps','bounds','tight','Color','rgb','FontMode','fixed','FontSize',16,'height',20,'width',16);


figure(fignmbr+3); clf;
sfcmin = min(sfc);
sfcmax = max(sfc);
v       = linspace(sfcmin,sfcmax,100);
vvalue  = v([1 100]);

%clabel(contour(X,Y*60,Z*1e6*3600,v),vvalue);
clabel(contour(Y*60,X,Z,v),vvalue);
xlabel('Engine speed [rpm]');
ylabel('Torque [Nm]');
colorbar('location','southoutside')
%title('2D engine map (Relation between Engine speed, Torque and Residual gas fraction) ');
print('-dpdf','engine_map_short_fuel_efficiency_4_normal')
exportfig(gcf,'engine_map_short_fuel_efficiency_4_normal.eps','bounds','tight','Color','rgb','FontMode','fixed','FontSize',16,'height',20,'width',16);


figure(fignmbr+4); clf;
sfcmin = min(sfc);
sfcmax = max(sfc);
v       = linspace(sfcmin,sfcmax,100);
vvalue  = v([1 100]);

%clabel(contour(X,Y*60,Z*1e6*3600,v),vvalue);
clabel(contour(Y*60,X,Z,v),vvalue);
hold on;
xlabel('Engine speed [rpm]');
ylabel('Torque [Nm]');
%title('2D engine map (Relation between Engine speed, Torque and Residual gas fraction) ');
% x=X_max';
% y=Y_max';
% z=Z_max';
% plot(y,x,'*');
% for i=1:11
% text(y(i),x(i),['  ' num2str(z(i)) ''])
% end
colorbar('location','southoutside')
print('-dpdf','engine_map_short_fuel_efficiency_5_normal')
exportfig(gcf,'engine_map_short_fuel_efficiency_5_normal.eps','bounds','tight','Color','rgb','FontMode','fixed','FontSize',16,'height',20,'width',16);
