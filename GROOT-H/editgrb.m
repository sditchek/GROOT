%% %%%%%%%%%%%%%%%%%%%%%%%%%% %%
%% BEGINNING OF USER SETTINGS %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%% %%

% Choose storm, experiment, cycle, and properties
ident=['AL092022'];                                             % basin, ID, and year (e.g., AL092016)
identn=['IAN22'];                                               % NAMEYY (e.g., HERMINE16)
identhwrf=['IAN09l'];                                           % name, ID, and short basin ID - check grb2 file output names if confused (e.g., hermine09l)
identcycles='2022093006';                                       % cycle times | for all, identcycles='all'; for multiple cycles, 'YYYYMMDDHH';'YYYYMMDDHH'; for single, YYYYMMDDHH
identmaxfhr=(126)/3+1;identmodelfhr=126/3+1;                    % X/3+1, where X is the max 1) identmaxfhr-you want for graphics and 2) identmodelfhr-output by your model
identlevels=45;                                                 % number of pressure levels
identexp=[{'IAN-ALL'};{'IAN-ALL'}];                             % full folder name of all experiments to compare - name from your scrub directory
identexpshort=[{'ALL'};{'NO'}];                                 % short name of experiments (no more than 8 letters per experiment)
identexpsigimp='NO';                                            % full folder name of experiment you want improvement and significance compared to
identexpsigimpshort='NO';                                       % short name of experiment you want improvement and significance compared to (no more than 8 letters)
identpresplan=[850];                                    % pressure levels of plan-view graphics
identexpcolors=[0 152 0;208 0 0]/255;                           % colors associated with each experiment
                                                                      % EX1: For 2 experiments, recommended colors: green(included data)=[0,.7,0] red(denied data)=[.9,0,0]
                                                                      % EX2: For more than 2 experiments, remember, "green" implies yes and "red" implies no
identdiff=[1 2;];                                               % for which experiments should difference fields be taken
                                                                      % EX1: if there are 3 experiments and you want to take the difference between experiment 1 and the other two experimentes, you'd write: identdiff=[1 2; 1 3];
                                                                      % EX2: if you want to take all differences, you'd write: identdiff='all';


% Set Directories
identscrub=['/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/ian/scrub/'];      % location of your scrub dirctory that has the grb files
identnoscrub=['/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/ian/noscrub/'];  % location of your noscrub dirctory that has the atcf track files
identout=['/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-H/'];    % location of your GROOT-H directory
identnum=0                                                               % do your grib files start with a number (identnum=1) or the name of the storm (identnum=0)?

% Graphics
initgraphics=1;                                                 % create TRACK/INT error data - for graphics edit editverif.m | yes - first time running (1) or no - ran this before (0)
initda=0;                                                       % create pre-GSI and post-GSI graphics if user-retrieved using the included retrieval script | yes (1) no (0)
initsynoptic=1;                                                 % create SYNOPTIC grid .mat files | yes (1) or no (0)
initgraphicssynoptic=1;                                         % create SYNOPTIC grid graphics | yes (1) or no (0)
initstorm=1;                                                    % create STORM grid .mat files | yes (1) or no (0)
initgraphicsstorm=1;                                            % create STORM grid graphics | yes (1) or no (0)
identplan=1;                                                    % create plan-view graphics (turn off to save time) | yes (1) no (0)
identsave=0;                                                    % do you want to save .mat files of the computed fields that make the graphics? This takes up more space! | yes (1) no (0)
identeps=1;                                                     % save as eps or png? | eps (1) png (0)

% Choose Variables
% If you choose v01, v9, or v58-v60 output will include multiple variables so it will take longer than expected!
% To include (exclude) a variable, remove (add) a "%" at the beginning of the line
% Commonly Used: v01, v9, v22, v26, v34, v60 (default)

