clear all
clc
close all
start

% DATOS
nc = netcdf('CMEMS_Barranquilla_2022_so.nc');
sal = nc{'so'}(:);
depth = nc{'depth'}(:);
time = nc{'time'}(:);
close(nc)

sal=sal';
sal(sal >= 1000) = NaN;
sal=sal(1:35,:); % el archivo tiene desde la fila 35 (900 m) hasta el final (4000 m) solo NaN, asi que tuve que selecionar 
depth = depth(1:35);
fechas = datetime(1950,1,1) + hours(time);
t_num = datenum(fechas);
[Xdat,Ydat] = meshgrid(t_num,depth);

figure(1)
contourf(Xdat,Ydat,sal,40,'LineColor','none')
set(gca, 'YDir', 'reverse')
title('Hovmöller Sea Water Salinity 2022','FontWeight','bold')
xlabel('Time')
ylabel('Depth (m)')
%set(gca,'xtick',1:12,'ytick',-56:-51,...
% 'xticklabel',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'},...
% 'yticklabel',{'56°S','55°S','54°S','53°S','52°S','51°S'})
caxis([32 37])
shading flat
colormap turbo
c = colorbar;
ylabel(c,'PSU','FontSize',10,'Rotation',90,'FontWeight','bold')
datetick
print(gcf,'fig2_sal_Hovmoller.png','-dpng','-r300');



