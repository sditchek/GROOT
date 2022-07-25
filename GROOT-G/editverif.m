%% %%%%%%%%%%%%%%%%%%%%%% %%
%% START OF USER SETTINGS %%
%% %%%%%%%%%%%%%%%%%%%%%% %%

% Set Directories and Model Properties
identout=['/scratch2/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-G/'];             % directory path for results | must be same as resultspath in runverif.ksh
identgroovpr=[identout,'GROOT-PR/'];						  % DO NOT CHANGE - location of your GROOT-PR dirctory
identmaxfhr=(126)/3+1;identmodelfhr=126/3+1;                                 	  % X/3+1, where X is the max 1) identmaxfhr-you want for graphics and 2) identmodelfhr-output by your model
identbasinmodel=1;                                                                % are there multiple storms being tracked at once (e.g., basin-scale HWRF or GFS)? | yes (1) no (0)

% Choose experiments and colors
identexp=[{'HF3A'};{'HF3S'};{'HWRF'}]; 		 	                                  % folder name of all experiments - must match "expnew" in runverif.ksh and last must be the BASELINE
                                                                                       % NOTE: the first experiment listed MUST be the one with all the observations assimilated
identexpsigimp='HWRF';                                                              % full folder name of improvement and significance wrt THIS experiment (i.e., your BASELINE)
identexpcolors=[0 152 0;208 0 0]/255;  						  % colors associated with each experiment - do NOT use black since the best track is black by default
        	                                                                       % EX1: For 2 experiments, recommended colors:  green(included)=[0 152 0] red(denied)=[208 0 0]
										       % EX2: For more than 2 experiments, remember, "green" implies yes and "red" implies no
stormsdone=dir([identgroovpr,'/HWRF/atcf']);                           % short name location of the experiment that's furthest along (must match name in "expnew" in runverif.ksh)

% Case Study: recommendation - also make identgraphicsbycycle=1, identgraphicsconv=1 or identgaphicssat=1 if testing obs impact, and identcompositeonly=0
identcase=0';								          % run graphics for just 1 storm | yes (1) no (0)
identcasename={'05AL'};tmpcasefold='DORIAN19';                                      % identcasename=ID and basin identifier (05AL) | tmpcasefold=uppercase name and 2-digit year (DORIAN19)
identcaseyear='2019';							          % year of storm: YYYY

% Error Graphics Options
identgraphicsbycycle=0;                                         % error graphics for EACH CYCLE - must be 0 if identcompositeonly=1 | yes (1) no (0 - this saves time)
identcompositeonly=1;						% only generate composite graphics | yes (1 - this saves time) no (0 - you get indiv. storm error statistics output)
identns=0;                                                      % do you want to create a new subset, different that what is in the package? | yes (1) no (0)
identnsname='RMDR';                                             % name for new subset - will be capitalized in the script
identnewsubset=[{'2019082306-2019082612'}];  			% new subset cycle times if identns=1 - you can use a range of cycles, disjointed cycles, or both
                	                                            % range of cycles: [{'2017081800-2017083100'}] %disjointed cycles: [{'2017081800'};{'2017090200'}]
		        	                                    % range and disjointed cycles: [{'2017081800-2017083100'};{'2017090200'}]
identremoveland=0;						% do you want to remove cycles where the best track was over land | yes (1) no (0)
identserialcorr=.5;identlagcorr=5;                        	% variance cutoff for serial correlation factor (e.g., for 50% variance, identserialcorr=.5) | maximum number of cycles for the separation time (e.g., for 24-h serial correlation that means a separation time of 30-h, or 5 6-h cycles, so identlagcorr=5)

% Conventional Graphics Options
identconv=0;                                                    % conventional observation graphics | yes (1) no (0 - if not retrieved using included retrieval script)
identgraphicsconv=0;                                            % conventional observation graphics for EACH CYCLE | yes (1) no (0 - this saves time)
identconvid='Dropsonde';                                        % full name of conventional observation | uppercase first letter | singular - will be come "Assimilated ____ Observations"
identconvobs=137;						% conventional observation obstype
identconvtype=[0];                                              % subtypes desired 
identincludeobs=1					% the value of (Prep_Use_Flag+Analysis_Use_Flag) that means that the observation was assimilated
                                                                    % NO SUBTYPE: identconvtype=0
                                                                    % YES SUBTYPE: identconvtype=[A B], where A and B are numbers from the diag file - any number of subtypes are supported
