function [] = windbarb(lat,lon,u,v,skip,scale,col)
%WINDBARB Adds wind barbs to plot
%
%  WINDBARB(lat,lon,u,v,skip,scale) projects two dimensional wind barbs onto the 
%  current plot. The vector components (u,v) are in units of KNOTS and
%  are specified at the points (lat,lon). It handles winds up to 130 KNOTS.
%  Winds exceeding 130 KNOTS will appear as 130 KNOTS.
%
%  ORIGINAL MFILE: windbarbm.m by Nick Siler (via Matlab file exchange)
%  MODIFIED BY: Sarah Ditchek to work...
%               1) without a map axis
%               2) with an argument to thin out the matrix
%               3) without the eval function (assigning g and c to matrix)

% Thin the data
u=u(1:skip:end,1:skip:end);
v=v(1:skip:end,1:skip:end);
lat=lat(1:skip:end,1:skip:end);
lon=lon(1:skip:end,1:skip:end);
% wind mag
umag = sqrt(u.^2+v.^2); %wind speed
%find theta; add pi to atan(v/u) when u<0
dummy = (u<0)*pi;
theta = atan(v./u)+dummy;
[a,b] = size(umag);
%create 18 logical matrices for 18 possible barbs. Non-zero when the barb
%is called for at that gridpoint.
g(:,:,1) = umag > 7.5 & umag <= 47.5;
g(:,:,2) = umag > 17.5 & umag <= 47.5;
g(:,:,3) = umag > 27.5;
g(:,:,4) = (umag > 37.5 & umag <= 47.5) | (umag > 57.5 & umag <= 97.5);
g(:,:,5) = umag > 67.5;
g(:,:,6) = (umag > 77.5 & umag < 97.5) | umag > 107.5;
g(:,:,7) = umag > 87.5 & umag < 97.5 | umag > 117.5;
g(:,:,8) = umag > 127.5;
g(:,:,9) = (umag > 2.5 & umag <= 7.5) | (umag > 12.5 & umag <= 17.5);
g(:,:,10) = umag > 22.5 & umag <= 27.5;
g(:,:,11) = (umag > 32.5 & umag <= 37.5) | (umag > 52.5 & umag <= 57.5);
g(:,:,12) = (umag > 42.5 & umag <= 47.5) | (umag > 62.5 & umag <= 67.5);
g(:,:,13) = (umag > 72.5 & umag <= 77.5) | (umag > 102.5 & umag <= 107.5); 
g(:,:,14) = (umag > 82.5 & umag <= 87.5) | (umag > 112.5 & umag <= 117.5);
g(:,:,15) = (umag > 92.5 & umag <= 97.5) | (umag > 122.5 & umag <= 127.5);
g(:,:,16) = umag > 47.5;
g(:,:,17) = umag > 97.5;
g(:,:,18) = true(a,b);
%position of each barb relative to grid point: [x0 y0; x1 y1]
c(:,:,1) = [-1 0;-1.125 .325];
c(:,:,2) = [-.875 0; -1 .325];
c(:,:,3) = [-.75 0; -.875 .325];
c(:,:,4) = [-.625 0; -.75 .325];
c(:,:,5) = [-.5 0; -.625 .325];
c(:,:,6) = [-.375 0; -.5 .325];
c(:,:,7) = [-.25 0; -.375 .325];
c(:,:,8) = [-.125 0; -.25 .325];
c(:,:,9) = [-.875 0; -.9375 .1625];
c(:,:,10) = [-.75 0; -.8125 .1625];
c(:,:,11) = [-.625 0; -.6875 .1625];
c(:,:,12) = [-.5 0; -.5625 .1625];
c(:,:,13) = [-.3750 0; -.4375 .1625];
c(:,:,14) = [-.25 0; -.3125 .1625];
c(:,:,15) = [-.125 0; -.1875 .1625];
c(:,:,16) = [-1 0; -.875 .325];
c(:,:,17) = [-.75 0; -.625 .325];
c(:,:,18) = [0 0; -1 0];
%set scale based on average latitude spacing
[m,n]=size(lat);
scale2 = scale*(max(max(lon))-min(min(lon)))/n;
%draw the barbs
for nn = 1:18
    dummy = reshape(g(:,:,nn),1,a*b);
    count = sum(dummy); % number of barbs to draw
    if count == 0
        continue
    end    
    %rotation operations
    x1 = c(1,1,nn)*cos(theta)-c(1,2,nn)*sin(theta);
    y1 = c(1,1,nn)*sin(theta)+c(1,2,nn)*cos(theta);
    x2 = c(2,1,nn)*cos(theta)-c(2,2,nn)*sin(theta);
    y2 = c(2,1,nn)*sin(theta)+c(2,2,nn)*cos(theta);    
    x1 = x1*scale2+lon;
    x2 = x2*scale2+lon;
    %multiply y1 and y2 by cos(lat) to compensate for the closer spacing of
    %meridians.
    y1 = y1*scale2.*cos(lat*pi/180)+lat;
    y2 = y2*scale2.*cos(lat*pi/180)+lat;
    x = [reshape(x1(dummy),1,count);reshape(x2(dummy),1,count)];
    y = [reshape(y1(dummy),1,count);reshape(y2(dummy),1,count)];
    line(x,y,'Color',col)
    hold on
end
