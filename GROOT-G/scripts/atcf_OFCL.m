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
Category1=dataArray{11};
RAD1=dataArray{12};
R1=dataArray{14};
R2=dataArray{15};
R3=dataArray{16};
R4=dataArray{17};
PO1=dataArray{18};
RO1=dataArray{19};
RMW1=dataArray{20};
Basin=dataArray{23};
Name1=dataArray{28};

if strcmp(FHR1(1),'0')==0
	Dates1=[Dates1(1);Dates1];
	FHR1=[0;FHR1];
	Latitude1=[Latitude1(1);Latitude1];
	Longitude1=[Longitude1(1);Longitude1];
	Speed1=[Speed1(1);Speed1];
	Pressure1=[Pressure1(1);Pressure1];
	Category1=[Category1(1);Category1];
	RAD1=[RAD1(1);RAD1];
	R1=[R1(1);R1];
	R2=[R2(1);R2];
	R3=[R3(1);R3];
	R4=[R4(1);R4];
	PO1=[PO1(1);PO1];
	RO1=[RO1(1);RO1];
	RMW1=[RMW1(1);RMW1];
	Basin=[Basin(1);Basin];
	Name1=[Name1(1);Name1];
end

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
    if isempty(str2num(Category1{i}))==1;if str2num(Speed1{i})./1.94384 < 34./1.94384;Cat(i,:)='TD';elseif str2num(Speed1{i})./1.94384 >= 34./1.94384 && str2num(Speed1{i})./1.94384 < 64./1.94384;Cat(i,:)='TS';elseif str2num(Speed1{i})./1.94384 >= 64./1.94384;Cat(i,:)='HU';end;else;Cat(i,:)=(Category1{i});end;
    Name(i,1:size(Name1{i},2))=(Name1{i});
    RAD(i)=str2num(RAD1{i});
    NEQ(i,:)=str2num(R1{i}).*1.852;
    SEQ(i,:)=str2num(R2{i}).*1.852;
    SWQ(i,:)=str2num(R3{i}).*1.852;
    NWQ(i,:)=str2num(R4{i}).*1.852;
    if isempty(str2num(PO1{i}))==1;PO(i,:)=0;else;PO(i,:)=str2num(PO1{i});end;
    if isempty(str2num(RO1{i}))==1;RO(i,:)=0;else;RO(i,:)=str2num(RO1{i}).*1.852;end;
    if isempty(str2num(RMW1{i}))==1;RMW(i,:)=0;else;RMW(i,:)=str2num(RMW1{i}).*1.852;end 
end

