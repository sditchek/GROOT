%% %%%%%%%%%%%%%%%%%%%%%% %%
%% START OF USER SETTINGS %%
%% %%%%%%%%%%%%%%%%%%%%%% %%

% Set Directories and Model Properties
identout=['/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-H/'];  	 % top-level directory path for results folder - must include end "/"
identgroot=['/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-H/GROOT-PR/']; % path of GROOT-PR directory (i.e., ${homepath}/GROOT/GROOT-H/GROOT-PR/, where homepath is same as in runverif.ksh) - must include end "/"
identmaxfhr=126;identmodelfhr=126;               		             	 % the max 1) identmaxfhr-you want for graphics and 2) identmodelfhr-output by your model
identbasinmodel=0;                                                               % are there multiple storms being tracked at once (e.g., basin-scale HWRF or GFS)? | yes (1) no (0)
identhwrfmodel=0;identhafsmodel=1;					         % did you run HWRF or HAFS? | yes (1) no (0)

% Choose experiments and colors
identexp=[{'ALL-A'};{'NOG4-A'}]; 		   	        % folder name of all experiments: 1) must match "expnew" in runverif.ksh, 2) first experiment MUST be the one with al the obs assimilated, and 3) last experiment MUST be the BASELINE
identexpsigimp='NOG4-A';                                                  % full folder name of improvement wrt THIS experiment (i.e., your BASELINE)
identexpcolors=[0 152 0;208 0 0]/255;  	        % colors associated with each experiment - do NOT use black since the best track is black by default
        	                                                             % EX1: For 2 experiments, recommended colors:  green(included)=[0 152 0] red(denied)=[208 0 0]
									     % EX2: For more than 2 experiments, remember, "green" implies yes and "red" implies no
stormsdone=dir([identgroot,'/ALL-A']);                                    % short name of experiment that has completed the most cycles (must match name in "expnew" in runverif.ksh)

% Case Study: also make identgraphicsbycycle=1, identgraphicsconv=1 or identgaphicssat=1 if testing obs impact, and identcompositeonly=0
identcase=0;								% run graphics for just 1 storm | yes (1) no (0)
identcasename={'delta26l'};identbasinid='AL';				% identcasename: lowercase name of storm, ID, and basin identifier (e.g., dorian05l) | % identbasinid: upper case 2-letter basin identifier
identcaseyear='2020';							% year of storm: YYYY

