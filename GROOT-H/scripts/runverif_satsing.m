for satobs=1
                    if identsatobs==1
                        %clear identsatobs
                        identinnerdrops=0;set(groot,'defaultAxesXTickLabelRotationMode','manual');set(groot,'defaultAxesYTickLabelRotationMode','manual');set(groot,'defaultAxesZTickLabelRotationMode','manual');
                        identinnergaledrops=0;
                        identouterdrops=0;
                        identdenmap=zeros(10,3);
                        identdenmap_stm=zeros(10,3);
                        identalldrops=0;
                        identuniquedrops=[];
                        identassimilateddrops=[];
                        identassimilateddrops_stm=[];
                        identinnerdrops_stm=0;
                        identinnergaledrops_stm=0;
                        identouterdrops_stm=0;
                        dropsall=[];
                        identbasinnameall=[];
                        alldropsstm=[];
                        alldenmapstm=[];
                        %% Individual Basin-Scale Storm/Init Conv
                        for identloop=1:size(identinittimesunique,1)
                            % What storms are run in the basin at this init time?   
                            if identbasinmodel==0
								if identhwrfmodel==1;identdr=dir([identgroot,'obsall/',identexpshort{1},'/',identhwrf,'*',identinittimesunique(identloop,:),'*']);identdr=unique({identdr.name});
								elseif identhafsmodel==1;identdr=[];for filetypes=1:size(identsatid_filename,1);tmp=dir([identgroot,'obsall/',identexpshort{1},'/*',identsatid_filename{filetypes},'*',identinittimesunique(identloop,:),'*']);identdr00=unique({tmp.name});identdr=[identdr identdr00]';end;end;
							else
								tmpt=[];
								for identloopcheck=1:size(identexpshort,1)
									if identhwrfmodel==1;tmp=dir([identgroot,'obsall/',identexpshort{identloopcheck},'/*',identinittimesunique(identloop,:),'*']);elseif identhafsmodel==1;identdr=[];for filetypes=1:size(identsatid_filename,1);tmp=dir([identgroot,'obsall/',identexpshort{1},'/*',identsatid_filename{filetypes},'*',identinittimesunique(identloop,:),'*']);identdr00=unique({tmp.name});identdr=[identdr identdr00]';end;end;
									tmpt=[tmpt unique({tmp.name})];									
								end
								a=unique(tmpt,'stable');
								b=cellfun(@(x) sum(ismember(tmpt,x)),a,'un',0);
								for tmptt=1:size(b,2)
									c(tmptt)=b{tmptt};
								end
								rmstm=find(c<size(identexpshort,1));
								a(rmstm)=[];
								identdr=a;
							end
                            if isempty(identdr)==1
                                identinittimesunique(identloop,:)=[];
                            else
                                for i=1:size(identdr,2);if identhwrfmodel==1;
                                    identdrops=identdr{i};
                                    if strcmp(identdrops(end-24),'l')==1
                                        identdropsdat(i,:)=['al',identdrops(end-26:end-25)];
                                    elseif strcmp(identdrops(end-24),'e')==1
                                        identdropsdat(i,:)=['ep',identdrops(end-26:end-25)];
                                    elseif strcmp(identdrops(end-24),'w')==1
                                        identdropsdat(i,:)=['wp',identdrops(end-26:end-25)];
                                    elseif strcmp(identdrops(end-24),'c')==1
                                        identdropsdat(i,:)=['cp',identdrops(end-26:end-25)];
                                    end
                                    identbasin{i}=identdrops(1:end-24);
                                    identbasinname{i}=[upper(identdrops(end-26:end-24)),' (',upper(identdrops(1)),identdrops(2:end-27),')'];elseif identhafsmodel==1;identdropsdat=lower(ident(1:4));identbasin={identhwrf};identbasinname={[upper(identn(end-4:end-2)),' (',upper(identn(1)),lower(identn(2:end-5)),')']};end                              
                                end        
                                % Get the TC VITALS for each storm
                                for i=1:size(identdropsdat,1)                                
                                    if identhwrfmodel==1;filename = [identgroot,'tcvitals/',identbasin{i},'.',identinittimesunique(identloop,:),'.storm_vit'];elseif identhafsmodel==1;filename = [identgroot,'tcvitals/',identbasin{i},'.',identinittimesunique(identloop,:),'.storm_vit'];delimiter = ' ';formatSpec = '%10s%4s%4s%[^\n\r]';fileID = fopen(filename,'r');dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string',  'ReturnOnError', false);fclose(fileID);tcvit_id=dataArray{2};tcvit_id=tcvit_id{:};tcvit_id=tcvit_id(2:4);filename = [identgroot,'tcvitals/',tcvit_id,'.',identinittimesunique(identloop,:),'.storm_vit'];end;                                                                                                            
                                    delimiter = ' ';
                                    formatSpec = '%3s%5s%5s%14s%5s%5s%6s%4s%4s%5s%5s%5s%3s%4s%5s%5s%5s%5s%2s%5s%5s%5s%5s%3s%5s%6s%5s%5s%5s%s%[^\n\r]';
                                    fileID = fopen(filename,'r');
                                    dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string',  'ReturnOnError', false);
                                    fclose(fileID);
                                    tcv_lat=dataArray{6};
                                    tcv_lat=tcv_lat{1};
                                    STMLAT(i)=str2num(tcv_lat(1:end-1))/10;
                                    tcv_lon=dataArray{7};
                                    tcv_lon=tcv_lon{1};
                                    tcv_lonew(i)=tcv_lon(end);
                                    tcv_lon=str2num(tcv_lon(1:end-1))/10;
                                    if strcmp(tcv_lonew(i),'W')==1
                                        STMLON(i)=360-tcv_lon;
                                    else
                                        STMLON(i)=tcv_lon;
                                    end
                                    tcv_dir=dataArray{8};
                                    tcv_dir=str2num(tcv_dir{1});
                                    tcv_spd=dataArray{9};
                                    tcv_spd=str2num(tcv_spd{1})/10;
                                    DXDT=tcv_spd.*sin(tcv_dir*pi/180).*3.6;
                                    DDXDT(i) = -1.*DXDT./(111.*cos(STMLAT(i)*pi/180));
                                    DYDT=tcv_spd.*cos(tcv_dir*pi/180).*3.6;
                                    DDYDT(i)=DYDT./111;
                                    if strcmp(tcv_lonew(i),'W')==1
                                        RLON(i)=360 - STMLON(i); %% puts it back to what it was (no neg for W)
                                    else
                                        RLON(i)=tcv_lon; %% keeps it what it was - valid for 0-360 and -180-180
                                    end
                                end
                               % Get the obs for each storm/experiment
                                for j=1:size(identexp,1)
                                    for i=1:size(identdr,2)                
                                        %% Get profile locations
                                        filename=[identgroot,'obsall/',identexpshort{j},'/',identbasin{i},'.',identinittimesunique(identloop,:),'.details.txt'];
                                        filenameqc=[identgroot,'obsall/',identexpshort{j},'/qcflags_',identinittimesunique(identloop,:),'.txt'];    
                                        tmpf=dir(filename);
                                         if tmpf.bytes==0 % the satellite in question was NOT assimilated
                                            alldrops0={[]};
                                            channel={[]};
                                            profiles={[]};
                                            usage={[]};
                                            wavelength={[]};
                                            wavenumber={[]};
                                            flagqc={[]};
                                            latqc={[]};
                                            lonqc={[]};
                                            chqc={[]};
                                            if j==size(identexp,1)
                                                RLON(i)=-1*RLON(i);
                                            end
                                         else
                                            formatSpec = '%8f%8f%8f%f%[^\n\r]';
                                            fileID = fopen(filename,'r');
                                            dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string',  'ReturnOnError', false);
                                            fclose(fileID);
                                            droplat=dataArray{:,1};
                                            if strcmp(tcv_lonew(i),'W')==1
                                                droplon=360-dataArray{:,2}; % puts it into -180-180 coord without the sign
                                            else
                                                droplon=dataArray{:,2}; % leave it be
                                            end
                                            droppres=dataArray{:,3};
                                            dropdhr=dataArray{:,4};
                                            clearvars filename formatSpec fileID dataArray ans;
                                            formatSpec = '%13f%13f%8f%f%[^\n\r]';
                                            fileID = fopen(filenameqc,'r');
                                            dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'EmptyValue', NaN,  'ReturnOnError', false);
                                            fclose(fileID);
                                            qclat=dataArray{:,1};
                                            qcch=dataArray{:,3};
                                            qcflag=dataArray{:,4};                        
                                            if strcmp(tcv_lonew(i),'W')==1
                                                qclon=360-dataArray{:,2}; % puts it into -180-180 coord without the sign
                                            else
                                                qclon=dataArray{:,2}; % leave it be
                                            end                        
                                            clearvars filename formatSpec fileID dataArray ans;
                                             % Create matrix of data based on how many channels the satellite has and how many profiles per channel 
                                             mxch=max(qcch);
                                             stch=find(qcch==1);
                                             for qci=1:size(find(qcch==1),1)
                                                 flagqc(:,qci)=qcflag(stch(qci):stch(qci)+mxch-1);
                                                 latqc(:,qci)=qclat(stch(qci):stch(qci)+mxch-1);
                                                 lonqc(:,qci)=qclon(stch(qci):stch(qci)+mxch-1);
                                                 chqc(:,qci)=qcch(stch(qci):stch(qci)+mxch-1);
                                             end                       
                                            % Add distance away from center at each pressure level
                                            if isnan(droplat)==1
                                                dropaz=NaN;
                                                dropan=NaN;
                                                xtob=NaN;
                                                ytob=NaN;
                                            else
                                                for drp=1:size(droplat,1)
                                                    xtob(drp)=round((RLON(i)+dropdhr(drp).*DDXDT(i))*10)/10;
                                                    ytob(drp)=round((STMLAT(i)+dropdhr(drp).*DDYDT(i))*10)/10;
                                                    if strcmp(tcv_lonew(i),'W')==1
                                                        dropaz(drp)=abs(111.11.*(distancegroot(ytob(drp),-1*xtob(drp),droplat(drp),-1*droplon(drp))));
                                                        [droptmp(drp),dropan(drp)]=distancegroot(ytob(drp),-1*xtob(drp),droplat(drp),-1*droplon(drp));
                                                    else
                                                        dropaz(drp)=abs(111.11.*(distancegroot(ytob(drp),xtob(drp),droplat(drp),droplon(drp))));
                                                        [droptmp(drp),dropan(drp)]=distancegroot(ytob(drp),xtob(drp),droplat(drp),droplon(drp));
                                                    end                                
                                                end
                                            end    
                                            % Make Full List
                                            if strcmp(tcv_lonew(i),'W')==1
                                                tmpdrops=[-1*droplon droplat droppres dropaz' dropan' -1*xtob' ytob'];
                                                if j==size(identexp,1)
                                                    RLON(i)=-1*RLON(i);
                                                end
                                            else
                                                tmpdrops=[droplon droplat droppres dropaz' dropan' xtob' ytob'];
                                            end
                                            alldrops0{i}=tmpdrops;
                                            clear dropaz tmp tmpdrops dropan xtob ytob
                                            %% Get profiles
                                            filename=[identgroot,'obsall/',identexpshort{j},'/',identbasin{i},'.',identinittimesunique(identloop,:),'.profiles.txt'];                     
                                            formatSpec = '%5s%5s%9s%15s%7s%11s%12s%12s%12s%12s%s%[^\n\r]';
                                            fileID = fopen(filename,'r');
                                            dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string',  'ReturnOnError', false);
                                            fclose(fileID);
                                            raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
                                            for col=1:length(dataArray)-1
                                                raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
                                            end
                                            numericData = NaN(size(dataArray{1},1),size(dataArray,2));
                                            for col=[1,2,3,4,5,6,7,8,9,10,11]
                                                % Converts text in the input cell array to numbers. Replaced non-numeric text with NaN.
                                                rawData = dataArray{col};
                                                for row=1:size(rawData, 1)
                                                    % Create a regular expression to detect and remove non-numeric prefixes and suffixes.
                                                    regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
                                                    try
                                                        result = regexp(rawData(row), regexstr, 'names');
                                                        numbers = result.numbers;
                                                        % Detected commas in non-thousand locations.
                                                        invalidThousandsSeparator = false;
                                                        if numbers.contains(',')
                                                            thousandsRegExp = '^[-/+]*\d+?(\,\d{3})*\.{0,1}\d*$';
                                                            if isempty(regexp(numbers, thousandsRegExp, 'once'))
                                                                numbers = NaN;
                                                                invalidThousandsSeparator = true;
                                                            end
                                                        end
                                                        % Convert numeric text to numbers.
                                                        if ~invalidThousandsSeparator
                                                            numbers = textscan(char(strrep(numbers, ',', '')), '%f');
                                                            numericData(row, col) = numbers{1};
                                                            raw{row, col} = numbers{1};
                                                        end
                                                    catch
                                                        raw{row, col} = rawData{row};
                                                    end
                                                end
                                            end
                                            channel{i}=numericData(:,2);
                                            profiles{i}=numericData(:,4);
                                            usage{i}=numericData(:,6);
                                            clearvars filename formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp;
                                            %% Get wavelength and wavenumber
                                            filename=[identgroot,'obsall/',identexpshort{j},'/',identbasin{i},'.',identinittimesunique(identloop,:),'.channels.txt'];                     
                                            startRow = 3;
                                            formatSpec = '%7C%3f%10f%10f%10f%10f%10f%5f%5f%f%[^\n\r]';
                                            fileID = fopen(filename,'r');
                                            dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
                                            fclose(fileID);
                                            wavelength{i}=dataArray{:,3};
                                            wavenumber{i}=dataArray{:,5};
                                            clearvars filename startRow formatSpec fileID dataArray ans;
                                        end                    
                                    end                
                                    alldrops{j}=alldrops0;
                                    allchannel{j}=channel;
                                    allprofiles{j}=profiles;
                                    allusage{j}=usage;
                                    allwavelength{j}=wavelength;
                                    allwavenumber{j}=wavenumber;
                                    flagqc={flagqc};
                                    latqc={latqc};
                                    lonqc={lonqc};
                                    chqc={chqc};                
                                    allflagqc{j}=flagqc;
                                    alllatqc{j}=latqc;
                                    alllonqc{j}=lonqc;
                                    allchqc{j}=chqc;
                                    clear alldrops0 channel profiles usage wavelength wavenumber flagqc latqc lonqc chqc
                                end                                     
                                % Generate Graphics or Fields for Later
                                if identgraphicssat==1
                                    %Plot the basin-wide view of all drops for each experiment
                                    for loop1=1:size(identexp,1)
                                        spPos=[0.11 0.13 0.75 0.75]; % arrange plots the same
                                        set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                        hfig=figure;
                                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                        ax1=subplot(3,4,[1:8]);
                                        h=fill([360,-360,-360,360],[-90,-90,90,90],[.5 .8 1]);
                                        hold on;borders('countries','facecolor',[.9 .9 .9]);borders('continental us','k');
                                        %geoshow('borders.shp','FaceColor',[0.9 0.9 0.9]);
                                        %hold on
                                        %states = shaperead('usastatehi', 'UseGeoCoords', true);
                                        %geoshow(states,'FaceColor',[0.9 0.9 0.9]);                                      
                                        xlabel('Longitude','fontsize',20)
                                        ylabel('Latitude','fontsize',20)                                   
                                        set(gca,'fontsize',20)
                                        axis equal
                                        axis([-180 180 -90 90])
                                        numdrops=0;
                                        clear l lsz
                                        for loop=1:size(identdr,2)
                                            viscircles([RLON(loop) STMLAT(loop)],500/111.11,'Color',[.5 .5 .5],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                            viscircles([RLON(loop) STMLAT(loop)],1000/111.11,'Color',[.5 .5 .5],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                            hold on
                                            alldrops0=alldrops{loop1};
                                            alldrops0=alldrops0{loop};
                                            if sum(~isnan(alldrops0(:)))==0
                                                l(1)=plot(-360,-360,'o','markerfacecolor','k','markersize',2,'markeredgecolor','k');
                                            else       
                                                l(1)=plot(alldrops0(:,1),alldrops0(:,2),'o','markerfacecolor','k','markersize',2,'markeredgecolor','k');
                                                numdrops=numdrops+size(alldrops0,1);
                                            end       
                                            lloop=identbasin{loop};
                                            text(RLON(loop),STMLAT(loop),upper(lloop(end-2:end)),'horizontalalignment','center','fontsize',10,'color',[.5 .5 .5])
                                        end
                                        l=legend(l,['Potential Profiles'],'location','northeast');
                                        l.FontSize=10;
                                        hold off                        
                                        set(gca,'xtick',-180:60:180)
                                        set(gca,'ytick',-90:30:90)
                                        set(gca,'plotboxaspectratio',[1 1 1])
                                        set(gcf, 'InvertHardcopy', 'off')
                                        set(gcf,'Units','inches');
                                        screenposition = get(gcf,'Position');
                                        set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                        set(gcf, 'InvertHardcopy', 'off')
                                        text(0,1.055,['\textbf{INIT: ',identinittimesunique(identloop,:),' $\mid$ PP=',num2str(numdrops),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                        text(0,1.11,['\textbf{Potential ',identsatname,' Profiles}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                        text(1,1.055,['\textbf{',identexpshort{loop1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(loop1,:),'units','normalized');
                                        ax=gca;
                                        box on
                                        set(ax, 'Layer', 'top')
                                        ax.LineWidth=1; 
                                        set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                        axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);
										filename=[identtrackint,'/sat_basin_',identinittimesunique(identloop,:),'_',identexpshort{loop1}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                        close all
                                    end
                                    % Plot the location of all obs at all levels that are included, centered on storm
                                    for loop1=1:size(identexp,1)
                                       for loop=1:size(identdr,2)                
                                        alldrops0=alldrops{loop1};
                                        alldrops0=alldrops0{loop};      
                                        channel=allchannel{loop1};
                                        channel=channel{loop}; 
                                        usage=allusage{loop1};
                                        usage=usage{loop};
                                        profiles=allprofiles{loop1};
                                        profiles=profiles{loop};
                                        wavenumber=allwavenumber{loop1};
                                        wavenumber=wavenumber{loop};
                                        wavelength=allwavelength{loop1};
                                        wavelength=wavelength{loop};
                                        flagqc=allflagqc{loop1};
                                        flagqc=flagqc{loop};
                                        latqc=alllatqc{loop1};
                                        latqc=latqc{loop};
                                        lonqc=alllonqc{loop1};
                                        lonqc=lonqc{loop};
                                        chqc=allchqc{loop1};
                                        chqc=chqc{loop};
                                        if isempty(channel)==1
                                            alldenmap(loop,loop1)={[]};  
                                            RLON2=RLON(loop);
                                            STMLAT2=STMLAT(loop);
                                            identbasinname2={identbasinname{loop}};
                                            alldrops2{loop1}={alldrops0};
                                        else                      
                                            set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                            hfig=figure;
                                            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                            ax1=subplot(3,4,[1:8]);
                                            h=fill([360,-360,-360,360],[-90,-90,90,90],[.5 .8 1]);
                                            hold on;borders('countries','facecolor',[.9 .9 .9]);borders('continental us','k');                                           
                                            %geoshow('borders.shp','FaceColor',[0.9 0.9 0.9]);
                                            %hold on
                                            %states = shaperead('usastatehi', 'UseGeoCoords', true);
                                            %geoshow(states,'FaceColor',[0.9 0.9 0.9]);
                                            xlabel('Longitude','fontsize',20)
                                            ylabel('Latitude','fontsize',20)                                   
                                            set(gca,'fontsize',20)
                                            fhr=1;                              
                                            viscircles([RLON(loop) STMLAT(loop)],75/111.11,'Color',[.5 .5 .5 ],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                            viscircles([RLON(loop) STMLAT(loop)],250/111.11,'Color',[.5 .5 .5 ],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                            viscircles([RLON(loop) STMLAT(loop)],500/111.11,'Color',[.5 .5 .5 ],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                            viscircles([RLON(loop) STMLAT(loop)],1000/111.11,'Color',[.5 .5 .5 ],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                            hold on
                                            plot(RLON(loop),STMLAT(loop),'o','markerfacecolor',[.5 .5 .5],'markersize',2,'markeredgecolor',[.5 .5 .5]);                
                                            numdrops=0;
                                            if sum(~isnan(alldrops0(:)))==0
                                            else                        
                                                for drp=1:size(alldrops0,1)
                                                        l(1)=plot(alldrops0(drp,1),alldrops0(drp,2),'o','markerfacecolor','k','markersize',2,'markeredgecolor','k');
                                                        numdrops=numdrops+1;
                                                end
                                                tmpminlat=min(alldrops0(:,2));
                                                tmpmaxlat=max(alldrops0(:,2));
                                                tmpminlon=min(alldrops0(:,1));
                                                tmpmaxlon=max(alldrops0(:,1));      
                                                xlim([tmpminlon-2 tmpmaxlon+2])
                                                ylim([tmpminlat-2 tmpmaxlat+2])       
                                            end     
                                            axis([RLON(loop)-15 RLON(loop)+15 STMLAT(loop)-15 STMLAT(loop)+15])
                                            text(.5,.49,'75 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ])
                                            text(.5,.43,'250 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ])
                                            text(.5,.355,'500 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ])
                                            text(.5,.2,'1000 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ])
                                            l=legend(l,['Potential Profiles'],'location','northeast');
                                            l.FontSize=10;
                                            hold off
                                            set(gca,'plotboxaspectratio',[1 1 1])
                                            set(gcf, 'InvertHardcopy', 'off')
                                            set(gcf,'Units','inches');
                                            screenposition = get(gcf,'Position');
                                            set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                            set(gcf, 'InvertHardcopy', 'off')
                                            text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,:),' $\mid$ PP=',num2str(max(profiles)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                            text(0,1.065,['\textbf{Potential ',identsatname,' Profiles}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                            text(1,1.03,['\textbf{',upper(identbasinname{loop}),'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                            text(1,1.065,['\textbf{',identexpshort{loop1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(loop1,:),'units','normalized');
                                            ax=gca;
                                            box on
                                            set(ax, 'Layer', 'top')
                                            ax.LineWidth=1; 
                                            set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                                            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                            axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);
											filename=[identtrackint,'/sat_plan_',identinittimesunique(identloop,:),'_',identexpshort{loop1}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                            close all 
                                            %% Individual Channel Graphics
                                            if identindivch==1
                                                if strcmp(identchannel,'all')==1
                                                identchannel=[1:size(flagqc,1)];
                                                end
                                                for loop2=identchannel % user-passed variable
                                                    % Subset Data
                                                    qcflag=flagqc(loop2,:);
                                                    qclat=latqc(loop2,:);
                                                    qclon=lonqc(loop2,:);
                                                    qcch=chqc(loop2,:);
                                                    qclat=qclat(qcflag==0);
                                                    qclon=qclon(qcflag==0);
                                                    % Plot
                                                    set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                                    hfig=figure;
                                                    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                                    ax1=subplot(3,4,[1:8]);
                                                    h=fill([360,-360,-360,360],[-90,-90,90,90],[.5 .8 1]);
                                                    hold on;borders('countries','facecolor',[.9 .9 .9]);borders('continental us','k');
                                                    %geoshow('borders.shp','FaceColor',[0.9 0.9 0.9]);
                                                    %hold on
                                                    %states = shaperead('usastatehi', 'UseGeoCoords', true);
                                                    %geoshow(states,'FaceColor',[0.9 0.9 0.9]);
                                                    xlabel('Longitude','fontsize',20)
                                                    ylabel('Latitude','fontsize',20)                                   
                                                    set(gca,'fontsize',20)
                                                    fhr=1;                              
                                                    viscircles([RLON(loop) STMLAT(loop)],75/111.11,'Color',[.5 .5 .5 ],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                                    viscircles([RLON(loop) STMLAT(loop)],250/111.11,'Color',[.5 .5 .5 ],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                                    viscircles([RLON(loop) STMLAT(loop)],500/111.11,'Color',[.5 .5 .5 ],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                                    viscircles([RLON(loop) STMLAT(loop)],1000/111.11,'Color',[.5 .5 .5 ],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                                    hold on
                                                    plot(RLON(loop),STMLAT(loop),'o','markerfacecolor',[.5 .5 .5],'markersize',2,'markeredgecolor',[.5 .5 .5]);                
                                                    numdrops=0;
                                                    if sum(~isnan(alldrops0(:)))==0
                                                    else                        
                                                        for drp=1:size(qclat,2)
                                                                l(1)=plot(-1*qclon(drp),qclat(drp),'o','markerfacecolor','k','markersize',2,'markeredgecolor','k');
                                                                numdrops=numdrops+1;
                                                        end
                                                        tmpminlat=min(alldrops0(:,2));
                                                        tmpmaxlat=max(alldrops0(:,2));
                                                        tmpminlon=min(alldrops0(:,1));
                                                        tmpmaxlon=max(alldrops0(:,1));      
                                                        xlim([tmpminlon-2 tmpmaxlon+2])
                                                        ylim([tmpminlat-2 tmpmaxlat+2])       
                                                    end                                                        
                                                    axis([RLON(loop)-15 RLON(loop)+15 STMLAT(loop)-15 STMLAT(loop)+15])
                                                    text(.5,.49,'75 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ])
                                                    text(.5,.43,'250 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ])
                                                    text(.5,.355,'500 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ])
                                                    text(.5,.2,'1000 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ])
                                                    l=legend(l,['Profile Locations'],'location','northeast');
                                                    l.FontSize=10;
                                                    hold off
                                                    set(gca,'plotboxaspectratio',[1 1 1])
                                                    set(gcf, 'InvertHardcopy', 'off')
                                                    set(gcf,'Units','inches');
                                                    screenposition = get(gcf,'Position');
                                                    set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                                    set(gcf, 'InvertHardcopy', 'off')
                                                    text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,:),' $\mid$ P=',num2str(numdrops),'/',num2str(max(profiles)),' $\mid$ C=',num2str(channel(identchannel)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                    text(0,1.065,['\textbf{Assimilated ',identsatname,' Profiles at ',num2str(wavenumber(identchannel)),' cm$^{-1}$ (',num2str(round(10000/wavenumber(identchannel),2)),' $\mu$)}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                    text(1,1.03,['\textbf{',upper(identbasinname{loop}),'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                    text(1,1.065,['\textbf{',identexpshort{loop1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(loop1,:),'units','normalized');
                                                    ax=gca;
                                                    box on
                                                    set(ax, 'Layer', 'top')
                                                    ax.LineWidth=1; 
                                                    set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                                                    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                                    axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);
													filename=[identtrackint,'/sat_plan_C',num2str(channel(identchannel)),'_',identinittimesunique(identloop,:),'_',identexpshort{loop1}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                                    %print([identtrackint,'/trackcomp_fhr_',num2str((fhr-1)*3),'h'],'-dpdf','-r200');
                                                    close all                     
                                                end
                                            end
                                            %% Channels & Profiles                
                                            set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                            hfig=figure;
                                            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                            ax1=subplot(3,4,[1:8]);
                                            plot(channel,profiles,'-k','markersize',10)
                                            hold on
                                            plot(channel(usage>0),profiles(usage>0),'.k','markersize',20)
                                            ylabel('Profiles','fontsize',20)
                                            set(gca,'fontsize',16)
                                            text(0,1.065,['\textbf{Assimilated ', identsatname,' Profiles By Channel \& Wavenumber}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                            text(1,1.03,['\textbf{',upper(identbasinname{loop}),'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                            text(1,1.065,['\textbf{',identexpshort{loop1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(loop1,:),'units','normalized');
                                            text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,:),' $\mid$ EC=',num2str(sum(usage>0)),'/',num2str(size(usage,1)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                            xlim([min(channel) max(channel)])
                                            ax=gca;
                                            box on
                                            set(ax, 'Layer', 'top')
                                            ax.LineWidth=1; 
                                            lg=legend(['All ',num2str(size(usage,1)),' Channels'],'Enabled Channels');
                                            lg.FontSize=10;
                                            ylim([0 round(max(profiles)/100)*100+100])
                                            set(gca,'ytick',[0:100:round(max(profiles)/100)*100+100])
                                            grid on
                                            set(gca,'Color',[.9 .9 .9])
                                            set(gca,'xtick',[channel(1) channel(201) channel(280) channel(322) channel(421) channel(444) channel(511) channel(559) channel(616)])
                                            wavenum=[wavenumber(1) wavenumber(201) wavenumber(280) wavenumber(322) wavenumber(421) wavenumber(444) wavenumber(511) wavenumber(559) wavenumber(616)];
                                            wavelen=[wavelength(1) wavelength(201) wavelength(280) wavelength(322) wavelength(421) wavelength(444) wavelength(511) wavelength(559) wavelength(616)];
                                            xTicks0 = get(gca, 'xticklabel');
                                            xTicks = get(gca, 'xtick');
                                            minY =0;
                                            VerticalOffset1=60;
                                            HorizontalOffset = 0.2;
                                            for xx = 1:size(xTicks0,1)   
                                                text(xTicks(xx), minY - VerticalOffset1,['(',num2str(wavenum(xx)),')'],'horizontalalignment','center','fontsize',10)                    
                                            end
                                            text(.5, -.1,'Channels','horizontalalignment','center','fontsize',16,'units','normalized')                    
                                            text(.5, -.13,'(Wavenumber)','horizontalalignment','center','fontsize',10,'units','normalized')                    
                                            set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                                            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                            axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);
											filename=[identtrackint,'/sat_channels_',identinittimesunique(identloop,:),'_',identexpshort{loop1}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                            close all
                                            %% Density Map
                                            % Full Density Map - keep this
                                             pall=squeeze(alldrops0(:,3,:));
                                             dall=squeeze(alldrops0(:,4,:));                                
                                             places=[];
                                             denmapall=[];
                                             for drp=1
                                                 %group pressures
                                                 data = pall(:,drp);
                                                 edges = 0:100:1100;
                                                 Y1 = discretize(data,edges);
                                                 %group radial bins
                                                 data=dall(:,drp);
                                                 edges=[0,75,250,10000];
                                                 Y2 = discretize(data,edges);
                                                 places=[Y1 Y2];
                                             end                        
                                             for k=1
                                                 denmap=nan(11,3);
                                                 places0=places;
                                                 for i=1:size(places0,1)
                                                     if isnan(places0(i,1))==1 || isnan(places0(i,2))==1
                                                     else
                                                         denmap(places0(i,1),places0(i,2))=nansum([denmap(places0(i,1),places0(i,2)),1]);
                                                     end
                                                 end
                                                 denmapall=denmap;
                                             end
                                             denmapall(isnan(denmapall))=0;                
                                             denmap=nan(11,3);
                                             denmap=nansum(denmapall,3);                
                                            set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                            hfig=figure;
                                            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                            ax1=subplot(3,4,[1:8]);
                                            imagesc((denmap))
                                            xlabel('','fontsize',20)
                                            ylabel('PMIN (hPa)','fontsize',20)                                   
                                            set(gca,'fontsize',20)
                                            set(gca,'xtick',1:3)
                                            set(gca,'xticklabel',{'<75 km','75-250 km','>250 km'});
                                            set(gca,'ytick',0.5:1:12)
                                            set(gca,'yticklabel',{'0','100','200','300','400','500','600','700','800','900','1000','1100'});
                                            colorbar
                                            caxis([0 50])
                                            colormap(flipud(gray(25)))
                                            set(gca, 'YGrid', 'on', 'XGrid', 'off')
                                            hold on
                                            plot(repmat(1.5,1,13),0:12,'k')
                                            plot(repmat(2.5,1,13),0:12,'k')
                                            set(gca,'plotboxaspectratio',[1 1 1])
                                            set(gcf, 'InvertHardcopy', 'off')
                                            set(gcf,'Units','inches');
                                            screenposition = get(gcf,'Position');
                                            set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                            set(gcf, 'InvertHardcopy', 'off')
                                            text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,:),' $\mid$ PP=',num2str(sum(denmap(:))),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                            text(0,1.065,['\textbf{Potential ',identsatname,' Profiles}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                            text(1,1.03,['\textbf{',upper(identbasinname{loop}),'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                            text(1,1.065,['\textbf{',identexpshort{loop1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(loop1,:),'units','normalized');
                                            for i=1:3
                                                for j=1:11
                                                    if denmap(j,i)>=40
                                                        text(i,j, num2str(denmap(j,i)), 'color','w','HorizontalAlignment', 'Center','fontsize',16)
                                                    else
                                                        text(i,j, num2str(denmap(j,i)), 'HorizontalAlignment', 'Center','fontsize',16)
                                                    end
                                                end
                                            end        
                                            text(0,-.065,['(Tot. #)'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',14,'interpreter','tex','color','k','units','normalized');        
                                            text(.168,-.065,['(',num2str(sum(denmap(:,1))),')'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',14,'interpreter','tex','color','k','units','normalized');
                                            text(.5,-.065,['(',num2str(sum(denmap(:,2))),')'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',14,'interpreter','tex','color','k','units','normalized');
                                            text(.832,-.065,['(',num2str(sum(denmap(:,3))),')'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',14,'interpreter','tex','color','k','units','normalized');        
                                            text(.5,-.1,['Distance from Storm Center'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',22,'interpreter','tex','color','k','units','normalized');
                                            ax=gca;
                                            box on
                                            set(ax, 'Layer', 'top')
                                            ax.LineWidth=1; 
                                            set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                                            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                            axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);
											filename=[identtrackint,'/sat_az_',identinittimesunique(identloop,:),'_',identexpshort{loop1}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                            close all
                                            alldenmap(loop,loop1)={denmapall};  
                                            RLON2=RLON(loop);
                                            STMLAT2=STMLAT(loop);
                                            identbasinname2={identbasinname{loop}};
                                            alldrops2{loop1}={alldrops0};
                                        end
                                       end
                                    end                  
                                else 
                                    spPos=[0.11 0.13 0.75 0.75]; % arrange plots the same                                                                       
                                    for loop1=1:size(identexp,1)
                                       for loop=1:size(identdr,2)                
                                        alldrops0=alldrops{loop1};
                                        alldrops0=alldrops0{loop};      
                                        channel=allchannel{loop1};
                                        channel=channel{loop}; 
                                        usage=allusage{loop1};
                                        usage=usage{loop};
                                        profiles=allprofiles{loop1};
                                        profiles=profiles{loop};
                                        wavenumber=allwavenumber{loop1};
                                        wavenumber=wavenumber{loop};
                                        wavelength=allwavelength{loop1};
                                        wavelength=wavelength{loop};
                                        flagqc=allflagqc{loop1};
                                        flagqc=flagqc{loop};
                                        latqc=alllatqc{loop1};
                                        latqc=latqc{loop};
                                        lonqc=alllonqc{loop1};
                                        lonqc=lonqc{loop};
                                        chqc=allchqc{loop1};
                                        chqc=chqc{loop};
                                        if isempty(channel)==1
                                            alldenmap(loop,loop1)={[]};  
                                            RLON2=RLON(loop);
                                            STMLAT2=STMLAT(loop);
                                            identbasinname2={identbasinname{loop}};
                                            alldrops2{loop1}={alldrops0};
                                        else                      
                                            numdrops=0;
                                            if sum(~isnan(alldrops0(:)))==0
                                            else                        
                                                for drp=1:size(alldrops0,1)
                                                        %l(1)=plot(alldrops0(drp,1),alldrops0(drp,2),'o','markerfacecolor','k','markersize',2,'markeredgecolor','k');
                                                        numdrops=numdrops+1;
                                                end                                                 
                                            end                                                                                 
                                        %% Density Map
                                        % Full Density Map - keep this
                                             pall=squeeze(alldrops0(:,3,:));
                                             dall=squeeze(alldrops0(:,4,:));                                
                                             places=[];
                                             denmapall=[];
                                             for drp=1
                                                 %group pressures
                                                 data = pall(:,drp);
                                                 edges = 0:100:1100;
                                                 Y1 = discretize(data,edges);
                                                 %group radial bins
                                                 data=dall(:,drp);
                                                 edges=[0,75,250,10000];
                                                 Y2 = discretize(data,edges);
                                                 places=[Y1 Y2];
                                             end                        
                                             for k=1
                                                 denmap=nan(11,3);
                                                 places0=places;
                                                 for i=1:size(places0,1)
                                                     if isnan(places0(i,1))==1 || isnan(places0(i,2))==1
                                                     else
                                                         denmap(places0(i,1),places0(i,2))=nansum([denmap(places0(i,1),places0(i,2)),1]);
                                                     end
                                                 end
                                                 denmapall=denmap;
                                             end
                                             denmapall(isnan(denmapall))=0;                
                                             denmap=nan(11,3);
                                             denmap=nansum(denmapall,3);                                                        
                                            alldenmap(loop,loop1)={denmapall};  
                                            RLON2=RLON(loop);
                                            STMLAT2=STMLAT(loop);
                                            identbasinname2={identbasinname{loop}};
                                            alldrops2{loop1}={alldrops0};
                                        end
                                       end
                                    end  
                                end
                                EXP_loncomp{identloop}=RLON2;
                                EXP_latcomp{identloop}=STMLAT2;
                                EXP_namecomp{identloop}=identbasinname2;
                                alldropscomp{identloop}=alldrops2;
                                alldenmapcomp{identloop}=alldenmap;  
                            end
                            clear identdrops identdropsdat identbasin identbasinname alldrops alldenmap alldenmap_t l lsz
                            clear alldrops0 channel profiles usage wavelength wavenumber identdrops identbasin identbasinname alldrops alldenmap allchannel allprofiles allusage allwavelength allwavenumber
                            clear alldrops0 channel profiles usage wavelength wavenumber flagqc latqc lonqc chqc                        
                        end
                        identbasinnameall=unique(identbasinnameall);
                        %% Composite Basin-Scale                  
                        % Loop over all experiments
                        for exl=1:size(identexp,1)            
                            % Loop over all of the cycles
                            tmp1=[];
                            tmp1_den=[];
                            for cyc=1:size(alldropscomp,2)
                                tmp0_all=alldropscomp{cyc};
                                tmp0_lon=EXP_loncomp{cyc};
                                tmp0_lat=EXP_latcomp{cyc};
                                tmp0_name=EXP_namecomp{cyc};
                                tmp0_denmap=alldenmapcomp{cyc};
                                tmp2_all=tmp0_all{exl};
                                cycleswithdrops=tmp0_all{1};
                                if isempty(cycleswithdrops{:})==1
                                   identdropcyc(cyc)=0;
                                else
                                    identdropcyc(cyc)=1;                        
                                end
                                for i=1:size(tmp2_all,2)
                                    tmp3_lon=tmp0_lon(i); 
                                    tmp3_lat=tmp0_lat(i); 
                                    tmp3_name=tmp0_name{i}; 
                                    tmp3_denmap=tmp0_denmap{i,exl};
                                    tmp3_all=tmp2_all{i};
                                    if isempty(tmp3_all)==1
                                    else                                                
                                        tmp3_all=[tmp3_all(:,1:3) zeros(size(tmp3_all,1),1) tmp3_all(:,4:end)];
                                        tmp3_all(:,3)=repmat(tmp3_lon,size(tmp3_all,1),1);
                                        tmp3_all(:,4)=repmat(tmp3_lat,size(tmp3_all,1),1);
                                        tmp1=cat(1,tmp1,tmp3_all); % all storms for ALL experiment
                                        tmp1_den=cat(3,tmp1_den,tmp3_denmap);
                                    end
                                end
                            end               
                            if isempty(tmp1)==1
                                identinnerdrops(exl)=0;
                                identgalesdrops(exl)=0;
                                identouterdrops(exl)=0;
                            else
                                t=sum(sum(tmp1_den,1),3);
                                identinnerdrops(exl)=t(1);
                                identgalesdrops(exl)=t(2);
                                identouterdrops(exl)=t(3);
                            end
                            for loopdrops=1 % loop over all drops                
                                % Histogram
                                spPos=[0.11 0.13 0.75 0.75]; % arrange plots the same
                                set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                hfig=figure;
                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                ax1=subplot(3,4,[1:8]);
                                set(gca,'plotboxaspectratio',[1 1 1])
                                box on
                                set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                hold on
                                clear l
                                if isempty(tmp1)==1
                                        counts=0;
                                        l(1)=plot(0,5000,'.k');
                                else
                                        [counts,centers]=hist(tmp1(:,5),[0:5:2000]);
                                        l(1)=plot(centers,counts,'-k','linewidth',2);            
                                end
                                xlim([-.5 2000])
                                if exl==1
                                    ymaxallbasin=round(max(counts)/100)*100+50;
                                end
                                ylim([0 ymaxallbasin])
                                ll=legend(l,['Potential Profiles'],'location','northeast');
                                ll.FontSize=10;
                                ylabel('Number of Potential Profiles','fontsize',20)                                   
                                xlabel('Radius (km)','fontsize',20)                                   
                                set(gca,'fontsize',20)
                                grid on
                                set(gca,'xtick',0:250:2000)
                                set(gcf, 'InvertHardcopy', 'off')
                                set(gcf,'Units','inches');
                                screenposition = get(gcf,'Position');
                                set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                set(gcf, 'InvertHardcopy', 'off')                       
                                text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),' $\mid$ PP=',num2str(size(tmp1,1)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                text(0,1.065,['\textbf{Potential ',identsatname,' Profiles}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-5),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                                text(1,1.065,['\textbf{',identexpshort{exl},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(exl,:),'units','normalized');                    
                                ax=gca;
                                set(gca,'Color',[.9 .9 .9])
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1; 
                                set(gca,'position',[spPos(1)+.035 spPos(2)+.015 spPos(3) spPos(4)-.02])
                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);
								filename=[identtrackint,'/sat_hist_',identexpshort{exl}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                close all    
                                % Create storm-centered reference frame for all dropsonde locations
                                spPos=[0.11 0.13 0.75 0.75]; % arrange plots the same
                                set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                hfig=figure;
                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                ax2=subplot(3,4,[1:8]);
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ax2=gca;
                                set(gca,'Color',[.9 .9 .9])
                                box on
                                set(ax2, 'Layer', 'top')
                                ax2.LineWidth=1; 
                                set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                set(gca,'xtick',[])
                                set(gca,'ytick',[])
                                hold on
                                ax1=subplot(3,4,[1:8],polaraxes);
                                 hold on
                                clear l lsz
                                if isempty(tmp1)==1                                
                                        l(1)=polarplot(0,5000,'.k');
                                else
                                        l(1)=polarplot(tmp1(:,6)*pi/180,tmp1(:,5),'.k');
                                end
                                ll=legend(l,['Potential Profiles'],'location','northeast');
                                ll.FontSize=10;
                                ax1.ThetaDir = 'clockwise';
                                ax1.ThetaZeroLocation = 'top';
                                ax1.RLim=[0 1600];
                                ax1.ThetaTick = [];
                                rticks([75 250 500 1000 1500])
                                rticklabels({})
                                thetaticklabels({}) 
                                ax1.GridLineStyle = '--';
                                ax1.ThetaColor=[.9 .9 .9];
                                ax1.GridAlpha = 1;
                                ax1.GridColor=[.7 .7 .7];
                                set(gcf, 'InvertHardcopy', 'off')
                                set(gcf,'Units','inches');
                                screenposition = get(gcf,'Position');
                                set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                set(gcf, 'InvertHardcopy', 'off')   
                                text(.5,.484,'75 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5])
                                text(.5,.426,'250 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5])
                                text(.5,.347,'500 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5])
                                text(.5,.19,'1000 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5])
                                text(.5,.034,'1500 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5])
                                text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),' $\mid$ PP=',num2str(size(tmp1,1)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                text(0,1.065,['\textbf{Potential ',identsatname,' Profiles}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-5),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                                text(1,1.065,['\textbf{',identexpshort{exl},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(exl,:),'units','normalized');                    
                                ax=gca;
                                set(gca,'Color',[.9 .9 .9])
                                set(ax, 'Layer', 'top')
                                ax1.LineWidth=1; 
                                set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window                    
                                axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);                    
								filename=[identtrackint,'/sat_plan_',identexpshort{exl}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                close all                            
                                %% Density Map                
                                set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                hfig=figure;
                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                ax1=subplot(3,4,[1:8]);  
                                if isempty(tmp1_den)==1
                                    tmp1_den=zeros(11,3);
                                end               
                                identvals=sum(sum(tmp1_den,1),3);
                                imagesc(sum(tmp1_den,3))
                                xlabel('','fontsize',20)
                                ylabel('PMIN (hPa)','fontsize',20)                                   
                                set(gca,'fontsize',20)
                                set(gca,'xtick',1:3)
                                set(gca,'xticklabel',{'<75 km','75-250 km','>250 km'});
                                set(gca,'ytick',0.5:1:12)
                                set(gca,'yticklabel',{'0','100','200','300','400','500','600','700','800','900','1000','1100'});
                                colorbar
                                caxis([0 250])
                                colormap(flipud(gray(25)))
                                set(gca, 'YGrid', 'on', 'XGrid', 'off')
                                hold on
                                plot(repmat(1.5,1,13),0:12,'k')
                                plot(repmat(2.5,1,13),0:12,'k')
                                set(gca,'plotboxaspectratio',[1 1 1])
                                set(gcf, 'InvertHardcopy', 'off')
                                set(gcf,'Units','inches');
                                screenposition = get(gcf,'Position');
                                set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                set(gcf, 'InvertHardcopy', 'off')
                                tmpsum=sum(identvals);                
                                text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),' $\mid$ PP=',num2str(size(tmp1,1)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                text(0,1.065,['\textbf{Potential ',identsatname,' Profiles}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-5),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                                text(1,1.065,['\textbf{',identexpshort{exl},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(exl,:),'units','normalized');                    
                                tmpsum=sum(tmp1_den,3);                
                                for i=1:3
                                    for j=1:11
                                        if tmpsum(j,i)>=200
                                            text(i,j, num2str(tmpsum(j,i)),'color','w','HorizontalAlignment', 'Center','fontsize',16)
                                        else
                                            text(i,j, num2str(tmpsum(j,i)), 'HorizontalAlignment', 'Center','fontsize',16)
                                        end
                                    end
                                end        
                                text(0,-.065,['(Tot. #)'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',14,'interpreter','tex','color','k','units','normalized');        
                                text(.168,-.065,['(',num2str(identvals(1)),')'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',14,'interpreter','tex','color','k','units','normalized');
                                text(.5,-.065,['(',num2str(identvals(2)),')'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',14,'interpreter','tex','color','k','units','normalized');
                                text(.832,-.065,['(',num2str(identvals(3)),')'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',14,'interpreter','tex','color','k','units','normalized');        
                                text(.5,-.1,['Distance from Storm Center'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',22,'interpreter','tex','color','k','units','normalized');
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1; 
                                set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);
								filename=[identtrackint,'/sat_az_',identexpshort{exl}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                close all                
                            end        
                            valuescomp{exl}=tmp1;
                            denmapcomp{exl}=tmp1_den;
                            listcomp{exl}=tmp1;
                        end
                        if ~exist([identout,'RESULTS/',identfold,'VERIFICATION/OBS/'], 'dir')
                            mkdir([identout,'RESULTS/',identfold,'VERIFICATION/OBS/'])
                        end
                        identdroplist={identn identinnerdrops identgalesdrops identouterdrops};
                        save([identout,'RESULTS/',identfold,'VERIFICATION/OBS/',identn,'_sat.mat'],'identdroplist','identdropcyc','valuescomp','denmapcomp','listcomp','-v7.3')
                        close all
                        %% Track with Obs
                        for track=1:size(identexp,1)
                            clear l cntexp
                            spPos=[0.11 0.13 0.75 0.75]; % arrange plots the same
                            set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                            hfig=figure;
                            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                            ax1=subplot(3,4,[1:8]);
                            hold on
                            %load coastlines
                            for i=1:size(CATall,1)
                                if strcmp(CATall(i,:),'WV')==1 || strcmp(CATall(i,:),'EX')==1 || strcmp(CATall(i,:),'LO')==1 || strcmp(CATall(i,:),'DB')==1 || strcmp(CATall(i,:),'SD')==1 || strcmp(CATall(i,:),'SS')==1
                                    SPEEDall(i)=-1;
                                end
                            end         
                            h=fill([200,-200,-200,200],[-90,-90,90,90],[.5 .8 1]);
                            hold on;borders('countries','facecolor',[.9 .9 .9]);borders('continental us','k');
                            %geoshow('borders.shp','FaceColor',[0.9 0.9 0.9]);
                            %hold on
                            %states = shaperead('usastatehi', 'UseGeoCoords', true);
                            %geoshow(states,'FaceColor',[0.9 0.9 0.9]);
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
                                ylim([tmpminlat-15 tmpmaxlat+15])
                                y_dist=(tmpminlat-5)-(tmpmaxlat+5);
                                y_mean=((tmpminlat-5)+(tmpmaxlat+5))/2;
                            end
                            c_adj=cosd(y_mean);
                            c_dist=abs(x_dist*c_adj/2);
                            c_mid=x_mean;
                            xlim([c_mid-c_dist-15 c_mid+c_dist+15])
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
                                elseif SPEEDall(i) >= 113./1.94384 && SPEEDall(i) < 137./1.94384
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
                            text(0,1.065,['\textbf{Track, Classification, \& Potential ',identsatname,' Profiles}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                            text(1,1.065,['\textbf{',identexpshort{track},'}'],'color',identexpcolors(track,:),'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                            text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-5),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'bottom')
                            ax.LineWidth=1; 
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            hold on
                            plotdrops=[];
                            for i=1:size(alldropscomp,2)
								tmpd=alldropscomp{i};
								tmpp=tmpd{track};
								tmpp=tmpp{:};
								plotdrops=cat(1,plotdrops,tmpp);
                            end
                            latpd=plotdrops(:,2);
                            lonpd=plotdrops(:,1);
                            clear l lsz
                            if isempty(lonpd)==1
                                    l(1)=plot(-360,-360,'x','color',[.5 0 .6],'markersize',2);
                            else
                                    l(1)=plot(lonpd,latpd,'x','color',[.5 0 .6],'markersize',2);
                            end
                            text(0,1.03,['\textbf{DATES: ',DATEall(1,:),'$\mathbf{-}$',DATEall(end,:),' $\mid$ PP=',num2str(size(lonpd,1)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
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
                            l(11)=plot(-200,-100,'x','color',[.5 0 .6],'markersize',6);
                            legend off
                            lh=legend(l,'WV/DB/LO','SD/SS','EX','TD','TS','C1','C2','C3','C4','C5','Obs','orientation','vertical');
                            lh.FontSize=10;     
                            set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
                            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                            axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);
							filename=[identtrackint,'/',identn,'_track_withobs_',identexpshort{track}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                        end
                        clearvars -except identboxhist identconmetric identeps identmodelfhr identincludeobs identconvobs identserialcorr identbasinmodel identsatobs identgraphicssat identsatid identsatname identindivch identchannel identsatobs identindivstorm identcomposite identstormsdone identconvobssubtype identconvobscolors identconvobslegend identns* identnewsub* identgraphicsconv identgraphicsbycycle identconvid  ident* stormsdone yearsdone identdiff identremoveex identremoveinv identcycles identmaxfhr identlevels identexp identexpshort identexpsigimp identexpsigimpshort identexpcolors identscrub identgroot identout identconv
                    end
                end
                
