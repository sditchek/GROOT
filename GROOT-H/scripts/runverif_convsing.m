%% Since Basin-Scale, must get BT and common data for ALL storms run
                for drops=1
                    if identconv==1
                        clear identdrops;set(groot,'defaultAxesXTickLabelRotationMode','manual');set(groot,'defaultAxesYTickLabelRotationMode','manual');set(groot,'defaultAxesZTickLabelRotationMode','manual'); 
                        identinnerdrops=0;
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
								if identhwrfmodel==1;tmp=dir([identgroot,'obsall/',identexpshort{1},'/',identhwrf,'*',identinittimesunique(identloop,:),'*anl0*']);identdr=unique({tmp.name});
								elseif identhafsmodel==1;identdr=[];for filetypes=1:size(identconvid_filename,1);tmp=dir([identgroot,'obsall/',identexpshort{1},'/',identhwrf,'*',identconvid_filename{filetypes},'*',identinittimesunique(identloop,:),'*']);identdr00=unique({tmp.name});if isempty(identdr00)==1;else;identdr{filetypes}=identdr00{:};end;end;identdr=identdr';end;						
							else
								tmpt=[];
								for identloopcheck=1:size(identexpshort,1)
									if identhwrfmodel==1;tmp=dir([identgroot,'obsall/',identexpshort{identloopcheck},'/',identhwrf,'*',identinittimesunique(identloop,:),'*anl0*']);elseif identhafsmodel==1;identdr=[];for filetypes=1:size(identconvid_filename,1);tmp=dir([identgroot,'obsall/',identexpshort{1},'/',identhwrf,'*',identconvid_filename{filetypes},'*',identinittimesunique(identloop,:),'*']);identdr00=unique({tmp.name});identdr{filetypes}=identdr00{:};end;identdr=identdr';end;
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
                                    if strcmp(identdrops(end-27),'l')==1
                                        identdropsdat(i,:)=['al',identdrops(end-29:end-28)];
                                    elseif strcmp(identdrops(end-27),'e')==1
                                        identdropsdat(i,:)=['ep',identdrops(end-29:end-28)];
                                    elseif strcmp(identdrops(end-27),'w')==1
                                        identdropsdat(i,:)=['wp',identdrops(end-29:end-28)];
                                    elseif strcmp(identdrops(end-27),'c')==1
                                        identdropsdat(i,:)=['cp',identdrops(end-29:end-28)];
                                    end
                                    identbasin{i}=identdrops(1:end-27);
                                    identbasinname{i}=[upper(identdrops(end-29:end-27)),' (',upper(identdrops(1)),identdrops(2:end-30),')'];elseif identhafsmodel==1;identdropsdat=lower(ident(1:4));identbasin={identhwrf};identbasinname={[upper(identn(end-4:end-2)),' (',upper(identn(1)),lower(identn(2:end-5)),')']};end
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
                                % Get the conv for each storm/experiment
                                for j=1:size(identexp,1)
                                    for i=1:size(identdr,2)
                                    %% Initialize variables.
                                    if identhwrfmodel==1;filename=[identgroot,'obsall/',identexpshort{j},'/',identdr{i}];
                                    formatSpec = '%10C%9f%13f%16f%16f%16f%16f%f%[^\n\r]';
                                    fileID = fopen(filename,'r');
                                    dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string',  'ReturnOnError', false);
                                    fclose(fileID);
                                    drops = table(dataArray{1:end-1});
                                    clearvars filename formatSpec fileID dataArray ans;
                                    droplat=drops{:,4};
                                    droplon=drops{:,5};
                                    if strcmp(tcv_lonew(i),'W')==1
                                        droplon=360-droplon; droplon(droplon>360)=droplon(droplon>360)-360;% puts it into -180-180 coord without the sign
                                    else
                                        droplon=droplon; % leave it be
                                    end
                                    droppres=drops{:,6};
                                    dropdhr=drops{:,7};
                                    dropinc=drops{:,8};
                                    dropsubtype=drops{:,3};droptype=drops{:,2};elseif identhafsmodel==1;droptype=[];dropsubtype=[];droplat=[];droplon=[];droppres=[];dropdhr=[];dropinc=[];for filetype=1:size(identdr,1);filename=[identgroot,'obsall/',identexpshort{j},'/',identdr{filetype}];if isfile(filename)==1;ncid = netcdf.open(filename,'NC_NOWRITE');droptype00 = single(netcdf.getVar(ncid,2));dropsubtype00 = single(netcdf.getVar(ncid,3)).*identsubtypekeep(filetype); dropc=ismember(droptype00,identconvobstype(filetype));dropd=ismember(dropsubtype00,identconvobssubtype(filetype));drope=dropc+dropd;drope(drope==1)=0;drope(drope==2)=1;drope=logical(drope);droptype0 = single(netcdf.getVar(ncid,2)); droptype0=droptype0(drope);droptype=[droptype;droptype0];dropsubtype0 = single(netcdf.getVar(ncid,3)).*identsubtypekeep(filetype); dropsubtype0=dropsubtype0(drope);dropsubtype=[dropsubtype;dropsubtype0];droplat0 = netcdf.getVar(ncid,4);droplat0=droplat0(drope);droplat=[droplat;droplat0];droplon0 = netcdf.getVar(ncid,5); droplon0=droplon0(drope);droplon0(droplon0>=180)=droplon0(droplon0>=180)-360;droplon0=-1.*droplon0;droplon=[droplon;droplon0];droppres0 = netcdf.getVar(ncid,7); droppres0=droppres0(drope);droppres=[droppres;droppres0];dropdhr0 = netcdf.getVar(ncid,9); dropdhr0=dropdhr0(drope);dropdhr=[dropdhr;dropdhr0];dropinc0 = netcdf.getVar(ncid,netcdf.inqVarID(ncid,'Analysis_Use_Flag')); dropinc0=dropinc0(drope);dropinc=[dropinc;dropinc0];end;end;end;            
									% Add distance away from center at each pressure level
                                    if isnan(droplat)==1
                                        dropaz=NaN;
                                        dropan=NaN;
                                        xtob=NaN;
                                        ytob=NaN;
                                    elseif isempty(droplat)==1;dropaz=NaN;dropan=NaN;xtob=NaN;ytob=NaN;Observation_Class=NaN;droptype0 = NaN;dropsubtype = NaN;droplat = NaN;droplon = NaN;droppres = NaN;dropdhr = NaN;dropinc = NaN;droptype=NaN;else;
                                        for drp=1:size(droplat,1)
                                            xtob(drp)=round((RLON(i)+dropdhr(drp).*DDXDT(i))*10)/10;
                                            ytob(drp)=round((STMLAT(i)+dropdhr(drp).*DDYDT(i))*10)/10;
                                            if strcmp(tcv_lonew(i),'W')==1
                                                dropaz(drp)=abs(deg2km(distance('gc',ytob(drp),-1*xtob(drp),droplat(drp),-1*droplon(drp))));
                                                [droptmp(drp),dropan(drp)]=distance('gc',ytob(drp),-1*xtob(drp),droplat(drp),-1*droplon(drp));
                                            else
                                                dropaz(drp)=abs(deg2km(distance('gc',ytob(drp),xtob(drp),droplat(drp),droplon(drp))));
                                                [droptmp(drp),dropan(drp)]=distance('gc',ytob(drp),xtob(drp),droplat(drp),droplon(drp));
                                            end
                                        end
                                    end    
                                    % Make Full List
                                    if strcmp(tcv_lonew(i),'W')==1
                                        tmpdrops=[-1*droplon droplat droppres dropinc dropaz' dropan' -1*xtob' ytob' dropsubtype repmat(identloop,size(droplat,1),1) droptype];
                                        if j==size(identexp,1)
                                            RLON(i)=-1*RLON(i);
                                        end
                                    else
                                        tmpdrops=[droplon droplat droppres dropinc dropaz' dropan' xtob' ytob' dropsubtype repmat(identloop,size(droplat,1),1) droptype]; %% STOPPED HERE - MUST ADD IN COLUMN FOR DROPTYPE! ENSURE IT WORKS WITH HWRF TOO!
                                    end
                                    tmpdrops(tmpdrops(:,4)<=0)=NaN;
                                    tmpdrops(any(isnan(tmpdrops), 2), :) = [];                

                                    alldrops01{i}=tmpdrops;
                                    clear dropaz tmp tmpdrops dropan xtob ytob
                                    end
                                    alldrops{j}=alldrops01;
                                    clear alldrops01
                                end
                                % Generate Graphics or Fields for Later
                                if identgraphicsconv==1
                                    % Plot the basin-wide view of all conv for each experiment
                                    for loop1=1:size(identexp,1)
                                        spPos=[0.11 0.13 0.75 0.75]; % arrange plots the same
                                        set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                        hfig=figure;
                                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                        ax1=subplot(3,4,[1:8]);
                                        h=fill([360,-360,-360,360],[-90,-90,90,90],[.5 .8 1]);
                                        hold on
                                        geoshow('borders.shp','FaceColor',[0.9 0.9 0.9]);
                                        hold on
                                        states = shaperead('usastatehi', 'UseGeoCoords', true);
                                        geoshow(states,'FaceColor',[0.9 0.9 0.9]);                                      
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
                                                if size(identconvobssubtype,2)>1 % there are multiple types of conv obs!
                                                    for sot=1:size(identconvobssubtype,2)
                                                         l(sot)=plot(-360,-360,'o','markerfacecolor',identconvobscolors(sot,:),'markeredgecolor',identconvobscolors(sot,:),'markersize',2);
                                                         lsz(sot)=0;
                                                    end
                                                else % there is 1 type of conv obs!
                                                    l(1)=plot(-360,-360,'o','markerfacecolor','k','markersize',2,'markeredgecolor','k');
                                                end
                                            else                       
                                                if size(identconvobssubtype,2)>1 % there are multiple types of conv obs!
                                                    for sot=1:size(identconvobssubtype,2)
                                                         if size(alldrops0((alldrops0(:,9)==identconvobssubtype(sot) & alldrops0(:,11)==identconvobstype(sot)),1),1)==0; l(sot)=plot(-360,-360,'o','markerfacecolor',identconvobscolors(sot,:),'markeredgecolor',identconvobscolors(sot,:),'markersize',2); else;l(sot)=plot(alldrops0((alldrops0(:,9)==identconvobssubtype(sot) & alldrops0(:,11)==identconvobstype(sot)),1),alldrops0((alldrops0(:,9)==identconvobssubtype(sot) & alldrops0(:,11)==identconvobstype(sot)),2),'o','markerfacecolor',identconvobscolors(sot,:),'markeredgecolor',identconvobscolors(sot,:),'markersize',2);end;
                                                         lsz(sot)=size(alldrops0((alldrops0(:,9)==identconvobssubtype(sot) & alldrops0(:,11)==identconvobstype(sot)),1),1);
                                                    end
                                                else % there is 1 type of conv obs!
                                                    l(1)=plot(alldrops0(:,1),alldrops0(:,2),'o','markerfacecolor','k','markersize',2,'markeredgecolor','k');
                                                end
                                                numdrops=numdrops+size(alldrops0,1);
                                            end       
                                            lloop=identbasin{loop};
                                            text(RLON(loop),STMLAT(loop),upper(lloop(end-2:end)),'horizontalalignment','center','fontsize',10,'color',[.5 .5 .5])
                                        end
                                        if size(identconvobssubtype,2)>1
                                            for sot=1:size(identconvobssubtype,2)
                                                identlegendconv(sot)={[identconvobslegend{sot} ' (',num2str(lsz(sot)),')']};
                                            end
                                            l=legend(l,identlegendconv,'location','northeast');
                                        else
                                            l=legend(l,['Assimilated Observations'],'location','northeast');
                                        end
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
                                        text(0,1.055,['\textbf{INIT: ',identinittimesunique(identloop,:),' $\mid$ N=',num2str(numdrops),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                        text(0,1.11,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                        text(1,1.055,['\textbf{',identexpshort{loop1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(loop1,:),'units','normalized');
                                        ax=gca;
                                        box on
                                        set(ax, 'Layer', 'top')
                                        ax.LineWidth=1; 
                                        set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                        f = getframe(hfig);
										filename=[identtrackint,'/conv_basin_',identinittimesunique(identloop,:),'_',identexp{loop1}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                        close all
                                    end
                                    % Plot the location of all conv at all levels that are included, centered on storm
                                    for loop1=1:size(identexp,1)
                                        for loop=1:size(identdr,2)
                                            ttt=identdr{loop};
                                            if strcmp(ttt(1:end-27),identhwrf)==0 && identhafsmodel==0
                                            else
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
                                                xlabel('Longitude','fontsize',20)
                                                ylabel('Latitude','fontsize',20)                                   
                                                set(gca,'fontsize',20)
                                                fhr=1;
                                                axis([RLON(loop)-10 RLON(loop)+10 STMLAT(loop)-10 STMLAT(loop)+10])
                                                viscircles([RLON(loop) STMLAT(loop)],75/111.11,'Color',[.5 .5 .5 ],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                                viscircles([RLON(loop) STMLAT(loop)],250/111.11,'Color',[.5 .5 .5 ],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                                viscircles([RLON(loop) STMLAT(loop)],500/111.11,'Color',[.5 .5 .5 ],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                                viscircles([RLON(loop) STMLAT(loop)],1000/111.11,'Color',[.5 .5 .5 ],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                                hold on
                                                clear l
                                                plot(RLON(loop),STMLAT(loop),'o','markerfacecolor',[.5 .5 .5],'markersize',2,'markeredgecolor',[.5 .5 .5]);
                                                 alldrops0=alldrops{loop1};
                                                 alldrops0=alldrops0{loop};  
                                                 numdrops=0;
                                                 clear l lsz
                                                 if sum(~isnan(alldrops0(:)))==0
                                                     if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
                                                        for sot=1:size(identconvobssubtype,2)
                                                             l(sot)=plot(-360,-360,'o','markerfacecolor',identconvobscolors(sot,:),'markeredgecolor',identconvobscolors(sot,:),'markersize',2);
                                                             lsz(sot)=0;
                                                        end
                                                    else % there are no subtypes to this conventional bservation!
                                                        l(1)=plot(-360,-360,'o','markerfacecolor','k','markersize',2,'markeredgecolor','k');
                                                    end
                                                 else                        
                                                        if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
                                                            for sot=1:size(identconvobssubtype,2)
                                                                 if size(alldrops0((alldrops0(:,9)==identconvobssubtype(sot) & alldrops0(:,11)==identconvobstype(sot)),1),1)==0; l(sot)=plot(-360,-360,'o','markerfacecolor',identconvobscolors(sot,:),'markeredgecolor',identconvobscolors(sot,:),'markersize',2); else; l(sot)=plot(alldrops0((alldrops0(:,9)==identconvobssubtype(sot) & alldrops0(:,11)==identconvobstype(sot)),1),alldrops0((alldrops0(:,9)==identconvobssubtype(sot) & alldrops0(:,11)==identconvobstype(sot)),2),'o','markerfacecolor',identconvobscolors(sot,:),'markeredgecolor',identconvobscolors(sot,:),'markersize',2);end;
                                                                 lsz(sot)=size(alldrops0((alldrops0(:,9)==identconvobssubtype(sot) & alldrops0(:,11)==identconvobstype(sot)),1),1);
                                                            end
                                                        else % there are no subtypes to this conventional observation!
                                                            l(1)=plot(alldrops0(:,1),alldrops0(:,2),'o','markerfacecolor','k','markersize',2,'markeredgecolor','k');
                                                        end
                                                        numdrops=size(alldrops0,1);
                                                 end                      
                                                text(.5,.468,'75 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ])
                                                text(.5,.39,'250 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ])
                                                text(.5,.278,'500 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ])
                                                text(.5,.05,'1000 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ])
                                                if size(identconvobssubtype,2)>1
                                                    for sot=1:size(identconvobssubtype,2)
                                                        identlegendconv(sot)={[identconvobslegend{sot} ' (',num2str(lsz(sot)),')']};
                                                    end
                                                    l=legend(l,identlegendconv,'location','northeast');
                                                else
                                                    l=legend(l,['Assimilated Observations'],'location','northeast');
                                                end
                                                l.FontSize=10;
                                                hold off
                                                set(gca,'plotboxaspectratio',[1 1 1])
                                                set(gcf, 'InvertHardcopy', 'off')
                                                set(gcf,'Units','inches');
                                                screenposition = get(gcf,'Position');
                                                set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                                set(gcf, 'InvertHardcopy', 'off')
                                                text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,:),' $\mid$ N=',num2str(numdrops),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                text(1,1.03,['\textbf{',upper(identbasinname{loop}),'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                text(1,1.065,['\textbf{',identexpshort{loop1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(loop1,:),'units','normalized');                    
                                                ax=gca;
                                                box on
                                                set(ax, 'Layer', 'top')
                                                ax.LineWidth=1; 
                                                set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                                f = getframe(hfig);
												filename=[identtrackint,'/conv_plan_',identinittimesunique(identloop,:),'_',identexpshort{loop1}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                                close all 
                                                % Denmap for Subtypes
                                                if size(identconvobssubtype,2)>1
                                                    for sot=1:size(identconvobssubtype,2)
                                                         % Density Map
                                                         pall=squeeze(alldrops0((alldrops0(:,9)==identconvobssubtype(sot) & alldrops0(:,11)==identconvobstype(sot)),3,:));
                                                         dall=squeeze(alldrops0((alldrops0(:,9)==identconvobssubtype(sot) & alldrops0(:,11)==identconvobstype(sot)),5,:));                                
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
                                                        ylabel('Pressure (hPa)','fontsize',20)                                   
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
                                                        text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,:),' $\mid$ N=',num2str(sum(denmap(:))),'/',num2str(numdrops),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                        text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
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
                                                        f = getframe(hfig);
														filename=[identtrackint,'/conv_az_',identinittimesunique(identloop,:),'_',identexpshort{loop1},'_',erase(erase(identconvobslegend{sot}," "),"-")];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                                        close all
                                                        alldenmap_t(sot,loop1)={denmapall};
                                                    end                             
                                                end
                                                 % Full Density Map
                                                 pall=squeeze(alldrops0(:,3,:));
                                                 dall=squeeze(alldrops0(:,5,:));                                
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
                                                ylabel('Pressure (hPa)','fontsize',20)                                   
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
                                                text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,:),' $\mid$ N=',num2str(numdrops),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
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
                                                f = getframe(hfig);
												filename=[identtrackint,'/conv_az_',identinittimesunique(identloop,:),'_',identexpshort{loop1}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                                close all                                             
                                                 alldenmap(loop1)={denmapall}; 
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
                                         ttt=identdr{loop};
                                            if strcmp(ttt(1:end-27),identhwrf)==0  && identhafsmodel==0
                                            else
                                                 alldrops0=alldrops{loop1};
                                                 alldrops0=alldrops0{loop};  
                                                 numdrops=0;
                                                 if sum(~isnan(alldrops0(:)))==0
                                                 else                        
                                                     for drp=1:size(alldrops0,1)
                                                             %l(1)=plot(alldrops0(drp,1),alldrops0(drp,2),'o','markerfacecolor','k','markersize',2,'markeredgecolor','k');
                                                             numdrops=numdrops+1;
                                                     end
                                                 end
                                                %% Denmap for Subtypes
                                                if size(identconvobssubtype,2)>1
                                                    for sot=1:size(identconvobssubtype,2)
                                                         % Density Map
                                                         pall=squeeze(alldrops0((alldrops0(:,9)==identconvobssubtype(sot) & alldrops0(:,11)==identconvobstype(sot)),3,:));
                                                         dall=squeeze(alldrops0((alldrops0(:,9)==identconvobssubtype(sot) & alldrops0(:,11)==identconvobstype(sot)),5,:));                                
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
                                                         alldenmap_t(sot,loop1)={denmapall};
                                                    end                             
                                                end
                                                 %% Full Density Map
                                                 pall=squeeze(alldrops0(:,3,:));
                                                 dall=squeeze(alldrops0(:,5,:));                                
                                                 places=[];
                                                 denmapall=[];
                                                 for drp=1
                                                     % group pressures
                                                     data = pall(:,drp);
                                                     edges = 0:100:1100;
                                                     Y1 = discretize(data,edges);
                                                     % group radial bins
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
                                                 alldenmap(loop1)={denmapall}; 
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
                                if size(identconvobssubtype,2)>1
                                    alldenmapcomp_t{identloop}=alldenmap_t;                             
                                end
                            end
                            clear identdrops identdropsdat identbasin identbasinname alldrops alldenmap alldenmap_t l lsz a b c
                        end
                        identbasinnameall=unique(identbasinnameall);
                        %% Composite Basin-Scale                  
                        % Loop over all experiments
                        for exl=1:size(identexp,1)            
                            % Loop over all of the cycles
                            tmp1=[];
                            tmp1_den=[];
                            tmp1_den_t=[];
                            for cyc=1:size(alldropscomp,2)
                                tmp0_all=alldropscomp{cyc};
                                tmp0_lon=EXP_loncomp{cyc};
                                tmp0_lat=EXP_latcomp{cyc};
                                tmp0_name=EXP_namecomp{cyc};
                                tmp0_denmap=alldenmapcomp{cyc};
                                if size(identconvobssubtype,2)>1
                                    tmp0_denmap_t=alldenmapcomp_t{cyc};                             
                                end
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
                                    if size(identconvobssubtype,2)>1
                                        tmp3_denmap_t=tmp0_denmap_t(:,exl); 
                                    end
                                    tmp3_all=tmp2_all{i};

                                    if isempty(tmp3_all)==1
                                    else                                                
                                        tmp3_all(:,3)=repmat(tmp3_lon,size(tmp3_all,1),1);
                                        tmp3_all(:,4)=repmat(tmp3_lat,size(tmp3_all,1),1);
                                        tmp1=cat(1,tmp1,tmp3_all); % all storms for ALL experiment
                                        tmp1_den=cat(3,tmp1_den,tmp3_denmap);
                                        if size(identconvobssubtype,2)>1
                                            tmp1_den_t=cat(1,tmp1_den_t,tmp3_denmap_t');                             
                                        end
                                    end
                                end
                            end               
                            if isempty(tmp1)==1
                                identinnerdrops(exl)=0;
                                identgalesdrops(exl)=0;
                                identouterdrops(exl)=0;
                                identinnerdrops_t(:,exl)=0;
                                identgalesdrops_t(:,exl)=0;
                                identouterdrops_t(:,exl)=0;
                            else
                                if size(identconvobssubtype,2)>1
                                    for sot=1:size(identconvobssubtype,2)
                                        for soti=1:size(tmp1_den_t,1)
                                            tmp1_den_tt(:,:,soti)=tmp1_den_t{soti,sot};
                                        end
                                        t_t(sot,:)=sum(sum(tmp1_den_tt,1),3);
                                    end                        
                                    identinnerdrops_t(:,exl)=t_t(:,1);
                                    identgalesdrops_t(:,exl)=t_t(:,2);
                                    identouterdrops_t(:,exl)=t_t(:,3);                            
                                end
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
                                if isempty(tmp1)==1
                                    if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
                                        for sot=1:size(identconvobssubtype,2)
                                             counts=0;
                                             l(sot)=plot(0,5000,'.','markerfacecolor',identconvobscolors(sot,:),'markeredgecolor',identconvobscolors(sot,:));
                                             lsz(sot)=0;
                                        end
                                    else % there are no subtypes to this conventional bservation!
                                        counts=0;
                                        l(1)=plot(0,5000,'.k');
                                    end
                                else
                                    if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
                                        for sot=1:size(identconvobssubtype,2)
                                            [counts,centers]=hist(tmp1((tmp1(:,9)==identconvobssubtype(sot) & tmp1(:,11)==identconvobstype(sot)),5),[0:5:2000]);
                                            l(sot)=plot(centers,counts,'-','color',identconvobscolors(sot,:),'linewidth',2);            
                                            lsz(sot)=size(tmp1((tmp1(:,9)==identconvobssubtype(sot) & tmp1(:,11)==identconvobstype(sot)),1),1);
                                        end
                                    else % there are no subtypes to this conventional observation!
                                           [counts,centers]=hist(tmp1(:,5),[0:5:2000]);
                                            l(1)=plot(centers,counts,'-k','linewidth',2);            
                                    end
                                end
                                xlim([-.5 2000])
                                if exl==1
                                    ymaxallbasin=round(max(counts)/100)*100+50;
                                end
                                ylim([0 ymaxallbasin])
                                if size(identconvobssubtype,2)>1
                                        for sot=1:size(identconvobssubtype,2)
                                            identlegendconv(sot)={[identconvobslegend{sot} ' (',num2str(lsz(sot)),')']};
                                        end
                                        ll=legend(l,identlegendconv,'location','northeast');
                                else
                                        ll=legend(l,['Assimilated Observations'],'location','northeast');
                                end
                                ll.FontSize=10;
                                ylabel('Number of Assimilated Observations','fontsize',20)                                   
                                xlabel('Radius (km)','fontsize',20)                                   
                                set(gca,'fontsize',20)
                                grid on
                                set(gca,'xtick',0:250:2000)
                                set(gcf, 'InvertHardcopy', 'off')
                                set(gcf,'Units','inches');
                                screenposition = get(gcf,'Position');
                                set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                set(gcf, 'InvertHardcopy', 'off')                       
                                text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),' $\mid$ N=',num2str(size(tmp1,1)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-5),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                                text(1,1.065,['\textbf{',identexpshort{exl},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(exl,:),'units','normalized');                    
                                ax=gca;
                                set(gca,'Color',[.9 .9 .9])
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1; 
                                set(gca,'position',[spPos(1)+.035 spPos(2)+.015 spPos(3) spPos(4)-.02])
                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                f = getframe(hfig);
								filename=[identtrackint,'/',identn,'_convcomp_hist_',identexpshort{exl}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
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
                                    if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
                                        for sot=1:size(identconvobssubtype,2)
                                             l(sot)=polarplot(0,5000,'.','markerfacecolor',identconvobscolors(sot,:),'markeredgecolor',identconvobscolors(sot,:));
                                             lsz(sot)=0;
                                        end
                                    else % there are no subtypes to this conventional bservation!
                                        l(1)=polarplot(0,5000,'.k');
                                    end
                                else
                                    if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
                                        for sot=1:size(identconvobssubtype,2)
                                            if size(tmp1((tmp1(:,9)==identconvobssubtype(sot) & tmp1(:,11)==identconvobstype(sot)),1),1)==0;l(sot)=polarplot(0,5000,'.','markerfacecolor',identconvobscolors(sot,:),'markeredgecolor',identconvobscolors(sot,:));else;l(sot)=polarplot(tmp1((tmp1(:,9)==identconvobssubtype(sot) & tmp1(:,11)==identconvobstype(sot)),6)*pi/180,tmp1((tmp1(:,9)==identconvobssubtype(sot) & tmp1(:,11)==identconvobstype(sot)),5),'.','color',identconvobscolors(sot,:));end;
                                            lsz(sot)=size(tmp1((tmp1(:,9)==identconvobssubtype(sot) & tmp1(:,11)==identconvobstype(sot)),1),1);
                                        end
                                    else % there are no subtypes to this conventional bservation!
                                            l(1)=polarplot(tmp1(:,6)*pi/180,tmp1(:,5),'.k');
                                    end
                                end

                                if size(identconvobssubtype,2)>1
                                        for sot=1:size(identconvobssubtype,2)
                                            identlegendconv(sot)={[identconvobslegend{sot} ' (',num2str(lsz(sot)),')']};
                                        end
                                        ll=legend(l,identlegendconv,'location','northeast');
                                else
                                        ll=legend(l,['Assimilated Observations'],'location','northeast');
                                end
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
                                text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),' $\mid$ N=',num2str(size(tmp1,1)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-5),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                                text(1,1.065,['\textbf{',identexpshort{exl},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(exl,:),'units','normalized');                    
                                ax=gca;
                                set(gca,'Color',[.9 .9 .9])
                                set(ax, 'Layer', 'top')
                                ax1.LineWidth=1; 
                                set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window                    
                                f = getframe(hfig);                    
								filename=[identtrackint,'/',identn,'_convcomp_plan_',identexpshort{exl}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                close all 
                                %% Denmap for Subtypes  
                                if size(identconvobssubtype,2)>1
                                    for sot=1:size(identconvobssubtype,2)
                                        clear tmp1_den_tt
                                        if isempty(tmp1_den_t)==1
                                            tmp1_den_tt=zeros(11,3);
                                        else
                                            for soti=1:size(tmp1_den_t,1)
                                                tmp1_den_tt(:,:,soti)=tmp1_den_t{soti,sot};
                                            end
                                        end                            
                                        set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                        hfig=figure;
                                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                        ax1=subplot(3,4,[1:8]);  
                                        identvals=sum(sum(tmp1_den_tt,1),3);
                                        imagesc(sum(tmp1_den_tt,3))
                                        xlabel('','fontsize',20)
                                        ylabel('Pressure (hPa)','fontsize',20)                                   
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
                                        text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),' $\mid$ N=',num2str(sum(identvals(:))),'/',num2str(size(tmp1,1)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                        text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                        text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-5),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                                        text(1,1.065,['\textbf{',identexpshort{exl},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(exl,:),'units','normalized');                    
                                        tmpsum=sum(tmp1_den_tt,3);                
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
                                        f = getframe(hfig);
										filename=[identtrackint,'/',identn,'_convcomp_az_',identexpshort{exl},'_',erase(erase(identconvobslegend{sot}," "),"-")];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                        close all 
                                    end
                                end
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
                                ylabel('Pressure (hPa)','fontsize',20)                                   
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
                                text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),' $\mid$ N=',num2str(size(tmp1,1)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
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
                                f = getframe(hfig);
								filename=[identtrackint,'/',identn,'_convcomp_az_',identexpshort{exl}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                close all                
                            end        
                            valuescomp{exl}=tmp1;
                            denmapcomp{exl}=tmp1_den;
                            listcomp{exl}=tmp1;
                            if size(identconvobssubtype,2)>1
                                denmapcomp_t{exl}=tmp1_den_t;
                            end
                        end
                        if ~exist([identout,'RESULTS/',identfold,'VERIFICATION/OBS/'], 'dir')
                            mkdir([identout,'RESULTS/',identfold,'VERIFICATION/OBS/'])
                        end
                        if size(identconvobssubtype,2)>1
                            identdroplist={identn identinnerdrops identgalesdrops identouterdrops identinnerdrops_t identgalesdrops_t identouterdrops_t};
                            save([identout,'RESULTS/',identfold,'VERIFICATION/OBS/',upper(identhwrf),identn(end-1:end),'_conv.mat'],'identdroplist','identdropcyc','valuescomp','denmapcomp','denmapcomp_t','listcomp','-v7.3')
                        else
                            identdroplist={identn identinnerdrops identgalesdrops identouterdrops};
                            save([identout,'RESULTS/',identfold,'VERIFICATION/OBS/',upper(identhwrf),identn(end-1:end),'_conv.mat'],'identdroplist','identdropcyc','valuescomp','denmapcomp','listcomp','-v7.3')
                        end            
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
                            text(0,1.065,['\textbf{Track, Classification, \& Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
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
                            if isempty(latpd)==1
                                    if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
                                        for sot=1:size(identconvobssubtype,2)
                                             l(sot)=plot(-360,-360,'x','color',identconvobscolors(sot,:),'markersize',2);
                                             lsz(sot)=0;
                                        end
                                    else % there are no subtypes to this conventional bservation!
                                        l(1)=plot(-360,-360,'x','color',[.5 0 .6],'markersize',2);
                                    end
                            else
                                if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
                                    for sot=1:size(identconvobssubtype,2)
                                         if size(lonpd((plotdrops(:,9)==identconvobssubtype(sot) & plotdrops(:,11)==identconvobstype(sot)),1),1)==0;l(sot)=plot(-360,-360,'x','color',identconvobscolors(sot,:),'markersize',2);else;l(sot)=plot(lonpd((plotdrops(:,9)==identconvobssubtype(sot) & plotdrops(:,11)==identconvobstype(sot))),latpd((plotdrops(:,9)==identconvobssubtype(sot) & plotdrops(:,11)==identconvobstype(sot))),'x','color',identconvobscolors(sot,:),'markersize',2);end;
                                         lsz(sot)=size(lonpd((plotdrops(:,9)==identconvobssubtype(sot) & plotdrops(:,11)==identconvobstype(sot)),1),1);
                                    end
                                else % there are no subtypes to this conventional bservation!
                                    l(1)=plot(lonpd,latpd,'x','color',[.5 0 .6],'markersize',2);
                                end
                            end
                            text(0,1.03,['\textbf{DATES: ',DATEall(1,:),'$\mathbf{-}$',DATEall(end,:),' $\mid$ N=',num2str(size(lonpd,1)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
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
                            if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
                                for sot=1:size(identconvobssubtype,2)
                                     l(10+sot)=plot(-200,-100,'x','color',identconvobscolors(sot,:),'markersize',6);
                                end
                                for sot=1:size(identconvobssubtype,2)
                                    identlegendconv(sot)={[identconvobslegend{sot} ' (',num2str(lsz(sot)),')']};
                                end
                                lh=legend(l,'WV/DB/LO','SD/SS','EX','TD','TS','C1','C2','C3','C4','C5',identlegendconv{:},'orientation','vertical');
                            else % there are no subtypes to this conventional bservation!
                                  l(11)=plot(-200,-100,'x','color',[.5 0 .6],'markersize',6);
                                legend off
                                lh=legend(l,'WV/DB/LO','SD/SS','EX','TD','TS','C1','C2','C3','C4','C5','Obs','orientation','vertical');
                            end
                            lh.FontSize=10;     
                            set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
                            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                            f = getframe(hfig);
							filename=[identtrackint,'/',identn,'_track_withobs_',identexpshort{track}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                        end
                        clearvars -except identconmetric identeps identmodelfhr identincludeobs identconvobs identserialcorr identbasinmodel identsatobs identgraphicssat identsatid identsatname identindivch identchannel identindivstorm identcomposite identstormsdone identconvobssubtype identconvobscolors identconvobslegend identns* identnewsub* identgraphicsconv identgraphicsbycycle identconvid  ident* stormsdone yearsdone identdiff identremoveex identremoveinv identcycles identmaxfhr identlevels identexp identexpshort identexpsigimp identexpsigimpshort identexpcolors identscrub identgroot identout identconv
                    end
                end             