for i=1:size(Dates1,1)
    if strcmp(identhemi(i)','W')
        Longitude(i)=-1*Longitude(i);
    end
end
identhemi=identhemi';

% Get the Basin
Basin(strcmp(Basin, '')) = [];
Basin=unique(Basin);

% Reassign R34/R50/R64 to one line instead of duplicate lines
tmpfill=zeros(1,size(Dates1,1))';
tmpnum=1:size(Dates1,1);
tmp=cat(2,str2num(Dates),Latitude',Longitude',Speed,Pressure,RAD',NEQ,SEQ,SWQ,NWQ,tmpfill,tmpfill,tmpfill,tmpfill,tmpfill,tmpfill,tmpfill,tmpfill,tmpfill,tmpfill,PO,RO,RMW,tmpnum',FHR');
for i=2:size(tmp,1)
    if strcmp(num2str(tmp(i,1)),num2str(tmp(i-1,1))) || strcmp(num2str(tmp(i-1,1)),'NaN')
        if tmp(i,6)==50
            tmp(i-1,11:15)=tmp(i,6:10);
            tmp(i,:)=NaN;
        elseif tmp(i,6)==64
            tmp(i-2,16:20)=tmp(i,6:10);
            tmp(i,:)=NaN;            
        end
    end
end
tmp(any(isnan(tmp), 2), :) = [];

% Remove 1:11 h, 144 h, and 168 h FHR
for i=1:size(tmp,1)
    tmp1=(tmp(i,end));
    if tmp1 == 1 || tmp1 == 2 || tmp1 == 3 || tmp1 == 4 || tmp1 == 5 || tmp1 == 6 || tmp1 == 7 || tmp1 == 8 || tmp1 == 9 || tmp1 == 10 || tmp1 == 11 || tmp1 == 144 || tmp1 == 168
        tmp(i,:)=NaN; 
    else          
    end
end
tmp(any(isnan(tmp), 2), :) = [];


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
if str2num(checkyear(1:4))<2019
	% Interpolate middle values 48 - 60 - 72 - 84 - 96 - 108 - 120
	if size(tmp,1)==6 % this means goes to 72
		Cat=Cat(tmp(:,end-1),:);
		tmp(7,:)=tmp(6,:);
		tmp(6,:)=(tmp(5,:)+tmp(7,:))/2;
		tmp(:,end-1)=1:7;
		Cat(7,:)=Cat(6,:);
		if tmp(6,4)<34./1.94384
			Cat(6,:)='TD';
		elseif tmp(6,4)>=34./1.94384 & tmp(6,4)<64./1.94384
			Cat(6,:)='TS';
		elseif tmp(6,4)>=64./1.94384
			Cat(6,:)='HU';
		end
	elseif size(tmp,1)==7 % this means goes to 96
		Cat=Cat(tmp(:,end-1),:);
		tmp(9,:)=tmp(7,:);
		tmp(7,:)=tmp(6,:);
		tmp(6,:)=(tmp(5,:)+tmp(7,:))/2;
		tmp(8,:)=(tmp(7,:)+tmp(9,:))/2;
		tmp(:,end-1)=1:9;
		Cat(9,:)=Cat(7,:);
		Cat(7,:)=Cat(6,:);
		if tmp(6,4)<34./1.94384
			Cat(6,:)='TD';
		elseif tmp(6,4)>=34./1.94384 & tmp(6,4)<64./1.94384
			Cat(6,:)='TS';
		elseif tmp(6,4)>=64./1.94384
			Cat(6,:)='HU';
		end
		if tmp(8,4)<34./1.94384
			Cat(8,:)='TD';
		elseif tmp(8,4)>=34./1.94384 & tmp(8,4)<64./1.94384
			Cat(8,:)='TS';
		elseif tmp(8,4)>=64./1.94384
			Cat(8,:)='HU';
		end
	elseif size(tmp,1)==8 % this means goes to 120
		Cat=Cat(tmp(:,end-1),:);
		tmp(11,:)=tmp(8,:);
		tmp(9,:)=tmp(7,:);
		tmp(7,:)=tmp(6,:);
		tmp(6,:)=(tmp(5,:)+tmp(7,:))/2;
		tmp(8,:)=(tmp(7,:)+tmp(9,:))/2;
		tmp(10,:)=(tmp(9,:)+tmp(11,:))/2;
		tmp(:,end-1)=1:11;
		Cat(11,:)=Cat(8,:);
		Cat(9,:)=Cat(7,:);
		Cat(7,:)=Cat(6,:);
		if tmp(6,4)<34./1.94384
			Cat(6,:)='TD';
		elseif tmp(6,4)>=34./1.94384 & tmp(6,4)<64./1.94384
			Cat(6,:)='TS';
		elseif tmp(6,4)>=64./1.94384
			Cat(6,:)='HU';
		end
		if tmp(8,4)<34./1.94384
			Cat(8,:)='TD';
		elseif tmp(8,4)>=34./1.94384 & tmp(8,4)<64./1.94384
			Cat(8,:)='TS';
		elseif tmp(8,4)>=64./1.94384
			Cat(8,:)='HU';
		end
		if tmp(10,4)<34./1.94384
			Cat(10,:)='TD';
		elseif tmp(10,4)>=34./1.94384 & tmp(10,4)<64./1.94384
			Cat(10,:)='TS';
		elseif tmp(10,4)>=64./1.94384
			Cat(10,:)='HU';
		end
	end
else
	% Interpolate middle values 72 - 84 - 96 - 108 - 120
	if size(tmp,1)==8 % this means goes to 96
		Cat=Cat(tmp(:,end-1),:);
		tmp(9,:)=tmp(8,:);
		tmp(8,:)=(tmp(7,:)+tmp(9,:))/2;
		tmp(:,end-1)=1:9;
		Cat(9,:)=Cat(8,:);
		if tmp(8,4)<34./1.94384
			Cat(8,:)='TD';
		elseif tmp(8,4)>=34./1.94384 & tmp(8,4)<64./1.94384
			Cat(8,:)='TS';
		elseif tmp(8,4)>=64./1.94384
			Cat(8,:)='HU';
		end
	elseif size(tmp,1)==9 % this means goes to 120
		Cat=Cat(tmp(:,end-1),:);
		tmp(11,:)=tmp(9,:);
		tmp(9,:)=tmp(8,:);
		tmp(10,:)=tmp(11,:);
		tmp(8,:)=(tmp(7,:)+tmp(9,:))/2;
		tmp(10,:)=(tmp(9,:)+tmp(11,:))/2;
		tmp(:,end-1)=1:11;
		Cat(11,:)=Cat(9,:);
		Cat(9,:)=Cat(8,:);
		if tmp(8,4)<34./1.94384
			Cat(8,:)='TD';
		elseif tmp(8,4)>=34./1.94384 & tmp(8,4)<64./1.94384
			Cat(8,:)='TS';
		elseif tmp(8,4)>=64./1.94384
			Cat(8,:)='HU';
		end
		if tmp(10,4)<34./1.94384
			Cat(10,:)='TD';
		elseif tmp(10,4)>=34./1.94384 & tmp(10,4)<64./1.94384
			Cat(10,:)='TS';
		elseif tmp(10,4)>=64./1.94384
			Cat(10,:)='HU';
		end
	end
end
% Save Data Vectors
Date=num2str(tmp(:,1));
Latitude=tmp(:,2);
Longitude=tmp(:,3);
Speed=tmp(:,4);
Pressure=tmp(:,5);
RAD34=tmp(:,6);
NE34=tmp(:,7);
SE34=tmp(:,8);
SW34=tmp(:,9);
NW34=tmp(:,10);
RAD50=tmp(:,11);
NE50=tmp(:,12);
SE50=tmp(:,13);
SW50=tmp(:,14);
NW50=tmp(:,15);
RAD64=tmp(:,16);
NE64=tmp(:,17);
SE64=tmp(:,18);
SW64=tmp(:,19);
NW64=tmp(:,20);
PO=tmp(:,21);
PO(PO==0)=NaN;
RO=tmp(:,22);
RO(RO==0)=NaN;
RMW=tmp(:,23);
RMW(RMW==0)=NaN;
Category=Cat(tmp(:,24),:);
Name=Category;
FHR=tmp(:,25);

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
			ctsc(cnt,:)=Category(i-1,:);
			ctsc(cnt+1,:)=Category(i-1,:); 
			nmsc(cnt,:)=Name(i-1,:);
			nmsc(cnt+1,:)=Name(i-1,:); 
			cnt=cnt+2;
		end
		dtsc(cnt,:)=Date(end,:);
		ctsc(cnt,:)=Category(end,:);    
		nmsc(cnt,:)=Name(end,:);    
		dtesc=dtsc(:,1:8);
		hrsc=str2num(dtsc(:,9:10));
		for i=2:2:length(hrsc)
			hrsc(i)=hrsc(i)+3;
		end
		hrsc=num2str(hrsc,'%02.f');
		dtsc=[dtesc,hrsc];   
		Date=dtsc;
		Category=ctsc;
		Name=nmsc;
	end
	t6h=1:1:size(Latitude,1);
	t3h=1:.25:size(Latitude,1);
	DATEall=dtsc;
	CATall=ctsc;
	NAMEall=nmsc; 
elseif intrp==1 % Interpolate to 3-h
    cnt=1;
    for i=2:size(Latitude,1)
        dtsc(cnt,:)=Date(i-1,:);
        dtsc(cnt+1,:)=Date(i-1,:); 
        ctsc(cnt,:)=Category(i-1,:);
        ctsc(cnt+1,:)=Category(i-1,:); 
        nmsc(cnt,:)=Name(i-1,:);
        nmsc(cnt+1,:)=Name(i-1,:); 
        cnt=cnt+2;
    end
    dtsc(cnt,:)=Date(end,:);
    ctsc(cnt,:)=Category(end,:);    
    nmsc(cnt,:)=Name(end,:);    
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
    CATall=ctsc;
    NAMEall=nmsc;    
else % Already 3 h or keep at 6 h
    t6h=1:1:size(Latitude,1);
    t3h=1:1:size(Latitude,1);
    DATEall=Date;
    CATall=Category;
    NAMEall=Name;
end

% Output
if sum(size(Longitude))==2
    LATall=Latitude;
    LONall=Longitude;
    SPEEDall=Speed;
    PRESSall=Pressure;
    RAD34all=RAD34;
    NE34all=NE34;
    SE34all=SE34;
    SW34all=SW34;
    NW34all=NW34;
    RAD50all=RAD50;
    NE50all=NE50;
    SE50all=SE50;
    SW50all=SW50;
    NW50all=NW50;
    RAD64all=RAD64;
    NE64all=NE64;
    SE64all=SE64;
    SW64all=SW64;
    NW64all=NW64;
    POall=PO;
    ROall=RO;
    RMWall=RMW;
    UMOTall=UMOT;
    VMOTall=VMOT;
    FHRall=FHR;
    BASINall=Basin;
    INTCHall=INTCH;
    HFIPINTCHall=HFIPINTCH;
else
    LATall=interp1(t6h,Latitude,t3h);
    LONall=interp1(t6h,Longitude,t3h);
    SPEEDall=interp1(t6h,Speed,t3h);
    PRESSall=interp1(t6h,Pressure,t3h);
    RAD34all=interp1(t6h,RAD34,t3h);
    NE34all=interp1(t6h,NE34,t3h);
    SE34all=interp1(t6h,SE34,t3h);
    SW34all=interp1(t6h,SW34,t3h);
    NW34all=interp1(t6h,NW34,t3h);
    RAD50all=interp1(t6h,RAD50,t3h);
    NE50all=interp1(t6h,NE50,t3h);
    SE50all=interp1(t6h,SE50,t3h);
    SW50all=interp1(t6h,SW50,t3h);
    NW50all=interp1(t6h,NW50,t3h);
    RAD64all=interp1(t6h,RAD64,t3h);
    NE64all=interp1(t6h,NE64,t3h);
    SE64all=interp1(t6h,SE64,t3h);
    SW64all=interp1(t6h,SW64,t3h);
    NW64all=interp1(t6h,NW64,t3h);
    POall=interp1(t6h,PO,t3h);
    ROall=interp1(t6h,RO,t3h);
    RMWall=interp1(t6h,RMW,t3h);
    UMOTall=interp1(t6h,UMOT,t3h);
    VMOTall=interp1(t6h,VMOT,t3h);
    FHRall=interp1(t6h,FHR,t3h);
    INTCHall=interp1(t6h,INTCH,t3h);
    HFIPINTCHall=interp1(t6h,HFIPINTCH,t3h);
    BASINall=Basin;
end

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
