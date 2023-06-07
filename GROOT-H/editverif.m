%% %%%%%%%%%%%%%%%%%%%%%% %%
%% START OF USER SETTINGS %%
%% %%%%%%%%%%%%%%%%%%%%%% %%

% Set Directories and Model Properties
identout=['/scratch2/AOML/aoml-hafs1/Sarah.D.Ditchek/GROOT/GROOT-H/'];  	 % top-level directory path for results folder
identgroot=['/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-H/GROOT-PR/']; % location of GROOT-PR directory (${homepath}/GROOT/GROOT-H/GROOT-PR/, where homepath is same as in runverif.ksh)
identmaxfhr=(126)/3+1;identmodelfhr=126/3+1;                            	 % X/3+1, where X is the max 1) identmaxfhr-you want for graphics and 2) identmodelfhr-output by your model
identbasinmodel=0;                                                               % are there multiple storms being tracked at once (e.g., basin-scale HWRF or GFS)? | yes (1) no (0)
identhwrfmodel=0;identhafsmodel=1;					         % did you run HWRF or HAFS? | yes (1) no (0)

% Choose experiments and colors
identexp=[{'ALL'};{'NONS'};{'NOIC'};{'NOG4'}];		   	        % folder name of all experiments - must match "expnew" in runverif.ksh and last must be the BASELINE
                                                                             % NOTE: the first experiment listed MUST be the one with all the observations assimilated
identexpsigimp='NOG4';                                                  % full folder name of improvement and significance wrt THIS experiment (i.e., your BASELINE)
identexpcolors=[0 152 0;146 108 172;213 157 1;208 0 0]/255;             % colors associated with each experiment - do NOT use black since the best track is black by default
        	                                                             % EX1: For 2 experiments, recommended colors:  green(included)=[0 152 0] red(denied)=[208 0 0]
									     % EX2: For more than 2 experiments, remember, "green" implies yes and "red" implies no
stormsdone=dir([identgroot,'/ALL']);                                    % short name of experiment that's completed the most cycles (must match name in "expnew" in runverif.ksh)

% Case Study: also make identgraphicsbycycle=1, identgraphicsconv=1 or identgaphicssat=1 if testing obs impact, and identcompositeonly=0
identcase=0;								% run graphics for just 1 storm | yes (1) no (0)
identcasename={'delta26l'};identbasinid='AL';				% identcasename: lowercase name of storm, ID, and basin identifier (e.g., dorian05l) | % identbasinid: upper case 2-letter basin identifier
identcaseyear='2020';							% year of storm: YYYY

% Error Graphics Options
identgraphicsbycycle=0;                                         % error graphics for EACH CYCLE - must be 0 if identcompositeonly=1 | yes (1) no (0 - this saves time)
identcompositeonly=1;						% only generate composite graphics | yes (1 - this saves time) no (0 - you get indiv. storm error statistics output)
identns=0;                                                      % do you want to create a new subset, different that what is in the package? | yes (1) no (0)
identnsname='OG4IC';                                            % name for new subset - will be capitalized in the script
identnewsubset_id=[{'06L'};{'06L'};{'06L'};{'06L'};{'06L'};{'14L'};{'14L'};{'14L'};{'05L'};{'05L'};{'05L'};{'05L'};{'05L'};{'05L'};{'14L'};{'13L'};{'13L'}]; % new subset stormids if identns=1 - each associated entry in identnewsubset, enter the stormid (if range of cycles, enter the stormid once)
identnewsubset=[{'2018091000'}; {'2018091200'}; {'2018091212'}; {'2018091300'}; {'2018091400'}; {'2018100900'}; {'2018100912'}; {'2018101000'}; {'2019082700'}; {'2019082800'}; {'2019083000'}; {'2019090100'}; {'2019090112'}; {'2019090312'}; {'2020082306'}; {'2020082512'}; {'2020082600'}]; % new subset cycle times if identns=1 - you can use a range of cycles, disjointed cycles, or both
                	            	                                % range of cycles: [{'2017081800-2017083100'}] %disjointed cycles: [{'2017081800'};{'2017090200'}]                                                                                           % range and disjointed cycles: [{'2017081800-2017083100'};{'2017090200'}]
identenkfexact=0;						%  covariance-type stratification - exact method ONLY WORKS FOR HWRF | if you used the retrieval scripts included in GROOT (1) if you did not use the retrieval scripts or there is no difference in covariance type (0)
identenkfoper=1;identenkfoperpath='/scratch1/NCEPDEV/hwrf/noscrub/input/TDR/'; % covariance-type stratification - operational method - note that for HAFS if this is enabled, graphics will indicate pre- and post- TDR rahter than enkf vs gdas covariance | all cycles from the first TDR available through the end of the TC used enfk (1) do not do stratifications by enkf (0) | note that identenkfoperpath is the path to the TDR files on disk - if your model doesn't have this, set to identenkfoper=0.
identremoveland=0;						% do you want to remove cycles where either best track or forecast was over land | yes (1) no (0)

% Conventional Graphics Options
identconv=1;                                                   		   % conventional observation graphics | yes (1) no (0 - if not retrieved using included retrieval script)
identgraphicsconv=0;                                            	   % conventional observation graphics for EACH CYCLE | yes (1) no (0 - this saves time)
identconvid='Recon';                                            	   % name of observation for graphic titles | uppercase first letter | will become "Assimilated ____ Observations"
if identhafsmodel==1
   identconvid_filename=[{'_rw_anl'};{'_rw_anl'};{'_t_anl'};{'_t_anl'}];   % if identhafsmodel=1, filenames of data desired ensuring it starts with "_" and equals length of identconvobstype
end
identconvobstype=[993 992 136 137];					   % obstype number(s) | number of obstypes must match number of obssubtypes
							 	      		% if an obstype is associated with multiple obssubtypes, repeat obstype for each obssubtype. if you want ALL obssubtypes for a given obstype, only list the obstype once and enter "0" as the corresponding obssubtype and set the corresponding identsubtypekeep to 0.
									        % the order of the obstypes will be plotting order, so put more sparse obs last
identconvobssubtype=[0 0 0 0];identsubtypekeep=[1 1 1 1];		   % corresponding obssubtype number(s) | number of obssubtypes must match number of obstypes | identsubtypekeep must match number of identconvobstype and identconvobssubtype | keep subtype (1) use all subtypes for this obtype (0)
identconvobscolors=[30 144 255;0 152 0;230 102 51;204 51 204]/255; 	   % colors for each of your subtypes (will only be used if identconvobssubtype has >1 value)
identconvobslegend=[{'P3 TDR Observations'};{'G-IV TDR Observations'};{'High-Density Observations'};{'Dropsonde Observations'}]; % names of each of your subtypes for the plot legends

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
identconmetric=1;			  % include the consistency metric on the error/skill combo graphics for both the mean and median | yes (1) no (0)

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
