function [identhemi,DATEall,BASINall,NAMEall,CATall,LATall,POall,SE50all,LONall,PRESSall,SE64all,NE34all,RAD34all,SPEEDall,NE50all,RAD50all,SW34all,NE64all,RAD64all,SW50all,NW34all,RMWall,SW64all,NW50all,ROall,NW64all,SE34all,FHRall,INTCHall,UMOTall,VMOTall,LANDall,HFIPINTCHall]=atcf(filename,intrp)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
% atcfgfs_bystorm(filename,intrp)
% INPUT
% filename: location and name of file
% intrp: (2) interp from 12 to 3 h (1) [interp to 3 h] or (0) [already 3 h or keep at 6 h]
% OUTPUT
% All data from atcf file in vector format (all radii in km)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Last Edited 06.22.20 by Sarah Ditchek
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read in data file
delimiter = ',';
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);

% Get columns of data you need
Dates1=dataArray{3};
FHR1=dataArray{6};
Latitude1=dataArray{7};
Longitude1=dataArray{8};
Speed1=dataArray{9};
Pressure1=dataArray{10};

% Transform to proper units and classes
for i=1:size(Dates1,1)
    Dates(i,:)=Dates1{i};
    FHR(i)=str2num(FHR1{i});
    tmp=Latitude1{i};
    Latitude(i)=str2num(tmp(1:end-1))./10;
    tmp=Longitude1{i};
    Longitude(i)=str2num(tmp(1:end-1))./10;
    identhemi(i)=tmp(end);
    Speed(i,:)=str2num(Speed1{i})./1.94384;
    Pressure(i,:)=str2num(Pressure1{i});
end