%v01=1		%	10^-5 1/s		%	    Absolute vorticity 					%	Isobaric
%v02=2		%	J/kg			%	    Convective available potential energy 		%	Surface
%v03=3		%	J/kg			%	    Convective inhibition 				%	Surface
%v04=4		%	kg/(m^2)		%	    Convective precipitation 				%	Surface
%v05=5		%	kg/(m^2*s)		%	    Convective precipitation rate 			%	Surface
%v06=6		%	K			%	    Dew point temperature 				%	2 M
%v07=7		%	(kg/(m^3))(m/s)		%	    Exchange Coefficient 				%	Surface
%v08=8		%	m/s			%	    Frictional Velocity 				%	Surface
v09=9		%	dam			%	    Geopotential height 				%	Isobaric
%v10=10		%	gpm			%	    Geopotential height 				%	Surface
%v11=11		%	gpm			%	    Geopotential height 				%	Tropopause
%v12=12		%	kg/kg			%	    Graupel (snow pellets) 				%	Isobaric
%v13=13		%	m/s			%	    Hourly Max of Downward Vert. Vel. 			%	2D
%v14=14		%	m/s			%	    Hourly Max of Downward Vert. Vel. (lowest 400hPa) 	%	2D
%v15=15		%	m^2/s^2			%	    Hourly Max of Updraft Helicity (2-5 km AGL) 	%	2-5 KM
%v16=16		%	m^2/s^2			%	    Hourly Max of Updraft Helicity (0-3 km AGL) 	%	0-3 KM
%v17=17		%	kg/kg			%	    Ice water mixing ratio 				%	Isobaric
%v18=18		%	Proportion		%	    Land cover (1=land; 2=sea) 				%	Surface
%v19=19		%	kg/(m^2)		%	    Large scale precipitation 				%	Surface
%v20=20		%	W/(m^2)			%	    Latent heat net flux 				%	Surface
%v21=21		%	hPa			%	    MSLP (Eta model reduction) 				%	Surface
%v22=22		%	dB			%	    Max / Composite radar reflectivity 			%	2D
%v23=23		%	N/(m^2)			%	    Momentum flux; u component 				%	Surface
%v24=24		%	N/(m^2)			%	    Momentum flux; v component 				%	Surface
%v25=25		%	m			%	    Planetary Boundary Layer Height 			%	2D
v26=26		%	kg/(m^2)		%	    Precipitable water 					%	2D
%v27=27		%	kg/(m^2 s)		%	    Precipitation rate 					%	Surface
%v28=28		%	hPa			%	    Pressure 						%	Surface
%v29=29		%	hPa			%	    Pressure 						%	Tropopause
%v30=30		%	hPa			%	    Pressure reduced to MSL 				%	Surface
%v31=31		%	kg/kg			%	    Rain mixing ratio 					%	Isobaric
%v32=32		%	dB			%	    Reflectivity 					%	Isobaric
%v33=33		%	%			%	    Relative humidity 					%	2 M
%v34=34		%	%			%	    Relative humidity 					%	Isobaric
%v35=35		%	W/(m^2)			%	    Sensible heat net flux 				%	Surface
%v36=36		%	kg/kg			%	    Snow mixing ratio 					%	Isobaric
%v37=37		%	kg/kg			%	    Specific humidity 					%	2 M
%v38=38		%	kg/kg			%	    Specific humidity 					%	Isobaric
%v39=39		%	J/kg			%	    Storm relative helicity 				%	3000 M
%v40=40		%	m			%	    Surface roughness 					%	Surface
%v41=41		%	K			%	    Temperature 					%	2 M
%v42=42		%	K			%	    Temperature						%	Tropopause
%v43=43		%	K			%	    Temperature						%	Cloud Top
%v44=44		%	K			%	    Temperature						%	Isobaric
%v45=45		%	K			%	    Temperature						%	Surface
%v46=46		%	kg/(m^2)		%	    Total Column Integrated Rain 			%	2D
%v47=47		%	kg/(m^2)		%	    Total Column Integrated Snow 			%	2D
%v48=48		%	kg/(m^2)		%	    Total Column-Integrated Cloud Ice 			%	2D
%v49=49		%	kg/(m^2)		%	    Total Column-Integrated Cloud Water 		%	2D
%v50=50		%	kg/(m^2)		%	    Total Column-Integrated Condensate 			%	2D
%v51=51		%	kg/(m^2)		%	    Total precipitation 				%	Surface
%v52=52		%	1/s			%	    Vertical speed sheer 				%	Tropopause
%v53=53		%	m/s			%	    Vertical velocity (geometric) 			%	Isobaric
%v54=54		%	Pa/s			%	    Vertical velocity (pressure) 			%	Isobaric
%v55=55		%	K			%	    Water temperature 					%	Surface
%v56=56		%	m/s			%	    Wind speed (gust) 					%	Surface
%v57=57		%	m/s			%	    Wind speed 						%	10 M
%v58=[58,59]	%	m/s			%	    u/v component of wind 				%	10 M
%v59=[60,61]	%	m/s			%	    u/v component of wind 				%	Tropopause
v60=[62,63]	%	m/s			%	    u/v component of wind 				%	Isobaric

%% %%%%%%%%%%%%%%%%%%%% %%
%% END OF USER SETTINGS %%
%% %%%%%%%%%%%%%%%%%%%% %%

%% Model outputs at 3 h, but to compare errors to BT make 6 h!
skip=2;                                                    % 6 h res | skip=1 is 3 h
skiphr=6;                                                  % 6 h res | skiphr=3 is 3 h res
skiptick=2;                                                % 6 h res | skiptick=4 is 3 h res
skipfct=4;                                                 % 6 h res | skipfct=4 is still 3 h res

%% Save the config file for future reference
disp(['Creating Start Parameters for ',identn])
C = who('v*');
identv=[];
for k=1:size(C,1)
   identv=[identv,eval(C{k})];
end
clear v*
identfold='';
for i=1:size(identexp,1)
    tmp=identexpshort{i};
    if i==size(identexp,1)
        identfold=strcat(identfold,tmp,'/');
    else
        identfold=strcat(identfold,tmp,'_');
    end
