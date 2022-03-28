for graphics=1
	clear l 
	% Parameters
	trkerr_sz=0; % find longest lead time - initialize value
	spPos=[0.11 0.13+.05 0.75 0.75-.05]; % arrange plots the same
	clPos=[0.88 0.13+.05 0.04 0.75-.05]; % arrange plots the same
	% Initialize BT
	BT_lon=nan(size(identinittimesunique,1),identmodelfhr);BT_land=nan(size(identinittimesunique,1),identmodelfhr);
	BT_lat=nan(size(identinittimesunique,1),identmodelfhr);
	BT_maxspd=nan(size(identinittimesunique,1),identmodelfhr);BT_cat=cell(size(identinittimesunique,1),identmodelfhr);BT_cat(:) = {'  '};
	BT_minpres=nan(size(identinittimesunique,1),identmodelfhr);
	BT_ne34=nan(size(identinittimesunique,1),identmodelfhr);
	BT_ne50=nan(size(identinittimesunique,1),identmodelfhr);
	BT_ne64=nan(size(identinittimesunique,1),identmodelfhr);
	BT_se50=nan(size(identinittimesunique,1),identmodelfhr);
	BT_se34=nan(size(identinittimesunique,1),identmodelfhr);
	BT_se64=nan(size(identinittimesunique,1),identmodelfhr);
	BT_sw34=nan(size(identinittimesunique,1),identmodelfhr);
	BT_sw50=nan(size(identinittimesunique,1),identmodelfhr);
	BT_sw64=nan(size(identinittimesunique,1),identmodelfhr);
	BT_nw34=nan(size(identinittimesunique,1),identmodelfhr);
	BT_nw50=nan(size(identinittimesunique,1),identmodelfhr);
	BT_nw64=nan(size(identinittimesunique,1),identmodelfhr);
	BT_po=nan(size(identinittimesunique,1),identmodelfhr);
	BT_ro=nan(size(identinittimesunique,1),identmodelfhr);
	BT_rmw=nan(size(identinittimesunique,1),identmodelfhr);         
	BT_intch=nan(size(identinittimesunique,1),identmodelfhr);         
	BT_shr=nan(size(identinittimesunique,1),identmodelfhr);         
	% Initialize EXP
	EXP_lon=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));EXP_land=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_lat=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_maxspd=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_minpres=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_ne34=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_ne50=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_ne64=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_se34=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_se50=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_se64=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_sw34=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_sw50=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_sw64=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_nw34=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_nw50=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_nw64=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_po=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_ro=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	EXP_rmw=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));         
	EXP_intch=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));         
	EXP_shr=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));         
	% Initialize Errors
	ateerr_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	xteerr_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	trkerr_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	interr_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	spderr_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	ne34err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	se34err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	sw34err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	nw34err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	ne50err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	se50err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	sw50err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	nw50err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	ne64err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	se64err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	sw64err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	nw64err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	poerr_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	roerr_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	rmwerr_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	intcherr_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
	% Individual Cycles
	for identloop=1:size(identinittimesunique,1)
		load([identout,'RESULTS/',identfold,'VERIFICATION/',identremovename,'/',ident(1:2),'/',identn,'/',identn,'_data.mat']);clear initnum;
		for i=1:size(DATEall,1)
			if strcmp(identinittimesunique(identloop,:),DATEall(i,:))==1
				initnum=i
			end
		end
		if exist('initnum','var')==0 %% to take care of invests not in BT
		else
			%% BT
			initsize=size(DATEall,1)-initnum+1;
			bt_date=DATEall(initnum:end,:);
			bt_cat=CATall(initnum:end,:);
			bt_lat=LATall(initnum:end);
			bt_lon=LONall(initnum:end);bt_land=LANDall(initnum:end);
			bt_maxspd=SPEEDall(initnum:end);
			bt_minpres=PRESSall(initnum:end);
			bt_ne34=NE34all(initnum:end);
			bt_ne50=NE50all(initnum:end);
			bt_ne64=NE64all(initnum:end);
			bt_se34=SE34all(initnum:end);
			bt_se50=SE50all(initnum:end);
			bt_se64=SE64all(initnum:end);
			bt_sw34=SW34all(initnum:end);
			bt_sw50=SW50all(initnum:end);
			bt_sw64=SW64all(initnum:end);
			bt_nw34=NW34all(initnum:end);
			bt_nw50=NW50all(initnum:end);
			bt_nw64=NW64all(initnum:end);
			bt_po=POall(initnum:end);
			bt_ro=ROall(initnum:end);
			bt_rmw=RMWall(initnum:end); 
			bt_intch=INTCHall(initnum:end); 
			bt_shr=SHRall(initnum:end); 
			%% EXP - grab stats file
			% Initialize Individual
			exp_fhr=nan(100,size(identexp,1));
			exp_lon=nan(100,size(identexp,1));exp_land=nan(100,size(identexp,1));
			exp_lat=nan(100,size(identexp,1));
			exp_minpres=nan(100,size(identexp,1));
			exp_maxspd=nan(100,size(identexp,1));                   
			exp_ne34=nan(100,size(identexp,1));
			exp_ne50=nan(100,size(identexp,1));
			exp_ne64=nan(100,size(identexp,1));
			exp_se34=nan(100,size(identexp,1));
			exp_se50=nan(100,size(identexp,1));
			exp_se64=nan(100,size(identexp,1));
			exp_sw34=nan(100,size(identexp,1));
			exp_sw50=nan(100,size(identexp,1));
			exp_sw64=nan(100,size(identexp,1));
			exp_nw34=nan(100,size(identexp,1));
			exp_nw50=nan(100,size(identexp,1));
			exp_nw64=nan(100,size(identexp,1));
			exp_po=nan(100,size(identexp,1));
			exp_ro=nan(100,size(identexp,1));
			exp_rmw=nan(100,size(identexp,1)); 
			exp_intch=nan(100,size(identexp,1)); 
			exp_shr=nan(100,size(identexp,1)); 
			% Loop
			for tmp=1:size(identexp,1)                
filename=[identgroovpr,identexp{tmp},'/atcf/',identtmp1,'.',identinittimesunique(identloop,:),'.trak.hwrf.atcfunix']; fid = fopen(filename,'rt'); C = textscan(fid,'%s%s%s%s%s%s%[^\n]', 'Delimiter',',= ', 'MultipleDelimsAsOne',true); fclose(fid); if sum(size(C{1}))==2; identoutputres=0; else; C=C{6}; if strcmp(C{2},'003')==1 || strcmp(C{2},'03')==1 || strcmp(C{2},'3')==1; identoutputres=0; else identoutputres=1; end; end;
				[identhemi,DATEall,BASINall,NAMEall,CATall,LATall,POall,SE50all,LONall,PRESSall,SE64all,NE34all,RAD34all,SPEEDall,NE50all,RAD50all,SW34all,NE64all,RAD64all,SW50all,NW34all,RMWall,SW64all,NW50all,ROall,NW64all,SE34all,FHRall,INTCHall,LANDall]=atcf(filename,identoutputres);
				initsizeexp=size(FHRall,2);
				exp_fhr(1:initsizeexp,tmp)=FHRall';
				exp_lon(1:initsizeexp,tmp)=LONall;exp_land(1:initsizeexp,tmp)=LANDall;
				exp_lat(1:initsizeexp,tmp)=LATall;
				exp_minpres(1:initsizeexp,tmp)=PRESSall;
				exp_maxspd(1:initsizeexp,tmp)=SPEEDall;                    
				exp_ne34(1:initsizeexp,tmp)=NE34all;
				exp_ne50(1:initsizeexp,tmp)=NE50all;
				exp_ne64(1:initsizeexp,tmp)=NE64all;
				exp_se34(1:initsizeexp,tmp)=SE34all;
				exp_se50(1:initsizeexp,tmp)=SE50all;
				exp_se64(1:initsizeexp,tmp)=SE64all;
				exp_sw34(1:initsizeexp,tmp)=SW34all;
				exp_sw50(1:initsizeexp,tmp)=SW50all;
				exp_sw64(1:initsizeexp,tmp)=SW64all;
				exp_nw34(1:initsizeexp,tmp)=NW34all;
				exp_nw50(1:initsizeexp,tmp)=NW50all;
				exp_nw64(1:initsizeexp,tmp)=NW64all;
				exp_po(1:initsizeexp,tmp)=POall;
				exp_ro(1:initsizeexp,tmp)=ROall;
				exp_rmw(1:initsizeexp,tmp)=RMWall;                    
				exp_intch(1:initsizeexp,tmp)=INTCHall;  
				exp_shr(1:initsizeexp,tmp)=INTCHall;                    									
			end  
			% Cut off rows with NaNs to make lengths equal
			exp_lon(any(isnan(exp_fhr), 2), :) = [];exp_land(any(isnan(exp_fhr), 2), :) = [];
			exp_lat(any(isnan(exp_fhr), 2), :) = [];
			exp_minpres(any(isnan(exp_fhr), 2), :) = [];
			exp_maxspd(any(isnan(exp_fhr), 2), :) = [];                  
			exp_ne34(any(isnan(exp_fhr), 2), :) = [];
			exp_ne50(any(isnan(exp_fhr), 2), :) = [];
			exp_ne64(any(isnan(exp_fhr), 2), :) = [];
			exp_se34(any(isnan(exp_fhr), 2), :) = [];
			exp_se50(any(isnan(exp_fhr), 2), :) = [];
			exp_se64(any(isnan(exp_fhr), 2), :) = [];
			exp_sw34(any(isnan(exp_fhr), 2), :) = [];
			exp_sw50(any(isnan(exp_fhr), 2), :) = [];
			exp_sw64(any(isnan(exp_fhr), 2), :) = [];
			exp_nw34(any(isnan(exp_fhr), 2), :) = [];
			exp_nw50(any(isnan(exp_fhr), 2), :) = [];
			exp_nw64(any(isnan(exp_fhr), 2), :) = [];
			exp_po(any(isnan(exp_fhr), 2), :) = [];
			exp_ro(any(isnan(exp_fhr), 2), :) = [];
			exp_rmw(any(isnan(exp_fhr), 2), :) = []; 
			exp_intch(any(isnan(exp_fhr), 2), :) = []; 
			exp_shr(any(isnan(exp_fhr), 2), :) = []; 
			exp_fhr(any(isnan(exp_fhr), 2), :) = [];
			% Measure size
			initsizeexp=size(exp_lon,1);                
			% Make BT and EXP same size
			if initsize>initsizeexp                    
				bt_cat=bt_cat(1:initsizeexp,:);
				bt_lon=bt_lon(1:initsizeexp);bt_land=bt_land(1:initsizeexp);
				bt_lat=bt_lat(1:initsizeexp);
				bt_minpres=bt_minpres(1:initsizeexp);
				bt_maxspd=bt_maxspd(1:initsizeexp);
				bt_date=bt_date(1:initsizeexp,:);                    
				bt_ne34=bt_ne34(1:initsizeexp);
				bt_ne50=bt_ne50(1:initsizeexp);
				bt_ne64=bt_ne64(1:initsizeexp);
				bt_se34=bt_se34(1:initsizeexp);
				bt_se50=bt_se50(1:initsizeexp);
				bt_se64=bt_se64(1:initsizeexp);
				bt_sw34=bt_sw34(1:initsizeexp);
				bt_sw50=bt_sw50(1:initsizeexp);
				bt_sw64=bt_sw64(1:initsizeexp);
				bt_nw34=bt_nw34(1:initsizeexp);
				bt_nw50=bt_nw50(1:initsizeexp);
				bt_nw64=bt_nw64(1:initsizeexp);
				bt_po=bt_po(1:initsizeexp);
				bt_ro=bt_ro(1:initsizeexp);
				bt_rmw=bt_rmw(1:initsizeexp);   
				bt_intch=bt_intch(1:initsizeexp);   
				bt_shr=bt_shr(1:initsizeexp);   
				initsize=initsizeexp;
			else
				exp_fhr=exp_fhr(1:initsize,:);
				exp_lon=exp_lon(1:initsize,:);exp_land=exp_land(1:initsize,:);
				exp_lat=exp_lat(1:initsize,:);
				exp_minpres=exp_minpres(1:initsize,:);
				exp_maxspd=exp_maxspd(1:initsize,:);
				exp_ne34=exp_ne34(1:initsize,:);
				exp_ne50=exp_ne50(1:initsize,:);
				exp_ne64=exp_ne64(1:initsize,:);
				exp_se34=exp_se34(1:initsize,:);
				exp_se50=exp_se50(1:initsize,:);
				exp_se64=exp_se64(1:initsize,:);
				exp_sw34=exp_sw34(1:initsize,:);
				exp_sw50=exp_sw50(1:initsize,:);
				exp_sw64=exp_sw64(1:initsize,:);
				exp_nw34=exp_nw34(1:initsize,:);
				exp_nw50=exp_nw50(1:initsize,:);
				exp_nw64=exp_nw64(1:initsize,:);
				exp_po=exp_po(1:initsize,:);
				exp_ro=exp_ro(1:initsize,:);
				exp_rmw=exp_rmw(1:initsize,:);   
				exp_intch=exp_intch(1:initsize,:);   
				exp_shr=exp_shr(1:initsize,:);   
			end         
			%% Turn missing spots and non-homogeneous spots into NaNs
			exp_ne34(exp_ne34==0)=NaN;exp_ne34(any(isnan(exp_ne34), 2), :) = NaN;
			exp_ne50(exp_ne50==0)=NaN;exp_ne50(any(isnan(exp_ne50), 2), :) = NaN;
			exp_ne64(exp_ne64==0)=NaN;exp_ne64(any(isnan(exp_ne64), 2), :) = NaN;
			exp_se34(exp_se34==0)=NaN;exp_se34(any(isnan(exp_se34), 2), :) = NaN;
			exp_se50(exp_se50==0)=NaN;exp_se50(any(isnan(exp_se50), 2), :) = NaN;
			exp_se64(exp_se64==0)=NaN;exp_se64(any(isnan(exp_se64), 2), :) = NaN;
			exp_sw34(exp_sw34==0)=NaN;exp_sw34(any(isnan(exp_sw34), 2), :) = NaN;
			exp_sw50(exp_sw50==0)=NaN;exp_sw50(any(isnan(exp_sw50), 2), :) = NaN;
			exp_sw64(exp_sw64==0)=NaN;exp_sw64(any(isnan(exp_sw64), 2), :) = NaN;
			exp_nw34(exp_nw34==0)=NaN;exp_nw34(any(isnan(exp_nw34), 2), :) = NaN;
			exp_nw50(exp_nw50==0)=NaN;exp_nw50(any(isnan(exp_nw50), 2), :) = NaN;
			exp_nw64(exp_nw64==0)=NaN;exp_nw64(any(isnan(exp_nw64), 2), :) = NaN;
			exp_po(exp_po<0)=NaN;exp_po(any(isnan(exp_po), 2), :) = NaN;
			exp_ro(exp_ro<0)=NaN;exp_ro(any(isnan(exp_ro), 2), :) = NaN;
			bt_ne34(bt_ne34==0)=NaN;
			bt_ne50(bt_ne50==0)=NaN;
			bt_ne64(bt_ne64==0)=NaN;
			bt_se34(bt_se34==0)=NaN;
			bt_se50(bt_se50==0)=NaN;
			bt_se64(bt_se64==0)=NaN;
			bt_sw34(bt_sw34==0)=NaN;
			bt_sw50(bt_sw50==0)=NaN;
			bt_sw64(bt_sw64==0)=NaN;
			bt_nw34(bt_nw34==0)=NaN;
			bt_nw50(bt_nw50==0)=NaN;
			bt_nw64(bt_nw64==0)=NaN;                
			bt_po(bt_po<0)=NaN;
			bt_ro(bt_ro<0)=NaN;
			%% Save lat/lons
			for ct=1:size(bt_cat,1)
				BT_cat(identloop,ct)={bt_cat(ct,:)};
			end
			BT_lon(identloop,1:size(bt_lon,2))=bt_lon;BT_land(identloop,1:size(bt_lon,2))=bt_land;
			BT_lat(identloop,1:size(bt_lat,2))=bt_lat;
			BT_maxspd(identloop,1:size(bt_maxspd,2))=bt_maxspd;
			BT_minpres(identloop,1:size(bt_minpres,2))=bt_minpres;                
			BT_ne34(identloop,1:size(bt_lon,2))=bt_ne34;
			BT_ne50(identloop,1:size(bt_lon,2))=bt_ne50;
			BT_ne64(identloop,1:size(bt_lon,2))=bt_ne64;
			BT_se34(identloop,1:size(bt_lon,2))=bt_se34;
			BT_se50(identloop,1:size(bt_lon,2))=bt_se50;
			BT_se64(identloop,1:size(bt_lon,2))=bt_se64;
			BT_sw34(identloop,1:size(bt_lon,2))=bt_sw34;
			BT_sw50(identloop,1:size(bt_lon,2))=bt_sw50;
			BT_sw64(identloop,1:size(bt_lon,2))=bt_sw64;
			BT_nw34(identloop,1:size(bt_lon,2))=bt_nw34;
			BT_nw50(identloop,1:size(bt_lon,2))=bt_nw50;
			BT_nw64(identloop,1:size(bt_lon,2))=bt_nw64;
			BT_po(identloop,1:size(bt_lon,2))=bt_po;
			BT_ro(identloop,1:size(bt_lon,2))=bt_ro;
			BT_rmw(identloop,1:size(bt_lon,2))=bt_rmw; 
			BT_intch(identloop,1:size(bt_lon,2))=bt_intch; 
			BT_shr(identloop,1:size(bt_lon,2))=bt_shr; 
			EXP_lon(identloop,1:size(exp_lon,1),:)=exp_lon;EXP_land(identloop,1:size(exp_land,1),:)=exp_land;
			EXP_lat(identloop,1:size(exp_lat,1),:)=exp_lat;
			EXP_maxspd(identloop,1:size(exp_maxspd,1),:)=exp_maxspd;
			EXP_minpres(identloop,1:size(exp_minpres,1),:)=exp_minpres;
			EXP_ne34(identloop,1:size(exp_lon,1),:)=exp_ne34;
			EXP_ne50(identloop,1:size(exp_lon,1),:)=exp_ne50;
			EXP_ne64(identloop,1:size(exp_lon,1),:)=exp_ne64;
			EXP_se34(identloop,1:size(exp_lon,1),:)=exp_se34;
			EXP_se50(identloop,1:size(exp_lon,1),:)=exp_se50;
			EXP_se64(identloop,1:size(exp_lon,1),:)=exp_se64;
			EXP_sw34(identloop,1:size(exp_lon,1),:)=exp_sw34;
			EXP_sw50(identloop,1:size(exp_lon,1),:)=exp_sw50;
			EXP_sw64(identloop,1:size(exp_lon,1),:)=exp_sw64;
			EXP_nw34(identloop,1:size(exp_lon,1),:)=exp_nw34;
			EXP_nw50(identloop,1:size(exp_lon,1),:)=exp_nw50;
			EXP_nw64(identloop,1:size(exp_lon,1),:)=exp_nw64;
			EXP_po(identloop,1:size(exp_lon,1),:)=exp_po;
			EXP_ro(identloop,1:size(exp_lon,1),:)=exp_ro;
			EXP_rmw(identloop,1:size(exp_lon,1),:)=exp_rmw;   
			EXP_intch(identloop,1:size(exp_lon,1),:)=exp_intch;   
			EXP_shr(identloop,1:size(exp_lon,1),:)=exp_shr;   
			% Across- and Along-Track Errors
			for exp=1:size(identexp,1)
				for acal=2:size(bt_lon,2)
					% Set points
					bt_lonn1=bt_lon(acal-1);
					bt_latn1=bt_lat(acal-1);
					bt_lon0=bt_lon(acal);
					bt_lat0=bt_lat(acal);       
					exp_lon0=exp_lon(acal,exp);
					exp_lat0=exp_lat(acal,exp);
					% Fine perpendicular coordinates from point to line                
					a = [bt_lonn1, bt_latn1]; %line - x1
					b = [bt_lon0, bt_lat0]; % line - x2
					c = [exp_lon0, exp_lat0]; %point - x0
					ab = b - a; %// Find x2 - x1
					%// -(x1 - x0).(x2 - x1) / (|x2 - x1|^2)
					t = -(a - c)*(ab.') / (ab*ab.'); %// Calculate t
					%// Find point of intersection
					Xinter = a + (b - a)*t;
					int_lon0=Xinter(1);
					int_lat0=Xinter(2);            
					% BT0 to GH0 (hypotenuse)
					dist_BT0GH0=deg2km(distance('gc',[bt_lat0,bt_lon0],[exp_lat0,exp_lon0]));
					dist_BTn1int0=deg2km(distance('gc',[bt_latn1,bt_lonn1],[int_lat0,int_lon0]));
					dist_BTn1BT0=deg2km(distance('gc',[bt_latn1,bt_lonn1],[bt_lat0,bt_lon0]));
					% Across-Track Error: GH0 to intersection point
					XTE=deg2km(distance('gc',[int_lat0,int_lon0],[exp_lat0,exp_lon0]));                     
					% Position Left Right:
					% if value > 0, p2 is on the left side of the line.
					% if value = 0, p2 is on the same line.
					% if value < 0, p2 is on the right side of the line.
					value = (bt_lon0 - bt_lonn1).*(exp_lat0 - bt_latn1) - (exp_lon0 - bt_lonn1).*(bt_lat0 - bt_latn1);
					if value > 0
					   XTE=XTE*-1;
					end
					% Along-Track Error
					ATE=deg2km(distance('gc',[bt_lat0,bt_lon0],[int_lat0,int_lon0]));
					% Distance from n1 to int and n1 to bt0. which is longer? 
					if dist_BTn1BT0 > dist_BTn1int0
					   ATE=-1.*ATE; 
					end        
					ateerr_exp(identloop,acal,exp)=ATE;
					xteerr_exp(identloop,acal,exp)=XTE;
				end
			end                
			if identgraphicsbycycle==1
				% Plot Tracks
				for plt_trk=1
						set(0,'defaultfigurecolor',[1 1 1]) % figure background color
						hfig=figure; clear l;
						set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
						ax1=subplot(3,4,[1:8]);
						h=fill([200,-200,-200,200],[-90,-90,90,90],[.5 .8 1]);
						hold on                                           
						geoshow('borders.shp','FaceColor',[0.9 0.9 0.9]);
						hold on
						states = shaperead('usastatehi', 'UseGeoCoords', true);
						geoshow(states,'FaceColor',[0.9 0.9 0.9]);
						tmpminlat=min([bt_lat(:); exp_lat(:)]);
						tmpmaxlat=max([bt_lat(:); exp_lat(:)]);
						tmpminlon=min([bt_lon(:); exp_lon(:)]);
						tmpmaxlon=max([bt_lon(:); exp_lon(:)]);
						xlim([tmpminlon-5 tmpmaxlon+5])
						ylim([tmpminlat-5 tmpmaxlat+5])
						xlabel('Longitude','fontsize',20)
						ylabel('Latitude','fontsize',20)                                   
						set(gca,'fontsize',20)
						l(2)=plot(bt_lon(1:skip:end),bt_lat(1:skip:end),'-sk','markerfacecolor','k','markersize',2,'linewidth',2);
						for tmptmp=1:size(exp_lon,1)
							if mod(exp_fhr(tmptmp),24)==0
								l(1)=plot(bt_lon(tmptmp),bt_lat(tmptmp),'o','markerfacecolor','w','markeredgecolor','k','markersize',6);                       
							end
						end
						for tmp=1:size(identexp,1)
							l(tmp+2)=plot(exp_lon(1:skip:end,tmp),exp_lat(1:skip:end,tmp),'-s','Color',identexpcolors(tmp,:),'markerfacecolor',identexpcolors(tmp,:),'markersize',2,'linewidth',2);                       
							for tmptmp=1:size(exp_lon,1)
								if mod(exp_fhr(tmptmp),24)==0
									l(1)=plot(exp_lon(tmptmp,tmp),exp_lat(tmptmp,tmp),'o','markerfacecolor','w','markeredgecolor','k','markersize',6);                       
								end
							end
						end												
						hold off                        
						lh=legend(l,[['t=0:24:',num2str(identmaxfhr*3-3),' h'], 'BT',identexpshort'],'location','northeast');
						lh.FontSize=10;
						set(gca,'plotboxaspectratio',[1 1 1])
						set(gcf, 'InvertHardcopy', 'off')
						set(gcf,'Units','inches');
						screenposition = get(gcf,'Position');
						set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
						set(gcf, 'InvertHardcopy', 'off')           
						text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
						text(0,1.065,['\textbf{Track Comparision}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
						text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
						ax=gca;
						box on
						set(ax, 'Layer', 'top')
						ax.LineWidth=1; 
						set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
						set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
						f = getframe(hfig);
						if identeps==1;filename=[identtrackint,'/FULL/trkcomp_',identinittimesunique(identloop,:)];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
						close all 
				end
				% Plot MaxSpd
				for plt_spd=1
					set(0,'defaultfigurecolor',[1 1 1]) % figure background color
					hfig=figure; clear l;
					set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
					ax1=subplot(3,4,[1:8]);                        
					tmp_bt=bt_maxspd(1:skip:end);
					tmp_exp=exp_maxspd(1:skip:end,:);
					% Y=[17,33-17,43-33,50-43,58-49,69-58,140-70];m/s
					Y=[34,64-34,83-64,96-83,113-96,137-113,200-137]./1.94384; %m/s
					Y=repmat(Y,identmaxfhr,1);    
					h=area(1:identmaxfhr,Y);
					h(1).FaceColor=[0 0.4470 0.7410];
					h(2).FaceColor=[0.3010 0.7450 0.9330];
					h(3).FaceColor=[0.4660 0.6740 0.1880];
					h(4).FaceColor=[0.9290 0.6940 0.1250];
					h(5).FaceColor=[0.8500 0.3250 0.0980];
					h(6).FaceColor=[.7 0.2 0.2];
					h(7).FaceColor=[.5 .2 .5];    
					alpha(0.25)
					hold on                      
					xlabel('Forecast Lead Time (h)','fontsize',20)        
					ylabel('Wind Speed (m/s)','fontsize',20)            
					set(gca,'fontsize',20)
					box on
					if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
						if mod(identmaxfhr*3,12)==0
							xlim([1 ((identmaxfhr*3))/skiphr+1])
						else
							xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
						end
					else
						if mod(identmaxfhr*3-3,12)==0
							xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
						else
							xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
						end
					end    
					ylim([0 100])
					set(gca,'xtick',1:skiptick:50)
					set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
					set(gca,'fontsize',20)
					l(1)=plot(tmp_bt,'-sk','markerfacecolor','k','markersize',2,'linewidth',2);
					for tmp=1:size(identexp,1)
						l(tmp+1)=plot(tmp_exp(:,tmp),'-s','Color',identexpcolors(tmp,:),'markerfacecolor',identexpcolors(tmp,:),'markersize',2,'linewidth',2);
					end
					hold off                        
					lh=legend(l,['BT',identexpshort'],'location','northeast');
					lh.FontSize=10;
					set(gca,'plotboxaspectratio',[1 1 1])
					set(gcf, 'InvertHardcopy', 'off')
					set(gcf,'Units','inches');
					screenposition = get(gcf,'Position');
					set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
					set(gcf, 'InvertHardcopy', 'off')    
					grid on
					set(gca,'gridcolor','k','gridalpha',.15)                               
					text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
					text(0,1.065,['\textbf{Wind Speed Comparision (m/s)}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
					text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
					ax=gca;
					box on
					set(ax, 'Layer', 'bottom')
					ax.LineWidth=1; 
					set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
					set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
					f = getframe(hfig);
					if identeps==1;filename=[identtrackint,'/FULL/spdcomp_',identinittimesunique(identloop,:)];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
					close all 
				end
				% Plot Pres, RTSF/50/64 all quadrants, PO, RO, RMW
				for plt_trk=1
					for pltcomp=1:18 
						clear l
						set(0,'defaultfigurecolor',[1 1 1]) % figure background color
						hfig=figure;
						set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
						ax1=subplot(3,4,[1:8]);                        
						if pltcomp==1
							tmp_name='prs';
							tmp_title='Pressure Comparision (hPa)';
							tmp_bt=bt_minpres(1:skip:end);
							tmp_exp=exp_minpres(1:skip:end,:);
							ylabel('Pressure (hPa)','fontsize',20)            
							ylim([880 1050])
						elseif pltcomp==2
							tmp_name='neRTSF';
							tmp_title='RTSF NEQ Comparision (km)';
							tmp_bt=bt_ne34(1:skip:end);
							tmp_exp=exp_ne34(1:skip:end,:);
							ylabel('Radius (km)','fontsize',20)            
							ylim([0 600])
						elseif pltcomp==3
							tmp_name='seRTSF';
							tmp_title='RTSF SEQ Comparision (km)';
							tmp_bt=bt_se34(1:skip:end);
							tmp_exp=exp_se34(1:skip:end,:);
							ylabel('Radius (km)','fontsize',20)            
							ylim([0 600])
						elseif pltcomp==4
							tmp_name='nwRTSF';
							tmp_title='RTSF NWQ Comparision (km)';
							tmp_bt=bt_nw34(1:skip:end);
							tmp_exp=exp_nw34(1:skip:end,:);
							ylabel('Radius (km)','fontsize',20)            
							ylim([0 600])
						elseif pltcomp==5
							tmp_name='swRTSF';
							tmp_title='RTSF SWQ Comparision (km)';
							tmp_bt=bt_sw34(1:skip:end);
							tmp_exp=exp_sw34(1:skip:end,:);
							ylabel('Radius (km)','fontsize',20)            
							ylim([0 600])
						elseif pltcomp==6
							tmp_name='neRSF';
							tmp_title='RSF NEQ Comparision (km)';
							tmp_bt=bt_ne50(1:skip:end);
							tmp_exp=exp_ne50(1:skip:end,:);
							ylabel('Radius (km)','fontsize',20)            
							ylim([0 300])
						elseif pltcomp==7
							tmp_name='seRSF';
							tmp_title='RSF SEQ Comparision (km)';
							tmp_bt=bt_se50(1:skip:end);
							tmp_exp=exp_se50(1:skip:end,:);
							ylabel('Radius (km)','fontsize',20)            
							ylim([0 300])
						elseif pltcomp==8
							tmp_name='nwRSF';
							tmp_title='RSF NWQ Comparision (km)';
							tmp_bt=bt_nw50(1:skip:end);
							tmp_exp=exp_nw50(1:skip:end,:);
							ylabel('Radius (km)','fontsize',20)            
							ylim([0 300])
						elseif pltcomp==9
							tmp_name='swRSF';
							tmp_title='RSF SWQ Comparision (km)';
							tmp_bt=bt_sw50(1:skip:end);
							tmp_exp=exp_sw50(1:skip:end,:);
							ylabel('Radius (km)','fontsize',20)            
							ylim([0 300])
					   elseif pltcomp==10
							tmp_name='neRHF';
							tmp_title='RHF NEQ Comparision (km)';
							tmp_bt=bt_ne64(1:skip:end);
							tmp_exp=exp_ne64(1:skip:end,:);
							ylabel('Radius (km)','fontsize',20)            
							ylim([0 150])
						elseif pltcomp==11
							tmp_name='seRHF';
							tmp_title='RHF SEQ Comparision (km)';
							tmp_bt=bt_se64(1:skip:end);
							tmp_exp=exp_se64(1:skip:end,:);
							ylabel('Radius (km)','fontsize',20)            
							ylim([0 150])
						elseif pltcomp==12
							tmp_name='nwRHF';
							tmp_title='RHF NWQ Comparision (km)';
							tmp_bt=bt_nw64(1:skip:end);
							tmp_exp=exp_nw64(1:skip:end,:);
							ylabel('Radius (km)','fontsize',20)            
							ylim([0 150])
						elseif pltcomp==13
							tmp_name='swRHF';
							tmp_title='RHF SWQ Comparision (km)';
							tmp_bt=bt_sw64(1:skip:end);
							tmp_exp=exp_sw64(1:skip:end,:);
							ylabel('Radius (km)','fontsize',20)            
							ylim([0 150])
						elseif pltcomp==14
							tmp_name='po';
							tmp_title='Outer Clsd Isbr Prs Comparision (hPa)';
							tmp_bt=bt_po(1:skip:end);
							tmp_exp=exp_po(1:skip:end,:);
							ylabel('Pressure (hPa)','fontsize',20)            
							ylim([880 1050]) 
						elseif pltcomp==15
							tmp_name='ro';
							tmp_title='Outer Clsd Isbr Rad Comparision (km)';
							tmp_bt=bt_ro(1:skip:end);
							tmp_exp=exp_ro(1:skip:end,:);
							ylabel('Radius (km)','fontsize',20)            
							ylim([0 600])
						elseif pltcomp==16
							tmp_name='rmw';
							tmp_title='RMW Comparison (km)';
							tmp_bt=bt_rmw(1:skip:end);
							tmp_exp=exp_rmw(1:skip:end,:);
							ylabel('Radius (km)','fontsize',20)            
							ylim([0 400])
						elseif pltcomp==17
							tmp_name='ate';
							tmp_title='Along-Track Error Comparison (km)';
							tmp_bt=nan(1,22);
							tmp_exp=squeeze(ateerr_exp(identloop,1:skip:end,:));
							ylabel('Error (km)','fontsize',20)            
							ylim([-500 500])
						elseif pltcomp==18
							tmp_name='xte';
							tmp_title='Across-Track Error Comparison (km)';
							tmp_bt=nan(1,22);
							tmp_exp=squeeze(xteerr_exp(identloop,1:skip:end,:));
							ylabel('Error (km)','fontsize',20)            
							ylim([-500 500])
						elseif plt==19
							tmp_name='RTSF';
							tmp_title='RTSF Comparision (km)';
							tmp_bt=cat(1,bt_ne34(:,1:skip:end,:),bt_nw34(:,1:skip:end,:),bt_se34(:,1:skip:end,:),bt_sw34(:,1:skip:end,:));
							tmp_exp=cat(1,exp_ne34(:,1:skip:end,:),exp_nw34(:,1:skip:end,:),exp_se34(:,1:skip:end,:),exp_sw34(:,1:skip:end,:));
							ylabel('Radius (km)','fontsize',20)            
							ylim([0 150]) 
						elseif plt==20
							tmp_name='RSF';
							tmp_title='RSF Comparision (km)';
							tmp_bt=cat(1,bt_ne50(:,1:skip:end,:),bt_nw50(:,1:skip:end,:),bt_se50(:,1:skip:end,:),bt_sw50(:,1:skip:end,:));
							tmp_exp=cat(1,exp_ne50(:,1:skip:end,:),exp_nw50(:,1:skip:end,:),exp_se50(:,1:skip:end,:),exp_sw50(:,1:skip:end,:));
							ylabel('Radius (km)','fontsize',20)            
							ylim([0 150]) 
						elseif plt==21                           
							tmp_name='RHF';
							tmp_title='RHF Comparision (km)';
							tmp_bt=cat(1,bt_ne64(:,1:skip:end,:),bt_nw64(:,1:skip:end,:),bt_se64(:,1:skip:end,:),bt_sw64(:,1:skip:end,:));
							tmp_exp=cat(1,exp_ne64(:,1:skip:end,:),exp_nw64(:,1:skip:end,:),exp_se64(:,1:skip:end,:),exp_sw64(:,1:skip:end,:));
							ylabel('Radius (km)','fontsize',20)            
							ylim([0 150])                    
						end                       
						xlabel('Forecast Lead Time (h)','fontsize',20)        
						set(gca,'fontsize',20)
						box on
						if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
							if mod(identmaxfhr*3,12)==0
								xlim([1 ((identmaxfhr*3))/skiphr+1])
							else
								xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
							end
						else
							if mod(identmaxfhr*3-3,12)==0
								xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
							else
								xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
							end
						end    
						set(gca,'xtick',1:skiptick:50)
						set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
						set(gca,'fontsize',20)
						hold on
						if pltcomp>16
							plot(0:100,zeros(1,101),'Color',[.5 .5 .5],'linewidth',1);
							for tmp=1:size(identexp,1)
								l(tmp)=plot(tmp_exp(:,tmp),'-s','Color',identexpcolors(tmp,:),'markerfacecolor',identexpcolors(tmp,:),'markersize',2,'linewidth',2);
							end
							lh=legend(l,identexpshort','location','northeast');
						else
							l(1)=plot(tmp_bt,'-sk','markerfacecolor','k','markersize',2,'linewidth',2);
							for tmp=1:size(identexp,1)
								l(tmp+1)=plot(tmp_exp(:,tmp),'-s','Color',identexpcolors(tmp,:),'markerfacecolor',identexpcolors(tmp,:),'markersize',2,'linewidth',2);
							end
							lh=legend(l,['BT',identexpshort'],'location','northeast');
						end
						lh.FontSize=10;
						hold off
						set(gca,'plotboxaspectratio',[1 1 1])
						set(gcf, 'InvertHardcopy', 'off')
						set(gcf,'Units','inches');
						screenposition = get(gcf,'Position');
						set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
						set(gcf, 'InvertHardcopy', 'off')
						% Missing Data Flags
						tmpflag=[sum(~isnan(tmp_exp))];                        
						tmpstrname=identexpshort(find(tmpflag==0));
						tmpstrcolor=identexpcolors(find(tmpflag==0),:);
						tmpstr=['Unavailable: '];
						if sum(~isnan(tmp_bt))==0 && size(tmpstrname,1)==0
							tmpstr=[tmpstr, 'BT'];
						elseif sum(~isnan(tmp_bt))==0 && size(tmpstrname,1)>0
							tmpstr=[tmpstr,'BT, '];                        
						end                            
						for tmp=1:size(tmpstrname,1)
							if tmp==size(tmpstrname,1)
								tmpstr=[tmpstr, '\color[rgb]{',num2str(tmpstrcolor(tmp,:)),'}',tmpstrname{tmp}];
							else
								tmpstr=[tmpstr, '\color[rgb]{',num2str(tmpstrcolor(tmp,:)),'}',tmpstrname{tmp},'\color[rgb]{0 0 0}, '];
							end
						end 
						if sum(~isnan(tmp_bt))>0 && size(tmpstrname,1)==0
							tmpstr='';
						end
						% Finish Plot
						if pltcomp==17
							 tx=text(0.02,0.05,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
							 tx=text(0.02,0.98,'Faster than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
						elseif pltcomp==18
							 tx=text(0.02,0.05,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
							 tx=text(0.02,0.98,'Right of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
						end
						grid on
						set(gca,'gridcolor','k','gridalpha',.15)
						text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
						text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
						text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
						set(gca,'Color',[.9 .9 .9])
						ax=gca;
						box on
						set(ax, 'Layer', 'bottom')
						if pltcomp>16
						else
							tx=text(0.98,0.05,tmpstr,'HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
							set(tx, 'Layer', 'front')
						end
						ax.LineWidth=1; 
						set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
						set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
						set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
						f = getframe(hfig);
						if identeps==1;filename=[identtrackint,'/FULL/',tmp_name,'comp_',identinittimesunique(identloop,:)];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
						close all                        
					end
				end
			else
			end
			%% Find errors - ALL init times                
			for tmp=1:size(identexp,1)
				trkerr_exp(identloop,1:initsize,tmp)=(deg2km(distance('gc',bt_lat,bt_lon,exp_lat(:,tmp)',exp_lon(:,tmp)')));
				trkerr_sz=max(size(bt_lat,2),trkerr_sz);
				interr_exp(identloop,1:initsize,tmp)=(exp_minpres(:,tmp)-bt_minpres');
				spderr_exp(identloop,1:initsize,tmp)=(exp_maxspd(:,tmp)-bt_maxspd');
				ne34err_exp(identloop,1:initsize,tmp)=(exp_ne34(:,tmp)-bt_ne34');
				se34err_exp(identloop,1:initsize,tmp)=(exp_se34(:,tmp)-bt_se34');
				sw34err_exp(identloop,1:initsize,tmp)=(exp_sw34(:,tmp)-bt_sw34');
				nw34err_exp(identloop,1:initsize,tmp)=(exp_nw34(:,tmp)-bt_nw34');
				ne50err_exp(identloop,1:initsize,tmp)=(exp_ne50(:,tmp)-bt_ne50');
				se50err_exp(identloop,1:initsize,tmp)=(exp_se50(:,tmp)-bt_se50');
				sw50err_exp(identloop,1:initsize,tmp)=(exp_sw50(:,tmp)-bt_sw50');
				nw50err_exp(identloop,1:initsize,tmp)=(exp_nw50(:,tmp)-bt_nw50');
				ne64err_exp(identloop,1:initsize,tmp)=(exp_ne64(:,tmp)-bt_ne64');
				se64err_exp(identloop,1:initsize,tmp)=(exp_se64(:,tmp)-bt_se64');
				sw64err_exp(identloop,1:initsize,tmp)=(exp_sw64(:,tmp)-bt_sw64');
				nw64err_exp(identloop,1:initsize,tmp)=(exp_nw64(:,tmp)-bt_nw64');            
				poerr_exp(identloop,1:initsize,tmp)=(exp_po(:,tmp)-bt_po');
				roerr_exp(identloop,1:initsize,tmp)=(exp_ro(:,tmp)-bt_ro');
				rmwerr_exp(identloop,1:initsize,tmp)=(exp_rmw(:,tmp)-bt_rmw');
			end
		end
	end

	run customcolorbars
	if strcmp(identcycles,'all')==0
		disp('You did not request that all available cycles be used...not creating all-cycles graphics...')
	elseif sum(~isnan(EXP_lat(:)))>0
		if identcompositeonly==0
			% All Track
			for fhr=1:size(identexp,1)
				clear l tmp
				set(0,'defaultfigurecolor',[1 1 1]) % figure background color
				hfig=figure;
				set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
				ax1=subplot(3,4,[1:8]);
				h=fill([200,-200,-200,200],[-90,-90,90,90],[.5 .8 1]);
				hold on                                           
				geoshow('borders.shp','FaceColor',[0.9 0.9 0.9]);
				hold on
				states = shaperead('usastatehi', 'UseGeoCoords', true);
				geoshow(states,'FaceColor',[0.9 0.9 0.9]);
				tmpminlat=min([BT_lat(:); EXP_lat(:)]);
				tmpmaxlat=max([BT_lat(:); EXP_lat(:)]);
				tmpminlon=min([BT_lon(:); EXP_lon(:)]);
				tmpmaxlon=max([BT_lon(:); EXP_lon(:)]);      
				xlim([tmpminlon-5 tmpmaxlon+5])
				ylim([tmpminlat-5 tmpmaxlat+5])
				xlabel('Longitude','fontsize',20)
				ylabel('Latitude','fontsize',20)                                   
				set(gca,'fontsize',20)    
				tmp_explon=EXP_lon(:,1:skip:end,fhr);
				tmp_explat=EXP_lat(:,1:skip:end,fhr);
				tmp_btlon=BT_lon(:,1:skip:end);      
				tmp_btlat=BT_lat(:,1:skip:end);      
				tmp=find(sum(isnan(tmp_explon'))'<size(tmp_explon,2)); % eliminate all fhr = nan
				% Make Gradient Colorbar
				clear cmtmp cm
				cnt=1;
				for cmtmp1=4:10
					cmtmp(cnt,:)=((identexpcolors(fhr,:)*255)*(cmtmp1/10))/255;
					cnt=cnt+1;
				end
				for cmtmp1=1:9
						cmtmp(cnt,:)=((identexpcolors(fhr,:)*255)+(([255 255 255]-(identexpcolors(fhr,:)*255))*(cmtmp1/10)))/255;
						cnt=cnt+1;
				end            
				cmp=sum(~isnan(nanmean(tmp_explon,2)));
				cm=colormap(custommap(cmp,flipud(cmtmp)));             
				for i=tmp(1):size(cm,1)
					plot(tmp_explon(i,:)',tmp_explat(i,:)','-s','Color',cm(i,:),'markerfacecolor',cm(i,:),'markersize',2,'linewidth',1);
				end
				plot(tmp_btlon',tmp_btlat','-sk','markerfacecolor','k','markersize',2,'linewidth',2);
				for i=tmp(1):size(cm,1)
					plot(tmp_explon(i,1)',tmp_explat(i,1)','o','Color','k','markerfacecolor',cm(i,:),'markersize',5,'linewidth',1);       
				end
				l(3)=plot([0 0],[-90 -89],'o','Color','k','markerfacecolor','w','markersize',5,'linewidth',1);
				l(2)=plot([0 0],[-90 -89],'-s','Color',identexpcolors(fhr,:),'markerfacecolor',identexpcolors(fhr,:),'markersize',2,'linewidth',1);   
				identexp0=identexpshort(fhr,:);            
				l(1)=plot([0 0],[-90 -89],'-sk','markerfacecolor','k','markersize',2,'linewidth',2);
				hold off
				lh=legend(l,['BT',identexp0','0 h'],'location','northeast');
				lh.FontSize=10;
				set(gca,'plotboxaspectratio',[1 1 1])
				set(gcf, 'InvertHardcopy', 'off')
				set(gcf,'Units','inches');
				screenposition = get(gcf,'Position');
				set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
				set(gcf, 'InvertHardcopy', 'off')
				text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
				text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
				text(0,1.065,['\textbf{Track Comparision}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
				cl=colorbar;
				if size(identinittimesunique,1)>50
					set(cl,'YTick',1/size(tmp,1)/2:4/size(tmp,1):1,'fontsize',20)
					set(cl,'YTicklabel',1:4:size(tmp,1))
				else
					set(cl,'YTick',1/size(tmp,1)/2:2/size(tmp,1):1,'fontsize',20)
					set(cl,'YTicklabel',1:2:size(tmp,1))
				end
				ax=gca;
				box on
				set(ax, 'Layer', 'top')
				ax.LineWidth=1; 
				set(gca,'position',spPos)
				set(cl,'position',clPos)
				set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
				f = getframe(hfig);
				if identeps==1;filename=[identtrackint,'/FULL/trkcomp_all_',identexp{fhr}];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
				close all 
			end
			% All Wind Speed
			for fhr=1:size(identexp,1)
				clear EXPmx BTmx l tmp
				set(0,'defaultfigurecolor',[1 1 1]) % figure background color
				hfig=figure;
				set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
				ax1=subplot(3,4,[1:8]);                        
				Y=[34,64-34,83-64,96-83,113-96,137-113,200-137]./1.94384; %m/s
				Y=repmat(Y,240,1);    
				h=area(1:240,Y);
				h(1).FaceColor=[0 0.4470 0.7410];
				h(2).FaceColor=[0.3010 0.7450 0.9330];
				h(3).FaceColor=[0.4660 0.6740 0.1880];
				h(4).FaceColor=[0.9290 0.6940 0.1250];
				h(5).FaceColor=[0.8500 0.3250 0.0980];
				h(6).FaceColor=[.7 0.2 0.2];
				h(7).FaceColor=[.5 .2 .5];                        
				alpha(0.25)
				hold on       
				ylabel('Wind Speed (m/s)','fontsize',20)            
				set(gca,'fontsize',20)
				box on                        
				ylim([0 100])
				set(gca,'fontsize',20)                        
				tmp_exp=EXP_maxspd(:,1:skip:end,fhr);
				tmp_bt=BT_maxspd(:,1);                  
				% stagger
				tmp=find(sum(isnan(tmp_explon'))'<size(tmp_explon,2)); % eliminate all fhr = nan
				cnt=1;
				for i=tmp(1):size(EXP_maxspd,1)
					EXPmx(i,cnt:cnt-1+size(tmp_exp(i,:),2))=tmp_exp(i,:);
					cnt=cnt+1;
				end
				BTmx=tmp_bt;
				EXPmx(EXPmx==0)=NaN;
				tmpsz=size(EXPmx,2)*6;
				if mod(tmpsz,skiphr)==0  % xrange to nearest tickmark
					if mod(tmpsz,12)==0
						xlim([1 tmpsz/6+2])
					else
						xlim([1 (tmpsz/6+(12-mod(tmpsz,12)))]) 
					end
				else
					if mod(tmpsz-3,12)==0
						xlim([1 (tmpsz-6)/6])
					else
						xlim([1 (tmpsz-6)/6+(12-mod(tmpsz-3,12))]) 
					end
				end                      
				tmpdt=50;
				t1 = datetime(str2num(identinittimesunique(tmp(1),1:4)),str2num(identinittimesunique(tmp(1),5:6)),str2num(identinittimesunique(tmp(1),7:8)),str2num(identinittimesunique(tmp(1),9:10)),0,0,'format','yyyyMMddhh');
				t2 = datetime(str2num(identinittimesunique(end,1:4)),str2num(identinittimesunique(end,5:6)),str2num(identinittimesunique(end,7:8))+ceil(tmpdt),str2num(identinittimesunique(end,9:10)),0,0,'format','yyyyMMddhh');
				identinittimesunique2=datestr(t1:hours(6):t2,'yyyymmddhh');
				if strcmp(identinittimesunique2((1),9:10),'00')==1
					tmpst=(1);
				elseif strcmp(identinittimesunique2((2),9:10),'00')==1
					tmpst=(2);
				elseif strcmp(identinittimesunique2((3),9:10),'00')==1
					tmpst=(3);
				elseif strcmp(identinittimesunique2((4),9:10),'00')==1
					tmpst=(4);
				end                        
				if size(EXPmx,2)>80
						set(gca,'xtick',tmpst:8:240)
						tmpxlab1=[identinittimesunique2((tmpst):8:end,5:8)];
						for i=1:size((tmpst):8:size(identinittimesunique2,1),2)
							tmpxlab(i,:)=[tmpxlab1(i,1:2),'/',tmpxlab1(i,3:4)];
						end 
				else
						set(gca,'xtick',tmpst:4:240)
						tmpxlab1=[identinittimesunique2((tmpst):4:end,5:8)];
						for i=1:size((tmpst):4:size(identinittimesunique2,1),2)
							tmpxlab(i,:)=[tmpxlab1(i,1:2),'/',tmpxlab1(i,3:4)];
						end 
				end 
				set(gca,'xticklabel',tmpxlab)                                    
				grid on
				set(gca,'gridcolor','k','gridalpha',.15)
				xtickangle(90)
				% Make Gradient Colorbar
				clear cmtmp cm
				cnt=1;
				for cmtmp1=4:10
					cmtmp(cnt,:)=((identexpcolors(fhr,:)*255)*(cmtmp1/10))/255;
					cnt=cnt+1;
				end
				for cmtmp1=1:9
					cmtmp(cnt,:)=((identexpcolors(fhr,:)*255)+(([255 255 255]-(identexpcolors(fhr,:)*255))*(cmtmp1/10)))/255;
					cnt=cnt+1;
				end
				cmp=sum(~isnan(nanmean(EXPmx,2)));
				cm=colormap(custommap(cmp,flipud(cmtmp))); 
				cnt=1;
				for i=tmp'
				   plot(EXPmx(i,:)','-s','Color',cm(cnt,:),'markerfacecolor',cm(cnt,:),'markersize',2,'linewidth',1);             
				   plot(i,EXPmx(i,i),'o','Color','k','markerfacecolor',cm(cnt,:),'markersize',5,'linewidth',1);       
				   l(2)=plot([0 0],[-90 -89],'-s','Color',identexpcolors(fhr,:),'markerfacecolor',identexpcolors(fhr,:),'markersize',2,'linewidth',1); 
				   cnt=cnt+1;
				end      
				plot(BTmx,'-sk','markerfacecolor','k','markersize',2,'linewidth',2);
				l(3)=plot([0 0],[-90 -89],'o','Color','k','markerfacecolor','w','markersize',5,'linewidth',1);
				l(1)=plot([0 0],[-90 -89],'-sk','markerfacecolor','k','markersize',2,'linewidth',2);
				identexp0=identexpshort(fhr,:);            
				lh=legend(l,['BT',identexp0','0 h'],'location','northeast','interpreter','none');
				lh.FontSize=10;
				set(gca,'plotboxaspectratio',[1 1 1])
				set(gcf, 'InvertHardcopy', 'off')
				set(gcf,'Units','inches');
				screenposition = get(gcf,'Position');
				set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
				set(gcf, 'InvertHardcopy', 'off')
				text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
				text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
				text(0,1.065,['\textbf{Wind Speed Comparision (m/s)}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
				cl=colorbar;
				if size(identinittimesunique,1)>50
					set(cl,'YTick',1/size(tmp,1)/2:4/size(tmp,1):1,'fontsize',20)
					set(cl,'YTicklabel',1:4:size(tmp,1))
				else
					set(cl,'YTick',1/size(tmp,1)/2:2/size(tmp,1):1,'fontsize',20)
					set(cl,'YTicklabel',1:2:size(tmp,1))
				end
				ax=gca;
				box on
				set(ax, 'Layer', 'top')
				ax.LineWidth=1; 
				set(gca,'position',spPos)
				set(cl,'position',clPos)
				set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
				f = getframe(hfig);
				if identeps==1;filename=[identtrackint,'/FULL/spdcomp_all_',identexp{fhr}];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
				close all 
			end
			% All Else
			for plt=1:18
				for fhr=1:size(identexp,1)
					clear EXPmx BTmx l tmp cmtmp cm
					set(0,'defaultfigurecolor',[1 1 1]) % figure background color
					hfig=figure;
					set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
					ax1=subplot(3,4,[1:8]);   
					hold on               
				   if plt==1
						tmp_exp=EXP_minpres(:,1:skip:end,fhr);
						tmp_bt=BT_minpres(:,1:skip:end);
						tmp_name='prscomp';
						tmp_title='Pressure Comparision (hPa)';
						tmp_ylab='Pressure (hPa)';
						ylim([880 1050])            
					 elseif plt==2
						tmp_exp=EXP_ne34(:,1:skip:end,fhr);
						tmp_bt=BT_ne34(:,1:skip:end);
						tmp_name='neRTSFcomp';
						tmp_title='RTSF NEQ Comparision (km)';
						tmp_ylab='Radius (km)';
						ylim([0 1000])            
					elseif plt==3
						tmp_exp=EXP_se34(:,1:skip:end,fhr);
						tmp_bt=BT_se34(:,1:skip:end);
						tmp_name='seRTSFcomp';
						tmp_title='RTSF SEQ Comparision (km)';
						tmp_ylab='Radius (km)';
						ylim([0 1000])            
					elseif plt==4
						tmp_exp=EXP_sw34(:,1:skip:end,fhr);
						tmp_bt=BT_sw34(:,1:skip:end);
						tmp_name='swRTSFcomp';
						tmp_title='RTSF SWQ Comparision (km)';
						tmp_ylab='Radius (km)';
						ylim([0 1000])            
					elseif plt==5
						tmp_exp=EXP_nw34(:,1:skip:end,fhr);
						tmp_bt=BT_nw34(:,1:skip:end);
						tmp_name='nwRTSFcomp';
						tmp_title='RTSF NWQ Comparision (km)';
						tmp_ylab='Radius (km)';
						ylim([0 1000])            
					elseif plt==6
						tmp_exp=EXP_ne50(:,1:skip:end,fhr);
						tmp_bt=BT_ne50(:,1:skip:end);
						tmp_name='neRSFcomp';
						tmp_title='RSF NEQ Comparision (km)';
						tmp_ylab='Radius (km)';
						ylim([0 500])            
					elseif plt==7
						tmp_exp=EXP_se50(:,1:skip:end,fhr);
						tmp_bt=BT_se50(:,1:skip:end);
						tmp_name='seRSFcomp';
						tmp_title='RSF SEQ Comparision (km)';
						tmp_ylab='Radius (km)';
						ylim([0 500])            
					elseif plt==8
						tmp_exp=EXP_sw50(:,1:skip:end,fhr);
						tmp_bt=BT_sw50(:,1:skip:end);
						tmp_name='swRSFcomp';
						tmp_title='RSF SWQ Comparision (km)';
						tmp_ylab='Radius (km)';
						ylim([0 500])            
					elseif plt==9
						tmp_exp=EXP_nw50(:,1:skip:end,fhr);
						tmp_bt=BT_nw50(:,1:skip:end);
						tmp_name='nwRSFcomp';
						tmp_title='RSF NWQ Comparision (km)';
						tmp_ylab='Radius (km)';
						ylim([0 500])            
					elseif plt==10
						tmp_exp=EXP_ne64(:,1:skip:end,fhr);
						tmp_bt=BT_ne64(:,1:skip:end);
						tmp_name='neRHFcomp';
						tmp_title='RHF NEQ Comparision (km)';
						tmp_ylab='Radius (km)';
						ylim([0 250])            
					elseif plt==11
						tmp_exp=EXP_se64(:,1:skip:end,fhr);
						tmp_bt=BT_se64(:,1:skip:end);
						tmp_name='seRHFcomp';
						tmp_title='RHF SEQ Comparision (km)';
						tmp_ylab='Radius (km)';
						ylim([0 250])            
					elseif plt==12
						tmp_exp=EXP_sw64(:,1:skip:end,fhr);
						tmp_bt=BT_sw64(:,1:skip:end);
						tmp_name='swRHFcomp';
						tmp_title='RHF SWQ Comparision (km)';
						tmp_ylab='Radius (km)';
						ylim([0 250])            
					elseif plt==13
						tmp_exp=EXP_nw64(:,1:skip:end,fhr);
						tmp_bt=BT_nw64(:,1:skip:end);
						tmp_name='nwRHFcomp';
						tmp_title='RHF NWQ Comparision (km)';
						tmp_ylab='Radius (km)';
						ylim([0 250])            
					elseif plt==14
						tmp_exp=EXP_po(:,1:skip:end,fhr);
						tmp_bt=BT_po(:,1:skip:end);
						tmp_name='pocomp';
						tmp_title='Outer Clsd Isbr Prs Error Comparison (hPa)';
						tmp_ylab='Pressure (hPa)';
						ylim([880 1050])            
					elseif plt==15
						tmp_exp=EXP_ro(:,1:skip:end,fhr);
						tmp_bt=BT_ro(:,1:skip:end);
						tmp_name='rocomp';
						tmp_title='Outer Clsd Isbr Rad Comparision (km)';
						tmp_ylab='Radius (km)';
						ylim([0 600])            
					elseif plt==16
						tmp_exp=EXP_rmw(:,1:skip:end,fhr);
						tmp_bt=BT_rmw(:,1:skip:end);
						tmp_name='rmwcomp';
						tmp_title='RMW Comparision (km)';
						tmp_ylab='Radius (km)';
						ylim([0 400])             
					elseif plt==17
						tmp_exp=ateerr_exp(:,1:skip:end,fhr);
						tmp_bt=nan(size(BT_rmw(:,1:skip:end)));
						tmp_name='atecomp';
						tmp_title='Along-Track Error Comparision (km)';
						tmp_ylab='Error (km)';
						ylim([-500 500])  
					elseif plt==18
						tmp_exp=xteerr_exp(:,1:skip:end,fhr);
						tmp_bt=nan(size(BT_rmw(:,1:skip:end)));
						tmp_name='xtecomp';
						tmp_title='Across-Track Error Comparision (km)';
						tmp_ylab='Error (km)';
						ylim([-500 500])  
				   elseif plt==19
						tmp_exp=cat(1,EXP_ne34(:,1:skip:end,:),EXP_nw34(:,1:skip:end,:),EXP_se34(:,1:skip:end,:),EXP_sw34(:,1:skip:end,:));
						tmp_name='RTSFcomp';
						tmp_title='RTSF Comparision (km)';
						tmp_ytitle='Error (km)';
						yrange=[0 200];
					elseif plt==20
						tmp_exp=cat(1,EXP_ne50(:,1:skip:end,:),EXP_nw50(:,1:skip:end,:),EXP_se50(:,1:skip:end,:),EXP_sw50(:,1:skip:end,:));
						tmp_name='RSFcomp';
						tmp_title='RSF Comparision (km)';
						tmp_ytitle='Error (km)';
						yrange=[0 200];
					elseif plt==21
						tmp_exp=cat(1,EXP_ne64(:,1:skip:end,:),EXP_nw64(:,1:skip:end,:),EXP_se64(:,1:skip:end,:),EXP_sw64(:,1:skip:end,:));
						tmp_name='RHFcomp';
						tmp_title='RHF Comparision (km)';
						tmp_ytitle='Error (km)';
						yrange=[0 200];    
				   end
				   if plt <17 && plt >18
						tmp_exp=abs(tmp_exp); % added for MAE
				   end                             
				   if plt>=17 && plt <=18
						plot(-10:89,zeros(1,100),'Color',[.5 .5 .5],'linewidth',2);
					end
					ylabel(tmp_ylab,'fontsize',20)
					set(gca,'fontsize',20)
					box on                                                   
					% stagger
					tmp=find(sum(isnan(tmp_explon'))'<size(tmp_explon,2)); % eliminate all fhr = nan
					cnt=1;
					for i=tmp(1):size(EXP_minpres,1)
						EXPmx(i,cnt:cnt-1+size(tmp_exp(i,:),2))=tmp_exp(i,:);
						cnt=cnt+1;
					end
					BTmx=tmp_bt(:,1);
					EXPmx(EXPmx==0)=NaN;
					tmpsz=size(EXPmx,2)*6;
					if mod(tmpsz,skiphr)==0  % xrange to nearest tickmark
						if mod(tmpsz,12)==0
							xlim([1 tmpsz/6+2])
						else
							xlim([1 (tmpsz/6+(12-mod(tmpsz,12)))]) 
						end
					else
						if mod(tmpsz-3,12)==0
							xlim([1 (tmpsz-6)/6])
						else
							xlim([1 (tmpsz-6)/6+(12-mod(tmpsz-3,12))]) 
						end
					end                               
					tmpdt=50;
					t1 = datetime(str2num(identinittimesunique(tmp(1),1:4)),str2num(identinittimesunique(tmp(1),5:6)),str2num(identinittimesunique(tmp(1),7:8)),str2num(identinittimesunique(tmp(1),9:10)),0,0,'format','yyyyMMddhh');
					t2 = datetime(str2num(identinittimesunique(end,1:4)),str2num(identinittimesunique(end,5:6)),str2num(identinittimesunique(end,7:8))+ceil(tmpdt),str2num(identinittimesunique(end,9:10)),0,0,'format','yyyyMMddhh');
					identinittimesunique2=datestr(t1:hours(6):t2,'yyyymmddhh');
					if strcmp(identinittimesunique2((1),9:10),'00')==1
						tmpst=(1);
					elseif strcmp(identinittimesunique2((2),9:10),'00')==1
						tmpst=(2);
					elseif strcmp(identinittimesunique2((3),9:10),'00')==1
						tmpst=(3);
					elseif strcmp(identinittimesunique2((4),9:10),'00')==1
						tmpst=(4);
					end                        
					if size(EXPmx,2)>80
						set(gca,'xtick',tmpst:8:240)
						tmpxlab1=[identinittimesunique2((tmpst):8:end,5:8)];
						for i=1:size((tmpst):8:size(identinittimesunique2,1),2)
							tmpxlab(i,:)=[tmpxlab1(i,1:2),'/',tmpxlab1(i,3:4)];
						end 
					else
						set(gca,'xtick',tmpst:4:240)
						tmpxlab1=[identinittimesunique2((tmpst):4:end,5:8)];
						for i=1:size((tmpst):4:size(identinittimesunique2,1),2)
							tmpxlab(i,:)=[tmpxlab1(i,1:2),'/',tmpxlab1(i,3:4)];
						end 
					end
					set(gca,'xticklabel',tmpxlab)                                    
					grid on
					set(gca,'gridcolor','k','gridalpha',.15)
					xtickangle(90)                
					% Make Gradient Colorbar
					clear cmtmp cm
					cnt=1;
					for cmtmp1=4:10
						cmtmp(cnt,:)=((identexpcolors(fhr,:)*255)*(cmtmp1/10))/255;
						cnt=cnt+1;
					end
					for cmtmp1=1:9
							cmtmp(cnt,:)=((identexpcolors(fhr,:)*255)+(([255 255 255]-(identexpcolors(fhr,:)*255))*(cmtmp1/10)))/255;
							cnt=cnt+1;
					end
					cmp=size(tmp,1);
					cm=colormap(custommap(cmp,flipud(cmtmp)));           
					cnt=1;
					for i=tmp'
					   plot(EXPmx(i,:)','-s','Color',cm(cnt,:),'markerfacecolor',cm(cnt,:),'markersize',2,'linewidth',1);             
					   plot(i,EXPmx(i,i),'o','Color','k','markerfacecolor',cm(cnt,:),'markersize',5,'linewidth',1);       
					   l(2)=plot([0 0],[-90 -89],'-s','Color',identexpcolors(fhr,:),'markerfacecolor',identexpcolors(fhr,:),'markersize',2,'linewidth',1); 
					   cnt=cnt+1;
					end   
					plot(BTmx,'-s','color','k','markersize',2,'markerfacecolor','k','linewidth',2);
					l(3)=plot([0 0],[-90 -89],'o','Color','k','markerfacecolor','w','markersize',5,'linewidth',1);
					l(1)=plot([0 0],[-90 -89],'-sk','markerfacecolor','k','markersize',2,'linewidth',2);
					identexp0=identexpshort(fhr,:);            
					if plt<17
					   lh=legend(l,['BT',identexp0','0 h'],'location','northeast','interpreter','none');
					else
						lh=legend(l(2:3),[identexp0','0 h'],'location','northeast','interpreter','none');
					end
					lh.FontSize=10;
					set(gca,'plotboxaspectratio',[1 1 1])
					set(gcf, 'InvertHardcopy', 'off')
					set(gcf,'Units','inches');
					screenposition = get(gcf,'Position');
					set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
					set(gcf, 'InvertHardcopy', 'off')
					text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
					text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
					text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
					% Missing Data Flags
					tmpflag=[sum(sum(~isnan(EXPmx)))];                        
					tmpst=identexp0;
					tmpstrname=tmpst(find(tmpflag==0),:);
					tmpstr=['Unavailable: '];
					if sum(sum(~isnan(BTmx)))==0 && size(tmpstrname,1)==0
						tmpstr=[tmpstr, 'BT'];
					elseif size(tmpstrname,1)>0
						tmpstr=[tmpstr,'BT, '];
						tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(fhr,:)),'}',tmpstrname{:}];
					end                            
					if sum(sum(~isnan(BTmx)))>0 && size(tmpstrname,1)==0
						tmpstr='';
					end
					cl=colorbar;
					tmp=find(sum(isnan(tmp_explon'))'<size(tmp_explon,2)); % eliminate all fhr = nan
					if size(identinittimesunique,1)>50
						set(cl,'YTick',1/size(tmp,1)/2:4/size(tmp,1):1,'fontsize',20)
						set(cl,'YTicklabel',1:4:size(tmp,1))
					else
						set(cl,'YTick',1/size(tmp,1)/2:2/size(tmp,1):1,'fontsize',20)
						set(cl,'YTicklabel',1:2:size(tmp,1))
					end
					ax=gca;
					box on
					set(ax, 'Layer', 'top')
					if plt<17
						tx=text(0.98,0.05,tmpstr,'HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
						set(tx, 'Layer', 'front')
					elseif plt==17
						tx=text(0.02,0.05,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
						tx=text(0.02,0.98,'Faster than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
						set(tx, 'Layer', 'front')            
					elseif plt==18
						tx=text(0.02,0.05,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
						tx=text(0.02,0.98,'Right of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
						set(tx, 'Layer', 'front')            
					end
					ax.LineWidth=1; 
					set(gca,'position',spPos)
					set(cl,'position',clPos)
					set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
					set(gca,'Color',[.9 .9 .9])
					f = getframe(hfig);
					if identeps==1;filename=[identtrackint,'/FULL/',tmp_name,'_all_',identexp{fhr}];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
					close all 
				end
			end
		end
	end
	
			if identcompositeonly==0 && sum(~isnan(EXP_lat(:)))>0
		% Create Graphics: Lag Corr
		%clear scfactor scfactor0
		for plt=[1:18,21:23]                                                  
			if plt==1
				 tmp_exp=trkerr_exp(:,1:skip:end,:);
				 tmp_name='trkerr';
				 tmp_title='Track Error (km)';
				 tmp_ytitle='Error (km)';
			elseif plt==2
				tmp_exp=interr_exp(:,1:skip:end,:);
				tmp_name='prserr';
				tmp_title='Pressure Error (hPa)';
				tmp_ytitle='Error (hPa)';
			elseif plt==3
				tmp_exp=spderr_exp(:,1:skip:end,:);
				tmp_name='spderr';
				tmp_title='Wind Speed Error (m/s)';
				tmp_ytitle='Error (m/s)';
			 elseif plt==4
				tmp_exp=ne34err_exp(:,1:skip:end,:);
				tmp_name='neRTSFerr';
				tmp_title='RTSF NEQ Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[0 200];
			elseif plt==5
				tmp_exp=se34err_exp(:,1:skip:end,:);
				tmp_name='seRTSFerr';
				tmp_title='RTSF SEQ Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[0 200];
			elseif plt==6
				tmp_exp=sw34err_exp(:,1:skip:end,:);
				tmp_name='swRTSFerr';
				tmp_title='RTSF SWQ Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[0 200];
			elseif plt==7
				tmp_exp=nw34err_exp(:,1:skip:end,:);
				tmp_name='nwRTSFerr';
				tmp_title='RTSF NWQ Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[0 200];
			elseif plt==8
				tmp_exp=ne50err_exp(:,1:skip:end,:);
				tmp_name='neRSFerr';
				tmp_title='RSF NEQ Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[0 200];
			elseif plt==9
				tmp_exp=se50err_exp(:,1:skip:end,:);
				tmp_name='seRSFerr';
				tmp_title='RSF SEQ Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[0 200];
			elseif plt==10
				tmp_exp=sw50err_exp(:,1:skip:end,:);
				tmp_name='swRSFerr';
				tmp_title='RSF SWQ Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[0 200];
			elseif plt==11
				tmp_exp=nw50err_exp(:,1:skip:end,:);
				tmp_name='nwRSFerr';
				tmp_title='RSF NWQ Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[0 200];
			elseif plt==12
				tmp_exp=ne64err_exp(:,1:skip:end,:);
				tmp_name='neRHFerr';
				tmp_title='RHF NEQ Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[0 200];
			elseif plt==13
				tmp_exp=se64err_exp(:,1:skip:end,:);
				tmp_name='seRHFerr';
				tmp_title='RHF SEQ Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[0 200];
			elseif plt==14
				tmp_exp=sw64err_exp(:,1:skip:end,:);
				tmp_name='swRHFerr';
				tmp_title='RHF SWQ Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[0 200];
			elseif plt==15
				tmp_exp=nw64err_exp(:,1:skip:end,:);
				tmp_name='nwRHFerr';
				tmp_title='RHF NWQ Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[0 200];
			elseif plt==16
				tmp_exp=poerr_exp(:,1:skip:end,:);
				tmp_name='poerr';
				tmp_title='Outer Clsd Isbr Prs Error (hPa)';
				tmp_ytitle='Error (hPa)';
			elseif plt==17
				tmp_exp=roerr_exp(:,1:skip:end,:);
				tmp_name='roerr';
				tmp_title='Outer Clsd Isbr Rad Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==18
				tmp_exp=rmwerr_exp(:,1:skip:end,:);
				tmp_name='rmwerr';
				tmp_title='RMW Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==19
				tmp_exp=ateerr_exp(:,1:skip:end,:);
				tmp_name='ateerr';
				tmp_title='Along-Track Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[-500 500];                
			elseif plt==20
				tmp_exp=xteerr_exp(:,1:skip:end,:);
				tmp_name='xteerr';
				tmp_title='Across-Track Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[-500 500]; 
			elseif plt==21
				tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
				tmp_name='RTSFerr';
				tmp_title='RTSF Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[0 100];
			elseif plt==22
				tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
				tmp_name='RSFerr';
				tmp_title='RSF Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[0 100];
			elseif plt==23
				tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
				tmp_name='RHFerr';
				tmp_title='RHF Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[0 100];
			end
			tmp_exp0=tmp_exp;
			% Lagged Correlation
			for identexploop=1:size(tmp_exp,3)	
				clear l cntexp
				set(0,'defaultfigurecolor',[1 1 1]) % figure background color
				hfig=figure;
				set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
				ax1=subplot(3,4,[1:8]);
				hold on													
				cc=[];
				pp=[];
				for fhr=1:size(tmp_exp,2)															
					onefhr=tmp_exp(:,fhr,identexploop);
					st=1;
					ed=11;
					for j=1:11
						ac1(j,:)=onefhr(st:end-ed);
						st=st+1;
						ed=ed-1;
					end								
					for k=1:11
						if size(corrcoef(ac1(1,:),ac1(k,:),'rows','complete'),1)==1
							r(k)=NaN;
							p(k)=NaN;
						else
							[R,P]=corrcoef(ac1(1,:),ac1(k,:),'rows','complete');
							r(k)=R(2);
							p(k)=P(2);
						end
					end
					cc(fhr,:)=r;
					pp(fhr,:)=p;
					clear ac1														
				end			
				% Plot														
				clear cola; for cca=1:size(cc,1); ccatmp=cc(cca,1:identlagcorr);	[row,col]=find(abs(ccatmp)>=sqrt(identserialcorr));	rowa(cca)=cca;	if isempty(col)==1;cola(cca)=1; else; cola(cca)=col(end);end; end; scfactor(plt,identexploop,:)=cola; if identexploop==1;scfactor0(plt,identexploop)={['Sample size for ', tmp_title,' in ',identexp{identexploop},' divided by ', num2str(cola(1:size(1:skip:identmaxfhr,2))),' which is a ', num2str((cola(1:size(1:skip:identmaxfhr,2))-1)*6),' serial correlation and a ',num2str((cola(1:size(1:skip:identmaxfhr,2)))*6),' separation time!']};end;
				cc=flipud(cc');
				pp=flipud(pp');
				pp(pp>=0.05)=NaN;
				pp=~isnan(pp)==1;
				imagesc(cc,'AlphaData',~isnan(cc))
				set(gca,'plotboxaspectratio',[1 1 1])
				ylabel('Lag (6-h Cycles)','fontsize',20)
				set(gca,'ytick',1:11)
				set(gca,'yticklabel',10:-1:0)
				xlabel('Forecast Lead Time (h)','fontsize',20)
				set(gca,'fontsize',20)
				box on
				if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
					if mod(identmaxfhr*3,12)==0
						xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5])
					else
						xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]) 
					end
				else
					if mod(identmaxfhr*3-3,12)==0
						xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5])
					else
						xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]) 
					end
				end         
				set(gca,'xtick',1:skiptick:50)
				set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
				set(gca,'gridcolor','k','gridalpha',.15)
				set(gca,'fontsize',20)      
				hold off
				box on														
				hold on
				for i=1:size(cc,2)
					plot(repmat(0.5+i,1,size(cc,1)+3),-1:size(cc,1)+1,'k')
				end
				for i=1:size(cc,1)
					plot(-1:size(cc,2)+1,repmat(i-.5,1,size(cc,2)+3),'k')
				end
				ylim([0.5 11.5])
				run customcolorbars
				cl=colorbar;
				caxis([-1 1])														
				colormap(gca,custommap(20,negposc))														
				set(cl,'ticks',[-1:.2:1],'fontsize',14)														
				[row,col]=find(abs(cc)>=sqrt(.25) & abs(cc)<sqrt(.50)); % 25-50% variance
				hold on
				if isempty(row)
				else
					plot(col,row,'.k','markerfacecolor','k');
				end
				[row,col]=find(abs(cc)>=sqrt(.50) & abs(cc)<sqrt(.75)); % 50-75% variance
				hold on
				if isempty(row)
				else
					plot(col,row,'+k','markerfacecolor','k');
				end
				[row,col]=find(abs(cc)>=sqrt(.75)); % 50-75% variance
				hold on
				if isempty(row)
				else
					plot(col,row,'sk','markerfacecolor','k');														
				end
				l(1)=plot(-100,-100,'.k','markerfacecolor','k');
				l(2)=plot(-100,-100,'+k','markerfacecolor','k');
				l(3)=plot(-100,-100,'sk','markerfacecolor','k');
				lh=legend(l,'r^2=25-50%','r^2=50-75%','r^2=75-100%','location','southeastoutside','orientation','vertical');	
				lh.FontSize=10;lh.ItemTokenSize(1) = 10;
				lhp=lh.Position;
				set(lh,'position',[lhp(1)+.2 lhp(2)-.28 lhp(3) lhp(4)])
				set(gcf,'Units','inches');
				a1Pos = get(gca,'Position');
				set(gcf, 'InvertHardcopy', 'off')
				set(gcf,'Units','inches');
				screenposition = get(gcf,'Position');
				set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
				set(gcf, 'InvertHardcopy', 'off')
				text(0,1.065,['\textbf{',tmp_title,' Lagged Correlation}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')    
				text(1,1.065,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
				text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
				text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
				ax=gca;
				box on
				set(ax, 'Layer', 'bottom')
				ax.LineWidth=2; 
				set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
				set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
				set(gca,'Color',[.9 .9 .9])
				for tmp=1:size(identexp,1)
					cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
				end
				if sum([cntexp(:)])==0
					tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
					set(tx, 'Layer', 'front')
				end          
				if plt==19
					 tx=text(0.02,0.05,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
					 tx=text(0.02,0.98,'Faster than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
					 set(tx, 'Layer', 'front')            
				elseif plt==20
					 tx=text(0.02,0.05,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
					 tx=text(0.02,0.98,'Right of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
					 set(tx, 'Layer', 'front')            
				end
				axis ij
				b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
				set(b,'plotboxaspectratio',[1 1 1])
				set(b,'Color','none');
				set(b,'YColor','none');
				set(b,'tickdir','both')
				set(b,'XColor',[0 0 0]);
				set(b,'ytick',[]);
				if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
					if mod(identmaxfhr*3,12)==0
						xlim(b,[0.5 (((identmaxfhr*3))/skiphr+1)+.5])
						tmpxend=((identmaxfhr*3))/skiphr+1;
					else
						xlim(b,[0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]) 
						tmpxend=((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1;
					end
				else
					if mod(identmaxfhr*3-3,12)==0
						xlim(b,[0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5])
						tmpxend=((identmaxfhr*3)-3)/skiphr+1;
					else
						xlim(b,[0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]) 
						tmpxend=((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1;
					end
				end
				set(b,'xtick',[1:skiptick:50]);
				trkerr_exp_fcnt=zeros(1,tmpxend);            
				trkerr_exp_fcnt1=zeros(1,tmpxend);            
				trkerr_exp_fcnt2=zeros(1,tmpxend);
				for tmp=1:size(identexp,1)
					cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
				end 
				set(gca,'fontsize',14)
				xlabel('# fcsts','Position',[-1 0],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',90,'units','normalized'); 
				set(gca,'position',[spPos(1)+.02 spPos(2)-.05 spPos(3) spPos(4)])
				screenposition = get(gcf,'Position');
				set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
				set(gcf, 'InvertHardcopy', 'off')
				% Create a text box at every Tick label position
				maxmin=squeeze(sum(~isnan(tmp_exp(:,1:skiptick:end,:)),1)); 
				xTicks0 = get(gca, 'xticklabel');
				xTicks = get(gca, 'xtick');
				if size(maxmin,1)<size(xTicks0,1)
					for n=1:size(xTicks0,1)-size(maxmin,1)
						maxmin(end+n,:)=0;
					end
				end
				set(b,'xticklabels',[]);
				minY =0;
				VerticalOffset1=0.03;
				HorizontalOffset = 0.2;
				for xx = 1:size(xTicks0,1)
					tmptxt0=maxmin(xx,:);
					tmplines=size(tmptxt0,2);
					if size(unique(tmptxt0),2)==1
						tmptxt1=num2str(tmptxt0(1)); 
						text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)                    
					else
						for n=1:tmplines
							tmptxt1=[];                            
							tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(n,:)),'}',num2str(tmptxt0(n))];                           
							if n==1
								text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)
							else
								text(xTicks(xx), minY - (VerticalOffset1+(.02*(n-1))),tmptxt1,'horizontalalignment','center','fontsize',14)                                
							end
						end    
					end
				end
				f = getframe(hfig);
				if identeps==1;filename=[identtrackint,'/FULL/',identn,'_',tmp_name,'_LAGCORR_',identexpshort{identexploop}];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
				close all													
			end
		end 
		fid=fopen([identtrackint,'/FULL/',identn,'_scfactor.txt'],'w');fprintf(fid,'%s\n', scfactor0{:});fclose(fid);
		% Create Graphics: trk, int, spd errors - bt-gh vs. bt-deny
		for plt=1:23
			clear l cntexp
			set(0,'defaultfigurecolor',[1 1 1]) % figure background color
			hfig=figure;
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
			ax1=subplot(3,4,[1:8]);
			hold on
			if plt==1
				 tmp_exp=trkerr_exp(:,1:skip:end,:);
				 tmp_name='trkerr';
				 tmp_title='Track Error (km)';
				 tmp_ytitle='Error (km)';
			elseif plt==2
				tmp_exp=interr_exp(:,1:skip:end,:);
				tmp_name='prserr';
				tmp_title='Pressure Error (hPa)';
				tmp_ytitle='Error (hPa)';
			elseif plt==3
				tmp_exp=spderr_exp(:,1:skip:end,:);
				tmp_name='spderr';
				tmp_title='Wind Speed Error (m/s)';
				tmp_ytitle='Error (m/s)';
			 elseif plt==4
				tmp_exp=ne34err_exp(:,1:skip:end,:);
				tmp_name='neRTSFerr';
				tmp_title='RTSF NEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==5
				tmp_exp=se34err_exp(:,1:skip:end,:);
				tmp_name='seRTSFerr';
				tmp_title='RTSF SEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==6
				tmp_exp=sw34err_exp(:,1:skip:end,:);
				tmp_name='swRTSFerr';
				tmp_title='RTSF SWQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==7
				tmp_exp=nw34err_exp(:,1:skip:end,:);
				tmp_name='nwRTSFerr';
				tmp_title='RTSF NWQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==8
				tmp_exp=ne50err_exp(:,1:skip:end,:);
				tmp_name='neRSFerr';
				tmp_title='RSF NEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==9
				tmp_exp=se50err_exp(:,1:skip:end,:);
				tmp_name='seRSFerr';
				tmp_title='RSF SEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==10
				tmp_exp=sw50err_exp(:,1:skip:end,:);
				tmp_name='swRSFerr';
				tmp_title='RSF SWQ Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[0 200];
			elseif plt==11
				tmp_exp=nw50err_exp(:,1:skip:end,:);
				tmp_name='nwRSFerr';
				tmp_title='RSF NWQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==12
				tmp_exp=ne64err_exp(:,1:skip:end,:);
				tmp_name='neRHFerr';
				tmp_title='RHF NEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==13
				tmp_exp=se64err_exp(:,1:skip:end,:);
				tmp_name='seRHFerr';
				tmp_title='RHF SEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==14
				tmp_exp=sw64err_exp(:,1:skip:end,:);
				tmp_name='swRHFerr';
				tmp_title='RHF SWQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==15
				tmp_exp=nw64err_exp(:,1:skip:end,:);
				tmp_name='nwRHFerr';
				tmp_title='RHF NWQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==16
				tmp_exp=poerr_exp(:,1:skip:end,:);
				tmp_name='poerr';
				tmp_title='Outer Clsd Isbr Prs Error (hPa)';
				tmp_ytitle='Error (hPa)';
			elseif plt==17
				tmp_exp=roerr_exp(:,1:skip:end,:);
				tmp_name='roerr';
				tmp_title='Outer Clsd Isbr Rad Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==18
				tmp_exp=rmwerr_exp(:,1:skip:end,:);
				tmp_name='rmwerr';
				tmp_title='RMW Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==19
				tmp_exp=ateerr_exp(:,1:skip:end,:);
				tmp_name='trkbias1';
				tmp_title='Along-Track Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==20
				tmp_exp=xteerr_exp(:,1:skip:end,:);
				tmp_name='trkbias2';
				tmp_title='Across-Track Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==21
				tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
				tmp_name='RTSFerr';
				tmp_title='RTSF Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==22
				tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
				tmp_name='RSFerr';
				tmp_title='RSF Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==23
				tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
				tmp_name='RHFerr';
				tmp_title='RHF Error (km)';
				tmp_ytitle='Error (km)';
			end
			if plt <19 || plt >20
				tmp_exp=abs(tmp_exp); % added for MAE
			end
			% YRANGE
			clear allquad
			allquad(1)=(max(max(nanmean(abs(ne34err_exp(:,1:skip:end,:)),1))));
			allquad(2)=(max(max(nanmean(abs(se34err_exp(:,1:skip:end,:)),1))));
			allquad(3)=(max(max(nanmean(abs(nw34err_exp(:,1:skip:end,:)),1))));
			allquad(4)=(max(max(nanmean(abs(sw34err_exp(:,1:skip:end,:)),1))));
			allquad(5)=(max(max(nanmean(abs(ne50err_exp(:,1:skip:end,:)),1))));
			allquad(6)=(max(max(nanmean(abs(se50err_exp(:,1:skip:end,:)),1))));
			allquad(7)=(max(max(nanmean(abs(nw50err_exp(:,1:skip:end,:)),1))));
			allquad(8)=(max(max(nanmean(abs(sw50err_exp(:,1:skip:end,:)),1))));
			allquad(9)=(max(max(nanmean(abs(ne64err_exp(:,1:skip:end,:)),1))));
			allquad(10)=(max(max(nanmean(abs(se64err_exp(:,1:skip:end,:)),1))));
			allquad(11)=(max(max(nanmean(abs(nw64err_exp(:,1:skip:end,:)),1))));
			allquad(12)=(max(max(nanmean(abs(sw64err_exp(:,1:skip:end,:)),1))));
			allquadmax=max(max(max(allquad)));
			allquadmin=min(min(min(allquad)));
			tmpvalq=max(abs(allquadmin),abs(allquadmax));
			if isnan(tmpvalq)==1
				tmpvalq=0;
			end
			if numel(num2str(tmpvalq))==3
				addfacq=100;
			elseif numel(num2str(tmpvalq))==2
				addfacq=20;
			else 
				addfacq=20;
			end
			if numel(num2str(round(max(max(nanmean((tmp_exp),1))))))==3
				addfac=100;
			elseif numel(num2str(round(max(max(nanmean((tmp_exp),1))))))==2
				addfac=20;
			else
				addfac=20;
			end
			if plt<=3 || (plt>=16 && plt<=18) % 0-end
				tmpmin=min(min(nanmean((tmp_exp),1)));
				tmpmax=max(max(nanmean((tmp_exp),1)));
				tmpval=max(abs(tmpmin),abs(tmpmax));
				if isnan(tmpval)==1
					tmpval=0;
				end               
				yrange=[0 round((tmpval+addfac)/10)*10];                
			elseif plt==19 || plt==20 % -end end 
				tmpmin=min(min(nanmean((tmp_exp),1)));
				tmpmax=max(max(nanmean((tmp_exp),1)));
				tmpval=max(abs(tmpmin),abs(tmpmax));
				if isnan(tmpval)==1
					tmpval=0;
				end 
				yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
			elseif (plt>=4 && plt<=15) || plt>=21%quad
				yrange=[0 round((tmpvalq+addfacq)/10)*10];
			end

			for tmp=1:size(identexp,1)
				l(tmp)=plot(1:size(tmp_exp,2),nanmean(tmp_exp(:,:,tmp),1),'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2);
			end           
			% Find which experiment to compare to
			for tmp=1:size(identexp,1)
				if strcmp(identexp(tmp),identexpsigimp)
					tmpimp=tmp;
				end
			end
			plot(-10:89,zeros(1,100),'Color',[.5 .5 .5],'linewidth',2);if plt==1;tmp_expbias=tmp_exp;end;
			for tmp=1:size(identexp,1)
				if plt==19 || plt==20; sigtest=ttestsc(tmp_expbias(:,:,tmp),tmp_expbias(:,:,tmpimp),squeeze(scfactor(1,tmp,:))','alpha',.05);else;sigtest=ttestsc(tmp_exp(:,:,tmp),tmp_exp(:,:,tmpimp),squeeze(scfactor(plt,tmp,:))','alpha',.05);end;
				sigtest_loc=find(sigtest==1);
				sigtest_exp=nanmean(tmp_exp(:,sigtest_loc,:),1);
				for tmpi=tmp
					plot(sigtest_loc,sigtest_exp(:,:,tmpi),'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',9)
				end
				if plt==19 || plt==20; sigtest=ttestsc(tmp_expbias(:,:,tmp),tmp_expbias(:,:,tmpimp),squeeze(scfactor(1,tmp,:))','alpha',.1);else;sigtest=ttestsc(tmp_exp(:,:,tmp),tmp_exp(:,:,tmpimp),squeeze(scfactor(plt,tmp,:))','alpha',.1);end;
				sigtest_loc1=find(sigtest==1);
				sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
				sigtest_exp=nanmean(tmp_exp(:,sigtest_loc,:),1);
				for tmpi=tmp
					plot(sigtest_loc,sigtest_exp(:,:,tmpi),'o','Color','k','markersize',8,'markerfacecolor',identexpcolors(tmp,:))
				end
			end   
			set(gca,'plotboxaspectratio',[1 1 1])
			xlabel('Forecast Lead Time (h)','fontsize',20)
			ylabel(tmp_ytitle,'fontsize',20)
			set(gca,'fontsize',20)
			box on
			if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
				if mod(identmaxfhr*3,12)==0
					xlim([1 ((identmaxfhr*3))/skiphr+1])
				else
					xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
				end
			else
				if mod(identmaxfhr*3-3,12)==0
					xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
				else
					xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
				end
			end
			ylim(yrange)
			set(gca,'xtick',1:skiptick:50)
			set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
			grid on
			set(gca,'gridcolor','k','gridalpha',.15)
			set(gca,'fontsize',20)      
			hold off
			box on
			lh=legend(l,identexpshort,'location','northeast');
			lh.FontSize=10;
			set(gcf,'Units','inches');
			a1Pos = get(gca,'Position');
			set(gcf, 'InvertHardcopy', 'off')
			set(gcf,'Units','inches');
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')
			text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
			text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
			text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
			ax=gca;
			box on
			set(ax, 'Layer', 'bottom')
			ax.LineWidth=1; 
			set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
			set(gca,'Color',[.9 .9 .9])
			for tmp=1:size(identexp,1)
				cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
			end
			if sum([cntexp(:)])==0
				tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				set(tx, 'Layer', 'front')
			end          
			if plt==19
				 tx=text(0.02,0.05,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 tx=text(0.02,0.98,'Faster than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 set(tx, 'Layer', 'front')            
			elseif plt==20
				 tx=text(0.02,0.05,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 tx=text(0.02,0.98,'Right of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 set(tx, 'Layer', 'front')            
			end
			b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
			set(b,'plotboxaspectratio',[1 1 1])
			set(b,'Color','none');
			set(b,'YColor','none');
			set(b,'tickdir','both')
			set(b,'XColor',[0 0 0]);
			set(b,'ytick',[]);
			if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
				if mod(identmaxfhr*3,12)==0
					xlim(b,[1 ((identmaxfhr*3))/skiphr+1])
					tmpxend=((identmaxfhr*3))/skiphr+1;
				else
					xlim(b,[1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
					tmpxend=((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1;
				end
			else
				if mod(identmaxfhr*3-3,12)==0
					xlim(b,[1 ((identmaxfhr*3)-3)/skiphr+1])
					tmpxend=((identmaxfhr*3)-3)/skiphr+1;
				else
					xlim(b,[1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
					tmpxend=((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1;
				end
			end        
			set(b,'xtick',[1:skiptick:50]);
			trkerr_exp_fcnt=zeros(1,tmpxend);            
			trkerr_exp_fcnt1=zeros(1,tmpxend);            
			trkerr_exp_fcnt2=zeros(1,tmpxend);
			for tmp=1:size(identexp,1)
				cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
			end  
			set(gca,'fontsize',14)
			xlabel('# fcsts','Position',[-1 0],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',90,'units','normalized'); 
			set(gca,'position',[spPos(1)+.02 spPos(2)-.05 spPos(3) spPos(4)])
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')
			% Create a text box at every Tick label position
			maxmin=squeeze(sum(~isnan(tmp_exp(:,1:skiptick:end,:)),1)); 
			xTicks0 = get(gca, 'xticklabel');
			xTicks = get(gca, 'xtick');
			if size(maxmin,1)<size(xTicks0,1)
				for n=1:size(xTicks0,1)-size(maxmin,1)
					maxmin(end+n,:)=0;
				end
			end
			set(b,'xticklabels',[]);
			minY =0;
			VerticalOffset1=0.03;
			HorizontalOffset = 0.2;
			for xx = 1:size(xTicks0,1)
				tmptxt0=maxmin(xx,:);
				tmplines=size(tmptxt0,2);
				if size(unique(tmptxt0),2)==1
					tmptxt1=num2str(tmptxt0(1)); 
					text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)                    
				else
					for n=1:tmplines
						tmptxt1=[];                            
						tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(n,:)),'}',num2str(tmptxt0(n))];                           
						if n==1
							text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)
						else
							text(xTicks(xx), minY - (VerticalOffset1+(.02*(n-1))),tmptxt1,'horizontalalignment','center','fontsize',14)                                
						end
					end    
				end
			end
			f = getframe(hfig);
			if identeps==1;filename=[identtrackint,'/FULL/',identn,'_',tmp_name];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
			close all
		end                    
		% Create Graphics: trk, int, spd Skill vs. deny
		for plt=[1:18,21:23]
			clear l cntexp
			set(0,'defaultfigurecolor',[1 1 1]) % figure background color
			hfig=figure;
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
			ax1=subplot(3,4,[1:8]);
			hold on
			if plt==1
				 tmp_exp=trkerr_exp(:,1:skip:end,:);
				 tmp_name='trkskill';
				 tmp_title='Track Skill (\%)';
				 tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==2
				tmp_exp=interr_exp(:,1:skip:end,:);
				tmp_name='prskill';
				tmp_title='Pressure Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==3
				tmp_exp=spderr_exp(:,1:skip:end,:);
				tmp_name='spdskill';
				tmp_title='Wind Speed Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			 elseif plt==4
				tmp_exp=ne34err_exp(:,1:skip:end,:);
				tmp_name='neRTSFskill';
				tmp_title='RTSF NEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==5
				tmp_exp=se34err_exp(:,1:skip:end,:);
				tmp_name='seRTSFskill';
				tmp_title='RTSF SEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==6
				tmp_exp=sw34err_exp(:,1:skip:end,:);
				tmp_name='swRTSFskill';
				tmp_title='RTSF SWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==7
				tmp_exp=nw34err_exp(:,1:skip:end,:);
				tmp_name='nwRTSFskill';
				tmp_title='RTSF NWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==8
				tmp_exp=ne50err_exp(:,1:skip:end,:);
				tmp_name='neRSFskill';
				tmp_title='RSF NEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==9
				tmp_exp=se50err_exp(:,1:skip:end,:);
				tmp_name='seRSFskill';
				tmp_title='RSF SEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==10
				tmp_exp=sw50err_exp(:,1:skip:end,:);
				tmp_name='swRSFskill';
				tmp_title='RSF SWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==11
				tmp_exp=nw50err_exp(:,1:skip:end,:);
				tmp_name='nwRSFskill';
				tmp_title='RSF NWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==12
				tmp_exp=ne64err_exp(:,1:skip:end,:);
				tmp_name='neRHFskill';
				tmp_title='RHF NEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==13
				tmp_exp=se64err_exp(:,1:skip:end,:);
				tmp_name='seRHFskill';
				tmp_title='RHF SEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==14
				tmp_exp=sw64err_exp(:,1:skip:end,:);
				tmp_name='swRHFskill';
				tmp_title='RHF SWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==15
				tmp_exp=nw64err_exp(:,1:skip:end,:);
				tmp_name='nwRHFskill';
				tmp_title='RHF NWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==16
				tmp_exp=poerr_exp(:,1:skip:end,:);
				tmp_name='poskill';
				tmp_title='Outer Clsd Isbr Prs Skill (hPa)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==17
				tmp_exp=roerr_exp(:,1:skip:end,:);
				tmp_name='roskill';
				tmp_title='Outer Clsd Isbr Rad Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==18
				tmp_exp=rmwerr_exp(:,1:skip:end,:);
				tmp_name='rmwskill';
				tmp_title='RMW Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==19
				tmp_exp=ateerr_exp(:,1:skip:end,:);
				tmp_name='ateskill';
				tmp_title='Along-Track Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==20
				tmp_exp=xteerr_exp(:,1:skip:end,:);
				tmp_name='xteskill';
				tmp_title='Across-Track Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==21
				tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
				tmp_name='RTSFskill';
				tmp_title='RTSF Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==22
				tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
				tmp_name='RSFskill';
				tmp_title='RSF Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==23
				tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
				tmp_name='RHFskill';
				tmp_title='RHF Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			end
			if plt <19 || plt >20
				tmp_exp=abs(tmp_exp); % added for MAE
			end                        % Find which experiment to compare to
			for tmp=1:size(identexp,1)
				if strcmp(identexp(tmp),identexpsigimp)
					tmpimp=tmp;
				end
			end      
			tmpu=1:size(identexp,1);
			tmpu(tmpu==tmpimp)=[];
			plot(-10:89,zeros(1,100),'Color',[.5 .5 .5],'linewidth',2);
			for tmp=[tmpimp,tmpu]
				imprv=100.*(1-abs(nanmean(tmp_exp(:,:,tmp),1))./abs(nanmean(tmp_exp(:,:,tmpimp),1)));                  
				imprv2(:,tmp)=imprv;
				l(tmp)=plot(1:size(imprv,2),imprv,'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2); 
				sigtest=ttestsc(tmp_exp(:,:,tmp),tmp_exp(:,:,tmpimp),squeeze(scfactor(plt,tmp,:))','alpha',.05);
				sigtest_loc=find(sigtest==1);
				sigtest_exp=imprv(sigtest_loc);
				plot(sigtest_loc,sigtest_exp,'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',9)
				sigtest=ttestsc(tmp_exp(:,:,tmp),tmp_exp(:,:,tmpimp),squeeze(scfactor(plt,tmp,:))','alpha',.1);
				sigtest_loc1=find(sigtest==1);
				sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
				sigtest_exp=imprv(sigtest_loc);
				plot(sigtest_loc,sigtest_exp,'o','Color','k','markersize',8,'markerfacecolor',identexpcolors(tmp,:))
			end   
			set(gca,'plotboxaspectratio',[1 1 1])
			xlabel('Forecast Lead Time (h)','fontsize',20)
			ylabel(tmp_ytitle,'fontsize',20)
			set(gca,'fontsize',20)
			box on
			if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
				if mod(identmaxfhr*3,12)==0
					xlim([1 ((identmaxfhr*3))/skiphr+1])
				else
					xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
				end
			else
				if mod(identmaxfhr*3-3,12)==0
					xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
				else
					xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
				end
			end
			% YRANGE
			clear allquad imprv3
			imprv3(:,:,1)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,2)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,3)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,4)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,5)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,6)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,7)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,8)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,9)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,10)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,11)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,12)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
			allquadmax=max(max(max(imprv3)));
			allquadmin=min(min(min(imprv3)));
			tmpvalq=max(abs(allquadmin),abs(allquadmax));
			if isnan(tmpvalq)==1
				tmpvalq=0;
			end
			if numel(num2str(tmpvalq))==3
				addfacq=100;
			elseif numel(num2str(tmpvalq))==2
				addfacq=20;
			else
				addfacq=20;
			end
			if numel(num2str(round(max(imprv2(:)))))==3
				addfac=100;
			elseif numel(num2str(round(max(imprv2(:)))))==2
				addfac=20;
			else
				addfac=20;
			end
			if plt<=3 || (plt>=16 && plt<=18) % 0-end
				tmpmin=min(imprv2(:));
				tmpmax=max(imprv2(:));
				tmpval=max(abs(tmpmin),abs(tmpmax));
				if isnan(tmpval)==1
					tmpval=0;
				end
				if tmpval>250
					yrange=[-250 250];
				else
					yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
				end
			elseif plt==19 || plt==20 % -end end 
				tmpmin=min(imprv2(:));
				tmpmax=max(imprv2(:));
				tmpval=max(abs(tmpmin),abs(tmpmax));
				if isnan(tmpval)==1
					tmpval=0;
				end
				if tmpval>250
					yrange=[-250 250];
				else
					yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
				end
			elseif (plt>=4 && plt<=15) || plt>=21%quad                   
				if tmpvalq>250
					yrange=[-250 250];
				else
					yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
				end
			end
			ylim(yrange)
			set(gca,'xtick',1:skiptick:50)
			set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
			grid on
			set(gca,'gridcolor','k','gridalpha',.15)
			set(gca,'fontsize',20)      
			hold off
			box on
			lh=legend(l,identexpshort,'location','northeast');
			lh.FontSize=10;
			set(gcf,'Units','inches');
			a1Pos = get(gca,'Position');
			set(gcf, 'InvertHardcopy', 'off')
			set(gcf,'Units','inches');
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')
			text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
			text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
			text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
			ax=gca;
			box on
			set(ax, 'Layer', 'bottom')
			ax.LineWidth=1; 
			set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
			set(gca,'Color',[.9 .9 .9])            
			if sum(~isnan((diff(imprv))))==0
				tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				set(tx, 'Layer', 'front')
			end
			% Mean Value            
			tmpstr=['Mean: '];
			imprv2(imprv2==-Inf)=0;
			imprv2(imprv2==Inf)=0;
			tmpstrmean=nanmean(imprv2(1:(identmaxfhr+1)/2,:),1);
			tmpstrmean=(find(tmpstrmean~=0));
			if size(tmpstrmean,2)>0
				for tmp=tmpstrmean
				if tmp==tmpstrmean(end)
					tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(imprv2(1:(identmaxfhr+1)/2,tmp)),2)),'%'];
				else
					tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(imprv2(1:(identmaxfhr+1)/2,tmp)),2)),'% \color[rgb]{0,0,0}| '];
				end
				end
			else
				tmpstr='';
			end
			if sum(sum(~isnan(imprv2)))==0
				tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				set(tx, 'Layer', 'front')          
			else
				tx=text(0.98,0.05,tmpstr,'HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				set(tx, 'Layer', 'front')
			end 
			b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
			set(b,'plotboxaspectratio',[1 1 1])
			set(b,'Color','none');
			set(b,'YColor','none');
			set(b,'tickdir','both')
			set(b,'XColor',[0 0 0]);
			set(b,'ytick',[]);
			if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
				if mod(identmaxfhr*3,12)==0
					xlim(b,[1 ((identmaxfhr*3))/skiphr+1])
					tmpxend=((identmaxfhr*3))/skiphr+1;
				else
					xlim(b,[1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
					tmpxend=((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1;
				end
			else
				if mod(identmaxfhr*3-3,12)==0
					xlim(b,[1 ((identmaxfhr*3)-3)/skiphr+1])
					tmpxend=((identmaxfhr*3)-3)/skiphr+1;
				else
					xlim(b,[1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
					tmpxend=((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1;
				end
			end        
			set(b,'xtick',[1:skiptick:50]); 
			trkerr_exp_fcnt=zeros(1,tmpxend);            
			trkerr_exp_fcnt1=zeros(1,tmpxend);            
			trkerr_exp_fcnt2=zeros(1,tmpxend);
			for tmp=1:size(identexp,1)
				cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
			end  
			set(gca,'fontsize',14)            
			xlabel('# fcsts','Position',[-1 0],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',90,'units','normalized'); 
			set(gca,'position',[spPos(1)+.02 spPos(2)-.05 spPos(3) spPos(4)])
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')
			% Create a text box at every Tick label position
			maxmin=squeeze(sum(~isnan(tmp_exp(:,1:skiptick:end,:)),1)); 
			xTicks0 = get(gca, 'xticklabel');
			xTicks = get(gca, 'xtick');
			if size(maxmin,1)<size(xTicks0,1)
				for n=1:size(xTicks0,1)-size(maxmin,1)
					maxmin(end+n,:)=0;
				end
			end
			set(b,'xticklabels',[]);
			minY =0;
			VerticalOffset1=0.03;
			HorizontalOffset = 0.2;
			for xx = 1:size(xTicks0,1)
				tmptxt0=maxmin(xx,:);
				tmplines=size(tmptxt0,2);
				if size(unique(tmptxt0),2)==1
					tmptxt1=num2str(tmptxt0(1)); 
					text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)                    
				else
					for n=1:tmplines
						tmptxt1=[];                            
						tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(n,:)),'}',num2str(tmptxt0(n))];                           
						if n==1
							text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)
						else
							text(xTicks(xx), minY - (VerticalOffset1+(.02*(n-1))),tmptxt1,'horizontalalignment','center','fontsize',14)                                
						end
					end    
				end
			end
			f = getframe(hfig);
			if identeps==1;filename=[identtrackint,'/FULL/',identn,'_',tmp_name];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
			close all
		end
		% Create Graphics: trk, int, spd FSP vs. deny            
		for plt=[1:18,21:23]
			clear l cntexp
			set(0,'defaultfigurecolor',[1 1 1]) % figure background color
			hfig=figure;
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
			ax1=subplot(3,4,[1:8]);
			hold on
			if plt==1
				 tmp_exp=trkerr_exp(:,1:skip:end,:);
				 tmp_name='trkfsp';
				 tmp_title='Track FSP (\%)';
				 tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==2
				tmp_exp=interr_exp(:,1:skip:end,:);
				tmp_name='prsfsp';
				tmp_title='Pressure FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==3
				tmp_exp=spderr_exp(:,1:skip:end,:);
				tmp_name='spdfsp';
				tmp_title='Wind Speed FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			 elseif plt==4
				tmp_exp=ne34err_exp(:,1:skip:end,:);
				tmp_name='neRTSFfsp';
				tmp_title='RTSF NEQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==5
				tmp_exp=se34err_exp(:,1:skip:end,:);
				tmp_name='seRTSFfsp';
				tmp_title='RTSF SEQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==6
				tmp_exp=sw34err_exp(:,1:skip:end,:);
				tmp_name='swRTSFfsp';
				tmp_title='RTSF SWQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==7
				tmp_exp=nw34err_exp(:,1:skip:end,:);
				tmp_name='nwRTSFfsp';
				tmp_title='RTSF NWQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==8
				tmp_exp=ne50err_exp(:,1:skip:end,:);
				tmp_name='neRSFfsp';
				tmp_title='RSF NEQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==9
				tmp_exp=se50err_exp(:,1:skip:end,:);
				tmp_name='seRSFfsp';
				tmp_title='RSF SEQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==10
				tmp_exp=sw50err_exp(:,1:skip:end,:);
				tmp_name='swRSFfsp';
				tmp_title='RSF SWQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==11
				tmp_exp=nw50err_exp(:,1:skip:end,:);
				tmp_name='nwRSFfsp';
				tmp_title='RSF NWQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==12
				tmp_exp=ne64err_exp(:,1:skip:end,:);
				tmp_name='neRHFfsp';
				tmp_title='RHF NEQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==13
				tmp_exp=se64err_exp(:,1:skip:end,:);
				tmp_name='seRHFfsp';
				tmp_title='RHF SEQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==14
				tmp_exp=sw64err_exp(:,1:skip:end,:);
				tmp_name='swRHFfsp';
				tmp_title='RHF SWQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==15
				tmp_exp=nw64err_exp(:,1:skip:end,:);
				tmp_name='nwRHFfsp';
				tmp_title='RHF NWQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==16
				tmp_exp=poerr_exp(:,1:skip:end,:);
				tmp_name='pofsp';
				tmp_title='Outer Clsd Isbr Prs FSP (hPa)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==17
				tmp_exp=roerr_exp(:,1:skip:end,:);
				tmp_name='rofsp';
				tmp_title='Outer Clsd Isbr Rad FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==18
				tmp_exp=rmwerr_exp(:,1:skip:end,:);
				tmp_name='rmwfsp';
				tmp_title='RMW FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==19
				tmp_exp=ateerr_exp(:,1:skip:end,:);
				tmp_name='atefsp';
				tmp_title='Along-Track FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==20
				tmp_exp=xteerr_exp(:,1:skip:end,:);
				tmp_name='xtefsp';
				tmp_title='Across-Track FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==21
				tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
				tmp_name='RTSFfsp';
				tmp_title='RTSF FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==22
				tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
				tmp_name='RSFfsp';
				tmp_title='RSF FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			elseif plt==23
				tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
				tmp_name='RHFfsp';
				tmp_title='RHF FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
			end
			if plt <19 || plt >20
				tmp_exp=abs(tmp_exp); % added for MAE
			end                        % Find which experiment to compare to
			for tmp=1:size(identexp,1)
				if strcmp(identexp(tmp),identexpsigimp)
					tmpimp=tmp;
				end
			end      
			tmpu=1:size(identexp,1);
			tmpu(tmpu==tmpimp)=[];
			plot(-10:89,50*ones(1,100),'Color',[.5 .5 .5],'linewidth',2);
			clear fsp2 l
			cntl=1;
			for tmp=tmpu
				tmp1=tmp_exp(:,:,tmp);
				tmp2=tmp_exp(:,:,tmpimp);
				tmp3=sign(tmp1-tmp2);
				tmp4=tmp3<0;
				tmp5=tmp3>0;
				tmp6=tmp3==0;
				tmptmp=sum(~isnan(tmp3),1);                            
				fspa=100*(nansum(tmp4,1)+nansum(tmp6,1)./2)./tmptmp;
				fspb=100*(nansum(tmp5,1)+nansum(tmp6,1)./2)./tmptmp;
				fsp2(:,tmp)=fspa;
				%plot(1:size(fspb,2),fspb,'--s','Color',identexpcolors(tmp,:),'linewidth',.5,'markersize',2); 
				l(cntl)=plot(1:size(fspa,2),fspa,'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2); 
				cntl=cntl+1;
				sigtest=ttestsc(abs(tmp_exp(:,:,tmp)),abs(tmp_exp(:,:,tmpimp)),squeeze(scfactor(plt,tmp,:))','alpha',.05);
				sigtest_loc=find(sigtest==1);
				sigtest_exp=fspa(sigtest_loc);
				plot(sigtest_loc,sigtest_exp,'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',9)
				sigtest=ttestsc(abs(tmp_exp(:,:,tmp)),abs(tmp_exp(:,:,tmpimp)),squeeze(scfactor(plt,tmp,:))','alpha',.1);
				sigtest_loc1=find(sigtest==1);
				sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
				sigtest_exp=fspa(sigtest_loc);
				plot(sigtest_loc,sigtest_exp,'o','Color','k','markersize',8,'markerfacecolor',identexpcolors(tmp,:))
			end 
			set(gca,'plotboxaspectratio',[1 1 1])
			xlabel('Forecast Lead Time (h)','fontsize',20)
			ylabel(tmp_ytitle,'fontsize',20)
			set(gca,'fontsize',20)
			box on
			if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
				if mod(identmaxfhr*3,12)==0
					xlim([1 ((identmaxfhr*3))/skiphr+1])
				else
					xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
				end
			else
				if mod(identmaxfhr*3-3,12)==0
					xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
				else
					xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
				end
			end                                
			ylim([0 100])
			set(gca,'xtick',1:skiptick:50)
			set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
			grid on
			set(gca,'gridcolor','k','gridalpha',.15)
			set(gca,'fontsize',20)      
			hold off
			box on
			lh=legend(l,identexpshort(tmpu),'location','northeast');
			lh.FontSize=10;
			set(gcf,'Units','inches');
			a1Pos = get(gca,'Position');
			set(gcf, 'InvertHardcopy', 'off')
			set(gcf,'Units','inches');
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')
			text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
			text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
			text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
			ax=gca;
			box on
			set(ax, 'Layer', 'bottom')
			ax.LineWidth=1; 
			set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
			set(gca,'Color',[.9 .9 .9])            
			if sum(~isnan((diff(fspa))))==0
				tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				set(tx, 'Layer', 'front')
			end
			% Mean Value            
			tmpstr=['Mean: '];
			fsp2(fsp2==-Inf)=0;
			fsp2(fsp2==Inf)=0;
			tmpstrmean=nanmean(fsp2(1:(identmaxfhr+1)/2,:),1);
			tmpstrmean=(find(tmpstrmean~=0));
			if size(tmpstrmean,2)>0
				for tmp=tmpstrmean
				if tmp==tmpstrmean(end)
					tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(fsp2(1:(identmaxfhr+1)/2,tmp)),2)),'%'];
				else
					tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(fsp2(1:(identmaxfhr+1)/2,tmp)),2)),'% \color[rgb]{0,0,0}| '];
				end
				end
			else
				tmpstr='';
			end
			if sum(sum(~isnan(fsp2)))==0
				tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				set(tx, 'Layer', 'front')          
			else
				tx=text(0.98,0.05,tmpstr,'HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				set(tx, 'Layer', 'front')
			end 
			b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
			set(b,'plotboxaspectratio',[1 1 1])
			set(b,'Color','none');
			set(b,'YColor','none');
			set(b,'tickdir','both')
			set(b,'XColor',[0 0 0]);
			set(b,'ytick',[]);
			if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
				if mod(identmaxfhr*3,12)==0
					xlim(b,[1 ((identmaxfhr*3))/skiphr+1])
					tmpxend=((identmaxfhr*3))/skiphr+1;
				else
					xlim(b,[1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
					tmpxend=((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1;
				end
			else
				if mod(identmaxfhr*3-3,12)==0
					xlim(b,[1 ((identmaxfhr*3)-3)/skiphr+1])
					tmpxend=((identmaxfhr*3)-3)/skiphr+1;
				else
					xlim(b,[1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
					tmpxend=((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1;
				end
			end        
			set(b,'xtick',[1:skiptick:50]); 
			trkerr_exp_fcnt=zeros(1,tmpxend);            
			trkerr_exp_fcnt1=zeros(1,tmpxend);            
			trkerr_exp_fcnt2=zeros(1,tmpxend);
			for tmp=1:size(identexp,1)
				cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
			end  
			set(gca,'fontsize',14)            
			xlabel('# fcsts','Position',[-1 0],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',90,'units','normalized'); 
			set(gca,'position',[spPos(1)+.02 spPos(2)-.05 spPos(3) spPos(4)])
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')
			% Create a text box at every Tick label position
			maxmin=squeeze(sum(~isnan(tmp_exp(:,1:skiptick:end,:)),1)); 
			xTicks0 = get(gca, 'xticklabel');
			xTicks = get(gca, 'xtick');
			if size(maxmin,1)<size(xTicks0,1)
				for n=1:size(xTicks0,1)-size(maxmin,1)
					maxmin(end+n,:)=0;
				end
			end
			set(b,'xticklabels',[]);
			minY =0;
			VerticalOffset1=0.03;
			HorizontalOffset = 0.2;
			for xx = 1:size(xTicks0,1)
				tmptxt0=maxmin(xx,:);
				tmplines=size(tmptxt0,2);
				if size(unique(tmptxt0),2)==1
					tmptxt1=num2str(tmptxt0(1)); 
					text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)                    
				else
					for n=1:tmplines
						tmptxt1=[];                            
						tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(n,:)),'}',num2str(tmptxt0(n))];                           
						if n==1
							text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)
						else
							text(xTicks(xx), minY - (VerticalOffset1+(.02*(n-1))),tmptxt1,'horizontalalignment','center','fontsize',14)                                
						end
					end    
				end
			end
			f = getframe(hfig);
			if identeps==1;filename=[identtrackint,'/FULL/',identn,'_',tmp_name];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
			close all
		end             
		% Create Graphics: trk, int, spd bias - bt-gh vs. bt-deny
		for plt=[2:18,21:23] % no across or along for bias since already in error
			clear l cntexp
			set(0,'defaultfigurecolor',[1 1 1]) % figure background color
			hfig=figure;
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
			ax1=subplot(3,4,[1:8]);
			hold on
			if plt==1
				 tmp_exp=trkerr_exp(:,1:skip:end,:);
				 tmp_name='trkbias';
				 tmp_title='Track Bias (km)';
				 tmp_ytitle='Bias (km)';
			elseif plt==2
				tmp_exp=interr_exp(:,1:skip:end,:);
				tmp_name='prsbias';
				tmp_title='Pressure Bias (hPa)';
				tmp_ytitle='Bias (hPa)';
			elseif plt==3
				tmp_exp=spderr_exp(:,1:skip:end,:);
				tmp_name='spdbias';
				tmp_title='Wind Speed Bias (m/s)';
				tmp_ytitle='Bias (m/s)';
			 elseif plt==4
				tmp_exp=ne34err_exp(:,1:skip:end,:);
				tmp_name='neRTSFbias';
				tmp_title='RTSF NEQ Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==5
				tmp_exp=se34err_exp(:,1:skip:end,:);
				tmp_name='seRTSFbias';
				tmp_title='RTSF SEQ Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==6
				tmp_exp=sw34err_exp(:,1:skip:end,:);
				tmp_name='swRTSFbias';
				tmp_title='RTSF SWQ Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==7
				tmp_exp=nw34err_exp(:,1:skip:end,:);
				tmp_name='nwRTSFbias';
				tmp_title='RTSF NWQ Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==8
				tmp_exp=ne50err_exp(:,1:skip:end,:);
				tmp_name='neRSFbias';
				tmp_title='RSF NEQ Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==9
				tmp_exp=se50err_exp(:,1:skip:end,:);
				tmp_name='seRSFbias';
				tmp_title='RSF SEQ Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==10
				tmp_exp=sw50err_exp(:,1:skip:end,:);
				tmp_name='swRSFbias';
				tmp_title='RSF SWQ Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==11
				tmp_exp=nw50err_exp(:,1:skip:end,:);
				tmp_name='nwRSFbias';
				tmp_title='RSF NWQ Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==12
				tmp_exp=ne64err_exp(:,1:skip:end,:);
				tmp_name='neRHFbias';
				tmp_title='RHF NEQ Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==13
				tmp_exp=se64err_exp(:,1:skip:end,:);
				tmp_name='seRHFbias';
				tmp_title='RHF SEQ Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==14
				tmp_exp=sw64err_exp(:,1:skip:end,:);
				tmp_name='swRHFbias';
				tmp_title='RHF SWQ Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==15
				tmp_exp=nw64err_exp(:,1:skip:end,:);
				tmp_name='nwRHFbias';
				tmp_title='RHF NWQ Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==16
				tmp_exp=poerr_exp(:,1:skip:end,:);
				tmp_name='pobias';
				tmp_title='Outer Clsd Isbr Prs Bias (hPa)';
				tmp_ytitle='Bias (hPa)';
			elseif plt==17
				tmp_exp=roerr_exp(:,1:skip:end,:);
				tmp_name='robias';
				tmp_title='Outer Clsd Isbr Rad Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==18
				tmp_exp=rmwerr_exp(:,1:skip:end,:);
				tmp_name='rmwbias';
				tmp_title='RMW Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==19
				tmp_exp=ateerr_exp(:,1:skip:end,:);
				tmp_name='atebias';
				tmp_title='Along-Track Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==20
				tmp_exp=xteerr_exp(:,1:skip:end,:);
				tmp_name='xtebias';
				tmp_title='Across-Track Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==21
				tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
				tmp_name='RTSFbias';
				tmp_title='RTSF Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==22
				tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
				tmp_name='RSFbias';
				tmp_title='RSF Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==23
				tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
				tmp_name='RHFbias';
				tmp_title='RHF Bias (km)';
				tmp_ytitle='Bias (km)';
			end
			for tmp=1:size(identexp,1)
				l(tmp)=plot(1:size(tmp_exp,2),nanmean(tmp_exp(:,:,tmp),1),'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2);
			end           
			% Find which experiment to compare to
			for tmp=1:size(identexp,1)
				if strcmp(identexp(tmp),identexpsigimp)
					tmpimp=tmp;
				end
			end
			plot(-10:89,zeros(1,100),'Color',[.5 .5 .5],'linewidth',2);
			for tmp=1:size(identexp,1)
				sigtest=ttestsc(abs(tmp_exp(:,:,tmp)),abs(tmp_exp(:,:,tmpimp)),squeeze(scfactor(plt,tmp,:))','alpha',.05);
				sigtest_loc=find(sigtest==1);
				sigtest_exp=nanmean(tmp_exp(:,sigtest_loc,:),1);
				for tmpi=tmp
					plot(sigtest_loc,sigtest_exp(:,:,tmpi),'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',9)
				end
				sigtest=ttestsc(abs(tmp_exp(:,:,tmp)),abs(tmp_exp(:,:,tmpimp)),squeeze(scfactor(plt,tmp,:))','alpha',.1);
				sigtest_loc1=find(sigtest==1);
				sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
				sigtest_exp=nanmean(tmp_exp(:,sigtest_loc,:),1);
				for tmpi=tmp
					plot(sigtest_loc,sigtest_exp(:,:,tmpi),'o','Color','k','markersize',8,'markerfacecolor',identexpcolors(tmp,:))
				end
			end   
			set(gca,'plotboxaspectratio',[1 1 1])
			xlabel('Forecast Lead Time (h)','fontsize',20)
			ylabel(tmp_ytitle,'fontsize',20)
			set(gca,'fontsize',20)
			box on
			if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
				if mod(identmaxfhr*3,12)==0
					xlim([1 ((identmaxfhr*3))/skiphr+1])
				else
					xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
				end
			else
				if mod(identmaxfhr*3-3,12)==0
					xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
				else
					xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
				end
			end
			% YRANGE
			clear allquad
			allquad(1)=(max(max(nanmean((ne34err_exp(:,1:skip:end,:)),1))));
			allquad(2)=(max(max(nanmean((se34err_exp(:,1:skip:end,:)),1))));
			allquad(3)=(max(max(nanmean((nw34err_exp(:,1:skip:end,:)),1))));
			allquad(4)=(max(max(nanmean((sw34err_exp(:,1:skip:end,:)),1))));
			allquad(5)=(max(max(nanmean((ne50err_exp(:,1:skip:end,:)),1))));
			allquad(6)=(max(max(nanmean((se50err_exp(:,1:skip:end,:)),1))));
			allquad(7)=(max(max(nanmean((nw50err_exp(:,1:skip:end,:)),1))));
			allquad(8)=(max(max(nanmean((sw50err_exp(:,1:skip:end,:)),1))));
			allquad(9)=(max(max(nanmean((ne64err_exp(:,1:skip:end,:)),1))));
			allquad(10)=(max(max(nanmean((se64err_exp(:,1:skip:end,:)),1))));
			allquad(11)=(max(max(nanmean((nw64err_exp(:,1:skip:end,:)),1))));
			allquad(12)=(max(max(nanmean((sw64err_exp(:,1:skip:end,:)),1))));
			allquadmax=max(max(max(allquad)));
			allquadmin=min(min(min(allquad)));
			tmpvalq=max(abs(allquadmin),abs(allquadmax));
			if isnan(tmpvalq)==1
				tmpvalq=0;
			end
			if numel(num2str(tmpvalq))==3
				addfacq=100;
			elseif numel(num2str(tmpvalq))==2
				addfacq=20;
			else
				addfacq=20;
			end
			if numel(num2str(round(max(max(nanmean((tmp_exp),1))))))==3
				addfac=100;
			elseif numel(num2str(round(max(max(nanmean((tmp_exp),1))))))==2
				addfac=20;
			else
				addfac=20;
			end
			if plt<=3 || (plt>=16 && plt<=18) % -end-end
				tmpmin=min(min(nanmean((tmp_exp),1)));
				tmpmax=max(max(nanmean((tmp_exp),1)));
				tmpval=max(abs(tmpmin),abs(tmpmax));
				if isnan(tmpval)==1
					tmpval=0;
				end
				yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
			elseif plt==19 || plt==20 % -end end 
				tmpmin=min(min(nanmean((tmp_exp),1)));
				tmpmax=max(max(nanmean((tmp_exp),1)));
				tmpval=max(abs(tmpmin),abs(tmpmax));
				if isnan(tmpval)==1
					tmpval=0;
				end
				yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
			elseif (plt>=4 && plt<=15) || plt>=21%quad
				yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
			end              
			ylim(yrange)
			set(gca,'xtick',1:skiptick:50)
			set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
			grid on
			set(gca,'gridcolor','k','gridalpha',.15)
			set(gca,'fontsize',20)      
			hold off
			box on
			lh=legend(l,identexpshort,'location','northeast');
			lh.FontSize=10;
			set(gcf,'Units','inches');
			a1Pos = get(gca,'Position');
			set(gcf, 'InvertHardcopy', 'off')
			set(gcf,'Units','inches');
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')
			text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
			text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
			text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
			ax=gca;
			box on
			set(ax, 'Layer', 'bottom')
			ax.LineWidth=1; 
			set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
			set(gca,'Color',[.9 .9 .9])
			for tmp=1:size(identexp,1)
				cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
			end
			if sum([cntexp(:)])==0
				tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				set(tx, 'Layer', 'front')
			end          
			if plt==1 || plt>=4 && plt<=15 || plt==17 || plt==18 || plt>20
				 tx=text(0.02,0.05,'Too Small','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 tx=text(0.02,0.98,'Too Large','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 set(tx, 'Layer', 'front')  
			elseif plt==2 || plt==16
				 tx=text(0.02,0.05,'Too Low','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 tx=text(0.02,0.98,'Too High','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 set(tx, 'Layer', 'front')  
			elseif plt==3
				 tx=text(0.02,0.05,'Too Slow','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 tx=text(0.02,0.98,'Too Fast','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 set(tx, 'Layer', 'front') 
			elseif plt==19
				 tx=text(0.02,0.05,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 tx=text(0.02,0.98,'Faster than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 set(tx, 'Layer', 'front')            
			elseif plt==20
				 tx=text(0.02,0.05,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 tx=text(0.02,0.98,'Right of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 set(tx, 'Layer', 'front')            
			end
			b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
			set(b,'plotboxaspectratio',[1 1 1])
			set(b,'Color','none');
			set(b,'YColor','none');
			set(b,'tickdir','both')
			set(b,'XColor',[0 0 0]);
			set(b,'ytick',[]);
			if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
				if mod(identmaxfhr*3,12)==0
					xlim(b,[1 ((identmaxfhr*3))/skiphr+1])
					tmpxend=((identmaxfhr*3))/skiphr+1;
				else
					xlim(b,[1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
					tmpxend=((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1;
				end
			else
				if mod(identmaxfhr*3-3,12)==0
					xlim(b,[1 ((identmaxfhr*3)-3)/skiphr+1])
					tmpxend=((identmaxfhr*3)-3)/skiphr+1;
				else
					xlim(b,[1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
					tmpxend=((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1;
				end
			end        
			set(b,'xtick',[1:skiptick:50]);
			trkerr_exp_fcnt=zeros(1,tmpxend);            
			trkerr_exp_fcnt1=zeros(1,tmpxend);            
			trkerr_exp_fcnt2=zeros(1,tmpxend);
			for tmp=1:size(identexp,1)
				cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
			end  
			set(gca,'fontsize',14)
			xlabel('# fcsts','Position',[-1 0],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',90,'units','normalized'); 
			set(gca,'position',[spPos(1)+.02 spPos(2)-.05 spPos(3) spPos(4)])
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')
			% Create a text box at every Tick label position
			maxmin=squeeze(sum(~isnan(tmp_exp(:,1:skiptick:end,:)),1)); 
			xTicks0 = get(gca, 'xticklabel');
			xTicks = get(gca, 'xtick');
			if size(maxmin,1)<size(xTicks0,1)
				for n=1:size(xTicks0,1)-size(maxmin,1)
					maxmin(end+n,:)=0;
				end
			end
			set(b,'xticklabels',[]);
			minY =0;
			VerticalOffset1=0.03;
			HorizontalOffset = 0.2;
			for xx = 1:size(xTicks0,1)
				tmptxt0=maxmin(xx,:);
				tmplines=size(tmptxt0,2);
				if size(unique(tmptxt0),2)==1
					tmptxt1=num2str(tmptxt0(1)); 
					text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)                    
				else
					for n=1:tmplines
						tmptxt1=[];                            
						tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(n,:)),'}',num2str(tmptxt0(n))];                           
						if n==1
							text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)
						else
							text(xTicks(xx), minY - (VerticalOffset1+(.02*(n-1))),tmptxt1,'horizontalalignment','center','fontsize',14)                                
						end
					end    
				end
			end
			f = getframe(hfig);
			if identeps==1;filename=[identtrackint,'/FULL/',identn,'_',tmp_name];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
			close all
		end  
		% Create Graphics: trk, int, spd errors and Skill - bt-gh vs. bt-deny
		for med=1:2; for plt=[1:18,21:23]
			spPosA=[0.1886    0.6118    0.6328    0.7000/2.2];
			spPosB=[0.1886    0.2300    0.6328    0.7000/2.2];
			clear l cntexp
			set(0,'defaultfigurecolor',[1 1 1]) % figure background color
			hfig=figure;
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
			ax2=subplot(5,4,[9:16]);
			ax1=subplot(5,4,[1:8]);
			hold on
			if plt==1
				 tmp_exp=trkerr_exp(:,1:skip:end,:);
				 tmp_name='trkerr';
				 tmp_title='Track Error (km)';
				 tmp_ytitle='Error (km)';
			elseif plt==2
				tmp_exp=interr_exp(:,1:skip:end,:);
				tmp_name='prserr';
				tmp_title='Pressure Error (hPa)';
				tmp_ytitle='Error (hPa)';
			elseif plt==3
				tmp_exp=spderr_exp(:,1:skip:end,:);
				tmp_name='spderr';
				tmp_title='Wind Speed Error (m/s)';
				tmp_ytitle='Error (m/s)';
			elseif plt==4
				tmp_exp=ne34err_exp(:,1:skip:end,:);
				tmp_name='neRTSFerr';
				tmp_title='RTSF NEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==5
				tmp_exp=se34err_exp(:,1:skip:end,:);
				tmp_name='seRTSFerr';
				tmp_title='RTSF SEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==6
				tmp_exp=sw34err_exp(:,1:skip:end,:);
				tmp_name='swRTSFerr';
				tmp_title='RTSF SWQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==7
				tmp_exp=nw34err_exp(:,1:skip:end,:);
				tmp_name='nwRTSFerr';
				tmp_title='RTSF NWQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==8
				tmp_exp=ne50err_exp(:,1:skip:end,:);
				tmp_name='neRSFerr';
				tmp_title='RSF NEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==9
				tmp_exp=se50err_exp(:,1:skip:end,:);
				tmp_name='seRSFerr';
				tmp_title='RSF SEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==10
				tmp_exp=sw50err_exp(:,1:skip:end,:);
				tmp_name='swRSFerr';
				tmp_title='RSF SWQ Error (km)';
				tmp_ytitle='Error (km)';
				yrange=[0 200];
			elseif plt==11
				tmp_exp=nw50err_exp(:,1:skip:end,:);
				tmp_name='nwRSFerr';
				tmp_title='RSF NWQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==12
				tmp_exp=ne64err_exp(:,1:skip:end,:);
				tmp_name='neRHFerr';
				tmp_title='RHF NEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==13
				tmp_exp=se64err_exp(:,1:skip:end,:);
				tmp_name='seRHFerr';
				tmp_title='RHF SEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==14
				tmp_exp=sw64err_exp(:,1:skip:end,:);
				tmp_name='swRHFerr';
				tmp_title='RHF SWQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==15
				tmp_exp=nw64err_exp(:,1:skip:end,:);
				tmp_name='nwRHFerr';
				tmp_title='RHF NWQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==16
				tmp_exp=poerr_exp(:,1:skip:end,:);
				tmp_name='poerr';
				tmp_title='Outer Clsd Isbr Prs Error (hPa)';
				tmp_ytitle='Error (hPa)';
			elseif plt==17
				tmp_exp=roerr_exp(:,1:skip:end,:);
				tmp_name='roerr';
				tmp_title='Outer Clsd Isbr Rad Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==18
				tmp_exp=rmwerr_exp(:,1:skip:end,:);
				tmp_name='rmwerr';
				tmp_title='RMW Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==19
				tmp_exp=ateerr_exp(:,1:skip:end,:);
				tmp_name='ateerr';
				tmp_title='Along-Track Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==20
				tmp_exp=xteerr_exp(:,1:skip:end,:);
				tmp_name='xteerr';
				tmp_title='Across-Track Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==21
				tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
				tmp_name='RTSFerr';
				tmp_title='RTSF Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==22
				tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
				tmp_name='RSFerr';
				tmp_title='RSF Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==23
				tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
				tmp_name='RHFerr';
				tmp_title='RHF Error (km)';
				tmp_ytitle='Error (km)';
			end
			if plt <19 || plt >20
				tmp_exp=abs(tmp_exp); % added for MAE
			end

			% YRANGE
			clear allquad
			allquad(1)=(max(max(nanmean(abs(ne34err_exp(:,1:skip:end,:)),1))));
			allquad(2)=(max(max(nanmean(abs(se34err_exp(:,1:skip:end,:)),1))));
			allquad(3)=(max(max(nanmean(abs(nw34err_exp(:,1:skip:end,:)),1))));
			allquad(4)=(max(max(nanmean(abs(sw34err_exp(:,1:skip:end,:)),1))));
			allquad(5)=(max(max(nanmean(abs(ne50err_exp(:,1:skip:end,:)),1))));
			allquad(6)=(max(max(nanmean(abs(se50err_exp(:,1:skip:end,:)),1))));
			allquad(7)=(max(max(nanmean(abs(nw50err_exp(:,1:skip:end,:)),1))));
			allquad(8)=(max(max(nanmean(abs(sw50err_exp(:,1:skip:end,:)),1))));
			allquad(9)=(max(max(nanmean(abs(ne64err_exp(:,1:skip:end,:)),1))));
			allquad(10)=(max(max(nanmean(abs(se64err_exp(:,1:skip:end,:)),1))));
			allquad(11)=(max(max(nanmean(abs(nw64err_exp(:,1:skip:end,:)),1))));
			allquad(12)=(max(max(nanmean(abs(sw64err_exp(:,1:skip:end,:)),1))));
			allquadmax=max(max(max(allquad)));
			allquadmin=min(min(min(allquad)));
			tmpvalq=max(abs(allquadmin),abs(allquadmax));
			if isnan(tmpvalq)==1
				tmpvalq=0;
			end
			if numel(num2str(tmpvalq))==3
				addfacq=100;
			elseif numel(num2str(tmpvalq))==2
				addfacq=20;
			else 
				addfacq=20;
			end
			if numel(num2str(round(max(max(nanmean((tmp_exp),1))))))==3
				addfac=100;
			elseif numel(num2str(round(max(max(nanmean((tmp_exp),1))))))==2
				addfac=20;
			else
				addfac=20;
			end
			if plt<=3 || (plt>=16 && plt<=18) % 0-end
				tmpmin=min(min(nanmean((tmp_exp),1)));
				tmpmax=max(max(nanmean((tmp_exp),1)));
				tmpval=max(abs(tmpmin),abs(tmpmax));
				if isnan(tmpval)==1
					tmpval=0;
				end               
				yrange=[0 round((tmpval+addfac)/10)*10];                
			elseif plt==19 || plt==20 % -end end 
				tmpmin=min(min(nanmean((tmp_exp),1)));
				tmpmax=max(max(nanmean((tmp_exp),1)));
				tmpval=max(abs(tmpmin),abs(tmpmax));
				if isnan(tmpval)==1
					tmpval=0;
				end 
				yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
			elseif (plt>=4 && plt<=15) || plt>=21%quad
				yrange=[0 round((tmpvalq+addfacq)/10)*10];
			end

			for tmp=1:size(identexp,1)
				if med==1; l(tmp)=plot(1:size(tmp_exp,2),nanmean(tmp_exp(:,:,tmp),1),'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2); elseif med==2; l(tmp)=plot(1:size(tmp_exp,2),nanmedian(tmp_exp(:,:,tmp),1),'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2); end;
			end           
			% Find which experiment to compare to
			for tmp=1:size(identexp,1)
				if strcmp(identexp(tmp),identexpsigimp)
					tmpimp=tmp;
				end
			end
			plot(-10:89,zeros(1,100),'Color',[.5 .5 .5],'linewidth',2);
			for tmp=1:size(identexp,1)
				sigtest=ttestsc(tmp_exp(:,:,tmp),tmp_exp(:,:,tmpimp),squeeze(scfactor(plt,tmp,:))','alpha',.05);
				sigtest_loc=find(sigtest==1);
				if med==1; sigtest_exp=nanmean(tmp_exp(:,sigtest_loc,:),1); elseif med==2; sigtest_exp=nanmedian(tmp_exp(:,sigtest_loc,:),1); end;
				for tmpi=tmp
					plot(sigtest_loc,sigtest_exp(:,:,tmpi),'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',8)
				end
				sigtest=ttestsc(tmp_exp(:,:,tmp),tmp_exp(:,:,tmpimp),squeeze(scfactor(plt,tmp,:))','alpha',.1);
				sigtest_loc1=find(sigtest==1);
				sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
				if med==1; sigtest_exp=nanmean(tmp_exp(:,sigtest_loc,:),1); elseif med==2; sigtest_exp=nanmedian(tmp_exp(:,sigtest_loc,:),1); end;
				for tmpi=tmp
					plot(sigtest_loc,sigtest_exp(:,:,tmpi),'o','Color','k','markersize',6,'markerfacecolor',identexpcolors(tmp,:))
				end
			end   
			set(ax1,'position',spPosA)
			ylabel(tmp_ytitle,'fontsize',20)
			set(gca,'fontsize',20)
			box on
			if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
				if mod(identmaxfhr*3,12)==0
					xlim([1 ((identmaxfhr*3))/skiphr+1])
				else
					xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
				end
			else
				if mod(identmaxfhr*3-3,12)==0
					xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
				else
					xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
				end
			end
			ylim(yrange)
			set(gca,'xtick',1:skiptick:50)
			set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
			set(gca,'xticklabel',[]) 
			grid on
			set(gca,'gridcolor','k','gridalpha',.15)
			set(gca,'fontsize',20)      
			hold off
			box on
			lh=legend(l,identexpshort,'location','northeast');
			lh.FontSize=10;
			set(gcf,'Units','inches');
			a1Pos = get(gca,'Position');
			set(gcf, 'InvertHardcopy', 'off')
			set(gcf,'Units','inches');
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')
			if med==1;text(0,1.145,['\textbf{Mean ',tmp_title,' \& Skill (\%)}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');elseif med==2;text(0,1.145,['\textbf{Median ',tmp_title,' \& Skill (\%)}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');end;
			text(0,1.07,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
			text(1,1.07,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
			box on
			set(ax1, 'Layer', 'bottom')
			ax1.LineWidth=1; 
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
			set(ax1,'Color',[.9 .9 .9])
			for tmp=1:size(identexp,1)
				cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
			end
			if sum([cntexp(:)])==0
				tx=text(0.99,0.1,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				set(tx, 'Layer', 'front')
			end          
			if plt==19
				 tx=text(0.01,0.1,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 tx=text(0.01,0.965,'Faster than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 set(tx, 'Layer', 'front')            
			elseif plt==20
				 tx=text(0.01,0.1,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 tx=text(0.01,0.965,'Right of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 set(tx, 'Layer', 'front')            
			end

			ax2=subplot(5,4,[9:16]);
			hold on
			if plt==1
				 tmp_exp=trkerr_exp(:,1:skip:end,:);
				 tmp_name='trkerrskill';
				 tmp_title='Track Skill (\%)';
				 tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==2
				tmp_exp=interr_exp(:,1:skip:end,:);
				tmp_name='prserrskill';
				tmp_title='Pressure Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==3
				tmp_exp=spderr_exp(:,1:skip:end,:);
				tmp_name='spderrskill';
				tmp_title='Wind Speed Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			 elseif plt==4
				tmp_exp=ne34err_exp(:,1:skip:end,:);
				tmp_name='neRTSFerrskill';
				tmp_title='RTSF NEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==5
				tmp_exp=se34err_exp(:,1:skip:end,:);
				tmp_name='seRTSFerrskill';
				tmp_title='RTSF SEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==6
				tmp_exp=sw34err_exp(:,1:skip:end,:);
				tmp_name='swRTSFerrskill';
				tmp_title='RTSF SWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==7
				tmp_exp=nw34err_exp(:,1:skip:end,:);
				tmp_name='nwRTSFerrskill';
				tmp_title='RTSF NWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==8
				tmp_exp=ne50err_exp(:,1:skip:end,:);
				tmp_name='neRSFerrskill';
				tmp_title='RSF NEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==9
				tmp_exp=se50err_exp(:,1:skip:end,:);
				tmp_name='seRSFerrskill';
				tmp_title='RSF SEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==10
				tmp_exp=sw50err_exp(:,1:skip:end,:);
				tmp_name='swRSFerrskill';
				tmp_title='RSF SWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==11
				tmp_exp=nw50err_exp(:,1:skip:end,:);
				tmp_name='nwRSFerrskill';
				tmp_title='RSF NWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==12
				tmp_exp=ne64err_exp(:,1:skip:end,:);
				tmp_name='neRHFerrskill';
				tmp_title='RHF NEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==13
				tmp_exp=se64err_exp(:,1:skip:end,:);
				tmp_name='seRHFerrskill';
				tmp_title='RHF SEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==14
				tmp_exp=sw64err_exp(:,1:skip:end,:);
				tmp_name='swRHFerrskill';
				tmp_title='RHF SWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==15
				tmp_exp=nw64err_exp(:,1:skip:end,:);
				tmp_name='nwRHFerrskill';
				tmp_title='RHF NWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==16
				tmp_exp=poerr_exp(:,1:skip:end,:);
				tmp_name='poerrskill';
				tmp_title='Outer Clsd Isbr Prs Skill (hPa)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==17
				tmp_exp=roerr_exp(:,1:skip:end,:);
				tmp_name='roerrskill';
				tmp_title='Outer Clsd Isbr Rad Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==18
				tmp_exp=rmwerr_exp(:,1:skip:end,:);
				tmp_name='rmwerrskill';
				tmp_title='RMW Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==19
				tmp_exp=ateerr_exp(:,1:skip:end,:);
				tmp_name='ateerrskill';
				tmp_title='Along-Track Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==20
				tmp_exp=xteerr_exp(:,1:skip:end,:);
				tmp_name='xteerrskill';
				tmp_title='Across-Track Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==21
				tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
				tmp_name='RTSFerrskill';
				tmp_title='RTSF Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==22
				tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
				tmp_name='RSFerrskill';
				tmp_title='RSF Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==23
				tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
				tmp_name='RHFerrskill';
				tmp_title='RHF Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			end
			if plt <19 || plt >20
				tmp_exp=abs(tmp_exp); % added for MAE
			end                        % Find which experiment to compare to
			for tmp=1:size(identexp,1)
				if strcmp(identexp(tmp),identexpsigimp)
					tmpimp=tmp;
				end
			end
			tmpu=1:size(identexp,1);
			tmpu(tmpu==tmpimp)=[];
			plot(-10:89,zeros(1,100),'Color',[.5 .5 .5],'linewidth',2);
			for tmp=[tmpimp,tmpu]
				if med==1; imprv=100.*(1-abs(nanmean(tmp_exp(:,:,tmp),1))./abs(nanmean(tmp_exp(:,:,tmpimp),1))); elseif med==2; imprv=100.*(1-abs(nanmedian(tmp_exp(:,:,tmp),1))./abs(nanmedian(tmp_exp(:,:,tmpimp),1))); end;                 
				imprv2(:,tmp)=imprv; imprvmedian(:,tmp)=100.*(1-nanmean(tmp_exp(:,:,tmp),1)./nanmean(tmp_exp(:,:,tmpimp),1));
				l(tmp)=plot(1:size(imprv,2),imprv,'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2); 
				sigtest=ttestsc(tmp_exp(:,:,tmp),tmp_exp(:,:,tmpimp),squeeze(scfactor(plt,tmp,:))','alpha',.05);
				sigtest_loc=find(sigtest==1);
				sigtest_exp=imprv(sigtest_loc);
				plot(sigtest_loc,sigtest_exp,'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',8)
				sigtest=ttestsc(tmp_exp(:,:,tmp),tmp_exp(:,:,tmpimp),squeeze(scfactor(plt,tmp,:))','alpha',.1);
				sigtest_loc1=find(sigtest==1);
				sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
				sigtest_exp=imprv(sigtest_loc);
				plot(sigtest_loc,sigtest_exp,'o','Color','k','markersize',6,'markerfacecolor',identexpcolors(tmp,:))
			end   
			set(ax2,'position',spPosB)
			xlabel('Forecast Lead Time (h)','fontsize',20)
			ylabel('Skill (%)','fontsize',20)
			set(gca,'fontsize',20)
			box on
			if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
				if mod(identmaxfhr*3,12)==0
					xlim([1 ((identmaxfhr*3))/skiphr+1])
				else
					xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
				end
			else
				if mod(identmaxfhr*3-3,12)==0
					xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
				else
					xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
				end
			end
			% YRANGE
			clear allquad imprv3
			imprv3(:,:,1)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,2)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,3)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,4)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,5)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,6)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,7)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,8)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,9)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,10)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,11)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
			imprv3(:,:,12)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
			allquadmax=max(max(max(imprv3)));
			allquadmin=min(min(min(imprv3)));
			tmpvalq=max(abs(allquadmin),abs(allquadmax));
			if isnan(tmpvalq)==1
				tmpvalq=0;
			end
			if numel(num2str(tmpvalq))==3
				addfacq=100;
			elseif numel(num2str(tmpvalq))==2
				addfacq=20;
			else
				addfacq=20;
			end
			if numel(num2str(round(max(imprvmedian(:)))))==3
				addfac=100;
			elseif numel(num2str(round(max(imprvmedian(:)))))==2
				addfac=20;
			else
				addfac=20;
			end
			if plt<=3 || (plt>=16 && plt<=18) % 0-end
				tmpmin=min(imprvmedian(:));
				tmpmax=max(imprvmedian(:));
				tmpval=max(abs(tmpmin),abs(tmpmax));
				if isnan(tmpval)==1
					tmpval=0;
				end
				if tmpval>250
					yrange=[-250 250];
				else
					yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
				end
			elseif plt==19 || plt==20 % -end end 
				tmpmin=min(imprvmedian(:));
				tmpmax=max(imprvmedian(:));
				tmpval=max(abs(tmpmin),abs(tmpmax));
				if isnan(tmpval)==1
					tmpval=0;
				end
				if tmpval>250
					yrange=[-250 250];
				else
					yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
				end
			elseif (plt>=4 && plt<=15) || plt>=21%quad                   
				if tmpvalq>250
					yrange=[-250 250];
				else
					yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
				end
			end
			ylim(yrange)
			if yrange(end)>=200
				set(gca,'ytick',yrange(1):100:yrange(end))
			elseif yrange(end)>=100
				set(gca,'ytick',yrange(1):50:yrange(end))
			elseif yrange(end)>=50
				set(gca,'ytick',yrange(1):20:yrange(end))
			else
				set(gca,'ytick',yrange(1):10:yrange(end))
			end
			set(gca,'xtick',1:skiptick:50)
			set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
			grid on
			set(gca,'gridcolor','k','gridalpha',.15)
			set(gca,'fontsize',20)      
			hold off
			box on
			set(gcf,'Units','inches');
			a1Pos = get(gca,'Position');
			set(gcf, 'InvertHardcopy', 'off')
			set(gcf,'Units','inches');
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')
			box on
			set(ax2, 'Layer', 'bottom')
			ax2.LineWidth=1; 
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
			set(ax2,'Color',[.9 .9 .9])   
			% Mean Value            
			tmpstr=['Mean: '];
			imprv2(imprv2==-Inf)=0;
			imprv2(imprv2==Inf)=0;
			tmpstrmean=nanmean(imprv2(1:(identmaxfhr+1)/2,:),1);
			tmpstrmean=(find(tmpstrmean~=0));
			if size(tmpstrmean,2)>0
				for tmp=tmpstrmean
				if tmp==tmpstrmean(end)
					tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(imprv2(1:(identmaxfhr+1)/2,tmp)),2)),'%'];
				else
					tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(imprv2(1:(identmaxfhr+1)/2,tmp)),2)),'% \color[rgb]{0,0,0}| '];
				end
				end
			else
				tmpstr='';
			end
			if sum(sum(~isnan(imprv2)))==0
				tx=text(0.99,0.1,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				set(tx, 'Layer', 'front')          
			else
				tx=text(0.99,0.1,tmpstr,'HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				set(tx, 'Layer', 'front')
			end 
			b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
			set(b,'Color','none');
			set(b,'YColor','none');
			set(b,'tickdir','both')
			set(b,'XColor',[0 0 0]);
			set(b,'ytick',[]);
			if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
				if mod(identmaxfhr*3,12)==0
					xlim(b,[1 ((identmaxfhr*3))/skiphr+1])
					tmpxend=((identmaxfhr*3))/skiphr+1;
				else
					xlim(b,[1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
					tmpxend=((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1;
				end
			else
				if mod(identmaxfhr*3-3,12)==0
					xlim(b,[1 ((identmaxfhr*3)-3)/skiphr+1])
					tmpxend=((identmaxfhr*3)-3)/skiphr+1;
				else
					xlim(b,[1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
					tmpxend=((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1;
				end
			end        
			set(b,'xtick',[1:skiptick:50]); 
			trkerr_exp_fcnt=zeros(1,tmpxend);            
			trkerr_exp_fcnt1=zeros(1,tmpxend);            
			trkerr_exp_fcnt2=zeros(1,tmpxend);
			for tmp=1:size(identexp,1)
				cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
			end  
			set(gca,'fontsize',14)            
			xlabel('# fcsts','Position',[-1 0],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',90,'units','normalized'); 
			set(gca,'position',[spPosB(1) spPosB(2)-.1 spPosB(3) spPosB(4)])
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')
			% Create a text box at every Tick label position
			maxmin=squeeze(sum(~isnan(tmp_exp(:,1:skiptick:end,:)),1)); 
			xTicks0 = get(gca, 'xticklabel');
			xTicks = get(gca, 'xtick');
			if size(maxmin,1)<size(xTicks0,1)
				for n=1:size(xTicks0,1)-size(maxmin,1)
					maxmin(end+n,:)=0;
				end
			end
			set(b,'xticklabels',[]);
			minY =0;
			VerticalOffset1=0.07;
			HorizontalOffset = 0.2;
			for xx = 1:size(xTicks0,1)
				tmptxt0=maxmin(xx,:);
				tmplines=size(tmptxt0,2);
				if size(unique(tmptxt0),2)==1
					tmptxt1=num2str(tmptxt0(1)); 
					text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)                    
				else
					for n=1:tmplines
						tmptxt1=[];                            
						tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(n,:)),'}',num2str(tmptxt0(n))];                           
						if n==1
							text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)
						else
							text(xTicks(xx), minY - (VerticalOffset1+(.05*(n-1))),tmptxt1,'horizontalalignment','center','fontsize',14)                                
						end
					end    
				end
			end
			f = getframe(hfig);
			if med==1; if identeps==1;filename=[identtrackint,'/FULL/',identn,'_',tmp_name,'_mean'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;elseif med==2;if identeps==1;filename=[identtrackint,'/FULL/',identn,'_',tmp_name,'_median'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;end;
			close all
		end;end              
		spPos=[0.11 0.13+.05 0.75 0.75-.05]; % arrange plots the same
		clPos=[0.88 0.13+.05 0.04 0.75-.05]; % arrange plots the same
		% Create Graphics: Cycle-By-Cycle Skill Graphics!!!
		for plt=[1:18,21:23] % no across or along for bias
			clear l cntexp nm_pct
			if plt==1
				 tmp_exp=trkerr_exp(:,1:skip:end,:);
				 tmp_name='trkerr';
				 tmp_title='Cycle-By-Cycle Track Skill (\%)';
				 tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==2
				tmp_exp=interr_exp(:,1:skip:end,:);
				tmp_name='prserr';
				tmp_title='Cycle-By-Cycle Pressure Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==3
				tmp_exp=spderr_exp(:,1:skip:end,:);
				tmp_name='spderr';
				tmp_title='Cycle-By-Cycle Wind Speed Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			 elseif plt==4
				tmp_exp=ne34err_exp(:,1:skip:end,:);
				tmp_name='neRTSFerr';
				tmp_title='Cycle-By-Cycle RTSF NEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==5
				tmp_exp=se34err_exp(:,1:skip:end,:);
				tmp_name='seRTSFerr';
				tmp_title='Cycle-By-Cycle RTSF SEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==6
				tmp_exp=sw34err_exp(:,1:skip:end,:);
				tmp_name='swRTSFerr';
				tmp_title='Cycle-By-Cycle RTSF SWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==7
				tmp_exp=nw34err_exp(:,1:skip:end,:);
				tmp_name='nwRTSFerr';
				tmp_title='Cycle-By-Cycle RTSF NWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==8
				tmp_exp=ne50err_exp(:,1:skip:end,:);
				tmp_name='neRSFerr';
				tmp_title='Cycle-By-Cycle RSF NEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==9
				tmp_exp=se50err_exp(:,1:skip:end,:);
				tmp_name='seRSFerr';
				tmp_title='Cycle-By-Cycle RSF SEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==10
				tmp_exp=sw50err_exp(:,1:skip:end,:);
				tmp_name='swRSFerr';
				tmp_title='Cycle-By-Cycle RSF SWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==11
				tmp_exp=nw50err_exp(:,1:skip:end,:);
				tmp_name='nwRSFerr';
				tmp_title='Cycle-By-Cycle RSF NWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==12
				tmp_exp=ne64err_exp(:,1:skip:end,:);
				tmp_name='neRHFerr';
				tmp_title='Cycle-By-Cycle RHF NEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==13
				tmp_exp=se64err_exp(:,1:skip:end,:);
				tmp_name='seRHFerr';
				tmp_title='Cycle-By-Cycle RHF SEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==14
				tmp_exp=sw64err_exp(:,1:skip:end,:);
				tmp_name='swRHFerr';
				tmp_title='Cycle-By-Cycle RHF SWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-100 100];                 
			elseif plt==15
				tmp_exp=nw64err_exp(:,1:skip:end,:);
				tmp_name='nwRHFerr';
				tmp_title='Cycle-By-Cycle RHF NWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==16
				tmp_exp=poerr_exp(:,1:skip:end,:);
				tmp_name='poerr';
				tmp_title='Cycle-By-Cycle Outer Clsd Isbr Prs Skill (hPa)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==17
				tmp_exp=roerr_exp(:,1:skip:end,:);
				tmp_name='roerr';
				tmp_title='Cycle-By-Cycle Outer Clsd Isbr Rad Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==18
				tmp_exp=rmwerr_exp(:,1:skip:end,:);
				tmp_name='rmwerr';
				tmp_title='Cycle-By-Cycle RMW Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==19
				tmp_exp=ateerr_exp(:,1:skip:end,:);
				tmp_name='ateerr';
				tmp_title='Cycle-By-Cycle Along-Track Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==20
				tmp_exp=xteerr_exp(:,1:skip:end,:);
				tmp_name='xteerr';
				tmp_title='Cycle-By-Cycle Across-Track Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==21
				tmp_exp1=cat(4,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
				tmp_exp=nansum(tmp_exp1,4);
				tmp_exp(all(isnan(tmp_exp1),4))=NaN;
				tmp_name='RTSFerr';
				tmp_title='Cycle-By-Cycle RTSF Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==22
				tmp_exp1=cat(4,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
				tmp_exp=nansum(tmp_exp1,4);
				tmp_exp(all(isnan(tmp_exp1),4))=NaN;
				tmp_name='RSFerr';
				tmp_title='Cycle-By-Cycle RSF Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			elseif plt==23
				tmp_exp1=cat(4,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
				tmp_exp=nansum(tmp_exp1,4);
				tmp_exp(all(isnan(tmp_exp1),4))=NaN;
				tmp_name='RHFerr';
				tmp_title='Cycle-By-Cycle RHF Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
			end
			if plt <19 || plt >20
				tmp_exp=abs(tmp_exp); % added for MAE
			end
			tmp_exp0=tmp_exp;
			

			% calculate Skill by cycle
			for tmp=1:size(identexp,1);if strcmp(identexp(tmp),identexpsigimp);tmpimp=tmp;end;end;tmpu=1:size(identexp,1);tmpu(tmpu==tmpimp)=[];
			for tmp=[tmpimp,tmpu]
				imprv=squeeze(100.*(1-(tmp_exp(:,:,tmp))./(tmp_exp(:,:,tmpimp))));nm_pct(:,tmp,:)=imprv;
			end
			nm_pct=permute(nm_pct,[3 2 1]);


			for identexploop=tmpu
				tmppct=squeeze(nm_pct(:,identexploop,:));
				tmpstd=nanstd(tmppct');
				tmpmn=nanmean(tmppct,2);
				tmpval=(tmpmn+tmpstd');
				set(0,'defaultfigurecolor',[1 1 1]) % figure background color
				hfig=figure;
				set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
				ax1=subplot(3,4,[1:8]);
				imagesc((tmppct)','AlphaData',~isnan((tmppct)'))
				xlabel('Forecast Lead Time (h)','fontsize',14)        
				set(gca,'fontsize',14)
				box on
				if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
					if mod(identmaxfhr*3,12)==0
						xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5])
					else
						xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]) 
					end
				else
					if mod(identmaxfhr*3-3,12)==0
						xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5])
					else
						xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]) 
					end
				end    
				set(gca,'xtick',1:skiptick:50)
				set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
				set(gca,'fontsize',14)
				hold on                        
				ylabel('Cycle Initialization Time','fontsize',14)
							box on
							xstart=1;          
							ylim([xstart-.5 size(BT_lat,1)+.5])                                                   
							if size(identinittimesunique,1)>50
								set(gca,'ytick',1:4:100)
								set(gca,'yticklabel',identinittimesunique(1:4:end,:))
							else
								set(gca,'ytick',1:2:100)
								set(gca,'yticklabel',identinittimesunique(1:2:end,:))
							end                           
				set(gca,'fontsize',14)
				cnt=1;                                       
				colorbar
				caxis([-50 50])
                colormap(gca,custommap(20,negposc))
				hold on
				for i=1:size(tmppct,1)
					plot(repmat(0.5+i,1,size(identdr,2)+3),-1:size(identdr,2)+1,'k')
				end
				for i=1:size(tmppct,2)
					plot(-1:size(tmppct,1)+1,repmat(i-.5,1,size(tmppct,1)+3),'k')
				end
				set(gcf, 'InvertHardcopy', 'off')
				set(gcf,'Units','inches');
				screenposition = get(gcf,'Position');
				set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
				set(gcf, 'InvertHardcopy', 'off')
				tmppctstr=isnan(tmppct);
				clear diffpct
				for j=1:size(tmppct,2)
					for i=1:size(1:skip:identmaxfhr,2)
						if tmppctstr(i,j)==0
							%if sum(round(tmppct(i,:)))>100
							%	for k=1:size(tmppct,2)
							%		diffpct(k)=round(tmppct(i,k))-tmppct(i,k);
							%	end
							%	tmppct(i,find(diffpct==max(diffpct')))=tmppct(i,find(diffpct==max(diffpct')))-diffpct(k);
							%elseif sum(round(tmppct(i,:)))<100
							%	for k=1:size(tmppct,2)
							%		diffpct(k)=round(tmppct(i,k))-tmppct(i,k);
							%	end
							%	tmppct(i,find(diffpct==max(diffpct')))=tmppct(i,find(diffpct==max(diffpct')))+diffpct(k);
							%end
								if tmppct(i,j)>25 || tmppct(i,j)<-25
									text(i,j, [num2str(round(tmppct(i,j))),'%'], 'color','w','HorizontalAlignment', 'Center','fontsize',6)
								else
									text(i,j, [num2str(round(tmppct(i,j))),'%'], 'HorizontalAlignment', 'Center','fontsize',6)
								end
						end
					end
				end        
				set(gca,'TickLength',[0 0])										
				text(0,1.052,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')                                        
				text(1,1.052,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
				text(0,1.025,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
				text(1,1.025,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');                																										
				ax=gca;
				box on
				set(ax, 'Layer', 'top')
				ax.LineWidth=1; 
				pos=get(gca,'Position');
				set(gca,'position',[pos(1)+.01 pos(2)-.33 pos(3) pos(4)+.34])
				set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .9, 0.96]); % maximize figure window
				f = getframe(hfig);
				if identeps==1;filename=[identtrackint,'/FULL/',identn,'_',tmp_name,'_contr_',identexpshort{identexploop}];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
				close all   
			end 														
		end  																							
		% Create PPC Graphics
		for plt=[1:18,21:23] % no across or along for bias
			clear l cntexp                                   
			if plt==1
				 tmp_exp=trkerr_exp(:,1:skip:end,:);
				 tmp_name='trkerr';
				 tmp_title='Percentage Point Contribution to Track Skill (\%)';
				 tmp_ytitle='Error Contribution (\%)';
			elseif plt==2
				tmp_exp=interr_exp(:,1:skip:end,:);
				tmp_name='prserr';
				tmp_title='Percentage Point Contribution to Pressure Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==3
				tmp_exp=spderr_exp(:,1:skip:end,:);
				tmp_name='spderr';
				tmp_title='Percentage Point Contribution to Wind Speed Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			 elseif plt==4
				tmp_exp=ne34err_exp(:,1:skip:end,:);
				tmp_name='neRTSFerr';
				tmp_title='Percentage Point Contribution to RTSF NEQ Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==5
				tmp_exp=se34err_exp(:,1:skip:end,:);
				tmp_name='seRTSFerr';
				tmp_title='Percentage Point Contribution to RTSF SEQ Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==6
				tmp_exp=sw34err_exp(:,1:skip:end,:);
				tmp_name='swRTSFerr';
				tmp_title='Percentage Point Contribution to RTSF SWQ Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==7
				tmp_exp=nw34err_exp(:,1:skip:end,:);
				tmp_name='nwRTSFerr';
				tmp_title='Percentage Point Contribution to RTSF NWQ Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==8
				tmp_exp=ne50err_exp(:,1:skip:end,:);
				tmp_name='neRSFerr';
				tmp_title='Percentage Point Contribution to RSF NEQ Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==9
				tmp_exp=se50err_exp(:,1:skip:end,:);
				tmp_name='seRSFerr';
				tmp_title='Percentage Point Contribution to RSF SEQ Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==10
				tmp_exp=sw50err_exp(:,1:skip:end,:);
				tmp_name='swRSFerr';
				tmp_title='Percentage Point Contribution to RSF SWQ Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==11
				tmp_exp=nw50err_exp(:,1:skip:end,:);
				tmp_name='nwRSFerr';
				tmp_title='Percentage Point Contribution to RSF NWQ Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==12
				tmp_exp=ne64err_exp(:,1:skip:end,:);
				tmp_name='neRHFerr';
				tmp_title='Percentage Point Contribution to RHF NEQ Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==13
				tmp_exp=se64err_exp(:,1:skip:end,:);
				tmp_name='seRHFerr';
				tmp_title='Percentage Point Contribution to RHF SEQ Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==14
				tmp_exp=sw64err_exp(:,1:skip:end,:);
				tmp_name='swRHFerr';
				tmp_title='Percentage Point Contribution to RHF SWQ Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
				yrange=[-100 100];                 
			elseif plt==15
				tmp_exp=nw64err_exp(:,1:skip:end,:);
				tmp_name='nwRHFerr';
				tmp_title='Percentage Point Contribution to RHF NWQ Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==16
				tmp_exp=poerr_exp(:,1:skip:end,:);
				tmp_name='poerr';
				tmp_title='Percentage Point Contribution to Outer Clsd Isbr Prs Skill (hPa)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==17
				tmp_exp=roerr_exp(:,1:skip:end,:);
				tmp_name='roerr';
				tmp_title='Percentage Point Contribution to Outer Clsd Isbr Rad Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==18
				tmp_exp=rmwerr_exp(:,1:skip:end,:);
				tmp_name='rmwerr';
				tmp_title='Percentage Point Contribution to RMW Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==19
				tmp_exp=ateerr_exp(:,1:skip:end,:);
				tmp_name='ateerr';
				tmp_title='Percentage Point Contribution to Along-Track Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==20
				tmp_exp=xteerr_exp(:,1:skip:end,:);
				tmp_name='xteerr';
				tmp_title='Percentage Point Contribution to Across-Track Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==21
				tmp_exp=cat(4,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
				tmp_exp1=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
				tmp_name='RTSFerr';
				tmp_title='Percentage Point Contribution to RTSF Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==22
				tmp_exp=cat(4,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
				tmp_exp1=cat(4,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
				tmp_name='RSFerr';
				tmp_title='Percentage Point Contribution to RSF Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			elseif plt==23
				tmp_exp=cat(4,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
				tmp_exp1=cat(4,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
				tmp_name='RHFerr';
				tmp_title='Percentage Point Contribution to RHF Skill (\%)';
				tmp_ytitle='Error Contribution (\%)';
			end
			if plt <19 || plt >20
				tmp_exp=abs(tmp_exp); % added for MAE
			end
			 % Find which experiment to compare to
			for tmp=1:size(identexp,1)
				if strcmp(identexp(tmp),identexpsigimp)
					tmpimp=tmp;
				end
			end 
			tmpu=1:size(identexp,1);
			tmpu(tmpu==tmpimp)=[];
			if plt>=21
				tmp_exp1=abs(tmp_exp1); % added for MAE
				tmp_exp0=squeeze(100.*(1-nanmean(tmp_exp1(:,:,:),1)./nanmean(tmp_exp1(:,:,tmpimp),1)));                  
			else
				tmp_exp0=squeeze(100.*(1-nanmean(tmp_exp(:,:,:),1)./nanmean(tmp_exp(:,:,tmpimp),1)));                  
			end		
			clear imprv imprv2 sm
			if plt>=21
				for tmp=[tmpimp,tmpu]
					for istm=1:size(tmp_exp,2)
						smpsz=sum(sum(~isnan(squeeze(tmp_exp(:,istm,:,:))),1),3);
						stmerr=nansum(squeeze((tmp_exp(:,istm,tmp,:))),2)./smpsz(tmp);stmerrnan=squeeze(sum((isnan(tmp_exp(:,istm,tmp,:))),1));stmerr(stmerrnan==200)=NaN;
						%stmerr(all(isnan(squeeze((tmp_exp(:,istm,tmp,:)))),2))=NaN;
						imperr=nansum(squeeze((tmp_exp(:,istm,tmpimp,:))),2)./smpsz(tmpimp);imperrnan=squeeze(sum((isnan(tmp_exp(:,istm,tmpimp,:))),1));imperr(imperrnan==200)=NaN;
						%imperr(all(isnan(squeeze((tmp_exp(:,istm,tmpimp,:)))),2))=NaN;
						imperrsum=nansum(nansum(squeeze((tmp_exp(:,istm,tmpimp,:))),1))./smpsz(tmpimp);;
						imprv0=-100.*(((stmerr-imperr)+imperrsum)./imperrsum-1);
						imprv0(all(isnan(squeeze((tmp_exp(:,istm,tmp,:))))&isnan(squeeze((tmp_exp(:,istm,tmpimp,:)))),2))=NaN;
						imprv(istm,:)=imprv0;
						sm(istm)=nansum(imprv(istm,:));
					end  
					imprv2(:,:,tmp)=imprv;     										
				end  
			else
				for tmp=[tmpimp,tmpu]
					for istm=1:size(tmp_exp,2)
						smpsz=sum(~isnan(squeeze(tmp_exp(:,istm,:))),1); if size(tmp_exp,1)==1 smpsz=sum(~isnan(squeeze(tmp_exp(:,istm,:))'),1); end
						stmerr=squeeze((tmp_exp(:,istm,tmp)))./smpsz(tmp);stmerrnan=squeeze(sum((isnan(tmp_exp(:,istm,tmp,:))),1));stmerr(stmerrnan==200)=NaN;
						imperr=squeeze((tmp_exp(:,istm,tmpimp)))./smpsz(tmpimp); imperrnan=squeeze(sum((isnan(tmp_exp(:,istm,tmpimp,:))),1));imperr(imperrnan==200)=NaN;
						imperrsum=nansum(squeeze((tmp_exp(:,istm,tmpimp))),1)./smpsz(tmpimp);;
						imprv(istm,:)=-100.*(((stmerr-imperr)+imperrsum)./imperrsum-1);
						sm(istm)=nansum(imprv(istm,:));
					end  
					imprv2(:,:,tmp)=imprv;     										
				end  
			end
			nm_pct = imprv2;
			clear imprv imprv2 sm
			
			for identexploop=tmpu
				tmppct=squeeze(nm_pct(:,:,identexploop));                                       
				set(0,'defaultfigurecolor',[1 1 1]) % figure background color
				hfig=figure;
				set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
				ax1=subplot(3,4,[1:8]);
				imagesc((tmppct)','AlphaData',~isnan((tmppct)'))
				xlabel('Forecast Lead Time (h)','fontsize',14)        
				set(gca,'fontsize',14)
				box on
				if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
					if mod(identmaxfhr*3,12)==0
						xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5])
					else
						xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]) 
					end
				else
					if mod(identmaxfhr*3-3,12)==0
						xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5])
					else
						xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]) 
					end
				end    
				set(gca,'xtick',1:skiptick:50)
				set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
				set(gca,'fontsize',14)
				hold on                        
				ylabel('Cycle Initialization Time','fontsize',14)
				set(gca,'fontsize',14)
				box on
				xstart=1;          
				ylim([xstart-.5 size(BT_lat,1)+.5])                                                   
				if size(identinittimesunique,1)>50
					set(gca,'ytick',1:4:100)
					set(gca,'yticklabel',identinittimesunique(1:4:end,:))
				else
					set(gca,'ytick',1:2:100)
					set(gca,'yticklabel',identinittimesunique(1:2:end,:))
				end                           
				set(gca,'fontsize',14)
				cnt=1;                       
				colorbar
				caxis([-5 5])
				run customcolorbars
				cl=colorbar;
				colormap(gca,custommap(20,negposc))														
				hold on
				for i=1:size(tmppct,1)
					plot(repmat(0.5+i,1,size(identdr,2)+3),-1:size(identdr,2)+1,'k')
				end
				for i=1:size(tmppct,2)
					plot(-1:size(tmppct,1)+1,repmat(i-.5,1,size(tmppct,1)+3),'k')
				end
				set(gcf, 'InvertHardcopy', 'off')
				set(gcf,'Units','inches');
				screenposition = get(gcf,'Position');
				set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
				set(gcf, 'InvertHardcopy', 'off')
				tmppctstr=isnan(tmppct);
				clear diffpct
				for j=1:size(tmppct,2)
					for i=1:size(1:skip:identmaxfhr,2)
						if tmppctstr(i,j)==0                                                   
								if tmppct(i,j)>5/2 || tmppct(i,j)<-5/2
									text(i,j, [num2str(round(tmppct(i,j),1)),'%'], 'color','w','HorizontalAlignment', 'Center','fontsize',6)
								else
									text(i,j, [num2str(round(tmppct(i,j),1)),'%'], 'HorizontalAlignment', 'Center','fontsize',6)
								end
						end
					end
				end        
				set(gca,'TickLength',[0 0])
				text(1,1.06,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
				text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')                                        										
				text(0,1.06,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')                                                                                
				text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
				ax=gca;
				box on
				set(ax, 'Layer', 'top')
				ax.LineWidth=1; 
				pos=get(gca,'Position');
				set(gca,'position',[pos(1)+.01 pos(2) pos(3) pos(4)])
				set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .9, 0.96]); % maximize figure window
				
				
				ax2=subplot(3,4,[9:12]);
				tmppct2=nansum(tmppct,2);
				imagesc(tmppct2','AlphaData',~isnan(tmppct2'))
				%xlabel('Forecast Lead Time (h)','fontsize',14)        
				set(gca,'fontsize',14)
				box on
				if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
					if mod(identmaxfhr*3,12)==0
						xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5])
					else
						xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]) 
					end
				else
					if mod(identmaxfhr*3-3,12)==0
						xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5])
					else
						xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]) 
					end
				end    
				set(gca,'xtick',[])
				set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
				set(gca,'fontsize',14)
				hold on                        
				ylabel('','fontsize',14)                                   
				set(gca,'fontsize',14)
				set(gca,'ytick',1)
				cnt=1;
				set(gca,'yticklabel','Composite');
				colorbar
				% YRANGE
				clear allquad imprv3
				imprv3(:,:,1)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
				imprv3(:,:,2)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
				imprv3(:,:,3)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
				imprv3(:,:,4)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
				imprv3(:,:,5)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
				imprv3(:,:,6)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
				imprv3(:,:,7)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
				imprv3(:,:,8)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
				imprv3(:,:,9)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
				imprv3(:,:,10)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
				imprv3(:,:,11)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
				imprv3(:,:,12)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
				allquadmax=max(max(max(imprv3)));
				allquadmin=min(min(min(imprv3)));
				tmpvalq=max(abs(allquadmin),abs(allquadmax));
				if isnan(tmpvalq)==1
					tmpvalq=0;
				end
				if numel(num2str(tmpvalq))==3
					addfacq=100;
				elseif numel(num2str(tmpvalq))==2
					addfacq=20;
				else
					addfacq=20;
				end

				if numel(num2str(round(max(tmp_exp0(:)))))==3
					addfac=100;
				elseif numel(num2str(round(max(tmp_exp0(:)))))==2
					addfac=20;
				else
					addfac=20;
				end
				if plt<=3 || (plt>=16 && plt<=18) % 0-end
					tmpmin=min(tmp_exp0(:));
					tmpmax=max(tmp_exp0(:));
					tmpval=max(abs(tmpmin),abs(tmpmax));
					if isnan(tmpval)==1
						tmpval=0;
					end
					if tmpval>250
						yrange=[-250 250];
					else
						yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
					end
				elseif plt==19 || plt==20 % -end end 
					tmpmin=min(tmp_exp0(:));
					tmpmax=max(tmp_exp0(:));
					tmpval=max(abs(tmpmin),abs(tmpmax));
					if isnan(tmpval)==1
						tmpval=0;
					end
					if tmpval>250
						yrange=[-250 250];
					else
						yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
					end
				elseif (plt>=4 && plt<=15) || plt>=21%quad 
					if tmpvalq>250
						yrange=[-250 250];
					else
						yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
					end
				end
				caxis(yrange)
				run customcolorbars
				cl=colorbar;
				colormap(gca,custommap(20,negposc))		
				set(cl,'ticks',yrange(:),'fontsize',14)																								
				hold on
				for i=1:size(tmppct2,1)
					plot(repmat(0.5+i,1,size(identdr,2)+3),-1:size(identdr,2)+1,'k')
				end
				for i=1:size(tmppct2,2)
					plot(-1:size(tmppct2,1)+1,repmat(i-.5,1,size(tmppct2,1)+3),'k')
				end
				set(gcf, 'InvertHardcopy', 'off')
				set(gcf,'Units','inches');
				screenposition = get(gcf,'Position');
				set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
				set(gcf, 'InvertHardcopy', 'off')
				tmppctstr=isnan(tmppct2);
				clear diffpct
				for j=1:size(tmppct2,2)
					for i=1:size(1:skip:identmaxfhr,2)
						if tmppctstr(i,j)==0                                                   
								if tmppct2(i,j)>yrange(2)/2 || tmppct2(i,j)<yrange(1)/2
									text(i,j, [num2str(round(tmppct2(i,j),1)),'%'], 'color','w','HorizontalAlignment', 'Center','fontsize',10)
								else
									text(i,j, [num2str(round(tmppct2(i,j),1)),'%'], 'HorizontalAlignment', 'Center','fontsize',10)
								end
						end
					end
				end        
				set(gca,'TickLength',[0 0])
				ax=gca;
				box on
				set(ax, 'Layer', 'top')
				ax.LineWidth=1;                                         
				pos=get(ax1,'Position');
				set(ax1,'position',[pos(1) pos(2)-.2 pos(3) pos(4)+.2])
				set(ax2,'position',[pos(1) pos(2)-.31 pos(3) pos(4)-.48])
				set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .9, 0.96]); % maximize figure window
				f = getframe(hfig);
				if identeps==1;filename=[identtrackint,'/FULL/',identn,'_',tmp_name,'_PPC_',identexpshort{identexploop}];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
				%print([identtrackint,'/trackcomp_fhr_',num2str((fhr-1)*3),'h'],'-dpdf','-r200');
				close all   
			end 
		end                             
		% Scorecard
		for scorecard=1
			% Which Experiment to Compare To
			for tmp=1:size(identexp,1)
				if strcmp(identexp(tmp),identexpsigimp)
					tmpimp=tmp;
				end
			end      
			tmpu=1:size(identexp,1);
			tmpu(tmpu==tmpimp)=[];

			for identexploop=tmpu % loop over experiments   
				% Compute Error, Skill, Bias, and FSP (wrt 50%) for all Variables
				for plt=1:9
					if plt==1
					 tmp_exp=(trkerr_exp(:,1:skip:end,:));plt0=1;
					 tmp_name='trkerr';
					 tmp_title='Track Error (km)';
					 tmp_ytitle='Error (km)';                                    
				elseif plt==3
					tmp_exp=interr_exp(:,1:skip:end,:);plt0=2;
					tmp_name='prserr';
					tmp_title='Pressure Error (hPa)';
					tmp_ytitle='Error (hPa)';
				elseif plt==2
					tmp_exp=spderr_exp(:,1:skip:end,:);plt0=3;
					tmp_name='spderr';
					tmp_title='Wind Speed Error (m/s)';
					tmp_ytitle='Error (m/s)';                                 
				elseif plt==7
					tmp_exp=rmwerr_exp(:,1:skip:end,:);plt0=18;
					tmp_name='rmwerr';
					tmp_title='RMW Error (km)';
					tmp_ytitle='Error (km)';                                
				elseif plt==4
					tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));plt0=21;
					tmp_name='RTSFerr';
					tmp_title='RTSF Error (km)';
					tmp_ytitle='Error (km)';
				elseif plt==5
					tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));plt0=22;
					tmp_name='RSFerr';
					tmp_title='RSF Error (km)';
					tmp_ytitle='Error (km)';
				elseif plt==6
					tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));plt0=23;
					tmp_name='RHFerr';
					tmp_title='RHF Error (km)';
					tmp_ytitle='Error (km)';                                    
				elseif plt==8
					tmp_exp=ateerr_exp(:,1:skip:end,:);plt0=19;
					tmp_name='ateerr';
					tmp_title='Along-Track Error (km)';
					tmp_ytitle='Error (km)';
				elseif plt==9
					tmp_exp=xteerr_exp(:,1:skip:end,:);plt0=20;
					tmp_name='xteerr';
					tmp_title='Across-Track Error (km)';
					tmp_ytitle='Error (km)';
				end
					if plt <8
						tmp_err(:,:,plt)=squeeze(nanmean(abs(tmp_exp),1)); tmp_errmed(:,:,plt)=squeeze(nanmedian(abs(tmp_exp),1));                                                                         
					else
						tmp_err(:,:,plt)=squeeze(nanmean((tmp_exp),1));  tmp_errmed(:,:,plt)=squeeze(nanmedian((tmp_exp),1));                                                                        
					end
					if sum(isnan(ttestsc(abs(tmp_exp(:,:,identexploop)),abs(tmp_exp(:,:,tmpimp)),squeeze(scfactor(plt0,identexploop,:))','alpha',.05)'))==0 sigtest_95(:,plt)=repmat(0,1,size(tmp_exp,2)); else sigtest_95(:,plt)=ttestsc(abs(tmp_exp(:,:,identexploop)),abs(tmp_exp(:,:,tmpimp)),squeeze(scfactor(plt0,identexploop,:))','alpha',.05)'; end
					if sum(isnan(ttestsc(abs(tmp_exp(:,:,identexploop)),abs(tmp_exp(:,:,tmpimp)),squeeze(scfactor(plt0,identexploop,:))','alpha',.1)'))==0 sigtest_90(:,plt)=repmat(0,1,size(tmp_exp,2));; else sigtest_90(:,plt)=ttestsc(abs(tmp_exp(:,:,identexploop)),abs(tmp_exp(:,:,tmpimp)),squeeze(scfactor(plt0,identexploop,:))','alpha',.1)';   end
					tmp_imp(:,plt)=squeeze(100.*(1-nanmean(abs(tmp_exp(:,:,identexploop)),1)./nanmean(abs(tmp_exp(:,:,tmpimp)),1)))';tmp_impmed(:,plt)=squeeze(100.*(1-nanmedian(abs(tmp_exp(:,:,identexploop)),1)./nanmedian(abs(tmp_exp(:,:,tmpimp)),1)))';
					tmp1=abs(tmp_exp(:,:,identexploop));
					tmp2=abs(tmp_exp(:,:,tmpimp));
					tmp3=sign(tmp1-tmp2);
					tmp4=tmp3<0;
					tmp5=tmp3>0;
					tmp6=tmp3==0;
					tmptmp=sum(~isnan(tmp3),1);                            
					tmp_bias(:,:,plt)=squeeze(nanmean((tmp_exp),1));
					tmp_fsp(:,plt)=squeeze(100*(nansum(tmp4,1)+nansum(tmp6,1)./2)./tmptmp)'-50;  
					for tmp=1:size(identexp,1)
						tmp_fcst(:,tmp,plt)=sum(~isnan(tmp_exp(:,:,tmp)),1);
					end 
				end        

				%% CONSISTENCY SCORECARD
				% Specify y labels
				tmp_ytitle={'TRACK','WIND SPEED','PRESSURE','RTSF','RSF','RHF'}';

				sconsistent=nan(6,size(tmp_imp,1));
				for vari=1:6
					a=find(tmp_imp(:,vari)>=1 & tmp_fsp(:,vari)>=((0.5.*tmp_fcst(:,1,vari)+max(5,0.01.*tmp_fcst(:,1,vari)))./tmp_fcst(:,1,vari)*100-50) & tmp_impmed(:,vari)>=1); % C-imp
					sconsistent(vari,a)=2;
					b=find((tmp_imp(:,vari)>=1 & tmp_fsp(:,vari)>=((0.5.*tmp_fcst(:,1,vari)+max(5,0.01.*tmp_fcst(:,1,vari)))./tmp_fcst(:,1,vari)*100-50) & tmp_impmed(:,vari)>-1) | (tmp_imp(:,vari)>=1 & tmp_fsp(:,vari)>-((0.5.*tmp_fcst(:,1,vari)+max(5,0.01.*tmp_fcst(:,1,vari)))./tmp_fcst(:,1,vari)*100-50) & tmp_impmed(:,vari)>=1) | (tmp_imp(:,vari)>-1 & tmp_fsp(:,vari)>=((0.5.*tmp_fcst(:,1,vari)+max(5,0.01.*tmp_fcst(:,1,vari)))./tmp_fcst(:,1,vari)*100-50) & tmp_impmed(:,vari)>=1)); % MC-imp
					[~,~,ind]  = intersect(a,b);b=b(~(ismember(1:numel(b),ind)));
					sconsistent(vari,b)=1;
					c=find(tmp_imp(:,vari)<=-1 & tmp_fsp(:,vari)<=-((0.5.*tmp_fcst(:,1,vari)+max(5,0.01.*tmp_fcst(:,1,vari)))./tmp_fcst(:,1,vari)*100-50) & tmp_impmed(:,vari)<=-1); % C-deg
					sconsistent(vari,c)=-2;
					d=find((tmp_imp(:,vari)<=-1 & tmp_fsp(:,vari)<=-((0.5.*tmp_fcst(:,1,vari)+max(5,0.01.*tmp_fcst(:,1,vari)))./tmp_fcst(:,1,vari)*100-50) & tmp_impmed(:,vari)<1) | (tmp_imp(:,vari)<=-1 & tmp_fsp(:,vari)<((0.5.*tmp_fcst(:,1,vari)+max(5,0.01.*tmp_fcst(:,1,vari)))./tmp_fcst(:,1,vari)*100-50) & tmp_impmed(:,vari)<=-1) | (tmp_imp(:,vari)<1 & tmp_fsp(:,vari)<=-((0.5.*tmp_fcst(:,1,vari)+max(5,0.01.*tmp_fcst(:,1,vari)))./tmp_fcst(:,1,vari)*100-50) & tmp_impmed(:,vari)<=-1)); % MC-deg
					[~,~,ind]  = intersect(c,d);d=d(~(ismember(1:numel(d),ind)));
					sconsistent(vari,d)=-1;
				end

				% Start Figure
				clear l cntexp;set(0,'defaultfigurecolor',[1 1 1]);hfig=figure;set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);hold on;

				% Plot Matrix & Flip
				imagesc(sconsistent,'AlphaData',~isnan((sconsistent)));axis ij;

				% Markers for Stat. Sig.
				cnt=1;for i=1:6;for j=1:size(sconsistent,2);if sigtest_90(j,cnt)+sigtest_95(j,cnt)==2;plot(j,i,'s','Color','k','markerfacecolor','k','markersize',7);elseif sigtest_90(j,cnt)+sigtest_95(j,cnt)==1;plot(j,i,'o','Color','k','markersize',5.5,'markerfacecolor','k');else;end;end;cnt=cnt+1;end;

				% X- and Y- Axes: Ticks, Labels, Ranges
				xlabel('Forecast Lead Time (h)','fontsize',20);set(gca,'fontsize',14);box on;if mod(identmaxfhr*3,skiphr)==0;if mod(identmaxfhr*3,12)==0;xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5]);else;xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]);end;else;if mod(identmaxfhr*3-3,12)==0;xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5]);else;xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]);end;end;set(gca,'xtick',1:skiptick:50);set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24);set(gca,'fontsize',16);ylim([0.5 size(sconsistent,1)+.5]);set(gca,'ytick',1:1:size(sconsistent,1)+.5);set(gca,'yticklabel',tmp_ytitle);set(gca,'TickLength',[0 0]);

				% Colormap
				colorbar;caxis([-2.5 2.5]);run customcolorbars;cl=colorbar;cl.Ticks=[-2:1:2];colormap(gca,flipud([56 87 35;169 209 142;229.5 229.5 229.5;244 177 131;132 60 12]/255));

				% Create Gridlines
				for i=1:size(sconsistent,2);	plot(repmat(0.5+i,1,size(sconsistent,1)+3),-1:size(sconsistent,1)+1,'k');end;plot(-1:size(sconsistent,2)+1,repmat(1.5,size(sconsistent,2)+3,1),'k','linewidth',2);plot(-1:size(sconsistent,2)+1,repmat(2.5,size(sconsistent,2)+3,1),'k','linewidth',2);plot(-1:size(sconsistent,2)+1,repmat(3.5,size(sconsistent,2)+3,1),'k','linewidth',2);plot(-1:size(sconsistent,2)+1,repmat(4.5,size(sconsistent,2)+3,1),'k','linewidth',2);plot(-1:size(sconsistent,2)+1,repmat(5.5,size(sconsistent,2)+3,1),'k','linewidth',2);plot(-1:size(sconsistent,2)+1,repmat(6.5,size(sconsistent,2)+3,1),'k','linewidth',2);

				% Title Text
				text(0,1.11,['\textbf{Consistency Scorecard}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');text(1,1.11,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');text(0,1.06,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');text(1,1.06,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
				% Figure Sizing & Printing
				set(gcf, 'InvertHardcopy', 'off');ax=gca;box on;set(ax, 'Layer', 'top');ax.LineWidth=2;set(gca,'position',[spPos(1)+.04 spPos(2) spPos(3) spPos(4)]);set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, .5, .2]);set(gca,'Color',[.9 .9 .9]);
				% Save Figure
				set(gcf,'Units','inches');screenposition = get(gcf,'Position');set(gcf,'PaperPosition',[0 0 screenposition(3)+3 screenposition(4)+3],'PaperSize',[screenposition(3)+3 screenposition(4)+3]); consPos=get(cl,'position');set(cl,'position',[consPos(1)+.005 consPos(2) consPos(3)+.01 consPos(4)]);ticks = strsplit(num2str(cl.Ticks));ax = axes('Position', cl.Position);edges = linspace(0,1,numel(ticks)+1);centers = edges(2:end)-((edges(2)-edges(1))/2);text(ones(size(centers))*0.5, centers, {'C','MC','','MC','C'},'FontSize',cl.FontSize,'HorizontalAlignment','Center','VerticalAlignment','Middle','color','w');ax.Visible = 'off';cl.Ticks = [];text(1.2,.2,['\textbf{Degradation}'],'color','k','rotation',270,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex');text(1.2,.8,['\textbf{Improvement}'],'color','k','rotation',270,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex');print('-dpng',[identtrackint,'/FULL/',identn,'_CONSISTENCYSCORECARD_',identexpshort{identexploop},'.png']);close all

				%% BACK TO SCORECARD
				%  Specify y labels
				tmp_ytitle={'Mean Error (km)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean AT Bias (km)','Mean XT Bias (km)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.'}';									
				
			    % Generate Matrix
				sc=nan(57,size(tmp_imp,1));
				% TRACK
				sc(1,:)=NaN; % error
				sc(2,:)=tmp_imp(:,1); % imprv
				sc(3,:)=tmp_fsp(:,1); % fsp
				sc(4,:)=NaN; sc(5,:)=tmp_impmed(:,1); sc(6,:)=NaN; % bias
				sc(7,:)=NaN; % bias
				sc(8,:)=NaN; % #fcst
				sc(9,:)=NaN; % sig.
				%WIND SPEED
				sc(10,:)=NaN; % error
				sc(11,:)=tmp_imp(:,2); % imprv
				sc(12,:)=tmp_fsp(:,2); % fsp
				sc(13,:)=NaN; sc(14,:)=tmp_impmed(:,2); sc(15,:)=NaN; % bias
				sc(16,:)=NaN; % #fcst
				sc(17,:)=NaN; % sig.
				% PRESSURE
				sc(18,:)=NaN; % error
				sc(19,:)=tmp_imp(:,3); % imprv
				sc(20,:)=tmp_fsp(:,3); % fsp
				sc(21,:)=NaN; sc(22,:)=tmp_impmed(:,3);sc(23,:)=NaN; % bias
				sc(24,:)=NaN; % #fcst
				sc(25,:)=NaN; % sig.
				% RTSF
				sc(26,:)=NaN; % error
				sc(27,:)=tmp_imp(:,4); % imprv
				sc(28,:)=tmp_fsp(:,4); % fsp
				sc(29,:)=NaN; sc(30,:)=tmp_impmed(:,4);sc(31,:)=NaN; % bias
				sc(32,:)=NaN; % #fcst
				sc(33,:)=NaN; % sig.
				% RSF
				sc(34,:)=NaN; % error
				sc(35,:)=tmp_imp(:,5); % imprv
				sc(36,:)=tmp_fsp(:,5); % fsp
				sc(37,:)=NaN; sc(38,:)=tmp_impmed(:,5);sc(39,:)=NaN; % bias
				sc(40,:)=NaN; % #fcst
				sc(41,:)=NaN; % sig.
				% RHF
				sc(42,:)=NaN; % error
				sc(43,:)=tmp_imp(:,6); % imprv
				sc(44,:)=tmp_fsp(:,6); % fsp
				sc(45,:)=NaN; sc(46,:)=tmp_impmed(:,6);sc(47,:)=NaN; % bias
				sc(48,:)=NaN; % #fcst
				sc(49,:)=NaN; % sig.
				% RMW
				sc(50,:)=NaN; % error
				sc(51,:)=tmp_imp(:,7); % imprv
				sc(52,:)=tmp_fsp(:,7); % fsp
				sc(53,:)=NaN; sc(54,:)=tmp_impmed(:,7);sc(55,:)=NaN; % bias
				sc(56,:)=NaN; % #fcst
				sc(57,:)=NaN; % sig.

				% Start Figure
				clear l cntexp
				set(0,'defaultfigurecolor',[1 1 1]) % figure background color
				hfig=figure;
				set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
				%ax1=subplot(3,4,[1:8]);   
				hold on

				% Plot Matrix & Flip
				imagesc(sc,'AlphaData',~isnan((sc)))
				axis ij

				% X- and Y- Axes: Ticks, Labels, Ranges
				xlabel('Forecast Lead Time (h)','fontsize',20)
				set(gca,'fontsize',14)
				box on
				if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
					if mod(identmaxfhr*3,12)==0
						xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5])
					else
						xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]) 
					end
				else
					if mod(identmaxfhr*3-3,12)==0
						xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5])
					else
						xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]) 
					end
				end    
				set(gca,'xtick',1:skiptick:50)
				set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
				set(gca,'fontsize',9)
				ylim([0.5 size(sc,1)+.5])
				set(gca,'ytick',1:1:size(sc,1)+.5)
				set(gca,'yticklabel',tmp_ytitle)
				set(gca,'TickLength',[0 0])

				% Colormap
				colorbar
				caxis([-50 50])
				run customcolorbars
				cl=colorbar;
				colormap(gca,custommap(20,negposc))														

				% Create Gridlines
				for i=1:size(sc,2)
					plot(repmat(0.5+i,1,size(sc,1)+3),-1:size(sc,1)+1,'k')
				end
				plot(-1:size(sc,2)+1,repmat(9.5,size(sc,2)+3,1),'k','linewidth',2)
				plot(-1:size(sc,2)+1,repmat(17.5,size(sc,2)+3,1),'k','linewidth',2)
				plot(-1:size(sc,2)+1,repmat(25.5,size(sc,2)+3,1),'k','linewidth',2)
				plot(-1:size(sc,2)+1,repmat(33.5,size(sc,2)+3,1),'k','linewidth',2)
				plot(-1:size(sc,2)+1,repmat(41.5,size(sc,2)+3,1),'k','linewidth',2)
				plot(-1:size(sc,2)+1,repmat(49.5,size(sc,2)+3,1),'k','linewidth',2)

				% Box Outside Graphic
				plot(repmat((-2.1+-1.5)/2,1,size(sc,1)+1),0.5:size(sc,1)+.5,'k','clipping','off','linewidth',28)
				plot(-2.1:size(sc,2)-7,repmat(0.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
				plot(-2.1:size(sc,2)-7,repmat(9.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
				plot(-2.1:size(sc,2)-7,repmat(17.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
				plot(-2.1:size(sc,2)-7,repmat(25.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
				plot(-2.1:size(sc,2)-7,repmat(33.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
				plot(-2.1:size(sc,2)-7,repmat(41.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
				plot(-2.1:size(sc,2)-7,repmat(49.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
				plot(-2.1:size(sc,2)-7,repmat(57.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')           

				% Text For Skill & FSP Percentages
				for j=1:size(sc,2)
					for i=1:size(sc,1)
						if isnan(sc(i,j))==1
						else
							if sc(i,j)>30 || sc(i,j)<-30
								text(j,i, strtrim([num2str(round(sc(i,j),1)),'%']), 'color','w','HorizontalAlignment', 'Center','fontsize',6)
							else
								text(j,i, strtrim([num2str(round(sc(i,j),1)),'%']), 'HorizontalAlignment', 'Center','fontsize',6)
							end
						end
					end
				end     

				% Text for Error 
				cnt=1;
				for i=[1,10,18,26,34,42,50]
					for j=1:size(sc,2)
						if isnan(sc(i,j))==1 % then put in error
							tmpstr=['\color[rgb]{',strtrim(num2str(identexpcolors(identexploop,:))),'}',strtrim(num2str(round(tmp_err(j,identexploop,cnt),1))),'\color[rgb]{0 0 0}|\color[rgb]{',strtrim(num2str(identexpcolors(tmpimp,:))),'}',strtrim(num2str(round(tmp_err(j,tmpimp,cnt),1))),];
							text(j,i,tmpstr, 'HorizontalAlignment', 'Center','fontsize',6)
							else                       
						end
					end
					cnt=cnt+1;
				end  
				cnt=1;for i=[4,13,21,29,37,45,53];for j=1:size(sc,2);if isnan(sc(i,j))==1;tmpstr=['\color[rgb]{',strtrim(num2str(identexpcolors(identexploop,:))),'}',strtrim(num2str(round(tmp_errmed(j,identexploop,cnt),1))),'\color[rgb]{0 0 0}|\color[rgb]{',strtrim(num2str(identexpcolors(tmpimp,:))),'}',strtrim(num2str(round(tmp_errmed(j,tmpimp,cnt),1))),];text(j,i,tmpstr, 'HorizontalAlignment', 'Center','fontsize',6);else;end;end;cnt=cnt+1;end; % median text
				% Text for Bias 
				cnt=2;
				for i=[15,23,31,39,47,55,6,7]
					for j=1:size(sc,2)
						if isnan(sc(i,j))==1 % then put in bias
							tmpstr=['\color[rgb]{',strtrim(num2str(identexpcolors(identexploop,:))),'}',strtrim(num2str(round(tmp_bias(j,identexploop,cnt),1))),'\color[rgb]{0 0 0}|\color[rgb]{',strtrim(num2str(identexpcolors(tmpimp,:))),'}',strtrim(num2str(round(tmp_bias(j,tmpimp,cnt),1))),];
							text(j,i,tmpstr, 'HorizontalAlignment', 'Center','fontsize',6)
						else                       
						end
					end
					cnt=cnt+1;
				end    

				% Text for # FCSTS 
				cnt=1;
				for i=[8,16,24,32,40,48,56]
					for j=1:size(sc,2)
						if isnan(sc(i,j))==1 % then put in #fcsts
							if sum(tmp_fcst(j,1,cnt)-tmp_fcst(j,2,cnt))==0
								tmpstr=['\color[rgb]{0 0 0}',strtrim(num2str(round(tmp_fcst(j,identexploop,cnt),2)))];
								text(j,i,tmpstr, 'HorizontalAlignment', 'Center','fontsize',6)
							else
								tmpstr=['\color[rgb]{',strtrim(num2str(identexpcolors(identexploop,:))),'}',strtrim(num2str(round(tmp_fcst(j,identexploop,cnt),1))),'\color[rgb]{0 0 0}|\color[rgb]{',strtrim(num2str(identexpcolors(tmpimp,:))),'}',strtrim(num2str(round(tmp_fcst(j,tmpimp,cnt),1))),];
								text(j,i,tmpstr, 'HorizontalAlignment', 'Center','fontsize',6)
							end
						else                       
						end
					end
					cnt=cnt+1;
				end  

				% Markers for Stat. Sig.
				cnt=1;
				for i=[9,17,25,33,41,49,57]
					for j=1:size(sc,2)
						if isnan(sc(i,j))==1 % then put in stat. sig.
							if sigtest_90(j,cnt)+sigtest_95(j,cnt)==2
								plot(j,i,'s','Color','k','markerfacecolor','k','markersize',7)
							elseif sigtest_90(j,cnt)+sigtest_95(j,cnt)==1
								plot(j,i,'o','Color','k','markersize',5.5,'markerfacecolor','k')
							else
							end                                                
						else                       
						end
					end
					cnt=cnt+1;
				end  

				% Variable Titles
				text(-1.75,5,['\textbf{TRACK}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
				text(-1.88,13.5,['\textbf{WIND}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
				text(-1.62,13.5,['\textbf{SPEED}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
				text(-1.75,21.5,['\textbf{MSLP}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
				text(-1.75,29.5,['\textbf{RTSF}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
				text(-1.75,37.5,['\textbf{RSF}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
				text(-1.75,45.5,['\textbf{RHF}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
				text(-1.75,53.5,['\textbf{RMW}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')

				% Title Text
				text(0,1.065,['\textbf{Scorecard}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
				text(1,1.065,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
				text(0,1.035,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
				text(1,1.035,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');

				% Figure Sizing & Printing
				set(gcf, 'InvertHardcopy', 'off')    
				ax=gca;
				box on
				set(ax, 'Layer', 'top')
				ax.LineWidth=2; 
				set(gca,'position',[spPos(1) spPos(2)-.07 spPos(3)+.09 spPos(4)+.1])
				set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, .5]); % maximize figure window
				set(gca,'Color',[.9 .9 .9])
				% Save Figure
				set(gcf,'Units','inches');
				screenposition = get(gcf,'Position');
				set(gcf,'PaperPosition',[0 0 screenposition(3)+3 screenposition(4)+3],'PaperSize',[screenposition(3)+3 screenposition(4)+3]);    
				if identeps==1;filename=[identtrackint,'/FULL/',identn,'_SCORECARD_',identexpshort{identexploop}];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;print('-dpng',filename);end;					
				close all
			end
		end                    
		spPos=[0.11 0.13+.05 0.75 0.75-.05]; % arrange plots the same
		% Create Graphics: by cycle trk, int, spd errors - bt-gh vs. bt-deny
		for plt=1:23
			clear l cntexp
			set(0,'defaultfigurecolor',[1 1 1]) % figure background color
			hfig=figure;
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
			ax1=subplot(3,4,[1:8]);
			hold on
			if plt==1
				 tmp_exp=trkerr_exp(:,1:skip:end,:);
				 tmp_name='trkerr';
				 tmp_title='Track Error (km)';
				 tmp_ytitle='Error (km)';
			elseif plt==2
				tmp_exp=interr_exp(:,1:skip:end,:);
				tmp_name='prserr';
				tmp_title='Pressure Error (hPa)';
				tmp_ytitle='Error (hPa)';
			elseif plt==3
				tmp_exp=spderr_exp(:,1:skip:end,:);
				tmp_name='spderr';
				tmp_title='Wind Speed Error (m/s)';
				tmp_ytitle='Error (m/s)';
			 elseif plt==4
				tmp_exp=ne34err_exp(:,1:skip:end,:);
				tmp_name='neRTSFerr';
				tmp_title='RTSF NEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==5
				tmp_exp=se34err_exp(:,1:skip:end,:);
				tmp_name='seRTSFerr';
				tmp_title='RTSF SEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==6
				tmp_exp=sw34err_exp(:,1:skip:end,:);
				tmp_name='swRTSFerr';
				tmp_title='RTSF SWQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==7
				tmp_exp=nw34err_exp(:,1:skip:end,:);
				tmp_name='nwRTSFerr';
				tmp_title='RTSF NWQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==8
				tmp_exp=ne50err_exp(:,1:skip:end,:);
				tmp_name='neRSFerr';
				tmp_title='RSF NEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==9
				tmp_exp=se50err_exp(:,1:skip:end,:);
				tmp_name='seRSFerr';
				tmp_title='RSF SEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==10
				tmp_exp=sw50err_exp(:,1:skip:end,:);
				tmp_name='swRSFerr';
				tmp_title='RSF SWQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==11
				tmp_exp=nw50err_exp(:,1:skip:end,:);
				tmp_name='nwRSFerr';
				tmp_title='RSF NWQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==12
				tmp_exp=ne64err_exp(:,1:skip:end,:);
				tmp_name='neRHFerr';
				tmp_title='RHF NEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==13
				tmp_exp=se64err_exp(:,1:skip:end,:);
				tmp_name='seRHFerr';
				tmp_title='RHF SEQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==14
				tmp_exp=sw64err_exp(:,1:skip:end,:);
				tmp_name='swRHFerr';
				tmp_title='RHF SWQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==15
				tmp_exp=nw64err_exp(:,1:skip:end,:);
				tmp_name='nwRHFerr';
				tmp_title='RHF NWQ Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==16
				tmp_exp=poerr_exp(:,1:skip:end,:);
				tmp_name='poerr';
				tmp_title='Outer Clsd Isbr Prs Error (hPa)';
				tmp_ytitle='Error (hPa)';
			elseif plt==17
				tmp_exp=roerr_exp(:,1:skip:end,:);
				tmp_name='roerr';
				tmp_title='Outer Clsd Isbr Rad Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==18
				tmp_exp=rmwerr_exp(:,1:skip:end,:);
				tmp_name='rmwerr';
				tmp_title='RMW Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==19
				tmp_exp=ateerr_exp(:,1:skip:end,:);
				tmp_name='trkbias1';
				tmp_title='Along-Track Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==20
				tmp_exp=xteerr_exp(:,1:skip:end,:);
				tmp_name='trkbias2';
				tmp_title='Across-Track Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==21
				tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
				tmp_name='RTSFerr';
				tmp_title='RTSF Error (km)';
				tmp_ytitle='Error (km)';
			elseif plt==22
				tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
				tmp_name='RSFerr';
				tmp_title='RSF Error (km';
				tmp_ytitle='Error (km)';
			elseif plt==23
				tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
				tmp_name='RHFerr';
				tmp_title='RHF Error (km)';
				tmp_ytitle='Error (km)';
			end
			if plt <19 || plt >20
				tmp_exp=abs(tmp_exp); % added for MAE
			end
			for tmp=1:size(identexp,1)
				l(tmp)=plot(nanmean(tmp_exp(:,:,tmp),2),1:size(tmp_exp(:,:,tmp),1),'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2);
			end
			% Find which experiment to compare to
			for tmp=1:size(identexp,1)
				if strcmp(identexp(tmp),identexpsigimp)
					tmpimp=tmp;
				end
			end       
			plot(zeros(1,100),-10:89,'Color',[.5 .5 .5],'linewidth',2);
			%for tmp=1:size(identexp,1)
				%sigtest=ttestsc(tmp_exp(:,:,tmp)',tmp_exp(:,:,tmpimp)',squeeze(scfactor(plt,tmp,:))','alpha',.05);
				%sigtest_loc=find(sigtest==1);
				%sigtest_exp=nanmean(tmp_exp(sigtest_loc,:,:),2);
				%for tmpi=tmp
				%	plot(sigtest_exp(:,:,tmpi),sigtest_loc,'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',9)
				%end                
				%sigtest=ttestsc(tmp_exp(:,:,tmp)',tmp_exp(:,:,tmpimp)',squeeze(scfactor(plt,tmp,:))','alpha',.1);
				%sigtest_loc1=find(sigtest==1);
				%sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
				%sigtest_exp=nanmean(tmp_exp(sigtest_loc,:,:),2);
				%for tmpi=tmp
				%	plot(sigtest_exp(:,:,tmpi),sigtest_loc,'o','Color','k','markersize',8,'markerfacecolor',identexpcolors(tmp,:))
				%end
			%end  
			set(gca,'plotboxaspectratio',[1 1 1])
			ylabel('Cycle Initialization Time','fontsize',20)
			xlabel(tmp_ytitle,'fontsize',20)
			set(gca,'fontsize',20)
			box on
			xstart=1;          
			ylim([xstart-.5 size(BT_lat,1)+.5])
			%% ERROR
			% YRANGE
			clear allquad
			allquad(1)=(max(max(nanmean(abs(ne34err_exp(:,1:skip:end,:)),2))));
			allquad(2)=(max(max(nanmean(abs(se34err_exp(:,1:skip:end,:)),2))));
			allquad(3)=(max(max(nanmean(abs(nw34err_exp(:,1:skip:end,:)),2))));
			allquad(4)=(max(max(nanmean(abs(sw34err_exp(:,1:skip:end,:)),2))));
			allquad(5)=(max(max(nanmean(abs(ne50err_exp(:,1:skip:end,:)),2))));
			allquad(6)=(max(max(nanmean(abs(se50err_exp(:,1:skip:end,:)),2))));
			allquad(7)=(max(max(nanmean(abs(nw50err_exp(:,1:skip:end,:)),2))));
			allquad(8)=(max(max(nanmean(abs(sw50err_exp(:,1:skip:end,:)),2))));
			allquad(9)=(max(max(nanmean(abs(ne64err_exp(:,1:skip:end,:)),2))));
			allquad(10)=(max(max(nanmean(abs(se64err_exp(:,1:skip:end,:)),2))));
			allquad(11)=(max(max(nanmean(abs(nw64err_exp(:,1:skip:end,:)),2))));
			allquad(12)=(max(max(nanmean(abs(sw64err_exp(:,1:skip:end,:)),2))));
			allquadmax=max(max(max(allquad)));
			allquadmin=min(min(min(allquad)));
			tmpvalq=max(abs(allquadmin),abs(allquadmax));
			if isnan(tmpvalq)==1
					tmpvalq=0;
				end
			if numel(num2str(tmpvalq))==3
				addfacq=100;
			elseif numel(num2str(tmpvalq))==2
				addfacq=20;
			else
				addfacq=20;
			end
			if numel(num2str(round(max(max(nanmean((tmp_exp),2))))))==3
				addfac=100;
			elseif numel(num2str(round(max(max(nanmean((tmp_exp),2))))))==2
				addfac=20;
			else
				addfac=20;
			end
			if plt<=3 || (plt>=16 && plt<=18) % 0-end
				tmpmin=min(min(nanmean((tmp_exp),2)));
				tmpmax=max(max(nanmean((tmp_exp),2)));
				tmpval=max(abs(tmpmin),abs(tmpmax));
				if isnan(tmpval)==1
					tmpval=0;
				end
				yrange=[0 round((tmpval+addfac)/10)*10];                                
			elseif plt==19 || plt==20 % -end end 
				tmpmin=min(min(nanmean((tmp_exp),2)));
				tmpmax=max(max(nanmean((tmp_exp),2)));
				tmpval=max(abs(tmpmin),abs(tmpmax));
				if isnan(tmpval)==1
					tmpval=0;
				end
				yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];                
			elseif (plt>=4 && plt<=15) || plt>=21%quad
				yrange=[0 round((tmpvalq+addfacq)/10)*10];
			end
			xlim(yrange)
			if size(identinittimesunique,1)>50
				set(gca,'ytick',1:4:100)
				set(gca,'yticklabel',identinittimesunique(1:4:end,:))
			else
				set(gca,'ytick',1:2:100)
				set(gca,'yticklabel',identinittimesunique(1:2:end,:))
			end  
			grid on
			set(gca,'gridcolor','k','gridalpha',.15)
			set(gca,'fontsize',20)      
			hold off
			box on
			lh=legend(l,identexpshort,'location','northeast');
			lh.FontSize=10;
			set(gcf,'Units','inches');
			a1Pos = get(gca,'Position');
			set(gcf, 'InvertHardcopy', 'off')
			set(gcf,'Units','inches');
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')
			text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
			text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
			text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
			ax=gca;
			box on
			set(ax, 'Layer', 'bottom')
			ax.LineWidth=1; 
			set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .85, 0.96]); % maximize figure window
			set(gca,'Color',[.9 .9 .9])
			clear cntexp
			for tmp=1:size(identexp,1)
				cntexp(:,tmp)=sum(~isnan(tmp_exp(:,:,tmp)),2);
			end
			if sum([cntexp(:)])==0
				tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				set(tx, 'Layer', 'front')
			end   
			if plt==19
				 tx=text(0.02,0.05,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 tx=text(0.98,0.05,'Faster than BT','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
			elseif plt==20
				 tx=text(0.02,0.05,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 tx=text(0.98,0.05,'Right of BT','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
			end
			axis ij;b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
			yyaxis left
			set(b,'YColor','none');
			yyaxis right
			set(b,'plotboxaspectratio',[1 1 1])
			set(b,'Color','none');
			set(b,'XColor','none');
			set(b,'tickdir','both')
			set(b,'YColor',[0 0 0]);
			set(b,'xtick',[]);
			ylim(b,[xstart-.5 size(BT_lat,1)+.5])
			tmpxend=size(BT_lat,1);
			if size(identinittimesunique,1)>50
				set(b,'ytick',[1:4:100]); 
			else
				set(b,'ytick',[1:2:100]); 
			end  
			trkerr_exp_fcnt=zeros(1,tmpxend);            
			trkerr_exp_fcnt1=zeros(1,tmpxend);            
			trkerr_exp_fcnt2=zeros(1,tmpxend);
			clear cntexp
			for tmp=1:size(identexp,1)
				cntexp(:,tmp)=sum(~isnan(tmp_exp(:,:,tmp)),2);
			end  
			set(gca,'fontsize',12)
			xL=xlim;
			yL=ylim;
			ylabel({'# 6-h','fcsts'},'Position',[xL(2) yL(2)],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',0); 
			set(gca,'position',[spPos(1)+.08 spPos(2)+.05 spPos(3) spPos(4)])
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')            
			% Create a text box at every Tick label position
			maxmin=squeeze(sum(~isnan(tmp_exp(:,:,:)),2)); 
			if size(identinittimesunique,1)>50
				maxmin=maxmin(1:4:end,:); 
			else
				maxmin=maxmin(1:2:end,:); 
			end
			yTicks0 = get(gca, 'yticklabel');
			yTicks = get(gca, 'ytick');
			set(b,'yticklabels',[]);
			minX =1;
			HorizontalOffset1=0.03;
			VerticalOffset = 0.2;
			for xx = 1:size(yTicks0,1)
				tmptxt0=maxmin(xx,:);
				tmptxt1=[];
				if size(unique(tmptxt0),2)==1
					tmptxt1=num2str(tmptxt0(1));
				else
					for xxx=1:size(maxmin,2)
						  if xxx==size(maxmin,2)
							  tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(xxx,:)),'}',num2str(tmptxt0(xxx))];
						  else
							  tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(xxx,:)),'}',num2str(tmptxt0(xxx)),'\color[rgb]{0,0,0}/'];
						  end
					end
				end
				text(minX+HorizontalOffset1,yTicks(xx),tmptxt1,'verticalalignment','middle','fontsize',12)
			end
			axis ij;f = getframe(hfig);
			if identeps==1;filename=[identtrackint,'/FULL/',identn,'_',tmp_name,'_cycles'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
			close all
		end
		% Create Graphics: by cycle trk, int, spd Skill vs. deny
		for plt=[1:18,21:23]
			clear l cntexp
			set(0,'defaultfigurecolor',[1 1 1]) % figure background color
			hfig=figure;
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
			ax1=subplot(3,4,[1:8]);
			hold on
			 if plt==1
				tmp_exp=trkerr_exp(:,1:skip:end,:);
				tmp_name='trkskill';
				tmp_title='Track Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300]; 
			elseif plt==2
				tmp_exp=interr_exp(:,1:skip:end,:);
				tmp_name='prskill';
				tmp_title='Pressure Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300]; 
			elseif plt==3
				tmp_exp=spderr_exp(:,1:skip:end,:);
				tmp_name='spdskill';
				tmp_title='Wind Speed Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300]; 
			 elseif plt==4
				tmp_exp=ne34err_exp(:,1:skip:end,:);
				tmp_name='neRTSFskill';
				tmp_title='RTSF NEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==5
				tmp_exp=se34err_exp(:,1:skip:end,:);
				tmp_name='seRTSFskill';
				tmp_title='RTSF SEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==6
				tmp_exp=sw34err_exp(:,1:skip:end,:);
				tmp_name='swRTSFskill';
				tmp_title='RTSF SWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==7
				tmp_exp=nw34err_exp(:,1:skip:end,:);
				tmp_name='nwRTSFskill';
				tmp_title='RTSF NWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==8
				tmp_exp=ne50err_exp(:,1:skip:end,:);
				tmp_name='neRSFskill';
				tmp_title='RSF NEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==9
				tmp_exp=se50err_exp(:,1:skip:end,:);
				tmp_name='seRSFskill';
				tmp_title='RSF SEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==10
				tmp_exp=sw50err_exp(:,1:skip:end,:);
				tmp_name='swRSFskill';
				tmp_title='RSF SWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==11
				tmp_exp=nw50err_exp(:,1:skip:end,:);
				tmp_name='nwRSFskill';
				tmp_title='RSF NWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==12
				tmp_exp=ne64err_exp(:,1:skip:end,:);
				tmp_name='neRHFskill';
				tmp_title='RHF NEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==13
				tmp_exp=se64err_exp(:,1:skip:end,:);
				tmp_name='seRHFskill';
				tmp_title='RHF SEQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==14
				tmp_exp=sw64err_exp(:,1:skip:end,:);
				tmp_name='swRHFskill';
				tmp_title='RHF SWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==15
				tmp_exp=nw64err_exp(:,1:skip:end,:);
				tmp_name='nwRHFskill';
				tmp_title='RHF NWQ Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==16
				tmp_exp=poerr_exp(:,1:skip:end,:);
				tmp_name='poskill';
				tmp_title='Outer Clsd Isbr Prs Skill (hPa)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300]; 
			elseif plt==17
				tmp_exp=roerr_exp(:,1:skip:end,:);
				tmp_name='roskill';
				tmp_title='Outer Clsd Isbr Rad Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300]; 
			elseif plt==18
				tmp_exp=rmwerr_exp(:,1:skip:end,:);
				tmp_name='rmwskill';
				tmp_title='RMW Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			 elseif plt==19
				tmp_exp=ateerr_exp(:,1:skip:end,:);
				tmp_name='ateskill';
				tmp_title='Along-Track Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300]; 
			 elseif plt==20
				tmp_exp=xteerr_exp(:,1:skip:end,:);
				tmp_name='xteskill';
				tmp_title='Across-Track Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300]; 
			 elseif plt==21
				tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
				tmp_name='RTSFskill';
				tmp_title='RTSF Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];
			elseif plt==22
				tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
				tmp_name='RSFskill';
				tmp_title='RSF Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];
			elseif plt==23
				tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
				tmp_name='RHFskill';
				tmp_title='RHF Skill (\%)';
				tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];
			 end
			 if plt <19 || plt >20
				tmp_exp=abs(tmp_exp); % added for MAE
			 end
			 % Find which experiment to compare to
			for tmp=1:size(identexp,1)
				if strcmp(identexp(tmp),identexpsigimp)
					tmpimp=tmp;
				end
			end            
			tmpu=1:size(identexp,1);
			tmpu(tmpu==tmpimp)=[];
			plot(zeros(1,100),-10:89,'Color',[.5 .5 .5],'linewidth',2);
			clear imprv1
			for tmp=[tmpimp,tmpu]
				imprv=100.*(1-abs(nanmean(tmp_exp(:,:,tmp),2))./abs(nanmean(tmp_exp(:,:,tmpimp),2)));  
				imprv(imprv<-99999999)=NaN;
				imprv(imprv>99999999)=NaN;
				l(tmp)=plot(imprv,1:size(imprv,1),'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2); 
				%sigtest=ttestsc(tmp_exp(:,:,tmp)',tmp_exp(:,:,tmpimp)',squeeze(scfactor(plt,tmp,:))','alpha',.05);
				%sigtest_loc=find(sigtest==1);
				%sigtest_exp=imprv(sigtest_loc);
				%plot(sigtest_exp,sigtest_loc,'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',9)
				%sigtest=ttestsc(tmp_exp(:,:,tmp)',tmp_exp(:,:,tmpimp)',squeeze(scfactor(plt,tmp,:))','alpha',.1);
				%sigtest_loc1=find(sigtest==1);
				%sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
				%sigtest_exp=imprv(sigtest_loc);
				%plot(sigtest_exp,sigtest_loc,'o','Color','k','markersize',8,'markerfacecolor',identexpcolors(tmp,:))
				imprv1(:,tmp)=imprv;
			end  
			set(gca,'plotboxaspectratio',[1 1 1])
			ylabel('Cycle Initialization Time','fontsize',20)
			xlabel(tmp_ytitle,'fontsize',20)
			set(gca,'fontsize',20)
			box on
			%% Skill
			% YRANGE
			clear allquad imprv3
			imprv3(:,:,1)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),2)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),2));
			imprv3(:,:,2)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),2)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),2));
			imprv3(:,:,3)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),2));
			imprv3(:,:,4)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),2));
			imprv3(:,:,5)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),2)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),2));
			imprv3(:,:,6)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),2)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),2));
			imprv3(:,:,7)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),2));
			imprv3(:,:,8)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),2));
			imprv3(:,:,9)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),2)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),2));
			imprv3(:,:,10)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),2)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),2));
			imprv3(:,:,11)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),2));
			imprv3(:,:,12)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),2));
			allquadmax=max(max(max(imprv3)));
			allquadmin=min(min(min(imprv3)));
			tmpvalq=max(abs(allquadmin),abs(allquadmax));
			if isnan(tmpvalq)==1
					tmpvalq=0;
			end
			if numel(num2str(tmpvalq))==3
				addfacq=100;
			elseif numel(num2str(tmpvalq))==2
				addfacq=20;
			else
				addfacq=20;
			end
			if numel(num2str(round(max(max(nanmean((tmp_exp),2))))))==3
				addfac=100;
			elseif numel(num2str(round(max(max(nanmean((tmp_exp),2))))))==2
				addfac=20;
			else
				addfac=20;
			end
			if plt<=3 || (plt>=16 && plt<=18) % 0-end
				tmpmin=min(min(((imprv))));
				tmpmax=max(max(((imprv))));
				tmpval=max(abs(tmpmin),abs(tmpmax));
				if isnan(tmpval)==1
					tmpval=0;
				end
				if tmpval>250
					yrange=[-250 250];
				else
					yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
				end                                
			elseif plt==19 || plt==20 % -end end 
				tmpmin=min(min(((imprv))));
				tmpmax=max(max(((imprv))));
				tmpval=max(abs(tmpmin),abs(tmpmax));
				if isnan(tmpval)==1
					tmpval=0;
				end
				if tmpval>250
					yrange=[-250 250];
				else
					yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
				end               
			elseif (plt>=4 && plt<=15) || plt>=21%quad
				if tmpvalq>250
					yrange=[-250 250];
				else
					yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
				end
			end
			xlim(yrange)
			xstart=1;
			ylim([xstart-.5 size(BT_lat,1)+.5])   
			if size(identinittimesunique,1)>50
				set(gca,'ytick',1:4:100)
				set(gca,'yticklabel',identinittimesunique(1:4:end,:))
			else
				set(gca,'ytick',1:2:100)
				set(gca,'yticklabel',identinittimesunique(1:2:end,:))
			end                        
			grid on
			set(gca,'gridcolor','k','gridalpha',.15)
			set(gca,'fontsize',20)      
			hold off
			box on
			lh=legend(l,identexpshort,'location','northeast');
			lh.FontSize=10;
			set(gcf,'Units','inches');
			a1Pos = get(gca,'Position');
			set(gcf, 'InvertHardcopy', 'off')
			set(gcf,'Units','inches');
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')
			text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
			text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
			text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
			ax=gca;
			box on
			set(ax, 'Layer', 'bottom')
			ax.LineWidth=1; 
			set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .85, 0.96]); % maximize figure window
			set(gca,'Color',[.9 .9 .9])
			clear cntexp
			for tmp=1:size(identexp,1)
				cntexp(:,tmp)=sum(~isnan(tmp_exp(:,:,tmp)),2);
			end        
			% Mean Value            
			tmpstr=['Mean: '];
			tmpstrmean=nanmean(imprv1,1);
			tmpstrmean=(find(tmpstrmean~=0));
			if size(tmpstrmean,2)>0
				for tmp=tmpstrmean
					if tmp==tmpstrmean(end)
						tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(imprv1(:,tmp)),2)),'%'];
					else
						tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(imprv1(:,tmp)),2)),'% \color[rgb]{0,0,0}| '];
					end
				end
			else
				tmpstr=[''];
			end
			if sum(cntexp(:))==0 || sum(sum(~isnan(imprv1)))==0
				tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				set(tx, 'Layer', 'front')          
			else
				tx=text(0.98,0.05,tmpstr,'HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				set(tx, 'Layer', 'front')
			end   
			axis ij;b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
			yyaxis left
			set(b,'YColor','none');
			yyaxis right
			set(b,'plotboxaspectratio',[1 1 1])
			set(b,'Color','none');
			set(b,'XColor','none');
			set(b,'tickdir','both')
			set(b,'YColor',[0 0 0]);
			set(b,'xtick',[]);
			ylim(b,[xstart-.5 size(BT_lat,1)+.5])
			tmpxend=size(BT_lat,1);
			if size(identinittimesunique,1)>50
				set(b,'ytick',[1:4:100]); 
			else
				set(b,'ytick',[1:2:100]); 
			end    
			trkerr_exp_fcnt=zeros(1,tmpxend);            
			trkerr_exp_fcnt1=zeros(1,tmpxend);            
			trkerr_exp_fcnt2=zeros(1,tmpxend);
			clear cntexp
			for tmp=1:size(identexp,1)
				cntexp(:,tmp)=sum(~isnan(tmp_exp(:,:,tmp)),2);
			end  
			set(gca,'fontsize',12)
			xL=xlim;
			yL=ylim;
			ylabel({'# 6-h','fcsts'},'Position',[xL(2) yL(2)],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',0); 
			set(gca,'position',[spPos(1)+.08 spPos(2)+.05 spPos(3) spPos(4)])
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')
			% Create a text box at every Tick label position
			maxmin=squeeze(sum(~isnan(tmp_exp(:,:,:)),2)); 
			if size(identinittimesunique,1)>50
				maxmin=maxmin(1:4:end,:); 
			else
				maxmin=maxmin(1:2:end,:); 
			end                        
			yTicks0 = get(gca, 'yticklabel');
			yTicks = get(gca, 'ytick');
			set(b,'yticklabels',[]);
			minX =1;
			HorizontalOffset1=0.03;
			VerticalOffset = 0.2;
			for xx = 1:size(yTicks0,1)
				tmptxt0=maxmin(xx,:);
				tmptxt1=[];
				if size(unique(tmptxt0),2)==1
					tmptxt1=num2str(tmptxt0(1));
				else
					for xxx=1:size(maxmin,2)
						  if xxx==size(maxmin,2)
							  tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(xxx,:)),'}',num2str(tmptxt0(xxx))];
						  else
							  tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(xxx,:)),'}',num2str(tmptxt0(xxx)),'\color[rgb]{0,0,0}/'];
						  end
					end
				end
				text(minX+HorizontalOffset1,yTicks(xx),tmptxt1,'verticalalignment','middle','fontsize',12)
			end
			axis ij;f = getframe(hfig);
			if identeps==1;filename=[identtrackint,'/FULL/',identn,'_',tmp_name,'_cycles'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
			close all
		end
		% Create Graphics: by cycle trk, int, spd FSP vs. deny            
		for plt=[1:18,21:23]
			clear l cntexp
			set(0,'defaultfigurecolor',[1 1 1]) % figure background color
			hfig=figure;
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
			ax1=subplot(3,4,[1:8]);
			hold on
			 if plt==1
				tmp_exp=trkerr_exp(:,1:skip:end,:);
				tmp_name='trkfsp';
				tmp_title='Track FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300]; 
			elseif plt==2
				tmp_exp=interr_exp(:,1:skip:end,:);
				tmp_name='prsfsp';
				tmp_title='Pressure FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300]; 
			elseif plt==3
				tmp_exp=spderr_exp(:,1:skip:end,:);
				tmp_name='spdfsp';
				tmp_title='Wind Speed FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300]; 
			 elseif plt==4
				tmp_exp=ne34err_exp(:,1:skip:end,:);
				tmp_name='neRTSFfsp';
				tmp_title='RTSF NEQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==5
				tmp_exp=se34err_exp(:,1:skip:end,:);
				tmp_name='seRTSFfsp';
				tmp_title='RTSF SEQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==6
				tmp_exp=sw34err_exp(:,1:skip:end,:);
				tmp_name='swRTSFfsp';
				tmp_title='RTSF SWQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==7
				tmp_exp=nw34err_exp(:,1:skip:end,:);
				tmp_name='nwRTSFfsp';
				tmp_title='RTSF NWQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==8
				tmp_exp=ne50err_exp(:,1:skip:end,:);
				tmp_name='neRSFfsp';
				tmp_title='RSF NEQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==9
				tmp_exp=se50err_exp(:,1:skip:end,:);
				tmp_name='seRSFfsp';
				tmp_title='RSF SEQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==10
				tmp_exp=sw50err_exp(:,1:skip:end,:);
				tmp_name='swRSFfsp';
				tmp_title='RSF SWQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==11
				tmp_exp=nw50err_exp(:,1:skip:end,:);
				tmp_name='nwRSFfsp';
				tmp_title='RSF NWQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==12
				tmp_exp=ne64err_exp(:,1:skip:end,:);
				tmp_name='neRHFfsp';
				tmp_title='RHF NEQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==13
				tmp_exp=se64err_exp(:,1:skip:end,:);
				tmp_name='seRHFfsp';
				tmp_title='RHF SEQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==14
				tmp_exp=sw64err_exp(:,1:skip:end,:);
				tmp_name='swRHFfsp';
				tmp_title='RHF SWQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==15
				tmp_exp=nw64err_exp(:,1:skip:end,:);
				tmp_name='nwRHFfsp';
				tmp_title='RHF NWQ FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			elseif plt==16
				tmp_exp=poerr_exp(:,1:skip:end,:);
				tmp_name='pofsp';
				tmp_title='Outer Clsd Isbr Prs FSP (hPa)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300]; 
			elseif plt==17
				tmp_exp=roerr_exp(:,1:skip:end,:);
				tmp_name='rofsp';
				tmp_title='Outer Clsd Isbr Rad FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300]; 
			elseif plt==18
				tmp_exp=rmwerr_exp(:,1:skip:end,:);
				tmp_name='rmwfsp';
				tmp_title='RMW FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];                 
			 elseif plt==19
				tmp_exp=ateerr_exp(:,1:skip:end,:);
				tmp_name='atefsp';
				tmp_title='Along-Track FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300]; 
			 elseif plt==20
				tmp_exp=xteerr_exp(:,1:skip:end,:);
				tmp_name='xtefsp';
				tmp_title='Across-Track FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300]; 
			 elseif plt==21
				tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
				tmp_name='RTSFfsp';
				tmp_title='RTSF FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];
			elseif plt==22
				tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
				tmp_name='RSFfsp';
				tmp_title='RSF FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];
			elseif plt==23
				tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
				tmp_name='RHFfsp';
				tmp_title='RHF FSP (\%)';
				tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
				yrange=[-300 300];
			 end
			 if plt <19 || plt >20
				tmp_exp=abs(tmp_exp); % added for MAE
			 end
			 % Find which experiment to compare to
			for tmp=1:size(identexp,1)
				if strcmp(identexp(tmp),identexpsigimp)
					tmpimp=tmp;
				end
			end            
			tmpu=1:size(identexp,1);
			tmpu(tmpu==tmpimp)=[];
			plot(50*ones(1,100),-10:89,'Color',[.5 .5 .5],'linewidth',2);
			clear fsp2
			cntl=1;
			for tmp=tmpu
				tmp1=tmp_exp(:,:,tmp);
				tmp2=tmp_exp(:,:,tmpimp);
				tmp3=sign(tmp1-tmp2);
				tmp4=tmp3<0;
				tmp5=tmp3>0;
				tmp6=tmp3==0;
				tmptmp=sum(~isnan(tmp3),2);                            
				fspa=100*(nansum(tmp4,2)+nansum(tmp6,2)./2)./tmptmp;
				fspb=100*(nansum(tmp5,2)+nansum(tmp6,2)./2)./tmptmp;
				fsp2(:,tmp)=fspa;
				%plot(fspb,1:size(fspb,1),'--s','Color',identexpcolors(tmp,:),'linewidth',.5,'markersize',2); 
				l(cntl)=plot(fspa,1:size(fspa,1),'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2); 
				cntl=cntl+1;								
				%sigtest=ttestsc(tmp_exp(:,:,tmp)',tmp_exp(:,:,tmpimp)',squeeze(scfactor(plt,tmp,:))','alpha',.05);
				%sigtest_loc=find(sigtest==1);
				%sigtest_exp=fspa(sigtest_loc);
				%plot(sigtest_exp,sigtest_loc,'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',9)
				%sigtest=ttestsc(tmp_exp(:,:,tmp)',tmp_exp(:,:,tmpimp)',squeeze(scfactor(plt,tmp,:))','alpha',.1);
				%sigtest_loc1=find(sigtest==1);
				%sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
				%sigtest_exp=fspa(sigtest_loc);
				%plot(sigtest_exp,sigtest_loc,'o','Color','k','markersize',8,'markerfacecolor',identexpcolors(tmp,:))
			end
			set(gca,'plotboxaspectratio',[1 1 1])
			ylabel('Cycle Initialization Time','fontsize',20)
			xlabel(tmp_ytitle,'fontsize',20)
			set(gca,'fontsize',20)
			box on
			%% FSP                
			xlim([0 100])
			xstart=1;
			ylim([xstart-.5 size(BT_lat,1)+.5])   
			if size(identinittimesunique,1)>50
				set(gca,'ytick',1:4:100)
				set(gca,'yticklabel',identinittimesunique(1:4:end,:))
			else
				set(gca,'ytick',1:2:100)
				set(gca,'yticklabel',identinittimesunique(1:2:end,:))
			end                        
			grid on
			set(gca,'gridcolor','k','gridalpha',.15)
			set(gca,'fontsize',20)      
			hold off
			box on
			lh=legend(l,identexpshort(tmpu),'location','northeast');
			lh.FontSize=10;
			set(gcf,'Units','inches');
			a1Pos = get(gca,'Position');
			set(gcf, 'InvertHardcopy', 'off')
			set(gcf,'Units','inches');
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')
			text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
			text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
			text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
			ax=gca;
			box on
			set(ax, 'Layer', 'bottom')
			ax.LineWidth=1; 
			set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .85, 0.96]); % maximize figure window
			set(gca,'Color',[.9 .9 .9])
			clear cntexp
			for tmp=1:size(identexp,1)
				cntexp(:,tmp)=sum(~isnan(tmp_exp(:,:,tmp)),2);
			end        
			% Mean Value            
			tmpstr=['Mean: '];
			tmpstrmean=nanmean(fsp2,1);
			tmpstrmean=(find(tmpstrmean~=0));
			if size(tmpstrmean,2)>0
				for tmp=tmpstrmean
					if tmp==tmpstrmean(end)
						tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(fsp2(:,tmp)),2)),'%'];
					else
						tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(fsp2(:,tmp)),2)),'% \color[rgb]{0,0,0}| '];
					end
				end
			else
				tmpstr=[''];
			end
			if sum(cntexp(:))==0 || sum(sum(~isnan(fsp2)))==0
				tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				set(tx, 'Layer', 'front')          
			else
				tx=text(0.98,0.05,tmpstr,'HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				set(tx, 'Layer', 'front')
			end   
			axis ij;b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
			yyaxis left
			set(b,'YColor','none');
			yyaxis right
			set(b,'plotboxaspectratio',[1 1 1])
			set(b,'Color','none');
			set(b,'XColor','none');
			set(b,'tickdir','both')
			set(b,'YColor',[0 0 0]);
			set(b,'xtick',[]);
			ylim(b,[xstart-.5 size(BT_lat,1)+.5])
			tmpxend=size(BT_lat,1);
			if size(identinittimesunique,1)>50
				set(b,'ytick',[1:4:100]); 
			else
				set(b,'ytick',[1:2:100]); 
			end    
			trkerr_exp_fcnt=zeros(1,tmpxend);            
			trkerr_exp_fcnt1=zeros(1,tmpxend);            
			trkerr_exp_fcnt2=zeros(1,tmpxend);
			clear cntexp
			for tmp=1:size(identexp,1)
				cntexp(:,tmp)=sum(~isnan(tmp_exp(:,:,tmp)),2);
			end  
			set(gca,'fontsize',12)
			xL=xlim;
			yL=ylim;
			ylabel({'# 6-h','fcsts'},'Position',[xL(2) yL(2)],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',0); 
			set(gca,'position',[spPos(1)+.08 spPos(2)+.05 spPos(3) spPos(4)])
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')
			% Create a text box at every Tick label position
			maxmin=squeeze(sum(~isnan(tmp_exp(:,:,:)),2)); 
			if size(identinittimesunique,1)>50
				maxmin=maxmin(1:4:end,:); 
			else
				maxmin=maxmin(1:2:end,:); 
			end                        
			yTicks0 = get(gca, 'yticklabel');
			yTicks = get(gca, 'ytick');
			set(b,'yticklabels',[]);
			minX =1;
			HorizontalOffset1=0.03;
			VerticalOffset = 0.2;
			for xx = 1:size(yTicks0,1)
				tmptxt0=maxmin(xx,:);
				tmptxt1=[];
				if size(unique(tmptxt0),2)==1
					tmptxt1=num2str(tmptxt0(1));
				else
					for xxx=1:size(maxmin,2)
						  if xxx==size(maxmin,2)
							  tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(xxx,:)),'}',num2str(tmptxt0(xxx))];
						  else
							  tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(xxx,:)),'}',num2str(tmptxt0(xxx)),'\color[rgb]{0,0,0}/'];
						  end
					end
				end
				text(minX+HorizontalOffset1,yTicks(xx),tmptxt1,'verticalalignment','middle','fontsize',12)
			end
			axis ij;f = getframe(hfig);
			if identeps==1;filename=[identtrackint,'/FULL/',identn,'_',tmp_name,'_cycles'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
			close all
		end            
		% Create Graphics: by cycle trk, int, spd bias - bt-gh vs. bt-deny
		for plt=[2:18,21:23] % no across or along for bias since already in error
			clear l cntexp
			set(0,'defaultfigurecolor',[1 1 1]) % figure background color
			hfig=figure;
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
			ax1=subplot(3,4,[1:8]);
			hold on
			if plt==1
				 tmp_exp=trkerr_exp(:,1:skip:end,:);
				 tmp_name='trkbias';
				 tmp_title='Track Bias (km)';
				 tmp_ytitle='Bias (km)';
			elseif plt==2
				tmp_exp=interr_exp(:,1:skip:end,:);
				tmp_name='prsbias';
				tmp_title='Pressure Bias (hPa)';
				tmp_ytitle='Bias (hPa)';
			elseif plt==3
				tmp_exp=spderr_exp(:,1:skip:end,:);
				tmp_name='spdbias';
				tmp_title='Wind Speed Bias (m/s)';
				tmp_ytitle='Bias (m/s)';
			 elseif plt==4
				tmp_exp=ne34err_exp(:,1:skip:end,:);
				tmp_name='neRTSFbias';
				tmp_title='RTSF NEQ Bias (km)';
				tmp_ytitle='Bias (km)';
				yrange=[-200 200];
			elseif plt==5
				tmp_exp=se34err_exp(:,1:skip:end,:);
				tmp_name='seRTSFbias';
				tmp_title='RTSF SEQ Bias (km)';
				tmp_ytitle='Bias (km)';
				yrange=[-200 200];
			elseif plt==6
				tmp_exp=sw34err_exp(:,1:skip:end,:);
				tmp_name='swRTSFbias';
				tmp_title='RTSF SWQ Bias (km)';
				tmp_ytitle='Bias (km)';
				yrange=[-200 200];
			elseif plt==7
				tmp_exp=nw34err_exp(:,1:skip:end,:);
				tmp_name='nwRTSFbias';
				tmp_title='RTSF NWQ Bias (km)';
				tmp_ytitle='Bias (km)';
				yrange=[-200 200];
			elseif plt==8
				tmp_exp=ne50err_exp(:,1:skip:end,:);
				tmp_name='neRSFbias';
				tmp_title='RSF NEQ Bias (km)';
				tmp_ytitle='Bias (km)';
				yrange=[-200 200];
			elseif plt==9
				tmp_exp=se50err_exp(:,1:skip:end,:);
				tmp_name='seRSFbias';
				tmp_title='RSF SEQ Bias (km)';
				tmp_ytitle='Bias (km)';
				yrange=[-200 200];
			elseif plt==10
				tmp_exp=sw50err_exp(:,1:skip:end,:);
				tmp_name='swRSFbias';
				tmp_title='RSF SWQ Bias (km)';
				tmp_ytitle='Bias (km)';
				yrange=[-200 200];
			elseif plt==11
				tmp_exp=nw50err_exp(:,1:skip:end,:);
				tmp_name='nwRSFbias';
				tmp_title='RSF NWQ Bias (km)';
				tmp_ytitle='Bias (km)';
				yrange=[-200 200];
			elseif plt==12
				tmp_exp=ne64err_exp(:,1:skip:end,:);
				tmp_name='neRHFbias';
				tmp_title='RHF NEQ Bias (km)';
				tmp_ytitle='Bias (km)';
				yrange=[-200 200];
			elseif plt==13
				tmp_exp=se64err_exp(:,1:skip:end,:);
				tmp_name='seRHFbias';
				tmp_title='RHF SEQ Bias (km)';
				tmp_ytitle='Bias (km)';
				yrange=[-200 200];
			elseif plt==14
				tmp_exp=sw64err_exp(:,1:skip:end,:);
				tmp_name='swRHFbias';
				tmp_title='RHF SWQ Bias (km)';
				tmp_ytitle='Bias (km)';
				yrange=[-200 200];
			elseif plt==15
				tmp_exp=nw64err_exp(:,1:skip:end,:);
				tmp_name='nwRHFbias';
				tmp_title='RHF NWQ Bias (km)';
				tmp_ytitle='Bias (km)';
				yrange=[-200 200];
			elseif plt==16
				tmp_exp=poerr_exp(:,1:skip:end,:);
				tmp_name='pobias';
				tmp_title='Outer Clsd Isbr Prs Bias (hPa)';
				tmp_ytitle='Bias (hPa)';
			elseif plt==17
				tmp_exp=roerr_exp(:,1:skip:end,:);
				tmp_name='robias';
				tmp_title='Outer Clsd Isbr Rad Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==18
				tmp_exp=rmwerr_exp(:,1:skip:end,:);
				tmp_name='rmwbias';
				tmp_title='RMW Bias (km)';
				tmp_ytitle='Bias (km)';
			elseif plt==19
				tmp_exp=ateerr_exp(:,1:skip:end,:);
				tmp_name='atebias';
				tmp_title='Along-Track Bias (km)';
				tmp_ytitle='Bias (km)';
				yrange=[-500 500];                
			elseif plt==20
				tmp_exp=xteerr_exp(:,1:skip:end,:);
				tmp_name='xtebias';
				tmp_title='Across-Track Bias (km)';
				tmp_ytitle='Bias (km)';
				yrange=[-500 500]; 
			elseif plt==21
				tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
				tmp_name='RTSFbias';
				tmp_title='RTSF Bias (km)';
				tmp_ytitle='Bias (km)';
				yrange=[-200 200];
			elseif plt==22
				tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
				tmp_name='RSFbias';
				tmp_title='RSF Bias (km)';
				tmp_ytitle='Bias (km)';
				yrange=[-200 200];
			elseif plt==23
				tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
				tmp_name='RHFbias';
				tmp_title='RHF Bias (km)';
				tmp_ytitle='Bias (km)';
				yrange=[-200 200]; 
			end                                                
			for tmp=1:size(identexp,1)
				l(tmp)=plot(nanmean(tmp_exp(:,:,tmp),2),1:size(tmp_exp(:,:,tmp),1),'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2);
			end
			% Find which experiment to compare to
			for tmp=1:size(identexp,1)
				if strcmp(identexp(tmp),identexpsigimp)
					tmpimp=tmp;
				end
			end       
			plot(zeros(1,100),-10:89,'Color',[.5 .5 .5],'linewidth',2);
			for tmp=1:size(identexp,1)
				%sigtest=ttestsc(abs(tmp_exp(:,:,tmp))',abs(tmp_exp(:,:,tmpimp))',squeeze(scfactor(plt,tmp,:))','alpha',.05);
				%sigtest_loc=find(sigtest==1);
				%sigtest_exp=nanmean(tmp_exp(sigtest_loc,:,:),2);
				%for tmpi=tmp
			%		plot(sigtest_exp(:,:,tmpi),sigtest_loc,'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',9)
			%	end                
				%sigtest=ttestsc(abs(tmp_exp(:,:,tmp))',abs(tmp_exp(:,:,tmpimp))',squeeze(scfactor(plt,tmp,:))','alpha',.1);
				%sigtest_loc1=find(sigtest==1);
				%sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
				%sigtest_exp=nanmean(tmp_exp(sigtest_loc,:,:),2);
				%for tmpi=tmp
			%		plot(sigtest_exp(:,:,tmpi),sigtest_loc,'o','Color','k','markersize',8,'markerfacecolor',identexpcolors(tmp,:))
				%end
			end  
			set(gca,'plotboxaspectratio',[1 1 1])
			ylabel('Cycle Initialization Time','fontsize',20)
			xlabel(tmp_ytitle,'fontsize',20)
			set(gca,'fontsize',20)
			box on
			xstart=1;          
			ylim([xstart-.5 size(BT_lat,1)+.5])  
			%% BIAS
			% YRANGE
			clear allquad
			allquad(1)=(max(max(nanmean((ne34err_exp(:,1:skip:end,:)),2))));
			allquad(2)=(max(max(nanmean((se34err_exp(:,1:skip:end,:)),2))));
			allquad(3)=(max(max(nanmean((nw34err_exp(:,1:skip:end,:)),2))));
			allquad(4)=(max(max(nanmean((sw34err_exp(:,1:skip:end,:)),2))));
			allquad(5)=(max(max(nanmean((ne50err_exp(:,1:skip:end,:)),2))));
			allquad(6)=(max(max(nanmean((se50err_exp(:,1:skip:end,:)),2))));
			allquad(7)=(max(max(nanmean((nw50err_exp(:,1:skip:end,:)),2))));
			allquad(8)=(max(max(nanmean((sw50err_exp(:,1:skip:end,:)),2))));
			allquad(9)=(max(max(nanmean((ne64err_exp(:,1:skip:end,:)),2))));
			allquad(10)=(max(max(nanmean((se64err_exp(:,1:skip:end,:)),2))));
			allquad(11)=(max(max(nanmean((nw64err_exp(:,1:skip:end,:)),2))));
			allquad(12)=(max(max(nanmean((sw64err_exp(:,1:skip:end,:)),2))));
			allquadmax=max(max(max(allquad)));
			allquadmin=min(min(min(allquad)));
			tmpvalq=max(abs(allquadmin),abs(allquadmax));
			if isnan(tmpvalq)==1
					tmpvalq=0;
			end
			if numel(num2str(tmpvalq))==3
				addfacq=100;
			elseif numel(num2str(tmpvalq))==2
				addfacq=20;
			else
				addfacq=20;
			end
			if numel(num2str(round(max(max(nanmean((tmp_exp),2))))))==3
				addfac=100;
			elseif numel(num2str(round(max(max(nanmean((tmp_exp),2))))))==2
				addfac=20;
			else
				addfac=20;
			end
			if plt<=3 || (plt>=16 && plt<=18) % 0-end
				tmpmin=min(min(nanmean((tmp_exp),2)));
				tmpmax=max(max(nanmean((tmp_exp),2)));
				tmpval=max(abs(tmpmin),abs(tmpmax));
				if isnan(tmpval)==1
					tmpval=0;
				end
				yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];                                
			elseif plt==19 || plt==20 % -end end 
				tmpmin=min(min(nanmean((tmp_exp),2)));
				tmpmax=max(max(nanmean((tmp_exp),2)));
				tmpval=max(abs(tmpmin),abs(tmpmax));
				if isnan(tmpval)==1
					tmpval=0;
				end
				yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];                
			elseif (plt>=4 && plt<=15) || plt>=21%quad
				yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
			end
			xlim(yrange)
			if size(identinittimesunique,1)>50
				set(gca,'ytick',1:4:100)
				set(gca,'yticklabel',identinittimesunique(1:4:end,:))
			else
				set(gca,'ytick',1:2:100)
				set(gca,'yticklabel',identinittimesunique(1:2:end,:))
			end  
			grid on
			set(gca,'gridcolor','k','gridalpha',.15)
			set(gca,'fontsize',20)      
			hold off
			box on
			lh=legend(l,identexpshort,'location','northeast');
			lh.FontSize=10;
			set(gcf,'Units','inches');
			a1Pos = get(gca,'Position');
			set(gcf, 'InvertHardcopy', 'off')
			set(gcf,'Units','inches');
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')
			text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
			text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
			text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
			ax=gca;
			box on
			set(ax, 'Layer', 'bottom')
			ax.LineWidth=1; 
			set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
			set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .85, 0.96]); % maximize figure window
			set(gca,'Color',[.9 .9 .9])
			clear cntexp
			for tmp=1:size(identexp,1)
				cntexp(:,tmp)=sum(~isnan(tmp_exp(:,:,tmp)),2);
			end
			if sum([cntexp(:)])==0
				tx=text(0.02,0.98,'Not Enough Data','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				set(tx, 'Layer', 'front')
			end   
			if plt==1 || plt>=4 && plt<=15 || plt==17 || plt==18 || plt>20
				 tx=text(0.02,0.05,'Too Small','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 tx=text(0.98,0.05,'Too Large','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 set(tx, 'Layer', 'front')  
			elseif plt==2 || plt==16
				 tx=text(0.02,0.05,'Too Low','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 tx=text(0.98,0.05,'Too High','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 set(tx, 'Layer', 'front')  
			elseif plt==3
				 tx=text(0.02,0.05,'Too Slow','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 tx=text(0.98,0.05,'Too Fast','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 set(tx, 'Layer', 'front') 
			elseif plt==19
				 tx=text(0.02,0.05,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 tx=text(0.98,0.05,'Faster than BT','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 set(tx, 'Layer', 'front')            
			elseif plt==20
				 tx=text(0.02,0.05,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 tx=text(0.98,0.05,'Right of BT','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
				 set(tx, 'Layer', 'front')            
			end                                              
			axis ij;b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
			yyaxis left
			set(b,'YColor','none');
			yyaxis right
			set(b,'plotboxaspectratio',[1 1 1])
			set(b,'Color','none');
			set(b,'XColor','none');
			set(b,'tickdir','both')
			set(b,'YColor',[0 0 0]);
			set(b,'xtick',[]);
			ylim(b,[xstart-.5 size(BT_lat,1)+.5])
			tmpxend=size(BT_lat,1);
			if size(identinittimesunique,1)>50
				set(b,'ytick',[1:4:100]); 
			else
				set(b,'ytick',[1:2:100]); 
			end  
			trkerr_exp_fcnt=zeros(1,tmpxend);            
			trkerr_exp_fcnt1=zeros(1,tmpxend);            
			trkerr_exp_fcnt2=zeros(1,tmpxend);
			clear cntexp
			for tmp=1:size(identexp,1)
				cntexp(:,tmp)=sum(~isnan(tmp_exp(:,:,tmp)),2);
			end  
			set(gca,'fontsize',12)
			xL=xlim;
			yL=ylim;
			ylabel({'# 6-h','fcsts'},'Position',[xL(2) yL(2)],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',0); 
			set(gca,'position',[spPos(1)+.08 spPos(2)+.05 spPos(3) spPos(4)])
			screenposition = get(gcf,'Position');
			set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
			set(gcf, 'InvertHardcopy', 'off')            
			% Create a text box at every Tick label position
			maxmin=squeeze(sum(~isnan(tmp_exp(:,:,:)),2)); 
			if size(identinittimesunique,1)>50
				maxmin=maxmin(1:4:end,:); 
			else
				maxmin=maxmin(1:2:end,:); 
			end
			yTicks0 = get(gca, 'yticklabel');
			yTicks = get(gca, 'ytick');
			set(b,'yticklabels',[]);
			minX =1;
			HorizontalOffset1=0.03;
			VerticalOffset = 0.2;
			for xx = 1:size(yTicks0,1)
				tmptxt0=maxmin(xx,:);
				tmptxt1=[];
				if size(unique(tmptxt0),2)==1
					tmptxt1=num2str(tmptxt0(1));
				else
					for xxx=1:size(maxmin,2)
						  if xxx==size(maxmin,2)
							  tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(xxx,:)),'}',num2str(tmptxt0(xxx))];
						  else
							  tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(xxx,:)),'}',num2str(tmptxt0(xxx)),'\color[rgb]{0,0,0}/'];
						  end
					end
				end
				text(minX+HorizontalOffset1,yTicks(xx),tmptxt1,'verticalalignment','middle','fontsize',12)
			end
			axis ij;f = getframe(hfig);
			if identeps==1;filename=[identtrackint,'/FULL/',identn,'_',tmp_name,'_cycles'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
			close all
		end
	end

	%% NaN NOT TD TS HU - this is a switch in the namelist
	if exist('BT_cat','var')==1
		btct=BT_cat(:);
		for i=1:size(btct)
			if isempty(btct{i})==1
				btct0(i,:)='XX';
			else
				btct0(i,:)=btct{i};
			end
		end
		btct=unique(btct0,'rows');
		if strcmp(btct,'XX')==1 %% no category designation yet! this wont be NHC verified
			disp(['The BT for ',identn,' does not have a category designation yet! Therefore it cannot be NHC verified. While FULL/ graphics are created for this storm, subsets will NOT be generated and it will NOT be included in any composites']);
		else
			%% Remove times when initial and verification time are not tropical or subtropical
			if identremoveinv==1
				% First remove forecasts when
				% t=0=nottropicalorsubtropical
				for exrm=1:size(BT_cat,1)
					if strcmp(BT_cat{exrm,1},'TD')==0 && strcmp(BT_cat{exrm,1},'TS')==0 && strcmp(BT_cat{exrm,1},'HU')==0 && strcmp(BT_cat{exrm,1},'SD')==0 && strcmp(BT_cat{exrm,1},'SS')==0
						for exno=1:size(BT_cat,2)
							BT_cat{exrm,exno}=NaN;                        
							BT_lon(exrm,exno)=NaN;BT_land(exrm,exno)=NaN;
							BT_lat(exrm,exno)=NaN;
							BT_maxspd(exrm,exno)=NaN;
							BT_minpres(exrm,exno)=NaN;
							BT_ne34(exrm,exno)=NaN;
							BT_ne50(exrm,exno)=NaN;
							BT_ne64(exrm,exno)=NaN;
							BT_se34(exrm,exno)=NaN;
							BT_se50(exrm,exno)=NaN;
							BT_se64(exrm,exno)=NaN;
							BT_sw34(exrm,exno)=NaN;
							BT_sw50(exrm,exno)=NaN;
							BT_sw64(exrm,exno)=NaN;
							BT_nw34(exrm,exno)=NaN;
							BT_nw50(exrm,exno)=NaN;
							BT_nw64(exrm,exno)=NaN;
							BT_po(exrm,exno)=NaN;
							BT_ro(exrm,exno)=NaN;
							BT_rmw(exrm,exno)=NaN;         
							BT_intch(exrm,exno)=NaN;         
							BT_shr(exrm,exno)=NaN;         
							EXP_lon(exrm,exno,:)=NaN;EXP_land(exrm,exno,:)=NaN;
							EXP_lat(exrm,exno,:)=NaN;
							EXP_maxspd(exrm,exno,:)=NaN;
							EXP_minpres(exrm,exno,:)=NaN;
							EXP_ne34(exrm,exno,:)=NaN;
							EXP_ne50(exrm,exno,:)=NaN;
							EXP_ne64(exrm,exno,:)=NaN;
							EXP_se34(exrm,exno,:)=NaN;
							EXP_se50(exrm,exno,:)=NaN;
							EXP_se64(exrm,exno,:)=NaN;
							EXP_sw34(exrm,exno,:)=NaN;
							EXP_sw50(exrm,exno,:)=NaN;
							EXP_sw64(exrm,exno,:)=NaN;
							EXP_nw34(exrm,exno,:)=NaN;
							EXP_nw50(exrm,exno,:)=NaN;
							EXP_nw64(exrm,exno,:)=NaN;
							EXP_po(exrm,exno,:)=NaN;
							EXP_ro(exrm,exno,:)=NaN;
							EXP_rmw(exrm,exno,:)=NaN;         
							EXP_intch(exrm,exno,:)=NaN;         
							EXP_shr(exrm,exno,:)=NaN;         
							ateerr_exp(exrm,exno,:)=NaN;
							xteerr_exp(exrm,exno,:)=NaN;
							trkerr_exp(exrm,exno,:)=NaN;
							interr_exp(exrm,exno,:)=NaN;
							spderr_exp(exrm,exno,:)=NaN;
							ne34err_exp(exrm,exno,:)=NaN;
							se34err_exp(exrm,exno,:)=NaN;
							sw34err_exp(exrm,exno,:)=NaN;
							nw34err_exp(exrm,exno,:)=NaN;
							ne50err_exp(exrm,exno,:)=NaN;
							se50err_exp(exrm,exno,:)=NaN;
							sw50err_exp(exrm,exno,:)=NaN;
							nw50err_exp(exrm,exno,:)=NaN;
							ne64err_exp(exrm,exno,:)=NaN;
							se64err_exp(exrm,exno,:)=NaN;
							sw64err_exp(exrm,exno,:)=NaN;
							nw64err_exp(exrm,exno,:)=NaN;
							poerr_exp(exrm,exno,:)=NaN;
							roerr_exp(exrm,exno,:)=NaN;
							rmwerr_exp(exrm,exno,:)=NaN;
						end       
					end
				end                    

				% Second remove times when t=0=tropical and t=x=nottropical
				for exrm=1:size(BT_cat,1)
					for exno=1:size(BT_cat,2)
						if strcmp(BT_cat{exrm,exno},'TD')==0 && strcmp(BT_cat{exrm,exno},'TS')==0 && strcmp(BT_cat{exrm,exno},'HU')==0 && strcmp(BT_cat{exrm,exno},'SD')==0  && strcmp(BT_cat{exrm,exno},'SS')==0  
							BT_cat{exrm,exno}=NaN;                        
							BT_lon(exrm,exno)=NaN;BT_land(exrm,exno)=NaN;
							BT_lat(exrm,exno)=NaN;
							BT_maxspd(exrm,exno)=NaN;
							BT_minpres(exrm,exno)=NaN;
							BT_ne34(exrm,exno)=NaN;
							BT_ne50(exrm,exno)=NaN;
							BT_ne64(exrm,exno)=NaN;
							BT_se34(exrm,exno)=NaN;
							BT_se50(exrm,exno)=NaN;
							BT_se64(exrm,exno)=NaN;
							BT_sw34(exrm,exno)=NaN;
							BT_sw50(exrm,exno)=NaN;
							BT_sw64(exrm,exno)=NaN;
							BT_nw34(exrm,exno)=NaN;
							BT_nw50(exrm,exno)=NaN;
							BT_nw64(exrm,exno)=NaN;
							BT_po(exrm,exno)=NaN;
							BT_ro(exrm,exno)=NaN;
							BT_rmw(exrm,exno)=NaN;         
							BT_intch(exrm,exno)=NaN;         
							BT_shr(exrm,exno)=NaN;         
							EXP_lon(exrm,exno,:)=NaN;EXP_land(exrm,exno,:)=NaN;
							EXP_lat(exrm,exno,:)=NaN;
							EXP_maxspd(exrm,exno,:)=NaN;
							EXP_minpres(exrm,exno,:)=NaN;
							EXP_ne34(exrm,exno,:)=NaN;
							EXP_ne50(exrm,exno,:)=NaN;
							EXP_ne64(exrm,exno,:)=NaN;
							EXP_se34(exrm,exno,:)=NaN;
							EXP_se50(exrm,exno,:)=NaN;
							EXP_se64(exrm,exno,:)=NaN;
							EXP_sw34(exrm,exno,:)=NaN;
							EXP_sw50(exrm,exno,:)=NaN;
							EXP_sw64(exrm,exno,:)=NaN;
							EXP_nw34(exrm,exno,:)=NaN;
							EXP_nw50(exrm,exno,:)=NaN;
							EXP_nw64(exrm,exno,:)=NaN;
							EXP_po(exrm,exno,:)=NaN;
							EXP_ro(exrm,exno,:)=NaN;
							EXP_rmw(exrm,exno,:)=NaN;         
							EXP_intch(exrm,exno,:)=NaN;         
							EXP_shr(exrm,exno,:)=NaN;         
							ateerr_exp(exrm,exno,:)=NaN;
							xteerr_exp(exrm,exno,:)=NaN;
							trkerr_exp(exrm,exno,:)=NaN;
							interr_exp(exrm,exno,:)=NaN;
							spderr_exp(exrm,exno,:)=NaN;
							ne34err_exp(exrm,exno,:)=NaN;
							se34err_exp(exrm,exno,:)=NaN;
							sw34err_exp(exrm,exno,:)=NaN;
							nw34err_exp(exrm,exno,:)=NaN;
							ne50err_exp(exrm,exno,:)=NaN;
							se50err_exp(exrm,exno,:)=NaN;
							sw50err_exp(exrm,exno,:)=NaN;
							nw50err_exp(exrm,exno,:)=NaN;
							ne64err_exp(exrm,exno,:)=NaN;
							se64err_exp(exrm,exno,:)=NaN;
							sw64err_exp(exrm,exno,:)=NaN;
							nw64err_exp(exrm,exno,:)=NaN;
							poerr_exp(exrm,exno,:)=NaN;
							roerr_exp(exrm,exno,:)=NaN;
							rmwerr_exp(exrm,exno,:)=NaN;
						end       
					end
				end                    
			end
			
			%% Remove times when initial and verification time are over land, as specified by the namelist
			if identremoveland==1
				% First remove forecasts when t=0=LAND
				for exrm=1:size(BT_land,1)
					if BT_land(exrm,1)==1 
						for exno=1:size(BT_cat,2)
							BT_cat{exrm,exno}=NaN;                        
							BT_lon(exrm,exno)=NaN;BT_land(exrm,exno)=NaN;
							BT_lat(exrm,exno)=NaN;
							BT_maxspd(exrm,exno)=NaN;
							BT_minpres(exrm,exno)=NaN;
							BT_ne34(exrm,exno)=NaN;
							BT_ne50(exrm,exno)=NaN;
							BT_ne64(exrm,exno)=NaN;
							BT_se34(exrm,exno)=NaN;
							BT_se50(exrm,exno)=NaN;
							BT_se64(exrm,exno)=NaN;
							BT_sw34(exrm,exno)=NaN;
							BT_sw50(exrm,exno)=NaN;
							BT_sw64(exrm,exno)=NaN;
							BT_nw34(exrm,exno)=NaN;
							BT_nw50(exrm,exno)=NaN;
							BT_nw64(exrm,exno)=NaN;
							BT_po(exrm,exno)=NaN;
							BT_ro(exrm,exno)=NaN;
							BT_rmw(exrm,exno)=NaN;         
							BT_intch(exrm,exno)=NaN;         
							BT_shr(exrm,exno)=NaN;         
							EXP_lon(exrm,exno,:)=NaN;EXP_land(exrm,exno,:)=NaN;
							EXP_lat(exrm,exno,:)=NaN;
							EXP_maxspd(exrm,exno,:)=NaN;
							EXP_minpres(exrm,exno,:)=NaN;
							EXP_ne34(exrm,exno,:)=NaN;
							EXP_ne50(exrm,exno,:)=NaN;
							EXP_ne64(exrm,exno,:)=NaN;
							EXP_se34(exrm,exno,:)=NaN;
							EXP_se50(exrm,exno,:)=NaN;
							EXP_se64(exrm,exno,:)=NaN;
							EXP_sw34(exrm,exno,:)=NaN;
							EXP_sw50(exrm,exno,:)=NaN;
							EXP_sw64(exrm,exno,:)=NaN;
							EXP_nw34(exrm,exno,:)=NaN;
							EXP_nw50(exrm,exno,:)=NaN;
							EXP_nw64(exrm,exno,:)=NaN;
							EXP_po(exrm,exno,:)=NaN;
							EXP_ro(exrm,exno,:)=NaN;
							EXP_rmw(exrm,exno,:)=NaN;         
							EXP_intch(exrm,exno,:)=NaN;         
							EXP_shr(exrm,exno,:)=NaN;         
							ateerr_exp(exrm,exno,:)=NaN;
							xteerr_exp(exrm,exno,:)=NaN;
							trkerr_exp(exrm,exno,:)=NaN;
							interr_exp(exrm,exno,:)=NaN;
							spderr_exp(exrm,exno,:)=NaN;
							ne34err_exp(exrm,exno,:)=NaN;
							se34err_exp(exrm,exno,:)=NaN;
							sw34err_exp(exrm,exno,:)=NaN;
							nw34err_exp(exrm,exno,:)=NaN;
							ne50err_exp(exrm,exno,:)=NaN;
							se50err_exp(exrm,exno,:)=NaN;
							sw50err_exp(exrm,exno,:)=NaN;
							nw50err_exp(exrm,exno,:)=NaN;
							ne64err_exp(exrm,exno,:)=NaN;
							se64err_exp(exrm,exno,:)=NaN;
							sw64err_exp(exrm,exno,:)=NaN;
							nw64err_exp(exrm,exno,:)=NaN;
							poerr_exp(exrm,exno,:)=NaN;
							roerr_exp(exrm,exno,:)=NaN;
							rmwerr_exp(exrm,exno,:)=NaN;
						end       
					end
				end                    

				% Second remove forecasts when t=x=LAND            
				for exrm=1:size(BT_land,1)
					for exno=1:size(BT_cat,2)
						if BT_land(exrm,exno)==1 
							BT_cat{exrm,exno}=NaN;                        
							BT_lon(exrm,exno)=NaN;BT_land(exrm,exno)=NaN;
							BT_lat(exrm,exno)=NaN;
							BT_maxspd(exrm,exno)=NaN;
							BT_minpres(exrm,exno)=NaN;
							BT_ne34(exrm,exno)=NaN;
							BT_ne50(exrm,exno)=NaN;
							BT_ne64(exrm,exno)=NaN;
							BT_se34(exrm,exno)=NaN;
							BT_se50(exrm,exno)=NaN;
							BT_se64(exrm,exno)=NaN;
							BT_sw34(exrm,exno)=NaN;
							BT_sw50(exrm,exno)=NaN;
							BT_sw64(exrm,exno)=NaN;
							BT_nw34(exrm,exno)=NaN;
							BT_nw50(exrm,exno)=NaN;
							BT_nw64(exrm,exno)=NaN;
							BT_po(exrm,exno)=NaN;
							BT_ro(exrm,exno)=NaN;
							BT_rmw(exrm,exno)=NaN;         
							BT_intch(exrm,exno)=NaN;         
							BT_shr(exrm,exno)=NaN;         
							EXP_lon(exrm,exno,:)=NaN;EXP_land(exrm,exno,:)=NaN;
							EXP_lat(exrm,exno,:)=NaN;
							EXP_maxspd(exrm,exno,:)=NaN;
							EXP_minpres(exrm,exno,:)=NaN;
							EXP_ne34(exrm,exno,:)=NaN;
							EXP_ne50(exrm,exno,:)=NaN;
							EXP_ne64(exrm,exno,:)=NaN;
							EXP_se34(exrm,exno,:)=NaN;
							EXP_se50(exrm,exno,:)=NaN;
							EXP_se64(exrm,exno,:)=NaN;
							EXP_sw34(exrm,exno,:)=NaN;
							EXP_sw50(exrm,exno,:)=NaN;
							EXP_sw64(exrm,exno,:)=NaN;
							EXP_nw34(exrm,exno,:)=NaN;
							EXP_nw50(exrm,exno,:)=NaN;
							EXP_nw64(exrm,exno,:)=NaN;
							EXP_po(exrm,exno,:)=NaN;
							EXP_ro(exrm,exno,:)=NaN;
							EXP_rmw(exrm,exno,:)=NaN;         
							EXP_intch(exrm,exno,:)=NaN;         
							EXP_shr(exrm,exno,:)=NaN;         
							ateerr_exp(exrm,exno,:)=NaN;
							xteerr_exp(exrm,exno,:)=NaN;
							trkerr_exp(exrm,exno,:)=NaN;
							interr_exp(exrm,exno,:)=NaN;
							spderr_exp(exrm,exno,:)=NaN;
							ne34err_exp(exrm,exno,:)=NaN;
							se34err_exp(exrm,exno,:)=NaN;
							sw34err_exp(exrm,exno,:)=NaN;
							nw34err_exp(exrm,exno,:)=NaN;
							ne50err_exp(exrm,exno,:)=NaN;
							se50err_exp(exrm,exno,:)=NaN;
							sw50err_exp(exrm,exno,:)=NaN;
							nw50err_exp(exrm,exno,:)=NaN;
							ne64err_exp(exrm,exno,:)=NaN;
							se64err_exp(exrm,exno,:)=NaN;
							sw64err_exp(exrm,exno,:)=NaN;
							nw64err_exp(exrm,exno,:)=NaN;
							poerr_exp(exrm,exno,:)=NaN;
							roerr_exp(exrm,exno,:)=NaN;
							rmwerr_exp(exrm,exno,:)=NaN;
						end       
					end
				end                    
			end
						
			if sum(~isnan(BT_lat(:)))==0
				% delete the folder of the storm if no data 
				%rmdir([identout,'RESULTS/',identfold,'VERIFICATION/',identremovename,'/',ident(1:2),'/',identn,'/'],'s')
			else
				spPos=[0.11 0.13+.05 0.75 0.75-.05]; % arrange plots the same
				% Subsets
				if identconv==1 || identsatobs==1 
					stratlist=[1:37,100];
					BT_drops=identdropcyc;BT_obsg=identobscyc;
					BT_target=identdropcyc;
					btd=find(BT_drops==1);
					if isempty(btd)==1 && identconv==1 % if the storm has conventional obs...           
						keepstm=NaN;
					elseif isempty(btd)==1 && identconv==0 % if conventional obs are turned off...
						keepstm=1;
					else
						BT_target(btd(1):end)=1; % from first time conventional obs detected in storm through end of storm
						keepstm=1; % save storm index since it has conventional obs
					end
				else
					stratlist=[1,4:14,29:31];
					keepstm=NaN;
				end
				
				if identns==1
					stratlist=[stratlist 888];
				end
				clear scfactor scfactor0
				BT_cat1=BT_maxspd(:,1);BT_cat0=BT_cat(:,1);
				BT_lat1=BT_lat(:,1);
				BT_intch1=BT_intch(:,1);
				BT_shr1=BT_shr(:,1);
				for strat=stratlist    
					if strat==1 % none
						clear breakstrat
						stname='NONE';
					elseif strat==2 % by those that had obs
						clear breakstrat
						stname='OBS';
						if sum(BT_drops==1)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_OBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: OBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==3 % by those storms from first point of obs till end
						clear breakstrat
						stname='RECON';
						 if sum(BT_target==1)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_RECON.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: RECON');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==4 % by intensity
						clear breakstrat
						stname='TD'; % <34 kts
						if sum(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_TD.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: TD');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==5
						clear breakstrat
						stname='TS'; % >=34 kts & < 64 kts
						if sum(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_TS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: TS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==6
						clear breakstrat
						stname='H12'; % >= 64 kts & < 96 kts
						if sum(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_H12.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: H12');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==7
						clear breakstrat
						stname='H345'; % >= 96 kts
						if sum(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_H345.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: H345');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==8 
						clear breakstrat
						stname='N30'; % north of 30N
						if sum(BT_lat1>=30)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_N30.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: N30');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==9
						clear breakstrat
						stname='S30'; % south of 30N
						if sum(BT_lat1<30)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_S30.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: S30');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==10
						clear breakstrat
						stname='RI'; % rapidly intensifying storms
						if sum(BT_intch1>=15./1.94384 )==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_RI.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: RI');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end											
					elseif strat==11
						clear breakstrat
						stname='IN'; % intensifying storms
						if sum(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 )==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_IN.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: IN');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end	
					elseif strat==12
						clear breakstrat
						stname='SS'; % steady-state storms
						if sum(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 )==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_SS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: SS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end	
					elseif strat==13
						clear breakstrat
						stname='WK'; % weakening storms 
						if sum(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 )==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_WK.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: WK');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end	
					elseif strat==14
						clear breakstrat
						stname='RW'; % rapidly weakening storms 
						if sum(BT_intch1<=-15./1.94384)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_RW.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: RW');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==15 %% TD strat obs only
						clear breakstrat
						stname='TD-OBS'; % <34 kts
						if sum(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_TD-OBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: TD-OBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==16 %% TS strat obs only
						clear breakstrat
						stname='TS-OBS'; % >=34 kts & < 64 kts
						if sum(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_TS-OBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: TS-OBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==17 %% H12 strat obs only
						clear breakstrat
						stname='H12-OBS'; % >= 64 kts & < 96 kts
						if sum(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_H12-OBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: H12-OBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==18 %% H345 strat obs only
						clear breakstrat
						stname='H345-OBS'; % >= 96 kts
						if sum(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_H345-OBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: H345-OBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==19 %% N30 strat obs only
						clear breakstrat
						stname='N30-OBS'; % north of 30N
						if sum(BT_lat1>=30 & BT_drops'==1)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_N30-OBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: N30-OBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==20 %% S30 strat obs only
						clear breakstrat
						stname='S30-OBS'; % south of 30N
						if sum(BT_lat1<30 & BT_drops'==1)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_S30-OBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: S30-OBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end  
					elseif strat==21 % by those that had no obs
						clear breakstrat
						stname='NOOBS';
						if sum(BT_drops'==0)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_NOOBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: NOOBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==22 % by those storms before the first point of ob
						clear breakstrat
						stname='PRERECON';
						if sum(BT_target'==0)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_PRERECON.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: PRERECON');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					 elseif strat==23 %% TD strat NOOBS only
						clear breakstrat
						stname='TD-NOOBS'; % <34 kts
						if sum(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_TD-NOOBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: TD-NOOBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==24 %% TS strat NOOBS only
						clear breakstrat
						stname='TS-NOOBS'; % >=34 kts & < 64 kts
						if sum(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_TS-NOOBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: TS-NOOBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==25 %% H12 strat NOOBS only
						clear breakstrat
						stname='H12-NOOBS'; % >= 64 kts & < 96 kts
						if sum(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_H12-NOOBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: H12-NOOBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==26 %% H345 strat NOOBS only
						clear breakstrat
						stname='H345-NOOBS'; % >= 96 kts
						if sum(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_H345-NOOBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: H345-NOOBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==27 %% N30 strat NOOBS only
						clear breakstrat
						stname='N30-NOOBS'; % north of 30N
						if sum(BT_lat1>=30 & BT_drops'==0)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_N30-NOOBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: N30-NOOBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==28 %% S30 strat NOOBS only
						clear breakstrat
						stname='S30-NOOBS'; % south of 30N
						if sum(BT_lat1<30 & BT_drops'==0)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_S30-NOOBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: S30-NOOBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end  
					elseif strat==29 %% Low Shear
						clear breakstrat
						stname='LOW'; 
						if sum(BT_shr1<LOWbasin)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_LOW.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: LOW');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end 
					elseif strat==30 %% Moderate Shear
						clear breakstrat
						stname='MOD';
						if sum(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_MOD.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: MOD');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end 
					elseif strat==31 %% High Shear
						clear breakstrat
						stname='HIGH'; 
						if sum(BT_shr1>HIGHbasin)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_HIGH.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: HIGH');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end 	
					elseif strat==32 %% Low Shear OBS
						clear breakstrat
						stname='LOW-OBS'; 
						if sum(BT_shr1<LOWbasin & BT_drops'==1)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_LOW-OBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: LOW-OBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end 
					elseif strat==33 %% Moderate Shear OBS
						clear breakstrat
						stname='MOD-OBS';
						if sum(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==1)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_MOD-OBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: MOD-OBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end 
					elseif strat==34 %% High Shear OBS
						clear breakstrat
						stname='HIGH-OBS'; 
						if sum(BT_shr1>HIGHbasin & BT_drops'==1)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_HIGH-OBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: HIGH-OBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end
					elseif strat==35 %% Low Shear NOOBS
						clear breakstrat
						stname='LOW-NOOBS'; 
						if sum(BT_shr1<LOWbasin & BT_drops'==0)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_LOW-NOOBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: LOW-NOOBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end 
					elseif strat==36 %% Moderate Shear NOOBS
						clear breakstrat
						stname='MOD-NOOBS';
						if sum(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_MOD-NOOBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: MOD-NOOBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end 
					elseif strat==37 %% High Shear NOOBS
						clear breakstrat
						stname='HIGH-NOOBS'; 
						if sum(BT_shr1>HIGHbasin & BT_drops'==0)==0 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_HIGH-NOOBS.txt'],'wt');
							fprintf(fid,'%s\n','STRATIFICATION: HIGH-NOOBS');
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end 		
					elseif strat==100 % by those that had obs
                                            clear breakstrat
                                            stname='OBS-G';
                                            if sum(BT_obsg==1)==0
                                                breakstrat='yes';
                                                fid = fopen([identtrackint,'/STRAT_OBS-G.txt'],'wt');
                                                fprintf(fid,'%s\n','STRATIFICATION: OBS-G');
                                                fprintf(fid,'%s\n','none');
                                                fclose(fid);
                                            end
					elseif strat==888
						clear breakstrat
						stname=identnsname;
						clear tmpyrb
						numlist=[];
						for ins=1:size(identnewsub,1)
							tmpns=identnewsub(ins,:);
							for ins2=1:size(identinittimesunique,1)
								if strcmp(identinittimesunique(ins2,:),tmpns)==1
									numlist=[numlist ins2];
								end
							end
						end
						if isempty(numlist)==1 && identcompositeonly==0
							breakstrat='yes';
							fid = fopen([identtrackint,'/STRAT_',identnsname,'.txt'],'wt');
							fprintf(fid,'%s\n',['STRATIFICATION: ',identnsname]);
							fprintf(fid,'%s\n','none');
							fclose(fid);
						end  
					end

					if exist('breakstrat','var')==1 && identcompositeonly==0
							% Create Graphics: trk, int, spd errors - bt-gh vs. bt-deny
							for plt=1:23
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax1=subplot(3,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkerr';
									 tmp_title='Track Error (km)';
									 tmp_ytitle='Error (km)';
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prserr';
									tmp_title='Pressure Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spderr';
									tmp_title='Wind Speed Error (m/s)';
									tmp_ytitle='Error (m/s)';
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFerr';
									tmp_title='RTSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFerr';
									tmp_title='RTSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFerr';
									tmp_title='RTSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFerr';
									tmp_title='RTSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFerr';
									tmp_title='RSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFerr';
									tmp_title='RSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFerr';
									tmp_title='RSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFerr';
									tmp_title='RSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFerr';
									tmp_title='RHF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFerr';
									tmp_title='RHF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFerr';
									tmp_title='RHF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFerr';
									tmp_title='RHF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poerr';
									tmp_title='Outer Clsd Isbr Prs Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roerr';
									tmp_title='Outer Clsd Isbr Rad Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwerr';
									tmp_title='RMW Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='trkbias1';
									tmp_title='Along-Track Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-500 500];                
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='trkbias2';
									tmp_title='Across-Track Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-500 500]; 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFerr';
									tmp_title='RTSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFerr';
									tmp_title='RSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFerr';
									tmp_title='RHF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								tmp_exp0=tmp_exp;                                                  
								plot(-10:89,zeros(1,100),'Color',[.5 .5 .5],'linewidth',2);                                                    
								set(gca,'plotboxaspectratio',[1 1 1])
								xlabel('Forecast Lead Time (h)','fontsize',20)
								ylabel(tmp_ytitle,'fontsize',20)
								set(gca,'fontsize',20)
								box on
								if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
									if mod(identmaxfhr*3,12)==0
										xlim([1 ((identmaxfhr*3))/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
									end
								else
									if mod(identmaxfhr*3-3,12)==0
										xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
									end
								end
								 % YRANGE
								clear allquad
								allquad(1)=(max(max(nanmean(abs(ne34err_exp(:,1:skip:end,:)),1))));
								allquad(2)=(max(max(nanmean(abs(se34err_exp(:,1:skip:end,:)),1))));
								allquad(3)=(max(max(nanmean(abs(nw34err_exp(:,1:skip:end,:)),1))));
								allquad(4)=(max(max(nanmean(abs(sw34err_exp(:,1:skip:end,:)),1))));
								allquad(5)=(max(max(nanmean(abs(ne50err_exp(:,1:skip:end,:)),1))));
								allquad(6)=(max(max(nanmean(abs(se50err_exp(:,1:skip:end,:)),1))));
								allquad(7)=(max(max(nanmean(abs(nw50err_exp(:,1:skip:end,:)),1))));
								allquad(8)=(max(max(nanmean(abs(sw50err_exp(:,1:skip:end,:)),1))));
								allquad(9)=(max(max(nanmean(abs(ne64err_exp(:,1:skip:end,:)),1))));
								allquad(10)=(max(max(nanmean(abs(se64err_exp(:,1:skip:end,:)),1))));
								allquad(11)=(max(max(nanmean(abs(nw64err_exp(:,1:skip:end,:)),1))));
								allquad(12)=(max(max(nanmean(abs(sw64err_exp(:,1:skip:end,:)),1))));
								allquadmax=max(max(max(allquad)));
								allquadmin=min(min(min(allquad)));
								tmpvalq=max(abs(allquadmin),abs(allquadmax));
								if isnan(tmpvalq)==1
									tmpvalq=0;
								end
								if numel(num2str(tmpvalq))==3
									addfacq=100;
								elseif numel(num2str(tmpvalq))==2
									addfacq=20;
								else 
									addfacq=20;
								end
								if numel(num2str(round(max(max(nanmean((tmp_exp0),1))))))==3
									addfac=100;
								elseif numel(num2str(round(max(max(nanmean((tmp_exp0),1))))))==2
									addfac=20;
								else
									addfac=20;
								end
								if plt<=3 || (plt>=16 && plt<=18) % 0-end
									tmpmin=min(min(nanmean((tmp_exp0),1)));
									tmpmax=max(max(nanmean((tmp_exp0),1)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[0 round((tmpval+addfac)/10)*10];                
								elseif plt==19 || plt==20 % -end end 
									tmpmin=min(min(nanmean((tmp_exp0),1)));
									tmpmax=max(max(nanmean((tmp_exp0),1)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
								elseif (plt>=4 && plt<=15) || plt>=21%quad
									yrange=[0 round((tmpvalq+addfacq)/10)*10];
								end
								ylim(yrange)
								set(gca,'xtick',1:skiptick:50)
								set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
								grid on
								set(gca,'gridcolor','k','gridalpha',.15)
								set(gca,'fontsize',20)      
								hold off
								box on
								set(gcf,'Units','inches');
								a1Pos = get(gca,'Position');
								set(gcf, 'InvertHardcopy', 'off')
								set(gcf,'Units','inches');
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')    
								text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
								tmpuv = 0;                               
								tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];
								if strat==1
								text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								else
								text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								end
								ax=gca;
								box on
								set(ax, 'Layer', 'bottom')
								ax.LineWidth=1; 
								set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
								set(gca,'Color',[.9 .9 .9])
								for tmp=1:size(identexp,1)
									cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
								end
									tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									set(tx, 'Layer', 'front')
								if plt==19
									 tx=text(0.02,0.05,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.02,0.98,'Faster than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')            
								elseif plt==20
									 tx=text(0.02,0.05,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.02,0.98,'Right of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')            
								end                                                    
								f = getframe(hfig);
								if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
								close all
							end   
							% Create Graphics: trk, int, spd Skill vs. deny
							for plt=[1:18,21:23]
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax1=subplot(3,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkskill';
									 tmp_title='Track Skill (\%)';
									 tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									 yrange=[-20 20];
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prskill';
									tmp_title='Pressure Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spdskill';
									tmp_title='Wind Speed Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFskill';
									tmp_title='RTSF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFskill';
									tmp_title='RTSF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFskill';
									tmp_title='RTSF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFskill';
									tmp_title='RTSF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFskill';
									tmp_title='RSF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFskill';
									tmp_title='RSF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFskill';
									tmp_title='RSF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFskill';
									tmp_title='RSF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFskill';
									tmp_title='RHF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFskill';
									tmp_title='RHF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFskill';
									tmp_title='RHF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFskill';
									tmp_title='RHF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poskill';
									tmp_title='Outer Clsd Isbr Prs Skill (hPa)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roskill';
									tmp_title='Outer Clsd Isbr Rad Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwskill';
									tmp_title='RMW Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='ateskill';
									tmp_title='Along-Track Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xteskill';
									tmp_title='Across-Track Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFskill';
									tmp_title='RTSF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFskill';
									tmp_title='RSF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFskill';
									tmp_title='RHF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								plot(-10:89,zeros(1,100),'Color',[.5 .5 .5],'linewidth',2);
								set(gca,'plotboxaspectratio',[1 1 1])
								xlabel('Forecast Lead Time (h)','fontsize',20)
								ylabel(tmp_ytitle,'fontsize',20)
								set(gca,'fontsize',20)
								box on
								if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
									if mod(identmaxfhr*3,12)==0
										xlim([1 ((identmaxfhr*3))/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
									end
								else
									if mod(identmaxfhr*3-3,12)==0
										xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
									end
								end
								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end  
								% YRANGE
								clear allquad imprv3
								imprv3(:,:,1)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,2)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,3)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,4)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,5)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,6)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,7)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,8)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,9)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,10)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,11)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,12)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
								allquadmax=max(max(max(imprv3)));
								allquadmin=min(min(min(imprv3)));
								tmpvalq=max(abs(allquadmin),abs(allquadmax));
								if isnan(tmpvalq)==1
									tmpvalq=0;
								end
								if numel(num2str(tmpvalq))==3
									addfacq=100;
								elseif numel(num2str(tmpvalq))==2
									addfacq=20;
								else
									addfacq=20;
								end

								if numel(num2str(round(max(tmp_exp0(:)))))==3
									addfac=100;
								elseif numel(num2str(round(max(tmp_exp0(:)))))==2
									addfac=20;
								else
									addfac=20;
								end
								if plt<=3 || (plt>=16 && plt<=18) % 0-end
									tmpmin=min(tmp_exp0(:));
									tmpmax=max(tmp_exp0(:));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									if tmpval>250
										yrange=[-250 250];
									else
										yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
									end
								elseif plt==19 || plt==20 % -end end 
									tmpmin=min(tmp_exp0(:));
									tmpmax=max(tmp_exp0(:));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									if tmpval>250
										yrange=[-250 250];
									else
										yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
									end
								elseif (plt>=4 && plt<=15) || plt>=21%quad 
									if tmpvalq>250
										yrange=[-250 250];
									else
										yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
									end
								end
								ylim(yrange)
								set(gca,'xtick',1:skiptick:50)
								set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
								grid on
								set(gca,'gridcolor','k','gridalpha',.15)
								set(gca,'fontsize',20)      
								hold off
								box on
								set(gcf,'Units','inches');
								a1Pos = get(gca,'Position');
								set(gcf, 'InvertHardcopy', 'off')
								set(gcf,'Units','inches');
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
								tmpuv = 0;                               
								tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
								if strat==1
								text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								else
								text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								end
								ax=gca;
								box on
								set(ax, 'Layer', 'bottom')
								ax.LineWidth=1; 
								set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
								set(gca,'Color',[.9 .9 .9])            
									tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									set(tx, 'Layer', 'front')
								f = getframe(hfig);
								if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
								close all
							end
							% Create Graphics: trk, int, spd FSP vs. deny                                    
							for plt=[1:18,21:23]
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax1=subplot(3,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkfsp';
									 tmp_title='Track FSP (\%)';
									 tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									 yrange=[-20 20];
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prsfsp';
									tmp_title='Pressure FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spdfsp';
									tmp_title='Wind Speed FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFfsp';
									tmp_title='RTSF NEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFfsp';
									tmp_title='RTSF SEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFfsp';
									tmp_title='RTSF SWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFfsp';
									tmp_title='RTSF NWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFfsp';
									tmp_title='RSF NEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFfsp';
									tmp_title='RSF SEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFfsp';
									tmp_title='RSF SWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFfsp';
									tmp_title='RSF NWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFfsp';
									tmp_title='RHF NEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFfsp';
									tmp_title='RHF SEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFfsp';
									tmp_title='RHF SWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFfsp';
									tmp_title='RHF NWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='pofsp';
									tmp_title='Outer Clsd Isbr Prs FSP (hPa)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='rofsp';
									tmp_title='Outer Clsd Isbr Rad FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwfsp';
									tmp_title='RMW FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='atefsp';
									tmp_title='Along-Track FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xtefsp';
									tmp_title='Across-Track FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFfsp';
									tmp_title='RTSF FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFfsp';
									tmp_title='RSF FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFfsp';
									tmp_title='RHF FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								tmp_exp0=squeeze(100.*(1-nanmean(tmp_exp(:,:,:),1)./nanmean(tmp_exp(:,:,tmpimp),1)));                  
								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end                                                          
								plot(-10:89,50*ones(1,100),'Color',[.5 .5 .5],'linewidth',2);                                                    
								set(gca,'plotboxaspectratio',[1 1 1])
								xlabel('Forecast Lead Time (h)','fontsize',20)
								ylabel(tmp_ytitle,'fontsize',20)
								set(gca,'fontsize',20)
								box on
								if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
									if mod(identmaxfhr*3,12)==0
										xlim([1 ((identmaxfhr*3))/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
									end
								else
									if mod(identmaxfhr*3-3,12)==0
										xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
									end
								end
								ylim([0 100])
								set(gca,'xtick',1:skiptick:50)
								set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
								grid on
								set(gca,'gridcolor','k','gridalpha',.15)
								set(gca,'fontsize',20)      
								hold off
								box on
								set(gcf,'Units','inches');
								a1Pos = get(gca,'Position');
								set(gcf, 'InvertHardcopy', 'off')
								set(gcf,'Units','inches');
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
								tmpuv = 0;                               
								tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
								if strat==1
								text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								else
								text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								end
								ax=gca;
								box on
								set(ax, 'Layer', 'bottom')
								ax.LineWidth=1; 
								set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
								set(gca,'Color',[.9 .9 .9])            
								tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
								set(tx, 'Layer', 'front')                                                    
								f = getframe(hfig);
								if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
								close all
							end                                    
							% Create Graphics: trk, int, spd bias - bt-gh vs. bt-deny
							for plt=[2:18,21:23] % no across or along for bias since already in error
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax1=subplot(3,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkbias';
									 tmp_title='Track Bias (km)';
									 tmp_ytitle='Bias (km)';
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prsbias';
									tmp_title='Pressure Bias (hPa)';
									tmp_ytitle='Bias (hPa)';
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spdbias';
									tmp_title='Wind Speed Bias (m/s)';
									tmp_ytitle='Bias (m/s)';
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFbias';
									tmp_title='RTSF NEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFbias';
									tmp_title='RTSF SEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFbias';
									tmp_title='RTSF SWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFbias';
									tmp_title='RTSF NWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFbias';
									tmp_title='RSF NEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFbias';
									tmp_title='RSF SEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFbias';
									tmp_title='RSF SWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFbias';
									tmp_title='RSF NWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFbias';
									tmp_title='RHF NEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFbias';
									tmp_title='RHF SEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFbias';
									tmp_title='RHF SWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFbias';
									tmp_title='RHF NWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='pobias';
									tmp_title='Outer Clsd Isbr Prs Bias (hPa)';
									tmp_ytitle='Bias (hPa)';
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='robias';
									tmp_title='Outer Clsd Isbr Rad Bias (km)';
									tmp_ytitle='Bias (km)';
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwbias';
									tmp_title='RMW Bias (km)';
									tmp_ytitle='Bias (km)';
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='atebias';
									tmp_title='Along-Track Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-500 500];                
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xtebias';
									tmp_title='Across-Track Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-500 500]; 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFbias';
									tmp_title='RTSF Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-100 100];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFbias';
									tmp_title='RSF Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-100 100];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFbias';
									tmp_title='RHF Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-100 100];
								end
								tmp_exp0=tmp_exp;                                                            
								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end
								plot(-10:89,zeros(1,100),'Color',[.5 .5 .5],'linewidth',2);                                                    
								set(gca,'plotboxaspectratio',[1 1 1])
								xlabel('Forecast Lead Time (h)','fontsize',20)
								ylabel(tmp_ytitle,'fontsize',20)
								set(gca,'fontsize',20)
								box on
								if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
									if mod(identmaxfhr*3,12)==0
										xlim([1 ((identmaxfhr*3))/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
									end
								else
									if mod(identmaxfhr*3-3,12)==0
										xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
									end
								end
								% YRANGE
								clear allquad
								allquad(1)=(max(max(nanmean((ne34err_exp(:,1:skip:end,:)),1))));
								allquad(2)=(max(max(nanmean((se34err_exp(:,1:skip:end,:)),1))));
								allquad(3)=(max(max(nanmean((nw34err_exp(:,1:skip:end,:)),1))));
								allquad(4)=(max(max(nanmean((sw34err_exp(:,1:skip:end,:)),1))));
								allquad(5)=(max(max(nanmean((ne50err_exp(:,1:skip:end,:)),1))));
								allquad(6)=(max(max(nanmean((se50err_exp(:,1:skip:end,:)),1))));
								allquad(7)=(max(max(nanmean((nw50err_exp(:,1:skip:end,:)),1))));
								allquad(8)=(max(max(nanmean((sw50err_exp(:,1:skip:end,:)),1))));
								allquad(9)=(max(max(nanmean((ne64err_exp(:,1:skip:end,:)),1))));
								allquad(10)=(max(max(nanmean((se64err_exp(:,1:skip:end,:)),1))));
								allquad(11)=(max(max(nanmean((nw64err_exp(:,1:skip:end,:)),1))));
								allquad(12)=(max(max(nanmean((sw64err_exp(:,1:skip:end,:)),1))));
								allquadmax=max(max(max(allquad)));
								allquadmin=min(min(min(allquad)));
								tmpvalq=max(abs(allquadmin),abs(allquadmax));
								if isnan(tmpvalq)==1
									tmpvalq=0;
								end
								if numel(num2str(tmpvalq))==3
									addfacq=100;
								elseif numel(num2str(tmpvalq))==2
									addfacq=20;
								else
									addfacq=20;
								end
								if numel(num2str(round(max(max(nanmean((tmp_exp0),1))))))==3
									addfac=100;
								elseif numel(num2str(round(max(max(nanmean((tmp_exp0),1))))))==2
									addfac=20;
								else
									addfac=20;
								end
								if plt<=3 || (plt>=16 && plt<=18) % -end-end
									tmpmin=min(min(nanmean((tmp_exp0),1)));
									tmpmax=max(max(nanmean((tmp_exp0),1)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
								elseif plt==19 || plt==20 % -end end 
									tmpmin=min(min(nanmean((tmp_exp0),1)));
									tmpmax=max(max(nanmean((tmp_exp0),1)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
								elseif (plt>=4 && plt<=15) || plt>=21%quad
									yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
								end
								ylim(yrange)
								set(gca,'xtick',1:skiptick:50)
								set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
								grid on
								set(gca,'gridcolor','k','gridalpha',.15)
								set(gca,'fontsize',20)      
								hold off
								box on
								set(gcf,'Units','inches');
								a1Pos = get(gca,'Position');
								set(gcf, 'InvertHardcopy', 'off')
								set(gcf,'Units','inches');
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');                         
								tmpuv = 0;                               
								tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
								if strat==1
								text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								else
								text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								end
								ax=gca;
								box on
								set(ax, 'Layer', 'bottom')
								ax.LineWidth=1; 
								set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
								set(gca,'Color',[.9 .9 .9])
								
									tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									set(tx, 'Layer', 'front')
								if plt==1 || plt>=4 && plt<=15 || plt==17 || plt==18 || plt>20
									 tx=text(0.02,0.05,'Too Small','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.02,0.98,'Too Large','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')  
								elseif plt==2 || plt==16
									 tx=text(0.02,0.05,'Too Low','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.02,0.98,'Too High','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')  
								elseif plt==3
									 tx=text(0.02,0.05,'Too Slow','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.02,0.98,'Too Fast','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front') 
								elseif plt==19
									 tx=text(0.02,0.05,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.02,0.98,'Faster than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')            
								elseif plt==20
									 tx=text(0.02,0.05,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.02,0.98,'Right of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')            
								end                                                    
								f = getframe(hfig);
								if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
								close all
							end
							% Create Graphics: trk, int, spd errors and Skill - bt-gh vs. bt-deny
							for med=1:2; for plt=[1:18,21:23]
								spPosA=[0.1886    0.6118    0.6328    0.7000/2.2];
								spPosB=[0.1886    0.2300    0.6328    0.7000/2.2];
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax2=subplot(5,4,[9:16]);
								ax1=subplot(5,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkerr';
									 tmp_title='Track Error (km)';
									 tmp_ytitle='Error (km)';
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prserr';
									tmp_title='Pressure Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spderr';
									tmp_title='Wind Speed Error (m/s)';
									tmp_ytitle='Error (m/s)';
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFerr';
									tmp_title='RTSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFerr';
									tmp_title='RTSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFerr';
									tmp_title='RTSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFerr';
									tmp_title='RTSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFerr';
									tmp_title='RSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFerr';
									tmp_title='RSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFerr';
									tmp_title='RSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFerr';
									tmp_title='RSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFerr';
									tmp_title='RHF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFerr';
									tmp_title='RHF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFerr';
									tmp_title='RHF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFerr';
									tmp_title='RHF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poerr';
									tmp_title='Outer Clsd Isbr Prs Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roerr';
									tmp_title='Outer Clsd Isbr Rad Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwerr';
									tmp_title='RMW Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='ateerr';
									tmp_title='Along-Track Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[-500 500];                
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xteerr';
									tmp_title='Across-Track Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[-500 500]; 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFerr';
									tmp_title='RTSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFerr';
									tmp_title='RSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFerr';
									tmp_title='RHF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								tmp_exp0=tmp_exp;

								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end
								plot(-10:89,zeros(1,100),'Color',[.5 .5 .5],'linewidth',2);												
								set(ax1,'position',spPosA)
								ylabel(tmp_ytitle,'fontsize',20)
								set(gca,'fontsize',20)
								box on
								if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
									if mod(identmaxfhr*3,12)==0
										xlim([1 ((identmaxfhr*3))/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
									end
								else
									if mod(identmaxfhr*3-3,12)==0
										xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
									end
								end
								 % YRANGE
								clear allquad
								allquad(1)=(max(max(nanmean(abs(ne34err_exp(:,1:skip:end,:)),1))));
								allquad(2)=(max(max(nanmean(abs(se34err_exp(:,1:skip:end,:)),1))));
								allquad(3)=(max(max(nanmean(abs(nw34err_exp(:,1:skip:end,:)),1))));
								allquad(4)=(max(max(nanmean(abs(sw34err_exp(:,1:skip:end,:)),1))));
								allquad(5)=(max(max(nanmean(abs(ne50err_exp(:,1:skip:end,:)),1))));
								allquad(6)=(max(max(nanmean(abs(se50err_exp(:,1:skip:end,:)),1))));
								allquad(7)=(max(max(nanmean(abs(nw50err_exp(:,1:skip:end,:)),1))));
								allquad(8)=(max(max(nanmean(abs(sw50err_exp(:,1:skip:end,:)),1))));
								allquad(9)=(max(max(nanmean(abs(ne64err_exp(:,1:skip:end,:)),1))));
								allquad(10)=(max(max(nanmean(abs(se64err_exp(:,1:skip:end,:)),1))));
								allquad(11)=(max(max(nanmean(abs(nw64err_exp(:,1:skip:end,:)),1))));
								allquad(12)=(max(max(nanmean(abs(sw64err_exp(:,1:skip:end,:)),1))));
								allquadmax=max(max(max(allquad)));
								allquadmin=min(min(min(allquad)));
								tmpvalq=max(abs(allquadmin),abs(allquadmax));
								if isnan(tmpvalq)==1
									tmpvalq=0;
								end
								if numel(num2str(tmpvalq))==3
									addfacq=100;
								elseif numel(num2str(tmpvalq))==2
									addfacq=20;
								else 
									addfacq=20;
								end
								if numel(num2str(round(max(max(nanmean((tmp_exp0),1))))))==3
									addfac=100;
								elseif numel(num2str(round(max(max(nanmean((tmp_exp0),1))))))==2
									addfac=20;
								else
									addfac=20;
								end
								if plt<=3 || (plt>=16 && plt<=18) % 0-end
									tmpmin=min(min(nanmean((tmp_exp0),1)));
									tmpmax=max(max(nanmean((tmp_exp0),1)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[0 round((tmpval+addfac)/10)*10];                
								elseif plt==19 || plt==20 % -end end 
									tmpmin=min(min(nanmean((tmp_exp0),1)));
									tmpmax=max(max(nanmean((tmp_exp0),1)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
								elseif (plt>=4 && plt<=15) || plt>=21%quad
									yrange=[0 round((tmpvalq+addfacq)/10)*10];
								end
								ylim(yrange)
								set(gca,'xtick',1:skiptick:50)
								set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
								set(gca,'xticklabel',[]) 
								grid on
								set(gca,'gridcolor','k','gridalpha',.15)
								set(gca,'fontsize',20)      
								hold off
								box on
								set(gcf,'Units','inches');
								a1Pos = get(gca,'Position');
								set(gcf, 'InvertHardcopy', 'off')
								set(gcf,'Units','inches');
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								if med==1;text(0,1.145,['\textbf{Mean ',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');elseif med==2;text(0,1.145,['\textbf{Median ',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');end;    
								text(1,1.07,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');                                                                  
								tmpuv = 0;                               
								tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];
								if strat==1
								text(0,1.07,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								else
								text(0,1.07,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								end
								box on
								set(ax1, 'Layer', 'bottom')
								ax1.LineWidth=1; 
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
								set(ax1,'Color',[.9 .9 .9])													
									tx=text(0.99,0.1,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									set(tx, 'Layer', 'front')
								if plt==19
									 tx=text(0.01,0.1,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.01,0.965,'Faster than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')            
								elseif plt==20
									 tx=text(0.01,0.1,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.01,0.965,'Right of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')            
								end
								ax2=subplot(5,4,[9:16]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkerrskill';
									 tmp_title='Track Skill (\%)';
									 tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									 yrange=[-20 20];
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prserrskill';
									tmp_title='Pressure Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spderrskill';
									tmp_title='Wind Speed Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFerrskill';
									tmp_title='RTSF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFerrskill';
									tmp_title='RTSF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFerrskill';
									tmp_title='RTSF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFerrskill';
									tmp_title='RTSF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFerrskill';
									tmp_title='RSF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFerrskill';
									tmp_title='RSF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFerrskill';
									tmp_title='RSF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFerrskill';
									tmp_title='RSF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFerrskill';
									tmp_title='RHF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFerrskill';
									tmp_title='RHF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFerrskill';
									tmp_title='RHF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFerrskill';
									tmp_title='RHF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poerrskill';
									tmp_title='Outer Clsd Isbr Prs Skill (hPa)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roerrskill';
									tmp_title='Outer Clsd Isbr Rad Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwerrskill';
									tmp_title='RMW Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='ateerrskill';
									tmp_title='Along-Track Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xteerrskill';
									tmp_title='Across-Track Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFerrskill';
									tmp_title='RTSF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFerrskill';
									tmp_title='RSF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFerrskill';
									tmp_title='RHF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								tmp_exp0=squeeze(100.*(1-nanmean(tmp_exp(:,:,:),1)./nanmean(tmp_exp(:,:,tmpimp),1)));                  
								% Strat
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end      													
								plot(-10:89,zeros(1,100),'Color',[.5 .5 .5],'linewidth',2);													
								xlabel('Forecast Lead Time (h)','fontsize',20)
								ylabel('Skill (%)','fontsize',20)
								set(gca,'fontsize',20)
								box on
								if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
									if mod(identmaxfhr*3,12)==0
										xlim([1 ((identmaxfhr*3))/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
									end
								else
									if mod(identmaxfhr*3-3,12)==0
										xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
									end
								end
								% YRANGE
								clear allquad imprv3
								imprv3(:,:,1)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,2)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,3)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,4)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,5)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,6)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,7)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,8)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,9)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,10)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,11)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,12)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
								allquadmax=max(max(max(imprv3)));
								allquadmin=min(min(min(imprv3)));
								tmpvalq=max(abs(allquadmin),abs(allquadmax));
								if isnan(tmpvalq)==1
									tmpvalq=0;
								end
								if numel(num2str(tmpvalq))==3
									addfacq=100;
								elseif numel(num2str(tmpvalq))==2
									addfacq=20;
								else
									addfacq=20;
								end

								if numel(num2str(round(max(tmp_exp0(:)))))==3
									addfac=100;
								elseif numel(num2str(round(max(tmp_exp0(:)))))==2
									addfac=20;
								else
									addfac=20;
								end
								if plt<=3 || (plt>=16 && plt<=18) % 0-end
									tmpmin=min(tmp_exp0(:));
									tmpmax=max(tmp_exp0(:));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									if tmpval>250
										yrange=[-250 250];
									else
										yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
									end
								elseif plt==19 || plt==20 % -end end 
									tmpmin=min(tmp_exp0(:));
									tmpmax=max(tmp_exp0(:));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									if tmpval>250
										yrange=[-250 250];
									else
										yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
									end
								elseif (plt>=4 && plt<=15) || plt>=21%quad 
									if tmpvalq>250
										yrange=[-250 250];
									else
										yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
									end
								end
								ylim(yrange)
								if yrange(end)>=200
									set(gca,'ytick',yrange(1):100:yrange(end))
								elseif yrange(end)>=100
									set(gca,'ytick',yrange(1):50:yrange(end))
								elseif yrange(end)>=50
									set(gca,'ytick',yrange(1):20:yrange(end))
								else
									set(gca,'ytick',yrange(1):10:yrange(end))
								end
								set(gca,'xtick',1:skiptick:50)
								set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
								grid on
								set(gca,'gridcolor','k','gridalpha',.15)
								set(gca,'fontsize',20)      
								hold off
								box on
								set(gcf,'Units','inches');
								a1Pos = get(gca,'Position');
								set(gcf, 'InvertHardcopy', 'off')
								set(gcf,'Units','inches');
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								box on
								set(ax2, 'Layer', 'bottom')
								ax2.LineWidth=1;
								set(ax2,'position',spPosB)
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
								set(ax2,'Color',[.9 .9 .9])            
								tx=text(0.99,0.1,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
								set(tx, 'Layer', 'front')																								
								f = getframe(hfig);
								if med==1;if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname,'_mean'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;elseif med==2; if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname,'_median'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;end;
								close all
							end; end;																				 
							
							spPos=[0.11 0.13+.05 0.75 0.75-.05]; % arrange plots the same
							% Create Graphics: trk, int, spd errors - bt-gh vs. bt-deny
							for plt=1:23
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax1=subplot(3,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkerr';
									 tmp_title='Track Error (km)';
									 tmp_ytitle='Error (km)';
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prserr';
									tmp_title='Pressure Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spderr';
									tmp_title='Wind Speed Error (m/s)';
									tmp_ytitle='Error (m/s)';
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFerr';
									tmp_title='RTSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFerr';
									tmp_title='RTSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFerr';
									tmp_title='RTSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFerr';
									tmp_title='RTSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFerr';
									tmp_title='RSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFerr';
									tmp_title='RSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFerr';
									tmp_title='RSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFerr';
									tmp_title='RSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFerr';
									tmp_title='RHF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFerr';
									tmp_title='RHF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFerr';
									tmp_title='RHF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFerr';
									tmp_title='RHF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poerr';
									tmp_title='Outer Clsd Isbr Prs Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roerr';
									tmp_title='Outer Clsd Isbr Rad Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwerr';
									tmp_title='RMW Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='trkbias1';
									tmp_title='Along-Track Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-500 500];                
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='trkbias2';
									tmp_title='Across-Track Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-500 500]; 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFerr';
									tmp_title='RTSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFerr';
									tmp_title='RSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFerr';
									tmp_title='RHF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								tmp_exp0=tmp_exp;                                                   
								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end
								plot(zeros(1,100),-10:89,'Color',[.5 .5 .5],'linewidth',2);                                                    
								set(gca,'plotboxaspectratio',[1 1 1])
								ylabel('Cycle Initialization Time','fontsize',20)
								xlabel(tmp_ytitle,'fontsize',20)
								set(gca,'fontsize',20)
								box on
								xstart=1;          
								ylim([xstart-.5 size(BT_lat,1)+.5])
								% YRANGE
								clear allquad
								allquad(1)=(max(max(nanmean(abs(ne34err_exp(:,1:skip:end,:)),2))));
								allquad(2)=(max(max(nanmean(abs(se34err_exp(:,1:skip:end,:)),2))));
								allquad(3)=(max(max(nanmean(abs(nw34err_exp(:,1:skip:end,:)),2))));
								allquad(4)=(max(max(nanmean(abs(sw34err_exp(:,1:skip:end,:)),2))));
								allquad(5)=(max(max(nanmean(abs(ne50err_exp(:,1:skip:end,:)),2))));
								allquad(6)=(max(max(nanmean(abs(se50err_exp(:,1:skip:end,:)),2))));
								allquad(7)=(max(max(nanmean(abs(nw50err_exp(:,1:skip:end,:)),2))));
								allquad(8)=(max(max(nanmean(abs(sw50err_exp(:,1:skip:end,:)),2))));
								allquad(9)=(max(max(nanmean(abs(ne64err_exp(:,1:skip:end,:)),2))));
								allquad(10)=(max(max(nanmean(abs(se64err_exp(:,1:skip:end,:)),2))));
								allquad(11)=(max(max(nanmean(abs(nw64err_exp(:,1:skip:end,:)),2))));
								allquad(12)=(max(max(nanmean(abs(sw64err_exp(:,1:skip:end,:)),2))));
								allquadmax=max(max(max(allquad)));
								allquadmin=min(min(min(allquad)));
								tmpvalq=max(abs(allquadmin),abs(allquadmax));
								if isnan(tmpvalq)==1
									tmpvalq=0;
								end
								if numel(num2str(tmpvalq))==3
									addfacq=100;
								elseif numel(num2str(tmpvalq))==2
									addfacq=20;
								else
									addfacq=20;
								end
								if numel(num2str(round(max(max(nanmean((tmp_exp0),2))))))==3
									addfac=100;
								elseif numel(num2str(round(max(max(nanmean((tmp_exp0),2))))))==2
									addfac=20;
								else
									addfac=20;
								end
								if plt<=3 || (plt>=16 && plt<=18) % 0-end
									tmpmin=min(min(nanmean((tmp_exp0),2)));
									tmpmax=max(max(nanmean((tmp_exp0),2)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
										if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[0 round((tmpval+addfac)/10)*10];                                
								elseif plt==19 || plt==20 % -end end 
									tmpmin=min(min(nanmean((tmp_exp0),2)));
									tmpmax=max(max(nanmean((tmp_exp0),2)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];                
								elseif (plt>=4 && plt<=15) || plt>=21%quad
									yrange=[0 round((tmpvalq+addfacq)/10)*10];
								end
								xlim(yrange)
								if size(identinittimesunique,1)>50
									set(gca,'ytick',1:4:100)
									set(gca,'yticklabel',identinittimesunique(1:4:end,:))
								else
									set(gca,'ytick',1:2:100)
									set(gca,'yticklabel',identinittimesunique(1:2:end,:))
								end  
								grid on
								set(gca,'gridcolor','k','gridalpha',.15)
								set(gca,'fontsize',20)      
								hold off
								box on
								set(gcf,'Units','inches');
								a1Pos = get(gca,'Position');
								set(gcf, 'InvertHardcopy', 'off')
								set(gcf,'Units','inches');
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')    
								text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');                
								tmpuv = 0;                               
								tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
								if strat==1
								text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								else
								text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								end
								ax=gca;
								box on
								set(ax, 'Layer', 'bottom')
								ax.LineWidth=1; 
								set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .85, 0.96]); % maximize figure window
								set(gca,'Color',[.9 .9 .9])
								clear cntexp                                                    
									tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									set(tx, 'Layer', 'front')
								if plt==19
									 tx=text(0.02,0.05,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.98,0.05,'Faster than BT','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
								elseif plt==20
									 tx=text(0.02,0.05,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.98,0.05,'Right of BT','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
								end
							   
								axis ij;f = getframe(hfig);
								if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname,'_cycles'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
								close all
							end   
							% Create Graphics: trk, int, spd Skill vs. deny
							for plt=[1:18,21:23]
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax1=subplot(3,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkskill';
									 tmp_title='Track Skill (\%)';
									 tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									 yrange=[-20 20];
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prskill';
									tmp_title='Pressure Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spdskill';
									tmp_title='Wind Speed Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFskill';
									tmp_title='RTSF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFskill';
									tmp_title='RTSF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFskill';
									tmp_title='RTSF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFskill';
									tmp_title='RTSF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFskill';
									tmp_title='RSF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFskill';
									tmp_title='RSF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFskill';
									tmp_title='RSF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFskill';
									tmp_title='RSF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFskill';
									tmp_title='RHF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFskill';
									tmp_title='RHF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFskill';
									tmp_title='RHF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFskill';
									tmp_title='RHF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poskill';
									tmp_title='Outer Clsd Isbr Prs Skill (hPa)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roskill';
									tmp_title='Outer Clsd Isbr Rad Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwskill';
									tmp_title='RMW Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='ateskill';
									tmp_title='Along-Track Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xteskill';
									tmp_title='Across-Track Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFskill';
									tmp_title='RTSF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFskill';
									tmp_title='RSF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFskill';
									tmp_title='RHF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								tmp_exp0=squeeze(100.*(1-nanmean(tmp_exp(:,:,:),2)./nanmean(tmp_exp(:,:,tmpimp),2)));                                                                    
								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end      
								
										set(gca,'plotboxaspectratio',[1 1 1])
										ylabel('Cycle Initialization Time','fontsize',20)
										xlabel(tmp_ytitle,'fontsize',20)
										set(gca,'fontsize',20)
										box on
										 % YRANGE
										clear allquad imprv3
										imprv3(:,:,1)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),2)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,2)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),2)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,3)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,4)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,5)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),2)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,6)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),2)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,7)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,8)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,9)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),2)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,10)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),2)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,11)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,12)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),2));
										allquadmax=max(max(max(imprv3)));
										allquadmin=min(min(min(imprv3)));
										tmpvalq=max(abs(allquadmin),abs(allquadmax));
										if isnan(tmpvalq)==1
											tmpvalq=0;
										end
										if numel(num2str(tmpvalq))==3
											addfacq=100;
										elseif numel(num2str(tmpvalq))==2
											addfacq=20;
										else
											addfacq=20;
										end
										if numel(num2str(round(max(max(nanmean((tmp_exp0),2))))))==3
											addfac=100;
										elseif numel(num2str(round(max(max(nanmean((tmp_exp0),2))))))==2
											addfac=20;
										else
											addfac=20;
										end
										if plt<=3 || (plt>=16 && plt<=18) % 0-end
											tmpmin=min(min(((tmp_exp0))));
											tmpmax=max(max(((tmp_exp0))));
											tmpval=max(abs(tmpmin),abs(tmpmax));
											if isnan(tmpval)==1
												tmpval=0;
											end
											if tmpval>250
												yrange=[-250 250];
											else
												yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
											end
										elseif plt==19 || plt==20 % -end end 
											tmpmin=min(min(((tmp_exp0))));
											tmpmax=max(max(((tmp_exp0))));
											tmpval=max(abs(tmpmin),abs(tmpmax));
											if isnan(tmpval)==1
												tmpval=0;
											end
											if tmpval>250
												yrange=[-250 250];
											else
												yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
											end               
										elseif (plt>=4 && plt<=15) || plt>=21%quad
											if tmpvalq>250
												yrange=[-250 250];
											else
												yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
											end
										end

										xlim(yrange)
										xstart=1;
										ylim([xstart-.5 size(BT_lat,1)+.5])   
										if size(identinittimesunique,1)>50
											set(gca,'ytick',1:4:100)
											set(gca,'yticklabel',identinittimesunique(1:4:end,:))
										else
											set(gca,'ytick',1:2:100)
											set(gca,'yticklabel',identinittimesunique(1:2:end,:))
										end                        
										grid on
										set(gca,'gridcolor','k','gridalpha',.15)
										set(gca,'fontsize',20)      
										hold off
										box on
										set(gcf,'Units','inches');
										a1Pos = get(gca,'Position');
										set(gcf, 'InvertHardcopy', 'off')
										set(gcf,'Units','inches');
										screenposition = get(gcf,'Position');
										set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
										set(gcf, 'InvertHardcopy', 'off')
										text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
										text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
										tmpuv = 0;                               
										tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
										if strat==1
										text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
										else
										text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
										end
										ax=gca;
										box on
										set(ax, 'Layer', 'bottom')
										ax.LineWidth=1; 
										set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
										set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .85, 0.96]); % maximize figure window
										set(gca,'Color',[.9 .9 .9])
										clear cntexp                                                            
										tx=text(0.02,0.98,'Not Enough Data','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
										set(tx, 'Layer', 'front')                                                                                                                                
										axis ij;f = getframe(hfig);
										if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname,'_cycles'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
										close all
							end
							% Create Graphics: trk, int, spd FSP vs. deny
							for plt=[1:18,21:23]
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax1=subplot(3,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkfsp';
									 tmp_title='Track FSP (\%)';
									 tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									 yrange=[-20 20];
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prsfsp';
									tmp_title='Pressure FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spdfsp';
									tmp_title='Wind Speed FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFfsp';
									tmp_title='RTSF NEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFfsp';
									tmp_title='RTSF SEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFfsp';
									tmp_title='RTSF SWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFfsp';
									tmp_title='RTSF NWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFfsp';
									tmp_title='RSF NEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFfsp';
									tmp_title='RSF SEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFfsp';
									tmp_title='RSF SWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFfsp';
									tmp_title='RSF NWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFfsp';
									tmp_title='RHF NEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFfsp';
									tmp_title='RHF SEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFfsp';
									tmp_title='RHF SWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFfsp';
									tmp_title='RHF NWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='pofsp';
									tmp_title='Outer Clsd Isbr Prs FSP (hPa)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='rofsp';
									tmp_title='Outer Clsd Isbr Rad FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwfsp';
									tmp_title='RMW FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='atefsp';
									tmp_title='Along-Track FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xtefsp';
									tmp_title='Across-Track FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFfsp';
									tmp_title='RTSF FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFfsp';
									tmp_title='RSF FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFfsp';
									tmp_title='RHF FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								tmp_exp0=squeeze(100.*(1-nanmean(tmp_exp(:,:,:),2)./nanmean(tmp_exp(:,:,tmpimp),2)));                  
								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end      
								tmpu=1:size(identexp,1);
										tmpu(tmpu==tmpimp)=[];
										plot(50*ones(1,100),-10:89,'Color',[.5 .5 .5],'linewidth',2);                                                            
										set(gca,'plotboxaspectratio',[1 1 1])
										ylabel('Cycle Initialization Time','fontsize',20)
										xlabel(tmp_ytitle,'fontsize',20)
										set(gca,'fontsize',20)
										box on
										xlim([0 100])
										xstart=1;
										ylim([xstart-.5 size(BT_lat,1)+.5])   
										if size(identinittimesunique,1)>50
											set(gca,'ytick',1:4:100)
											set(gca,'yticklabel',identinittimesunique(1:4:end,:))
										else
											set(gca,'ytick',1:2:100)
											set(gca,'yticklabel',identinittimesunique(1:2:end,:))
										end                        
										grid on
										set(gca,'gridcolor','k','gridalpha',.15)
										set(gca,'fontsize',20)      
										hold off
										box on
										set(gcf,'Units','inches');
										a1Pos = get(gca,'Position');
										set(gcf, 'InvertHardcopy', 'off')
										set(gcf,'Units','inches');
										screenposition = get(gcf,'Position');
										set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
										set(gcf, 'InvertHardcopy', 'off')
										text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
										text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
										tmpuv = size(tmpnm,1);                               
										tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
										if strat==1
										text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
										else
										text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
										end
										ax=gca;
										box on
										set(ax, 'Layer', 'bottom')
										ax.LineWidth=1; 
										set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
										set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .85, 0.96]); % maximize figure window
										set(gca,'Color',[.9 .9 .9])
										clear cntexp
										
										tx=text(0.02,0.98,'Not Enough Data','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
										set(tx, 'Layer', 'front')                                                                                                                                  
										axis ij;f = getframe(hfig);
										if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname,'_cycles'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
										close all
							end                                    
							% Create Graphics: trk, int, spd bias - bt-gh vs. bt-deny
							for plt=[2:18,21:23] % no across or along for bias since already in error
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax1=subplot(3,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkbias';
									 tmp_title='Track Bias (km)';
									 tmp_ytitle='Bias (km)';
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prsbias';
									tmp_title='Pressure Bias (hPa)';
									tmp_ytitle='Bias (hPa)';
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spdbias';
									tmp_title='Wind Speed Bias (m/s)';
									tmp_ytitle='Bias (m/s)';
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFbias';
									tmp_title='RTSF NEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFbias';
									tmp_title='RTSF SEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFbias';
									tmp_title='RTSF SWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFbias';
									tmp_title='RTSF NWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFbias';
									tmp_title='RSF NEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFbias';
									tmp_title='RSF SEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFbias';
									tmp_title='RSF SWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFbias';
									tmp_title='RSF NWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFbias';
									tmp_title='RHF NEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFbias';
									tmp_title='RHF SEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFbias';
									tmp_title='RHF SWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFbias';
									tmp_title='RHF NWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='pobias';
									tmp_title='Outer Clsd Isbr Prs Bias (hPa)';
									tmp_ytitle='Bias (hPa)';
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='robias';
									tmp_title='Outer Clsd Isbr Rad Bias (km)';
									tmp_ytitle='Bias (km)';
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwbias';
									tmp_title='RMW Bias (km)';
									tmp_ytitle='Bias (km)';
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='atebias';
									tmp_title='Along-Track Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-500 500];                
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xtebias';
									tmp_title='Across-Track Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-500 500]; 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFbias';
									tmp_title='RTSF Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-100 100];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFbias';
									tmp_title='RSF Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-100 100];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFbias';
									tmp_title='RHF Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-100 100];
								end
								tmp_exp0=tmp_exp;
								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end       
								plot(zeros(1,100),-10:89,'Color',[.5 .5 .5],'linewidth',2);                                                    
								set(gca,'plotboxaspectratio',[1 1 1])
								ylabel('Cycle Initialization Time','fontsize',20)
								xlabel(tmp_ytitle,'fontsize',20)
								set(gca,'fontsize',20)
								box on
								xstart=1;         
								ylim([xstart-.5 size(BT_lat,1)+.5])
								% YRANGE
								clear allquad
								allquad(1)=(max(max(nanmean((ne34err_exp(:,1:skip:end,:)),2))));
								allquad(2)=(max(max(nanmean((se34err_exp(:,1:skip:end,:)),2))));
								allquad(3)=(max(max(nanmean((nw34err_exp(:,1:skip:end,:)),2))));
								allquad(4)=(max(max(nanmean((sw34err_exp(:,1:skip:end,:)),2))));
								allquad(5)=(max(max(nanmean((ne50err_exp(:,1:skip:end,:)),2))));
								allquad(6)=(max(max(nanmean((se50err_exp(:,1:skip:end,:)),2))));
								allquad(7)=(max(max(nanmean((nw50err_exp(:,1:skip:end,:)),2))));
								allquad(8)=(max(max(nanmean((sw50err_exp(:,1:skip:end,:)),2))));
								allquad(9)=(max(max(nanmean((ne64err_exp(:,1:skip:end,:)),2))));
								allquad(10)=(max(max(nanmean((se64err_exp(:,1:skip:end,:)),2))));
								allquad(11)=(max(max(nanmean((nw64err_exp(:,1:skip:end,:)),2))));
								allquad(12)=(max(max(nanmean((sw64err_exp(:,1:skip:end,:)),2))));
								allquadmax=max(max(max(allquad)));
								allquadmin=min(min(min(allquad)));
								tmpvalq=max(abs(allquadmin),abs(allquadmax));
								if isnan(tmpvalq)==1
									tmpvalq=0;
								end
								if numel(num2str(tmpvalq))==3
									addfacq=100;
								elseif numel(num2str(tmpvalq))==2
									addfacq=20;
								else
									addfacq=20;
								end
								if numel(num2str(round(max(max(nanmean((tmp_exp0),2))))))==3
									addfac=100;
								elseif numel(num2str(round(max(max(nanmean((tmp_exp0),2))))))==2
									addfac=20;
								else
									addfac=20;
								end
								if plt<=3 || (plt>=16 && plt<=18) % 0-end
									tmpmin=min(min(nanmean((tmp_exp0),2)));
									tmpmax=max(max(nanmean((tmp_exp0),2)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];                                
								elseif plt==19 || plt==20 % -end end 
									tmpmin=min(min(nanmean((tmp_exp0),2)));
									tmpmax=max(max(nanmean((tmp_exp0),2)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];                
								elseif (plt>=4 && plt<=15) || plt>=21%quad
									yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
								end
								xlim(yrange)
								if size(identinittimesunique,1)>50
									set(gca,'ytick',1:4:100)
									set(gca,'yticklabel',identinittimesunique(1:4:end,:))
								else
									set(gca,'ytick',1:2:100)
									set(gca,'yticklabel',identinittimesunique(1:2:end,:))
								end  
								grid on
								set(gca,'gridcolor','k','gridalpha',.15)
								set(gca,'fontsize',20)      
								hold off
								box on
								set(gcf,'Units','inches');
								a1Pos = get(gca,'Position');
								set(gcf, 'InvertHardcopy', 'off')
								set(gcf,'Units','inches');
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');                         
								tmpuv = 0;                               
								tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
								if strat==1
								text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								else
								text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								end
								ax=gca;
								box on
								set(ax, 'Layer', 'bottom')
								ax.LineWidth=1; 
								set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .85, 0.96]); % maximize figure window
								set(gca,'Color',[.9 .9 .9])
								clear cntexp                                                            
								tx=text(0.02,0.98,'Not Enough Data','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
								set(tx, 'Layer', 'front')
								if plt==1 || plt>=4 && plt<=15 || plt==17 || plt==18 || plt>20
									 tx=text(0.02,0.05,'Too Small','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.98,0.05,'Too Large','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')  
								elseif plt==2 || plt==16
									 tx=text(0.02,0.05,'Too Low','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.98,0.05,'Too High','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')  
								elseif plt==3
									 tx=text(0.02,0.05,'Too Slow','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.98,0.05,'Too Fast','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front') 
								elseif plt==19
									 tx=text(0.02,0.05,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.98,0.05,'Faster than BT','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')            
								elseif plt==20
									 tx=text(0.02,0.05,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.98,0.05,'Right of BT','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')            
								end                                                               
								axis ij;f = getframe(hfig);
								if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname,'_cycles'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
								close all
							end                                      
							% Create Graphics: Cycle-By-Cycle Skill!!!
							for plt=[1:18,21:23] % no across or along for bias
								clear l cntexp
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkerr';
									 tmp_title='Cycle-By-Cycle Track Skill (\%)';
									 tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prserr';
									tmp_title='Cycle-By-Cycle Pressure Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spderr';
									tmp_title='Cycle-By-Cycle Wind Speed Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFerr';
									tmp_title='Cycle-By-Cycle RTSF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFerr';
									tmp_title='Cycle-By-Cycle RTSF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFerr';
									tmp_title='Cycle-By-Cycle RTSF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFerr';
									tmp_title='Cycle-By-Cycle RTSF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFerr';
									tmp_title='Cycle-By-Cycle RSF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFerr';
									tmp_title='Cycle-By-Cycle RSF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFerr';
									tmp_title='Cycle-By-Cycle RSF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFerr';
									tmp_title='Cycle-By-Cycle RSF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFerr';
									tmp_title='Cycle-By-Cycle RHF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFerr';
									tmp_title='Cycle-By-Cycle RHF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFerr';
									tmp_title='Cycle-By-Cycle RHF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFerr';
									tmp_title='Cycle-By-Cycle RHF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poerr';
									tmp_title='Cycle-By-Cycle Outer Clsd Isbr Prs Skill (hPa)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roerr';
									tmp_title='Cycle-By-Cycle Outer Clsd Isbr Rad Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwerr';
									tmp_title='Cycle-By-Cycle RMW Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='ateerr';
									tmp_title='Cycle-By-Cycle Along-Track Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xteerr';
									tmp_title='Cycle-By-Cycle Across-Track Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==21
									tmp_exp1=cat(4,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_exp=nansum(tmp_exp1,4);
									tmp_exp(all(isnan(tmp_exp1),4))=NaN;
									tmp_name='RTSFerr';
									tmp_title='Cycle-By-Cycle RTSF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==22
									tmp_exp1=cat(4,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_exp=nansum(tmp_exp1,4);
									tmp_exp(all(isnan(tmp_exp1),4))=NaN;
									tmp_name='RSFerr';
									tmp_title='Cycle-By-Cycle RSF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==23
									tmp_exp1=cat(4,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_exp=nansum(tmp_exp1,4);
									tmp_exp(all(isnan(tmp_exp1),4))=NaN;
									tmp_name='RHFerr';
									tmp_title='Cycle-By-Cycle RHF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								tmp_exp0=tmp_exp;for tmp=1:size(identexp,1); if strcmp(identexp(tmp),identexpsigimp); tmpimp=tmp; end; end;   tmpu=1:size(identexp,1);tmpu(tmpu==tmpimp)=[];                                              
								for identexploop=tmpu
									set(0,'defaultfigurecolor',[1 1 1]) % figure background color
									hfig=figure;
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
									ax1=subplot(3,4,[1:8]);
									xlabel('Forecast Lead Time (h)','fontsize',14)        
									set(gca,'fontsize',14)
									box on
									if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
										if mod(identmaxfhr*3,12)==0
											xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]) 
										end
									else
										if mod(identmaxfhr*3-3,12)==0
											xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]) 
										end
									end    
									set(gca,'xtick',1:skiptick:50)
									set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
									set(gca,'fontsize',14)
									hold on         
									ylabel('','fontsize',14) 
									set(gca,'yticklabel',[]);														
									box on														               
									set(gca,'fontsize',14)
									cnt=1;                                       
									colorbar
									caxis([-50 50])
									colormap(gca,custommap(20,negposc))
									hold on
									for i=1:identmaxfhr
										plot(repmat(i-.5,1,identmaxfhr+3),-1:identmaxfhr+1,'k')
									end
									ylim([0 1])
									set(gcf, 'InvertHardcopy', 'off')
									set(gcf,'Units','inches');
									screenposition = get(gcf,'Position');
									set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
									set(gcf, 'InvertHardcopy', 'off')														
									set(gca,'TickLength',[0 0])										
									text(1,1.052,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
									text(1,1.025,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');                
									text(0,1.052,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')                                        
									tmpphrase=[num2str(0),'/',num2str(size(identinittimesunique,1))];                    
									if strat==1
										text(0,1.025,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									else
										text(0,1.025,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									end			
									tx=text(0.99,0.04,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');														
									ax=gca;
									box on
									set(ax, 'Layer', 'top')
									ax.LineWidth=1; 
									pos=get(gca,'Position');
									set(gca,'position',[pos(1)+.01 pos(2)-.33 pos(3) pos(4)+.34])
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .9, 0.96]); % maximize figure window
									f = getframe(hfig);
									if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_contr_',stname,'_',identexpshort{identexploop}];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
									close all   
								end 														
							end  																							
							% Create PPC Graphics
							for plt=[1:18,21:23] % no across or along for bias
								clear l cntexp                                   
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkerr';
									 tmp_title='Percentage Point Contribution to Track Skill (\%)';
									 tmp_ytitle='Error Contribution (\%)';
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prserr';
									tmp_title='Percentage Point Contribution to Pressure Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spderr';
									tmp_title='Percentage Point Contribution to Wind Speed Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFerr';
									tmp_title='Percentage Point Contribution to RTSF NEQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFerr';
									tmp_title='Percentage Point Contribution to RTSF SEQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFerr';
									tmp_title='Percentage Point Contribution to RTSF SWQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFerr';
									tmp_title='Percentage Point Contribution to RTSF NWQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFerr';
									tmp_title='Percentage Point Contribution to RSF NEQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFerr';
									tmp_title='Percentage Point Contribution to RSF SEQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFerr';
									tmp_title='Percentage Point Contribution to RSF SWQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFerr';
									tmp_title='Percentage Point Contribution to RSF NWQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFerr';
									tmp_title='Percentage Point Contribution to RHF NEQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFerr';
									tmp_title='Percentage Point Contribution to RHF SEQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFerr';
									tmp_title='Percentage Point Contribution to RHF SWQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
									yrange=[-100 100];                 
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFerr';
									tmp_title='Percentage Point Contribution to RHF NWQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poerr';
									tmp_title='Percentage Point Contribution to Outer Clsd Isbr Prs Skill (hPa)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roerr';
									tmp_title='Percentage Point Contribution to Outer Clsd Isbr Rad Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwerr';
									tmp_title='Percentage Point Contribution to RMW Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='ateerr';
									tmp_title='Percentage Point Contribution to Along-Track Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xteerr';
									tmp_title='Percentage Point Contribution to Across-Track Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==21
									tmp_exp=cat(4,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_exp1=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFerr';
									tmp_title='Percentage Point Contribution to RTSF Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==22
									tmp_exp=cat(4,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_exp1=cat(4,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFerr';
									tmp_title='Percentage Point Contribution to RSF Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==23
									tmp_exp=cat(4,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_exp1=cat(4,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFerr';
									tmp_title='Percentage Point Contribution to RHF Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								 % Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end 
								tmpu=1:size(identexp,1);
								tmpu(tmpu==tmpimp)=[];
								if plt>=21
									tmp_exp1=abs(tmp_exp1); % added for MAE
									tmp_exp0=squeeze(100.*(1-nanmean(tmp_exp1(:,:,:),1)./nanmean(tmp_exp1(:,:,tmpimp),1)));                  
								else
									tmp_exp0=squeeze(100.*(1-nanmean(tmp_exp(:,:,:),1)./nanmean(tmp_exp(:,:,tmpimp),1)));                  
								end
								

								
								
								for identexploop=tmpu
									set(0,'defaultfigurecolor',[1 1 1]) % figure background color
									hfig=figure;
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
									ax1=subplot(3,4,[1:8]);
									xlabel('Forecast Lead Time (h)','fontsize',14)        
									set(gca,'fontsize',14)
									box on
									if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
										if mod(identmaxfhr*3,12)==0
											xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]) 
										end
									else
										if mod(identmaxfhr*3-3,12)==0
											xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]) 
										end
									end    
									set(gca,'xtick',1:skiptick:50)
									set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
									set(gca,'fontsize',14)
									hold on                        
									ylabel('','fontsize',14)
									set(gca,'fontsize',14)
									box on
									set(gca,'yticklabel',[]);																									
									set(gca,'fontsize',14)
									cnt=1;                       
									colorbar
									caxis([-5 5])
									run customcolorbars
									cl=colorbar;
									colormap(gca,custommap(20,negposc))														
									hold on
									for i=1:identmaxfhr
										plot(repmat(i-.5,1,identmaxfhr+3),-1:identmaxfhr+1,'k')
									end
									ylim([0 1])
									set(gcf, 'InvertHardcopy', 'off')
									set(gcf,'Units','inches');
									screenposition = get(gcf,'Position');
									set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
									set(gcf, 'InvertHardcopy', 'off')														
									set(gca,'TickLength',[0 0])
									tmpphrase=[num2str(0),'/',num2str(size(identinittimesunique,1))];                    
									text(1,1.06,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
									if strat==1
										text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									else
										text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									end
									text(0,1.06,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')                                                                                
									text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									ax=gca;
									box on
									set(ax, 'Layer', 'top')
									ax.LineWidth=1; 
									pos=get(gca,'Position');
									set(gca,'position',[pos(1)+.01 pos(2) pos(3) pos(4)])
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .9, 0.96]); % maximize figure window
									tx=text(0.99,0.045,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');														
									
									ax2=subplot(3,4,[9:12]);														
									%xlabel('Forecast Lead Time (h)','fontsize',14)        
									set(gca,'fontsize',14)
									box on
									if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
										if mod(identmaxfhr*3,12)==0
											xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]) 
										end
									else
										if mod(identmaxfhr*3-3,12)==0
											xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]) 
										end
									end    
									set(gca,'xtick',[])
									set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
									set(gca,'fontsize',14)
									hold on                        
									ylabel('','fontsize',14)                                   
									set(gca,'fontsize',14)
									set(gca,'ytick',[])
									cnt=1;
									set(gca,'yticklabel',[]);
									colorbar
									% YRANGE
									clear allquad imprv3
									imprv3(:,:,1)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,2)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,3)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,4)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,5)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,6)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,7)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,8)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,9)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,10)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,11)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,12)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
									allquadmax=max(max(max(imprv3)));
									allquadmin=min(min(min(imprv3)));
									tmpvalq=max(abs(allquadmin),abs(allquadmax));
									if isnan(tmpvalq)==1
										tmpvalq=0;
									end
									if numel(num2str(tmpvalq))==3
										addfacq=100;
									elseif numel(num2str(tmpvalq))==2
										addfacq=20;
									else
										addfacq=20;
									end

									if numel(num2str(round(max(tmp_exp0(:)))))==3
										addfac=100;
									elseif numel(num2str(round(max(tmp_exp0(:)))))==2
										addfac=20;
									else
										addfac=20;
									end
									if plt<=3 || (plt>=16 && plt<=18) % 0-end
										tmpmin=min(tmp_exp0(:));
										tmpmax=max(tmp_exp0(:));
										tmpval=max(abs(tmpmin),abs(tmpmax));
										if isnan(tmpval)==1
											tmpval=0;
										end
										if tmpval>250
											yrange=[-250 250];
										else
											yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
										end
									elseif plt==19 || plt==20 % -end end 
										tmpmin=min(tmp_exp0(:));
										tmpmax=max(tmp_exp0(:));
										tmpval=max(abs(tmpmin),abs(tmpmax));
										if isnan(tmpval)==1
											tmpval=0;
										end
										if tmpval>250
											yrange=[-250 250];
										else
											yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
										end
									elseif (plt>=4 && plt<=15) || plt>=21%quad 
										if tmpvalq>250
											yrange=[-250 250];
										else
											yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
										end
									end
									caxis(yrange)
									run customcolorbars
									cl=colorbar;
									colormap(gca,custommap(20,negposc))		
									set(cl,'ticks',yrange(:),'fontsize',14)																								
									hold on
									for i=1:identmaxfhr
										plot(repmat(i-.5,1,identmaxfhr+3),-1:identmaxfhr+1,'k')
									end
									ylim([0 1])
									set(gcf, 'InvertHardcopy', 'off')
									set(gcf,'Units','inches');
									screenposition = get(gcf,'Position');
									set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
									set(gcf, 'InvertHardcopy', 'off')													
									set(gca,'TickLength',[0 0])
									ax=gca;
									box on
									set(ax, 'Layer', 'top')
									ax.LineWidth=1;                                         
									pos=get(ax1,'Position');
									set(ax1,'position',[pos(1) pos(2)-.2 pos(3) pos(4)+.2])
									set(ax2,'position',[pos(1) pos(2)-.31 pos(3) pos(4)-.48])
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .9, 0.96]); % maximize figure window
									f = getframe(hfig);
									if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_PPC_',stname,'_',identexpshort{identexploop}];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
									%print([identtrackint,'/trackcomp_fhr_',num2str((fhr-1)*3),'h'],'-dpdf','-r200');
									close all   
								end 
							end                             
							% Create Graphics: lagged corr
							%if identlagcorr==1
							for plt=[1:18,21:23]                                                  
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkerr';
									 tmp_title='Track Error (km)';
									 tmp_ytitle='Error (km)';
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prserr';
									tmp_title='Pressure Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spderr';
									tmp_title='Wind Speed Error (m/s)';
									tmp_ytitle='Error (m/s)';
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFerr';
									tmp_title='RTSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFerr';
									tmp_title='RTSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFerr';
									tmp_title='RTSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFerr';
									tmp_title='RTSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFerr';
									tmp_title='RSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFerr';
									tmp_title='RSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFerr';
									tmp_title='RSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFerr';
									tmp_title='RSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFerr';
									tmp_title='RHF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFerr';
									tmp_title='RHF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFerr';
									tmp_title='RHF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFerr';
									tmp_title='RHF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poerr';
									tmp_title='Outer Clsd Isbr Prs Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roerr';
									tmp_title='Outer Clsd Isbr Rad Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwerr';
									tmp_title='RMW Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='ateerr';
									tmp_title='Along-Track Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[-500 500];                
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xteerr';
									tmp_title='Across-Track Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[-500 500]; 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFerr';
									tmp_title='RTSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFerr';
									tmp_title='RSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFerr';
									tmp_title='RHF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								end
								onefhr0=tmp_exp;
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkerr';
									 tmp_title='Track Error (km)';
									 tmp_ytitle='Error (km)';
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prserr';
									tmp_title='Pressure Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spderr';
									tmp_title='Wind Speed Error (m/s)';
									tmp_ytitle='Error (m/s)';
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFerr';
									tmp_title='RTSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFerr';
									tmp_title='RTSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFerr';
									tmp_title='RTSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFerr';
									tmp_title='RTSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFerr';
									tmp_title='RSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFerr';
									tmp_title='RSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFerr';
									tmp_title='RSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFerr';
									tmp_title='RSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFerr';
									tmp_title='RHF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFerr';
									tmp_title='RHF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFerr';
									tmp_title='RHF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFerr';
									tmp_title='RHF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poerr';
									tmp_title='Outer Clsd Isbr Prs Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roerr';
									tmp_title='Outer Clsd Isbr Rad Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwerr';
									tmp_title='RMW Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='ateerr';
									tmp_title='Along-Track Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[-500 500];                
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xteerr';
									tmp_title='Across-Track Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[-500 500]; 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFerr';
									tmp_title='RTSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFerr';
									tmp_title='RSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFerr';
									tmp_title='RHF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								end
								onefhr=tmp_exp;													
							 % Lagged Correlation
								for identexploop=1:size(tmp_exp,3)	
									clear l cntexp
									set(0,'defaultfigurecolor',[1 1 1]) % figure background color
									hfig=figure;
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
									ax1=subplot(3,4,[1:8]);
									hold on													
									cc=[];																												
									set(gca,'plotboxaspectratio',[1 1 1])
									ylabel('Lag (6-h Cycles)','fontsize',20)
									set(gca,'ytick',1:11)
									set(gca,'yticklabel',10:-1:0)
									xlabel('Forecast Lead Time (h)','fontsize',20)
									set(gca,'fontsize',20)
									box on
									if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
										if mod(identmaxfhr*3,12)==0
											xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]) 
										end
									else
										if mod(identmaxfhr*3-3,12)==0
											xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]) 
										end
									end         
									set(gca,'xtick',1:skiptick:50)
									set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
									set(gca,'gridcolor','k','gridalpha',.15)
									set(gca,'fontsize',20)      
									hold off
									box on														
									hold on
									for i=1:identmaxfhr
										plot(repmat(i-.5,1,identmaxfhr+3),-1:identmaxfhr+1,'k')
									end	
									for i=1:identmaxfhr
										plot(-1:identmaxfhr+1,repmat(i-.5,1,identmaxfhr+3),'k')
									end	
									ylim([0.5 11.5])
									run customcolorbars
									cl=colorbar;
									caxis([-1 1])														
									colormap(gca,custommap(20,negposc))														
									set(cl,'ticks',[-1:.2:1],'fontsize',14)														
									[row,col]=find(abs(cc)>=sqrt(.25) & abs(cc)<sqrt(.50)); % 25-50% variance
									hold on
									if isempty(row)
									else
										plot(col,row,'.k','markerfacecolor','k');
									end
									[row,col]=find(abs(cc)>=sqrt(.50) & abs(cc)<sqrt(.75)); % 50-75% variance
									hold on
									if isempty(row)
									else
										plot(col,row,'+k','markerfacecolor','k');
									end
									[row,col]=find(abs(cc)>=sqrt(.75)); % 50-75% variance
									hold on
									if isempty(row)
									else
										plot(col,row,'sk','markerfacecolor','k');														
									end
									l(1)=plot(-100,-100,'.k','markerfacecolor','k');
									l(2)=plot(-100,-100,'+k','markerfacecolor','k');
									l(3)=plot(-100,-100,'sk','markerfacecolor','k');
									lh=legend(l,'r^2=25-50%','r^2=50-75%','r^2=75-100%','location','southeastoutside','orientation','vertical');	
									lh.FontSize=10;
									lh.ItemTokenSize(1) = 10;
									lhp=lh.Position;
									set(lh,'position',[lhp(1)+.2 lhp(2)-.28 lhp(3) lhp(4)])
									set(gcf,'Units','inches');
									a1Pos = get(gca,'Position');
									set(gcf, 'InvertHardcopy', 'off')
									set(gcf,'Units','inches');
									screenposition = get(gcf,'Position');
									set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
									set(gcf, 'InvertHardcopy', 'off')
									text(0,1.065,['\textbf{',tmp_title,' Lagged Correlation}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')    
									text(1,1.065,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
									text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
									tmpphrase=[num2str(0),'/',num2str(size(identinittimesunique,1))];
									if strat==1
									text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									else
									text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									end
									ax=gca;
									box on
									set(ax, 'Layer', 'bottom')
									ax.LineWidth=2; 
									set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
									set(gca,'Color',[.9 .9 .9])
									
										tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
										set(tx, 'Layer', 'front')
									if plt==19
										 tx=text(0.02,0.05,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
										 tx=text(0.02,0.98,'Faster than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
										 set(tx, 'Layer', 'front')            
									elseif plt==20
										 tx=text(0.02,0.05,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
										 tx=text(0.02,0.98,'Right of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
										 set(tx, 'Layer', 'front')            
									end
									axis ij														
									f = getframe(hfig);
									if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname,'_LAGCORR','_',identexpshort{identexploop}];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
									close all													
								end
							end   																																		
%							end
							fid=fopen([identtrackint,'/',identn,'_scfactor.txt'],'w');fprintf(fid,'%s\n', 'No Data!');fclose(fid);
							% Scorecard										
							for scorecard=1
								% Which Experiment to Compare To
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end      
								tmpu=1:size(identexp,1);
								tmpu(tmpu==tmpimp)=[];

								for identexploop=tmpu % loop over experiments                

									%% CONSISTENCY SCORECARD		
									% Specify y labels
									tmp_ytitle={'TRACK','WIND SPEED','PRESSURE','RTSF','RSF','RHF'}';
									sconsistent=nan(6,(identmaxfhr+1)/2);
									
									% Start Figure
									clear l cntexp;set(0,'defaultfigurecolor',[1 1 1]);hfig=figure;set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);hold on;

									% Plot Matrix & Flip
									imagesc(sconsistent,'AlphaData',~isnan((sconsistent)));axis ij;

									% X- and Y- Axes: Ticks, Labels, Ranges
									xlabel('Forecast Lead Time (h)','fontsize',20);set(gca,'fontsize',14);box on;if mod(identmaxfhr*3,skiphr)==0;if mod(identmaxfhr*3,12)==0;xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5]);else;xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]);end;else;if mod(identmaxfhr*3-3,12)==0;xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5]);else;xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]);end;end;
									set(gca,'xtick',1:skiptick:50);set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24);set(gca,'fontsize',16);ylim([0.5 size(sconsistent,1)+.5]);set(gca,'ytick',1:1:size(sconsistent,1)+.5);set(gca,'yticklabel',tmp_ytitle);set(gca,'TickLength',[0 0])

									% Colormap
									colorbar;caxis([-2.5 2.5]);
									run customcolorbars;
									cl=colorbar;
									cl.Ticks=[-2:1:2];
									colormap(gca,flipud([56 87 35;169 209 142;229.5 229.5 229.5;244 177 131;132 60 12]/255))

									% Create Gridlines
									for i=1:size(sconsistent,2);plot(repmat(0.5+i,1,size(sconsistent,1)+3),-1:size(sconsistent,1)+1,'k');end;plot(-1:size(sconsistent,2)+1,repmat(1.5,size(sconsistent,2)+3,1),'k','linewidth',2);plot(-1:size(sconsistent,2)+1,repmat(2.5,size(sconsistent,2)+3,1),'k','linewidth',2);plot(-1:size(sconsistent,2)+1,repmat(3.5,size(sconsistent,2)+3,1),'k','linewidth',2);plot(-1:size(sconsistent,2)+1,repmat(4.5,size(sconsistent,2)+3,1),'k','linewidth',2);plot(-1:size(sconsistent,2)+1,repmat(5.5,size(sconsistent,2)+3,1),'k','linewidth',2);plot(-1:size(sconsistent,2)+1,repmat(6.5,size(sconsistent,2)+3,1),'k','linewidth',2);

									% Title Text
									text(0,1.11,['\textbf{Consistency Scorecard}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');
									text(1,1.11,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
									text(1,1.06,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
									tmpuv = size(tmpnm,1);
									tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];
									if strat==1
										text(0,1.06,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');
									else
										text(0,1.06,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');
									end
									tx=text(0.99,0.09,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									set(tx, 'Layer', 'front')
									% Figure Sizing & Printing
									set(gcf, 'InvertHardcopy', 'off');ax=gca;box on;set(ax, 'Layer', 'top');ax.LineWidth=2;set(gca,'position',[spPos(1)+.04 spPos(2) spPos(3) spPos(4)]);
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, .5, .2]);set(gca,'Color',[.9 .9 .9]);set(gcf,'Units','inches');screenposition = get(gcf,'Position');set(gcf,'PaperPosition',[0 0 screenposition(3)+3 screenposition(4)+3],'PaperSize',[screenposition(3)+3 screenposition(4)+3]);consPos=get(cl,'position');set(cl,'position',[consPos(1)+.005 consPos(2) consPos(3)+.01 consPos(4)]);ticks = strsplit(num2str(cl.Ticks));ax = axes('Position', cl.Position);edges = linspace(0,1,numel(ticks)+1);centers = edges(2:end)-((edges(2)-edges(1))/2);text(ones(size(centers))*0.5, centers, {'C','MC','','MC','C'},'FontSize',cl.FontSize,'HorizontalAlignment','Center','VerticalAlignment','Middle','color','w');ax.Visible = 'off';cl.Ticks = [];text(1.2,.2,['\textbf{Degradation}'],'color','k','rotation',270,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex');text(1.2,.8,['\textbf{Improvement}'],'color','k','rotation',270,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex');
									if identeps==1;filename=[identtrackint,'/',identn,'_',stname,'_CONSISTENCYSCORECARD','_',identexpshort{identexploop}];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;print('-dpng',filename);end;close all;

									%% BACK TO SCORECARD
									% Specify y labels
									tmp_ytitle={'Mean Error (km)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean AT Bias (km)','Mean XT Bias (km)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.'}';									
									
									% Generate Matrix
									sc=nan(57,(identmaxfhr+1)/2);       

									% Start Figure
									clear l cntexp
									set(0,'defaultfigurecolor',[1 1 1]) % figure background color
									hfig=figure;
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
									%ax1=subplot(3,4,[1:8]);   
									hold on

									% Plot Matrix & Flip
									imagesc(sc,'AlphaData',~isnan((sc)))
									axis ij

									% X- and Y- Axes: Ticks, Labels, Ranges
									xlabel('Forecast Lead Time (h)','fontsize',20)
									set(gca,'fontsize',14)
									box on
									if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
										if mod(identmaxfhr*3,12)==0
											xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]) 
										end
									else
										if mod(identmaxfhr*3-3,12)==0
											xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]) 
										end
									end    
									set(gca,'xtick',1:skiptick:50)
									set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
									set(gca,'fontsize',9)
									ylim([0.5 size(sc,1)+.5])
									set(gca,'ytick',1:1:size(sc,1)+.5)
									set(gca,'yticklabel',tmp_ytitle)
									set(gca,'TickLength',[0 0])

									% Colormap
									colorbar
									caxis([-50 50])
									run customcolorbars
									cl=colorbar;
									colormap(gca,custommap(20,negposc))														

									% Create Gridlines
									for i=1:size(sc,2)
										plot(repmat(0.5+i,1,size(sc,1)+3),-1:size(sc,1)+1,'k')
									end
									plot(-1:size(sc,2)+1,repmat(9.5,size(sc,2)+3,1),'k','linewidth',2)
									plot(-1:size(sc,2)+1,repmat(17.5,size(sc,2)+3,1),'k','linewidth',2)
									plot(-1:size(sc,2)+1,repmat(25.5,size(sc,2)+3,1),'k','linewidth',2)
									plot(-1:size(sc,2)+1,repmat(33.5,size(sc,2)+3,1),'k','linewidth',2)
									plot(-1:size(sc,2)+1,repmat(41.5,size(sc,2)+3,1),'k','linewidth',2)
									plot(-1:size(sc,2)+1,repmat(49.5,size(sc,2)+3,1),'k','linewidth',2)

									% Box Outside Graphic
									plot(repmat((-2.1+-1.5)/2,1,size(sc,1)+1),0.5:size(sc,1)+.5,'k','clipping','off','linewidth',28)
									plot(-2.1:size(sc,2)-7,repmat(0.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
									plot(-2.1:size(sc,2)-7,repmat(9.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
									plot(-2.1:size(sc,2)-7,repmat(17.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
									plot(-2.1:size(sc,2)-7,repmat(25.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
									plot(-2.1:size(sc,2)-7,repmat(33.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
									plot(-2.1:size(sc,2)-7,repmat(41.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
									plot(-2.1:size(sc,2)-7,repmat(49.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
									plot(-2.1:size(sc,2)-7,repmat(57.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')         

								   

									% Variable Titles
									text(-1.75,5,['\textbf{TRACK}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
									text(-1.88,13.5,['\textbf{WIND}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
									text(-1.62,13.5,['\textbf{SPEED}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
									text(-1.75,21.5,['\textbf{MSLP}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
									text(-1.75,29.5,['\textbf{RTSF}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
									text(-1.75,37.5,['\textbf{RSF}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
									text(-1.75,45.5,['\textbf{RHF}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
									text(-1.75,53.5,['\textbf{RMW}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')

									% Title Text
									text(0,1.065,['\textbf{Scorecard}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									text(1,1.065,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
									text(1,1.035,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
									tmpuv = 0;                               
									tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
									if strat==1
										text(0,1.035,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									else
										text(0,1.035,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									end
									tx=text(0.99,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									set(tx, 'Layer', 'front')
									
									% Figure Sizing & Printing
									set(gcf, 'InvertHardcopy', 'off')    
									ax=gca;
									box on
									set(ax, 'Layer', 'top')
									ax.LineWidth=2; 
									set(gca,'position',[spPos(1) spPos(2)-.07 spPos(3)+.09 spPos(4)+.1])
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, .5]); % maximize figure window
									set(gca,'Color',[.9 .9 .9])
									% Save Figure
									set(gcf,'Units','inches');
									screenposition = get(gcf,'Position');
									set(gcf,'PaperPosition',[0 0 screenposition(3)+3 screenposition(4)+3],'PaperSize',[screenposition(3)+3 screenposition(4)+3]);    
									if identeps==1;filename=[identtrackint,'/',identn,'_',stname,'_SCORECARD','_',identexpshort{identexploop}];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;print('-dpng',filename);end;close all;
									close all
								end
							end                    
					else    
						if sum(isnan(keepstm))-size(keepstm,2)==0 && (strat==2 || strat==3) % no storms have obs...skip strat 2 & 3
							disp('None of the storms in the composite have obs...skipping the OBS and TARGET stratifications...')
						elseif identcompositeonly==0
							% Create Graphics: lagged corr
							if strat==1; for plt=[1:18,21:23]                                                  
							%clear scfactor scfactor0
							if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkerr';
									 tmp_title='Track Error (km)';
									 tmp_ytitle='Error (km)';
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prserr';
									tmp_title='Pressure Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spderr';
									tmp_title='Wind Speed Error (m/s)';
									tmp_ytitle='Error (m/s)';
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFerr';
									tmp_title='RTSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFerr';
									tmp_title='RTSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFerr';
									tmp_title='RTSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFerr';
									tmp_title='RTSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFerr';
									tmp_title='RSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFerr';
									tmp_title='RSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFerr';
									tmp_title='RSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFerr';
									tmp_title='RSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFerr';
									tmp_title='RHF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFerr';
									tmp_title='RHF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFerr';
									tmp_title='RHF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFerr';
									tmp_title='RHF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poerr';
									tmp_title='Outer Clsd Isbr Prs Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roerr';
									tmp_title='Outer Clsd Isbr Rad Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwerr';
									tmp_title='RMW Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='ateerr';
									tmp_title='Along-Track Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[-500 500];                
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xteerr';
									tmp_title='Across-Track Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[-500 500]; 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFerr';
									tmp_title='RTSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFerr';
									tmp_title='RSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFerr';
									tmp_title='RHF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								end
								if strat==1
									clear tmpyrb
									tmpnm=identinittimesunique(~isnan(BT_cat1)==1,:);
								elseif strat==2
									clear tmpyrb
									if plt>=21 && plt<=23
										 tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										 tmp_exp(BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_drops'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==3
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_target';BT_target';BT_target';BT_target']==0,:,:)=NaN;
									else
										tmp_exp(BT_target'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_target'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==4 % TD
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:);
								elseif strat==5 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384,:,:)=NaN;
									end 
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:);
								elseif strat==6 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 ,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0,:,:)=NaN;
									end                  
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==7 % H345
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==8 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1>=30,:);
								elseif strat==9 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30,:,:)=NaN;
									else
										tmp_exp(BT_lat1>=30,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30,:);
								elseif strat==10 % RI
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>=15./1.94384 ,:);
								elseif strat==11 % IN
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<5./1.94384  | BT_intch1>=15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:);
								elseif strat==12 % SS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=5./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<=-5./1.94384  | BT_intch1>=5./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:);
								elseif strat==13 % W
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1>-5./1.94384  | BT_intch1<=-15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:);
								elseif strat==14 % RW
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1>-15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1<=-15./1.94384 ,:);
								elseif strat==15 %% TD strat obs only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0 | BT_drops'==0,:,:)=NaN;
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:);
								elseif strat==16 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384 | BT_drops'==0,:,:)=NaN;
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:);
								elseif strat==17 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0  | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384| BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==0,:,:)=NaN;
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==18 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
								   else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0| BT_drops'==0,:,:)=NaN;
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==19 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30 | BT_drops'==0,:,:)=NaN;
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==1,:);
								elseif strat==20 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										 tmp_exp(BT_lat1>=30 | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==1,:);
								elseif strat==21
									clear tmpyrb
									if plt>=21 && plt<=23
										 tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										 tmp_exp(BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_drops'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==22
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_target';BT_target';BT_target';BT_target']==1,:,:)=NaN;
									else
										tmp_exp(BT_target'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_target'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==23 %% TD strat obs only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0 | BT_drops'==1,:,:)=NaN;
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:);
								elseif strat==24 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384 | BT_drops'==1,:,:)=NaN;
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:);
								elseif strat==25 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0  | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==1,:,:)=NaN;
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==26 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
								   else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==1,:,:)=NaN;
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==27 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30 | BT_drops'==1,:,:)=NaN;
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==0,:);
								elseif strat==28 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										 tmp_exp(BT_lat1>=30 | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==0,:);
								elseif strat==29 % Low Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin,:);
								elseif strat==30 % Moderate Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin ,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:);
								elseif strat==31 % High Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin,:);
								elseif strat==32 % Low Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==1,:);
								elseif strat==33 % Moderate Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin | BT_drops'==1,:);
								elseif strat==34 % High Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==1,:);
								elseif strat==35 % Low Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==0,:);
								elseif strat==36 % Moderate Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:);
								elseif strat==37 % High Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==0,:);	
						 elseif strat==100
                                                        clear tmpyrb
                                                        if plt>=21 && plt<=23
                                                             tmp_exp([BT_obsg';BT_obsg';BT_obsg';BT_obsg']==0,:,:)=NaN;
                                                        else
                                                             tmp_exp(BT_obsg'==0,:,:)=NaN;
                                                        end
                                                        tmpnm=identinittimesunique(BT_obsg'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==888
									clear tmpyrb
									numlist=[];
									for ins=1:size(identnewsub,1)
										tmpns=identnewsub(ins,:);
										for ins2=1:size(identinittimesunique,1)
											if strcmp(identinittimesunique(ins2,:),tmpns)==1
												numlist=[numlist ins2];
											else
											end
										end
									end
									[a_ns,b_ns]=histcounts(numlist,.5:1:size(identinittimesunique,1)+.5);
									numlist=a_ns';
									numlist(numlist>0)=1;
									if plt>=21 && plt<=23
										tmp_exp([numlist;numlist+size(identinittimesunique,1)*1;numlist+size(identinittimesunique,1)*2;numlist+size(identinittimesunique,1)*3]==0,:,:)=NaN;
									else
										tmp_exp(numlist==0,:,:)=NaN;
									end                  
									tmpnm=identinittimesunique(numlist==1,:);     
								end
								onefhr0=tmp_exp;
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkerr';
									 tmp_title='Track Error (km)';
									 tmp_ytitle='Error (km)';
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prserr';
									tmp_title='Pressure Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spderr';
									tmp_title='Wind Speed Error (m/s)';
									tmp_ytitle='Error (m/s)';
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFerr';
									tmp_title='RTSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFerr';
									tmp_title='RTSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFerr';
									tmp_title='RTSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFerr';
									tmp_title='RTSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFerr';
									tmp_title='RSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFerr';
									tmp_title='RSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFerr';
									tmp_title='RSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFerr';
									tmp_title='RSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFerr';
									tmp_title='RHF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFerr';
									tmp_title='RHF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFerr';
									tmp_title='RHF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFerr';
									tmp_title='RHF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poerr';
									tmp_title='Outer Clsd Isbr Prs Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roerr';
									tmp_title='Outer Clsd Isbr Rad Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwerr';
									tmp_title='RMW Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='ateerr';
									tmp_title='Along-Track Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[-500 500];                
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xteerr';
									tmp_title='Across-Track Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[-500 500]; 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFerr';
									tmp_title='RTSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFerr';
									tmp_title='RSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFerr';
									tmp_title='RHF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								end
								onefhr=tmp_exp;													
							 % Lagged Correlation
								for identexploop=1:size(tmp_exp,3)	
									clear l cntexp
									set(0,'defaultfigurecolor',[1 1 1]) % figure background color
									hfig=figure;
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
									ax1=subplot(3,4,[1:8]);
									hold on													
									cc=[];
									pp=[];
									for fhr=1:size(tmp_exp,2)															
										st=1;
										ed=11;
										for j=1:11
											if j==1
												ac1(j,:)=onefhr0(st:end-ed,fhr,identexploop);
												st=st+1;
												ed=ed-1;
											else
												ac1(j,:)=onefhr(st:end-ed,fhr,identexploop);
												st=st+1;
												ed=ed-1;
											end
										end							
										for k=1:11
											if size(corrcoef(ac1(1,:),ac1(k,:),'rows','complete'),1)==1
												r(k)=NaN;
												p(k)=NaN;
											else
												[R,P]=corrcoef(ac1(1,:),ac1(k,:),'rows','complete');
												r(k)=R(2);
												p(k)=P(2);
											end
										end
										cc(fhr,:)=r;
										pp(fhr,:)=p;
										clear ac1														
									end			
									% Plot														
									clear cola; for cca=1:size(cc,1); ccatmp=cc(cca,1:identlagcorr);	[row,col]=find(abs(ccatmp)>=sqrt(identserialcorr));	rowa(cca)=cca;	if isempty(col)==1;cola(cca)=1; else; cola(cca)=col(end);end; end; scfactor(plt,identexploop,:)=cola; if identexploop==1;scfactor0(plt,identexploop)={['Sample size for ', tmp_title,' in ',identexp{identexploop},' divided by ', num2str(cola(1:size(1:skip:identmaxfhr,2))),' which is a ', num2str((cola(1:size(1:skip:identmaxfhr,2))-1)*6),' serial correlation and a ',num2str((cola(1:size(1:skip:identmaxfhr,2)))*6),' separation time!']};end;
									cc=flipud(cc');
									pp=flipud(pp');
									pp(pp>=0.05)=NaN;
									pp=~isnan(pp)==1;
									imagesc(cc,'AlphaData',~isnan(cc))
									set(gca,'plotboxaspectratio',[1 1 1])
									ylabel('Lag (6-h Cycles)','fontsize',20)
									set(gca,'ytick',1:11)
									set(gca,'yticklabel',10:-1:0)
									xlabel('Forecast Lead Time (h)','fontsize',20)
									set(gca,'fontsize',20)
									box on
									if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
										if mod(identmaxfhr*3,12)==0
											xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]) 
										end
									else
										if mod(identmaxfhr*3-3,12)==0
											xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]) 
										end
									end         
									set(gca,'xtick',1:skiptick:50)
									set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
									set(gca,'gridcolor','k','gridalpha',.15)
									set(gca,'fontsize',20)      
									hold off
									box on														
									hold on
									for i=1:size(cc,2)
										plot(repmat(0.5+i,1,size(cc,1)+3),-1:size(cc,1)+1,'k')
									end
									for i=1:size(cc,1)
										plot(-1:size(cc,2)+1,repmat(i-.5,1,size(cc,2)+3),'k')
									end
									ylim([0.5 11.5])
									run customcolorbars
									cl=colorbar;
									caxis([-1 1])														
									colormap(gca,custommap(20,negposc))														
									set(cl,'ticks',[-1:.2:1],'fontsize',14)														
									[row,col]=find(abs(cc)>=sqrt(.25) & abs(cc)<sqrt(.50)); % 25-50% variance
									hold on
									if isempty(row)
									else
										plot(col,row,'.k','markerfacecolor','k');
									end
									[row,col]=find(abs(cc)>=sqrt(.50) & abs(cc)<sqrt(.75)); % 50-75% variance
									hold on
									if isempty(row)
									else
										plot(col,row,'+k','markerfacecolor','k');
									end
									[row,col]=find(abs(cc)>=sqrt(.75)); % 50-75% variance
									hold on
									if isempty(row)
									else
										plot(col,row,'sk','markerfacecolor','k');														
									end
									l(1)=plot(-100,-100,'.k','markerfacecolor','k');
									l(2)=plot(-100,-100,'+k','markerfacecolor','k');
									l(3)=plot(-100,-100,'sk','markerfacecolor','k');
									lh=legend(l,'r^2=25-50%','r^2=50-75%','r^2=75-100%','location','southeastoutside','orientation','vertical');	
									lh.FontSize=10;
									lh.ItemTokenSize(1) = 10;
									lhp=lh.Position;
									set(lh,'position',[lhp(1)+.2 lhp(2)-.28 lhp(3) lhp(4)])
									set(gcf,'Units','inches');
									a1Pos = get(gca,'Position');
									set(gcf, 'InvertHardcopy', 'off')
									set(gcf,'Units','inches');
									screenposition = get(gcf,'Position');
									set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
									set(gcf, 'InvertHardcopy', 'off')
									text(0,1.065,['\textbf{',tmp_title,' Lagged Correlation}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')    
									text(1,1.065,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
									text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
									tmpuv = size(tmpnm,1);                               
									tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];
									if strat==1
									text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									else
									text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									end
									ax=gca;
									box on
									set(ax, 'Layer', 'bottom')
									ax.LineWidth=2; 
									set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
									set(gca,'Color',[.9 .9 .9]);clear cntexp;
									for tmp=1:size(identexp,1)
										cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
									end
									if sum([cntexp(:)])==0
										tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
										set(tx, 'Layer', 'front')
									end          
									if plt==19
										 tx=text(0.02,0.05,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
										 tx=text(0.02,0.98,'Faster than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
										 set(tx, 'Layer', 'front')            
									elseif plt==20
										 tx=text(0.02,0.05,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
										 tx=text(0.02,0.98,'Right of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
										 set(tx, 'Layer', 'front')            
									end
									axis ij
									b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
									set(b,'plotboxaspectratio',[1 1 1])
									set(b,'Color','none');
									set(b,'YColor','none');
									set(b,'tickdir','both')
									set(b,'XColor',[0 0 0]);
									set(b,'ytick',[]);
									if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
										if mod(identmaxfhr*3,12)==0
											xlim(b,[0.5 (((identmaxfhr*3))/skiphr+1)+.5])
											tmpxend=((identmaxfhr*3))/skiphr+1;
										else
											xlim(b,[0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]) 
											tmpxend=((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1;
										end
									else
										if mod(identmaxfhr*3-3,12)==0
											xlim(b,[0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5])
											tmpxend=((identmaxfhr*3)-3)/skiphr+1;
										else
											xlim(b,[0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]) 
											tmpxend=((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1;
										end
									end
									set(b,'xtick',[1:skiptick:50]);
									trkerr_exp_fcnt=zeros(1,tmpxend);            
									trkerr_exp_fcnt1=zeros(1,tmpxend);            
									trkerr_exp_fcnt2=zeros(1,tmpxend);clear cntexp;
									for tmp=1:size(identexp,1)
										cntexp(:,tmp)=sum(~isnan(onefhr0(:,1:skip:end,tmp)),1);
									end 
									set(gca,'fontsize',14)
									xlabel('# fcsts','Position',[-1 0],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',90,'units','normalized'); 
									set(gca,'position',[spPos(1)+.02 spPos(2)-.05 spPos(3) spPos(4)])
									screenposition = get(gcf,'Position');
									set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
									set(gcf, 'InvertHardcopy', 'off')
									% Create a text box at every Tick label position
									maxmin=squeeze(sum(~isnan(onefhr0(:,1:skip:end,:)),1)); 
									xTicks0 = get(gca, 'xticklabel');
									xTicks = get(gca, 'xtick');
									if size(maxmin,1)<size(xTicks0,1)
										for n=1:size(xTicks0,1)-size(maxmin,1)
											maxmin(end+n,:)=0;
										end
									end
									set(b,'xticklabels',[]);
									minY =0;
									VerticalOffset1=0.03;
									HorizontalOffset = 0.2;
									for xx = 1:size(xTicks0,1)
										tmptxt0=maxmin(xx,:);
										tmplines=size(tmptxt0,2);
										if size(unique(tmptxt0),2)==1
											tmptxt1=num2str(tmptxt0(1)); 
											text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)                    
										else
											for n=1:tmplines
												tmptxt1=[];                            
												tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(n,:)),'}',num2str(tmptxt0(n))];                           
												if n==1
													text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)
												else
													text(xTicks(xx), minY - (VerticalOffset1+(.02*(n-1))),tmptxt1,'horizontalalignment','center','fontsize',14)                                
												end
											end    
										end
									end
									f = getframe(hfig);
									if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname,'_LAGCORR','_',identexpshort{identexploop}];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
									close all													
								end
							end;end;   														
							fid=fopen([identtrackint,'/',identn,'_scfactor.txt'],'w');fprintf(fid,'%s\n', scfactor0{:});fclose(fid);
							% Create Graphics: trk, int, spd errors - bt-gh vs. bt-deny
							for plt=1:23
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax1=subplot(3,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkerr';
									 tmp_title='Track Error (km)';
									 tmp_ytitle='Error (km)';
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prserr';
									tmp_title='Pressure Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spderr';
									tmp_title='Wind Speed Error (m/s)';
									tmp_ytitle='Error (m/s)';
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFerr';
									tmp_title='RTSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFerr';
									tmp_title='RTSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFerr';
									tmp_title='RTSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFerr';
									tmp_title='RTSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFerr';
									tmp_title='RSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFerr';
									tmp_title='RSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFerr';
									tmp_title='RSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFerr';
									tmp_title='RSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFerr';
									tmp_title='RHF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFerr';
									tmp_title='RHF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFerr';
									tmp_title='RHF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFerr';
									tmp_title='RHF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poerr';
									tmp_title='Outer Clsd Isbr Prs Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roerr';
									tmp_title='Outer Clsd Isbr Rad Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwerr';
									tmp_title='RMW Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='trkbias1';
									tmp_title='Along-Track Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-500 500];                
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='trkbias2';
									tmp_title='Across-Track Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-500 500]; 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFerr';
									tmp_title='RTSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFerr';
									tmp_title='RSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFerr';
									tmp_title='RHF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								tmp_exp0=tmp_exp;

								 % Strat
								if strat==1
									clear tmpyrb
									tmpnm=identinittimesunique(~isnan(BT_cat1)==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_NONE.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: NONE');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end
								elseif strat==2
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_drops==1,:,:);
									end
									tmpnm=identinittimesunique(BT_drops'==1 & ~isnan(BT_cat1)==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_OBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: OBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end
								elseif strat==3
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_target';BT_target';BT_target';BT_target']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_target==1,:,:);
									end
									tmpnm=identinittimesunique(BT_target'==1 & ~isnan(BT_cat1)==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_TARGETED.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: TARGETED');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end
								elseif strat==4 % TD
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:,:);
									end
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_TD.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: TD');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end                
								elseif strat==5 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:,:);
									end 
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_TS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: TS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end   
								elseif strat==6 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:,:);
									end                  
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_H12.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: H12');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end   
								elseif strat==7 % H345
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:,:);
									end     
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_H345.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: H345');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end   
								elseif strat==8 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1>=30,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_N30.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: N30');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end   
								elseif strat==9 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_S30.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: S30');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end                                                     
								elseif strat==10 % RI
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>=15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>=15./1.94384 ,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_RI.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: RI');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end 
								elseif strat==11 % IN
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_IN.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: IN');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end 
								elseif strat==12 % SS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<5./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_SS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: SS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end 
								elseif strat==13 % W
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_WK.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: WK');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end 
								elseif strat==14 % RW
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1<=-15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1<=-15./1.94384 ,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_RW.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: RW');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end 		
								elseif strat==15 %% TD strat obs only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:,:);
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_TD-OBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: TD-OBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end 
								elseif strat==16 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:,:);
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_TS-OBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: TS-OBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end   
								elseif strat==17 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:,:);
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_H12-OBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: H12-OBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end   
								elseif strat==18 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
								   else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:,:);
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_H345-OBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: H345-OBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end   
								elseif strat==19 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30 & BT_drops'==1,:,:);
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_N30-OBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: N30-OBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end   
								elseif strat==20 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30 & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_S30-OBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: S30-OBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end
								elseif strat==21
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_drops'==0 & ~isnan(BT_cat1)==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_NOOBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: NOOBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end
								elseif strat==22
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_target';BT_target';BT_target';BT_target']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_target'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_target'==0 & ~isnan(BT_cat1)==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_PRERECON.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: PRERECON');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end    
								elseif strat==23 %% TD strat NOOBS only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:,:);
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_TD-NOOBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: TD-NOOBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end 
								elseif strat==24 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:,:);
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_TS-NOOBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: TS-NOOBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end   
								elseif strat==25 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:,:);
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_H12-NOOBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: H12-NOOBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end   
								elseif strat==26 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
								   else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:,:);
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_H345-NOOBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: H345-NOOBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end   
								elseif strat==27 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30 & BT_drops'==0,:,:);
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==0,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_N30-NOOBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: N30-NOOBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end   
								elseif strat==28 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30 & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==0,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_S30-NOOBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: S30-NOOBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end
								elseif strat==29 % Low Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_LOW.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: LOW');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end
								elseif strat==30 % Moderate Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin ,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_MOD.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: MOD');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end 	
								elseif strat==31 % High Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_HIGH.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: HIGH');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end	
								elseif strat==32 % Low Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_LOW-OBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: LOW-OBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end
								elseif strat==33 % Moderate Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_MOD-OBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: MOD-OBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end 	
								elseif strat==34 % High Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_HIGH-OBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: HIGH-OBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end	
								elseif strat==35 % Low Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==0,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_LOW-NOOBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: LOW-NOOBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end
								elseif strat==36 % Moderate Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_MOD-NOOBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: MOD-NOOBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end 	
								elseif strat==37 % High Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==0,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_HIGH-NOOBS.txt'],'wt');
										fprintf(fid,'%s\n','STRATIFICATION: HIGH-NOOBS');
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end		
						elseif strat==100 % OBS-G
							clear tmpyrb
                                                        if plt>=21 && plt<=23
                                                            tmp_exp=tmp_exp([BT_obsg';BT_obsg';BT_obsg';BT_obsg']==1,:,:);
                                                        else
                                                            tmp_exp=tmp_exp(BT_obsg==1,:,:);
                                                        end
                                                        tmpnm=identinittimesunique(BT_obsg'==1 & ~isnan(BT_cat1)==1,:);
                                                        if plt==1
                                                            fid = fopen([identtrackint,'/STRAT_OBS-G.txt'],'wt');
                                                            fprintf(fid,'%s\n','STRATIFICATION: OBS-G');
                                                            for prn=1:size(tmpnm,1)
                                                                fprintf(fid,'%s\n',tmpnm(prn,:));
                                                            end
                                                            fclose(fid); 
                                                        end
								elseif strat==888
									clear tmpyrb
									numlist=[];
									for ins=1:size(identnewsub,1)
										tmpns=identnewsub(ins,:);
										for ins2=1:size(identinittimesunique,1)
											if strcmp(identinittimesunique(ins2,:),tmpns)==1
												numlist=[numlist ins2];
											end
										end
									end
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([numlist;numlist+size(identinittimesunique,1)*1;numlist+size(identinittimesunique,1)*2;numlist+size(identinittimesunique,1)*3],:,:);
									else
										tmp_exp=tmp_exp(numlist,:,:);
									end                  
									tmpnmbtcat=BT_cat1(numlist); tmpnm=identinittimesunique(numlist,:); tmpnm=tmpnm(~isnan(tmpnmbtcat)==1,:);
									if plt==1
										fid = fopen([identtrackint,'/STRAT_',stname,'.txt'],'wt');
										fprintf(fid,'%s\n',['STRATIFICATION ',stname]);
										for prn=1:size(tmpnm,1)
											fprintf(fid,'%s\n',tmpnm(prn,:));
										end
										fclose(fid); 
									end  
								end

								if plt==1;tmp_expbias=tmp_exp;end;
								for tmp=1:size(identexp,1)
									l(tmp)=plot(1:size(tmp_exp,2),nanmean(tmp_exp(:,:,tmp),1),'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2);
								end           
								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end
								plot(-10:89,zeros(1,100),'Color',[.5 .5 .5],'linewidth',2);
								for tmp=1:size(identexp,1)
									if plt==19 || plt==20; sigtest=ttestsc(tmp_expbias(:,:,tmp),tmp_expbias(:,:,tmpimp),squeeze(scfactor(1,tmp,:))','alpha',.05);else;sigtest=ttestsc(tmp_exp(:,:,tmp),tmp_exp(:,:,tmpimp),squeeze(scfactor(plt,tmp,:))','alpha',.05);end;
									sigtest_loc=find(sigtest==1);
									sigtest_exp=nanmean(tmp_exp(:,sigtest_loc,:),1);
									for tmpi=tmp
										plot(sigtest_loc,sigtest_exp(:,:,tmpi),'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',9)
									end
									if plt==19 || plt==20; sigtest=ttestsc(tmp_expbias(:,:,tmp),tmp_expbias(:,:,tmpimp),squeeze(scfactor(1,tmp,:))','alpha',.1);else;sigtest=ttestsc(tmp_exp(:,:,tmp),tmp_exp(:,:,tmpimp),squeeze(scfactor(plt,tmp,:))','alpha',.1);end;
									sigtest_loc1=find(sigtest==1);
									sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
									sigtest_exp=nanmean(tmp_exp(:,sigtest_loc,:),1);
									for tmpi=tmp
										plot(sigtest_loc,sigtest_exp(:,:,tmpi),'o','Color','k','markersize',8,'markerfacecolor',identexpcolors(tmp,:))
									end
								end   
								set(gca,'plotboxaspectratio',[1 1 1])
								xlabel('Forecast Lead Time (h)','fontsize',20)
								ylabel(tmp_ytitle,'fontsize',20)
								set(gca,'fontsize',20)
								box on
								if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
									if mod(identmaxfhr*3,12)==0
										xlim([1 ((identmaxfhr*3))/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
									end
								else
									if mod(identmaxfhr*3-3,12)==0
										xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
									end
								end
								 % YRANGE
								clear allquad
								allquad(1)=(max(max(nanmean(abs(ne34err_exp(:,1:skip:end,:)),1))));
								allquad(2)=(max(max(nanmean(abs(se34err_exp(:,1:skip:end,:)),1))));
								allquad(3)=(max(max(nanmean(abs(nw34err_exp(:,1:skip:end,:)),1))));
								allquad(4)=(max(max(nanmean(abs(sw34err_exp(:,1:skip:end,:)),1))));
								allquad(5)=(max(max(nanmean(abs(ne50err_exp(:,1:skip:end,:)),1))));
								allquad(6)=(max(max(nanmean(abs(se50err_exp(:,1:skip:end,:)),1))));
								allquad(7)=(max(max(nanmean(abs(nw50err_exp(:,1:skip:end,:)),1))));
								allquad(8)=(max(max(nanmean(abs(sw50err_exp(:,1:skip:end,:)),1))));
								allquad(9)=(max(max(nanmean(abs(ne64err_exp(:,1:skip:end,:)),1))));
								allquad(10)=(max(max(nanmean(abs(se64err_exp(:,1:skip:end,:)),1))));
								allquad(11)=(max(max(nanmean(abs(nw64err_exp(:,1:skip:end,:)),1))));
								allquad(12)=(max(max(nanmean(abs(sw64err_exp(:,1:skip:end,:)),1))));
								allquadmax=max(max(max(allquad)));
								allquadmin=min(min(min(allquad)));
								tmpvalq=max(abs(allquadmin),abs(allquadmax));
								if isnan(tmpvalq)==1
									tmpvalq=0;
								end
								if numel(num2str(tmpvalq))==3
									addfacq=100;
								elseif numel(num2str(tmpvalq))==2
									addfacq=20;
								else 
									addfacq=20;
								end
								if numel(num2str(round(max(max(nanmean((tmp_exp0),1))))))==3
									addfac=100;
								elseif numel(num2str(round(max(max(nanmean((tmp_exp0),1))))))==2
									addfac=20;
								else
									addfac=20;
								end
								if plt<=3 || (plt>=16 && plt<=18) % 0-end
									tmpmin=min(min(nanmean((tmp_exp0),1)));
									tmpmax=max(max(nanmean((tmp_exp0),1)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[0 round((tmpval+addfac)/10)*10];                
								elseif plt==19 || plt==20 % -end end 
									tmpmin=min(min(nanmean((tmp_exp0),1)));
									tmpmax=max(max(nanmean((tmp_exp0),1)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
								elseif (plt>=4 && plt<=15) || plt>=21%quad
									yrange=[0 round((tmpvalq+addfacq)/10)*10];
								end
								ylim(yrange)
								set(gca,'xtick',1:skiptick:50)
								set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
								grid on
								set(gca,'gridcolor','k','gridalpha',.15)
								set(gca,'fontsize',20)      
								hold off
								box on
								lh=legend(l,identexpshort,'location','northeast');
								lh.FontSize=10;
								set(gcf,'Units','inches');
								a1Pos = get(gca,'Position');
								set(gcf, 'InvertHardcopy', 'off')
								set(gcf,'Units','inches');
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')    
								text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
								tmpuv = size(tmpnm,1);                               
								tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];
								if strat==1
								text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								else
								text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								end
								ax=gca;
								box on
								set(ax, 'Layer', 'bottom')
								ax.LineWidth=1; 
								set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
								set(gca,'Color',[.9 .9 .9])
								for tmp=1:size(identexp,1)
									cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
								end
								if sum([cntexp(:)])==0
									tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									set(tx, 'Layer', 'front')
								end          
								if plt==19
									 tx=text(0.02,0.05,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.02,0.98,'Faster than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')            
								elseif plt==20
									 tx=text(0.02,0.05,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.02,0.98,'Right of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')            
								end
								b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
								set(b,'plotboxaspectratio',[1 1 1])
								set(b,'Color','none');
								set(b,'YColor','none');
								set(b,'tickdir','both')
								set(b,'XColor',[0 0 0]);
								set(b,'ytick',[]);
								if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
									if mod(identmaxfhr*3,12)==0
										xlim(b,[1 ((identmaxfhr*3))/skiphr+1])
										tmpxend=((identmaxfhr*3))/skiphr+1;
									else
										xlim(b,[1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
										tmpxend=((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1;
									end
								else
									if mod(identmaxfhr*3-3,12)==0
										xlim(b,[1 ((identmaxfhr*3)-3)/skiphr+1])
										tmpxend=((identmaxfhr*3)-3)/skiphr+1;
									else
										xlim(b,[1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
										tmpxend=((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1;
									end
								end        
								set(b,'xtick',[1:skiptick:50]);
								trkerr_exp_fcnt=zeros(1,tmpxend);            
								trkerr_exp_fcnt1=zeros(1,tmpxend);            
								trkerr_exp_fcnt2=zeros(1,tmpxend);
								for tmp=1:size(identexp,1)
									cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
								end 
								set(gca,'fontsize',14)
								xlabel('# fcsts','Position',[-1 0],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',90,'units','normalized'); 
								set(gca,'position',[spPos(1)+.02 spPos(2)-.05 spPos(3) spPos(4)])
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								% Create a text box at every Tick label position
								maxmin=squeeze(sum(~isnan(tmp_exp(:,1:skiptick:end,:)),1)); 
								xTicks0 = get(gca, 'xticklabel');
								xTicks = get(gca, 'xtick');
								if size(maxmin,1)<size(xTicks0,1)
									for n=1:size(xTicks0,1)-size(maxmin,1)
										maxmin(end+n,:)=0;
									end
								end
								set(b,'xticklabels',[]);
								minY =0;
								VerticalOffset1=0.03;
								HorizontalOffset = 0.2;
								for xx = 1:size(xTicks0,1)
									tmptxt0=maxmin(xx,:);
									tmplines=size(tmptxt0,2);
									if size(unique(tmptxt0),2)==1
										tmptxt1=num2str(tmptxt0(1)); 
										text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)                    
									else
										for n=1:tmplines
											tmptxt1=[];                            
											tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(n,:)),'}',num2str(tmptxt0(n))];                           
											if n==1
												text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)
											else
												text(xTicks(xx), minY - (VerticalOffset1+(.02*(n-1))),tmptxt1,'horizontalalignment','center','fontsize',14)                                
											end
										end    
									end
								end
								f = getframe(hfig);
								if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
								close all
							end   
							% Create Graphics: trk, int, spd Skill vs. deny
							for plt=[1:18,21:23]
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax1=subplot(3,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkskill';
									 tmp_title='Track Skill (\%)';
									 tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									 yrange=[-20 20];
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prskill';
									tmp_title='Pressure Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spdskill';
									tmp_title='Wind Speed Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFskill';
									tmp_title='RTSF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFskill';
									tmp_title='RTSF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFskill';
									tmp_title='RTSF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFskill';
									tmp_title='RTSF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFskill';
									tmp_title='RSF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFskill';
									tmp_title='RSF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFskill';
									tmp_title='RSF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFskill';
									tmp_title='RSF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFskill';
									tmp_title='RHF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFskill';
									tmp_title='RHF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFskill';
									tmp_title='RHF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFskill';
									tmp_title='RHF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poskill';
									tmp_title='Outer Clsd Isbr Prs Skill (hPa)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roskill';
									tmp_title='Outer Clsd Isbr Rad Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwskill';
									tmp_title='RMW Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='ateskill';
									tmp_title='Along-Track Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xteskill';
									tmp_title='Across-Track Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFskill';
									tmp_title='RTSF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFskill';
									tmp_title='RSF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFskill';
									tmp_title='RHF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								tmp_exp0=squeeze(100.*(1-abs(nanmean(tmp_exp(:,:,:),1))./abs(nanmean(tmp_exp(:,:,tmpimp),1))));                  
								% Strat
																	% Strat
								if strat==1
									clear tmpyrb
									tmpnm=identinittimesunique(~isnan(BT_cat1)==1,:);
								elseif strat==2
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_drops==1,:,:);
									end
									tmpnm=identinittimesunique(BT_drops'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==3
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_target';BT_target';BT_target';BT_target']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_target==1,:,:);
									end
									tmpnm=identinittimesunique(BT_target'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==4 % TD
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:,:);
									end
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:);
								elseif strat==5 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:,:);
									end 
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:);
								elseif strat==6 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:,:);
									end                  
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==7 % H345
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:,:);
									end     
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==8 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1>=30,:);
								elseif strat==9 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30,:);                                                    
								elseif strat==10 % RI
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>=15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>=15./1.94384 ,:);
								elseif strat==11 % IN
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:);
								elseif strat==12 % SS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<5./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:);
								elseif strat==13 % W
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:);
								elseif strat==14 % RW
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1<=-15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1<=-15./1.94384 ,:);													
								elseif strat==15 %% TD strat obs only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:,:);
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:);
								elseif strat==16 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:,:);
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:);
								elseif strat==17 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:,:);
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==18 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
								   else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:,:);
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==19 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30 & BT_drops'==1,:,:);
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==1,:);
								elseif strat==20 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30 & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==1,:);                                        
								elseif strat==21
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_drops==0,:,:);
									end
									tmpnm=identinittimesunique(BT_drops'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==22
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_target';BT_target';BT_target';BT_target']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_target==0,:,:);
									end
									tmpnm=identinittimesunique(BT_target'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==23 %% TD strat NOOBS only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:,:);
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:);
								elseif strat==24 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:,:);
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:);
								elseif strat==25 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:,:);
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==26 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
								   else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:,:);
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==27 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30 & BT_drops'==0,:,:);
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==0,:);
								elseif strat==28 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30 & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==0,:);
								elseif strat==29 % Low Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin,:);
								elseif strat==30 % Moderate Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin ,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:);
								elseif strat==31 % High Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin,:);
								elseif strat==32 % Low Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==1,:);
								elseif strat==33 % Moderate Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==1,:);
								elseif strat==34 % High Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==1,:);
								elseif strat==35 % Low Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==0,:);
								elseif strat==36 % Moderate Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:);
								elseif strat==37 % High Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==0,:);	
						elseif strat==100 % OBS-G
                                                        clear tmpyrb
                                                        if plt>=21 && plt<=23
                                                            tmp_exp=tmp_exp([BT_obsg';BT_obsg';BT_obsg';BT_obsg']==1,:,:);
                                                        else
                                                            tmp_exp=tmp_exp(BT_obsg==1,:,:);
                                                        end
                                                        tmpnm=identinittimesunique(BT_obsg'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==888
									clear tmpyrb
									numlist=[];
									for ins=1:size(identnewsub,1)
										tmpns=identnewsub(ins,:);
										for ins2=1:size(identinittimesunique,1)
											if strcmp(identinittimesunique(ins2,:),tmpns)==1
												numlist=[numlist ins2];
											end
										end
									end
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([numlist;numlist+size(identinittimesunique,1)*1;numlist+size(identinittimesunique,1)*2;numlist+size(identinittimesunique,1)*3],:,:);
									else
										tmp_exp=tmp_exp(numlist,:,:);
									end                  
									tmpnmbtcat=BT_cat1(numlist); tmpnm=identinittimesunique(numlist,:); tmpnm=tmpnm(~isnan(tmpnmbtcat)==1,:); 
								end    
								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end      
								tmpu=1:size(identexp,1);
								tmpu(tmpu==tmpimp)=[];
								plot(-10:89,zeros(1,100),'Color',[.5 .5 .5],'linewidth',2);
								for tmp=[tmpimp,tmpu]
									imprv=100.*(1-abs(nanmean(tmp_exp(:,:,tmp),1))./abs(nanmean(tmp_exp(:,:,tmpimp),1)));                  
									imprv2(:,tmp)=imprv;
									l(tmp)=plot(1:size(imprv,2),imprv,'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2); 
									sigtest=ttestsc(tmp_exp(:,:,tmp),tmp_exp(:,:,tmpimp),squeeze(scfactor(plt,tmp,:))','alpha',.05);
									sigtest_loc=find(sigtest==1);
									sigtest_exp=imprv(sigtest_loc);
									plot(sigtest_loc,sigtest_exp,'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',9)
									sigtest=ttestsc(tmp_exp(:,:,tmp),tmp_exp(:,:,tmpimp),squeeze(scfactor(plt,tmp,:))','alpha',.1);
									sigtest_loc1=find(sigtest==1);
									sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
									sigtest_exp=imprv(sigtest_loc);
									plot(sigtest_loc,sigtest_exp,'o','Color','k','markersize',8,'markerfacecolor',identexpcolors(tmp,:))
								end   
								set(gca,'plotboxaspectratio',[1 1 1])
								xlabel('Forecast Lead Time (h)','fontsize',20)
								ylabel(tmp_ytitle,'fontsize',20)
								set(gca,'fontsize',20)
								box on
								if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
									if mod(identmaxfhr*3,12)==0
										xlim([1 ((identmaxfhr*3))/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
									end
								else
									if mod(identmaxfhr*3-3,12)==0
										xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
									end
								end
								% YRANGE
								clear allquad imprv3
								imprv3(:,:,1)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,2)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,3)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,4)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,5)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,6)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,7)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,8)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,9)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,10)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,11)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,12)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
								allquadmax=max(max(max(imprv3)));
								allquadmin=min(min(min(imprv3)));
								tmpvalq=max(abs(allquadmin),abs(allquadmax));
								if isnan(tmpvalq)==1
									tmpvalq=0;
								end
								if numel(num2str(tmpvalq))==3
									addfacq=100;
								elseif numel(num2str(tmpvalq))==2
									addfacq=20;
								else
									addfacq=20;
								end

								if numel(num2str(round(max(tmp_exp0(:)))))==3
									addfac=100;
								elseif numel(num2str(round(max(tmp_exp0(:)))))==2
									addfac=20;
								else
									addfac=20;
								end
								if plt<=3 || (plt>=16 && plt<=18) % 0-end
									tmpmin=min(tmp_exp0(:));
									tmpmax=max(tmp_exp0(:));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									if tmpval>250
										yrange=[-250 250];
									else
										yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
									end
								elseif plt==19 || plt==20 % -end end 
									tmpmin=min(tmp_exp0(:));
									tmpmax=max(tmp_exp0(:));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									if tmpval>250
										yrange=[-250 250];
									else
										yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
									end
								elseif (plt>=4 && plt<=15) || plt>=21%quad 
									if tmpvalq>250
										yrange=[-250 250];
									else
										yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
									end
								end
								ylim(yrange)
								set(gca,'xtick',1:skiptick:50)
								set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
								grid on
								set(gca,'gridcolor','k','gridalpha',.15)
								set(gca,'fontsize',20)      
								hold off
								box on
								lh=legend(l,identexpshort,'location','northeast');
								lh.FontSize=10;
								set(gcf,'Units','inches');
								a1Pos = get(gca,'Position');
								set(gcf, 'InvertHardcopy', 'off')
								set(gcf,'Units','inches');
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
								tmpuv = size(tmpnm,1);                               
								tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
								if strat==1
								text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								else
								text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								end
								ax=gca;
								box on
								set(ax, 'Layer', 'bottom')
								ax.LineWidth=1; 
								set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
								set(gca,'Color',[.9 .9 .9])            
								%if sum(~isnan((diff(imprv))))==0
								%    tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
								%    set(tx, 'Layer', 'front')
								%end
								% Mean Value            
								tmpstr=['Mean: '];
								%tmpstrmean=nanmean(imprv2(1:(identmaxfhr+1)/2,:),1);
								%tmpstrmean=(find(tmpstrmean~=0));
								tmpstrmean=1:size(imprv2,2);
								tmpstrmean(tmpstrmean==tmpimp)=[];
								for tmp=tmpstrmean
									if tmp==tmpstrmean(end)
										tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(imprv2(1:(identmaxfhr+1)/2,tmp)),2)),'%'];
									else
										tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(imprv2(1:(identmaxfhr+1)/2,tmp)),2)),'% \color[rgb]{0,0,0}| '];
									end
								end
								if sum(sum(~isnan(imprv2)))==0
									tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									set(tx, 'Layer', 'front')          
								else
									tx=text(0.98,0.05,tmpstr,'HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									set(tx, 'Layer', 'front')
								end 
								b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
								set(b,'plotboxaspectratio',[1 1 1])
								set(b,'Color','none');
								set(b,'YColor','none');
								set(b,'tickdir','both')
								set(b,'XColor',[0 0 0]);
								set(b,'ytick',[]);
								if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
									if mod(identmaxfhr*3,12)==0
										xlim(b,[1 ((identmaxfhr*3))/skiphr+1])
										tmpxend=((identmaxfhr*3))/skiphr+1;
									else
										xlim(b,[1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
										tmpxend=((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1;
									end
								else
									if mod(identmaxfhr*3-3,12)==0
										xlim(b,[1 ((identmaxfhr*3)-3)/skiphr+1])
										tmpxend=((identmaxfhr*3)-3)/skiphr+1;
									else
										xlim(b,[1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
										tmpxend=((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1;
									end
								end        
								set(b,'xtick',[1:skiptick:50]); 
								trkerr_exp_fcnt=zeros(1,tmpxend);            
								trkerr_exp_fcnt1=zeros(1,tmpxend);            
								trkerr_exp_fcnt2=zeros(1,tmpxend);
								for tmp=1:size(identexp,1)
									cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
								end  
								set(gca,'fontsize',14)
								xlabel('# fcsts','Position',[-1 0],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',90,'units','normalized'); 
								set(gca,'position',[spPos(1)+.02 spPos(2)-.05 spPos(3) spPos(4)])
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								% Create a text box at every Tick label position
								maxmin=squeeze(sum(~isnan(tmp_exp(:,1:skiptick:end,:)),1)); 
								xTicks0 = get(gca, 'xticklabel');
								xTicks = get(gca, 'xtick');
								if size(maxmin,1)<size(xTicks0,1)
									for n=1:size(xTicks0,1)-size(maxmin,1)
										maxmin(end+n,:)=0;
									end
								end
								set(b,'xticklabels',[]);
								minY =0;
								VerticalOffset1=0.03;
								HorizontalOffset = 0.2;
								for xx = 1:size(xTicks0,1)
									tmptxt0=maxmin(xx,:);
									tmplines=size(tmptxt0,2);
									if size(unique(tmptxt0),2)==1
										tmptxt1=num2str(tmptxt0(1)); 
										text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)                    
									else
										for n=1:tmplines
											tmptxt1=[];                            
											tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(n,:)),'}',num2str(tmptxt0(n))];                           
											if n==1
												text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)
											else
												text(xTicks(xx), minY - (VerticalOffset1+(.02*(n-1))),tmptxt1,'horizontalalignment','center','fontsize',14)                                
											end
										end    
									end
								end
								f = getframe(hfig);
								if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
								close all
							end
							% Create Graphics: trk, int, spd FSP vs. deny                                    
							for plt=[1:18,21:23]
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax1=subplot(3,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkfsp';
									 tmp_title='Track FSP (\%)';
									 tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									 yrange=[-20 20];
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prsfsp';
									tmp_title='Pressure FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spdfsp';
									tmp_title='Wind Speed FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFfsp';
									tmp_title='RTSF NEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFfsp';
									tmp_title='RTSF SEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFfsp';
									tmp_title='RTSF SWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFfsp';
									tmp_title='RTSF NWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFfsp';
									tmp_title='RSF NEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFfsp';
									tmp_title='RSF SEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFfsp';
									tmp_title='RSF SWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFfsp';
									tmp_title='RSF NWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFfsp';
									tmp_title='RHF NEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFfsp';
									tmp_title='RHF SEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFfsp';
									tmp_title='RHF SWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFfsp';
									tmp_title='RHF NWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='pofsp';
									tmp_title='Outer Clsd Isbr Prs FSP (hPa)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='rofsp';
									tmp_title='Outer Clsd Isbr Rad FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwfsp';
									tmp_title='RMW FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='atefsp';
									tmp_title='Along-Track FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xtefsp';
									tmp_title='Across-Track FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFfsp';
									tmp_title='RTSF FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFfsp';
									tmp_title='RSF FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFfsp';
									tmp_title='RHF FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								tmp_exp0=squeeze(100.*(1-nanmean(tmp_exp(:,:,:),1)./nanmean(tmp_exp(:,:,tmpimp),1)));                  
								% Strat
																	% Strat
								if strat==1
									clear tmpyrb
									tmpnm=identinittimesunique(~isnan(BT_cat1)==1,:);
								elseif strat==2
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_drops==1,:,:);
									end
									tmpnm=identinittimesunique(BT_drops'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==3
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_target';BT_target';BT_target';BT_target']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_target==1,:,:);
									end
									tmpnm=identinittimesunique(BT_target'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==4 % TD
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:,:);
									end
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:);
								elseif strat==5 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:,:);
									end 
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:);
								elseif strat==6 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:,:);
									end                  
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==7 % H345
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:,:);
									end     
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==8 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1>=30,:);
								elseif strat==9 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30,:);
								elseif strat==10 % RI
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>=15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>=15./1.94384 ,:);
								elseif strat==11 % IN
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:);
								elseif strat==12 % SS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<5./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:);
								elseif strat==13 % W
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:);
								elseif strat==14 % RW
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1<=-15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1<=-15./1.94384 ,:);	
								elseif strat==15 %% TD strat obs only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:,:);
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:);
								elseif strat==16 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:,:);
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:);
								elseif strat==17 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:,:);
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==18 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
								   else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:,:);
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==19 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30 & BT_drops'==1,:,:);
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==1,:);
								elseif strat==20 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30 & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==1,:);
								elseif strat==21
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_drops==0,:,:);
									end
									tmpnm=identinittimesunique(BT_drops'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==22
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_target';BT_target';BT_target';BT_target']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_target==0,:,:);
									end
									tmpnm=identinittimesunique(BT_target'==0 & ~isnan(BT_cat1)==1,:); 
								elseif strat==23 %% TD strat NOOBS only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:,:);
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:);
								elseif strat==24 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:,:);
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:);
								elseif strat==25 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:,:);
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==26 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
								   else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:,:);
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==27 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30 & BT_drops'==0,:,:);
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==0,:);
								elseif strat==28 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30 & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==0,:);  
								elseif strat==29 % Low Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin,:);
								elseif strat==30 % Moderate Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin ,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:);
								elseif strat==31 % High Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin,:);
								elseif strat==32 % Low Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==1,:);
								elseif strat==33 % Moderate Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==1,:);
								elseif strat==34 % High Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==1,:);
								elseif strat==35 % Low Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==0,:);
								elseif strat==36 % Moderate Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:);
								elseif strat==37 % High Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==0,:);	
						elseif strat==100 % OBS-G
                                                        clear tmpyrb
                                                        if plt>=21 && plt<=23
                                                            tmp_exp=tmp_exp([BT_obsg';BT_obsg';BT_obsg';BT_obsg']==1,:,:);
                                                        else
                                                            tmp_exp=tmp_exp(BT_obsg==1,:,:);
                                                        end
                                                        tmpnm=identinittimesunique(BT_obsg'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==888
									clear tmpyrb
									numlist=[];
									for ins=1:size(identnewsub,1)
										tmpns=identnewsub(ins,:);
										for ins2=1:size(identinittimesunique,1)
											if strcmp(identinittimesunique(ins2,:),tmpns)==1
												numlist=[numlist ins2];
											end
										end
									end
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([numlist;numlist+size(identinittimesunique,1)*1;numlist+size(identinittimesunique,1)*2;numlist+size(identinittimesunique,1)*3],:,:);
									else
										tmp_exp=tmp_exp(numlist,:,:);
									end                  
									tmpnmbtcat=BT_cat1(numlist); tmpnm=identinittimesunique(numlist,:); tmpnm=tmpnm(~isnan(tmpnmbtcat)==1,:); 
								end
								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end      
								tmpu=1:size(identexp,1);
								tmpu(tmpu==tmpimp)=[];
								plot(-10:89,50*ones(1,100),'Color',[.5 .5 .5],'linewidth',2);
								clear fsp2
								cntl=1;
								for tmp=tmpu
									tmp1=tmp_exp(:,:,tmp);
									tmp2=tmp_exp(:,:,tmpimp);
									tmp3=sign(tmp1-tmp2);
									tmp4=tmp3<0;
									tmp5=tmp3>0;
									tmp6=tmp3==0;
									tmptmp=sum(~isnan(tmp3),1);                            
									fspa=100*(nansum(tmp4,1)+nansum(tmp6,1)./2)./tmptmp;
									fspb=100*(nansum(tmp5,1)+nansum(tmp6,1)./2)./tmptmp;
									fsp2(:,tmp)=fspa;
									l(cntl)=plot(1:size(fspa,2),fspa,'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2); 
									cntl=cntl+1;
									sigtest=ttestsc(abs(tmp_exp(:,:,tmp)),abs(tmp_exp(:,:,tmpimp)),squeeze(scfactor(plt,tmp,:))','alpha',.05);
									sigtest_loc=find(sigtest==1);
									sigtest_exp=fspa(sigtest_loc);
									plot(sigtest_loc,sigtest_exp,'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',9)
									sigtest=ttestsc(abs(tmp_exp(:,:,tmp)),abs(tmp_exp(:,:,tmpimp)),squeeze(scfactor(plt,tmp,:))','alpha',.1);
									sigtest_loc1=find(sigtest==1);
									sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
									sigtest_exp=fspa(sigtest_loc);
									plot(sigtest_loc,sigtest_exp,'o','Color','k','markersize',8,'markerfacecolor',identexpcolors(tmp,:))
								end
								set(gca,'plotboxaspectratio',[1 1 1])
								xlabel('Forecast Lead Time (h)','fontsize',20)
								ylabel(tmp_ytitle,'fontsize',20)
								set(gca,'fontsize',20)
								box on
								if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
									if mod(identmaxfhr*3,12)==0
										xlim([1 ((identmaxfhr*3))/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
									end
								else
									if mod(identmaxfhr*3-3,12)==0
										xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
									end
								end
								ylim([0 100])
								set(gca,'xtick',1:skiptick:50)
								set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
								grid on
								set(gca,'gridcolor','k','gridalpha',.15)
								set(gca,'fontsize',20)      
								hold off
								box on
								lh=legend(l,identexpshort(tmpu),'location','northeast');
								lh.FontSize=10;
								set(gcf,'Units','inches');
								a1Pos = get(gca,'Position');
								set(gcf, 'InvertHardcopy', 'off')
								set(gcf,'Units','inches');
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
								tmpuv = size(tmpnm,1);                               
								tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
								if strat==1
								text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								else
								text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								end
								ax=gca;
								box on
								set(ax, 'Layer', 'bottom')
								ax.LineWidth=1; 
								set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
								set(gca,'Color',[.9 .9 .9])            
								%if sum(~isnan((diff(fspa))))==0
								%    tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
								%    set(tx, 'Layer', 'front')
								%end
								% Mean Value            
								tmpstr=['Mean: '];
								%tmpstrmean=nanmean(fsp2(1:(identmaxfhr+1)/2,:),1);
								%tmpstrmean=(find(tmpstrmean~=0));
								tmpstrmean=1:size(imprv2,2);
								tmpstrmean(tmpstrmean==tmpimp)=[];
								for tmp=tmpstrmean
									if tmp==tmpstrmean(end)
										tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(fsp2(1:(identmaxfhr+1)/2,tmp)),2)),'%'];
									else
										tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(fsp2(1:(identmaxfhr+1)/2,tmp)),2)),'% \color[rgb]{0,0,0}| '];
									end
								end
								if sum(sum(~isnan(fsp2)))==0
									tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									set(tx, 'Layer', 'front')          
								else
									tx=text(0.98,0.05,tmpstr,'HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									set(tx, 'Layer', 'front')
								end 
								b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
								set(b,'plotboxaspectratio',[1 1 1])
								set(b,'Color','none');
								set(b,'YColor','none');
								set(b,'tickdir','both')
								set(b,'XColor',[0 0 0]);
								set(b,'ytick',[]);
								if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
									if mod(identmaxfhr*3,12)==0
										xlim(b,[1 ((identmaxfhr*3))/skiphr+1])
										tmpxend=((identmaxfhr*3))/skiphr+1;
									else
										xlim(b,[1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
										tmpxend=((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1;
									end
								else
									if mod(identmaxfhr*3-3,12)==0
										xlim(b,[1 ((identmaxfhr*3)-3)/skiphr+1])
										tmpxend=((identmaxfhr*3)-3)/skiphr+1;
									else
										xlim(b,[1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
										tmpxend=((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1;
									end
								end        
								set(b,'xtick',[1:skiptick:50]); 
								trkerr_exp_fcnt=zeros(1,tmpxend);            
								trkerr_exp_fcnt1=zeros(1,tmpxend);            
								trkerr_exp_fcnt2=zeros(1,tmpxend);
								for tmp=1:size(identexp,1)
									cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
								end
								set(gca,'fontsize',14)
								xlabel('# fcsts','Position',[-1 0],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',90,'units','normalized'); 
								set(gca,'position',[spPos(1)+.02 spPos(2)-.05 spPos(3) spPos(4)])
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								% Create a text box at every Tick label position
								maxmin=squeeze(sum(~isnan(tmp_exp(:,1:skiptick:end,:)),1)); 
								xTicks0 = get(gca, 'xticklabel');
								xTicks = get(gca, 'xtick');
								if size(maxmin,1)<size(xTicks0,1)
									for n=1:size(xTicks0,1)-size(maxmin,1)
										maxmin(end+n,:)=0;
									end
								end
								set(b,'xticklabels',[]);
								minY =0;
								VerticalOffset1=0.03;
								HorizontalOffset = 0.2;
								for xx = 1:size(xTicks0,1)
									tmptxt0=maxmin(xx,:);
									tmplines=size(tmptxt0,2);
									if size(unique(tmptxt0),2)==1
										tmptxt1=num2str(tmptxt0(1)); 
										text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)                    
									else
										for n=1:tmplines
											tmptxt1=[];                            
											tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(n,:)),'}',num2str(tmptxt0(n))];                           
											if n==1
												text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)
											else
												text(xTicks(xx), minY - (VerticalOffset1+(.02*(n-1))),tmptxt1,'horizontalalignment','center','fontsize',14)                                
											end
										end    
									end
								end
								f = getframe(hfig);
								if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
								close all
							end                                    
							% Create Graphics: trk, int, spd bias - bt-gh vs. bt-deny
							for plt=[2:18,21:23] % no across or along for bias since already in error
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax1=subplot(3,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkbias';
									 tmp_title='Track Bias (km)';
									 tmp_ytitle='Bias (km)';
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prsbias';
									tmp_title='Pressure Bias (hPa)';
									tmp_ytitle='Bias (hPa)';
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spdbias';
									tmp_title='Wind Speed Bias (m/s)';
									tmp_ytitle='Bias (m/s)';
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFbias';
									tmp_title='RTSF NEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFbias';
									tmp_title='RTSF SEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFbias';
									tmp_title='RTSF SWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFbias';
									tmp_title='RTSF NWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFbias';
									tmp_title='RSF NEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFbias';
									tmp_title='RSF SEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFbias';
									tmp_title='RSF SWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFbias';
									tmp_title='RSF NWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFbias';
									tmp_title='RHF NEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFbias';
									tmp_title='RHF SEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFbias';
									tmp_title='RHF SWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFbias';
									tmp_title='RHF NWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='pobias';
									tmp_title='Outer Clsd Isbr Prs Bias (hPa)';
									tmp_ytitle='Bias (hPa)';
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='robias';
									tmp_title='Outer Clsd Isbr Rad Bias (km)';
									tmp_ytitle='Bias (km)';
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwbias';
									tmp_title='RMW Bias (km)';
									tmp_ytitle='Bias (km)';
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='atebias';
									tmp_title='Along-Track Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-500 500];                
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xtebias';
									tmp_title='Across-Track Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-500 500]; 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFbias';
									tmp_title='RTSF Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-100 100];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFbias';
									tmp_title='RSF Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-100 100];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFbias';
									tmp_title='RHF Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-100 100];
								end
								tmp_exp0=tmp_exp;
								% Strat
								if strat==1
									clear tmpyrb
									tmpnm=identinittimesunique(~isnan(BT_cat1)==1,:);
								elseif strat==2
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_drops==1,:,:);
									end
									tmpnm=identinittimesunique(BT_drops'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==3
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_target';BT_target';BT_target';BT_target']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_target==1,:,:);
									end
									tmpnm=identinittimesunique(BT_target'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==4 % TD
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:,:);
									end
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:);
								elseif strat==5 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:,:);
									end 
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:);
								elseif strat==6 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:,:);
									end                  
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==7 % H345
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:,:);
									end     
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==8 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1>=30,:);
								elseif strat==9 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30,:);
								elseif strat==10 % RI
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>=15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>=15./1.94384 ,:);
								elseif strat==11 % IN
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:);
								elseif strat==12 % SS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<5./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:);
								elseif strat==13 % W
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:);
								elseif strat==14 % RW
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1<=-15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1<=-15./1.94384 ,:);	
								elseif strat==15 %% TD strat obs only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:,:);
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:);
								elseif strat==16 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:,:);
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:);
								elseif strat==17 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:,:);
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==18 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
								   else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:,:);
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==19 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30 & BT_drops'==1,:,:);
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==1,:);
								elseif strat==20 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30 & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==1,:);
								elseif strat==21
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_drops==0,:,:);
									end
									tmpnm=identinittimesunique(BT_drops'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==22
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_target';BT_target';BT_target';BT_target']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_target==0,:,:);
									end
									tmpnm=identinittimesunique(BT_target'==0 & ~isnan(BT_cat1)==1,:);  
								elseif strat==23 %% TD strat NOOBS only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:,:);
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:);
								elseif strat==24 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:,:);
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:);
								elseif strat==25 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:,:);
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==26 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
								   else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:,:);
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==27 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30 & BT_drops'==0,:,:);
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==0,:);
								elseif strat==28 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30 & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==0,:);   
								elseif strat==29 % Low Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin,:);
								elseif strat==30 % Moderate Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin ,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:);
								elseif strat==31 % High Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin,:);
								elseif strat==32 % Low Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==1,:);
								elseif strat==33 % Moderate Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==1,:);
								elseif strat==34 % High Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==1,:);
								elseif strat==35 % Low Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==0,:);
								elseif strat==36 % Moderate Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:);
								elseif strat==37 % High Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==0,:);	
						elseif strat==100 % OBS-G
                                                        clear tmpyrb
                                                        if plt>=21 && plt<=23
                                                            tmp_exp=tmp_exp([BT_obsg';BT_obsg';BT_obsg';BT_obsg']==1,:,:);
                                                        else
                                                            tmp_exp=tmp_exp(BT_obsg==1,:,:);
                                                        end
                                                        tmpnm=identinittimesunique(BT_obsg'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==888
									clear tmpyrb
									numlist=[];
									for ins=1:size(identnewsub,1)
										tmpns=identnewsub(ins,:);
										for ins2=1:size(identinittimesunique,1)
											if strcmp(identinittimesunique(ins2,:),tmpns)==1
												numlist=[numlist ins2];
											end
										end
									end
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([numlist;numlist+size(identinittimesunique,1)*1;numlist+size(identinittimesunique,1)*2;numlist+size(identinittimesunique,1)*3],:,:);
									else
										tmp_exp=tmp_exp(numlist,:,:);
									end                  
									tmpnmbtcat=BT_cat1(numlist); tmpnm=identinittimesunique(numlist,:); tmpnm=tmpnm(~isnan(tmpnmbtcat)==1,:);
								end
								for tmp=1:size(identexp,1)
									l(tmp)=plot(1:size(tmp_exp,2),nanmean(tmp_exp(:,:,tmp),1),'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2);
								end           
								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end
								plot(-10:89,zeros(1,100),'Color',[.5 .5 .5],'linewidth',2);
								for tmp=1:size(identexp,1)
									sigtest=ttestsc(abs(tmp_exp(:,:,tmp)),abs(tmp_exp(:,:,tmpimp)),squeeze(scfactor(plt,tmp,:))','alpha',.05);
									sigtest_loc=find(sigtest==1);
									sigtest_exp=nanmean(tmp_exp(:,sigtest_loc,:),1);
									for tmpi=tmp
										plot(sigtest_loc,sigtest_exp(:,:,tmpi),'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',9)
									end
									sigtest=ttestsc(abs(tmp_exp(:,:,tmp)),abs(tmp_exp(:,:,tmpimp)),squeeze(scfactor(plt,tmp,:))','alpha',.1);
									sigtest_loc1=find(sigtest==1);
									sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
									sigtest_exp=nanmean(tmp_exp(:,sigtest_loc,:),1);
									for tmpi=tmp
										plot(sigtest_loc,sigtest_exp(:,:,tmpi),'o','Color','k','markersize',8,'markerfacecolor',identexpcolors(tmp,:))
									end
								end   
								set(gca,'plotboxaspectratio',[1 1 1])
								xlabel('Forecast Lead Time (h)','fontsize',20)
								ylabel(tmp_ytitle,'fontsize',20)
								set(gca,'fontsize',20)
								box on
								if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
									if mod(identmaxfhr*3,12)==0
										xlim([1 ((identmaxfhr*3))/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
									end
								else
									if mod(identmaxfhr*3-3,12)==0
										xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
									end
								end
								% YRANGE
								clear allquad
								allquad(1)=(max(max(nanmean((ne34err_exp(:,1:skip:end,:)),1))));
								allquad(2)=(max(max(nanmean((se34err_exp(:,1:skip:end,:)),1))));
								allquad(3)=(max(max(nanmean((nw34err_exp(:,1:skip:end,:)),1))));
								allquad(4)=(max(max(nanmean((sw34err_exp(:,1:skip:end,:)),1))));
								allquad(5)=(max(max(nanmean((ne50err_exp(:,1:skip:end,:)),1))));
								allquad(6)=(max(max(nanmean((se50err_exp(:,1:skip:end,:)),1))));
								allquad(7)=(max(max(nanmean((nw50err_exp(:,1:skip:end,:)),1))));
								allquad(8)=(max(max(nanmean((sw50err_exp(:,1:skip:end,:)),1))));
								allquad(9)=(max(max(nanmean((ne64err_exp(:,1:skip:end,:)),1))));
								allquad(10)=(max(max(nanmean((se64err_exp(:,1:skip:end,:)),1))));
								allquad(11)=(max(max(nanmean((nw64err_exp(:,1:skip:end,:)),1))));
								allquad(12)=(max(max(nanmean((sw64err_exp(:,1:skip:end,:)),1))));
								allquadmax=max(max(max(allquad)));
								allquadmin=min(min(min(allquad)));
								tmpvalq=max(abs(allquadmin),abs(allquadmax));
								if isnan(tmpvalq)==1
									tmpvalq=0;
								end
								if numel(num2str(tmpvalq))==3
									addfacq=100;
								elseif numel(num2str(tmpvalq))==2
									addfacq=20;
								else
									addfacq=20;
								end
								if numel(num2str(round(max(max(nanmean((tmp_exp0),1))))))==3
									addfac=100;
								elseif numel(num2str(round(max(max(nanmean((tmp_exp0),1))))))==2
									addfac=20;
								else
									addfac=20;
								end
								if plt<=3 || (plt>=16 && plt<=18) % -end-end
									tmpmin=min(min(nanmean((tmp_exp0),1)));
									tmpmax=max(max(nanmean((tmp_exp0),1)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
								elseif plt==19 || plt==20 % -end end 
									tmpmin=min(min(nanmean((tmp_exp0),1)));
									tmpmax=max(max(nanmean((tmp_exp0),1)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
								elseif (plt>=4 && plt<=15) || plt>=21%quad
									yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
								end
								ylim(yrange)
								set(gca,'xtick',1:skiptick:50)
								set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
								grid on
								set(gca,'gridcolor','k','gridalpha',.15)
								set(gca,'fontsize',20)      
								hold off
								box on
								lh=legend(l,identexpshort,'location','northeast');
								lh.FontSize=10;
								set(gcf,'Units','inches');
								a1Pos = get(gca,'Position');
								set(gcf, 'InvertHardcopy', 'off')
								set(gcf,'Units','inches');
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');                         
								tmpuv = size(tmpnm,1);                               
								tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
								if strat==1
								text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								else
								text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								end
								ax=gca;
								box on
								set(ax, 'Layer', 'bottom')
								ax.LineWidth=1; 
								set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
								set(gca,'Color',[.9 .9 .9])
								for tmp=1:size(identexp,1)
									cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
								end
								if sum([cntexp(:)])==0
									tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									set(tx, 'Layer', 'front')
								end
								if plt==1 || plt>=4 && plt<=15 || plt==17 || plt==18 || plt>20
									 tx=text(0.02,0.05,'Too Small','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.02,0.98,'Too Large','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')  
								elseif plt==2 || plt==16
									 tx=text(0.02,0.05,'Too Low','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.02,0.98,'Too High','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')  
								elseif plt==3
									 tx=text(0.02,0.05,'Too Slow','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.02,0.98,'Too Fast','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front') 
								elseif plt==19
									 tx=text(0.02,0.05,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.02,0.98,'Faster than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')            
								elseif plt==20
									 tx=text(0.02,0.05,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.02,0.98,'Right of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')            
								end
								b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
								set(b,'plotboxaspectratio',[1 1 1])
								set(b,'Color','none');
								set(b,'YColor','none');
								set(b,'tickdir','both')
								set(b,'XColor',[0 0 0]);
								set(b,'ytick',[]);
								if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
									if mod(identmaxfhr*3,12)==0
										xlim(b,[1 ((identmaxfhr*3))/skiphr+1])
										tmpxend=((identmaxfhr*3))/skiphr+1;
									else
										xlim(b,[1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
										tmpxend=((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1;
									end
								else
									if mod(identmaxfhr*3-3,12)==0
										xlim(b,[1 ((identmaxfhr*3)-3)/skiphr+1])
										tmpxend=((identmaxfhr*3)-3)/skiphr+1;
									else
										xlim(b,[1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
										tmpxend=((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1;
									end
								end        
								set(b,'xtick',[1:skiptick:50]);
								trkerr_exp_fcnt=zeros(1,tmpxend);            
								trkerr_exp_fcnt1=zeros(1,tmpxend);            
								trkerr_exp_fcnt2=zeros(1,tmpxend);
								for tmp=1:size(identexp,1)
									cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
								end
								set(gca,'fontsize',14)
								xlabel('# fcsts','Position',[-1 0],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',90,'units','normalized'); 
								set(gca,'position',[spPos(1)+.02 spPos(2)-.05 spPos(3) spPos(4)])
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								% Create a text box at every Tick label position
								maxmin=squeeze(sum(~isnan(tmp_exp(:,1:skiptick:end,:)),1)); 
								xTicks0 = get(gca, 'xticklabel');
								xTicks = get(gca, 'xtick');
								if size(maxmin,1)<size(xTicks0,1)
									for n=1:size(xTicks0,1)-size(maxmin,1)
										maxmin(end+n,:)=0;
									end
								end
								set(b,'xticklabels',[]);
								minY =0;
								VerticalOffset1=0.03;
								HorizontalOffset = 0.2;
								for xx = 1:size(xTicks0,1)
									tmptxt0=maxmin(xx,:);
									tmplines=size(tmptxt0,2);
									if size(unique(tmptxt0),2)==1
										tmptxt1=num2str(tmptxt0(1)); 
										text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)                    
									else
										for n=1:tmplines
											tmptxt1=[];                            
											tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(n,:)),'}',num2str(tmptxt0(n))];                           
											if n==1
												text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)
											else
												text(xTicks(xx), minY - (VerticalOffset1+(.02*(n-1))),tmptxt1,'horizontalalignment','center','fontsize',14)                                
											end
										end    
									end
								end
								f = getframe(hfig);
								if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
								close all
							end
							% Create Graphics: trk, int, spd errors and Skill - bt-gh vs. bt-deny
							for med=1:2; for plt=[2:18,21:23]
								spPosA=[0.1886    0.6118    0.6328    0.7000/2.2];
								spPosB=[0.1886    0.2300    0.6328    0.7000/2.2];
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax2=subplot(5,4,[9:16]);
								ax1=subplot(5,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkerr';
									 tmp_title='Track Error (km)';
									 tmp_ytitle='Error (km)';
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prserr';
									tmp_title='Pressure Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spderr';
									tmp_title='Wind Speed Error (m/s)';
									tmp_ytitle='Error (m/s)';
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFerr';
									tmp_title='RTSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFerr';
									tmp_title='RTSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFerr';
									tmp_title='RTSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFerr';
									tmp_title='RTSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFerr';
									tmp_title='RSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFerr';
									tmp_title='RSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFerr';
									tmp_title='RSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFerr';
									tmp_title='RSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFerr';
									tmp_title='RHF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFerr';
									tmp_title='RHF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFerr';
									tmp_title='RHF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFerr';
									tmp_title='RHF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poerr';
									tmp_title='Outer Clsd Isbr Prs Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roerr';
									tmp_title='Outer Clsd Isbr Rad Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwerr';
									tmp_title='RMW Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='ateerr';
									tmp_title='Along-Track Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[-500 500];                
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xteerr';
									tmp_title='Across-Track Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[-500 500]; 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFerr';
									tmp_title='RTSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFerr';
									tmp_title='RSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFerr';
									tmp_title='RHF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								tmp_exp0=tmp_exp;
								% Strat
								if strat==1
									clear tmpyrb
									tmpnm=identinittimesunique(~isnan(BT_cat1)==1,:);
								elseif strat==2
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_drops==1,:,:);
									end
									tmpnm=identinittimesunique(BT_drops'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==3
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_target';BT_target';BT_target';BT_target']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_target==1,:,:);
									end
									tmpnm=identinittimesunique(BT_target'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==4 % TD
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:,:);
									end
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:);
								elseif strat==5 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:,:);
									end 
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:);
								elseif strat==6 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:,:);
									end                  
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==7 % H345
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:,:);
									end     
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==8 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1>=30,:);
								elseif strat==9 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30,:);                                                    
								elseif strat==10 % RI
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>=15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>=15./1.94384 ,:);
								elseif strat==11 % IN
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:);
								elseif strat==12 % SS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<5./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:);
								elseif strat==13 % W
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:);
								elseif strat==14 % RW
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1<=-15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1<=-15./1.94384 ,:);													
								elseif strat==15 %% TD strat obs only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:,:);
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:);
								elseif strat==16 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:,:);
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:);
								elseif strat==17 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:,:);
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==18 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
								   else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:,:);
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==19 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30 & BT_drops'==1,:,:);
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==1,:);
								elseif strat==20 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30 & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==1,:);                                        
								elseif strat==21
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_drops==0,:,:);
									end
									tmpnm=identinittimesunique(BT_drops'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==22
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_target';BT_target';BT_target';BT_target']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_target==0,:,:);
									end
									tmpnm=identinittimesunique(BT_target'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==23 %% TD strat NOOBS only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:,:);
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:);
								elseif strat==24 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:,:);
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:);
								elseif strat==25 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:,:);
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==26 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
								   else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:,:);
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==27 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30 & BT_drops'==0,:,:);
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==0,:);
								elseif strat==28 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30 & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==0,:);
								elseif strat==29 % Low Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin,:);
								elseif strat==30 % Moderate Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin ,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:);
								elseif strat==31 % High Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin,:);
								elseif strat==32 % Low Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==1,:);
								elseif strat==33 % Moderate Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==1,:);
								elseif strat==34 % High Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==1,:);
								elseif strat==35 % Low Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==0,:);
								elseif strat==36 % Moderate Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:);
								elseif strat==37 % High Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==0,:);	
						elseif strat==100 % OBS-G
                                                        clear tmpyrb
                                                        if plt>=21 && plt<=23
                                                            tmp_exp=tmp_exp([BT_obsg';BT_obsg';BT_obsg';BT_obsg']==1,:,:);
                                                        else
                                                            tmp_exp=tmp_exp(BT_obsg==1,:,:);
                                                        end
                                                        tmpnm=identinittimesunique(BT_obsg'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==888
									clear tmpyrb
									numlist=[];
									for ins=1:size(identnewsub,1)
										tmpns=identnewsub(ins,:);
										for ins2=1:size(identinittimesunique,1)
											if strcmp(identinittimesunique(ins2,:),tmpns)==1
												numlist=[numlist ins2];
											end
										end
									end
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([numlist;numlist+size(identinittimesunique,1)*1;numlist+size(identinittimesunique,1)*2;numlist+size(identinittimesunique,1)*3],:,:);
									else
										tmp_exp=tmp_exp(numlist,:,:);
									end                  
									tmpnmbtcat=BT_cat1(numlist); tmpnm=identinittimesunique(numlist,:); tmpnm=tmpnm(~isnan(tmpnmbtcat)==1,:); 
								end                                                       
								for tmp=1:size(identexp,1)
									if med==1; l(tmp)=plot(1:size(tmp_exp,2),nanmean(tmp_exp(:,:,tmp),1),'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2); elseif med==2; l(tmp)=plot(1:size(tmp_exp,2),nanmedian(tmp_exp(:,:,tmp),1),'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2); end;
								end           
								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end

								plot(-10:89,zeros(1,100),'Color',[.5 .5 .5],'linewidth',2);
								for tmp=1:size(identexp,1)
									sigtest=ttestsc(tmp_exp(:,:,tmp),tmp_exp(:,:,tmpimp),squeeze(scfactor(plt,tmp,:))','alpha',.05);
									sigtest_loc=find(sigtest==1);
									if med==1; sigtest_exp=nanmean(tmp_exp(:,sigtest_loc,:),1); elseif med==2; sigtest_exp=nanmedian(tmp_exp(:,sigtest_loc,:),1); end;
									for tmpi=tmp
										plot(sigtest_loc,sigtest_exp(:,:,tmpi),'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',8)
									end
									sigtest=ttestsc(tmp_exp(:,:,tmp),tmp_exp(:,:,tmpimp),squeeze(scfactor(plt,tmp,:))','alpha',.1);
									sigtest_loc1=find(sigtest==1);
									sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
									if med==1; sigtest_exp=nanmean(tmp_exp(:,sigtest_loc,:),1); elseif med==2; sigtest_exp=nanmedian(tmp_exp(:,sigtest_loc,:),1); end;
									for tmpi=tmp
										plot(sigtest_loc,sigtest_exp(:,:,tmpi),'o','Color','k','markersize',6,'markerfacecolor',identexpcolors(tmp,:))
									end
								end   
								set(ax1,'position',spPosA)
								ylabel(tmp_ytitle,'fontsize',20)
								set(gca,'fontsize',20)
								box on
								if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
									if mod(identmaxfhr*3,12)==0
										xlim([1 ((identmaxfhr*3))/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
									end
								else
									if mod(identmaxfhr*3-3,12)==0
										xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
									end
								end
								 % YRANGE
								clear allquad
								allquad(1)=(max(max(nanmean(abs(ne34err_exp(:,1:skip:end,:)),1))));
								allquad(2)=(max(max(nanmean(abs(se34err_exp(:,1:skip:end,:)),1))));
								allquad(3)=(max(max(nanmean(abs(nw34err_exp(:,1:skip:end,:)),1))));
								allquad(4)=(max(max(nanmean(abs(sw34err_exp(:,1:skip:end,:)),1))));
								allquad(5)=(max(max(nanmean(abs(ne50err_exp(:,1:skip:end,:)),1))));
								allquad(6)=(max(max(nanmean(abs(se50err_exp(:,1:skip:end,:)),1))));
								allquad(7)=(max(max(nanmean(abs(nw50err_exp(:,1:skip:end,:)),1))));
								allquad(8)=(max(max(nanmean(abs(sw50err_exp(:,1:skip:end,:)),1))));
								allquad(9)=(max(max(nanmean(abs(ne64err_exp(:,1:skip:end,:)),1))));
								allquad(10)=(max(max(nanmean(abs(se64err_exp(:,1:skip:end,:)),1))));
								allquad(11)=(max(max(nanmean(abs(nw64err_exp(:,1:skip:end,:)),1))));
								allquad(12)=(max(max(nanmean(abs(sw64err_exp(:,1:skip:end,:)),1))));
								allquadmax=max(max(max(allquad)));
								allquadmin=min(min(min(allquad)));
								tmpvalq=max(abs(allquadmin),abs(allquadmax));
								if isnan(tmpvalq)==1
									tmpvalq=0;
								end
								if numel(num2str(tmpvalq))==3
									addfacq=100;
								elseif numel(num2str(tmpvalq))==2
									addfacq=20;
								else 
									addfacq=20;
								end
								if numel(num2str(round(max(max(nanmean((tmp_exp0),1))))))==3
									addfac=100;
								elseif numel(num2str(round(max(max(nanmean((tmp_exp0),1))))))==2
									addfac=20;
								else
									addfac=20;
								end
								if plt<=3 || (plt>=16 && plt<=18) % 0-end
									tmpmin=min(min(nanmean((tmp_exp0),1)));
									tmpmax=max(max(nanmean((tmp_exp0),1)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[0 round((tmpval+addfac)/10)*10];                
								elseif plt==19 || plt==20 % -end end 
									tmpmin=min(min(nanmean((tmp_exp0),1)));
									tmpmax=max(max(nanmean((tmp_exp0),1)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
								elseif (plt>=4 && plt<=15) || plt>=21%quad
									yrange=[0 round((tmpvalq+addfacq)/10)*10];
								end
								ylim(yrange)
								set(gca,'xtick',1:skiptick:50)
								set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
								set(gca,'xticklabel',[]) 
								grid on
								set(gca,'gridcolor','k','gridalpha',.15)
								set(gca,'fontsize',20)      
								hold off
								box on
								lh=legend(l,identexpshort,'location','northeast');
								lh.FontSize=10;
								set(gcf,'Units','inches');
								a1Pos = get(gca,'Position');
								set(gcf, 'InvertHardcopy', 'off')
								set(gcf,'Units','inches');
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								if med==1;text(0,1.145,['\textbf{Mean ',tmp_title,' \& Skill (\%)}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');elseif med==2;text(0,1.145,['\textbf{Median ',tmp_title,' \& Skill (\%)}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');end;    
								text(1,1.07,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');                                                                  
								tmpuv = size(tmpnm,1);                               
								tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];
								if strat==1
								text(0,1.07,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								else
								text(0,1.07,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								end
								box on
								set(ax1, 'Layer', 'bottom')
								ax1.LineWidth=1; 
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
								set(ax1,'Color',[.9 .9 .9])
								for tmp=1:size(identexp,1)
									cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
								end
								if sum([cntexp(:)])==0
									tx=text(0.99,0.1,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									set(tx, 'Layer', 'front')
								end          
								if plt==19
									 tx=text(0.01,0.1,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.01,0.965,'Faster than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')            
								elseif plt==20
									 tx=text(0.01,0.1,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.01,0.965,'Right of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 set(tx, 'Layer', 'front')            
								end
								ax2=subplot(5,4,[9:16]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkerrskill';
									 tmp_title='Track Skill (\%)';
									 tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									 yrange=[-20 20];
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prserrskill';
									tmp_title='Pressure Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spderrskill';
									tmp_title='Wind Speed Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFerrskill';
									tmp_title='RTSF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFerrskill';
									tmp_title='RTSF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFerrskill';
									tmp_title='RTSF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFerrskill';
									tmp_title='RTSF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFerrskill';
									tmp_title='RSF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFerrskill';
									tmp_title='RSF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFerrskill';
									tmp_title='RSF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFerrskill';
									tmp_title='RSF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFerrskill';
									tmp_title='RHF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFerrskill';
									tmp_title='RHF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFerrskill';
									tmp_title='RHF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFerrskill';
									tmp_title='RHF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poerrskill';
									tmp_title='Outer Clsd Isbr Prs Skill (hPa)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roerrskill';
									tmp_title='Outer Clsd Isbr Rad Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwerrskill';
									tmp_title='RMW Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='ateerrskill';
									tmp_title='Along-Track Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xteerrskill';
									tmp_title='Across-Track Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFerrskill';
									tmp_title='RTSF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFerrskill';
									tmp_title='RSF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFerrskill';
									tmp_title='RHF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								tmp_exp0=squeeze(100.*(1-abs(nanmean(tmp_exp(:,:,:),1))./abs(nanmean(tmp_exp(:,:,tmpimp),1))));               													
								
								% Strat
								if strat==1
									clear tmpyrb
									tmpnm=identinittimesunique(~isnan(BT_cat1)==1,:);
								elseif strat==2
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_drops==1,:,:);
									end
									tmpnm=identinittimesunique(BT_drops'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==3
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_target';BT_target';BT_target';BT_target']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_target==1,:,:);
									end
									tmpnm=identinittimesunique(BT_target'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==4 % TD
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:,:);
									end
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:);
								elseif strat==5 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:,:);
									end 
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:);
								elseif strat==6 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:,:);
									end                  
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==7 % H345
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1 ,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:,:);
									end     
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==8 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1>=30,:);
								elseif strat==9 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30,:);                                                    
								elseif strat==10 % RI
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>=15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>=15./1.94384 ,:);
								elseif strat==11 % IN
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:);
								elseif strat==12 % SS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<5./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:);
								elseif strat==13 % W
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:);
								elseif strat==14 % RW
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-15./1.94384 ,:,:);
									else
										tmp_exp=tmp_exp(BT_intch1<=-15./1.94384 ,:,:);
									end     
									tmpnm=identinittimesunique(BT_intch1<=-15./1.94384 ,:);													
								elseif strat==15 %% TD strat obs only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:,:);
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:);
								elseif strat==16 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:,:);
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:);
								elseif strat==17 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:,:);
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==18 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
								   else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:,:);
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==19 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30 & BT_drops'==1,:,:);
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==1,:);
								elseif strat==20 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30 & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==1,:);                                        
								elseif strat==21
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_drops==0,:,:);
									end
									tmpnm=identinittimesunique(BT_drops'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==22
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_target';BT_target';BT_target';BT_target']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_target==0,:,:);
									end
									tmpnm=identinittimesunique(BT_target'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==23 %% TD strat NOOBS only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:,:);
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:);
								elseif strat==24 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:,:);
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:);
								elseif strat==25 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:,:);
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==26 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
								   else
										tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:,:);
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==27 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1>=30 & BT_drops'==0,:,:);
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==0,:);
								elseif strat==28 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_lat1<30 & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==0,:);
								elseif strat==29 % Low Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin,:);
								elseif strat==30 % Moderate Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin ,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:);
								elseif strat==31 % High Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin,:);
								elseif strat==32 % Low Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==1,:);
								elseif strat==33 % Moderate Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==1,:);
								elseif strat==34 % High Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin & BT_drops'==1,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==1,:);
								elseif strat==35 % Low Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1<LOWbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==0,:);
								elseif strat==36 % Moderate Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:);
								elseif strat==37 % High Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
									else
										tmp_exp=tmp_exp(BT_shr1>HIGHbasin & BT_drops'==0,:,:);
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==0,:);	
						elseif strat==100 % OBS-G
                                                        clear tmpyrb
                                                        if plt>=21 && plt<=23
                                                            tmp_exp=tmp_exp([BT_obsg';BT_obsg';BT_obsg';BT_obsg']==1,:,:);
                                                        else
                                                            tmp_exp=tmp_exp(BT_obsg==1,:,:);
                                                        end
                                                        tmpnm=identinittimesunique(BT_obsg'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==888
									clear tmpyrb
									numlist=[];
									for ins=1:size(identnewsub,1)
										tmpns=identnewsub(ins,:);
										for ins2=1:size(identinittimesunique,1)
											if strcmp(identinittimesunique(ins2,:),tmpns)==1
												numlist=[numlist ins2];
											end
										end
									end
									if plt>=21 && plt<=23
										tmp_exp=tmp_exp([numlist;numlist+size(identinittimesunique,1)*1;numlist+size(identinittimesunique,1)*2;numlist+size(identinittimesunique,1)*3],:,:);
									else
										tmp_exp=tmp_exp(numlist,:,:);
									end                  
									tmpnmbtcat=BT_cat1(numlist); tmpnm=identinittimesunique(numlist,:); tmpnm=tmpnm(~isnan(tmpnmbtcat)==1,:); 
								end                                                       
								
								
								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end      
								tmpu=1:size(identexp,1);
								tmpu(tmpu==tmpimp)=[];
								plot(-10:89,zeros(1,100),'Color',[.5 .5 .5],'linewidth',2);
								for tmp=[tmpimp,tmpu]
									if med==1; imprv=100.*(1-abs(nanmean(tmp_exp(:,:,tmp),1))./abs(nanmean(tmp_exp(:,:,tmpimp),1)));   elseif med==2; imprv=100.*(1-abs(nanmedian(tmp_exp(:,:,tmp),1))./abs(nanmedian(tmp_exp(:,:,tmpimp),1))); end;                
									imprv2(:,tmp)=imprv;
									l(tmp)=plot(1:size(imprv,2),imprv,'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2); 
									sigtest=ttestsc(tmp_exp(:,:,tmp),tmp_exp(:,:,tmpimp),squeeze(scfactor(plt,tmp,:))','alpha',.05);
									sigtest_loc=find(sigtest==1);
									sigtest_exp=imprv(sigtest_loc);
									plot(sigtest_loc,sigtest_exp,'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',8)
									sigtest=ttestsc(tmp_exp(:,:,tmp),tmp_exp(:,:,tmpimp),squeeze(scfactor(plt,tmp,:))','alpha',.1);
									sigtest_loc1=find(sigtest==1);
									sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
									sigtest_exp=imprv(sigtest_loc);
									plot(sigtest_loc,sigtest_exp,'o','Color','k','markersize',6,'markerfacecolor',identexpcolors(tmp,:))
								end   
								xlabel('Forecast Lead Time (h)','fontsize',20)
								ylabel('Skill (%)','fontsize',20)
								set(gca,'fontsize',20)
								box on
								if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
									if mod(identmaxfhr*3,12)==0
										xlim([1 ((identmaxfhr*3))/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
									end
								else
									if mod(identmaxfhr*3-3,12)==0
										xlim([1 ((identmaxfhr*3)-3)/skiphr+1])
									else
										xlim([1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
									end
								end
								% YRANGE
								clear allquad imprv3
								imprv3(:,:,1)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,2)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,3)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,4)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,5)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,6)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,7)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,8)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,9)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,10)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,11)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
								imprv3(:,:,12)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
								allquadmax=max(max(max(imprv3)));
								allquadmin=min(min(min(imprv3)));
								tmpvalq=max(abs(allquadmin),abs(allquadmax));
								if isnan(tmpvalq)==1
									tmpvalq=0;
								end
								if numel(num2str(tmpvalq))==3
									addfacq=100;
								elseif numel(num2str(tmpvalq))==2
									addfacq=20;
								else
									addfacq=20;
								end

								if numel(num2str(round(max(tmp_exp0(:)))))==3
									addfac=100;
								elseif numel(num2str(round(max(tmp_exp0(:)))))==2
									addfac=20;
								else
									addfac=20;
								end
								if plt<=3 || (plt>=16 && plt<=18) % 0-end
									tmpmin=min(tmp_exp0(:));
									tmpmax=max(tmp_exp0(:));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									if tmpval>250
										yrange=[-250 250];
									else
										yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
									end
								elseif plt==19 || plt==20 % -end end 
									tmpmin=min(tmp_exp0(:));
									tmpmax=max(tmp_exp0(:));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									if tmpval>250
										yrange=[-250 250];
									else
										yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
									end
								elseif (plt>=4 && plt<=15) || plt>=21%quad 
									if tmpvalq>250
										yrange=[-250 250];
									else
										yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
									end
								end											
								ylim(yrange)
								if yrange(end)>=200
									set(gca,'ytick',yrange(1):100:yrange(end))
								elseif yrange(end)>=100
									set(gca,'ytick',yrange(1):50:yrange(end))
								elseif yrange(end)>=50
									set(gca,'ytick',yrange(1):20:yrange(end))
								else
									set(gca,'ytick',yrange(1):10:yrange(end))
								end
								set(gca,'xtick',1:skiptick:50)
								set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
								grid on
								set(gca,'gridcolor','k','gridalpha',.15)
								set(gca,'fontsize',20)      
								hold off
								box on
								set(gcf,'Units','inches');
								a1Pos = get(gca,'Position');
								set(gcf, 'InvertHardcopy', 'off')
								set(gcf,'Units','inches');
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								box on
								set(ax2, 'Layer', 'bottom')
								ax2.LineWidth=1;
								set(ax2,'position',spPosB)
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
								set(ax2,'Color',[.9 .9 .9])            													
								% Mean Value            
								tmpstr=['Mean: '];
								tmpstrmean=1:size(imprv2,2);
								tmpstrmean(tmpstrmean==tmpimp)=[];
								for tmp=tmpstrmean
									if tmp==tmpstrmean(end)
										tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(imprv2(1:(identmaxfhr+1)/2,tmp)),2)),'%'];
									else
										tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(imprv2(1:(identmaxfhr+1)/2,tmp)),2)),'% \color[rgb]{0,0,0}| '];
									end
								end
								if sum(sum(~isnan(imprv2)))==0
									tx=text(0.99,0.1,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									set(tx, 'Layer', 'front')          
								else
									tx=text(0.99,0.1,tmpstr,'HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									set(tx, 'Layer', 'front')
								end 
								b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
								set(b,'Color','none');
								set(b,'YColor','none');
								set(b,'tickdir','both')
								set(b,'XColor',[0 0 0]);
								set(b,'ytick',[]);
								if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
									if mod(identmaxfhr*3,12)==0
										xlim(b,[1 ((identmaxfhr*3))/skiphr+1])
										tmpxend=((identmaxfhr*3))/skiphr+1;
									else
										xlim(b,[1 ((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1]) 
										tmpxend=((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1;
									end
								else
									if mod(identmaxfhr*3-3,12)==0
										xlim(b,[1 ((identmaxfhr*3)-3)/skiphr+1])
										tmpxend=((identmaxfhr*3)-3)/skiphr+1;
									else
										xlim(b,[1 ((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1]) 
										tmpxend=((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1;
									end
								end        
								set(b,'xtick',[1:skiptick:50]); 
								trkerr_exp_fcnt=zeros(1,tmpxend);            
								trkerr_exp_fcnt1=zeros(1,tmpxend);            
								trkerr_exp_fcnt2=zeros(1,tmpxend);
								for tmp=1:size(identexp,1)
									cntexp(:,tmp)=sum(~isnan(tmp_exp(:,1:skiptick:end,tmp)),1);
								end
								set(gca,'fontsize',14)
								xlabel('# fcsts','Position',[-1 0],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',90,'units','normalized'); 
								set(gca,'position',[spPosB(1) spPosB(2)-.1 spPosB(3) spPosB(4)])
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								% Create a text box at every Tick label position
								maxmin=squeeze(sum(~isnan(tmp_exp(:,1:skiptick:end,:)),1)); 
								xTicks0 = get(gca, 'xticklabel');
								xTicks = get(gca, 'xtick');
								if size(maxmin,1)<size(xTicks0,1)
									for n=1:size(xTicks0,1)-size(maxmin,1)
										maxmin(end+n,:)=0;
									end
								end
								set(b,'xticklabels',[]);
								minY =0;
								VerticalOffset1=0.07;
								HorizontalOffset = 0.2;
								for xx = 1:size(xTicks0,1)
									tmptxt0=maxmin(xx,:);
									tmplines=size(tmptxt0,2);
									if size(unique(tmptxt0),2)==1
										tmptxt1=num2str(tmptxt0(1)); 
										text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)                    
									else
										for n=1:tmplines
											tmptxt1=[];                            
											tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(n,:)),'}',num2str(tmptxt0(n))];                           
											if n==1
												text(xTicks(xx), minY - VerticalOffset1,tmptxt1,'horizontalalignment','center','fontsize',14)
											else
												text(xTicks(xx), minY - (VerticalOffset1+(.05*(n-1))),tmptxt1,'horizontalalignment','center','fontsize',14)                                
											end
										end    
									end
								end
								f = getframe(hfig);
								if med==1;if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname,'_mean'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;elseif med==2; if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname,'_median'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;end;
								close all
							end; end;																	
							
							spPos=[0.11 0.13+.05 0.75 0.75-.05]; % arrange plots the same
							% Create Graphics: trk, int, spd errors - bt-gh vs. bt-deny
							for plt=1:23
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax1=subplot(3,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkerr';
									 tmp_title='Track Error (km)';
									 tmp_ytitle='Error (km)';
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prserr';
									tmp_title='Pressure Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spderr';
									tmp_title='Wind Speed Error (m/s)';
									tmp_ytitle='Error (m/s)';
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFerr';
									tmp_title='RTSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFerr';
									tmp_title='RTSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFerr';
									tmp_title='RTSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFerr';
									tmp_title='RTSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFerr';
									tmp_title='RSF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFerr';
									tmp_title='RSF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFerr';
									tmp_title='RSF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFerr';
									tmp_title='RSF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFerr';
									tmp_title='RHF NEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFerr';
									tmp_title='RHF SEQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFerr';
									tmp_title='RHF SWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFerr';
									tmp_title='RHF NWQ Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 200];
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poerr';
									tmp_title='Outer Clsd Isbr Prs Error (hPa)';
									tmp_ytitle='Error (hPa)';
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roerr';
									tmp_title='Outer Clsd Isbr Rad Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwerr';
									tmp_title='RMW Error (km)';
									tmp_ytitle='Error (km)';
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='trkbias1';
									tmp_title='Along-Track Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-500 500];                
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='trkbias2';
									tmp_title='Across-Track Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-500 500]; 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFerr';
									tmp_title='RTSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFerr';
									tmp_title='RSF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFerr';
									tmp_title='RHF Error (km)';
									tmp_ytitle='Error (km)';
									yrange=[0 100];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								tmp_exp0=tmp_exp;
								% Strat
								if strat==1
									clear tmpyrb
									tmpnm=identinittimesunique(~isnan(BT_cat1)==1,:);
								elseif strat==2
									clear tmpyrb
									if plt>=21 && plt<=23
										 tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										 tmp_exp(BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_drops'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==3
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_target';BT_target';BT_target';BT_target']==0,:,:)=NaN;
									else
										tmp_exp(BT_target'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_target'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==4 % TD
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:);
								elseif strat==5 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384,:,:)=NaN;
									end 
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:);
								elseif strat==6 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 ,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0,:,:)=NaN;
									end                  
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==7 % H345
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==8 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1>=30,:);
								elseif strat==9 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30,:,:)=NaN;
									else
										tmp_exp(BT_lat1>=30,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30,:);
								elseif strat==10 % RI
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>=15./1.94384 ,:);
								elseif strat==11 % IN
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<5./1.94384  | BT_intch1>=15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:);
								elseif strat==12 % SS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=5./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<=-5./1.94384  | BT_intch1>=5./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:);
								elseif strat==13 % W
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1>-5./1.94384  | BT_intch1<=-15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:);
								elseif strat==14 % RW
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1>-15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1<=-15./1.94384 ,:);
								elseif strat==15 %% TD strat obs only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0 | BT_drops'==0,:,:)=NaN;
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:);
								elseif strat==16 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384 | BT_drops'==0,:,:)=NaN;
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:);
								elseif strat==17 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0  | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==0,:,:)=NaN;
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==18 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
								   else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0| BT_drops'==0,:,:)=NaN;
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==19 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30 | BT_drops'==0,:,:)=NaN;
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==1,:);
								elseif strat==20 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										 tmp_exp(BT_lat1>=30 | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==1,:);
								elseif strat==21
									clear tmpyrb
									if plt>=21 && plt<=23
										 tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										 tmp_exp(BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_drops'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==22
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_target';BT_target';BT_target';BT_target']==1,:,:)=NaN;
									else
										tmp_exp(BT_target'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_target'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==23 %% TD strat obs only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0 | BT_drops'==1,:,:)=NaN;
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:);
								elseif strat==24 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384 | BT_drops'==1,:,:)=NaN;
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:);
								elseif strat==25 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0  | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==1,:,:)=NaN;
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==26 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
								   else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==1,:,:)=NaN;
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==27 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30 | BT_drops'==1,:,:)=NaN;
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==0,:);
								elseif strat==28 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										 tmp_exp(BT_lat1>=30 | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==0,:);
								elseif strat==29 % Low Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin,:);
								elseif strat==30 % Moderate Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin ,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:);
								elseif strat==31 % High Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin,:);
								elseif strat==32 % Low Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==1,:);
								elseif strat==33 % Moderate Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin | BT_drops'==1,:);
								elseif strat==34 % High Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==1,:);
								elseif strat==35 % Low Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==0,:);
								elseif strat==36 % Moderate Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:);
								elseif strat==37 % High Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==0,:);	
						elseif strat==100
                                                        clear tmpyrb
                                                        if plt>=21 && plt<=23
                                                             tmp_exp([BT_obsg';BT_obsg';BT_obsg';BT_obsg']==0,:,:)=NaN;
                                                        else
                                                             tmp_exp(BT_obsg'==0,:,:)=NaN;
                                                        end
                                                        tmpnm=identinittimesunique(BT_obsg'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==888
									clear tmpyrb
									numlist=[];
									for ins=1:size(identnewsub,1)
										tmpns=identnewsub(ins,:);
										for ins2=1:size(identinittimesunique,1)
											if strcmp(identinittimesunique(ins2,:),tmpns)==1
												numlist=[numlist ins2];
											else
											end
										end
									end
									[a_ns,b_ns]=histcounts(numlist,.5:1:size(identinittimesunique,1)+.5);
									numlist=a_ns';
									numlist(numlist>0)=1;
									if plt>=21 && plt<=23
										tmp_exp([numlist;numlist+size(identinittimesunique,1)*1;numlist+size(identinittimesunique,1)*2;numlist+size(identinittimesunique,1)*3]==0,:,:)=NaN;
									else
										tmp_exp(numlist==0,:,:)=NaN;
									end                  
									tmpnm=identinittimesunique(numlist==1 & ~isnan(BT_cat1)==1,:);     
								end


								for tmp=1:size(identexp,1)
									l(tmp)=plot(nanmean(tmp_exp(:,:,tmp),2),1:size(tmp_exp(:,:,tmp),1),'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2);
								end     
								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end
								plot(zeros(1,100),-10:89,'Color',[.5 .5 .5],'linewidth',2);
								for tmp=1:size(identexp,1)
									%sigtest=ttestsc(tmp_exp(:,:,tmp)',tmp_exp(:,:,tmpimp)',squeeze(scfactor(plt,tmp,:))','alpha',.05);
									%sigtest_loc=find(sigtest==1);
									%sigtest_exp=nanmean(tmp_exp(sigtest_loc,:,:),2);
									%for tmpi=tmp
									%    plot(sigtest_exp(:,:,tmpi),sigtest_loc,'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',9)
									%end                
									%sigtest=ttestsc(tmp_exp(:,:,tmp)',tmp_exp(:,:,tmpimp)',squeeze(scfactor(plt,tmp,:))','alpha',.1);
									%sigtest_loc1=find(sigtest==1);
									%sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
									%sigtest_exp=nanmean(tmp_exp(sigtest_loc,:,:),2);
									%for tmpi=tmp
									%    plot(sigtest_exp(:,:,tmpi),sigtest_loc,'o','Color','k','markersize',8,'markerfacecolor',identexpcolors(tmp,:))
									%end
								end  
								set(gca,'plotboxaspectratio',[1 1 1])
								ylabel('Cycle Initialization Time','fontsize',20)
								xlabel(tmp_ytitle,'fontsize',20)
								set(gca,'fontsize',20)
								box on
								xstart=1;          
								ylim([xstart-.5 size(BT_lat,1)+.5])
								% YRANGE
								clear allquad
								allquad(1)=(max(max(nanmean(abs(ne34err_exp(:,1:skip:end,:)),2))));
								allquad(2)=(max(max(nanmean(abs(se34err_exp(:,1:skip:end,:)),2))));
								allquad(3)=(max(max(nanmean(abs(nw34err_exp(:,1:skip:end,:)),2))));
								allquad(4)=(max(max(nanmean(abs(sw34err_exp(:,1:skip:end,:)),2))));
								allquad(5)=(max(max(nanmean(abs(ne50err_exp(:,1:skip:end,:)),2))));
								allquad(6)=(max(max(nanmean(abs(se50err_exp(:,1:skip:end,:)),2))));
								allquad(7)=(max(max(nanmean(abs(nw50err_exp(:,1:skip:end,:)),2))));
								allquad(8)=(max(max(nanmean(abs(sw50err_exp(:,1:skip:end,:)),2))));
								allquad(9)=(max(max(nanmean(abs(ne64err_exp(:,1:skip:end,:)),2))));
								allquad(10)=(max(max(nanmean(abs(se64err_exp(:,1:skip:end,:)),2))));
								allquad(11)=(max(max(nanmean(abs(nw64err_exp(:,1:skip:end,:)),2))));
								allquad(12)=(max(max(nanmean(abs(sw64err_exp(:,1:skip:end,:)),2))));
								allquadmax=max(max(max(allquad)));
								allquadmin=min(min(min(allquad)));
								tmpvalq=max(abs(allquadmin),abs(allquadmax));
								if isnan(tmpvalq)==1
									tmpvalq=0;
								end
								if numel(num2str(tmpvalq))==3
									addfacq=100;
								elseif numel(num2str(tmpvalq))==2
									addfacq=20;
								else
									addfacq=20;
								end
								if numel(num2str(round(max(max(nanmean((tmp_exp0),2))))))==3
									addfac=100;
								elseif numel(num2str(round(max(max(nanmean((tmp_exp0),2))))))==2
									addfac=20;
								else
									addfac=20;
								end
								if plt<=3 || (plt>=16 && plt<=18) % 0-end
									tmpmin=min(min(nanmean((tmp_exp0),2)));
									tmpmax=max(max(nanmean((tmp_exp0),2)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
										if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[0 round((tmpval+addfac)/10)*10];                                
								elseif plt==19 || plt==20 % -end end 
									tmpmin=min(min(nanmean((tmp_exp0),2)));
									tmpmax=max(max(nanmean((tmp_exp0),2)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];                
								elseif (plt>=4 && plt<=15) || plt>=21%quad
									yrange=[0 round((tmpvalq+addfacq)/10)*10];
								end
								xlim(yrange)
								if size(identinittimesunique,1)>50
									set(gca,'ytick',1:4:100)
									set(gca,'yticklabel',identinittimesunique(1:4:end,:))
								else
									set(gca,'ytick',1:2:100)
									set(gca,'yticklabel',identinittimesunique(1:2:end,:))
								end  
								grid on
								set(gca,'gridcolor','k','gridalpha',.15)
								set(gca,'fontsize',20)      
								hold off
								box on
								lh=legend(l,identexpshort,'location','northeast');
								lh.FontSize=10;
								set(gcf,'Units','inches');
								a1Pos = get(gca,'Position');
								set(gcf, 'InvertHardcopy', 'off')
								set(gcf,'Units','inches');
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')
								text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')    
								text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');                
								tmpuv = size(tmpnm,1);                               
								tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
								if strat==1
								text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								else
								text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								end
								ax=gca;
								box on
								set(ax, 'Layer', 'bottom')
								ax.LineWidth=1; 
								set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .85, 0.96]); % maximize figure window
								set(gca,'Color',[.9 .9 .9])
								clear cntexp
								for tmp=1:size(identexp,1)
									cntexp(:,tmp)=sum(~isnan(tmp_exp(:,:,tmp)),2);
								end
								if sum([cntexp(:)])==0
									tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									set(tx, 'Layer', 'front')
								end   
								if plt==19
									 tx=text(0.02,0.05,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.98,0.05,'Faster than BT','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
								elseif plt==20
									 tx=text(0.02,0.05,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
									 tx=text(0.98,0.05,'Right of BT','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
								end
								axis ij;b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
								yyaxis left
								set(b,'YColor','none');
								yyaxis right
								set(b,'plotboxaspectratio',[1 1 1])
								set(b,'Color','none');
								set(b,'XColor','none');
								set(b,'tickdir','both')
								set(b,'YColor',[0 0 0]);
								set(b,'xtick',[]);
								ylim(b,[xstart-.5 size(BT_lat,1)+.5])
								tmpxend=size(BT_lat,1);
								if size(identinittimesunique,1)>50
									set(b,'ytick',[1:4:100]); 
								else
									set(b,'ytick',[1:2:100]); 
								end  
								trkerr_exp_fcnt=zeros(1,tmpxend);            
								trkerr_exp_fcnt1=zeros(1,tmpxend);            
								trkerr_exp_fcnt2=zeros(1,tmpxend);
								clear cntexp
								for tmp=1:size(identexp,1)
									cntexp(:,tmp)=sum(~isnan(tmp_exp(:,:,tmp)),2);
								end
								set(gca,'fontsize',12)
								xL=xlim;
								yL=ylim;
								ylabel({'# 6-h','fcsts'},'Position',[xL(2) yL(2)],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',0); 
								set(gca,'position',[spPos(1)+.08 spPos(2)+.05 spPos(3) spPos(4)])
								screenposition = get(gcf,'Position');
								set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
								set(gcf, 'InvertHardcopy', 'off')            
								% Create a text box at every Tick label position
								maxmin=squeeze(sum(~isnan(tmp_exp(:,:,:)),2)); 
								if size(identinittimesunique,1)>50
									maxmin=maxmin(1:4:end,:); 
								else
									maxmin=maxmin(1:2:end,:); 
								end
								yTicks0 = get(gca, 'yticklabel');
								yTicks = get(gca, 'ytick');
								set(b,'yticklabels',[]);
								minX =1;
								HorizontalOffset1=0.03;
								VerticalOffset = 0.2;
								for xx = 1:size(yTicks0,1)
									tmptxt0=maxmin(xx,:);
									tmptxt1=[];
									if size(unique(tmptxt0),2)==1
										tmptxt1=num2str(tmptxt0(1));
									else
										for xxx=1:size(maxmin,2)
											  if xxx==size(maxmin,2)
												  tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(xxx,:)),'}',num2str(tmptxt0(xxx))];
											  else
												  tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(xxx,:)),'}',num2str(tmptxt0(xxx)),'\color[rgb]{0,0,0}/'];
											  end
										end
									end
									text(minX+HorizontalOffset1,yTicks(xx),tmptxt1,'verticalalignment','middle','fontsize',12)
								end
								axis ij;f = getframe(hfig);
								if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname,'_cycles'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
								close all
							end   
							% Create Graphics: trk, int, spd Skill vs. deny
							for plt=[1:18,21:23]
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax1=subplot(3,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkskill';
									 tmp_title='Track Skill (\%)';
									 tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									 yrange=[-20 20];
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prskill';
									tmp_title='Pressure Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spdskill';
									tmp_title='Wind Speed Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFskill';
									tmp_title='RTSF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFskill';
									tmp_title='RTSF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFskill';
									tmp_title='RTSF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFskill';
									tmp_title='RTSF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFskill';
									tmp_title='RSF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFskill';
									tmp_title='RSF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFskill';
									tmp_title='RSF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFskill';
									tmp_title='RSF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFskill';
									tmp_title='RHF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFskill';
									tmp_title='RHF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFskill';
									tmp_title='RHF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFskill';
									tmp_title='RHF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poskill';
									tmp_title='Outer Clsd Isbr Prs Skill (hPa)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roskill';
									tmp_title='Outer Clsd Isbr Rad Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwskill';
									tmp_title='RMW Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='ateskill';
									tmp_title='Along-Track Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xteskill';
									tmp_title='Across-Track Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFskill';
									tmp_title='RTSF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFskill';
									tmp_title='RSF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFskill';
									tmp_title='RHF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								tmp_exp0=squeeze(100.*(1-abs(nanmean(tmp_exp(:,:,:),2))./abs(nanmean(tmp_exp(:,:,tmpimp),2))));                  

																	% Strat
								if strat==1
									clear tmpyrb
									tmpnm=identinittimesunique(~isnan(BT_cat1)==1,:);
								elseif strat==2
									clear tmpyrb
									if plt>=21 && plt<=23
										 tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										 tmp_exp(BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_drops'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==3
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_target';BT_target';BT_target';BT_target']==0,:,:)=NaN;
									else
										tmp_exp(BT_target'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_target'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==4 % TD
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:);
								elseif strat==5 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384,:,:)=NaN;
									end 
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:);
								elseif strat==6 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 ,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0,:,:)=NaN;
									end                  
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==7 % H345
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==8 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1>=30,:);
								elseif strat==9 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30,:,:)=NaN;
									else
										tmp_exp(BT_lat1>=30,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30,:);
								elseif strat==10 % RI
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>=15./1.94384 ,:);
								elseif strat==11 % IN
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<5./1.94384  | BT_intch1>=15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:);
								elseif strat==12 % SS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=5./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<=-5./1.94384  | BT_intch1>=5./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:);
								elseif strat==13 % W
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1>-5./1.94384  | BT_intch1<=-15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:);
								elseif strat==14 % RW
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1>-15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1<=-15./1.94384 ,:);
								elseif strat==15 %% TD strat obs only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0 | BT_drops'==0,:,:)=NaN;
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:);
								elseif strat==16 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384 | BT_drops'==0,:,:)=NaN;
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:);
								elseif strat==17 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0  | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==0,:,:)=NaN;
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==18 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
								   else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0| BT_drops'==0,:,:)=NaN;
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==19 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30 | BT_drops'==0,:,:)=NaN;
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==1,:);
								elseif strat==20 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										 tmp_exp(BT_lat1>=30 | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==1,:);
								elseif strat==21
									clear tmpyrb
									if plt>=21 && plt<=23
										 tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										 tmp_exp(BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_drops'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==22
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_target';BT_target';BT_target';BT_target']==1,:,:)=NaN;
									else
										tmp_exp(BT_target'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_target'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==23 %% TD strat obs only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0 | BT_drops'==1,:,:)=NaN;
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:);
								elseif strat==24 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384 | BT_drops'==1,:,:)=NaN;
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:);
								elseif strat==25 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0  | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==1,:,:)=NaN;
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==26 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
								   else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==1,:,:)=NaN;
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==27 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30 | BT_drops'==1,:,:)=NaN;
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==0,:);
								elseif strat==28 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										 tmp_exp(BT_lat1>=30 | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==0,:);
								elseif strat==29 % Low Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin,:);
								elseif strat==30 % Moderate Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin ,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:);
								elseif strat==31 % High Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin,:);
								elseif strat==32 % Low Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==1,:);
								elseif strat==33 % Moderate Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin | BT_drops'==1,:);
								elseif strat==34 % High Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==1,:);
								elseif strat==35 % Low Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==0,:);
								elseif strat==36 % Moderate Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:);
								elseif strat==37 % High Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==0,:);	
						elseif strat==100
                                                        clear tmpyrb
                                                        if plt>=21 && plt<=23
                                                             tmp_exp([BT_obsg';BT_obsg';BT_obsg';BT_obsg']==0,:,:)=NaN;
                                                        else
                                                             tmp_exp(BT_obsg'==0,:,:)=NaN;
                                                        end
                                                        tmpnm=identinittimesunique(BT_obsg'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==888
									clear tmpyrb
									numlist=[];
									for ins=1:size(identnewsub,1)
										tmpns=identnewsub(ins,:);
										for ins2=1:size(identinittimesunique,1)
											if strcmp(identinittimesunique(ins2,:),tmpns)==1
												numlist=[numlist ins2];
											else
											end
										end
									end
									[a_ns,b_ns]=histcounts(numlist,.5:1:size(identinittimesunique,1)+.5);
									numlist=a_ns';
									numlist(numlist>0)=1;
									if plt>=21 && plt<=23
										tmp_exp([numlist;numlist+size(identinittimesunique,1)*1;numlist+size(identinittimesunique,1)*2;numlist+size(identinittimesunique,1)*3]==0,:,:)=NaN;
									else
										tmp_exp(numlist==0,:,:)=NaN;
									end                  
									tmpnm=identinittimesunique(numlist==1 & ~isnan(BT_cat1)==1,:);       
								end

								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end      
								tmpu=1:size(identexp,1);
										tmpu(tmpu==tmpimp)=[];
										plot(zeros(1,100),-10:89,'Color',[.5 .5 .5],'linewidth',2);
										clear imprv1
										for tmp=[tmpimp,tmpu]
											imprv=100.*(1-abs(nanmean(tmp_exp(:,:,tmp),2))./abs(nanmean(tmp_exp(:,:,tmpimp),2)));  
											imprv(imprv<-99999999)=NaN;
											imprv(imprv>99999999)=NaN;
											l(tmp)=plot(imprv,1:size(imprv,1),'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2); 
											%sigtest=ttestsc(tmp_exp(:,:,tmp)',tmp_exp(:,:,tmpimp)',squeeze(scfactor(plt,tmp,:))','alpha',.05);
											%sigtest_loc=find(sigtest==1);
											%sigtest_exp=imprv(sigtest_loc);
											%plot(sigtest_exp,sigtest_loc,'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',9)
											%sigtest=ttestsc(tmp_exp(:,:,tmp)',tmp_exp(:,:,tmpimp)',squeeze(scfactor(plt,tmp,:))','alpha',.1);
											%sigtest_loc1=find(sigtest==1);
											%sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
											%sigtest_exp=imprv(sigtest_loc);
											%plot(sigtest_exp,sigtest_loc,'o','Color','k','markersize',8,'markerfacecolor',identexpcolors(tmp,:))
											imprv1(:,tmp)=imprv;
										end  
										set(gca,'plotboxaspectratio',[1 1 1])
										ylabel('Cycle Initialization Time','fontsize',20)
										xlabel(tmp_ytitle,'fontsize',20)
										set(gca,'fontsize',20)
										box on
										 % YRANGE
										clear allquad imprv3
										imprv3(:,:,1)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),2)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,2)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),2)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,3)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,4)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,5)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),2)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,6)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),2)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,7)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,8)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,9)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),2)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,10)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),2)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,11)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),2));
										imprv3(:,:,12)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),2)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),2));
										allquadmax=max(max(max(imprv3)));
										allquadmin=min(min(min(imprv3)));
										tmpvalq=max(abs(allquadmin),abs(allquadmax));
										if isnan(tmpvalq)==1
											tmpvalq=0;
										end
										if numel(num2str(tmpvalq))==3
											addfacq=100;
										elseif numel(num2str(tmpvalq))==2
											addfacq=20;
										else
											addfacq=20;
										end
										if numel(num2str(round(max(max(nanmean((tmp_exp0),2))))))==3
											addfac=100;
										elseif numel(num2str(round(max(max(nanmean((tmp_exp0),2))))))==2
											addfac=20;
										else
											addfac=20;
										end
										if plt<=3 || (plt>=16 && plt<=18) % 0-end
											tmpmin=min(min(((tmp_exp0))));
											tmpmax=max(max(((tmp_exp0))));
											tmpval=max(abs(tmpmin),abs(tmpmax));
											if isnan(tmpval)==1
												tmpval=0;
											end
											if tmpval>250
												yrange=[-250 250];
											else
												yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
											end
										elseif plt==19 || plt==20 % -end end 
											tmpmin=min(min(((tmp_exp0))));
											tmpmax=max(max(((tmp_exp0))));
											tmpval=max(abs(tmpmin),abs(tmpmax));
											if isnan(tmpval)==1
												tmpval=0;
											end
											if tmpval>250
												yrange=[-250 250];
											else
												yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
											end               
										elseif (plt>=4 && plt<=15) || plt>=21%quad
											if tmpvalq>250
												yrange=[-250 250];
											else
												yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
											end
										end

										xlim(yrange)
										xstart=1;
										ylim([xstart-.5 size(BT_lat,1)+.5])   
										if size(identinittimesunique,1)>50
											set(gca,'ytick',1:4:100)
											set(gca,'yticklabel',identinittimesunique(1:4:end,:))
										else
											set(gca,'ytick',1:2:100)
											set(gca,'yticklabel',identinittimesunique(1:2:end,:))
										end                        
										grid on
										set(gca,'gridcolor','k','gridalpha',.15)
										set(gca,'fontsize',20)      
										hold off
										box on
										lh=legend(l,identexpshort,'location','northeast');
										lh.FontSize=10;
										set(gcf,'Units','inches');
										a1Pos = get(gca,'Position');
										set(gcf, 'InvertHardcopy', 'off')
										set(gcf,'Units','inches');
										screenposition = get(gcf,'Position');
										set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
										set(gcf, 'InvertHardcopy', 'off')
								text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
								tmpuv = size(tmpnm,1);                               
								tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
								if strat==1
								text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								else
								text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								end
								ax=gca;
										box on
										set(ax, 'Layer', 'bottom')
										ax.LineWidth=1; 
										set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
										set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .85, 0.96]); % maximize figure window
										set(gca,'Color',[.9 .9 .9])
										clear cntexp
										for tmp=1:size(identexp,1)
											cntexp(:,tmp)=sum(~isnan(tmp_exp(:,:,tmp)),2);
										end        
										% Mean Value            
										tmpstr=['Mean: '];
										tmpstrmean=nanmean(imprv1,1);
										tmpstrmean=(find(tmpstrmean~=0));
										if size(tmpstrmean,2)>0
											for tmp=tmpstrmean
												if tmp==tmpstrmean(end)
													tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(imprv1(:,tmp)),2)),'%'];
												else
													tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(imprv1(:,tmp)),2)),'% \color[rgb]{0,0,0}| '];
												end
											end
										else
											tmpstr=[''];
										end
										if sum(cntexp(:))==0 || sum(sum(~isnan(imprv1)))==0
											tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
											set(tx, 'Layer', 'front')          
										else
											tx=text(0.98,0.05,tmpstr,'HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
											set(tx, 'Layer', 'front')
										end   
										axis ij;b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
										yyaxis left
										set(b,'YColor','none');
										yyaxis right
										set(b,'plotboxaspectratio',[1 1 1])
										set(b,'Color','none');
										set(b,'XColor','none');
										set(b,'tickdir','both')
										set(b,'YColor',[0 0 0]);
										set(b,'xtick',[]);
										ylim(b,[xstart-.5 size(BT_lat,1)+.5])
										tmpxend=size(BT_lat,1);
										if size(identinittimesunique,1)>50
											set(b,'ytick',[1:4:100]); 
										else
											set(b,'ytick',[1:2:100]); 
										end    
										trkerr_exp_fcnt=zeros(1,tmpxend);            
										trkerr_exp_fcnt1=zeros(1,tmpxend);            
										trkerr_exp_fcnt2=zeros(1,tmpxend);
										clear cntexp
										for tmp=1:size(identexp,1)
											cntexp(:,tmp)=sum(~isnan(tmp_exp(:,:,tmp)),2);
										end
										set(gca,'fontsize',12)
										xL=xlim;
										yL=ylim;
										ylabel({'# 6-h','fcsts'},'Position',[xL(2) yL(2)],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',0); 
										set(gca,'position',[spPos(1)+.08 spPos(2)+.05 spPos(3) spPos(4)])
										screenposition = get(gcf,'Position');
										set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
										set(gcf, 'InvertHardcopy', 'off')
										% Create a text box at every Tick label position
										maxmin=squeeze(sum(~isnan(tmp_exp(:,:,:)),2)); 
										if size(identinittimesunique,1)>50
											maxmin=maxmin(1:4:end,:); 
										else
											maxmin=maxmin(1:2:end,:); 
										end                        
										yTicks0 = get(gca, 'yticklabel');
										yTicks = get(gca, 'ytick');
										set(b,'yticklabels',[]);
										minX =1;
										HorizontalOffset1=0.03;
										VerticalOffset = 0.2;
										for xx = 1:size(yTicks0,1)
											tmptxt0=maxmin(xx,:);
											tmptxt1=[];
											if size(unique(tmptxt0),2)==1
												tmptxt1=num2str(tmptxt0(1));
											else
												for xxx=1:size(maxmin,2)
													  if xxx==size(maxmin,2)
														  tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(xxx,:)),'}',num2str(tmptxt0(xxx))];
													  else
														  tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(xxx,:)),'}',num2str(tmptxt0(xxx)),'\color[rgb]{0,0,0}/'];
													  end
												end
											end
											text(minX+HorizontalOffset1,yTicks(xx),tmptxt1,'verticalalignment','middle','fontsize',12)
										end
										axis ij;f = getframe(hfig);
								if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname,'_cycles'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
										close all
							end
							% Create Graphics: trk, int, spd FSP vs. deny
							for plt=[1:18,21:23]
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax1=subplot(3,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkfsp';
									 tmp_title='Track FSP (\%)';
									 tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									 yrange=[-20 20];
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prsfsp';
									tmp_title='Pressure FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spdfsp';
									tmp_title='Wind Speed FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFfsp';
									tmp_title='RTSF NEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFfsp';
									tmp_title='RTSF SEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFfsp';
									tmp_title='RTSF SWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFfsp';
									tmp_title='RTSF NWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFfsp';
									tmp_title='RSF NEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFfsp';
									tmp_title='RSF SEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFfsp';
									tmp_title='RSF SWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFfsp';
									tmp_title='RSF NWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFfsp';
									tmp_title='RHF NEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFfsp';
									tmp_title='RHF SEQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFfsp';
									tmp_title='RHF SWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFfsp';
									tmp_title='RHF NWQ FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='pofsp';
									tmp_title='Outer Clsd Isbr Prs FSP (hPa)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='rofsp';
									tmp_title='Outer Clsd Isbr Rad FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwfsp';
									tmp_title='RMW FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='atefsp';
									tmp_title='Along-Track FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xtefsp';
									tmp_title='Across-Track FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-200 200];                                 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFfsp';
									tmp_title='RTSF FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFfsp';
									tmp_title='RSF FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFfsp';
									tmp_title='RHF FSP (\%)';
									tmp_ytitle=['FSP wrt ', identexpsigimpshort,' (%)'];
									yrange=[-50 50];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								tmp_exp0=squeeze(100.*(1-nanmean(tmp_exp(:,:,:),2)./nanmean(tmp_exp(:,:,tmpimp),2)));                  
								% Strat
								if strat==1
									clear tmpyrb
									tmpnm=identinittimesunique(~isnan(BT_cat1)==1,:);
								elseif strat==2
									clear tmpyrb
									if plt>=21 && plt<=23
										 tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										 tmp_exp(BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_drops'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==3
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_target';BT_target';BT_target';BT_target']==0,:,:)=NaN;
									else
										tmp_exp(BT_target'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_target'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==4 % TD
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:);
								elseif strat==5 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384,:,:)=NaN;
									end 
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:);
								elseif strat==6 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 ,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0,:,:)=NaN;
									end                  
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==7 % H345
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==8 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1>=30,:);
								elseif strat==9 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30,:,:)=NaN;
									else
										tmp_exp(BT_lat1>=30,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30,:);
								elseif strat==10 % RI
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>=15./1.94384 ,:);
								elseif strat==11 % IN
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<5./1.94384  | BT_intch1>=15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:);
								elseif strat==12 % SS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=5./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<=-5./1.94384  | BT_intch1>=5./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:);
								elseif strat==13 % W
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1>-5./1.94384  | BT_intch1<=-15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:);
								elseif strat==14 % RW
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1>-15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1<=-15./1.94384 ,:);
								elseif strat==15 %% TD strat obs only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0 | BT_drops'==0,:,:)=NaN;
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:);
								elseif strat==16 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384 | BT_drops'==0,:,:)=NaN;
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:);
								elseif strat==17 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0  | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==0,:,:)=NaN;
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==18 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
								   else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0| BT_drops'==0,:,:)=NaN;
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==19 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30 | BT_drops'==0,:,:)=NaN;
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==1,:);
								elseif strat==20 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										 tmp_exp(BT_lat1>=30 | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==1,:);
								elseif strat==21
									clear tmpyrb
									if plt>=21 && plt<=23
										 tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										 tmp_exp(BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_drops'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==22
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_target';BT_target';BT_target';BT_target']==1,:,:)=NaN;
									else
										tmp_exp(BT_target'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_target'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==23 %% TD strat obs only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0 | BT_drops'==1,:,:)=NaN;
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:);
								elseif strat==24 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384 | BT_drops'==1,:,:)=NaN;
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:);
								elseif strat==25 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0  | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==1,:,:)=NaN;
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==26 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
								   else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==1,:,:)=NaN;
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==27 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30 | BT_drops'==1,:,:)=NaN;
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==0,:);
								elseif strat==28 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										 tmp_exp(BT_lat1>=30 | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==0,:);
								elseif strat==29 % Low Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin,:);
								elseif strat==30 % Moderate Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin ,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:);
								elseif strat==31 % High Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin,:);
								elseif strat==32 % Low Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==1,:);
								elseif strat==33 % Moderate Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin | BT_drops'==1,:);
								elseif strat==34 % High Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==1,:);
								elseif strat==35 % Low Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==0,:);
								elseif strat==36 % Moderate Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:);
								elseif strat==37 % High Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==0,:);	
						elseif strat==100
                                                        clear tmpyrb
                                                        if plt>=21 && plt<=23
                                                             tmp_exp([BT_obsg';BT_obsg';BT_obsg';BT_obsg']==0,:,:)=NaN;
                                                        else
                                                             tmp_exp(BT_obsg'==0,:,:)=NaN;
                                                        end
                                                        tmpnm=identinittimesunique(BT_obsg'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==888
									clear tmpyrb
									numlist=[];
									for ins=1:size(identnewsub,1)
										tmpns=identnewsub(ins,:);
										for ins2=1:size(identinittimesunique,1)
											if strcmp(identinittimesunique(ins2,:),tmpns)==1
												numlist=[numlist ins2];
											else
											end
										end
									end
									[a_ns,b_ns]=histcounts(numlist,.5:1:size(identinittimesunique,1)+.5);
									numlist=a_ns';
									numlist(numlist>0)=1;
									if plt>=21 && plt<=23
										tmp_exp([numlist;numlist+size(identinittimesunique,1)*1;numlist+size(identinittimesunique,1)*2;numlist+size(identinittimesunique,1)*3]==0,:,:)=NaN;
									else
										tmp_exp(numlist==0,:,:)=NaN;
									end                  
									tmpnm=identinittimesunique(numlist==1 & ~isnan(BT_cat1)==1,:);      
								end

								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end      
								tmpu=1:size(identexp,1);
										tmpu(tmpu==tmpimp)=[];
										plot(50*ones(1,100),-10:89,'Color',[.5 .5 .5],'linewidth',2);
										clear fsp2
										cntl=1;
										for tmp=tmpu
											tmp1=tmp_exp(:,:,tmp);
											tmp2=tmp_exp(:,:,tmpimp);
											tmp3=sign(tmp1-tmp2);
											tmp4=tmp3<0;
											tmp5=tmp3>0;
											tmp6=tmp3==0;
											tmptmp=sum(~isnan(tmp3),2);                            
											fspa=100*(nansum(tmp4,2)+nansum(tmp6,2)./2)./tmptmp;
											fspb=100*(nansum(tmp5,2)+nansum(tmp6,2)./2)./tmptmp;
											fsp2(:,tmp)=fspa;
											%plot(fspb,1:size(fspb,1),'--s','Color',identexpcolors(tmp,:),'linewidth',.5,'markersize',2); 
											l(cntl)=plot(fspa,1:size(fspa,1),'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2); 
											cntl=cntl+1;
											%sigtest=ttestsc(tmp_exp(:,:,tmp)',tmp_exp(:,:,tmpimp)',squeeze(scfactor(plt,tmp,:))','alpha',.05);
											%sigtest_loc=find(sigtest==1);
											%sigtest_exp=fspa(sigtest_loc);
											%plot(sigtest_exp,sigtest_loc,'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',9)
											%sigtest=ttestsc(tmp_exp(:,:,tmp)',tmp_exp(:,:,tmpimp)',squeeze(scfactor(plt,tmp,:))','alpha',.1);
											%sigtest_loc1=find(sigtest==1);
											%sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
											%sigtest_exp=fspa(sigtest_loc);
											%plot(sigtest_exp,sigtest_loc,'o','Color','k','markersize',8,'markerfacecolor',identexpcolors(tmp,:))
										end
										set(gca,'plotboxaspectratio',[1 1 1])
										ylabel('Cycle Initialization Time','fontsize',20)
										xlabel(tmp_ytitle,'fontsize',20)
										set(gca,'fontsize',20)
										box on
										xlim([0 100])
										xstart=1;
										ylim([xstart-.5 size(BT_lat,1)+.5])   
										if size(identinittimesunique,1)>50
											set(gca,'ytick',1:4:100)
											set(gca,'yticklabel',identinittimesunique(1:4:end,:))
										else
											set(gca,'ytick',1:2:100)
											set(gca,'yticklabel',identinittimesunique(1:2:end,:))
										end                        
										grid on
										set(gca,'gridcolor','k','gridalpha',.15)
										set(gca,'fontsize',20)      
										hold off
										box on
										lh=legend(l,identexpshort(tmpu),'location','northeast');
										lh.FontSize=10;
										set(gcf,'Units','inches');
										a1Pos = get(gca,'Position');
										set(gcf, 'InvertHardcopy', 'off')
										set(gcf,'Units','inches');
										screenposition = get(gcf,'Position');
										set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
										set(gcf, 'InvertHardcopy', 'off')
								text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
								tmpuv = size(tmpnm,1);                               
								tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
								if strat==1
								text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								else
								text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								end
								ax=gca;
										box on
										set(ax, 'Layer', 'bottom')
										ax.LineWidth=1; 
										set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
										set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .85, 0.96]); % maximize figure window
										set(gca,'Color',[.9 .9 .9])
										clear cntexp
										for tmp=1:size(identexp,1)
											cntexp(:,tmp)=sum(~isnan(tmp_exp(:,:,tmp)),2);
										end        
										% Mean Value            
										tmpstr=['Mean: '];
										tmpstrmean=nanmean(fsp2,1);
										tmpstrmean=(find(tmpstrmean>=0));
										if size(tmpstrmean,2)>0
											for tmp=tmpstrmean
												if tmp==tmpstrmean(end)
													tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(fsp2(:,tmp)),2)),'%'];
												else
													tmpstr=[tmpstr, '\color[rgb]{',num2str(identexpcolors(tmp,:)),'}',num2str(round(nanmean(fsp2(:,tmp)),2)),'% \color[rgb]{0,0,0}| '];
												end
											end
										else
											tmpstr=[''];
										end
										if sum(cntexp(:))==0 || sum(sum(~isnan(fsp2)))==0
											tx=text(0.98,0.05,'Not Enough Data','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
											set(tx, 'Layer', 'front')          
										else
											tx=text(0.98,0.05,tmpstr,'HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
											set(tx, 'Layer', 'front')
										end   
										axis ij;b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
										yyaxis left
										set(b,'YColor','none');
										yyaxis right
										set(b,'plotboxaspectratio',[1 1 1])
										set(b,'Color','none');
										set(b,'XColor','none');
										set(b,'tickdir','both')
										set(b,'YColor',[0 0 0]);
										set(b,'xtick',[]);
										ylim(b,[xstart-.5 size(BT_lat,1)+.5])
										tmpxend=size(BT_lat,1);
										if size(identinittimesunique,1)>50
											set(b,'ytick',[1:4:100]); 
										else
											set(b,'ytick',[1:2:100]); 
										end    
										trkerr_exp_fcnt=zeros(1,tmpxend);            
										trkerr_exp_fcnt1=zeros(1,tmpxend);            
										trkerr_exp_fcnt2=zeros(1,tmpxend);
										clear cntexp
										for tmp=1:size(identexp,1)
											cntexp(:,tmp)=sum(~isnan(tmp_exp(:,:,tmp)),2);
										end
										set(gca,'fontsize',12)
										xL=xlim;
										yL=ylim;
										ylabel({'# 6-h','fcsts'},'Position',[xL(2) yL(2)],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',0); 
										set(gca,'position',[spPos(1)+.08 spPos(2)+.05 spPos(3) spPos(4)])
										screenposition = get(gcf,'Position');
										set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
										set(gcf, 'InvertHardcopy', 'off')
										% Create a text box at every Tick label position
										maxmin=squeeze(sum(~isnan(tmp_exp(:,:,:)),2)); 
										if size(identinittimesunique,1)>50
											maxmin=maxmin(1:4:end,:); 
										else
											maxmin=maxmin(1:2:end,:); 
										end                        
										yTicks0 = get(gca, 'yticklabel');
										yTicks = get(gca, 'ytick');
										set(b,'yticklabels',[]);
										minX =1;
										HorizontalOffset1=0.03;
										VerticalOffset = 0.2;
										for xx = 1:size(yTicks0,1)
											tmptxt0=maxmin(xx,:);
											tmptxt1=[];
											if size(unique(tmptxt0),2)==1
												tmptxt1=num2str(tmptxt0(1));
											else
												for xxx=1:size(maxmin,2)
													  if xxx==size(maxmin,2)
														  tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(xxx,:)),'}',num2str(tmptxt0(xxx))];
													  else
														  tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(xxx,:)),'}',num2str(tmptxt0(xxx)),'\color[rgb]{0,0,0}/'];
													  end
												end
											end
											text(minX+HorizontalOffset1,yTicks(xx),tmptxt1,'verticalalignment','middle','fontsize',12)
										end
										axis ij;f = getframe(hfig);
								if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname,'_cycles'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
										close all
							end                                    
							% Create Graphics: trk, int, spd bias - bt-gh vs. bt-deny
							for plt=[2:18,21:23] % no across or along for bias since already in error
								clear l cntexp
								set(0,'defaultfigurecolor',[1 1 1]) % figure background color
								hfig=figure;
								set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
								ax1=subplot(3,4,[1:8]);
								hold on
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkbias';
									 tmp_title='Track Bias (km)';
									 tmp_ytitle='Bias (km)';
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prsbias';
									tmp_title='Pressure Bias (hPa)';
									tmp_ytitle='Bias (hPa)';
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spdbias';
									tmp_title='Wind Speed Bias (m/s)';
									tmp_ytitle='Bias (m/s)';
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFbias';
									tmp_title='RTSF NEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFbias';
									tmp_title='RTSF SEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFbias';
									tmp_title='RTSF SWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFbias';
									tmp_title='RTSF NWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFbias';
									tmp_title='RSF NEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFbias';
									tmp_title='RSF SEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFbias';
									tmp_title='RSF SWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFbias';
									tmp_title='RSF NWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFbias';
									tmp_title='RHF NEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFbias';
									tmp_title='RHF SEQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFbias';
									tmp_title='RHF SWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFbias';
									tmp_title='RHF NWQ Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-200 200];
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='pobias';
									tmp_title='Outer Clsd Isbr Prs Bias (hPa)';
									tmp_ytitle='Bias (hPa)';
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='robias';
									tmp_title='Outer Clsd Isbr Rad Bias (km)';
									tmp_ytitle='Bias (km)';
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwbias';
									tmp_title='RMW Bias (km)';
									tmp_ytitle='Bias (km)';
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='atebias';
									tmp_title='Along-Track Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-500 500];                
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xtebias';
									tmp_title='Across-Track Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-500 500]; 
								elseif plt==21
									tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFbias';
									tmp_title='RTSF Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-100 100];
								elseif plt==22
									tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFbias';
									tmp_title='RSF Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-100 100];
								elseif plt==23
									tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFbias';
									tmp_title='RHF Bias (km)';
									tmp_ytitle='Bias (km)';
									yrange=[-100 100];
								end
								tmp_exp0=tmp_exp;

																   % Strat
								if strat==1
									clear tmpyrb
									tmpnm=identinittimesunique(~isnan(BT_cat1)==1,:);
								elseif strat==2
									clear tmpyrb
									if plt>=21 && plt<=23
										 tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										 tmp_exp(BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_drops'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==3
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_target';BT_target';BT_target';BT_target']==0,:,:)=NaN;
									else
										tmp_exp(BT_target'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_target'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==4 % TD
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:);
								elseif strat==5 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384,:,:)=NaN;
									end 
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:);
								elseif strat==6 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 ,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0,:,:)=NaN;
									end                  
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==7 % H345
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==8 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1>=30,:);
								elseif strat==9 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30,:,:)=NaN;
									else
										tmp_exp(BT_lat1>=30,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30,:);
								elseif strat==10 % RI
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>=15./1.94384 ,:);
								elseif strat==11 % IN
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<5./1.94384  | BT_intch1>=15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:);
								elseif strat==12 % SS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=5./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<=-5./1.94384  | BT_intch1>=5./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:);
								elseif strat==13 % W
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1>-5./1.94384  | BT_intch1<=-15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:);
								elseif strat==14 % RW
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1>-15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1<=-15./1.94384 ,:);
								elseif strat==15 %% TD strat obs only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0 | BT_drops'==0,:,:)=NaN;
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:);
								elseif strat==16 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384 | BT_drops'==0,:,:)=NaN;
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:);
								elseif strat==17 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0  | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==0,:,:)=NaN;
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==18 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
								   else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0| BT_drops'==0,:,:)=NaN;
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==19 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30 | BT_drops'==0,:,:)=NaN;
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==1,:);
								elseif strat==20 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										 tmp_exp(BT_lat1>=30 | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==1,:);
								elseif strat==21
									clear tmpyrb
									if plt>=21 && plt<=23
										 tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										 tmp_exp(BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_drops'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==22
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_target';BT_target';BT_target';BT_target']==1,:,:)=NaN;
									else
										tmp_exp(BT_target'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_target'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==23 %% TD strat obs only
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0 | BT_drops'==1,:,:)=NaN;
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:);
								elseif strat==24 % TS
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384 | BT_drops'==1,:,:)=NaN;
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:);
								elseif strat==25 % H12
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0  | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==1,:,:)=NaN;
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==26 % H345
									clear tmpyrb
								   if plt>=21 && plt<=23
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
								   else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==1,:,:)=NaN;
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==27 % N30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30 | BT_drops'==1,:,:)=NaN;
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==0,:);
								elseif strat==28 % S30
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										 tmp_exp(BT_lat1>=30 | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==0,:);
								elseif strat==29 % Low Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin,:);
								elseif strat==30 % Moderate Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin ,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:);
								elseif strat==31 % High Shear
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin,:);
								elseif strat==32 % Low Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==1,:);
								elseif strat==33 % Moderate Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin | BT_drops'==1,:);
								elseif strat==34 % High Shear Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==1,:);
								elseif strat==35 % Low Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==0,:);
								elseif strat==36 % Moderate Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:);
								elseif strat==37 % High Shear No Drops
									clear tmpyrb
									if plt>=21 && plt<=23
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==0,:);	
						elseif strat==100
                                                        clear tmpyrb
                                                        if plt>=21 && plt<=23
                                                             tmp_exp([BT_obsg';BT_obsg';BT_obsg';BT_obsg']==0,:,:)=NaN;
                                                        else
                                                             tmp_exp(BT_obsg'==0,:,:)=NaN;
                                                        end
                                                        tmpnm=identinittimesunique(BT_obsg'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==888
									clear tmpyrb
									numlist=[];
									for ins=1:size(identnewsub,1)
										tmpns=identnewsub(ins,:);
										for ins2=1:size(identinittimesunique,1)
											if strcmp(identinittimesunique(ins2,:),tmpns)==1
												numlist=[numlist ins2];
											else
											end
										end
									end
									[a_ns,b_ns]=histcounts(numlist,.5:1:size(identinittimesunique,1)+.5);
									numlist=a_ns';
									numlist(numlist>0)=1;
									if plt>=21 && plt<=23
										tmp_exp([numlist;numlist+size(identinittimesunique,1)*1;numlist+size(identinittimesunique,1)*2;numlist+size(identinittimesunique,1)*3]==0,:,:)=NaN;
									else
										tmp_exp(numlist==0,:,:)=NaN;
									end                  
									tmpnm=identinittimesunique(numlist==1 & ~isnan(BT_cat1)==1,:);     
								end

								for tmp=1:size(identexp,1)
									l(tmp)=plot(nanmean(tmp_exp(:,:,tmp),2),1:size(tmp_exp(:,:,tmp),1),'-s','Color',identexpcolors(tmp,:),'linewidth',2,'markersize',2);
								end
								% Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end       
								plot(zeros(1,100),-10:89,'Color',[.5 .5 .5],'linewidth',2);
								for tmp=1:size(identexp,1)
									%sigtest=ttestsc(abs(tmp_exp(:,:,tmp))',abs(tmp_exp(:,:,tmpimp))',squeeze(scfactor(plt,tmp,:))','alpha',.05);
									%sigtest_loc=find(sigtest==1);
									%sigtest_exp=nanmean(tmp_exp(sigtest_loc,:,:),2);
									%for tmpi=tmp
									%    plot(sigtest_exp(:,:,tmpi),sigtest_loc,'s','Color','k','markerfacecolor',identexpcolors(tmp,:),'markersize',9)
									%end                
									%sigtest=ttestsc(abs(tmp_exp(:,:,tmp))',abs(tmp_exp(:,:,tmpimp))',squeeze(scfactor(plt,tmp,:))','alpha',.1);
									%sigtest_loc1=find(sigtest==1);
									%sigtest_loc=setdiff(sigtest_loc1,sigtest_loc);
									%sigtest_exp=nanmean(tmp_exp(sigtest_loc,:,:),2);
									%for tmpi=tmp
									%    plot(sigtest_exp(:,:,tmpi),sigtest_loc,'o','Color','k','markersize',8,'markerfacecolor',identexpcolors(tmp,:))
									%end
								end  
								set(gca,'plotboxaspectratio',[1 1 1])
								ylabel('Cycle Initialization Time','fontsize',20)
								xlabel(tmp_ytitle,'fontsize',20)
								set(gca,'fontsize',20)
								box on
								xstart=1;        
								ylim([xstart-.5 size(BT_lat,1)+.5])
								% YRANGE
								clear allquad
								allquad(1)=(max(max(nanmean((ne34err_exp(:,1:skip:end,:)),2))));
								allquad(2)=(max(max(nanmean((se34err_exp(:,1:skip:end,:)),2))));
								allquad(3)=(max(max(nanmean((nw34err_exp(:,1:skip:end,:)),2))));
								allquad(4)=(max(max(nanmean((sw34err_exp(:,1:skip:end,:)),2))));
								allquad(5)=(max(max(nanmean((ne50err_exp(:,1:skip:end,:)),2))));
								allquad(6)=(max(max(nanmean((se50err_exp(:,1:skip:end,:)),2))));
								allquad(7)=(max(max(nanmean((nw50err_exp(:,1:skip:end,:)),2))));
								allquad(8)=(max(max(nanmean((sw50err_exp(:,1:skip:end,:)),2))));
								allquad(9)=(max(max(nanmean((ne64err_exp(:,1:skip:end,:)),2))));
								allquad(10)=(max(max(nanmean((se64err_exp(:,1:skip:end,:)),2))));
								allquad(11)=(max(max(nanmean((nw64err_exp(:,1:skip:end,:)),2))));
								allquad(12)=(max(max(nanmean((sw64err_exp(:,1:skip:end,:)),2))));
								allquadmax=max(max(max(allquad)));
								allquadmin=min(min(min(allquad)));
								tmpvalq=max(abs(allquadmin),abs(allquadmax));
								if isnan(tmpvalq)==1
									tmpvalq=0;
								end
								if numel(num2str(tmpvalq))==3
									addfacq=100;
								elseif numel(num2str(tmpvalq))==2
									addfacq=20;
								else
									addfacq=20;
								end
								if numel(num2str(round(max(max(nanmean((tmp_exp0),2))))))==3
									addfac=100;
								elseif numel(num2str(round(max(max(nanmean((tmp_exp0),2))))))==2
									addfac=20;
								else
									addfac=20;
								end
								if plt<=3 || (plt>=16 && plt<=18) % 0-end
									tmpmin=min(min(nanmean((tmp_exp0),2)));
									tmpmax=max(max(nanmean((tmp_exp0),2)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];                                
								elseif plt==19 || plt==20 % -end end 
									tmpmin=min(min(nanmean((tmp_exp0),2)));
									tmpmax=max(max(nanmean((tmp_exp0),2)));
									tmpval=max(abs(tmpmin),abs(tmpmax));
									if isnan(tmpval)==1
										tmpval=0;
									end
									yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];                
								elseif (plt>=4 && plt<=15) || plt>=21%quad
									yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
								end
											xlim(yrange)
										if size(identinittimesunique,1)>50
											set(gca,'ytick',1:4:100)
											set(gca,'yticklabel',identinittimesunique(1:4:end,:))
										else
											set(gca,'ytick',1:2:100)
											set(gca,'yticklabel',identinittimesunique(1:2:end,:))
										end  
										grid on
										set(gca,'gridcolor','k','gridalpha',.15)
										set(gca,'fontsize',20)      
										hold off
										box on
										lh=legend(l,identexpshort,'location','northeast');
										lh.FontSize=10;
										set(gcf,'Units','inches');
										a1Pos = get(gca,'Position');
										set(gcf, 'InvertHardcopy', 'off')
										set(gcf,'Units','inches');
										screenposition = get(gcf,'Position');
										set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
										set(gcf, 'InvertHardcopy', 'off')
								text(0,1.065,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');                         
								tmpuv = size(tmpnm,1);                               
								tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
								if strat==1
								text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								else
								text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
								end
								ax=gca;
										box on
										set(ax, 'Layer', 'bottom')
										ax.LineWidth=1; 
										set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
										set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .85, 0.96]); % maximize figure window
										set(gca,'Color',[.9 .9 .9])
										clear cntexp
										for tmp=1:size(identexp,1)
											cntexp(:,tmp)=sum(~isnan(tmp_exp(:,:,tmp)),2);
										end
										if sum([cntexp(:)])==0
											tx=text(0.02,0.98,'Not Enough Data','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
											set(tx, 'Layer', 'front')
										end															 
											if plt==1 || plt>=4 && plt<=15 || plt==17 || plt==18 || plt>20
												 tx=text(0.02,0.05,'Too Small','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
												 tx=text(0.98,0.05,'Too Large','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
												 set(tx, 'Layer', 'front')  
											elseif plt==2 || plt==16
												 tx=text(0.02,0.05,'Too Low','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
												 tx=text(0.98,0.05,'Too High','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
												 set(tx, 'Layer', 'front')  
											elseif plt==3
												 tx=text(0.02,0.05,'Too Slow','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
												 tx=text(0.98,0.05,'Too Fast','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
												 set(tx, 'Layer', 'front') 
											elseif plt==19
												 tx=text(0.02,0.05,'Slower than BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
												 tx=text(0.98,0.05,'Faster than BT','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
												 set(tx, 'Layer', 'front')            
											elseif plt==20
												 tx=text(0.02,0.05,'Left of BT','HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
												 tx=text(0.98,0.05,'Right of BT','HorizontalAlignment','right','VerticalAlignment','top','BackgroundColor', 'w','EdgeColor','k','fontsize',12,'units','normalized');
												 set(tx, 'Layer', 'front')            
											end   
										axis ij;b=axes('Position',[a1Pos(1) a1Pos(2)-.11 a1Pos(3) a1Pos(4)]);
										yyaxis left
										set(b,'YColor','none');
										yyaxis right
										set(b,'plotboxaspectratio',[1 1 1])
										set(b,'Color','none');
										set(b,'XColor','none');
										set(b,'tickdir','both')
										set(b,'YColor',[0 0 0]);
										set(b,'xtick',[]);
										ylim(b,[xstart-.5 size(BT_lat,1)+.5])
										tmpxend=size(BT_lat,1);
										if size(identinittimesunique,1)>50
											set(b,'ytick',[1:4:100]); 
										else
											set(b,'ytick',[1:2:100]); 
										end  
										trkerr_exp_fcnt=zeros(1,tmpxend);            
										trkerr_exp_fcnt1=zeros(1,tmpxend);            
										trkerr_exp_fcnt2=zeros(1,tmpxend);
										clear cntexp
										for tmp=1:size(identexp,1)
											cntexp(:,tmp)=sum(~isnan(tmp_exp(:,:,tmp)),2);
										end
										set(gca,'fontsize',12)
										xL=xlim;
										yL=ylim;
										ylabel({'# 6-h','fcsts'},'Position',[xL(2) yL(2)],'VerticalAlignment','top','HorizontalAlignment','center','Rotation',0); 
										set(gca,'position',[spPos(1)+.08 spPos(2)+.05 spPos(3) spPos(4)])
										screenposition = get(gcf,'Position');
										set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
										set(gcf, 'InvertHardcopy', 'off')            
										% Create a text box at every Tick label position
										maxmin=squeeze(sum(~isnan(tmp_exp(:,:,:)),2)); 
										if size(identinittimesunique,1)>50
											maxmin=maxmin(1:4:end,:); 
										else
											maxmin=maxmin(1:2:end,:); 
										end
										yTicks0 = get(gca, 'yticklabel');
										yTicks = get(gca, 'ytick');
										set(b,'yticklabels',[]);
										minX =1;
										HorizontalOffset1=0.03;
										VerticalOffset = 0.2;
										for xx = 1:size(yTicks0,1)
											tmptxt0=maxmin(xx,:);
											tmptxt1=[];
											if size(unique(tmptxt0),2)==1
												tmptxt1=num2str(tmptxt0(1));
											else
												for xxx=1:size(maxmin,2)
													  if xxx==size(maxmin,2)
														  tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(xxx,:)),'}',num2str(tmptxt0(xxx))];
													  else
														  tmptxt1=[tmptxt1,'\color[rgb]{',num2str(identexpcolors(xxx,:)),'}',num2str(tmptxt0(xxx)),'\color[rgb]{0,0,0}/'];
													  end
												end
											end
											text(minX+HorizontalOffset1,yTicks(xx),tmptxt1,'verticalalignment','middle','fontsize',12)
										end
										axis ij;f = getframe(hfig);
								if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_',stname,'_cycles'];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
										close all
							end                                                
							% Create Graphics: Cycle-By-Cycle Skill!!!
							for plt=[1:18,21:23] % no across or along for bias
								clear l cntexp nm_pct
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkerr';
									 tmp_title='Cycle-By-Cycle Track Skill (\%)';
									 tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prserr';
									tmp_title='Cycle-By-Cycle Pressure Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spderr';
									tmp_title='Cycle-By-Cycle Wind Speed Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFerr';
									tmp_title='Cycle-By-Cycle RTSF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFerr';
									tmp_title='Cycle-By-Cycle RTSF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFerr';
									tmp_title='Cycle-By-Cycle RTSF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFerr';
									tmp_title='Cycle-By-Cycle RTSF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFerr';
									tmp_title='Cycle-By-Cycle RSF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFerr';
									tmp_title='Cycle-By-Cycle RSF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFerr';
									tmp_title='Cycle-By-Cycle RSF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFerr';
									tmp_title='Cycle-By-Cycle RSF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFerr';
									tmp_title='Cycle-By-Cycle RHF NEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFerr';
									tmp_title='Cycle-By-Cycle RHF SEQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFerr';
									tmp_title='Cycle-By-Cycle RHF SWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
									yrange=[-100 100];                 
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFerr';
									tmp_title='Cycle-By-Cycle RHF NWQ Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poerr';
									tmp_title='Cycle-By-Cycle Outer Clsd Isbr Prs Skill (hPa)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roerr';
									tmp_title='Cycle-By-Cycle Outer Clsd Isbr Rad Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwerr';
									tmp_title='Cycle-By-Cycle RMW Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='ateerr';
									tmp_title='Cycle-By-Cycle Along-Track Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xteerr';
									tmp_title='Cycle-By-Cycle Across-Track Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==21
									tmp_exp1=cat(4,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_exp=nansum(tmp_exp1,4);
									tmp_exp(all(isnan(tmp_exp1),4))=NaN;
									tmp_name='RTSFerr';
									tmp_title='Cycle-By-Cycle RTSF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==22
									tmp_exp1=cat(4,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_exp=nansum(tmp_exp1,4);
									tmp_exp(all(isnan(tmp_exp1),4))=NaN;
									tmp_name='RSFerr';
									tmp_title='Cycle-By-Cycle RSF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								elseif plt==23
									tmp_exp1=cat(4,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_exp=nansum(tmp_exp1,4);
									tmp_exp(all(isnan(tmp_exp1),4))=NaN;
									tmp_name='RHFerr';
									tmp_title='Cycle-By-Cycle RHF Skill (\%)';
									tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								tmp_exp0=tmp_exp;
								% Strat
								if strat==1
									clear tmpyrb
									tmpnm=identinittimesunique(~isnan(BT_cat1)==1,:);
								elseif strat==2
									clear tmpyrb
									if plt<0
										 tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										 tmp_exp(BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_drops'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==3
									clear tmpyrb
									if plt<0
										tmp_exp([BT_target';BT_target';BT_target';BT_target']==0,:,:)=NaN;
									else
										tmp_exp(BT_target'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_target'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==4 % TD
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:);
								elseif strat==5 % TS
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384,:,:)=NaN;
									end 
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:);
								elseif strat==6 % H12
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 ,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0,:,:)=NaN;
									end                  
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==7 % H345
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==8 % N30
									clear tmpyrb
									if plt<0
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1>=30,:);
								elseif strat==9 % S30
									clear tmpyrb
									if plt<0
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30,:,:)=NaN;
									else
										tmp_exp(BT_lat1>=30,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30,:);
								elseif strat==10 % RI
									clear tmpyrb
									if plt<0
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>=15./1.94384 ,:);
								elseif strat==11 % IN
									clear tmpyrb
									if plt<0
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<5./1.94384  | BT_intch1>=15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:);
								elseif strat==12 % SS
									clear tmpyrb
									if plt<0
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=5./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<=-5./1.94384  | BT_intch1>=5./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:);
								elseif strat==13 % W
									clear tmpyrb
									if plt<0
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1>-5./1.94384  | BT_intch1<=-15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:);
								elseif strat==14 % RW
									clear tmpyrb
									if plt<0
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1>-15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1<=-15./1.94384 ,:);
								elseif strat==15 %% TD strat obs only
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0 | BT_drops'==0,:,:)=NaN;
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:);
								elseif strat==16 % TS
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384 | BT_drops'==0,:,:)=NaN;
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:);
								elseif strat==17 % H12
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0  | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==0,:,:)=NaN;
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==18 % H345
									clear tmpyrb
								   if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
								   else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0| BT_drops'==0,:,:)=NaN;
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==19 % N30
									clear tmpyrb
									if plt<0
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30 | BT_drops'==0,:,:)=NaN;
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==1,:);
								elseif strat==20 % S30
									clear tmpyrb
									if plt<0
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										 tmp_exp(BT_lat1>=30 | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==1,:);
								elseif strat==21
									clear tmpyrb
									if plt<0
										 tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										 tmp_exp(BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_drops'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==22
									clear tmpyrb
									if plt<0
										tmp_exp([BT_target';BT_target';BT_target';BT_target']==1,:,:)=NaN;
									else
										tmp_exp(BT_target'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_target'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==23 %% TD strat obs only
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0 | BT_drops'==1,:,:)=NaN;
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:);
								elseif strat==24 % TS
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384 | BT_drops'==1,:,:)=NaN;
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:);
								elseif strat==25 % H12
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0  | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==1,:,:)=NaN;
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==26 % H345
									clear tmpyrb
								   if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
								   else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==1,:,:)=NaN;
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==27 % N30
									clear tmpyrb
									if plt<0
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30 | BT_drops'==1,:,:)=NaN;
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==0,:);
								elseif strat==28 % S30
									clear tmpyrb
									if plt<0
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										 tmp_exp(BT_lat1>=30 | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==0,:);
								elseif strat==29 % Low Shear
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin,:);
								elseif strat==30 % Moderate Shear
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin ,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:);
								elseif strat==31 % High Shear
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin,:);
								elseif strat==32 % Low Shear Drops
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==1,:);
								elseif strat==33 % Moderate Shear Drops
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin | BT_drops'==1,:);
								elseif strat==34 % High Shear Drops
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==1,:);
								elseif strat==35 % Low Shear No Drops
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==0,:);
								elseif strat==36 % Moderate Shear No Drops
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:);
								elseif strat==37 % High Shear No Drops
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==0,:);	
						elseif strat==100
                                                        clear tmpyrb
                                                        if plt>=21 && plt<=23
                                                             tmp_exp([BT_obsg';BT_obsg';BT_obsg';BT_obsg']==0,:,:)=NaN;
                                                        else
                                                             tmp_exp(BT_obsg'==0,:,:)=NaN;
                                                        end
                                                        tmpnm=identinittimesunique(BT_obsg'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==888
									clear tmpyrb
									numlist=[];
									for ins=1:size(identnewsub,1)
										tmpns=identnewsub(ins,:);
										for ins2=1:size(identinittimesunique,1)
											if strcmp(identinittimesunique(ins2,:),tmpns)==1
												numlist=[numlist ins2];
											else
											end
										end
									end
									[a_ns,b_ns]=histcounts(numlist,.5:1:size(identinittimesunique,1)+.5);
									numlist=a_ns';
									numlist(numlist>0)=1;
									if plt<0
										tmp_exp([numlist;numlist+size(identinittimesunique,1)*1;numlist+size(identinittimesunique,1)*2;numlist+size(identinittimesunique,1)*3]==0,:,:)=NaN;
									else
										tmp_exp(numlist==0,:,:)=NaN;
									end                  
									tmpnm=identinittimesunique(numlist==1 & ~isnan(BT_cat1)==1,:);      
								end


								% calculate the sum of all errors
								for tmp=1:size(identexp,1);if strcmp(identexp(tmp),identexpsigimp);tmpimp=tmp;end;end;tmpu=1:size(identexp,1);tmpu(tmpu==tmpimp)=[];
								for tmp=[tmpimp,tmpu]
									imprv=squeeze(100.*(1-(tmp_exp(:,:,tmp))./(tmp_exp(:,:,tmpimp))));nm_pct(:,tmp,:)=imprv;
								end
								nm_pct=permute(nm_pct,[3 2 1]);


								for identexploop=tmpu
									tmppct=squeeze(nm_pct(:,identexploop,:));
									tmpstd=nanstd(tmppct');
									tmpmn=nanmean(tmppct,2);
									tmpval=(tmpmn+tmpstd');
									set(0,'defaultfigurecolor',[1 1 1]) % figure background color
									hfig=figure;
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
									ax1=subplot(3,4,[1:8]);
									imagesc((tmppct)','AlphaData',~isnan((tmppct)'))
									xlabel('Forecast Lead Time (h)','fontsize',14)        
									set(gca,'fontsize',14)
									box on
									if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
										if mod(identmaxfhr*3,12)==0
											xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]) 
										end
									else
										if mod(identmaxfhr*3-3,12)==0
											xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]) 
										end
									end    
									set(gca,'xtick',1:skiptick:50)
									set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
									set(gca,'fontsize',14)
									hold on                        
									ylabel('Cycle Initialization Time','fontsize',14)
												box on
												xstart=1;          
												ylim([xstart-.5 size(BT_lat,1)+.5])                                                   
												if size(identinittimesunique,1)>50
													set(gca,'ytick',1:4:100)
													set(gca,'yticklabel',identinittimesunique(1:4:end,:))
												else
													set(gca,'ytick',1:2:100)
													set(gca,'yticklabel',identinittimesunique(1:2:end,:))
												end                           
									set(gca,'fontsize',14)
									cnt=1;                                       
									colorbar
									caxis([-50 50])
									colormap(gca,custommap(20,negposc))
									hold on
									for i=1:size(tmppct,1)
										plot(repmat(0.5+i,1,size(identdr,2)+3),-1:size(identdr,2)+1,'k')
									end
									for i=1:size(tmppct,2)
										plot(-1:size(tmppct,1)+1,repmat(i-.5,1,size(tmppct,1)+3),'k')
									end
									set(gcf, 'InvertHardcopy', 'off')
									set(gcf,'Units','inches');
									screenposition = get(gcf,'Position');
									set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
									set(gcf, 'InvertHardcopy', 'off')
									tmppctstr=isnan(tmppct);
									clear diffpct
									for j=1:size(tmppct,2)
										for i=1:size(1:skip:identmaxfhr,2)
											if tmppctstr(i,j)==0
												%if sum(round(tmppct(i,:)))>100
												%	for k=1:size(tmppct,2)
												%		diffpct(k)=round(tmppct(i,k))-tmppct(i,k);
												%	end
												%	tmppct(i,find(diffpct==max(diffpct')))=tmppct(i,find(diffpct==max(diffpct')))-diffpct(k);
												%elseif sum(round(tmppct(i,:)))<100
												%	for k=1:size(tmppct,2)
												%		diffpct(k)=round(tmppct(i,k))-tmppct(i,k);
												%	end
												%	tmppct(i,find(diffpct==max(diffpct')))=tmppct(i,find(diffpct==max(diffpct')))+diffpct(k);
												%end
													if tmppct(i,j)>25 || tmppct(i,j)<-25
														text(i,j, [num2str(round(tmppct(i,j))),'%'], 'color','w','HorizontalAlignment', 'Center','fontsize',6)
													else
														text(i,j, [num2str(round(tmppct(i,j))),'%'], 'HorizontalAlignment', 'Center','fontsize',6)
													end
											end
										end
									end        
									set(gca,'TickLength',[0 0])										
									text(1,1.052,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
									text(1,1.025,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');                
									text(0,1.052,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')                                        
									tmpuv = size(tmpnm,1);                               
									tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
									if strat==1
										text(0,1.025,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									else
										text(0,1.025,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									end														
									ax=gca;
									box on
									set(ax, 'Layer', 'top')
									ax.LineWidth=1; 
									pos=get(gca,'Position');
									set(gca,'position',[pos(1)+.01 pos(2)-.33 pos(3) pos(4)+.34])
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .9, 0.96]); % maximize figure window
									f = getframe(hfig);
									if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_contr_',stname,'_',identexpshort{identexploop}];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
									close all   
								end 														
							end  																							
							% Create PPC Graphics
							for plt=[1:18,21:23] % no across or along for bias
								clear l cntexp                                   
								if plt==1
									 tmp_exp=trkerr_exp(:,1:skip:end,:);
									 tmp_name='trkerr';
									 tmp_title='Percentage Point Contribution to Track Skill (\%)';
									 tmp_ytitle='Error Contribution (\%)';
								elseif plt==2
									tmp_exp=interr_exp(:,1:skip:end,:);
									tmp_name='prserr';
									tmp_title='Percentage Point Contribution to Pressure Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==3
									tmp_exp=spderr_exp(:,1:skip:end,:);
									tmp_name='spderr';
									tmp_title='Percentage Point Contribution to Wind Speed Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								 elseif plt==4
									tmp_exp=ne34err_exp(:,1:skip:end,:);
									tmp_name='neRTSFerr';
									tmp_title='Percentage Point Contribution to RTSF NEQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==5
									tmp_exp=se34err_exp(:,1:skip:end,:);
									tmp_name='seRTSFerr';
									tmp_title='Percentage Point Contribution to RTSF SEQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==6
									tmp_exp=sw34err_exp(:,1:skip:end,:);
									tmp_name='swRTSFerr';
									tmp_title='Percentage Point Contribution to RTSF SWQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==7
									tmp_exp=nw34err_exp(:,1:skip:end,:);
									tmp_name='nwRTSFerr';
									tmp_title='Percentage Point Contribution to RTSF NWQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==8
									tmp_exp=ne50err_exp(:,1:skip:end,:);
									tmp_name='neRSFerr';
									tmp_title='Percentage Point Contribution to RSF NEQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==9
									tmp_exp=se50err_exp(:,1:skip:end,:);
									tmp_name='seRSFerr';
									tmp_title='Percentage Point Contribution to RSF SEQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==10
									tmp_exp=sw50err_exp(:,1:skip:end,:);
									tmp_name='swRSFerr';
									tmp_title='Percentage Point Contribution to RSF SWQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==11
									tmp_exp=nw50err_exp(:,1:skip:end,:);
									tmp_name='nwRSFerr';
									tmp_title='Percentage Point Contribution to RSF NWQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==12
									tmp_exp=ne64err_exp(:,1:skip:end,:);
									tmp_name='neRHFerr';
									tmp_title='Percentage Point Contribution to RHF NEQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==13
									tmp_exp=se64err_exp(:,1:skip:end,:);
									tmp_name='seRHFerr';
									tmp_title='Percentage Point Contribution to RHF SEQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==14
									tmp_exp=sw64err_exp(:,1:skip:end,:);
									tmp_name='swRHFerr';
									tmp_title='Percentage Point Contribution to RHF SWQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
									yrange=[-100 100];                 
								elseif plt==15
									tmp_exp=nw64err_exp(:,1:skip:end,:);
									tmp_name='nwRHFerr';
									tmp_title='Percentage Point Contribution to RHF NWQ Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==16
									tmp_exp=poerr_exp(:,1:skip:end,:);
									tmp_name='poerr';
									tmp_title='Percentage Point Contribution to Outer Clsd Isbr Prs Skill (hPa)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==17
									tmp_exp=roerr_exp(:,1:skip:end,:);
									tmp_name='roerr';
									tmp_title='Percentage Point Contribution to Outer Clsd Isbr Rad Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==18
									tmp_exp=rmwerr_exp(:,1:skip:end,:);
									tmp_name='rmwerr';
									tmp_title='Percentage Point Contribution to RMW Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==19
									tmp_exp=ateerr_exp(:,1:skip:end,:);
									tmp_name='ateerr';
									tmp_title='Percentage Point Contribution to Along-Track Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==20
									tmp_exp=xteerr_exp(:,1:skip:end,:);
									tmp_name='xteerr';
									tmp_title='Percentage Point Contribution to Across-Track Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==21
									tmp_exp=cat(4,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_exp1=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));
									tmp_name='RTSFerr';
									tmp_title='Percentage Point Contribution to RTSF Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==22
									tmp_exp=cat(4,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_exp1=cat(4,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
									tmp_name='RSFerr';
									tmp_title='Percentage Point Contribution to RSF Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								elseif plt==23
									tmp_exp=cat(4,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_exp1=cat(4,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
									tmp_name='RHFerr';
									tmp_title='Percentage Point Contribution to RHF Skill (\%)';
									tmp_ytitle='Error Contribution (\%)';
								end
								if plt <19 || plt >20
									tmp_exp=abs(tmp_exp); % added for MAE
								end
								 % Find which experiment to compare to
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end 
								tmpu=1:size(identexp,1);
								tmpu(tmpu==tmpimp)=[];
								if plt>=21
									tmp_exp1=abs(tmp_exp1); % added for MAE
									tmp_exp0=squeeze(100.*(1-nanmean(tmp_exp1(:,:,:),1)./nanmean(tmp_exp1(:,:,tmpimp),1)));                  
								else
									tmp_exp0=squeeze(100.*(1-nanmean(tmp_exp(:,:,:),1)./nanmean(tmp_exp(:,:,tmpimp),1)));                  
								end
								% Strat
								if strat==1
									clear tmpyrb
									tmpnm=identinittimesunique(~isnan(BT_cat1)==1,:);
								elseif strat==2
									clear tmpyrb
									if plt<0
										 tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										 tmp_exp(BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_drops'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==3
									clear tmpyrb
									if plt<0
										tmp_exp([BT_target';BT_target';BT_target';BT_target']==0,:,:)=NaN;
									else
										tmp_exp(BT_target'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_target'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==4 % TD
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:);
								elseif strat==5 % TS
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384,:,:)=NaN;
									end 
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:);
								elseif strat==6 % H12
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 ,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0,:,:)=NaN;
									end                  
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==7 % H345
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
								elseif strat==8 % N30
									clear tmpyrb
									if plt<0
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1>=30,:);
								elseif strat==9 % S30
									clear tmpyrb
									if plt<0
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30,:,:)=NaN;
									else
										tmp_exp(BT_lat1>=30,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30,:);
								elseif strat==10 % RI
									clear tmpyrb
									if plt<0
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>=15./1.94384 ,:);
								elseif strat==11 % IN
									clear tmpyrb
									if plt<0
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<5./1.94384  | BT_intch1>=15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:);
								elseif strat==12 % SS
									clear tmpyrb
									if plt<0
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=5./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1<=-5./1.94384  | BT_intch1>=5./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:);
								elseif strat==13 % W
									clear tmpyrb
									if plt<0
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-5./1.94384  | [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1>-5./1.94384  | BT_intch1<=-15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:);
								elseif strat==14 % RW
									clear tmpyrb
									if plt<0
										tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-15./1.94384 ,:,:)=NaN;
									else
										tmp_exp(BT_intch1>-15./1.94384 ,:,:)=NaN;
									end     
									tmpnm=identinittimesunique(BT_intch1<=-15./1.94384 ,:);
								elseif strat==15 %% TD strat obs only
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0 | BT_drops'==0,:,:)=NaN;
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:);
								elseif strat==16 % TS
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384 | BT_drops'==0,:,:)=NaN;
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:);
								elseif strat==17 % H12
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0  | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==0,:,:)=NaN;
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==18 % H345
									clear tmpyrb
								   if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
								   else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0| BT_drops'==0,:,:)=NaN;
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
								elseif strat==19 % N30
									clear tmpyrb
									if plt<0
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30 | BT_drops'==0,:,:)=NaN;
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==1,:);
								elseif strat==20 % S30
									clear tmpyrb
									if plt<0
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										 tmp_exp(BT_lat1>=30 | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==1,:);
								elseif strat==21
									clear tmpyrb
									if plt<0
										 tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										 tmp_exp(BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_drops'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==22
									clear tmpyrb
									if plt<0
										tmp_exp([BT_target';BT_target';BT_target';BT_target']==1,:,:)=NaN;
									else
										tmp_exp(BT_target'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_target'==0 & ~isnan(BT_cat1)==1,:);
								elseif strat==23 %% TD strat obs only
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1>=34./1.94384 | strcmp(BT_cat0,'TD')==0 | BT_drops'==1,:,:)=NaN;
									end   
									tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:);
								elseif strat==24 % TS
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==0  | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1<34./1.94384 | strcmp(BT_cat0,'TS')==0 | BT_cat1>=64./1.94384 | BT_drops'==1,:,:)=NaN;
									end            
									tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:);
								elseif strat==25 % H12
									clear tmpyrb
									if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 | [BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0  | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_cat1<64./1.94384 | BT_cat1>=96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==1,:,:)=NaN;
									 end
									tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==26 % H345
									clear tmpyrb
								   if plt<0
										tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 | strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==0 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
								   else
										tmp_exp(BT_cat1<96./1.94384 | strcmp(BT_cat0,'HU')==0 | BT_drops'==1,:,:)=NaN;
								   end
									tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
								elseif strat==27 % N30
									clear tmpyrb
									if plt<0
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_lat1<30 | BT_drops'==1,:,:)=NaN;
									 end   
									tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==0,:);
								elseif strat==28 % S30
									clear tmpyrb
									if plt<0
										tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										 tmp_exp(BT_lat1>=30 | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==0,:);
								elseif strat==29 % Low Shear
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin,:);
								elseif strat==30 % Moderate Shear
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin ,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:);
								elseif strat==31 % High Shear
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin,:);
								elseif strat==32 % Low Shear Drops
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==1,:);
								elseif strat==33 % Moderate Shear Drops
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin | BT_drops'==1,:);
								elseif strat==34 % High Shear Drops
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin | BT_drops'==0,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==1,:);
								elseif strat==35 % Low Shear No Drops
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1>=LOWbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==0,:);
								elseif strat==36 % Moderate Shear No Drops
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin | [BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1<LOWbasin | BT_shr1>HIGHbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:);
								elseif strat==37 % High Shear No Drops
									clear tmpyrb
									if plt<0
										tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin | [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:)=NaN;
									else
										tmp_exp(BT_shr1<=HIGHbasin | BT_drops'==1,:,:)=NaN;
									end
									tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==0,:);	
						elseif strat==100
                                                        clear tmpyrb
                                                        if plt>=21 && plt<=23
                                                             tmp_exp([BT_obsg';BT_obsg';BT_obsg';BT_obsg']==0,:,:)=NaN;
                                                        else
                                                             tmp_exp(BT_obsg'==0,:,:)=NaN;
                                                        end
                                                        tmpnm=identinittimesunique(BT_obsg'==1 & ~isnan(BT_cat1)==1,:);
								elseif strat==888
									clear tmpyrb
									numlist=[];
									for ins=1:size(identnewsub,1)
										tmpns=identnewsub(ins,:);
										for ins2=1:size(identinittimesunique,1)
											if strcmp(identinittimesunique(ins2,:),tmpns)==1
												numlist=[numlist ins2];
											else
											end
										end
									end
									[a_ns,b_ns]=histcounts(numlist,.5:1:size(identinittimesunique,1)+.5);
									numlist=a_ns';
									numlist(numlist>0)=1;
									if plt<0
										tmp_exp([numlist;numlist+size(identinittimesunique,1)*1;numlist+size(identinittimesunique,1)*2;numlist+size(identinittimesunique,1)*3]==0,:,:)=NaN;
									else
										tmp_exp(numlist==0,:,:)=NaN;
									end                  
									tmpnm=identinittimesunique(numlist==1 & ~isnan(BT_cat1)==1,:);      
								end
								clear imprv imprv2 sm
								if plt>=21
									for tmp=[tmpimp,tmpu]
										for istm=1:size(tmp_exp,2)
											smpsz=sum(sum(~isnan(squeeze(tmp_exp(:,istm,:,:))),1),3);
											stmerr=nansum(squeeze((tmp_exp(:,istm,tmp,:))),2)./smpsz(tmp);stmerrnan=squeeze(sum((isnan(tmp_exp(:,istm,tmp,:))),1));stmerr(stmerrnan==200)=NaN;
											%stmerr(all(isnan(squeeze((tmp_exp(:,istm,tmp,:)))),2))=NaN;
											imperr=nansum(squeeze((tmp_exp(:,istm,tmpimp,:))),2)./smpsz(tmpimp);imperrnan=squeeze(sum((isnan(tmp_exp(:,istm,tmpimp,:))),1));imperr(imperrnan==200)=NaN;
											%imperr(all(isnan(squeeze((tmp_exp(:,istm,tmpimp,:)))),2))=NaN;
											imperrsum=nansum(nansum(squeeze((tmp_exp(:,istm,tmpimp,:))),1))./smpsz(tmpimp);;
											imprv0=-100.*(((stmerr-imperr)+imperrsum)./imperrsum-1);
											imprv0(all(isnan(squeeze((tmp_exp(:,istm,tmp,:))))&isnan(squeeze((tmp_exp(:,istm,tmpimp,:)))),2))=NaN;
											imprv(istm,:)=imprv0;
											sm(istm)=nansum(imprv(istm,:));
										end  
										imprv2(:,:,tmp)=imprv;     										
									end  
								else
									for tmp=[tmpimp,tmpu]
										for istm=1:size(tmp_exp,2)
											smpsz=sum(~isnan(squeeze(tmp_exp(:,istm,:))),1); if size(tmp_exp,1)==1 smpsz=sum(~isnan(squeeze(tmp_exp(:,istm,:))'),1); end
											stmerr=squeeze((tmp_exp(:,istm,tmp)))./smpsz(tmp);stmerrnan=squeeze(sum((isnan(tmp_exp(:,istm,tmp,:))),1));stmerr(stmerrnan==200)=NaN;
											imperr=squeeze((tmp_exp(:,istm,tmpimp)))./smpsz(tmpimp); imperrnan=squeeze(sum((isnan(tmp_exp(:,istm,tmpimp,:))),1));imperr(imperrnan==200)=NaN;
											imperrsum=nansum(squeeze((tmp_exp(:,istm,tmpimp))),1)./smpsz(tmpimp);;
											imprv(istm,:)=-100.*(((stmerr-imperr)+imperrsum)./imperrsum-1);
											sm(istm)=nansum(imprv(istm,:));
										end  
										imprv2(:,:,tmp)=imprv;     										
									end  
								end
								nm_pct = imprv2;
								clear imprv imprv2 sm
								
								for identexploop=tmpu
									tmppct=squeeze(nm_pct(:,:,identexploop));                                       
									set(0,'defaultfigurecolor',[1 1 1]) % figure background color
									hfig=figure;
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
									ax1=subplot(3,4,[1:8]);
									imagesc((tmppct)','AlphaData',~isnan((tmppct)'))
									xlabel('Forecast Lead Time (h)','fontsize',14)        
									set(gca,'fontsize',14)
									box on
									if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
										if mod(identmaxfhr*3,12)==0
											xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]) 
										end
									else
										if mod(identmaxfhr*3-3,12)==0
											xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]) 
										end
									end    
									set(gca,'xtick',1:skiptick:50)
									set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
									set(gca,'fontsize',14)
									hold on                        
									ylabel('Cycle Initialization Time','fontsize',14)
									set(gca,'fontsize',14)
									box on
									xstart=1;          
									ylim([xstart-.5 size(BT_lat,1)+.5])                                                   
									if size(identinittimesunique,1)>50
										set(gca,'ytick',1:4:100)
										set(gca,'yticklabel',identinittimesunique(1:4:end,:))
									else
										set(gca,'ytick',1:2:100)
										set(gca,'yticklabel',identinittimesunique(1:2:end,:))
									end                           
									set(gca,'fontsize',14)
									cnt=1;                       
									colorbar
									caxis([-5 5])
									run customcolorbars
									cl=colorbar;
									colormap(gca,custommap(20,negposc))														
									hold on
									for i=1:size(tmppct,1)
										plot(repmat(0.5+i,1,size(identdr,2)+3),-1:size(identdr,2)+1,'k')
									end
									for i=1:size(tmppct,2)
										plot(-1:size(tmppct,1)+1,repmat(i-.5,1,size(tmppct,1)+3),'k')
									end
									set(gcf, 'InvertHardcopy', 'off')
									set(gcf,'Units','inches');
									screenposition = get(gcf,'Position');
									set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
									set(gcf, 'InvertHardcopy', 'off')
									tmppctstr=isnan(tmppct);
									clear diffpct
									for j=1:size(tmppct,2)
										for i=1:size(1:skip:identmaxfhr,2)
											if tmppctstr(i,j)==0                                                   
													if tmppct(i,j)>5/2 || tmppct(i,j)<-5/2
														text(i,j, [num2str(round(tmppct(i,j),1)),'%'], 'color','w','HorizontalAlignment', 'Center','fontsize',6)
													else
														text(i,j, [num2str(round(tmppct(i,j),1)),'%'], 'HorizontalAlignment', 'Center','fontsize',6)
													end
											end
										end
									end        
									set(gca,'TickLength',[0 0])
									tmpuv = size(tmpnm,1);                               
									tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
									text(1,1.06,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
									if strat==1
										text(0,1.03,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									else
										text(0,1.03,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									end
									text(0,1.06,['\textbf{',tmp_title,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')                                                                                
									text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									ax=gca;
									box on
									set(ax, 'Layer', 'top')
									ax.LineWidth=1; 
									pos=get(gca,'Position');
									set(gca,'position',[pos(1)+.01 pos(2) pos(3) pos(4)])
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .9, 0.96]); % maximize figure window
									
									
									ax2=subplot(3,4,[9:12]);
									tmppct2=nansum(tmppct,2);
									imagesc(tmppct2','AlphaData',~isnan(tmppct2'))
									%xlabel('Forecast Lead Time (h)','fontsize',14)        
									set(gca,'fontsize',14)
									box on
									if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
										if mod(identmaxfhr*3,12)==0
											xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]) 
										end
									else
										if mod(identmaxfhr*3-3,12)==0
											xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]) 
										end
									end    
									set(gca,'xtick',[])
									set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
									set(gca,'fontsize',14)
									hold on                        
									ylabel('','fontsize',14)                                   
									set(gca,'fontsize',14)
									set(gca,'ytick',1)
									cnt=1;
									set(gca,'yticklabel','Composite');
									colorbar
									% YRANGE
									clear allquad imprv3
									imprv3(:,:,1)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,2)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,3)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,4)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,5)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,6)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,7)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,8)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,9)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:end,:)),1)./nanmean(abs(ne34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,10)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:end,:)),1)./nanmean(abs(se34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,11)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(nw34err_exp(:,1:skip:end,tmpimp)),1));
									imprv3(:,:,12)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:end,:)),1)./nanmean(abs(sw34err_exp(:,1:skip:end,tmpimp)),1));
									allquadmax=max(max(max(imprv3)));
									allquadmin=min(min(min(imprv3)));
									tmpvalq=max(abs(allquadmin),abs(allquadmax));
									if isnan(tmpvalq)==1
										tmpvalq=0;
									end
									if numel(num2str(tmpvalq))==3
										addfacq=100;
									elseif numel(num2str(tmpvalq))==2
										addfacq=20;
									else
										addfacq=20;
									end

									if numel(num2str(round(max(tmp_exp0(:)))))==3
										addfac=100;
									elseif numel(num2str(round(max(tmp_exp0(:)))))==2
										addfac=20;
									else
										addfac=20;
									end
									if plt<=3 || (plt>=16 && plt<=18) % 0-end
										tmpmin=min(tmp_exp0(:));
										tmpmax=max(tmp_exp0(:));
										tmpval=max(abs(tmpmin),abs(tmpmax));
										if isnan(tmpval)==1
											tmpval=0;
										end
										if tmpval>250
											yrange=[-250 250];
										else
											yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
										end
									elseif plt==19 || plt==20 % -end end 
										tmpmin=min(tmp_exp0(:));
										tmpmax=max(tmp_exp0(:));
										tmpval=max(abs(tmpmin),abs(tmpmax));
										if isnan(tmpval)==1
											tmpval=0;
										end
										if tmpval>250
											yrange=[-250 250];
										else
											yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
										end
									elseif (plt>=4 && plt<=15) || plt>=21%quad 
										if tmpvalq>250
											yrange=[-250 250];
										else
											yrange=[-round((tmpvalq+addfacq)/10)*10 round((tmpvalq+addfacq)/10)*10];
										end
									end
									caxis(yrange)
									run customcolorbars
									cl=colorbar;
									colormap(gca,custommap(20,negposc))		
									set(cl,'ticks',yrange(:),'fontsize',14)																								
									hold on
									for i=1:size(tmppct2,1)
										plot(repmat(0.5+i,1,size(identdr,2)+3),-1:size(identdr,2)+1,'k')
									end
									for i=1:size(tmppct2,2)
										plot(-1:size(tmppct2,1)+1,repmat(i-.5,1,size(tmppct2,1)+3),'k')
									end
									set(gcf, 'InvertHardcopy', 'off')
									set(gcf,'Units','inches');
									screenposition = get(gcf,'Position');
									set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
									set(gcf, 'InvertHardcopy', 'off')
									tmppctstr=isnan(tmppct2);
									clear diffpct
									for j=1:size(tmppct2,2)
										for i=1:size(tmppct2,1)
											if tmppctstr(i,j)==0                                                   
													if tmppct2(i,j)>yrange(2)/2 || tmppct2(i,j)<yrange(1)/2
														text(i,j, [num2str(round(tmppct2(i,j),1)),'%'], 'color','w','HorizontalAlignment', 'Center','fontsize',10)
													else
														text(i,j, [num2str(round(tmppct2(i,j),1)),'%'], 'HorizontalAlignment', 'Center','fontsize',10)
													end
											end
										end
									end        
									set(gca,'TickLength',[0 0])
									ax=gca;
									box on
									set(ax, 'Layer', 'top')
									ax.LineWidth=1;                                         
									pos=get(ax1,'Position');
									set(ax1,'position',[pos(1) pos(2)-.2 pos(3) pos(4)+.2])
									set(ax2,'position',[pos(1) pos(2)-.31 pos(3) pos(4)-.48])
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .9, 0.96]); % maximize figure window
									f = getframe(hfig);
									if identeps==1;filename=[identtrackint,'/',identn,'_',tmp_name,'_PPC_',stname,'_',identexpshort{identexploop}];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
									%print([identtrackint,'/trackcomp_fhr_',num2str((fhr-1)*3),'h'],'-dpdf','-r200');
									close all   
								end 
							end                             												
							% Scorecard
							for scorecard=1
								% Which Experiment to Compare To
								for tmp=1:size(identexp,1)
									if strcmp(identexp(tmp),identexpsigimp)
										tmpimp=tmp;
									end
								end      
								tmpu=1:size(identexp,1);
								tmpu(tmpu==tmpimp)=[];

								for identexploop=tmpu % loop over experiments   
									% Compute Error, Skill, Bias, and FSP (wrt 50%) for all Variables
									for plt=1:9
										if plt==1
											 tmp_exp=(trkerr_exp(:,1:skip:end,:));plt0=1;
											 tmp_name='trkerr';
											 tmp_title='Track Error (km)';
											 tmp_ytitle='Error (km)';                                    
										elseif plt==3
											tmp_exp=interr_exp(:,1:skip:end,:);plt0=2;
											tmp_name='prserr';
											tmp_title='Pressure Error (hPa)';
											tmp_ytitle='Error (hPa)';
										elseif plt==2
											tmp_exp=spderr_exp(:,1:skip:end,:);plt0=3;
											tmp_name='spderr';
											tmp_title='Wind Speed Error (m/s)';
											tmp_ytitle='Error (m/s)';                                 
										elseif plt==7
											tmp_exp=rmwerr_exp(:,1:skip:end,:);plt0=18;
											tmp_name='rmwerr';
											tmp_title='RMW Error (km)';
											tmp_ytitle='Error (km)';                                
										elseif plt==4
											tmp_exp=cat(1,ne34err_exp(:,1:skip:end,:),nw34err_exp(:,1:skip:end,:),se34err_exp(:,1:skip:end,:),sw34err_exp(:,1:skip:end,:));plt0=21;
											tmp_name='RTSFerr';
											tmp_title='RTSF Error (km)';
											tmp_ytitle='Error (km)';
										elseif plt==5
											tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));plt0=22;
											tmp_name='RSFerr';
											tmp_title='RSF Error (km)';
											tmp_ytitle='Error (km)';
										elseif plt==6
											tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));plt0=23;
											tmp_name='RHFerr';
											tmp_title='RHF Error (km)';
											tmp_ytitle='Error (km)';                                    
										elseif plt==8
											tmp_exp=ateerr_exp(:,1:skip:end,:);plt0=19;
											tmp_name='ateerr';
											tmp_title='Along-Track Error (km)';
											tmp_ytitle='Error (km)';
										elseif plt==9
											tmp_exp=xteerr_exp(:,1:skip:end,:);plt0=20;
											tmp_name='xteerr';
											tmp_title='Across-Track Error (km)';
											tmp_ytitle='Error (km)';
										end
										
										 % Strat
										if strat==1
											clear tmpyrb
											tmpnm=identinittimesunique(~isnan(BT_cat1)==1,:);
										elseif strat==2
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
											else
												tmp_exp=tmp_exp(BT_drops==1,:,:);
											end
											tmpnm=identinittimesunique(BT_drops'==1 & ~isnan(BT_cat1)==1,:);
										elseif strat==3
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_target';BT_target';BT_target';BT_target']==1,:,:);
											else
												tmp_exp=tmp_exp(BT_target==1,:,:);
											end
											tmpnm=identinittimesunique(BT_target'==1 & ~isnan(BT_cat1)==1,:);
										elseif strat==4 % TD
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1 ,:,:);
											else
												tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:,:);
											end
											tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1,:);
										elseif strat==5 % TS
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1 ,:,:);
											else
												tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:,:);
											end 
											tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1,:);
										elseif strat==6 % H12
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1 ,:,:);
											else
												tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:,:);
											end                  
											tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
										elseif strat==7 % H345
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1 ,:,:);
											else
												tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:,:);
											end     
											tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1,:);
										elseif strat==8 % N30
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30,:,:);
											else
												tmp_exp=tmp_exp(BT_lat1>=30,:,:);
											end
											tmpnm=identinittimesunique(BT_lat1>=30,:);
										elseif strat==9 % S30
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30,:,:);
											else
												tmp_exp=tmp_exp(BT_lat1<30,:,:);
											end
											tmpnm=identinittimesunique(BT_lat1<30,:);                                                    
										elseif strat==10 % RI
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=15./1.94384 ,:,:);
											else
												tmp_exp=tmp_exp(BT_intch1>=15./1.94384 ,:,:);
											end     
											tmpnm=identinittimesunique(BT_intch1>=15./1.94384 ,:);
										elseif strat==11 % IN
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>=5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<15./1.94384 ,:,:);
											else
												tmp_exp=tmp_exp(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:,:);
											end     
											tmpnm=identinittimesunique(BT_intch1>=5./1.94384  & BT_intch1<15./1.94384 ,:);
										elseif strat==12 % SS
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]<5./1.94384 ,:,:);
											else
												tmp_exp=tmp_exp(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:,:);
											end     
											tmpnm=identinittimesunique(BT_intch1>-5./1.94384  & BT_intch1<5./1.94384 ,:);
										elseif strat==13 % W
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-5./1.94384  & [BT_intch1;BT_intch1;BT_intch1;BT_intch1]>-15./1.94384 ,:,:);
											else
												tmp_exp=tmp_exp(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:,:);
											end     
											tmpnm=identinittimesunique(BT_intch1<=-5./1.94384  & BT_intch1>-15./1.94384 ,:);
										elseif strat==14 % RW
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_intch1;BT_intch1;BT_intch1;BT_intch1]<=-15./1.94384 ,:,:);
											else
												tmp_exp=tmp_exp(BT_intch1<=-15./1.94384 ,:,:);
											end     
											tmpnm=identinittimesunique(BT_intch1<=-15./1.94384 ,:);													
										elseif strat==15 %% TD strat obs only
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
											else
												tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:,:);
											end   
											tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==1,:);
										elseif strat==16 % TS
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
											else
												tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:,:);
											end            
											tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==1,:);
										elseif strat==17 % H12
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
											else
												tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:,:);
											 end
											tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
										elseif strat==18 % H345
											clear tmpyrb
										   if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
										   else
												tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:,:);
										   end
											tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==1,:);
										elseif strat==19 % N30
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
											else
												tmp_exp=tmp_exp(BT_lat1>=30 & BT_drops'==1,:,:);
											 end   
											tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==1,:);
										elseif strat==20 % S30
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
											else
												tmp_exp=tmp_exp(BT_lat1<30 & BT_drops'==1,:,:);
											end
											tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==1,:);                                        
										elseif strat==21
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
											else
												tmp_exp=tmp_exp(BT_drops==0,:,:);
											end
											tmpnm=identinittimesunique(BT_drops'==0 & ~isnan(BT_cat1)==1,:);
										elseif strat==22
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_target';BT_target';BT_target';BT_target']==0,:,:);
											else
												tmp_exp=tmp_exp(BT_target==0,:,:);
											end
											tmpnm=identinittimesunique(BT_target'==0 & ~isnan(BT_cat1)==1,:);
										elseif strat==23 %% TD strat NOOBS only
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]<34./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TD')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
											else
												tmp_exp=tmp_exp(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:,:);
											end   
											tmpnm=identinittimesunique(BT_cat1<34./1.94384 & strcmp(BT_cat0,'TD')==1 & BT_drops'==0,:);
										elseif strat==24 % TS
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=34./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<64./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'TS')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
											else
												tmp_exp=tmp_exp(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:,:);
											end            
											tmpnm=identinittimesunique(BT_cat1>=34./1.94384 & BT_cat1<64./1.94384 & strcmp(BT_cat0,'TS')==1 & BT_drops'==0,:);
										elseif strat==25 % H12
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=64./1.94384 & [BT_cat1;BT_cat1;BT_cat1;BT_cat1]<96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
											else
												tmp_exp=tmp_exp(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:,:);
											 end
											tmpnm=identinittimesunique(BT_cat1>=64./1.94384 & BT_cat1<96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
										elseif strat==26 % H345
											clear tmpyrb
										   if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_cat1;BT_cat1;BT_cat1;BT_cat1]>=96./1.94384 & strcmp([BT_cat0;BT_cat0;BT_cat0;BT_cat0],'HU')==1  & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
										   else
												tmp_exp=tmp_exp(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:,:);
										   end
											tmpnm=identinittimesunique(BT_cat1>=96./1.94384 & strcmp(BT_cat0,'HU')==1 & BT_drops'==0,:);
										elseif strat==27 % N30
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]>=30 & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
											else
												tmp_exp=tmp_exp(BT_lat1>=30 & BT_drops'==0,:,:);
											 end   
											tmpnm=identinittimesunique(BT_lat1>=30 & BT_drops'==0,:);
										elseif strat==28 % S30
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_lat1;BT_lat1;BT_lat1;BT_lat1]<30 & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
											else
												tmp_exp=tmp_exp(BT_lat1<30 & BT_drops'==0,:,:);
											end
											tmpnm=identinittimesunique(BT_lat1<30 & BT_drops'==0,:);
										elseif strat==29 % Low Shear
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin,:,:);
											else
												tmp_exp=tmp_exp(BT_shr1<LOWbasin,:,:);
											end
											tmpnm=identinittimesunique(BT_shr1<LOWbasin,:);
										elseif strat==30 % Moderate Shear
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin ,:,:);
											else
												tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:,:);
											end
											tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin,:);
										elseif strat==31 % High Shear
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin,:,:);
											else
												tmp_exp=tmp_exp(BT_shr1>HIGHbasin,:,:);
											end
											tmpnm=identinittimesunique(BT_shr1>HIGHbasin,:);
										elseif strat==32 % Low Shear Drops
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
											else
												tmp_exp=tmp_exp(BT_shr1<LOWbasin & BT_drops'==1,:,:);
											end
											tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==1,:);
										elseif strat==33 % Moderate Shear Drops
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
											else
												tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==1,:,:);
											end
											tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==1,:);
										elseif strat==34 % High Shear Drops
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==1,:,:);
											else
												tmp_exp=tmp_exp(BT_shr1>HIGHbasin & BT_drops'==1,:,:);
											end
											tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==1,:);
										elseif strat==35 % Low Shear No Drops
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]<LOWbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
											else
												tmp_exp=tmp_exp(BT_shr1<LOWbasin & BT_drops'==0,:,:);
											end
											tmpnm=identinittimesunique(BT_shr1<LOWbasin & BT_drops'==0,:);
										elseif strat==36 % Moderate Shear No Drops
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>=LOWbasin & [BT_shr1;BT_shr1;BT_shr1;BT_shr1]<=HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
											else
												tmp_exp=tmp_exp(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:,:);
											end
											tmpnm=identinittimesunique(BT_shr1>=LOWbasin & BT_shr1<=HIGHbasin & BT_drops'==0,:);
										elseif strat==37 % High Shear No Drops
											clear tmpyrb
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([BT_shr1;BT_shr1;BT_shr1;BT_shr1]>HIGHbasin & [BT_drops';BT_drops';BT_drops';BT_drops']==0,:,:);
											else
												tmp_exp=tmp_exp(BT_shr1>HIGHbasin & BT_drops'==0,:,:);
											end
											tmpnm=identinittimesunique(BT_shr1>HIGHbasin & BT_drops'==0,:);	
															elseif strat==100
																clear tmpyrb
																if plt>=4 && plt<=6
																	tmp_exp=tmp_exp([BT_obsg';BT_obsg';BT_obsg';BT_obsg']==1,:,:);
																else
																	tmp_exp=tmp_exp(BT_obsg==1,:,:);
																end
																tmpnm=identinittimesunique(BT_obsg'==1 & ~isnan(BT_cat1)==1,:);
										elseif strat==888
											clear tmpyrb
											numlist=[];
											for ins=1:size(identnewsub,1)
												tmpns=identnewsub(ins,:);
												for ins2=1:size(identinittimesunique,1)
													if strcmp(identinittimesunique(ins2,:),tmpns)==1
														numlist=[numlist ins2];
													end
												end
											end
											if plt>=21 && plt<=23
												tmp_exp=tmp_exp([numlist;numlist+size(identinittimesunique,1)*1;numlist+size(identinittimesunique,1)*2;numlist+size(identinittimesunique,1)*3],:,:);
											else
												tmp_exp=tmp_exp(numlist,:,:);
											end                  
											tmpnmbtcat=BT_cat1(numlist); tmpnm=identinittimesunique(numlist,:); tmpnm=tmpnm(~isnan(tmpnmbtcat)==1,:);
										end    
																			   
										
										
										if plt <8
											tmp_err(:,:,plt)=squeeze(nanmean(abs(tmp_exp),1));tmp_errmed(:,:,plt)=squeeze(nanmedian(abs(tmp_exp),1));                                                                          
										else
											tmp_err(:,:,plt)=squeeze(nanmean((tmp_exp),1)); tmp_errmed(:,:,plt)=squeeze(nanmedian((tmp_exp),1));                                                                          
										end
										if sum(isnan(ttestsc(abs(tmp_exp(:,:,identexploop)),abs(tmp_exp(:,:,tmpimp)),squeeze(scfactor(plt0,identexploop,:))','alpha',.05)'))==0 sigtest_95(:,plt)=repmat(0,1,size(tmp_exp,2)); else sigtest_95(:,plt)=ttestsc(abs(tmp_exp(:,:,identexploop)),abs(tmp_exp(:,:,tmpimp)),squeeze(scfactor(plt0,identexploop,:))','alpha',.05)'; end
										if sum(isnan(ttestsc(abs(tmp_exp(:,:,identexploop)),abs(tmp_exp(:,:,tmpimp)),squeeze(scfactor(plt0,identexploop,:))','alpha',.1)'))==0 sigtest_90(:,plt)=repmat(0,1,size(tmp_exp,2));; else sigtest_90(:,plt)=ttestsc(abs(tmp_exp(:,:,identexploop)),abs(tmp_exp(:,:,tmpimp)),squeeze(scfactor(plt0,identexploop,:))','alpha',.1)';   end                                                                                                       
										tmp_imp(:,plt)=squeeze(100.*(1-nanmean(abs(tmp_exp(:,:,identexploop)),1)./nanmean(abs(tmp_exp(:,:,tmpimp)),1)))';tmp_impmed(:,plt)=squeeze(100.*(1-nanmedian(abs(tmp_exp(:,:,identexploop)),1)./nanmedian(abs(tmp_exp(:,:,tmpimp)),1)))';
										tmp1=abs(tmp_exp(:,:,identexploop));
										tmp2=abs(tmp_exp(:,:,tmpimp));
										tmp3=sign(tmp1-tmp2);
										tmp4=tmp3<0;
										tmp5=tmp3>0;
										tmp6=tmp3==0;
										tmptmp=sum(~isnan(tmp3),1);                            
										tmp_bias(:,:,plt)=squeeze(nanmean((tmp_exp),1));
										tmp_fsp(:,plt)=squeeze(100*(nansum(tmp4,1)+nansum(tmp6,1)./2)./tmptmp)'-50;  
										for tmp=1:size(identexp,1)
											tmp_fcst(:,tmp,plt)=sum(~isnan(tmp_exp(:,:,tmp)),1);
										end 
									end        
									
									%% CONSISTENCY SCORECARD		
									% Specify y labels
									tmp_ytitle={'TRACK','WIND SPEED','PRESSURE','RTSF','RSF','RHF'}';
									sconsistent=nan(6,size(tmp_imp,1));
									for vari=1:6
										a=find(tmp_imp(:,vari)>=1 & tmp_fsp(:,vari)>=((0.5.*tmp_fcst(:,1,vari)+max(5,0.01.*tmp_fcst(:,1,vari)))./tmp_fcst(:,1,vari)*100-50) & tmp_impmed(:,vari)>=1);
										sconsistent(vari,a)=2;
										b=find((tmp_imp(:,vari)>=1 & tmp_fsp(:,vari)>=((0.5.*tmp_fcst(:,1,vari)+max(5,0.01.*tmp_fcst(:,1,vari)))./tmp_fcst(:,1,vari)*100-50) & tmp_impmed(:,vari)>-1) | (tmp_imp(:,vari)>=1 & tmp_fsp(:,vari)>-((0.5.*tmp_fcst(:,1,vari)+max(5,0.01.*tmp_fcst(:,1,vari)))./tmp_fcst(:,1,vari)*100-50) & tmp_impmed(:,vari)>=1) | (tmp_imp(:,vari)>-1 & tmp_fsp(:,vari)>=((0.5.*tmp_fcst(:,1,vari)+max(5,0.01.*tmp_fcst(:,1,vari)))./tmp_fcst(:,1,vari)*100-50) & tmp_impmed(:,vari)>=1));
										[~,~,ind]  = intersect(a,b);
										b=b(~(ismember(1:numel(b),ind)));
										sconsistent(vari,b)=1;
										c=find(tmp_imp(:,vari)<=-1 & tmp_fsp(:,vari)<=-((0.5.*tmp_fcst(:,1,vari)+max(5,0.01.*tmp_fcst(:,1,vari)))./tmp_fcst(:,1,vari)*100-50) & tmp_impmed(:,vari)<=-1);sconsistent(vari,c)=-2;
										d=find((tmp_imp(:,vari)<=-1 & tmp_fsp(:,vari)<=-((0.5.*tmp_fcst(:,1,vari)+max(5,0.01.*tmp_fcst(:,1,vari)))./tmp_fcst(:,1,vari)*100-50) & tmp_impmed(:,vari)<1) | (tmp_imp(:,vari)<=-1 & tmp_fsp(:,vari)<((0.5.*tmp_fcst(:,1,vari)+max(5,0.01.*tmp_fcst(:,1,vari)))./tmp_fcst(:,1,vari)*100-50) & tmp_impmed(:,vari)<=-1) | (tmp_imp(:,vari)<1 & tmp_fsp(:,vari)<=-((0.5.*tmp_fcst(:,1,vari)+max(5,0.01.*tmp_fcst(:,1,vari)))./tmp_fcst(:,1,vari)*100-50) & tmp_impmed(:,vari)<=-1));
										[~,~,ind]  = intersect(c,d);
										d=d(~(ismember(1:numel(d),ind)));
										sconsistent(vari,d)=-1;
									end

									% Start Figure
									clear l cntexp;set(0,'defaultfigurecolor',[1 1 1]);hfig=figure;set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);hold on;

									% Plot Matrix & Flip
									imagesc(sconsistent,'AlphaData',~isnan((sconsistent)));axis ij;

									% Markers for Stat. Sig.
									cnt=1;for i=1:6;for j=1:size(sconsistent,2);if sigtest_90(j,cnt)+sigtest_95(j,cnt)==2;plot(j,i,'s','Color','k','markerfacecolor','k','markersize',7);elseif sigtest_90(j,cnt)+sigtest_95(j,cnt)==1;plot(j,i,'o','Color','k','markersize',5.5,'markerfacecolor','k');else;end;end;cnt=cnt+1;end;

									% X- and Y- Axes: Ticks, Labels, Ranges
									xlabel('Forecast Lead Time (h)','fontsize',20);set(gca,'fontsize',14);box on;if mod(identmaxfhr*3,skiphr)==0;if mod(identmaxfhr*3,12)==0;xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5]);else;xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]);end;else;if mod(identmaxfhr*3-3,12)==0;xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5]);else;xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]);end;end;
									set(gca,'xtick',1:skiptick:50);set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24);set(gca,'fontsize',16);ylim([0.5 size(sconsistent,1)+.5]);set(gca,'ytick',1:1:size(sconsistent,1)+.5);set(gca,'yticklabel',tmp_ytitle);set(gca,'TickLength',[0 0])

									% Colormap
									colorbar;caxis([-2.5 2.5]);run customcolorbars;cl=colorbar;cl.Ticks=[-2:1:2];colormap(gca,flipud([56 87 35;169 209 142;229.5 229.5 229.5;244 177 131;132 60 12]/255))

									% Create Gridlines
									for i=1:size(sconsistent,2);plot(repmat(0.5+i,1,size(sconsistent,1)+3),-1:size(sconsistent,1)+1,'k');end;plot(-1:size(sconsistent,2)+1,repmat(1.5,size(sconsistent,2)+3,1),'k','linewidth',2);plot(-1:size(sconsistent,2)+1,repmat(2.5,size(sconsistent,2)+3,1),'k','linewidth',2);plot(-1:size(sconsistent,2)+1,repmat(3.5,size(sconsistent,2)+3,1),'k','linewidth',2);plot(-1:size(sconsistent,2)+1,repmat(4.5,size(sconsistent,2)+3,1),'k','linewidth',2);plot(-1:size(sconsistent,2)+1,repmat(5.5,size(sconsistent,2)+3,1),'k','linewidth',2);plot(-1:size(sconsistent,2)+1,repmat(6.5,size(sconsistent,2)+3,1),'k','linewidth',2);

									% Title Text
									text(0,1.11,['\textbf{Consistency Scorecard}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');text(1,1.11,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');text(1,1.06,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');tmpuv = size(tmpnm,1);tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];if strat==1;text(0,1.06,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');else;	text(0,1.06,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');end;

									% Figure Sizing & Printing
									set(gcf, 'InvertHardcopy', 'off');ax=gca;box on;set(ax, 'Layer', 'top');ax.LineWidth=2;set(gca,'position',[spPos(1)+.04 spPos(2) spPos(3) spPos(4)]);set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, .5, .2]);set(gca,'Color',[.9 .9 .9]);set(gcf,'Units','inches');screenposition = get(gcf,'Position');set(gcf,'PaperPosition',[0 0 screenposition(3)+3 screenposition(4)+3],'PaperSize',[screenposition(3)+3 screenposition(4)+3]);consPos=get(cl,'position');set(cl,'position',[consPos(1)+.005 consPos(2) consPos(3)+.01 consPos(4)]);ticks = strsplit(num2str(cl.Ticks));ax = axes('Position', cl.Position);edges = linspace(0,1,numel(ticks)+1);centers = edges(2:end)-((edges(2)-edges(1))/2);text(ones(size(centers))*0.5, centers, {'C','MC','','MC','C'},'FontSize',cl.FontSize,'HorizontalAlignment','Center','VerticalAlignment','Middle','color','w');ax.Visible = 'off';cl.Ticks = [];text(1.2,.2,['\textbf{Degradation}'],'color','k','rotation',270,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex');text(1.2,.8,['\textbf{Improvement}'],'color','k','rotation',270,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex');									if identeps==1;filename=[identtrackint,'/',identn,'_',stname,'_CONSISTENCYSCORECARD','_',identexpshort{identexploop}];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;print('-dpng',filename);end;close all;
									
									%% BACK TO SCORECARD
									% Specify y labels
									tmp_ytitle={'Mean Error (km)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean AT Bias (km)','Mean XT Bias (km)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.','Mean Error (m/s)','Mean Imp. (%)','FSP (wrt 50%)','Median Error (km)','Median Imp. (%)','Mean Bias (m/s)','# fcsts','Stat. Sig.'}';									
							
									% Generate Matrix
									sc=nan(57,size(tmp_imp,1));
									% TRACK
									sc(1,:)=NaN; % error
									sc(2,:)=tmp_imp(:,1); % imprv
									sc(3,:)=tmp_fsp(:,1); % fsp
									sc(4,:)=NaN; sc(5,:)=tmp_impmed(:,1); sc(6,:)=NaN; % bias
									sc(7,:)=NaN; % bias
									sc(8,:)=NaN; % #fcst
									sc(9,:)=NaN; % sig.
									%WIND SPEED
									sc(10,:)=NaN; % error
									sc(11,:)=tmp_imp(:,2); % imprv
									sc(12,:)=tmp_fsp(:,2); % fsp
									sc(13,:)=NaN; sc(14,:)=tmp_impmed(:,2); sc(15,:)=NaN; % bias
									sc(16,:)=NaN; % #fcst
									sc(17,:)=NaN; % sig.
									% PRESSURE
									sc(18,:)=NaN; % error
									sc(19,:)=tmp_imp(:,3); % imprv
									sc(20,:)=tmp_fsp(:,3); % fsp
									sc(21,:)=NaN; sc(22,:)=tmp_impmed(:,3);sc(23,:)=NaN; % bias
									sc(24,:)=NaN; % #fcst
									sc(25,:)=NaN; % sig.
									% RTSF
									sc(26,:)=NaN; % error
									sc(27,:)=tmp_imp(:,4); % imprv
									sc(28,:)=tmp_fsp(:,4); % fsp
									sc(29,:)=NaN; sc(30,:)=tmp_impmed(:,4);sc(31,:)=NaN; % bias
									sc(32,:)=NaN; % #fcst
									sc(33,:)=NaN; % sig.
									% RSF
									sc(34,:)=NaN; % error
									sc(35,:)=tmp_imp(:,5); % imprv
									sc(36,:)=tmp_fsp(:,5); % fsp
									sc(37,:)=NaN; sc(38,:)=tmp_impmed(:,5);sc(39,:)=NaN; % bias
									sc(40,:)=NaN; % #fcst
									sc(41,:)=NaN; % sig.
									% RHF
									sc(42,:)=NaN; % error
									sc(43,:)=tmp_imp(:,6); % imprv
									sc(44,:)=tmp_fsp(:,6); % fsp
									sc(45,:)=NaN; sc(46,:)=tmp_impmed(:,6);sc(47,:)=NaN; % bias
									sc(48,:)=NaN; % #fcst
									sc(49,:)=NaN; % sig.
									% RMW
									sc(50,:)=NaN; % error
									sc(51,:)=tmp_imp(:,7); % imprv
									sc(52,:)=tmp_fsp(:,7); % fsp
									sc(53,:)=NaN; sc(54,:)=tmp_impmed(:,7);sc(55,:)=NaN; % bias
									sc(56,:)=NaN; % #fcst
									sc(57,:)=NaN; % sig.

									% Start Figure
									clear l cntexp
									set(0,'defaultfigurecolor',[1 1 1]) % figure background color
									hfig=figure;
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
									%ax1=subplot(3,4,[1:8]);   
									hold on

									% Plot Matrix & Flip
									imagesc(sc,'AlphaData',~isnan((sc)))
									axis ij

									% X- and Y- Axes: Ticks, Labels, Ranges
									xlabel('Forecast Lead Time (h)','fontsize',20)
									set(gca,'fontsize',14)
									box on
									if mod(identmaxfhr*3,skiphr)==0  % xrange to nearest tickmark
										if mod(identmaxfhr*3,12)==0
											xlim([0.5 (((identmaxfhr*3))/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)+(12-mod(identmaxfhr*3,12)))/skiphr+1)-.5]) 
										end
									else
										if mod(identmaxfhr*3-3,12)==0
											xlim([0.5 (((identmaxfhr*3)-3)/skiphr+1)+.5])
										else
											xlim([0.5 (((identmaxfhr*3)-3+(12-mod(identmaxfhr*3-3,12)))/skiphr+1)-.5]) 
										end
									end    
									set(gca,'xtick',1:skiptick:50)
									set(gca,'xticklabel',0:skiphr*skiptick:(identmaxfhr*3)+24) 
									set(gca,'fontsize',9)
									ylim([0.5 size(sc,1)+.5])
									set(gca,'ytick',1:1:size(sc,1)+.5)
									set(gca,'yticklabel',tmp_ytitle)
									set(gca,'TickLength',[0 0])

									% Colormap
									colorbar
									caxis([-50 50])
									run customcolorbars
									cl=colorbar;
									colormap(gca,custommap(20,negposc))														

									% Create Gridlines
									for i=1:size(sc,2)
										plot(repmat(0.5+i,1,size(sc,1)+3),-1:size(sc,1)+1,'k')
									end
									plot(-1:size(sc,2)+1,repmat(9.5,size(sc,2)+3,1),'k','linewidth',2)
									plot(-1:size(sc,2)+1,repmat(17.5,size(sc,2)+3,1),'k','linewidth',2)
									plot(-1:size(sc,2)+1,repmat(25.5,size(sc,2)+3,1),'k','linewidth',2)
									plot(-1:size(sc,2)+1,repmat(33.5,size(sc,2)+3,1),'k','linewidth',2)
									plot(-1:size(sc,2)+1,repmat(41.5,size(sc,2)+3,1),'k','linewidth',2)
									plot(-1:size(sc,2)+1,repmat(49.5,size(sc,2)+3,1),'k','linewidth',2)

									% Box Outside Graphic
									plot(repmat((-2.1+-1.5)/2,1,size(sc,1)+1),0.5:size(sc,1)+.5,'k','clipping','off','linewidth',28)
									plot(-2.1:size(sc,2)-7,repmat(0.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
									plot(-2.1:size(sc,2)-7,repmat(9.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
									plot(-2.1:size(sc,2)-7,repmat(17.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
									plot(-2.1:size(sc,2)-7,repmat(25.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
									plot(-2.1:size(sc,2)-7,repmat(33.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
									plot(-2.1:size(sc,2)-7,repmat(41.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
									plot(-2.1:size(sc,2)-7,repmat(49.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')
									plot(-2.1:size(sc,2)-7,repmat(57.5,size(sc,2)-4,1),'k','linewidth',2,'clipping', 'off')       

									% Text For Skill & FSP Percentages
									for j=1:size(sc,2)
										for i=1:size(sc,1)
											if isnan(sc(i,j))==1
											else
												if sc(i,j)>30 || sc(i,j)<-30
													text(j,i, strtrim([num2str(round(sc(i,j),1)),'%']), 'color','w','HorizontalAlignment', 'Center','fontsize',6)
												else
													text(j,i, strtrim([num2str(round(sc(i,j),1)),'%']), 'HorizontalAlignment', 'Center','fontsize',6)
												end
											end
										end
									end     

									% Text for Error 
									cnt=1;
									for i=[1,10,18,26,34,42,50]
										for j=1:size(sc,2)
											if isnan(sc(i,j))==1 % then put in error
												tmpstr=['\color[rgb]{',strtrim(num2str(identexpcolors(identexploop,:))),'}',strtrim(num2str(round(tmp_err(j,identexploop,cnt),1))),'\color[rgb]{0 0 0}|\color[rgb]{',strtrim(num2str(identexpcolors(tmpimp,:))),'}',strtrim(num2str(round(tmp_err(j,tmpimp,cnt),1))),];
												text(j,i,tmpstr, 'HorizontalAlignment', 'Center','fontsize',6)
												else                       
											end
										end
										cnt=cnt+1;
									end  
									cnt=1;for i=[4,13,21,29,37,45,53];for j=1:size(sc,2);if isnan(sc(i,j))==1;tmpstr=['\color[rgb]{',strtrim(num2str(identexpcolors(identexploop,:))),'}',strtrim(num2str(round(tmp_errmed(j,identexploop,cnt),1))),'\color[rgb]{0 0 0}|\color[rgb]{',strtrim(num2str(identexpcolors(tmpimp,:))),'}',strtrim(num2str(round(tmp_errmed(j,tmpimp,cnt),1))),];text(j,i,tmpstr, 'HorizontalAlignment', 'Center','fontsize',6);else;end;end;cnt=cnt+1;end; % median text
									% Text for Bias 
									cnt=2;
									for i=[15,23,31,39,47,55,6,7]
										for j=1:size(sc,2)
											if isnan(sc(i,j))==1 % then put in bias
												tmpstr=['\color[rgb]{',strtrim(num2str(identexpcolors(identexploop,:))),'}',strtrim(num2str(round(tmp_bias(j,identexploop,cnt),1))),'\color[rgb]{0 0 0}|\color[rgb]{',strtrim(num2str(identexpcolors(tmpimp,:))),'}',strtrim(num2str(round(tmp_bias(j,tmpimp,cnt),1))),];
												text(j,i,tmpstr, 'HorizontalAlignment', 'Center','fontsize',6)
											else                       
											end
										end
										cnt=cnt+1;
									end    

									% Text for # FCSTS 
									cnt=1;
									for i=[8,16,24,32,40,48,56]
										for j=1:size(sc,2)
											if isnan(sc(i,j))==1 % then put in #fcsts
												if sum(tmp_fcst(j,1,cnt)-tmp_fcst(j,2,cnt))==0
													tmpstr=['\color[rgb]{0 0 0}',strtrim(num2str(round(tmp_fcst(j,1,cnt),2)))];
													text(j,i,tmpstr, 'HorizontalAlignment', 'Center','fontsize',6)
												else
													tmpstr=['\color[rgb]{',strtrim(num2str(identexpcolors(identexploop,:))),'}',strtrim(num2str(round(tmp_fcst(j,identexploop,cnt),1))),'\color[rgb]{0 0 0}|\color[rgb]{',strtrim(num2str(identexpcolors(tmpimp,:))),'}',strtrim(num2str(round(tmp_fcst(j,tmpimp,cnt),1))),];
													text(j,i,tmpstr, 'HorizontalAlignment', 'Center','fontsize',6)
												end
											else                       
											end
										end
										cnt=cnt+1;
									end  

									% Markers for Stat. Sig.
									cnt=1;
									for i=[9,17,25,33,41,49,57]
										for j=1:size(sc,2)
											if isnan(sc(i,j))==1 % then put in stat. sig.
												if sigtest_90(j,cnt)+sigtest_95(j,cnt)==2
													plot(j,i,'s','Color','k','markerfacecolor','k','markersize',7)
												elseif sigtest_90(j,cnt)+sigtest_95(j,cnt)==1
													plot(j,i,'o','Color','k','markersize',5.5,'markerfacecolor','k')
												else
												end                                                
											else                       
											end
										end
										cnt=cnt+1;
									end  

									% Variable Titles
									text(-1.75,5,['\textbf{TRACK}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
									text(-1.88,13.5,['\textbf{WIND}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
									text(-1.62,13.5,['\textbf{SPEED}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
									text(-1.75,21.5,['\textbf{MSLP}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
									text(-1.75,29.5,['\textbf{RTSF}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
									text(-1.75,37.5,['\textbf{RSF}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
									text(-1.75,45.5,['\textbf{RHF}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')
									text(-1.75,53.5,['\textbf{RMW}'],'color','w','rotation',90,'HorizontalAlignment','center','VerticalAlignment','middle','fontsize',12,'fontweight','bold','interpreter','latex')

									% Title Text
									text(0,1.065,['\textbf{Scorecard}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									text(1,1.065,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
									%text(0,1.035,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									text(1,1.035,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');

									tmpuv = size(tmpnm,1);                               
									tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
									if strat==1
									text(0,1.035,['\textbf{CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									else
									text(0,1.035,['\textbf{SUBSET: ',upper(stname),' $\mid$ CYCLES: ',tmpphrase,'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
									end
									
									% Figure Sizing & Printing
									set(gcf, 'InvertHardcopy', 'off')    
									ax=gca;
									box on
									set(ax, 'Layer', 'top')
									ax.LineWidth=2; 
									set(gca,'position',[spPos(1) spPos(2)-.07 spPos(3)+.09 spPos(4)+.1])
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, .5]); % maximize figure window
									set(gca,'Color',[.9 .9 .9])
									% Save Figure
									set(gcf,'Units','inches');
									screenposition = get(gcf,'Position');
									set(gcf,'PaperPosition',[0 0 screenposition(3)+3 screenposition(4)+3],'PaperSize',[screenposition(3)+3 screenposition(4)+3]);    
									if identeps==1;filename=[identtrackint,'/',identn,'_',stname,'_SCORECARD','_',identexpshort{identexploop}];set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;print('-dpng',filename);end;close all;
									close all
								end
							end                    																						
						end
					end
				end
				if identconv==1 || identsatobs==1
					BT_drops=identdropcyc;BT_obsg=identobscyc;
				else
					BT_drops=[];BT_obsg=[];
				end
				save([identout,'RESULTS/',identfold,'VERIFICATION/',identremovename,'/',ident(1:2),'/',identn,'/',identn,'_latlon.mat'],'BT*','EXP*','identinittimesunique');
				save([identout,'RESULTS/',identfold,'VERIFICATION/',identremovename,'/',ident(1:2),'/',identn,'/',identn,'_errors.mat'],'*err_exp')       
			end
		end
	end
	clearvars -except identeps identmodelfhr identincludeobs identconvobs identserialcorr identbasinmodel identsatobs identgraphicssat identsatid identsatname identindivch identchannel identindivstorm identcomposite identstormsdone identconvtype identconvcolors identconvlegend identns* identnewsub identgraphicsconv identgraphicsbycycle identconvid  stormsdone identremovename yearsdone BT* EXP* ident* skip* spPos clPos ateerr_exp xteerr_exp
	clearvars -except identeps identmodelfhr identincludeobs identconvobs identserialcorr identbasinmodel identsatobs identgraphicssat identsatid identsatname identindivch identchannel identindivstorm identcomposite identstormsdone identconvtype identconvcolors identconvlegend identns* identnewsub identgraphicsconv identgraphicsbycycle identconvid  ident* skip* stormsdone yearsdone
end   
