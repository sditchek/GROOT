%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%% This script sets up your specific case. You only need to change items in this script in the User Settings section %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%

%% %%%%%%%%%%%%%%%%%%%%%%%%%% %%
%% BEGINNING OF USER SETTINGS %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%% %%

% Choose storm, experiment, cycle, and properties
ident=['AL052019'];                                             % basin, ID, and year (e.g., AL092016)
identn=['DORIAN19'];                                            % NAMEYY (e.g., HERMINE16)
identhwrf=['dorian05l'];                                        % name, ID, and short basin ID - check grb2 file output names if confused (e.g., hermine09l)
identcycles=['2019082606';'2019082612';'2019082618';'2019082700';'2019082706';'2019082712';'2019082718';'2019082800';'2019082806';'2019082812';'2019082818';'2019082900';'2019082906'];			 		        % cycle times | for all, identcycles='all'; for multiple cycles, 'YYYYMMDDHH';'YYYYMMDDHH'; for single, YYYYMMDDHH
identmaxfhr=(126)/3+1;identmodelfhr=(126)/3+1;                  % max forecast hours set in model (e.g., 126) - keep the /3+1
identlevels=46;                                                 % number of pressure levels
identexp=[{'HB20new'};{'HB20_NC'};{'HB20_OV'};{'HB20_TG'};{'HB20_IC'};{'HB20_NO'}];                      % full folder name of all experiments to compare - name from your scrub directory
identexpshort=[{'ALL'};{'NIC'};{'NTG'};{'TG'};{'IC'};{'NO'}];   % short name of experiments (no more than 8 letters per experiment)
identexpsigimp='HB20_NO';                                    % full folder name of experiment you want improvement and significance compared to
identexpsigimpshort='NO';                                       % short name of experiment you want improvement and significance compared to (no more than 8 letters)
identpresplan=[200,500,850];                                    % pressure levels of plan-view graphics
identexpcolors=[0 152 0;89 130 219;146 108 172;213 157 1;237 119 0;208 0 0]/255;            % colors associated with each experiment
                                                                      % EX1: For 2 experiments, recommended colors: green(included data)=[0,.7,0] red(denied data)=[.9,0,0]
                                                                      % EX2: For more than 2 experiments, remember, "green" implies yes and "red" implies no
identdiff=[1 6;];                                               % for which experiments should difference fields be taken
                                                                      % EX1: if there are 3 experiments and you want to take the difference between experiment 1 and the other two experimentes, you'd write: identdiff=[1 2; 1 3];
                                                                      % EX2: if you want to take all differences, you'd write: identdiff='all';
          

% Set Directories
identscrub=['/scratch1/BMC/qosap/Sarah.D.Ditchek/scrub/'];      % location of your scrub dirctory that has the grb and observation files (either conventional or satellite)
identnoscrub=['/scratch1/BMC/qosap/Sarah.D.Ditchek/noscrub/'];  % location of your noscrub dirctory that has the atcf track files
identout=['/scratch1/BMC/qosap/Sarah.D.Ditchek/GROOT/GROOT-H/'];% location of your GROOT-H directory 

% Graphics
initgraphics=1;                                                 % create TRACK/INT error data - for graphics edit editverif.m | yes - first time running (1) or no - ran this before (0)
initda=0;                                                       % create pre-GSI and post-GSI graphics if user-retrieved using the included retrieval script | yes (1) no (0)
initsynoptic=1;                                                 % create SYNOPTIC grid .mat files | yes (1) or no (0)
initgraphicssynoptic=1;                                         % create SYNOPTIC grid graphics | yes (1) or no (0)
initstorm=1;                                                    % create STORM grid .mat files | yes (1) or no (0)
initgraphicsstorm=1;                                            % create STORM grid graphics | yes (1) or no (0)
identplan=1;                                                    % create plan-view graphics (turn off to save time) | yes (1) no (0)
identsave=0;                                                    % do you want to save .mat files of the computed fields that make the graphics? This takes up more space! | yes (1) no (0)	

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%% IF YOU CHOOSE v01, v16, or v73-v78, OUTPUT WILL INCLUDE  %%
%% MULTIPLE VARIABLES SO IT WILL TAKE LONGER THAN EXPECTED! %%
%%							    %%					
%%   How To: to include (exclude) a variable, remove (add)  %%
%%           a "%" at the beginning of the line             %% 
%%							    %%
%%   Commonly Used: v01, v16, v27, v29, v35, v74            %%
%% 							    %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%

