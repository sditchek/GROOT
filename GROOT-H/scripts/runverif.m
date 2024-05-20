load('startverif.mat')
for identremoveinvest=1
    if identremoveinvest==1
        identremoveinv=1;
        identremovename='InvestN';
    elseif identremoveinvest==2 % For speed, this capability is removed. If you are reading the code and want to include when invests occur, change the for loop to be identremoveinvest=1:2
        identremoveinv=0;
        identremovename='InvestY';
    end
    identremoveex=1;set(groot,'defaultAxesXTickLabelRotationMode','manual');set(groot,'defaultAxesYTickLabelRotationMode','manual');set(groot,'defaultAxesZTickLabelRotationMode','manual'); 
    if identindivstorm==1
        for stmdn=identstormsdone
            %% %%%%%%%%%%%%%%%% %%
            %% Set Up the Storm %%
            %% %%%%%%%%%%%%%%%% %%
            for editsingle=1
                identtmp1=stormsdone{stmdn};
                identtmp2=yearsdone(stmdn,:);
                if strcmp(identtmp1(end),'l')==1;identtmp3='AL';
					elseif strcmp(identtmp1(end),'e')==1;identtmp3='EP';
					elseif strcmp(identtmp1(end),'w')==1;identtmp3='WP';elseif strcmp(identtmp1(end),'b')==1;identtmp3='IO';elseif strcmp(identtmp1(end),'a')==1;identtmp3='IO';elseif strcmp(identtmp1(end),'s')==1;identtmp3='SH';elseif strcmp(identtmp1(end),'p')==1;identtmp3='SH';
					elseif strcmp(identtmp1(end),'c')==1;identtmp3='CP';
				end
                % Set Name
                ident=[identtmp3,identtmp1(end-2:end-1),identtmp2];      % basin, ID, and year (e.g., AL092016)
                identn=[upper(identtmp1(1:end-3)),identtmp2(3:4)];       % NAMEYY (e.g., HERMINE16)
                identhwrf=identtmp1; identn= [upper(identtmp1),identtmp2(3:4)];                                  % name, ID, and short basin - check grb2 file output names if confused (e.g., hermine09l)
                % Model outputs at 3 h, but to compare errors to BT make 6 h!
                skip=2;                                                  % 6 h res | skip=1 is 3 h
                skiphr=6;                                                % 6 h res | skiphr=3 is 3 h res
                skiptick=2; if identmaxfhr*3>129; skiptick=4; end;         % 6 h res | skiptick=4 is 3 h res
                skipfct=4;                                               % 6 h res | skipfct=4 is still 3 h res
                % Save the config file for future reference
                disp(['Creating Start Parameters for ',identn])           
                identfold='';
                for i=1:size(identexp,1)
                    tmp=identexpshort{i};
                    if i==size(identexp,1)
                        identfold=strcat(identfold,tmp,'/');
                    else
                        identfold=strcat(identfold,tmp,'_');
                    end
                end; if identremoveland==1;identfold=[identfold(1:end-1),'_noland/'];end;if identeps==1;identfold=[identfold(1:end-1),'_eps/'];else;identfold=[identfold(1:end-1),'_png/'];end;
                if ~exist(['cases/',identfold], 'dir')                 % if this is the first time running these scripts, it will create the cases directory
                    mkdir(['cases/',identfold])
                end
                if identcase==1;copyfile('editverif.m',['cases/',identfold,identn,'_editverif.m']);copyfile('runverif.ksh',['cases/',identfold,identn,'_runverif.ksh']);else;copyfile('editverif.m',['cases/',identfold,'editverif.m']);copyfile('runverif.ksh',['cases/',identfold,'runverif.ksh']);end;  % copy file into cases directory so if you need to run again, you'll already have it saved!
                % Save the output
                save('indivparams.mat')                              % this file will be saved in the running directory so it can be used when needed
                % Get common initalizations between all experiments
                for comm=1
                    cnt=1;
                    for tmp=1:size(identexpshort,1)
                        identdr=dir([identgroot,identexp{tmp},'/',identtmp1,'*','atcfunix*']);
                        if isempty(identdr)==1
                            breakscript='yes';
                        else
                            identdr=unique({identdr.name});
                            for i=1:size(identdr,2)
                                tmp2=identdr{i};
                                tmp2=tmp2(end-28:end-19);
                                identdr1(cnt,:)=tmp2;
                                cnt=cnt+1;
                            end 
                        end
                    end    
                    A = str2num(identdr1);
                    [n, bin] = histc(A, unique(A));
                    multiple = find(n > size(identexpshort,1)-1);
                    index    = find(ismember(bin, multiple));
                    identinittimesunique=unique(identdr1(index,:),'rows');investhelp=sum(identinittimesunique(:,1:4)==yearsdone(stmdn,:),2);identinittimesunique=identinittimesunique(investhelp==4,:);
                end
                if identconv==1 && isempty(identinittimesunique)==0 && identhwrfmodel==1
		% Get common initalizations between all experiment - this might be different from the original atcf count due to in-progress runs! This only is needed for the conv and sat sections since they have new, unique files in scrub/
			cnt=1; clear identdr1
			 for tmp=1:size(identexpshort,1)
				if identhwrfmodel==1;identdr=dir([identgroot,'obsall/',identexp{tmp},'/',identtmp1,'*anl0*']);elseif identhafsmodel==1;identdr=dir([identgroot,'obsall/',identexp{tmp},'/',identtmp1,'*',identconvid_filename{1},'*']);end
				identdr=unique({identdr.name});
				for i=1:size(identdr,2)
					tmp2=identdr{i};
					if identhwrfmodel==1;tmp2=tmp2(end-25:end-16);elseif identhafsmodel==1;tmp2=tmp2(end-13:end-4);end			
					identdr1(cnt,:)=tmp2;
					cnt=cnt+1;
				end        
			end    
			A = str2num(identdr1);
			[n, bin] = histc(A, unique(A));
			multiple = find(n > size(identexpshort,1)-1);
			index    = find(ismember(bin, multiple));
            identinittimesunique=unique(identdr1(index,:),'rows');investhelp=sum(identinittimesunique(:,1:4)==yearsdone(stmdn,:),2);identinittimesunique=identinittimesunique(investhelp==4,:);
		end	
		% Identify which cycle numbers will be running
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
            end
            if exist('breakscript','var')==1 || size(identinittimesunique,1)==0
                disp([identn,' does not exist across all experiments yet...moving to next storm'])
                clearvars -except identboxhist identconmetric identeps identmodelfhr identincludeobs identconvobs identserialcorr identbasinmodel identsatobs identgraphicssat identsatid identsatname identindivch identchannel identindivstorm identcomposite identstormsdone identconvobssubtype identconvobscolors identconvobslegend identns* identnewsub identgraphicsbycycle identgraphicsconv identconvid  stormsdone yearsdone identdiff identremovename identremoveex identremoveinv identcycles identmaxfhr identlevels identexp identexpshort identexpsigimp identexpsigimpshort identexpcolors identscrub identgroot identout identconv  
            else
                %% %%%%%%%%%%%% %%
                %% Setup script %%
                %% %%%%%%%%%%%% %%
                for setup=1
                    % Load the indivparams.mat that is set in editsingle.m
                    load('indivparams.mat')
                    % Add paths to scripts
                    addpath('scripts')
                    identfold='';
                    for i=1:size(identexp,1)
                        tmp=identexpshort{i};
                        if i==size(identexp,1)
                            identfold=strcat(identfold,tmp,'/');
                        else
                            identfold=strcat(identfold,tmp,'_');
                        end
                    end; if identremoveland==1;identfold=[identfold(1:end-1),'_noland/'];end;if identeps==1;identfold=[identfold(1:end-1),'_eps/'];else;identfold=[identfold(1:end-1),'_png/'];end;
                    if ~exist([identout,'RESULTS/',identfold], 'dir')
                        disp('CREATING EXPERIMENT FOLDER')
                        mkdir([identout,'RESULTS/',identfold])
                    end
                    % Create Directory Structure
                    if ~exist([identout,'RESULTS/',identfold,'VERIFICATION/',identremovename,'/',ident(1:2),'/',identn], 'dir')
                        disp('CREATING DIRECTORY STRUCTURE')
                        mkdir([identout,'RESULTS/',identfold,'VERIFICATION/',identremovename,'/',ident(1:2),'/',identn])
                        mkdir([identout,'RESULTS/',identfold,'VERIFICATION/',identremovename,'/',ident(1:2),'/',identn,'/TRACKINT/'])
                        mkdir([identout,'RESULTS/',identfold,'VERIFICATION/',identremovename,'/',ident(1:2),'/',identn,'/TRACKINT/FULL/'])
                    else
                        disp('DIRECTORY STRUCTURE ALREADY EXISTS')
                    end
                    identtrackint=[identout,'RESULTS/',identfold,'VERIFICATION/',identremovename,'/',ident(1:2),'/',identn,'/TRACKINT'];
                    identbdecks='bdeck/';
                    % Get common initalizations between all experiments
                    cnt=1;
                     for tmp=1:size(identexpshort,1)
                        identdr=dir([identgroot,identexp{tmp},'/',identtmp1,'*','atcfunix*']);
                        identdr=unique({identdr.name});
                        for i=1:size(identdr,2)
                            tmp2=identdr{i};
                            tmp2=tmp2(end-28:end-19);
                            identdr1(cnt,:)=tmp2;
                            cnt=cnt+1;
                        end        
                    end    
                    A = str2num(identdr1);
                    [n, bin] = histc(A, unique(A));
                    multiple = find(n > size(identexpshort,1)-1);
                    index    = find(ismember(bin, multiple));
                    identinittimesunique=unique(identdr1(index,:),'rows');investhelp=sum(identinittimesunique(:,1:4)==yearsdone(stmdn,:),2);identinittimesunique=identinittimesunique(investhelp==4,:);
					if identconv==1 && isempty(identinittimesunique)==0 && identhwrfmodel==1
                    % Get common initalizations between all experiment - this might be different from the original atcf count due to in-progress runs! This only is needed for the conv and sat sections since they have new, unique files in scrub/
                        cnt=1; clear identdr1
                         for tmp=1:size(identexpshort,1)
								if identhwrfmodel==1;identdr=dir([identgroot,'obsall/',identexp{tmp},'/',identtmp1,'*anl0*']);elseif identhafsmodel==1;identdr=dir([identgroot,'obsall/',identexp{tmp},'/',identtmp1,'*',identconvid_filename{1},'*']);end
                                identdr=unique({identdr.name});
                                for i=1:size(identdr,2)
                                        tmp2=identdr{i};
										if identhwrfmodel==1;tmp2=tmp2(end-25:end-16);elseif identhafsmodel==1;tmp2=tmp2(end-13:end-4);end			
                                        identdr1(cnt,:)=tmp2;
                                        cnt=cnt+1;
                                end
                        end
                        A = str2num(identdr1);
                        [n, bin] = histc(A, unique(A));
                        multiple = find(n > size(identexpshort,1)-1);
                        index    = find(ismember(bin, multiple));
						identinittimesunique=unique(identdr1(index,:),'rows');investhelp=sum(identinittimesunique(:,1:4)==yearsdone(stmdn,:),2);identinittimesunique=identinittimesunique(investhelp==4,:);
					end
                    % Add package to read grb2 files to path
                    %run('nctoolbox-1.1.3/setup_nctoolbox')
                end
                %% %%%%%%%%% %%
                %% Get BDECK %%
                %% %%%%%%%%% %%
                for bdecks=1
                    filename = [identbdecks,'b',lower(ident),'.dat'];
					[identhemi,DATEall,BASINall,NAMEall,CATall,LATall,POall,SE50all,LONall,PRESSall,SE64all,NE34all,RAD34all,SPEEDall,NE50all,RAD50all,SW34all,NE64all,RAD64all,SW50all,NW34all,RMWall,SW64all,NW50all,ROall,NW64all,SE34all,FHRall,INTCHall,UMOTall,VMOTall,SHRall,LOWbasin,HIGHbasin,LANDall,HFIPINTCHall]=atcf_shear(filename,1,identbdecks);
                    save([identout,'RESULTS/',identfold,'VERIFICATION/',identremovename,'/',ident(1:2),'/',identn,'/',identn,'_data.mat'])
                end
                %% %%%%%%%%%%%%%% %%
                %% Track of Storm %%
                %% %%%%%%%%%%%%%% %%
                for track=1
                    clear l cntexp
                    spPos=[0.11 0.13 0.75 0.75]; % arrange plots the same
                    set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                    hfig=figure;
                    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                    ax1=subplot(3,4,[1:8]);
                    hold on
                    load coastlines
                    for i=1:size(CATall,1)
                        if strcmp(CATall(i,:),'WV')==1 || strcmp(CATall(i,:),'EX')==1 || strcmp(CATall(i,:),'LO')==1 || strcmp(CATall(i,:),'DB')==1 || strcmp(CATall(i,:),'SD')==1 || strcmp(CATall(i,:),'SS')==1
                            SPEEDall(i)=-1;
                        end
                    end         
                    h=fill([200,-200,-200,200],[-90,-90,90,90],[.5 .8 1]);
                    hold on
                    geoshow('borders.shp','FaceColor',[0.9 0.9 0.9]);
                    hold on
                    states = shaperead('usastatehi', 'UseGeoCoords', true);
                    geoshow(states,'FaceColor',[0.9 0.9 0.9]);
                    tmpminlat=min(LATall(:));
                    tmpmaxlat=max(LATall(:));
                    tmpminlon=min(LONall(:));
                    tmpmaxlon=max(LONall(:));
                    tmplat=tmpmaxlat+5-(tmpminlat-5);
                    tmplon=tmpmaxlon+5-(tmpminlon-5);
                    difftmp=tmplat-tmplon;
                    if difftmp<0 % longitude is wider than latitude
                        diffmult=tmplon/2;
                        diffmid=(tmpmaxlat+5+(tmpminlat-5))/2;
                        xlim([tmpminlon-5 tmpmaxlon+5])
                        x_dist=(tmpminlon-5)-(tmpmaxlon+5);
                        x_mean=((tmpminlon-5)+(tmpmaxlon+5))/2;
                        ylim([diffmid-diffmult diffmid+diffmult])
                        y_dist=(diffmid-diffmult)-(diffmid+diffmult);
                        y_mean=((diffmid-diffmult)-(diffmid+diffmult))/2;
                    else         % latitude is wider than longitude
                        diffmult=tmplat/2;
                        diffmid=(tmpmaxlon+5+(tmpminlon-5))/2;
                        xlim([tmpminlon-diffmult tmpmaxlon+diffmult])
                        x_dist=(tmpminlon-diffmult)-(tmpmaxlon+diffmult);
                        x_mean=((tmpminlon-diffmult)+(tmpmaxlon+diffmult))/2;
                        ylim([tmpminlat-5 tmpmaxlat+5])
                        y_dist=(tmpminlat-5)-(tmpmaxlat+5);
                        y_mean=((tmpminlat-5)+(tmpmaxlat+5))/2;
                    end
                    c_adj=cosd(y_mean);
                    c_dist=abs(x_dist*c_adj/2);
                    c_mid=x_mean;
                    xlim([c_mid-c_dist-5 c_mid+c_dist+5])
                    hold on
                    xlabel('Longitude','fontsize',20)
                    ylabel('Latitude','fontsize',20)                                   
                    set(gca,'fontsize',18)  
                    set(gca,'xtick',-180:10:180)
                    set(gca,'ytick',-90:5:90)
                    plot(LONall,LATall,'-k','linewidth',4);
                    hold on
                    azavcm=jet(7);
                    for i=1:length(LONall)
						if strcmp(DATEall(i,9:10),'00')==1 || strcmp(DATEall(i,9:10),'06')==1 || strcmp(DATEall(i,9:10),'12')==1 || strcmp(DATEall(i,9:10),'18')==1                        
							if SPEEDall(i) > 0 && SPEEDall(i) < 34./1.94384 
								plot(LONall(i),LATall(i),'.','color',azavcm(2,:),'markersize',12);            
							elseif SPEEDall(i) >= 34./1.94384 && SPEEDall(i) < 64./1.94384 
								plot(LONall(i),LATall(i),'.','color',azavcm(3,:),'markersize',12);            
							elseif SPEEDall(i) >= 64./1.94384 && SPEEDall(i) < 83./1.94384
								plot(LONall(i),LATall(i),'.','color',azavcm(4,:),'markersize',12);            
							elseif SPEEDall(i) >= 83./1.94384 && SPEEDall(i) < 96./1.94384 
								plot(LONall(i),LATall(i),'.','color',azavcm(5,:),'markersize',12);            
							elseif SPEEDall(i) >= 96./1.94384 && SPEEDall(i) < 113./1.94384 
								plot(LONall(i),LATall(i),'.','color',azavcm(6,:),'markersize',12);            
							elseif SPEEDall(i) >=113./1.94384 && SPEEDall(i) < 137./1.94384 
								plot(LONall(i),LATall(i),'.','color',azavcm(7,:),'markersize',12);           
							elseif SPEEDall(i) >= 137./1.94384
								plot(LONall(i),LATall(i),'.','color','m','markersize',12); 
							elseif strcmp(CATall(i,:),'LO')==1 || strcmp(CATall(i,:),'DB')==1 || strcmp(CATall(i,:),'WV')==1
								plot(LONall(i),LATall(i),'.','color',[.5 .5 .5],'markersize',12);             
							elseif strcmp(CATall(i,:),'SD')==1 || strcmp(CATall(i,:),'SS')==1
								plot(LONall(i),LATall(i),'s','color',[.5 .5 .5],'markersize',4,'markerfacecolor',[.5 .5 .5]);                 
							elseif strcmp(CATall(i,:),'EX')==1
								plot(LONall(i),LATall(i),'d','color',[.5 .5 .5],'markersize',3,'markerfacecolor',[.5 .5 .5]);                 
							end
						end
                    end
                    for i=1:length(LONall)
                        if strcmp(DATEall(i,9:10),'00')==1
                            plot(LONall(i),LATall(i),'o','markeredgecolor','w','markersize',3); 
                        end
                    end                     
                    nonanplot=find(~isnan(LONall));plot(LONall(nonanplot(1)),LATall(nonanplot(1)),'o','markerfacecolor','w','markeredgecolor','k','markersize',6);set(gca,'plotboxaspectratio',[1 1 1])
                    set(gcf, 'InvertHardcopy', 'off')             
                    set(gca,'fontsize',20)
                    box on
                    set(gcf,'Units','inches');
                    a1Pos = get(gca,'Position');
                    set(gcf, 'InvertHardcopy', 'off')
                    set(gcf,'Units','inches');
                    screenposition = get(gcf,'Position');
                    set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                    set(gcf, 'InvertHardcopy', 'off')
                    text(0,1.065,['\textbf{Track \& Classification}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                    text(0,1.03,['\textbf{DATES: ',DATEall(1,:),'$\mathbf{-}$',DATEall(end,:),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                    text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-5),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                    ax=gca;
                    box on
                    set(ax, 'Layer', 'bottom')
                    ax.LineWidth=1; 
                    ax=gca;
                    box on
                    set(ax, 'Layer', 'top')
                    ax.LineWidth=1; 
                    %l(1)=plot(-200,-100,'o','markerfacecolor','w','markeredgecolor','k','markersize',8); 
                    l(1)=plot(-200,-100,'.','color',[.5 .5 .5],'markersize',25); 
                    l(2)=plot(-200,-100,'s','markerfacecolor',[.5 .5 .5],'markeredgecolor',[.5 .5 .5],'markersize',8); 
                    l(3)=plot(-200,-100,'d','markerfacecolor',[.5 .5 .5],'markeredgecolor',[.5 .5 .5],'markersize',6); 
                    l(4)=plot(-200,-100,'.','color',azavcm(2,:),'markersize',25);
                    l(5)=plot(-200,-100,'.','color',azavcm(3,:),'markersize',25);
                    l(6)=plot(-200,-100,'.','color',azavcm(4,:),'markersize',25);
                    l(7)=plot(-200,-100,'.','color',azavcm(5,:),'markersize',25);
                    l(8)=plot(-200,-100,'.','color',azavcm(6,:),'markersize',25);
                    l(9)=plot(-200,-100,'.','color',azavcm(7,:),'markersize',25);
                    l(10)=plot(-200,-100,'.','color','m','markersize',25);
                    legend off
                    lh=legend(l,'WV/DB/LO','SD/SS','EX','TD','TS','C1','C2','C3','C4','C5','orientation','vertical');
                    lh.FontSize=10;     
                    set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
                    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                    axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);;
					filename=[identtrackint,'/',identn,'_track'];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                end
                %% %%%%%%%%%%%%%%%%%%%% %%
                %% Plot Conventonal Obs %% 
                %% %%%%%%%%%%%%%%%%%%%% %%
				run runverif_convsing
                %% %%%%%%%%%%%%%%%%%% %%
                %% Plot Satellite Obs %% 
                %% %%%%%%%%%%%%%%%%%% %%
                run runverif_satsing
				%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
                %% By Cycle (Individual & All) and By Forecast Hour (Errors, EDiffs, Imprv) %%
                %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
                run runverif_statsing
				clearvars -except identboxhist identconmetric identeps identmodelfhr identincludeobs identconvobs identserialcorr identbasinmodel identsatobs identgraphicssat identsatid identsatname identindivch identchannel identindivstorm identcomposite identstormsdone identconvobssubtype identconvobscolors identconvobslegend identns* identnewsub identgraphicsconv identgraphicsbycycle identconvid  stormsdone identremovename yearsdone identdiff identremoveex identremoveinv identcycles identmaxfhr identlevels identexp identexpshort identexpsigimp identexpsigimpshort identexpcolors identscrub identgroot identout identconv
            end
        end
    end      
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
    %% This script sets up your composite case. %%
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
    if identcomposite==1
        if identcompositeprep==1
			identfold='';
			for i=1:size(identexp,1)
				tmp=identexpshort{i};
				if i==size(identexp,1)
					identfold=strcat(identfold,tmp,'/');
				else
					identfold=strcat(identfold,tmp,'_');
				end
			end; if identremoveland==1;identfold=[identfold(1:end-1),'_noland/'];end;if identeps==1;identfold=[identfold(1:end-1),'_eps/'];else;identfold=[identfold(1:end-1),'_png/'];end;
			
			%% Model outputs at 3 h, but to compare errors to BT make 6 h!
			skip=2;                                                    % 6 h res | skip=1 is 3 h
			skiphr=6;                                                  % 6 h res | skiphr=3 is 3 h res
			skiptick=2; if identmaxfhr*3>129; skiptick=4; end;         % 6 h res | skiptick=4 is 3 h res
			skipfct=4;                                                 % 6 h res | skipfct=4 is still 3 h res

			%% Add paths to scripts
			addpath('scripts')

			%% Get the storms that are part of the experiment
			identdr5=dir([identout,'RESULTS/',identfold,'/VERIFICATION/',identremovename,'/*']);
			identdr5=unique({identdr5.name});
			identdr5=identdr5(3:end);
			save('compsave1.mat')
			
			%% Create output file for shell script
			fid = fopen('compverif.txt','wt');
			fprintf(fid,'%s\n',['initbasins="',num2str(1:size(identdr5,2)),'"']);
			fclose(fid);	
			
			%% Get the stratifications for each basin independently and create output file for shell script.
			for basinloop=1:size(identdr5,2) 
					identdr=dir([identout,'RESULTS/',identfold,'VERIFICATION/',identremovename,'/',identdr5{basinloop},'/*']);
					dirFlags = [identdr.isdir];
					identdr = identdr(dirFlags);
					identdr=unique({identdr.name});
					identdr=identdr(3:end);
					% Deal with storms that aren't finished or incomplete
					cnt=1;identbtyear=[];clear tmprm;
					for i=1:size(identdr,2)    
						if isfile([identout,'RESULTS/',identfold,'/','VERIFICATION/',identremovename,'/',identdr5{basinloop},'/',identdr{i},'/',identdr{i},'_errors.mat'])==0
							tmprm(cnt)=i;
							cnt=cnt+1;
						end
					end
					if exist('tmprm','var')==1
						identdr(tmprm)=[];
					end
					for i=1:size(identdr,2)    
						tmpidentdr=identdr{i};
						identbtyear(i)=str2num(tmpidentdr(end-1:end));
					end
					identbtyear=identbtyear';
					if identconv==1 || identsatobs==1
						stratlist=[1:14,894,100:108];
					else
						stratlist=[1,4:14,894,100:102];
					end
					stratlist=[stratlist,15:15+size(unique(identbtyear),1)-1];
					if identconv==1 || identsatobs==1 % stratify stratifications by dropsonde cycles
						stratlist=[stratlist stratlist(end)+1:stratlist(end)+6]; % TD TS MN MJ N30 S30
						stratlist=[stratlist, stratlist(end)+1:stratlist(end)+size(unique(identbtyear),1)]; % add years
						if identbasinmodel==0
							stratlist=[stratlist, stratlist(end)+1:stratlist(end)+2,stratlist(end)+13:stratlist(end)+18+size(unique(identbtyear),1)];
						else
							stratlist=[stratlist, stratlist(end)+1:stratlist(end)+12+6+size(unique(identbtyear),1)++size(unique(identbtyear),1)+size(unique(identbtyear),1)+size(unique(identbtyear),1)+size(unique(identbtyear),1)+size(unique(identbtyear),1)];
						end
					else
					end                  
					if identns==1;stratlist=[stratlist 888 889];end;
					if identenkfexact==1 | identenkfoper==1;stratlist=[stratlist 890 891];if identconv==1 || identsatobs==1;stratlist=[stratlist 892 893];end;end;

					for i=1:size(stratlist,2)
						if i<=10;
							identstratlist1(i)=stratlist(i);														
						elseif i>10 & i<=20
							identstratlist2(i-10)=stratlist(i);
						elseif i>20 & i<=30
							identstratlist3(i-20)=stratlist(i);
						elseif i>30 & i<=40
							identstratlist4(i-30)=stratlist(i);	
						elseif i>40 & i<=50
							identstratlist5(i-40)=stratlist(i);elseif i>50 & i<=60;identstratlist6(i-50)=stratlist(i);elseif i>60 & i<=70;identstratlist7(i-60)=stratlist(i);elseif i>70 & i<=80;identstratlist8(i-70)=stratlist(i);elseif i>80 & i<=1000;identstratlist9(i-80)=stratlist(i);
						end
					end
					cnt=0;
					for i=1:size(stratlist,2)
						if i==1
							cnt=cnt+1;
						elseif i==11
							cnt=cnt+1;
						elseif i==21
							cnt=cnt+1;
						elseif i==31
							cnt=cnt+1;
						elseif i==41
							cnt=cnt+1;elseif i==51;cnt=cnt+1;elseif i==61;cnt=cnt+1;elseif i==71;cnt=cnt+1;elseif i==81;cnt=cnt+1;
						end
					end
					fid = fopen(['stratverif_',num2str(basinloop),'.txt'],'wt');
					fprintf(fid,'%s\n',['initstrat="',num2str(1:cnt),'"']);
					if exist('identstratlist1','var')==1	
						fprintf(fid,'%s\n',['initstrat1="[',num2str(identstratlist1),']"']);
					end
					if exist('identstratlist2','var')==1	
						fprintf(fid,'%s\n',['initstrat2="[',num2str(identstratlist2),']"']);
					end
					if exist('identstratlist3','var')==1	
						fprintf(fid,'%s\n',['initstrat3="[',num2str(identstratlist3),']"']);
					end
					if exist('identstratlist4','var')==1	
						fprintf(fid,'%s\n',['initstrat4="[',num2str(identstratlist4),']"']);
					end
					if exist('identstratlist5','var')==1	
						fprintf(fid,'%s\n',['initstrat5="[',num2str(identstratlist5),']"']);
					end; if exist('identstratlist6','var')==1;fprintf(fid,'%s\n',['initstrat6="[',num2str(identstratlist6),']"']);end;if exist('identstratlist7','var')==1;fprintf(fid,'%s\n',['initstrat7="[',num2str(identstratlist7),']"']);end;if exist('identstratlist8','var')==1;fprintf(fid,'%s\n',['initstrat8="[',num2str(identstratlist8),']"']);end;if exist('identstratlist9','var')==1;fprintf(fid,'%s\n',['initstrat9="[',num2str(identstratlist9),']"']);end;
					fclose(fid);
					clear identbtyear identstratlist*
			end			
		end
		if identcompositerun==1
			load('compsave1.mat')
			if size(stormsdone,2)>1 && strcmp(identdr5{1},'AL')==1 || strcmp(identdr5{1},'EP')==1 || strcmp(identdr5{1},'CP')==1 || strcmp(identdr5{1},'WP')==1 || strcmp(identdr5{1},'IO')==1 || strcmp(identdr5{1},'SH')==1 
				%% To deal with multiple basins, if present
				identbasincut(1)=1;
				for basinloop=1:size(identdr5,2) 
					identdr=dir([identout,'RESULTS/',identfold,'VERIFICATION/',identremovename,'/',identdr5{basinloop},'/*']);
					dirFlags = [identdr.isdir];
					identdr = identdr(dirFlags);
					identdr=unique({identdr.name});
					identdr=identdr(3:end);
					% Deal with storms that aren't finished or incomplete
					cnt=1;clear tmprm;
					for i=1:size(identdr,2)    
						if isfile([identout,'RESULTS/',identfold,'/','VERIFICATION/',identremovename,'/',identdr5{basinloop},'/',identdr{i},'/',identdr{i},'_errors.mat'])==0
							tmprm(cnt)=i;
							cnt=cnt+1;
						end
					end
					if exist('tmprm','var')==1
						identdr(tmprm)=[];
					end
					if isempty(identdr)==1
						disp(['NHC verification was not able to be applied for storms in BASIN: ',identdr5{basinloop},'...so no composite graphics for this basin are generated!'])
					else
						if basinloop==1
							% Initialize arrays
							BT_name_all     =   {};
							BT_target_all   =   [];
							BT_drops_all    =   [];BT_enkf_all=[];BT_hfip_all=[];
							BT_year_all    =   [];
							BT_date_all     =   [];
							BT_storm_all    =   [];
							BT_lat_all      =   [];
							BT_lon_all      =   [];
							BT_maxspd_all   =	[];
							BT_pres_all      =   [];                           
							BT_rmw_all=[];                                                        
							BT_intch_all=[];                                                        
							BT_shr_all=[];                                                        
							BT_po_all=[];                                                        
							BT_ro_all=[];                                                        
							BT_ne34_all=[];                                                        
							BT_se34_all=[];                                                        
							BT_nw34_all=[];                                                        
							BT_sw34_all=[];                                                        
							BT_ne50_all=[];                                                        
							BT_se50_all=[];                                                        
							BT_nw50_all=[];                                                        
							BT_sw50_all=[];
							BT_ne64_all=[];                                                        
							BT_se64_all=[];                                                        
							BT_nw64_all=[];                                                        
							BT_sw64_all=[];
							EXP_lat_all      =   [];
							EXP_lon_all      =   [];
							EXP_maxspd_all   =	[];
							EXP_pres_all      =   [];                           
							EXP_rmw_all=[];                                                        
							EXP_intch_all=[];                                                        
							EXP_shr_all=[];                                                        
							EXP_po_all=[];                                                        
							EXP_ro_all=[];                                                        
							EXP_ne34_all=[];                                                        
							EXP_se34_all=[];                                                        
							EXP_nw34_all=[];                                                        
							EXP_sw34_all=[];                                                        
							EXP_ne50_all=[];                                                        
							EXP_se50_all=[];                                                        
							EXP_nw50_all=[];                                                        
							EXP_sw50_all=[];
							EXP_ne64_all=[];                                                        
							EXP_se64_all=[];                                                        
							EXP_nw64_all=[];                                                        
							EXP_sw64_all=[];
							interr_exp_all	=	[];
							ne34err_exp_all	=	[];
							ne50err_exp_all	=	[];
							ne64err_exp_all	=	[];
							nw34err_exp_all	=	[];
							nw50err_exp_all	=	[];
							nw64err_exp_all	=	[];
							poerr_exp_all	=	[];
							rmwerr_exp_all	=	[];
							roerr_exp_all	=	[];
							se34err_exp_all	=	[];
							se50err_exp_all	=	[];
							se64err_exp_all	=	[];
							spderr_exp_all	=	[];
							sw34err_exp_all	=	[];
							sw50err_exp_all	=	[];
							sw64err_exp_all	=	[];
							trkerr_exp_all	=	[];
							ateerr_exp_all	=	[];
							xteerr_exp_all	=	[];
							interr_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							ne34err_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							ne50err_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							ne64err_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							nw34err_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							nw50err_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							nw64err_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							poerr_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							rmwerr_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							roerr_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							se34err_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							se50err_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							se64err_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							spderr_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							sw34err_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							sw50err_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							sw64err_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							trkerr_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							ateerr_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							xteerr_exp_stm = nan(1000,identmodelfhr,size(identexp,1),size(identdr,2));
							cntcan=1;
							cntst=1;
						end
						% Concatenate all storms together
						for i=1:size(identdr,2)    
							if isfile([identout,'RESULTS/',identfold,'/','VERIFICATION/',identremovename,'/',identdr5{basinloop},'/',identdr{i},'/',identdr{i},'_errors.mat'])==1   
								load([identout,'RESULTS/',identfold,'/','VERIFICATION/',identremovename,'/',identdr5{basinloop},'/',identdr{i},'/',identdr{i},'_errors.mat'])
								load([identout,'RESULTS/',identfold,'/','VERIFICATION/',identremovename,'/',identdr5{basinloop},'/',identdr{i},'/',identdr{i},'_latlon.mat'])        
								load([identout,'RESULTS/',identfold,'/','VERIFICATION/',identremovename,'/',identdr5{basinloop},'/',identdr{i},'/',identdr{i},'_data.mat'],'LOWbasin','HIGHbasin')        
								BT_drops_all=cat(2,BT_drops_all,BT_drops);BT_hfip_all=cat(1,BT_hfip_all,BT_hfip);if identenkfexact==1 | identenkfoper==1;BT_enkf_all=cat(2,BT_enkf_all,BT_enkf);end;  % only cycles that had conventional obs   
								btd=find(BT_drops==1);
								if isempty(btd)==1 && identconv==1 % if the storm has conventional obs...           
									keepstm(cntst)=NaN;
									cntst=cntst+1;
								elseif isempty(btd)==1 && identconv==0 % if conventional obs are turned off...
									keepstm(cntst)=i;
									cntst=cntst+1;
								else
									BT_drops(btd(1):end)=1; % from first time conventional obs detected in storm through end of storm
									[identdr{i},' ',num2str(sum(BT_drops(isnan(BT_lat(:,1))==0)))];
									keepstm(cntst)=i; % save storm index since it has conventional obs
									cntst=cntst+1;
								end
								tmpyr=identdr{i};
								for nmal=1:size(BT_lat,1)
									BT_name_all=cat(2,BT_name_all,tmpyr);
								end
								BT_date_all=cat(1,BT_date_all,identinittimesunique);
								BT_year_all=cat(1,BT_year_all,repmat(str2num(tmpyr(end-1:end)),size(BT_lat)));
								BT_storm_all=cat(1,BT_storm_all,repmat(i,size(BT_lat)));
								BT_target_all=cat(2,BT_target_all,BT_drops);        
								BT_maxspd_all=cat(1,BT_maxspd_all,BT_maxspd);
								BT_lat_all=cat(1,BT_lat_all,BT_lat);
								BT_lon_all=cat(1,BT_lon_all,BT_lon);
								BT_pres_all=cat(1,BT_pres_all,BT_minpres);                            
								BT_rmw_all=cat(1,BT_rmw_all,BT_rmw);                                                        
								BT_intch_all=cat(1,BT_intch_all,BT_intch);                                                        
								BT_shr_all=cat(1,BT_shr_all,BT_shr);                                                        
								BT_po_all=cat(1,BT_po_all,BT_po);                                                        
								BT_ro_all=cat(1,BT_ro_all,BT_ro);                                                        
								BT_ne34_all=cat(1,BT_ne34_all,BT_ne34);                                                        
								BT_se34_all=cat(1,BT_se34_all,BT_se34);                                                        
								BT_nw34_all=cat(1,BT_nw34_all,BT_nw34);                                                        
								BT_sw34_all=cat(1,BT_sw34_all,BT_sw34);                                                        
								BT_ne50_all=cat(1,BT_ne50_all,BT_ne50);                                                        
								BT_se50_all=cat(1,BT_se50_all,BT_se50);                                                        
								BT_nw50_all=cat(1,BT_nw50_all,BT_nw50);                                                        
								BT_sw50_all=cat(1,BT_sw50_all,BT_sw50);
								BT_ne64_all=cat(1,BT_ne64_all,BT_ne64);                                                        
								BT_se64_all=cat(1,BT_se64_all,BT_se64);                                                        
								BT_nw64_all=cat(1,BT_nw64_all,BT_nw64);                                                        
								BT_sw64_all=cat(1,BT_sw64_all,BT_sw64);
								EXP_maxspd_all=cat(1,EXP_maxspd_all,EXP_maxspd);
								EXP_lat_all=cat(1,EXP_lat_all,EXP_lat);
								EXP_lon_all=cat(1,EXP_lon_all,EXP_lon);
								EXP_pres_all=cat(1,EXP_pres_all,EXP_minpres);                            
								EXP_rmw_all=cat(1,EXP_rmw_all,EXP_rmw);                                                        
								EXP_intch_all=cat(1,EXP_intch_all,EXP_intch);                                                        
								EXP_shr_all=cat(1,EXP_shr_all,EXP_shr);                                                        
								EXP_po_all=cat(1,EXP_po_all,EXP_po);                                                        
								EXP_ro_all=cat(1,EXP_ro_all,EXP_ro);                                                        
								EXP_ne34_all=cat(1,EXP_ne34_all,EXP_ne34);                                                        
								EXP_se34_all=cat(1,EXP_se34_all,EXP_se34);                                                        
								EXP_nw34_all=cat(1,EXP_nw34_all,EXP_nw34);                                                        
								EXP_sw34_all=cat(1,EXP_sw34_all,EXP_sw34);                                                        
								EXP_ne50_all=cat(1,EXP_ne50_all,EXP_ne50);                                                        
								EXP_se50_all=cat(1,EXP_se50_all,EXP_se50);                                                        
								EXP_nw50_all=cat(1,EXP_nw50_all,EXP_nw50);                                                        
								EXP_sw50_all=cat(1,EXP_sw50_all,EXP_sw50);
								EXP_ne64_all=cat(1,EXP_ne64_all,EXP_ne64);                                                        
								EXP_se64_all=cat(1,EXP_se64_all,EXP_se64);                                                        
								EXP_nw64_all=cat(1,EXP_nw64_all,EXP_nw64);                                                        
								EXP_sw64_all=cat(1,EXP_sw64_all,EXP_sw64);
								interr_exp_all=cat(1,interr_exp_all,interr_exp);
								ne34err_exp_all=cat(1,ne34err_exp_all,ne34err_exp);
								ne50err_exp_all=cat(1,ne50err_exp_all,ne50err_exp);
								ne64err_exp_all=cat(1,ne64err_exp_all,ne64err_exp);
								nw34err_exp_all=cat(1,nw34err_exp_all,nw34err_exp);
								nw50err_exp_all=cat(1,nw50err_exp_all,nw50err_exp);
								nw64err_exp_all=cat(1,nw64err_exp_all,nw64err_exp);
								poerr_exp_all=cat(1,poerr_exp_all,poerr_exp);
								rmwerr_exp_all=cat(1,rmwerr_exp_all,rmwerr_exp);
								roerr_exp_all=cat(1,roerr_exp_all,roerr_exp);
								se34err_exp_all=cat(1,se34err_exp_all,se34err_exp);
								se50err_exp_all=cat(1,se50err_exp_all,se50err_exp);
								se64err_exp_all=cat(1,se64err_exp_all,se64err_exp);
								spderr_exp_all=cat(1,spderr_exp_all,spderr_exp);
								sw34err_exp_all=cat(1,sw34err_exp_all,sw34err_exp);
								sw50err_exp_all=cat(1,sw50err_exp_all,sw50err_exp);
								sw64err_exp_all=cat(1,sw64err_exp_all,sw64err_exp);
								trkerr_exp_all=cat(1,trkerr_exp_all,trkerr_exp);
								xteerr_exp_all=cat(1,xteerr_exp_all,xteerr_exp);
								ateerr_exp_all=cat(1,ateerr_exp_all,ateerr_exp);      
								interr_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(interr_exp));
								ne34err_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(ne34err_exp));
								ne50err_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(ne50err_exp));
								ne64err_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(ne64err_exp));
								nw34err_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(nw34err_exp));
								nw50err_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(nw50err_exp));
								nw64err_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(nw64err_exp));
								poerr_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(poerr_exp));
								rmwerr_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(rmwerr_exp));
								roerr_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(roerr_exp));
								se34err_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(se34err_exp));
								se50err_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(se50err_exp));
								se64err_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(se64err_exp));
								spderr_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(spderr_exp));
								sw34err_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(sw34err_exp));
								sw50err_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(sw50err_exp));
								sw64err_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(sw64err_exp));
								trkerr_exp_stm(1:size(interr_exp,1),:,:,cntcan)=(abs(trkerr_exp));
								xteerr_exp_stm(1:size(interr_exp,1),:,:,cntcan)=((xteerr_exp));
								ateerr_exp_stm(1:size(interr_exp,1),:,:,cntcan)=((ateerr_exp));
								cntcan=cntcan+1;
							end

						end
					end
					identbasincut(basinloop+1)=size(trkerr_exp_all,1)+1;
				end
				% Reassign variables for easy plotting
				BT_date=BT_date_all;
				BT_name=BT_name_all;
				BT_drops=BT_drops_all;BT_hfip=BT_hfip_all;if identenkfexact==1 | identenkfoper==1;BT_enkf=BT_enkf_all;end;
				BT_target=BT_target_all;
				BT_year=BT_year_all;
				BT_storm=BT_storm_all;
				BT_lat=BT_lat_all;
				BT_lon=BT_lon_all;
				BT_cat=BT_maxspd_all;
				BT_pres=BT_pres_all;                    
				BT_rmw=BT_rmw_all;                                                        
				BT_intch=BT_intch_all;                                                        
				BT_shr=BT_shr_all;                                                        
				BT_po=BT_po_all;                                                        
				BT_ro=BT_ro_all;                                                        
				BT_ne34=BT_ne34_all;                                                        
				BT_se34=BT_se34_all;                                                        
				BT_nw34=BT_nw34_all;                                                        
				BT_sw34=BT_sw34_all;                                                        
				BT_ne50=BT_ne50_all;                                                        
				BT_se50=BT_se50_all;                                                        
				BT_nw50=BT_nw50_all;                                                        
				BT_sw50=BT_sw50_all;
				BT_ne64=BT_ne64_all;                                                        
				BT_se64=BT_se64_all;                                                        
				BT_nw64=BT_nw64_all;                                                        
				BT_sw64=BT_sw64_all; 
				EXP_lat=EXP_lat_all;
				EXP_lon=EXP_lon_all;
				EXP_cat=EXP_maxspd_all;
				EXP_pres=EXP_pres_all;                    
				EXP_rmw=EXP_rmw_all;                                                        
				EXP_intch=EXP_intch_all;                                                        
				EXP_shr=EXP_shr_all;                                                        
				EXP_po=EXP_po_all;                                                        
				EXP_ro=EXP_ro_all;                                                        
				EXP_ne34=EXP_ne34_all;                                                        
				EXP_se34=EXP_se34_all;                                                        
				EXP_nw34=EXP_nw34_all;                                                        
				EXP_sw34=EXP_sw34_all;                                                        
				EXP_ne50=EXP_ne50_all;                                                        
				EXP_se50=EXP_se50_all;                                                        
				EXP_nw50=EXP_nw50_all;                                                        
				EXP_sw50=EXP_sw50_all;
				EXP_ne64=EXP_ne64_all;                                                        
				EXP_se64=EXP_se64_all;                                                        
				EXP_nw64=EXP_nw64_all;                                                        
				EXP_sw64=EXP_sw64_all;                     
				interr_exp=interr_exp_all;
				ne34err_exp=ne34err_exp_all;
				ne50err_exp=ne50err_exp_all;
				ne64err_exp=ne64err_exp_all;
				nw34err_exp=nw34err_exp_all;
				nw50err_exp=nw50err_exp_all;
				nw64err_exp=nw64err_exp_all;
				poerr_exp=poerr_exp_all;
				rmwerr_exp=rmwerr_exp_all;
				roerr_exp=roerr_exp_all;
				se34err_exp=se34err_exp_all;
				se50err_exp=se50err_exp_all;
				se64err_exp=se64err_exp_all;
				spderr_exp=spderr_exp_all;
				sw34err_exp=sw34err_exp_all;
				sw50err_exp=sw50err_exp_all;
				sw64err_exp=sw64err_exp_all;
				trkerr_exp=trkerr_exp_all;
				ateerr_exp=ateerr_exp_all;
				xteerr_exp=xteerr_exp_all;
				clear *all
				% Basin Values for Subsets
				BT_dropsB=BT_drops;                   
				for i=1:size(BT_drops,2)
					if BT_drops(i)==1
						tmpdate=BT_date(i,:);
						tmpdatematch=find(str2num(BT_date)==str2num(tmpdate));
						BT_dropsB(tmpdatematch)=1;
					end
				end
				% Basin Values for Subsets
				BT_dropsI=zeros(1,size(BT_drops,2));
				BT_dropsT=zeros(1,size(BT_drops,2));
				for i=1:size(BT_drops,2)
					if BT_drops(i)==1
						tmpdate=BT_date(i,:);
						tmpdatematch=find(str2num(BT_date)==str2num(tmpdate));                           
							if sum(BT_drops(tmpdatematch))>1
								BT_dropsT(tmpdatematch(BT_drops(tmpdatematch)==1))=1;
							elseif sum(BT_drops(tmpdatematch))==1
								BT_dropsI(i)=1;
							end
					end
				end
				% Basin Values for Subsets
				BT_targetI=zeros(1,size(BT_target,2));
				BT_targetT=zeros(1,size(BT_target,2));
				for i=1:size(BT_target,2)
					if BT_target(i)==1
						tmpdate=BT_date(i,:);
						tmpdatematch=find(str2num(BT_date)==str2num(tmpdate));                           
							if sum(BT_target(tmpdatematch))>1
								BT_targetT(tmpdatematch(BT_target(tmpdatematch)==1))=1;
							elseif sum(BT_target(tmpdatematch))==1
								BT_targetI(i)=1;
							end
					end
				end
				BT_targetB=BT_target;
				for i=1:size(BT_target,2)
					if BT_target(i)==1
						tmpdate=BT_date(i,:);
						tmpdatematch=find(str2num(BT_date)==str2num(tmpdate));
						BT_targetB(tmpdatematch)=1;
					end
				end
				% Arrange plots the same
				spPos=[0.11 0.13+.05 0.75 0.75-.05]; % arrange plots the same
				% Keepstm
				keepstm(isnan(keepstm)==1)=[];
				BT_cat=BT_cat(:,1);
				BT_intch=BT_intch(:,1);
				BT_shr=BT_shr(:,1);
				BT_lat=BT_lat(:,1);
				BT_year=BT_year(:,1);
				BT_storm=BT_storm(:,1);            
				% Create Graphics: trk, int, spd errors - bt-gh vs. bt-deny
				for plt=[1:23]                                   
					if plt==1
						 tmp_exp=trkerr_exp(:,1:skip:end,:);
						 tmp_name='trkerr';
						 tmp_title='Track Error (km)';
						 tmp_ytitle='Error (km)';
					elseif plt==2
						tmp_exp=interr_exp(:,1:skip:end,:);
						tmp_name='prserr';
						tmp_title='PMIN Error (hPa)';
						tmp_ytitle='Error (hPa)';
					elseif plt==3
						tmp_exp=spderr_exp(:,1:skip:end,:);
						tmp_name='spderr';
						tmp_title='VMAX Error (m/s)';
						tmp_ytitle='Error (m/s)';
					 elseif plt==4
						tmp_exp=ne34err_exp(:,1:skip:end,:);
						tmp_name='neR34err';
						tmp_title='R34 NEQ Error (km)';
						tmp_ytitle='Error (km)';
						yrange=[0 200];
					elseif plt==5
						tmp_exp=se34err_exp(:,1:skip:end,:);
						tmp_name='seR34err';
						tmp_title='R34 SEQ Error (km)';
						tmp_ytitle='Error (km)';
						yrange=[0 200];
					elseif plt==6
						tmp_exp=sw34err_exp(:,1:skip:end,:);
						tmp_name='swR34err';
						tmp_title='R34 SWQ Error (km)';
						tmp_ytitle='Error (km)';
						yrange=[0 200];
					elseif plt==7
						tmp_exp=nw34err_exp(:,1:skip:end,:);
						tmp_name='nwR34err';
						tmp_title='R34 NWQ Error (km)';
						tmp_ytitle='Error (km)';
						yrange=[0 200];
					elseif plt==8
						tmp_exp=ne50err_exp(:,1:skip:end,:);
						tmp_name='neR50err';
						tmp_title='R50 NEQ Error (km)';
						tmp_ytitle='Error (km)';
						yrange=[0 200];
					elseif plt==9
						tmp_exp=se50err_exp(:,1:skip:end,:);
						tmp_name='seR50err';
						tmp_title='R50 SEQ Error (km)';
						tmp_ytitle='Error (km)';
						yrange=[0 200];
					elseif plt==10
						tmp_exp=sw50err_exp(:,1:skip:end,:);
						tmp_name='swR50err';
						tmp_title='R50 SWQ Error (km)';
						tmp_ytitle='Error (km)';
						yrange=[0 200];
					elseif plt==11
						tmp_exp=nw50err_exp(:,1:skip:end,:);
						tmp_name='nwR50err';
						tmp_title='R50 NWQ Error (km)';
						tmp_ytitle='Error (km)';
						yrange=[0 200];
					elseif plt==12
						tmp_exp=ne64err_exp(:,1:skip:end,:);
						tmp_name='neR64err';
						tmp_title='R64 NEQ Error (km)';
						tmp_ytitle='Error (km)';
						yrange=[0 200];
					elseif plt==13
						tmp_exp=se64err_exp(:,1:skip:end,:);
						tmp_name='seR64err';
						tmp_title='R64 SEQ Error (km)';
						tmp_ytitle='Error (km)';
						yrange=[0 200];
					elseif plt==14
						tmp_exp=sw64err_exp(:,1:skip:end,:);
						tmp_name='swR64err';
						tmp_title='R64 SWQ Error (km)';
						tmp_ytitle='Error (km)';
						yrange=[0 200];
					elseif plt==15
						tmp_exp=nw64err_exp(:,1:skip:end,:);
						tmp_name='nwR64err';
						tmp_title='R64 NWQ Error (km)';
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
						tmp_name='R34err';
						tmp_title='R34 Error (km)';
						tmp_ytitle='Error (km)';
						yrange=[0 100];
					elseif plt==22
						tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
						tmp_name='R50err';
						tmp_title='R50 Error (km)';
						tmp_ytitle='Error (km)';
						yrange=[0 100];
					elseif plt==23
						tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
						tmp_name='R64err';
						tmp_title='R64 Error (km)';
						tmp_ytitle='Error (km)';
						yrange=[0 100];
					end
					if plt <19 || plt >20
						tmp_exp=abs(tmp_exp); % added for MAE
					end
					tmp_exp0=tmp_exp(:,1:(identmaxfhr+1)/2,:);

					% YRANGE
					clear allquad
					allquad(1)=(max(max(nanmean(abs(ne34err_exp(:,1:skip:identmaxfhr,:)),1))));
					allquad(2)=(max(max(nanmean(abs(se34err_exp(:,1:skip:identmaxfhr,:)),1))));
					allquad(3)=(max(max(nanmean(abs(nw34err_exp(:,1:skip:identmaxfhr,:)),1))));
					allquad(4)=(max(max(nanmean(abs(sw34err_exp(:,1:skip:identmaxfhr,:)),1))));
					allquad(5)=(max(max(nanmean(abs(ne50err_exp(:,1:skip:identmaxfhr,:)),1))));
					allquad(6)=(max(max(nanmean(abs(se50err_exp(:,1:skip:identmaxfhr,:)),1))));
					allquad(7)=(max(max(nanmean(abs(nw50err_exp(:,1:skip:identmaxfhr,:)),1))));
					allquad(8)=(max(max(nanmean(abs(sw50err_exp(:,1:skip:identmaxfhr,:)),1))));
					allquad(9)=(max(max(nanmean(abs(ne64err_exp(:,1:skip:identmaxfhr,:)),1))));
					allquad(10)=(max(max(nanmean(abs(se64err_exp(:,1:skip:identmaxfhr,:)),1))));
					allquad(11)=(max(max(nanmean(abs(nw64err_exp(:,1:skip:identmaxfhr,:)),1))));
					allquad(12)=(max(max(nanmean(abs(sw64err_exp(:,1:skip:identmaxfhr,:)),1))));
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
					errylim(plt,:)=yrange;
				end   
				% Create Graphics: trk, int, spd Skill vs. deny
				for plt=[1:23]                                    
					if plt==1
						 tmp_exp=trkerr_exp(:,1:skip:end,:);
						 tmp_name='trkskill';
						 tmp_title='Track Skill (\%)';
						 tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
						 yrange=[-20 20];
					elseif plt==2
						tmp_exp=interr_exp(:,1:skip:end,:);
						tmp_name='prskill';
						tmp_title='PMIN Skill (\%)';
						tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
					elseif plt==3
						tmp_exp=spderr_exp(:,1:skip:end,:);
						tmp_name='spdskill';
						tmp_title='VMAX Skill (\%)';
						tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
					 elseif plt==4
						tmp_exp=ne34err_exp(:,1:skip:end,:);
						tmp_name='neR34skill';
						tmp_title='R34 NEQ Skill (\%)';
						tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
						yrange=[-100 100];                 
					elseif plt==5
						tmp_exp=se34err_exp(:,1:skip:end,:);
						tmp_name='seR34skill';
						tmp_title='R34 SEQ Skill (\%)';
						tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
						yrange=[-100 100];                 
					elseif plt==6
						tmp_exp=sw34err_exp(:,1:skip:end,:);
						tmp_name='swR34skill';
						tmp_title='R34 SWQ Skill (\%)';
						tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
						yrange=[-100 100];                 
					elseif plt==7
						tmp_exp=nw34err_exp(:,1:skip:end,:);
						tmp_name='nwR34skill';
						tmp_title='R34 NWQ Skill (\%)';
						tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
						yrange=[-100 100];                 
					elseif plt==8
						tmp_exp=ne50err_exp(:,1:skip:end,:);
						tmp_name='neR50skill';
						tmp_title='R50 NEQ Skill (\%)';
						tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
						yrange=[-100 100];                 
					elseif plt==9
						tmp_exp=se50err_exp(:,1:skip:end,:);
						tmp_name='seR50skill';
						tmp_title='R50 SEQ Skill (\%)';
						tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
						yrange=[-100 100];                 
					elseif plt==10
						tmp_exp=sw50err_exp(:,1:skip:end,:);
						tmp_name='swR50skill';
						tmp_title='R50 SWQ Skill (\%)';
						tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
						yrange=[-100 100];                 
					elseif plt==11
						tmp_exp=nw50err_exp(:,1:skip:end,:);
						tmp_name='nwR50skill';
						tmp_title='R50 NWQ Skill (\%)';
						tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
						yrange=[-100 100];                 
					elseif plt==12
						tmp_exp=ne64err_exp(:,1:skip:end,:);
						tmp_name='neR64skill';
						tmp_title='R64 NEQ Skill (\%)';
						tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
						yrange=[-100 100];                 
					elseif plt==13
						tmp_exp=se64err_exp(:,1:skip:end,:);
						tmp_name='seR64skill';
						tmp_title='R64 SEQ Skill (\%)';
						tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
						yrange=[-100 100];                 
					elseif plt==14
						tmp_exp=sw64err_exp(:,1:skip:end,:);
						tmp_name='swR64skill';
						tmp_title='R64 SWQ Skill (\%)';
						tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
						yrange=[-100 100];                 
					elseif plt==15
						tmp_exp=nw64err_exp(:,1:skip:end,:);
						tmp_name='nwR64skill';
						tmp_title='R64 NWQ Skill (\%)';
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
						tmp_name='R34skill';
						tmp_title='R34 Skill (\%)';
						tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
						yrange=[-50 50];
					elseif plt==22
						tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
						tmp_name='R50skill';
						tmp_title='R50 Skill (\%)';
						tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
						yrange=[-50 50];
					elseif plt==23
						tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
						tmp_name='R64skill';
						tmp_title='R64 Skill (\%)';
						tmp_ytitle=['Skill wrt ', identexpsigimpshort,' (%)'];
						yrange=[-50 50];
					end
					if plt <19 || plt >20
						tmp_exp=abs(tmp_exp); % added for MAE
					end
						tmp_exp0=tmp_exp(:,1:(identmaxfhr+1)/2,:);                                    

					% Find which experiment to compare to
					for tmp=1:size(identexp,1)
						if strcmp(identexp(tmp),identexpsigimp)
							tmpimp=tmp;
						end
					end      
					tmpu=1:size(identexp,1);
					tmpu(tmpu==tmpimp)=[];                                    
					% YRANGE
						clear allquad imprv3
						imprv3(:,:,1)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:identmaxfhr,:)))./nanmean(abs(ne34err_exp(:,1:skip:identmaxfhr,tmpimp))));
						imprv3(:,:,2)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:identmaxfhr,:)))./nanmean(abs(se34err_exp(:,1:skip:identmaxfhr,tmpimp))));
						imprv3(:,:,3)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:identmaxfhr,:)))./nanmean(abs(nw34err_exp(:,1:skip:identmaxfhr,tmpimp))));
						imprv3(:,:,4)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:identmaxfhr,:)))./nanmean(abs(sw34err_exp(:,1:skip:identmaxfhr,tmpimp))));
						imprv3(:,:,5)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:identmaxfhr,:)))./nanmean(abs(ne34err_exp(:,1:skip:identmaxfhr,tmpimp))));
						imprv3(:,:,6)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:identmaxfhr,:)))./nanmean(abs(se34err_exp(:,1:skip:identmaxfhr,tmpimp))));
						imprv3(:,:,7)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:identmaxfhr,:)))./nanmean(abs(nw34err_exp(:,1:skip:identmaxfhr,tmpimp))));
						imprv3(:,:,8)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:identmaxfhr,:)))./nanmean(abs(sw34err_exp(:,1:skip:identmaxfhr,tmpimp))));
						imprv3(:,:,9)=100.*(1-nanmean(abs(ne34err_exp(:,1:skip:identmaxfhr,:)))./nanmean(abs(ne34err_exp(:,1:skip:identmaxfhr,tmpimp))));
						imprv3(:,:,10)=100.*(1-nanmean(abs(se34err_exp(:,1:skip:identmaxfhr,:)))./nanmean(abs(se34err_exp(:,1:skip:identmaxfhr,tmpimp))));
						imprv3(:,:,11)=100.*(1-nanmean(abs(nw34err_exp(:,1:skip:identmaxfhr,:)))./nanmean(abs(nw34err_exp(:,1:skip:identmaxfhr,tmpimp))));
						imprv3(:,:,12)=100.*(1-nanmean(abs(sw34err_exp(:,1:skip:identmaxfhr,:)))./nanmean(abs(sw34err_exp(:,1:skip:identmaxfhr,tmpimp))));
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
						imprv0=squeeze(100.*(1-nanmean(tmp_exp0(:,:,:),1)./nanmean(tmp_exp0(:,:,tmpimp),1)));                  
						if numel(num2str(round(max(imprv0(:)))))==3
							addfac=100;
						elseif numel(num2str(round(max(imprv0(:)))))==2
							addfac=20;
						else
							addfac=20;
						end
						if plt<=3 || (plt>=16 && plt<=18) % 0-end
							tmpmin=min(imprv0(:));
							tmpmax=max(imprv0(:));
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
							tmpmin=min(imprv0(:));
							tmpmax=max(imprv0(:));
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
						impylim(plt,:)=yrange;                                    
				end
				% Create Graphics: trk, int, spd bias - bt-gh vs. bt-deny
				for plt=[2:18,21:23] % no across or along for bias since already in error                                  
					if plt==1
						 tmp_exp=trkerr_exp(:,1:skip:end,:);
						 tmp_name='trkbias';
						 tmp_title='Track Bias (km)';
						 tmp_ytitle='Bias (km)';
					elseif plt==2
						tmp_exp=interr_exp(:,1:skip:end,:);
						tmp_name='prsbias';
						tmp_title='PMIN Bias (hPa)';
						tmp_ytitle='Bias (hPa)';
					elseif plt==3
						tmp_exp=spderr_exp(:,1:skip:end,:);
						tmp_name='spdbias';
						tmp_title='VMAX Bias (m/s)';
						tmp_ytitle='Bias (m/s)';
					 elseif plt==4
						tmp_exp=ne34err_exp(:,1:skip:end,:);
						tmp_name='neR34bias';
						tmp_title='R34 NEQ Bias (km)';
						tmp_ytitle='Bias (km)';
						yrange=[-200 200];
					elseif plt==5
						tmp_exp=se34err_exp(:,1:skip:end,:);
						tmp_name='seR34bias';
						tmp_title='R34 SEQ Bias (km)';
						tmp_ytitle='Bias (km)';
						yrange=[-200 200];
					elseif plt==6
						tmp_exp=sw34err_exp(:,1:skip:end,:);
						tmp_name='swR34bias';
						tmp_title='R34 SWQ Bias (km)';
						tmp_ytitle='Bias (km)';
						yrange=[-200 200];
					elseif plt==7
						tmp_exp=nw34err_exp(:,1:skip:end,:);
						tmp_name='nwR34bias';
						tmp_title='R34 NWQ Bias (km)';
						tmp_ytitle='Bias (km)';
						yrange=[-200 200];
					elseif plt==8
						tmp_exp=ne50err_exp(:,1:skip:end,:);
						tmp_name='neR50bias';
						tmp_title='R50 NEQ Bias (km)';
						tmp_ytitle='Bias (km)';
						yrange=[-200 200];
					elseif plt==9
						tmp_exp=se50err_exp(:,1:skip:end,:);
						tmp_name='seR50bias';
						tmp_title='R50 SEQ Bias (km)';
						tmp_ytitle='Bias (km)';
						yrange=[-200 200];
					elseif plt==10
						tmp_exp=sw50err_exp(:,1:skip:end,:);
						tmp_name='swR50bias';
						tmp_title='R50 SWQ Bias (km)';
						tmp_ytitle='Bias (km)';
						yrange=[-200 200];
					elseif plt==11
						tmp_exp=nw50err_exp(:,1:skip:end,:);
						tmp_name='nwR50bias';
						tmp_title='R50 NWQ Bias (km)';
						tmp_ytitle='Bias (km)';
						yrange=[-200 200];
					elseif plt==12
						tmp_exp=ne64err_exp(:,1:skip:end,:);
						tmp_name='neR64bias';
						tmp_title='R64 NEQ Bias (km)';
						tmp_ytitle='Bias (km)';
						yrange=[-200 200];
					elseif plt==13
						tmp_exp=se64err_exp(:,1:skip:end,:);
						tmp_name='seR64bias';
						tmp_title='R64 SEQ Bias (km)';
						tmp_ytitle='Bias (km)';
						yrange=[-200 200];
					elseif plt==14
						tmp_exp=sw64err_exp(:,1:skip:end,:);
						tmp_name='swR64bias';
						tmp_title='R64 SWQ Bias (km)';
						tmp_ytitle='Bias (km)';
						yrange=[-200 200];
					elseif plt==15
						tmp_exp=nw64err_exp(:,1:skip:end,:);
						tmp_name='nwR64bias';
						tmp_title='R64 NWQ Bias (km)';
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
						tmp_name='R34bias';
						tmp_title='R34 Bias (km)';
						tmp_ytitle='Bias (km)';
						yrange=[-100 100];
					elseif plt==22
						tmp_exp=cat(1,ne50err_exp(:,1:skip:end,:),nw50err_exp(:,1:skip:end,:),se50err_exp(:,1:skip:end,:),sw50err_exp(:,1:skip:end,:));
						tmp_name='R50bias';
						tmp_title='R50 Bias (km)';
						tmp_ytitle='Bias (km)';
						yrange=[-100 100];
					elseif plt==23
						tmp_exp=cat(1,ne64err_exp(:,1:skip:end,:),nw64err_exp(:,1:skip:end,:),se64err_exp(:,1:skip:end,:),sw64err_exp(:,1:skip:end,:));
						tmp_name='R64bias';
						tmp_title='R64 Bias (km)';
						tmp_ytitle='Bias (km)';
						yrange=[-100 100];
					end
					tmp_exp0=tmp_exp(:,1:(identmaxfhr+1)/2,:);                                                                       
					% YRANGE
					clear allquad
					allquad(1)=(max(max(nanmean(abs(ne34err_exp(:,1:skip:identmaxfhr,:)),1))));
                                        allquad(2)=(max(max(nanmean(abs(se34err_exp(:,1:skip:identmaxfhr,:)),1))));
                                        allquad(3)=(max(max(nanmean(abs(nw34err_exp(:,1:skip:identmaxfhr,:)),1))));
                                        allquad(4)=(max(max(nanmean(abs(sw34err_exp(:,1:skip:identmaxfhr,:)),1))));
                                        allquad(5)=(max(max(nanmean(abs(ne50err_exp(:,1:skip:identmaxfhr,:)),1))));
                                        allquad(6)=(max(max(nanmean(abs(se50err_exp(:,1:skip:identmaxfhr,:)),1))));
                                        allquad(7)=(max(max(nanmean(abs(nw50err_exp(:,1:skip:identmaxfhr,:)),1))));
                                        allquad(8)=(max(max(nanmean(abs(sw50err_exp(:,1:skip:identmaxfhr,:)),1))));
                                        allquad(9)=(max(max(nanmean(abs(ne64err_exp(:,1:skip:identmaxfhr,:)),1))));
                                        allquad(10)=(max(max(nanmean(abs(se64err_exp(:,1:skip:identmaxfhr,:)),1))));
                                        allquad(11)=(max(max(nanmean(abs(nw64err_exp(:,1:skip:identmaxfhr,:)),1))));
                                        allquad(12)=(max(max(nanmean(abs(sw64err_exp(:,1:skip:identmaxfhr,:)),1))));
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
					biasylim(plt,:)=yrange;
				end
				% BT Value vs. EXP Value
				for plt=[2:18,21:23]                                   
						% Mean Value            
						ylabv=[];
						for tmp=1:size(identexpshort,1)
							if tmp==size(identexpshort,1)
								ylabv=[ylabv, 'and ',identexpshort{tmp},' Values'];
							else
								ylabv=[ylabv,identexpshort{tmp},', '];
							end
						end
						if plt==1
							 tmp_exp=squeeze(trkerr_exp(:,1,:));
							 tmp_name='trkval';
							 tmp_title='Track (km)';
							 tmp_ytitle=[ylabv,' (km)'];
							 tmp_u='(km)';
						elseif plt==2
							tmp_exp=squeeze(EXP_pres(:,1,:));
							tmp_bt=squeeze(BT_pres(:,1,:));
							tmp_name='prsval';
							tmp_title='PMIN (hPa)';
							tmp_ytitle=[ylabv,' (hPa)'];
							tmp_u='(hPa)';
						elseif plt==3
							tmp_exp=squeeze(EXP_cat(:,1,:));
							tmp_bt=squeeze(BT_cat(:,1,:));
							tmp_name='spdval';
							tmp_title='VMAX (m/s)';
							tmp_ytitle=[ylabv,' (m/s)'];
							tmp_u='(m/s)';
						 elseif plt==4
							tmp_exp=squeeze(EXP_ne34(:,1,:));
							tmp_bt=squeeze(BT_ne34(:,1,:));
							tmp_name='neR34val';
							tmp_title='R34 NEQ (km)';
							tmp_ytitle=[ylabv,' (km)'];
							yrange=[0 200];
							tmp_u='(km)';
						elseif plt==5
							tmp_exp=squeeze(EXP_se34(:,1,:));
							tmp_bt=squeeze(BT_se34(:,1,:));
							tmp_name='seR34val';
							tmp_title='R34 SEQ (km)';
							tmp_ytitle=[ylabv,' (km)'];
							yrange=[0 200];
							tmp_u='(km)';
						elseif plt==6
							tmp_exp=squeeze(EXP_sw34(:,1,:));
							tmp_bt=squeeze(BT_sw34(:,1,:));
							tmp_name='swR34val';
							tmp_title='R34 SWQ (km)';
							tmp_ytitle=[ylabv,' (km)'];
							yrange=[0 200];
							tmp_u='(km)';
						elseif plt==7
							tmp_exp=squeeze(EXP_nw34(:,1,:));
							tmp_bt=squeeze(BT_nw34(:,1,:));
							tmp_name='nwR34val';
							tmp_title='R34 NWQ (km)';
							tmp_ytitle=[ylabv,' (km)'];
							yrange=[0 200];
							tmp_u='(km)';
						elseif plt==8
							tmp_exp=squeeze(EXP_ne50(:,1,:));
							tmp_bt=squeeze(BT_ne50(:,1,:));
							tmp_name='neR50val';
							tmp_title='R50 NEQ (km)';
							tmp_ytitle=[ylabv,' (km)'];
							yrange=[0 200];
							tmp_u='(km)';
						elseif plt==9
							tmp_exp=squeeze(EXP_se50(:,1,:));
							tmp_bt=squeeze(BT_se50(:,1,:));
							tmp_name='seR50val';
							tmp_title='R50 SEQ (km)';
							tmp_ytitle=[ylabv,' (km)'];
							yrange=[0 200];
							tmp_u='(km)';
						elseif plt==10
							tmp_exp=squeeze(EXP_sw50(:,1,:));
							tmp_bt=squeeze(BT_sw50(:,1,:));
							tmp_name='swR50val';
							tmp_title='R50 SWQ (km)';
							tmp_ytitle=[ylabv,' (km)'];
							yrange=[0 200];
							tmp_u='(km)';
						elseif plt==11
							tmp_exp=squeeze(EXP_nw50(:,1,:));
							tmp_bt=squeeze(BT_nw50(:,1,:));
							tmp_name='nwR50val';
							tmp_title='R50 NWQ (km)';
							tmp_ytitle=[ylabv,' (km)'];
							yrange=[0 200];
							tmp_u='(km)';
						elseif plt==12
							tmp_exp=squeeze(EXP_ne64(:,1,:));
							tmp_bt=squeeze(BT_ne64(:,1,:));
							tmp_name='neR64val';
							tmp_title='R64 NEQ (km)';
							tmp_ytitle=[ylabv,' (km)'];
							yrange=[0 200];
							tmp_u='(km)';
						elseif plt==13
							tmp_exp=squeeze(EXP_se64(:,1,:));
							tmp_bt=squeeze(BT_se64(:,1,:));
							tmp_name='seR64val';
							tmp_title='R64 SEQ (km)';
							tmp_ytitle=[ylabv,' (km)'];
							yrange=[0 200];
							tmp_u='(km)';
						elseif plt==14
							tmp_exp=squeeze(EXP_sw64(:,1,:));
							tmp_bt=squeeze(BT_sw64(:,1,:));
							tmp_name='swR64val';
							tmp_title='R64 SWQ (km)';
							tmp_ytitle=[ylabv,' (km)'];
							yrange=[0 200];
							tmp_u='(km)';
						elseif plt==15
							tmp_exp=squeeze(EXP_nw64(:,1,:));
							tmp_bt=squeeze(BT_nw64(:,1,:));
							tmp_name='nwR64val';
							tmp_title='R64 NWQ (km)';
							tmp_ytitle=[ylabv,' (km)'];
							yrange=[0 200];
							tmp_u='(km)';
						elseif plt==16
							tmp_exp=squeeze(EXP_po(:,1,:));
							tmp_bt=squeeze(BT_po(:,1,:));
							tmp_name='poval';
							tmp_title='Outer Clsd Isbr Prs (hPa)';
							tmp_ytitle=[ylabv,' (hPa)'];
							tmp_u='(hPa)';
						elseif plt==17
							tmp_exp=squeeze(EXP_ro(:,1,:));
							tmp_bt=squeeze(BT_ro(:,1,:));
							tmp_name='roval';
							tmp_title='Outer Clsd Isbr Rad (km)';
							tmp_ytitle=[ylabv,' (km)'];
							tmp_u='(km)';
						elseif plt==18
							tmp_exp=squeeze(EXP_rmw(:,1,:));
							tmp_bt=squeeze(BT_rmw(:,1,:));
							tmp_name='rmwval';
							tmp_title='RMW (km)';
							tmp_ytitle=[ylabv,' (km)'];
							tmp_u='(km)';
						elseif plt==19
							tmp_exp=squeeze(ateerr_exp(:,1,:));
							tmp_name='ateval';
							tmp_title='Along-Track (km)';
							tmp_ytitle=[ylabv,' (km)'];
							yrange=[-500 500];       
							tmp_u='(km)';
						elseif plt==20
							tmp_exp=squeeze(xteerr_exp(:,1,:));
							tmp_name='xteval';
							tmp_title='Across-Track (km)';
							tmp_ytitle=[ylabv,' (km)'];
							tmp_u='(km)';
							yrange=[-500 500]; 
						elseif plt==21
							tmp_exp=squeeze(cat(1,EXP_ne34(:,1,:),EXP_nw34(:,1,:),EXP_se34(:,1,:),EXP_sw34(:,1,:)));
							tmp_bt=squeeze(cat(1,BT_ne34(:,1,:),BT_nw34(:,1,:),BT_se34(:,1,:),BT_sw34(:,1,:)));
							tmp_name='R34val';
							tmp_title='R34 (km)';
							tmp_ytitle=[ylabv,' (km)'];
							tmp_u='(km)';
							yrange=[0 100];
						elseif plt==22
							tmp_exp=squeeze(cat(1,EXP_ne50(:,1,:),EXP_nw50(:,1,:),EXP_se50(:,1,:),EXP_sw50(:,1,:)));
							tmp_bt=squeeze(cat(1,BT_ne50(:,1,:),BT_nw50(:,1,:),BT_se50(:,1,:),BT_sw50(:,1,:)));
							tmp_name='R50val';
							tmp_title='R50 (km)';
							tmp_ytitle=[ylabv,' (km)'];
							tmp_u='(km)';
							yrange=[0 100];
						elseif plt==23
							tmp_exp=squeeze(cat(1,EXP_ne64(:,1,:),EXP_nw64(:,1,:),EXP_se64(:,1,:),EXP_sw64(:,1,:)));
							tmp_bt=squeeze(cat(1,BT_ne64(:,1,:),BT_nw64(:,1,:),BT_se64(:,1,:),BT_sw64(:,1,:)));
							tmp_name='R64val';
							tmp_title='R64 (km)';
							tmp_ytitle=[ylabv,' (km)'];
							tmp_u='(km)';
							yrange=[0 100];
						end
						tmp_exp0=tmp_exp;
						% YRANGE
						clear allquad
						allquad(1)=(max(max((abs(EXP_ne34(:))))));
						allquad(2)=(max(max((abs(EXP_se34(:))))));
						allquad(3)=(max(max((abs(EXP_nw34(:))))));
						allquad(4)=(max(max((abs(EXP_sw34(:))))));
						allquad(5)=(max(max((abs(EXP_ne50(:))))));
						allquad(6)=(max(max((abs(EXP_se50(:))))));
						allquad(7)=(max(max((abs(EXP_nw50(:))))));
						allquad(8)=(max(max((abs(EXP_sw50(:))))));
						allquad(9)=(max(max((abs(EXP_ne64(:))))));
						allquad(10)=(max(max((abs(EXP_se64(:))))));
						allquad(11)=(max(max((abs(EXP_nw64(:))))));
						allquad(12)=(max(max((abs(EXP_sw64(:))))));
						allquadmax=max(max(max(allquad)));
						allquadmin=min(min(min(allquad)));
						tmpvalq=round(max(abs(allquadmin),abs(allquadmax)));
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
						if numel(num2str(round(max(max(((tmp_exp0)))))))==3
							addfac=100;
						elseif numel(num2str(round(max(max(((tmp_exp0)))))))==2
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
							yrange=[0 round((tmpval+addfac)/10)*10];                
						elseif plt==19 || plt==20 % -end end 
							tmpmin=min(min(((tmp_exp0))));
							tmpmax=max(max(((tmp_exp0))));
							tmpval=max(abs(tmpmin),abs(tmpmax));
							if isnan(tmpval)==1
								tmpval=0;
							end
							yrange=[-round((tmpval+addfac)/10)*10 round((tmpval+addfac)/10)*10];
						elseif (plt>=4 && plt<=15) || plt>=21%quad
							yrange=[0 round((tmpvalq+addfacq)/10)*10];
						end     
						valylim(plt,:)=yrange;                                    
					end               
				ABT_drops=BT_drops;
				ABT_dropsB=BT_dropsB;
				ABT_dropsI=BT_dropsI;
				ABT_dropsT=BT_dropsT;
				ABT_targetI=BT_targetI;
				ABT_targetT=BT_targetT;
				ABT_target=BT_target;
				ABT_targetB=BT_targetB;
				clearvars -except identboxhist identconmetric identeps identmodelfhr identincludeobs identconvobs identserialcorr LOWbasin HIGHbasin ABT_drops ABT_dropsB ABT_dropsI ABT_dropsT ABT_targetI ABT_targetT ABT_target ABT_targetB *ylim identbasinmodel identsatobs identgraphicssat identsatid identsatname identindivch identchannel identindivstorm identcomposite identstormsdone identconvobssubtype identconvobscolors identconvobslegend identns* identnewsub identgraphicsbycycle identgraphicsconv identconvid  ident* skip* stormsdone yearsdone            
				save('compsave2.mat')						
				run('scripts/runverif_statcomp')
			end
		end
		if identcompositefin==1
			load('compsave1.mat')
			load('compsave2.mat')
			if size(stormsdone,2)>1
				run('scripts/runverif_convcomp')
				run('scripts/runverif_satcomp')		
			end
		end
    end
end