identconvcolors=[.8 .2 .8;.9 .4 .2];                            % colors for each of your subtypes
identconvlegend=[{'Assimilated Mie (Cloudy) Observations'};{'Assimilated Rayleigh (Clear) Observations'}]; % names of each of your subtypes for the plot legends

% Satellite Graphics Options
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
    identnewsub=[];
    for i=1:size(identnewsubset,1)
        tmpnewsub=identnewsubset{i};
        if isempty(strfind(tmpnewsub,'-'))==0 % then this is a range of dates...get all intermediate dates
            tmpnewsuba=tmpnewsub(1:10);
            tmpnewsubb=tmpnewsub(12:end);
            t1 = datetime(str2num(tmpnewsuba(1,1:4)),str2num(tmpnewsuba(1,5:6)),str2num(tmpnewsuba(1,7:8)),str2num(tmpnewsuba(1,9:10)),0,0,'format','yyyyMMddhh');
            t2 = datetime(str2num(tmpnewsubb(1,1:4)),str2num(tmpnewsubb(1,5:6)),str2num(tmpnewsubb(1,7:8)),str2num(tmpnewsubb(1,9:10)),0,0,'format','yyyyMMddhh');
            identinittimesunique2=datestr(t1:hours(6):t2,'yyyymmddhh');
            identnewsub=[identnewsub;identinittimesunique2];
            clear identinittimesunique2
        else % then this is just one date...record this date
            identnewsub=[identnewsub;tmpnewsub];
            clear identinittimesunique2
        end
    end
end
identexpshort=identexp;                                         
identexpsigimpshort=identexpsigimp;
stormsdone={stormsdone.name};
stormsdone=stormsdone(3:end);%testtmp=stormsdone{1};if isnan(str2double(tmptest(1)))==0; for stmdn=1:size(stormsdone,2);identtmp1=stormsdone{stmdn};identtmp2=yearsdone(stmdn,:);identtmp3=identtmp1(3:4);if strcmp(identtmp3,'AL')==1;identtmp4='l';elseif strcmp(identtmp3,'EP')==1;identtmp4='e';elseif strcmp(identtmp3,'WP')==1;identtmp4='w';elseif strcmp(identtmp3,'CP')==1;identtmp4='c';end;addpath(['scripts']);identbdecks=['bdeck/'];filename = [identbdecks,'b',lower(identtmp1(3:4)),identtmp1(1:2),yearsdone(stmdn,:),'.dat'];if isfile(filename)==1; [identhemi,DATEall,BASINall,NAMEall,CATall,LATall,POall,SE50all,LONall,PRESSall,SE64all,NE34all,RAD34all,SPEEDall,NE50all,RAD50all,SW34all,NE64all,RAD64all,SW50all,NW34all,RMWall,SW64all,NW50all,ROall,NW64all,SE34all,FHRall]=atcf(filename,1);identn=unique(NAMEall,'rows','stable');identn=identn(end,:);identn=identn(isletter(identn));ident=[identtmp1(3:4),identtmp1(1:2),identtmp2];identn=[identn,identtmp2(3:4)];identhwrf=[lower(identn(1:end-2)),lower(identtmp1(1:2)),lower(identtmp4)];if strcmp(identtmp1(1),'9')==1; identn=[identn(1:6) upper(identtmp1),identtmp2(3:4)];end;stormsdone{stmdn}=identhwrf;end;end;end;clear testtmp;
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
%   if strcmp(tmp(1),'9')==1
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
    if exist([identout,'RESULTS/',identfold,tmpcasefold,'/'], 'dir' ); rmdir([identout,'RESULTS/',identfold,tmpcasefold,'/'],'s');end;
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
fprintf(fid,'%s\n',['initpath="',[identout,'RESULTS/',identfold,'VERIFICATION/**/**/',upper(tmpcasefold),'*'],'"']);
fprintf(fid,'%s\n',['initend="',[identout,'RESULTS/',identfold],'"']);
fclose(fid);