v01=1;         %        10-5 s-1       Absolute vorticity | isobaric
%v02=2;         %        kg m-2         Cloud Ice | isobaric
%v03=3;         %        kg kg-1        Cloud mixing ratio | isobaric
v04=4;         %        dB             Maximum/Composite radar reflectivity | 2D
%v05=5;         %        J kg**-1       Convective available potential energy | surface
%v06=6;         %        J kg**-1       Convective inhibition | surface
%v07=7;         %        kg m**-2       Convective accumulated precipitation (water) | surface
%v08=8;         %        K              2 metre dewpoint temperature | 2D
%v09=9;         %        K              Dew point temperature | isobaric
%v10=10;        %        W m**-2        Downward long-wave radiation flux | surface
%v11=11;        %        W m**-2        Downward long-wave radiation flux Hour Average | surface
%v12=12;        %        W m**-2        Downward short-wave radiation flux | surface
%v13=13;        %        W m**-2        Downward short-wave radiation flux Hour Average | surface
%v14=14;        %        numeric        Drag coefficient
v16=16;        %        gpm            Geopotential Height | isobaric
%v17=17;        %        gpm            Geopotential Height | surface
%v18=18;        %        km             Orography | 2D
%v19=19;        %        (0 - 1)        Land-sea mask | surface
%v20=20;        %        kg m**-2       Nonconvective accumulated precipitation (large-scale) | surface
%v21=21;        %        W m**-2        Latent heat net flux | surface
%v23=23;        %        N m**-2        Momentum flux, u component | surface
%v24=24;        %        N m**-2        Momentum flux, v component | surface
%v25=25;        %        m              Planetary boundary layer height | 2D
%v26=26;        %        K              Potential temperature | tropopause
v27=27;        %        kg m**-2       Precipitable water | 2D
%v28=28;        %        kg m**-2 s**-1 Precipitation rate | surface
%v29=29;        %        mb             Pressure reduced to MSL | surface
%v30=30;        %        hPa            Surface pressure | surface
%v31=31;        %        hPa            Pressure | tropopause
%v32=32;        %        kg kg-1        Rain mixing ratio | isobaric
%v33=33;        %        dB             Radar reflectivity | isobaric
%v34=34;        %        %              Relative humidity | 2D
v35=35;        %        %              Relative humidity | isobaric
%v36=36;        %        numeric        Rime factor | isobaric
%v37=37;        %        W m**-2        Sensible heat net flux | surface
%v38=38;        %        kg kg-1        Snow mixing ratio | isobaric
%v39=39;        %        kg kg**-1      Specific humidity | 2D
%v40=40;        %        kg kg**-1      Specific humidity | isobaric
%v41=41;        %        J kg**-1       Storm relative helicity | 2D
%v42=42;        %        m              Surface roughness | surface
%v43=43;        %        K              Temperature | 2D
%v44=44;        %        K              Temperature | isobaric
%v45=45;        %        K              Temperature | surface
%v46=46;        %        K              2 metre temperature | 2D
%v47=47;        %        kg m**-2       Total column integrated rain | 2D
%v48=48;        %        kg m**-2       Total column integrated snow | 2D
%v49=49;        %        kg m**-2       Total column-integrated cloud ice | 2D
%v50=50;        %        kg m**-2       Total column-integrated cloud water | 2D
%v51=51;        %        kg m**-2       Total column-integrated condensate | 2D
%v52=52;        %        kg kg-1        Total condensate | isobaric
%v53=53;        %        kg m**-2       Total accumulated precipitation | surface
%v54=54;        %        W m**-2        Upward long-wave radiation flux | surface
%v55=55;        %        W m**-2        Upward long-wave radiation flux hour average | surface
%v56=56;        %        W m**-2        Upward short-wave radiation flux | surface
%v57=57;        %        W m**-2        Upward short-wave radiation flux hour average | surface
%v58=58;        %        numeric        Heat Exchange Coefficient | 2D
%v59=59;        %        s**-1          Vertical speed shear | tropopause
v60=60;        %        Pa s-1         Vertical velocity | isobaric
v61=61;        %        K              Sea surface temperature | surface
%v73=[73,76];   %        m s**-1        10 metre U/V wind component | 2D
v74=[74,77];   %        m s**-1        U/V component of wind | isobaric
%v75=[75,78];   %        m s**-1        U/V component of wind | tropopause

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
C = who('-regexp','v*');
identv=[];
for k=3:size(C,1)
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
end   
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
if find(identv==16)>0 && isempty(find(identv==74))==1
    identv=[identv 74 77];
end

%% If user wants U/V but didn't select geopotential
if isempty(find(identv==16))==1 && find(identv==74)>0
    identv=[identv 16];
end

%% Create output variable file for shell script
% STORM GRID: Don't plot u-component and v-component or geopotential
identv0=identv;
if find(identv0==1)>0
    identv0=[identv0 86];
end
if find(identv0==73)>0
    identv0=[identv0 80 83 87];
elseif find(identv0==74)>0
    identv0=[identv0 81 84 88];
elseif find(identv0==75)>0
    identv0=[identv0 82 85 89];
end
for i=[73:78,16]
    identv0(identv0==i)=NaN;
end
identvstorm=identv0(find(~isnan(identv0)));

% SYNOPTIC GRID: Don't plot u-component and v-component or geopotential
identv0=identv;
if find(identv0==1)>0
    identv0=[identv0 86];
end
if find(identv0==73)>0
    identv0=[identv0 80 83 87];
elseif find(identv0==74)>0
    identv0=[identv0 81 84 88];
elseif find(identv0==75)>0
    identv0=[identv0 82 85 89];
end
for i=[73:78,16]
    identv0(identv0==i)=NaN;
end
identvsynoptic=identv0(find(~isnan(identv0)));

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
