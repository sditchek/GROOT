function [rng, az] = distancegroot(lat1,lon1,lat2,lon2)

lat1=pi/180.*(lat1);
lat2=pi/180.*(lat2);
lon1=pi/180.*(lon1);
lon2=pi/180.*(lon2);
r=1;
a = sin((lat2-lat1)./2).^2 + cos(lat1) .* cos(lat2) .* sin((lon2-lon1)./2).^2;
a(a < 0) = 0;
a(a > 1) = 1;
rng = r * 2 * atan2(sqrt(a),sqrt(1 - a));
rng=180/pi.*(rng);

az = (atan2(cos(lat2) .* sin(lon2-lon1),cos(lat1) .* sin(lat2) - sin(lat1) .* cos(lat2) .* cos(lon2-lon1)));
az(lat1 <= -pi/2) = 0;
az(lat2 >=  pi/2) = 0;
az(lat2 <= -pi/2) = pi;
az(lat1 >=  pi/2) = pi;
az=180/pi.*(az)+360;
