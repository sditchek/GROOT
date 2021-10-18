%% %%%%%%%%%%%%%%%%%%%%%% %%
%% START OF USER SETTINGS %%
%% %%%%%%%%%%%%%%%%%%%%%% %%

% Set Directories and Model Properties
identgroovpr=['/scratch1/BMC/qosap/Sarah.D.Ditchek/GROOT/GROOT-H/GROOT-PR/'];    % location of your GROOT-PR dirctory
identout=['/scratch1/BMC/qosap/Sarah.D.Ditchek/GROOT/GROOT-H/'];                 % location of where all graphics will go
identmaxfhr=(126)/3+1;                                                        	 % max forecast hours steps set in model (e.g., 126)
identbasinmodel=1;                                                               % are there multiple storms being tracked at once (e.g., basin-scale HWRF or GFS)? | yes (1) no (0)

% Choose experiments and colors
identexp=[{'ALL'};{'NO'}];                                      % folder name of all experiments to compare - (must match names in "expnew" in runverif.ksh)
                                                                                 	% NOTE: the first experiment listed MUST be the one with all the observations assimilated
identexpsigimp='NO';                                                            % full folder name of improvement and significance wrt THIS experiment
identexpcolors=[0 152 0;208 0 0]/255;                    % colors associated with each experiment
                                                                                 	% EX1: For 2 experiments, recommended colors:  green(included)=[0 152 0] red(denied)=[208 0 0]
										     	% EX2: For more than 2 experiments, remember, "green" implies yes and "red" implies no
stormsdone=dir([identgroovpr,'/NO']);                                           % short name location of the experiment that's furthest along (must match name in "expnew" in runverif.ksh)

% Case Study 
% Recommendation: make identgraphicsbycycle=1 and identgraphicsconv=1 or identgaphicssat=1, depending on your O(S)SE) for more details
identcase=0';								        % run graphics for just 1 storm | yes (1) no (0)
identcasename={'florence06l'};						        % lowercase name of storm, ID, and basin identifier: dorian05l
identcaseyear='2018';							        % year of storm: YYYY

% Error Graphics Options
identgraphicsbycycle=0;                                         % error graphics for EACH CYCLE - must be 0 if identcompositeonly=1 | yes (1) no (0 - this saves time)
identcompositeonly=1;						% only generate composite graphics | yes (1 - this saves time) no (0 - you get indiv. storm error statistics output)
identlagcorr=0;							% do you want to create lagged correlation graphics? | yes (1) no (0 - this saves time)			
identns=0;                                                      % do you want to create a new subset, different that what is in the package? | yes (1) no (0)
identnsname='test';                                             % name for new subset - will be capitalized in the script
identnewsubset=[{'2017081800-2017083100'};{'2017090200'}];      % new subset cycle times if identns=1 - you can use a range of cycles, disjointed cycles, or both
                                                                     % range of cycles: [{'2017081800-2017083100'}]
                                                                     % disjointed cycles: [{'2017081800'};{'2017090200'}]
                                                                     % range and disjointed cycles: [{'2017081800-2017083100'};{'2017090200'}]

% Conventional Graphics Options
identconv=1;                                                    % conventional observation graphics | yes (1) no (0 - if not retrieved using included retrieval script)
identgraphicsconv=0;                                            % conventional observation graphics for EACH CYCLE | yes (1) no (0 - this saves time)
identconvid='Dropsonde';                                        % full name of conventional observation | uppercase first letter | singular - will be come "Assimilated ____ Observations"
identconvtype=[0];                                              % subtypes desired 
                                                                    % NO SUBTYPE: identconvtype=0
                                                                    % YES SUBTYPE: identconvtype=[A B], where A and B are numbers from the diag file - any number of subtypes are supported
identconvcolors=[.8 .2 .8;.9 .4 .2];                            % colors for each of your subtypes
identconvlegend=[{'Assimilated Mie (Cloudy) Observations'};{'Assimilated Rayleigh (Clear) Observations'}]; % names of each of your subtypes for the plot legends

% Satellite Graphics Options
identsatobs=0;                                                  % create satellite graphics if user-retrieved using the included retrieval script | yes (1) no (0)
identgraphicssat=1;						% satellite graphics for EACH CYCLE | yes (1) no (0 - this saves time)
identsatid='iasi_g13';                                          % if the above is yes (1), then type the satellite name here - must match the diag file
identsatname='Geo-HSS';						% full name of satellite observation | uppercase first letter | singular
identindivch=1;                                                 % create individual-channel graphics (turn off to save time) | yes (1) no (0)
identchannel=[200];                                             % used to generate graphics of profiles assimilated by channel
                                                                    % look in your COM directory for the file that ends in *channels.txt and choose the value(s) in col1 that you want 
                                                                    % col1=number | col2=frequency (kHz) | col4=wavenumber (1/cm) | col8=channel
                                                                    % for 1 or more, identchannel=[a,b,c];
                                                                    % for all, identchannel='all';                                                            

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
stormsdone=stormsdone(3:end);
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
end

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
    rmdir([identout,'RESULTS/',identfold,'VERIFICATION/'],'s')
elseif identcase==1
    disp('CLEANING UP PREVIOUS VERIFICATION RESULTS FOR THIS STORM...')
    tmpcasefold=upper(stormsdone{:});
    tmpcasefold=[tmpcasefold(1:end-3) identcaseyear(3:4)]
    rmdir([identout,'RESULTS/',identfold,tmpcasefold,'/'],'s')
end

%% Save the output
save([identout,'startverif.mat'])                        % this file will be saved in the [identout] directory so it can be used when needed

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
fprintf(fid,'%s\n',['initpath="',[identout,'RESULTS/',identfold,'VERIFICATION/**/**/',upper(tmpidentcasename(1:end-3)),'*'],'"']);
fprintf(fid,'%s\n',['initend="',[identout,'RESULTS/',identfold],'"']);
fclose(fid);
 