end;if identeps==1;identfold=[identfold(1:end-1),'_eps/'];else;identfold=[identfold(1:end-1),'_png/'];end;
if ~exist([identout,'cases/',identfold], 'dir')                      % if this is the first time running these scripts, it will create the cases directory
    mkdir([identout,'cases/',identfold])
end
copyfile('editgrb.m',['cases/',identfold,identn,'.m'])  % copy file into cases directory so if you need to run again, you'll already have it saved!

%% Save the output
save([identout,'startparams.mat'])                        % this file will be saved in the [identout] directory so it can be used when needed

%% Get common initalizations between all experiments
for comm=1
    cnt=1;
    for tmp=1:size(identexp,1)
        identdr=dir([identscrub,identexp{tmp},'/com/',ident(5:8),'*/',ident(3:4),upper(identhwrf(end))]);
        identdr=unique({identdr.folder});
        for i=1:size(identdr,2)
            tmp2=identdr{i};
            tmp2=tmp2(end-13:end-4);
            identdr1(cnt,:)=tmp2;
            cnt=cnt+1;
        end
    end
    A = str2num(identdr1);
    [n, bin] = histc(A, unique(A));
    multiple = find(n > size(identexp,1)-1);
    index    = find(ismember(bin, multiple));
    identinittimesunique=unique(identdr1(index,:),'rows');
end

%% Identify which cycle numbers will be running
if strcmp(identcycles,'all')==1
    identcyclenum=1:size(identinittimesunique,1);
else
    for i=1:size(identcycles,1)
        for ii=1:size(identinittimesunique,1)
            if strcmp(identcycles(i,:),identinittimesunique(ii,:))==1
                identcyclenum(i)=ii;
            end
        end
    end
end

if strcmp(identdiff,'all')==1
    identdiff=nchoosek(1:size(identexp,1),2);
end

%% If user wants geopotential but didn't select U/V
if find(identv==9)>0 & isempty(find(identv==62))==1
    identv=[identv 62 63];
end

%% If user wants U/V but didn't select geopotential
if isempty(find(identv==9))==1 & find(identv==62)>0
    identv=[identv 9];
end

%% If user wants wind speed at 10 m, choose v58
if find(identv==57)>0 & isempty(find(identv==58))>0
    identv=[identv 58 59];
	identv(identv==57)=[];
end

%% Create output variable file for shell script
% STORM GRID: Don't plot u-component and v-component or geopotential
identv0=identv;
if find(identv0==1)>0
    identv0=[identv0 65];
end
if find(identv0==58)>0
    identv0=[identv0 66 67 68];
elseif find(identv0==60)>0
    identv0=[identv0 69 70 71];
elseif find(identv0==62)>0
    identv0=[identv0 72 73 74];
end
for i=[58:63,9:11]
    identv0(identv0==i)=NaN;
end
identvstorm=identv0(find(~isnan(identv0)));

% SYNOPTIC GRID: Don't plot u-component and v-component or geopotential
identv0=identv;
if find(identv0==1)>0
    identv0=[identv0 65];
end
if find(identv0==58)>0
    identv0=[identv0 66 67 68];
elseif find(identv0==60)>0
    identv0=[identv0 69 70 71];
elseif find(identv0==62)>0
    identv0=[identv0 72 73 74];
end
for i=[58:63,9:11]
    identv0(identv0==i)=NaN;
end
identvsynoptic=identv0(find(~isnan(identv0)));

%% Clean Up Old Files
disp('CLEANING UP PREVIOUS GRB RESULTS FOR THIS STORM...')
if exist([identout,'RESULTS/',identfold,'/',identn,'/'], 'dir'); 
    rmdir([identout,'RESULTS/',identfold,'/',identn,'/'],'s');
end

%% Create output file for shell script
fid = fopen('common.txt','wt');
fprintf(fid,'%s\n',['initgraphics=',num2str(initgraphics)]);
fprintf(fid,'%s\n',['initstorm=',num2str(initstorm)]);
fprintf(fid,'%s\n',['initsynoptic=',num2str(initsynoptic)]);
fprintf(fid,'%s\n',['initgraphicsstorm=',num2str(initgraphicsstorm)]);
fprintf(fid,'%s\n',['initgraphicssynoptic=',num2str(initgraphicssynoptic)]);
%fprintf(fid,'%s\n',['initsatobs=',num2str(initsatobs)]);
%fprintf(fid,'%s\n',['initconventional=',num2str(initconventional)]);
fprintf(fid,'%s\n',['initda=',num2str(initda)]);
fprintf(fid,'%s\n',['cycles="',num2str(identcyclenum),'"']);
fprintf(fid,'%s\n',['exp="',num2str(1:size(identexp,1)),'"']);
fprintf(fid,'%s\n',['stm=',identn]);
fprintf(fid,'%s\n',['stormvariables="',num2str(identvstorm),'"']);
fprintf(fid,'%s\n',['synopticvariables="',num2str(identvsynoptic),'"']);
fclose(fid);