% Error Graphics Options
identgraphicsbycycle=0;                                         % error graphics for EACH CYCLE - must be 0 if identcompositeonly=1 | yes (1) no (0 - this saves time)
identcompositeonly=1;						% only generate composite graphics | yes (1 - this saves time) no (0 - you get indiv. storm error statistics output)
identns=1;                                                      % do you want to create a new subset, different that what is in the package? | yes (1) no (0)
identnsname='OG4';                                              % name for new subset - will be capitalized in the script
identnewsubset_id=[{'09L'};{'09L'};{'09L'};{'09L'};{'09L'};{'09L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'14L'};{'14L'};{'14L'};{'26L'};{'26L'};{'26L'};{'26L'};{'26L'};{'26L'};{'26L'};{'26L'};{'28L'};{'28L'};{'28L'};{'28L'};{'28L'};{'28L'};{'28L'};{'28L'};{'05L'};{'05L'};{'08L'};{'08L'};{'08L'};{'08L'};{'08L'};{'08L'};{'08L'};{'08L'};{'09L'};{'09L'};{'09L'};{'09L'};{'09L'};{'09L'};{'18L'};{'18L'};{'18L'};{'18L'};{'07L'};{'07L'};{'07L'};{'07L'};{'07L'};{'07L'};{'09L'};{'09L'};{'09L'};{'09L'};{'09L'};{'09L'};{'09L'};{'09L'};{'09L'};{'09L'};{'09L'};{'09L'};{'09L'};{'09L'};{'17L'};{'17L'};{'17L'};{'17L'};{'17L'};{'17L'};{'08L'};{'10L'};{'10L'};{'10L'};{'10L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'};{'13L'}]; % new subset stormids if identns=1 - each associated entry in identnewsubset, enter the stormid (if range of cycles, enter the stormid once)
identnewsubset=[{'2020073118'};{'2020080100'};{'2020080106'};{'2020080112'};{'2020080118'};{'2020080200'};{'2020082118'};{'2020082200'};{'2020082218'};{'2020082300'};{'2020082406'};{'2020082412'};{'2020082418'};{'2020082500'};{'2020082506'};{'2020082512'};{'2020082518'};{'2020082600'};{'2020082212'};{'2020082306'};{'2020082312'};{'2020100618'};{'2020100700'};{'2020100706'};{'2020100712'};{'2020100718'};{'2020100800'};{'2020100806'};{'2020100812'};{'2020102518'};{'2020102600'};{'2020102606'};{'2020102612'};{'2020102618'};{'2020102700'};{'2020102706'};{'2020102712'};{'2021070218'};{'2021070300'};{'2021081918'};{'2021082000'};{'2021082006'};{'2021082012'};{'2021082018'};{'2021082100'};{'2021082106'};{'2021082112'};{'2021082706'};{'2021082712'};{'2021082718'};{'2021082800'};{'2021082806'};{'2021082812'};{'2021092618'};{'2021092700'};{'2021092718'};{'2021092800'};{'2022091718'};{'2022091800'};{'2022091818'};{'2022091900'};{'2022092018'};{'2022092100'};{'2022092418'};{'2022092500'};{'2022092506'};{'2022092512'};{'2022092518'};{'2022092600'};{'2022092606'};{'2022092612'};{'2022092618'};{'2022092700'};{'2022092706'};{'2022092712'};{'2022092718'};{'2022092800'};{'2022110806'};{'2022110812'};{'2022110818'};{'2022110900'};{'2022110906'};{'2022110912'};{'2023082206'};{'2023082800'};{'2023082812'};{'2023082818'};{'2023082900'};{'2023091018'};{'2023091100'};{'2023091106'};{'2023091112'};{'2023091118'};{'2023091200'};{'2023091206'};{'2023091212'};{'2023091218'};{'2023091300'};{'2023091306'};{'2023091312'};{'2023091318'};{'2023091400'};{'2023091406'};{'2023091412'};{'2023091418'};{'2023091500'};{'2023091506'};{'2023091512'}]; % new subset cycle times if identns=1 - you can use a range of cycles, disjointed cycles, or both
                	            	                                % range of cycles: [{'2017081800-2017083100'}] %disjointed cycles: [{'2017081800'};{'2017090200'}]                                                                                           % range and disjointed cycles: [{'2017081800-2017083100'};{'2017090200'}]
identenkfexact=0;							%  covariance-type stratification - exact method ONLY WORKS FOR HWRF | if you used the retrieval scripts included in GROOT (1) if you did not use the retrieval scripts or there is no difference in covariance type (0)
identenkfoper=1;identenkfoperpath='/scratch1/NCEPDEV/hwrf/noscrub/input/TDR/'; % covariance-type stratification - operational method - note that for HAFS if this is enabled, graphics will indicate pre- and post- TDR rather than enkf vs gdas covariance | all cycles from the first TDR available through the end of the TC used enkf (1) do not do stratifications by enkf (0) | note that identenkfoperpath is the path to the TDR files on disk - if your model doesn't have this, set to identenkfoper=0.
identremoveland=0;							% do you want to remove cycles where either best track or forecast was over land | yes (1) no (0)
identboxhist=0;								% do you want to create boxplots of absolute error for each experiment & stratification as well as histograms of bias and absolute error for each forecast hour and stratification? | yes (1) no (0 - this saves a lot of time)

% Conventional Graphics Options
identconv=1;                                                   		   % conventional observation graphics | yes (1) no (0 - if not retrieved using included retrieval script)
identgraphicsconv=0;                                            	   % conventional observation graphics for EACH CYCLE | yes (1) no (0 - this saves time)
identconvid='Recon';                                            	   % name of observation for graphic titles | uppercase first letter | will become "Assimilated ____ Observations"
if identhafsmodel==1							   % if identhafsmodel=1, filenames of data desired ensuring it starts with "_" and equals # of identconvobstype
   identconvid_filename=[{'_t_anl'};{'_q_anl'};{'_uv_anl'};{'_spd_anl'};{'_rw_anl'};{'_rw_anl'};{'_t_anl'};{'_q_anl'};{'_uv_anl'}];
end
identconvobstype=[136 136 236 213 993 992 137 137 237];			   % obstype number(s) | number of obstypes must match number of obssubtypes
							 	      		% NOTE: if an obstype is associated with multiple obssubtypes and you want to keep that obssubtype, repeat obstype for each obssubtype and set identsubtypekeep=1. if you want ALL obssubtypes for a given obstype, only list the obstype once and enter "0" as the corresponding obssubtype and set the corresponding identsubtypekeep to 0. Also, the order of the obstypes will be plotting order, so put more sparse obs last
identconvobssubtype=[0 0 0 0 0 0 0 0 0];identsubtypekeep=[1 1 1 1 1 1 1 1 1]; % corresponding obssubtype number(s) | number of obssubtypes must match number of obstypes | identsubtypekeep must match number of identconvobstype and identconvobssubtype | keep subtype (1) use all subtypes for this obtype (0)
identconvobscolors=[229 96 43;237 146 109;164 61 20;248 211 196;56 87 35;112 173 71;204 51 204;233 169 233;107 27 107]/255; % colors for each of your subtypes (will only be used if identconvobssubtype has >1 value) | NOTE: if you want to group together different obstypes as one category (e.g., COSMIC2 FM1 - FM6 > COSMIC2), repeat the same color for each obstype and then repeat the same name in identconvobslegend.
identconvobslegend=[{'T-HDOBS'};{'Q-HDOBS'};{'UV-HDOBS'};{'SPD-SFMR'};{'RW-P3'};{'RW-GIV'};{'T-DROPS'};{'Q-DROPS'};{'UV-DROPS'}]; % names of each of your subtypes for the plot legends

% Satellite Graphics Options - ONLY WORKS FOR IDENTHWRFMODEL=1!!!!!!!
identsatobs=0;                          % create satellite graphics if user-retrieved using the included retrieval script | yes (1) no (0)
identgraphicssat=1;			% satellite graphics for EACH CYCLE | yes (1) no (0 - this saves time)
identsatid='iasi_g13';                  % if the above is yes (1), then type the satellite name here - must match the diag file
identsatname='Geo-HSS';			% full name of satellite observation | uppercase first letter | singular
identindivch=1;                         % create individual-channel graphics (turn off to save time) | yes (1) no (0)
identchannel=[200];                     % used to generate graphics of profiles assimilated by channel
                                             % look in your COM directory for the file that ends in *channels.txt and choose the value(s) in col1 that you want 
                                             % col1=number | col2=frequency (kHz) | col4=wavenumber (1/cm) | col8=channel;  for 1 or more, identchannel=[a,b,c]; for all, identchannel='all';                                                            
% Graphics Options														
identeps=1;				  % save as eps or png? | eps (1) png (0)
identconmetric=1;                         % include the consistency metric on the MAE/MAESkill combo graphics | yes (1) no (0)

%% %%%%%%%%%%%%%%%%%%%% %%
%% END OF USER SETTINGS %%
%% %%%%%%%%%%%%%%%%%%%% %%

identcycles=['all']; if identcompositeonly==1 identgraphicsbycycle=0; end  
if identns==1
    identnewsub=[];identnewsub_id=[];
    for i=1:size(identnewsubset,1)
        tmpnewsub=identnewsubset{i};tmpnewsub_id=identnewsubset_id{i};
        if isempty(strfind(tmpnewsub,'-'))==0 % then this is a range of dates...get all intermediate dates
            tmpnewsuba=tmpnewsub(1:10);
            tmpnewsubb=tmpnewsub(12:end);
            t1 = datetime(str2num(tmpnewsuba(1,1:4)),str2num(tmpnewsuba(1,5:6)),str2num(tmpnewsuba(1,7:8)),str2num(tmpnewsuba(1,9:10)),0,0,'format','yyyyMMddhh');
            t2 = datetime(str2num(tmpnewsubb(1,1:4)),str2num(tmpnewsubb(1,5:6)),str2num(tmpnewsubb(1,7:8)),str2num(tmpnewsubb(1,9:10)),0,0,'format','yyyyMMddhh');
            identinittimesunique2=datestr(t1:hours(6):t2,'yyyymmddhh');
            identnewsub=[identnewsub;identinittimesunique2];identnewsub_id=[identnewsub_id;repmat(identnewsubset_id,size(identnewsub,1),1)];
            clear identinittimesunique2
        else % then this is just one date...record this date
            identnewsub=[identnewsub;tmpnewsub];identnewsub_id=[identnewsub_id;tmpnewsub_id];
            clear identinittimesunique2
        end
    end
end
identexpshort=identexp;                                         
identexpsigimpshort=identexpsigimp;
stormsdone={stormsdone.name};
stormsdone=stormsdone(3:end);%testtmp=stormsdone{1};if isnan(str2double(tmptest(1)))==0; for stmdn=1:size(stormsdone,2);identtmp1=stormsdone{stmdn};identtmp2=yearsdone(stmdn,:);identtmp3=identtmp1(3:4);if strcmp(identtmp3,'AL')==1;identtmp4='l';elseif strcmp(identtmp3,'EP')==1;identtmp4='e';elseif strcmp(identtmp3,'WP')==1;identtmp4='w';elseif strcmp(identtmp3,'CP')==1;identtmp4='c';end;addpath(['scripts']);identbdecks=['bdeck/'];filename = [identbdecks,'b',lower(identtmp1(3:4)),identtmp1(1:2),yearsdone(stmdn,:),'.dat'];if isfile(filename)==1; [identhemi,DATEall,BASINall,NAMEall,CATall,LATall,POall,SE50all,LONall,PRESSall,SE64all,NE34all,RAD34all,SPEEDall,NE50all,RAD50all,SW34all,NE64all,RAD64all,SW50all,NW34all,RMWall,SW64all,NW50all,ROall,NW64all,SE34all,FHRall]=atcf(filename,1);identn=unique(NAMEall,'rows','stable');identn=identn(end,:);identn=identn(isletter(identn));ident=[identtmp1(3:4),identtmp1(1:2),identtmp2];identn=[identn,identtmp2(3:4)];identhwrf=[lower(identn(1:end-2)),lower(identtmp1(1:2)),lower(identtmp4)];if strcmp(identtmp1(1),'9')==1; identn=[identn(1:6) upper(identtmp1),identtmp2(3:4)];end;stormsdone{stmdn}=identhwrf;end;end;end;clear testtmp;

identserialcorr=.5;identlagcorr=5;                              % variance cutoff for serial correlation factor (e.g., for 50% variance, identserialcorr=.5) | maximum number of cycles for the separation time (e.g., for 24-h serial correlation that means a separation time of 30-h, or 5 6-h cycles, so identlagcorr=5)
identmaxfhr=identmaxfhr/3+1;identmodelfhr=identmodelfhr/3+1;
cnt=1;
for i=1:size(stormsdone,2)
            tmp0=stormsdone{i};
            tmp1=tmp0(1:end-30);
            tmp2=tmp0(end-28:end-25);
            stormsdone1{cnt}=tmp1;
            yearsdone1{cnt}=tmp2;
            cnt=cnt+1;
end 
[stormsdone,val]=unique(stormsdone1);stormsdone0=unique(table(stormsdone1', yearsdone1'),'rows');stormsdone=table2cell(stormsdone0(:,1))'; yearsdone0=table2cell(stormsdone0(:,2)); for yrdn=1:size(yearsdone0,1); yearsdone(yrdn,:)=yearsdone0{yrdn,:}; end;
%for i=1:size(val,1)
%    yearsdone(i,:)=yearsdone1{val(i)};
%end
%
%% Remove storms named invest if they aren't named by end of forecast
%for i=1:size(stormsdone,2)
%   tmp=stormsdone{i};
%   if strcmp(tmp(1:end-3),'invest')==1
%      stormsdone{i}=[]; 
%   end
%end
%empties = find(cellfun(@isempty,stormsdone));
%stormsdone(empties)=[];
%yearsdone(empties,:)=[];
if identcase==1
   stormsdone=identcasename;
   yearsdone=identcaseyear;
end

%% Folder
identfold='';
for i=1:size(identexp,1)
    tmp=identexpshort{i};
    if i==size(identexp,1)
        identfold=strcat(identfold,tmp,'/');
    else
        identfold=strcat(identfold,tmp,'_');
    end
end; if identremoveland==1;identfold=[identfold(1:end-1),'_noland/'];end; if identeps==1;identfold=[identfold(1:end-1),'_eps/'];else;identfold=[identfold(1:end-1),'_png/'];end;

%% Make Experiment Directory
if ~exist([identout,'RESULTS/',identfold], 'dir')
    disp('CREATING EXPERIMENT FOLDER')
    mkdir([identout,'RESULTS/',identfold,'VERIFICATION/'])
end

%% Clean Up Old Files
if ~exist([identout,'RESULTS/',identfold,'VERIFICATION/'], 'dir')
    disp('CREATING VERIFICATION FOLDER...')
    mkdir([identout,'RESULTS/',identfold,'VERIFICATION/'])
elseif identcase==0
    disp('CLEANING UP PREVIOUS VERIFICATION RESULTS...')    
    if exist([identout,'RESULTS/',identfold,'VERIFICATION/'], 'dir'); rmdir([identout,'RESULTS/',identfold,'VERIFICATION/'],'s');end;
elseif identcase==1
    disp('CLEANING UP PREVIOUS VERIFICATION RESULTS FOR THIS STORM...')
    tmpcasefold=upper(stormsdone{:});
    tmpcasefold=[tmpcasefold identcaseyear(3:4)]
    if exist([identout,'RESULTS/',identfold,tmpcasefold,'/TRACKINT/'], 'dir' ); rmdir([identout,'RESULTS/',identfold,tmpcasefold,'/TRACKINT/'],'s');end;
end

%% Save the output
save('startverif.mat')                        % this file will be saved in the [identout] directory so it can be used when needed

%% Create output file for shell script
fid = fopen('commonverif.txt','wt');
if identcase==1 
    fprintf(fid,'%s\n',['initstormsdone="',num2str(1),'"']);
else
    fprintf(fid,'%s\n',['initstormsdone="',num2str(1:size(stormsdone,2)),'"']);
end
fclose(fid); 

%% Change wall clock times
if identcase==1 || identgraphicsbycycle==1 || (identconv==1 && identgraphicsconv==1)
    copyfile('scripts/matlabverifbatchcase.ksh',['scripts/matlabverifbatch.ksh'])  % copy file for case study with larger wall clock time!
elseif identcompositeonly==1
    copyfile('scripts/matlabverifbatchshort.ksh',['scripts/matlabverifbatch.ksh'])  % copy file for case study with larger wall clock time!
else
    copyfile('scripts/matlabverifbatchall.ksh',['scripts/matlabverifbatch.ksh'])  % copy file for case study with larger wall clock time!
end

%% Create output file for shell script
tmpidentcasename=identcasename{:};
fid = fopen('caseverif.txt','wt');
fprintf(fid,'%s\n',['initcasestudy="',num2str(identcase),'"']);
fprintf(fid,'%s\n',['initpath="',[identout,'RESULTS/',identfold,'VERIFICATION/InvestN/',identbasinid,'/',upper(tmpidentcasename),yearsdone(end-1:end),'/'],'"']);
fprintf(fid,'%s\n',['initend="',[identout,'RESULTS/',identfold],'"']);
fprintf(fid,'%s\n',['initcasetcname="',[upper(tmpidentcasename),yearsdone(end-1:end)],'"']);
fclose(fid);