for i=1:size(Dates1,1)
    if strcmp(identhemi(i)','W')
        Longitude(i)=-1*Longitude(i);
    end
end
identhemi=identhemi';

% Reassign R34/R50/R64 to one line instead of duplicate lines
tmpfill=zeros(1,size(Dates1,1))';
tmpnum=1:size(Dates1,1);
tmp=cat(2,str2num(Dates),Latitude',Longitude',Speed,Pressure,tmpnum',FHR');

% Remove times not 0,6,12,18
for i=1:size(tmp,1)
    tmp1=num2str(tmp(i,1));
    tmp1=str2num(tmp1(9:10));
    if tmp1 == 0 || tmp1 == 6 || tmp1 == 12 || tmp1 == 18
    else
        tmp(i,:)=NaN;           
    end
end
tmp(any(isnan(tmp), 2), :) = [];

checkyear=num2str(tmp(1,1));
if str2num(checkyear(1:4))<2013
        % Interpolate middle values 48 - 60 - 72 - 84 - 96 - 108 - 120
        if size(tmp,1)==6 % this means goes to 72
                tmp(7,:)=tmp(6,:);
                tmp(6,:)=(tmp(5,:)+tmp(7,:))/2;
                tmp(:,end-1)=1:7;
        elseif size(tmp,1)==7 % this means goes to 96
                tmp(9,:)=tmp(7,:);
                tmp(7,:)=tmp(6,:);
                tmp(6,:)=(tmp(5,:)+tmp(7,:))/2;
                tmp(8,:)=(tmp(7,:)+tmp(9,:))/2;
                tmp(:,end-1)=1:9;
        elseif size(tmp,1)==8 % this means goes to 120
                tmp(11,:)=tmp(8,:);
                tmp(9,:)=tmp(7,:);
                tmp(7,:)=tmp(6,:);
                tmp(6,:)=(tmp(5,:)+tmp(7,:))/2;
                tmp(8,:)=(tmp(7,:)+tmp(9,:))/2;
                tmp(10,:)=(tmp(9,:)+tmp(11,:))/2;
                tmp(:,end-1)=1:11;
        end
end

% Save Data Vectors
Date=num2str(tmp(:,1));
Latitude=tmp(:,2);
Longitude=tmp(:,3);
Speed=tmp(:,4);
Pressure=tmp(:,5);
FHR=tmp(:,7);

% BONUS: Intensity Change % - don't actually use in the code! Only use IntCh from the atcf_shear code on the BDECK which always has the same time resolution
if size(Speed,1)<3
	INTCH=nan(size(Speed,1),1);
else
	for tmpint=2:size(Speed,1)-1
		INTCH(tmpint)=Speed(tmpint+1)-Speed(tmpint-1);
	end
	INTCH(1)=NaN;
	INTCH(end+1)=NaN;
end

% BONUS: HFIP Intensity Change %
if intrp==0
	minusvar=9;
elseif intrp==1
	minusvar=5;
elseif intrp==2
	minusvar=3;
end
if size(Speed,1)<minusvar
	HFIPINTCH=nan(size(Speed,1),1)';
else
	for tmpint=minusvar:size(Speed,1)
		HFIPINTCH(tmpint)=Speed(tmpint)-Speed(tmpint-(minusvar-1));
	end
	HFIPINTCH(1:minusvar-1)=NaN;
end

% BONUS: Storm Relative Motion %
EQDLON=111.11;
ER=6.37122e3;
PI=4.*atan(1);
RAD=PI/180;
KMHMS=1000/3600;
DHR=6;
cntr=1; 
if sum(size(Longitude))==2
    UMOT=NaN;
    VMOT=NaN;
else
for trk=1:size(Latitude,1)
    I1=trk+1;
    I0=trk-1;
    DELH=2.*DHR;
    if trk==1
        I1=trk+1;
        I0=trk;
        DELH=DHR;
    elseif trk==size(Latitude,1)
        I1=trk;
        I0=trk-1;
        DELH=DHR;
    end
    DXLON=Longitude(I1)-Longitude(I0);
    DXLAT=Latitude(I1)-Latitude(I0);
    XLATB=RAD*(Latitude(I1)+Latitude(I0))/2;
    DELY=EQDLON*DXLAT;
    DELX=cos(XLATB)*ER*RAD*DXLON;
    VMOT(cntr)=(DELY/DELH)*KMHMS;
    UMOT(cntr)=(DELX/DELH)*KMHMS;
    cntr=cntr+1;
end
end

% Interpolation
if intrp==2
	for loop=1:2
		cnt=1;
		for i=2:size(Date,1)
			dtsc(cnt,:)=Date(i-1,:);
			dtsc(cnt+1,:)=Date(i-1,:); 			
			cnt=cnt+2;
		end
		dtsc(cnt,:)=Date(end,:);		
		dtesc=dtsc(:,1:8);
		hrsc=str2num(dtsc(:,9:10));
		for i=2:2:length(hrsc)
			hrsc(i)=hrsc(i)+3;
		end
		hrsc=num2str(hrsc,'%02.f');
		dtsc=[dtesc,hrsc];   
		Date=dtsc;		
	end
	t6h=1:1:size(Latitude,1);
	t3h=1:.25:size(Latitude,1);
	DATEall=dtsc;
elseif intrp==1 % Interpolate to 3-h
    cnt=1;
    for i=2:size(Latitude,1)
        dtsc(cnt,:)=Date(i-1,:);
        dtsc(cnt+1,:)=Date(i-1,:);         
        cnt=cnt+2;
    end
    dtsc(cnt,:)=Date(end,:);  
    dtesc=dtsc(:,1:8);
    hrsc=str2num(dtsc(:,9:10));
    for i=2:2:length(hrsc)
        hrsc(i)=hrsc(i)+3;
    end
    hrsc=num2str(hrsc,'%02.f');
    dtsc=[dtesc,hrsc];   
    t6h=1:1:size(Latitude,1);
    t3h=1:.5:size(Latitude,1);
    DATEall=dtsc;   
else % Already 3 h or keep at 6 h
    t6h=1:1:size(Latitude,1);
    t3h=1:1:size(Latitude,1);
    DATEall=Date;
end

% Output
if sum(size(Longitude))==2
    LATall=Latitude;
    LONall=Longitude;
    SPEEDall=Speed;
    PRESSall=Pressure;    
    UMOTall=UMOT;
    VMOTall=VMOT;
    FHRall=FHR;
    INTCHall=INTCH;
    HFIPINTCHall=HFIPINTCH;
else
    LATall=interp1(t6h,Latitude,t3h);
    LONall=interp1(t6h,Longitude,t3h);
    SPEEDall=interp1(t6h,Speed,t3h);
    PRESSall=interp1(t6h,Pressure,t3h);   
    UMOTall=interp1(t6h,UMOT,t3h);
    VMOTall=interp1(t6h,VMOT,t3h);
    FHRall=interp1(t6h,FHR,t3h);
    INTCHall=interp1(t6h,INTCH,t3h);
    HFIPINTCHall=interp1(t6h,HFIPINTCH,t3h);
end

LATall(1:4)=0;
LONall(1:4)=0;
SPEEDall(1:4)=0;
PRESSall(1:4)=0;
UMOTall(1:4)=0;
VMOTall(1:4)=0;
INTCHall(1:4)=0;
HFIPINTCHall(1:4)=0;

BASINall=nan(1,size(LATall,2));
NAMEall=nan(1,size(LATall,2));
CATall=nan(1,size(LATall,2));
POall=nan(1,size(LATall,2));
SE50all=nan(1,size(LATall,2));
SE64all=nan(1,size(LATall,2));
NE34all=nan(1,size(LATall,2));
RAD34all=nan(1,size(LATall,2));
NE50all=nan(1,size(LATall,2));
RAD50all=nan(1,size(LATall,2));
SW34all=nan(1,size(LATall,2));
NE64all=nan(1,size(LATall,2));
RAD64all=nan(1,size(LATall,2));
SW50all=nan(1,size(LATall,2));
NW34all=nan(1,size(LATall,2));
RMWall=nan(1,size(LATall,2));
SW64all=nan(1,size(LATall,2));
NW50all=nan(1,size(LATall,2));
ROall=nan(1,size(LATall,2));
NW64all=nan(1,size(LATall,2));
SE34all=nan(1,size(LATall,2));

% Low Res. Landmask
load coastlines
vals=[coastlat coastlon];
for i=1:length(coastlat)
	if coastlat(i)<-60.5
		vals(i,:)=NaN;
	end
end
lat_mask=vals(:,1);
lon_mask=vals(:,2);                         
lndfl = inpolygon(LONall, LATall, lon_mask, lat_mask);    
% Make Great Lakes into Land
for i=1:size(lndfl,2)
	if LATall(i)>40 && LATall(i)<50 && LONall(i)<-75 && LONall(i)>-95
		lndfl(i)=1;
	end
end                                          
LANDall=lndfl;

end
