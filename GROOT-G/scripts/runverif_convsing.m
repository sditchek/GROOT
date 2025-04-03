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
			identdr=dir([identgroot,'tcvitals/','*',identinittimesunique(identloop,:),'.storm_vit']);
			identdr=unique({identdr.name});
			if isempty(identdr)==1
				%identinittimesunique(identloop,:)=[];
				if exist('RLON2','var')==0																					alldenmap=repmat({nan(11,3)},1,size(identexp,1)); 
					RLON2=NaN;
					STMLAT2=NaN;
					identbasinname2={[]};
					alldrops2=repmat({{nan(0,9)}},1,size(identexp,1));alldrops3=repmat({{nan(0,9)}},1,size(identexp,1));
					alldenmap_t=repmat({nan(11,3)},size(identconvtype,2),size(identexp,1));
				end
				EXP_loncomp{identloop}=RLON2;
				EXP_latcomp{identloop}=STMLAT2;
				EXP_namecomp{identloop}=identbasinname2;
				alldropscomp{identloop}=alldrops2;alldropscomp3{identloop}=alldrops3;
				alldenmapcomp{identloop}=alldenmap;            
				if size(identconvtype,2)>1
					alldenmapcomp_t{identloop}=alldenmap_t;                             
				end
			else
				for i=1:size(identdr,2)
					identdrops=identdr{i};                                    
					identbasinname{i}=identdrops(1:3);
					if strcmp(identdrops(3),'L')==1
						identdropsdat(i,:)=['AL',identdrops(1:2)];
					elseif strcmp(identdrops(3),'E')==1
						identdropsdat(i,:)=['EP',identdrops(1:2)];
					elseif strcmp(identdrops(3),'W')==1
						identdropsdat(i,:)=['WP',identdrops(1:2)];
					elseif strcmp(identdrops(3),'C')==1
						identdropsdat(i,:)=['CP',identdrops(1:2)];
					elseif strcmp(identdrops(3),'A')==1 || strcmp(identdrops(3),'B')==1
						identdropsdat(i,:)=['IO',identdrops(1:2)];
					elseif strcmp(identdrops(3),'Q')==1
						identdropsdat(i,:)=['LS',identdrops(1:2)];
					elseif strcmp(identdrops(3),'S')==1 || strcmp(identdrops(3),'P')==1
						identdropsdat(i,:)=['SH',identdrops(1:2)];	
					end
				end
				identbasin=identbasinname;
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
										filename=[identgroot,identexpshort{j},'/anl/diag_conv_',lower(identconvid),'_anl.',identinittimesunique(identloop,:),'.nc4'];
										if isfile(filename)==1
											ncid = netcdf.open(filename,'NC_NOWRITE');
											droptype0 = single(netcdf.getVar(ncid,2)); 
											Observation_Class=strtrim(netcdf.getVar(ncid,1)');Observation_Class=Observation_Class(droptype0==identconvobs);
											droptype = single(netcdf.getVar(ncid,3)); droptype=droptype(droptype0==identconvobs);
											droplat = netcdf.getVar(ncid,4); droplat=droplat(droptype0==identconvobs);
											droplon = netcdf.getVar(ncid,5); droplon=droplon(droptype0==identconvobs);
											droppres = netcdf.getVar(ncid,7); droppres=droppres(droptype0==identconvobs);
											dropdhr = netcdf.getVar(ncid,9); dropdhr=dropdhr(droptype0==identconvobs);
											dropinc = (netcdf.getVar(ncid,netcdf.inqVarID(ncid,'Prep_Use_Flag'))+netcdf.getVar(ncid,netcdf.inqVarID(ncid,'Analysis_Use_Flag'))); dropinc=dropinc(droptype0==identconvobs);
											droplon(droplon>=180)=droplon(droplon>=180)-360; % puts it into -180-180 coord without the sign
										else
											filename=[identgroot,identexpshort{j},'/anl/diag_conv_anl.',identinittimesunique(identloop,:),'.',lower(identconvid),'.latlon.txt'];
											Observation_Class=NaN;
											droptype0 = NaN;
											droptype = NaN;
											droplat = NaN;
											droplon = NaN;
											droppres = NaN;
											dropdhr = NaN;
											dropinc = NaN;
										end
										% Add distance away from center at each pressure level
										if isnan(droplat)==1
											dropaz=NaN;
											dropan=NaN;
											xtob=NaN;
											ytob=NaN;
											tmpdrops=[droplon droplat droppres dropinc dropaz dropan xtob ytob droptype];
											tmpdrops_stm=[droplon droplat droppres dropinc dropaz dropan xtob ytob droptype];
										else
											xtob=round((RLON(i)+dropdhr.*DDXDT(i))*10)/10;
											ytob=round((STMLAT(i)+dropdhr.*DDYDT(i))*10)/10;
											if strcmp(tcv_lonew(i),'W')==1
												xtob=-1*xtob;
											end
											dropaz=abs(deg2km(distance('gc',ytob,xtob,droplat,droplon)));
											[droptmp,dropan]=distance('gc',ytob,xtob,droplat,droplon);
											tmpdrops=[droplon droplat droppres dropinc dropaz dropan xtob ytob droptype];
											tmpdrops_stm=[droplon(dropaz<2000) droplat(dropaz<2000) droppres(dropaz<2000) dropinc(dropaz<2000) dropaz(dropaz<2000) dropan(dropaz<2000) xtob(dropaz<2000) ytob(dropaz<2000) droptype(dropaz<2000)];
										end  
										% Make Full List
										if strcmp(tcv_lonew(i),'W')==1
											if j==size(identexp,1)
												RLON(i)=-1*RLON(i);
											end
										end
										if ~isempty(tmpdrops); tmpdrops(tmpdrops(:,4)~=identincludeobs)=NaN; end;
										tmpdrops(any(isnan(tmpdrops), 2), :) = [];                
										alldrops01{i}=tmpdrops;
										if ~isempty(tmpdrops_stm); tmpdrops_stm(tmpdrops_stm(:,4)~=identincludeobs)=NaN; end;
										tmpdrops_stm(any(isnan(tmpdrops_stm), 2), :) = [];                
										alldrops01_stm{i}=tmpdrops_stm;
										clear dropaz tmp tmpdrops tmpdrops_stm dropan xtob ytob
									end
										alldrops{j}=alldrops01;
										alldrops_stm{j}=alldrops01_stm;
										clear alldrops01_stm
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
                                        clear l lsz; if isempty(identdr)==1;loopfix=1;else;loopfix=size(identdr,2);end;
                                        for loop=1:loopfix
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
                                                    l(1)=plot(-360,-360,'o','markerfacecolor','k','markersize',2,'markeredgecolor','k');lsz=0;
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
                                        if size(identconvobssubtype,2)>1 && strcmp(pwd,'/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-AOMLMV')==0
                                            for sot=1:size(identconvobssubtype,2)
                                                identlegendconv(sot)={[identconvobslegend{sot} ' (',num2str(lsz(sot)),')']};
                                            end
                                            l=legend(l,identlegendconv,'location','northeast');l.FontSize=8;l.ItemTokenSize=[10 10];
                                        elseif size(identconvobssubtype,2)>1 && strcmp(pwd,'/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-AOMLMV')==1;lsz=numdrops;else;
                                            l=legend(l,['Assimilated Observations'],'location','northeast');lsz=numdrops;l.FontSize=8;l.ItemTokenSize=[10 10];
                                        end
                                        %l.FontSize=8;l.ItemTokenSize=[10 10];
                                        hold off                        
                                        set(gca,'xtick',-180:60:180)
                                        set(gca,'ytick',-90:30:90)
                                        set(gca,'plotboxaspectratio',[1 1 1])
                                        set(gcf, 'InvertHardcopy', 'off')
                                        set(gcf,'Units','inches');
                                        screenposition = get(gcf,'Position');
                                        set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                        set(gcf, 'InvertHardcopy', 'off')
                                        text(0,1.055,['\textbf{INIT: ',identinittimesunique(identloop,:),' $\mid$ N=',num2str(sum(lsz)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                        text(0,1.11,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                        text(1,1.055,['\textbf{',identexpshort{loop1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(loop1,:),'units','normalized');
                                        ax=gca;
                                        box on
                                        set(ax, 'Layer', 'top')
                                        ax.LineWidth=1; 
                                        set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                        axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);
										filename=[identtrackint,'/conv_basin_',identinittimesunique(identloop,:),'_',identexp{loop1}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                        close all
                                    end
                                    % Plot the location of all conv at all levels that are included, centered on storm
                                    for loop1=1:size(identexp,1);if isempty(identdr)==1;loopfix=1;else;loopfix=size(identdr,2);end;
                                        for loop=1:loopfix
											if identhafsmodel==0;ttt=identdr{loop};else;ttt='nopenopenopenopenopenope';end;alldrops0=alldrops{loop1};alldrops0=alldrops0{loop};alldrops3{loop1}={alldrops0};
                                            if strcmp(ttt(1:3),upper(identhwrf(end-2:end)))==0 && identhafsmodel==0
                                            else
                                                set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                                hfig=figure;
                                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                                ax1=subplot(3,4,[1:8]);
                                                h=fill([200,-200,-200,200],[-90,-90,90,90],[.5 .8 1]);
                                                hold on;borders('countries','facecolor',[.9 .9 .9]);borders('continental us','k');
                                                %geoshow('borders.shp','FaceColor',[0.9 0.9 0.9]);
                                                %hold on
                                                %states = shaperead('usastatehi', 'UseGeoCoords', true);
                                                %geoshow(states,'FaceColor',[0.9 0.9 0.9]);
                                                xlabel('Longitude','fontsize',20)
                                                ylabel('Latitude','fontsize',20)                                   
                                                set(gca,'fontsize',20)
                                                fhr=1;
                                                if identhafsmodel==1;axis([RLON(loop)-7 RLON(loop)+7 STMLAT(loop)-7 STMLAT(loop)+7]);else;axis([RLON(loop)-10 RLON(loop)+10 STMLAT(loop)-10 STMLAT(loop)+10]);end;
                                                viscircles([RLON(loop) STMLAT(loop)],75/111.11,'Color',[.5 .5 .5 ],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                                viscircles([RLON(loop) STMLAT(loop)],250/111.11,'Color',[.5 .5 .5 ],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                                viscircles([RLON(loop) STMLAT(loop)],500/111.11,'Color',[.5 .5 .5 ],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);viscircles([RLON(loop) STMLAT(loop)],750/111.11,'Color',[.5 .5 .5 ],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                                viscircles([RLON(loop) STMLAT(loop)],1000/111.11,'Color',[.5 .5 .5 ],'linewidth',.5,'linestyle','--','EnhanceVisibility',0);
                                                hold on
                                                clear l
                                                plot(RLON(loop),STMLAT(loop),'o','markerfacecolor',[.5 .5 .5],'markersize',2,'markeredgecolor',[.5 .5 .5]);
alldrops0=alldrops_stm{loop1};
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
                                                        l(1)=plot(-360,-360,'o','markerfacecolor','k','markersize',2,'markeredgecolor','k');lsz=0;
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
                                                if identhafsmodel==1;text(.5,.48,'75 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ]);else; text(.5,.468,'75 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ]);end;
                                                if identhafsmodel==1;text(.5,.36,'250 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ]);else;text(.5,.39,'250 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ]);end;
                                                if identhafsmodel==1;text(.5,.2,'500 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ]); text(.5,.04,'750 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ]);else;text(.5,.278,'500 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ]);end;
                                                if identhafsmodel==1;else;text(.5,.05,'1000 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ]);end;
                                                if size(identconvobssubtype,2)>1 && strcmp(pwd,'/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-AOMLMV')==0
                                                    for sot=1:size(identconvobssubtype,2)
                                                        identlegendconv(sot)={[identconvobslegend{sot} ' (',num2str(lsz(sot)),')']};
                                                    end
                                                    l=legend(l,identlegendconv,'location','northeast');l.FontSize=8;l.ItemTokenSize=[10 10];
                                                elseif size(identconvobssubtype,2)>1 && strcmp(pwd,'/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-AOMLMV')==1;lsz=numdrops;else;
                                                    l=legend(l,['Assimilated Observations'],'location','northeast');lsz=numdrops;l.FontSize=8;l.ItemTokenSize=[10 10];
                                                end
                                                %l.FontSize=8;l.ItemTokenSize=[10 10];
                                                hold off
                                                set(gca,'plotboxaspectratio',[1 1 1])
                                                set(gcf, 'InvertHardcopy', 'off')
                                                set(gcf,'Units','inches');
                                                screenposition = get(gcf,'Position');
                                                set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                                set(gcf, 'InvertHardcopy', 'off')
                                                text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,:),' $\mid$ N=',num2str(numdrops),' $\mid$ R$<$2000 km}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                text(1,1.03,['\textbf{',upper(identbasinname{loop}),'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                text(1,1.065,['\textbf{',identexpshort{loop1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(loop1,:),'units','normalized');                    
                                                ax=gca;
                                                box on
                                                set(ax, 'Layer', 'top')
                                                ax.LineWidth=1; 
                                                set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                                axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);
												filename=[identtrackint,'/conv_plan_',identinittimesunique(identloop,:),'_',identexpshort{loop1}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                                close all;if size(identconvobssubtype,2)>1;clear l lsz;spPos=[0.11 0.13 0.75 0.75];set(0,'defaultfigurecolor',[1 1 1]);hfig=figure;set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);ax1=subplot(3,4,[1:8]);set(gca,'plotboxaspectratio',[1 1 1]);box on;set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)]);set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]);hold on;if isempty(alldrops0)==1;if size(identconvobssubtype,2)>1;for sot=1:size(identconvobssubtype,2);counts=0;lsz(sot)=0;ylim([0 1]);end;else;counts=0;lsz=0;ylim([0 1]);end;else;if size(identconvobssubtype,2)>1; for sot=1:size(identconvobssubtype,2);lsz(sot)=size(alldrops0((alldrops0(:,9)==identconvobssubtype(sot) & alldrops0(:,11)==identconvobstype(sot)),1),1);end;else; lsz=size(alldrops0,1);end;end;b=bar(lsz);b.FaceColor = 'flat';cnt=1;for i=1:size(lsz,2);if lsz(i)==0;cnt=cnt+1;else;b.CData(i,:) =  identconvobscolors(cnt,:);cnt=cnt+1;end;end;ylabel('Number of Assimilated Observations','fontsize',20);ax=gca;ax.YGrid = 'on';ax.YMinorGrid='on';ax.GridAlpha=0.35;ax.YAxis.Exponent = 0;set(gca,'xtick',1:1:50);xlim([0.5 size(lsz,2)+.5]);if strcmp(identconvid,'Recon') && strcmp(pwd,'/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-AOMLMV');set(gca,'xticklabel',{'T','Q','UV','SPD','P3','G-IV','T','Q','UV'});ax.XAxis.FontSize = 18;text(.165,-.062,['HDOBS'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');text(.385,-.062,['SFMR'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');text(.55,-.062,['TDR'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');text(.83,-.062,['DROPS'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');elseif strcmp(identconvid,'Recon+') && strcmp(pwd,'/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-AOMLMV');set(gca,'xticklabel',{'UV','RW','T','Q','UV','SPD','P3','G-IV','T','Q','UV'});ax.XAxis.FontSize = 18;text(.095,-.062,['OTHER'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');text(.32,-.062,['HDOBS'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');text(.5,-.062,['SFMR'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');text(.64,-.062,['TDR'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');text(.87,-.062,['DROPS'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');elseif strcmp(identconvid,'Conv+Recon') && strcmp(pwd,'/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-AOMLMV');set(gca,'xticklabel',{'S','NS','S','NS','S','NS','88D','T','Q','UV','SPD','P3','G-IV','T','Q','UV'});ax.XAxis.FontSize = 15;annotation('line',[.479 .479],[.02 .875]);text(.06,-.055,['UV'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');text(.19,-.055,['TQ'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');text(.28,-.055,['P'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');text(.345,-.055,['RO'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');text(.41,-.055,['RW'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized'); 
												text(.53,-.055,['HDOBS'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');text(.65,-.055,['SFMR'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');text(.75,-.055,['TDR'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');text(.9,-.055,['DROPS'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');text(.7,-.1,['RECON'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');text(.22,-.1,['CONV'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');else;set(gca,'xticklabel',upper(identconvobslegend));xtickangle(45);ax.XAxis.FontSize = 18;end;ax.YAxis.FontSize = 20;set(gca,'TickLength',[0 0]);set(gcf, 'InvertHardcopy', 'off');set(gcf,'Units','inches');screenposition = get(gcf,'Position');set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);set(gcf, 'InvertHardcopy', 'off');text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,:),' $\mid$ N=',num2str(sum(lsz)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');text(1,1.03,['\textbf{',upper(identbasinname{loop}),'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');text(1,1.065,['\textbf{',identexpshort{loop1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(loop1,:),'units','normalized');set(gca,'Color',[.9 .9 .9]);ax.LineWidth=1;set(gca,'position',[spPos(1)+.035 spPos(2)+.015 spPos(3) spPos(4)-.02]);set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]);axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);filename=[identtrackint,'/conv_bar_',identinittimesunique(identloop,:),'_',identexpshort{loop1}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;close all;end;
												for histdrops=1;for yy=1:2;clear l lsz;spPos=[0.11 0.13 0.75 0.75];set(0,'defaultfigurecolor',[1 1 1]);hfig=figure;set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);ax1=subplot(3,4,[1:8]);set(gca,'plotboxaspectratio',[1 1 1]);box on;set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)]);set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]);hold on;if isempty(alldrops0)==1;if size(identconvobssubtype,2)>1;for sot=1:size(identconvobssubtype,2);counts=0;counts_tally=0;l(sot)=plot(0,5000,'.','markerfacecolor',identconvobscolors(sot,:),'markeredgecolor',identconvobscolors(sot,:));lsz(sot)=0;end;else;counts=0;l(1)=plot(0,5000,'.k');counts_tally=0;lsz=0;end;else;if size(identconvobssubtype,2)>1;for sot=1:size(identconvobssubtype,2);[counts,centers]=hist(alldrops0((alldrops0(:,9)==identconvobssubtype(sot) & alldrops0(:,11)==identconvobstype(sot)),5),[0:5:2000]);counts_tally(sot)=max(counts);l(sot)=plot(centers,counts,'-','color',identconvobscolors(sot,:),'linewidth',2);lsz(sot)=size(alldrops0((alldrops0(:,9)==identconvobssubtype(sot) & alldrops0(:,11)==identconvobstype(sot)),1),1);end;else;[counts,centers]=hist(alldrops0(:,5),[0:5:2000]);counts_tally=max(counts);l(1)=plot(centers,counts,'-k','linewidth',2);end;end;if identhafsmodel==1;xlim([-0.5 1000]);else;xlim([-.5 2000]);end;if loop1==1;ymaxallbasin=max(round(ceil(counts_tally+100),-2));clear counts_tally;end;if isempty(alldrops0)==1;ylim([0 1]);else;ylim([0 ymaxallbasin]);end;if size(identconvobssubtype,2)>1 && strcmp(pwd,'/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-AOMLMV')==0;for sot=1:size(identconvobssubtype,2);identlegendconv(sot)={[identconvobslegend{sot} ' (',num2str(lsz(sot)),')']};end;ll=legend(l,identlegendconv,'location','northeast');ll.FontSize=8;ll.ItemTokenSize=[10 10];elseif size(identconvobssubtype,2)>1 && strcmp(pwd,'/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-AOMLMV')==1;lsz=size(alldrops0,1);else;ll=legend(l,['Assimilated Observations'],'location','northeast');lsz=size(alldrops0,1);ll.FontSize=8;ll.ItemTokenSize=[10 10];end;ylabel('Number of Assimilated Observations','fontsize',20);xlabel('Radius (km)','fontsize',20);set(gca,'fontsize',20);grid on;if identhafsmodel==1;set(gca,'xtick',0:100:2000);else;set(gca,'xtick',0:250:2000);end;set(gcf, 'InvertHardcopy', 'off');set(gcf,'Units','inches');screenposition = get(gcf,'Position');set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);set(gcf, 'InvertHardcopy', 'off');text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,:),' $\mid$ N=',num2str(sum(lsz)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');text(1,1.03,['\textbf{',upper(identbasinname{loop}),'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized');text(1,1.065,['\textbf{',identexpshort{loop1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(loop1,:),'units','normalized');ax=gca;set(gca,'Color',[.9 .9 .9]);set(ax, 'Layer', 'top');ax.LineWidth=1;ax.XGrid='on';ax.XMinorGrid='on';ax.GridAlpha=0.35;set(gca,'position',[spPos(1)+.035 spPos(2)+.015 spPos(3) spPos(4)-.02]);set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]);axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');
												if yy==1;set(gca,'yscale','log');yyscale='log';elseif yy==2;set(gca,'yscale','linear');yyscale='linear';end;f = getframe(hfig);filename=[identtrackint,'/conv_hist_',identinittimesunique(identloop,:),'_',identexpshort{loop1},'_',yyscale];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;close all;end;end;if size(identconvobssubtype,2)>1 % denmap for subtypes
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
                                                                     denmap(places0(i,1),places0(i,2))=sum([denmap(places0(i,1),places0(i,2)),1],'omitnan');
                                                                 end
                                                             end
                                                             denmapall=denmap;
                                                         end
                                                         denmapall(isnan(denmapall))=0;                
                                                         denmap=nan(11,3);
                                                         denmap=sum(denmapall,3,'omitnan');                
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
                                                        if max(max(denmap))>100000;caxis([0 100000]);colcut=5000*4;elseif max(max(denmap))>50000;caxis([0 50000]);colcut=2500*4;elseif max(max(denmap))>25000;caxis([0 25000]);colcut=1250*4;elseif max(max(denmap))>10000;caxis([0 10000]);colcut=500*4;elseif max(max(denmap))>5000;caxis([0 5000]);colcut=250*4;elseif max(max(denmap))>2500;caxis([0 2500]);colcut=125*4;elseif max(max(denmap))>1000;caxis([0 1000]);colcut=50*4;else;caxis([0 250]);colcut=12.5*4;end
                                                        if loop1==1;cmax=caxis;cmax0(sot)=cmax(2);colcut0(sot)=colcut;end;colormap(flipud(gray(20)));caxis([0 cmax0(sot)]);
                                                        set(gca, 'YGrid', 'on', 'XGrid', 'off')
                                                        hold on
                                                        plot(repmat(1.5,1,13),0:12,'k')
                                                        plot(repmat(2.5,1,13),0:12,'k')
                                                        set(gca,'plotboxaspectratio',[1 1 1])
                                                        set(gcf, 'InvertHardcopy', 'off')
                                                        set(gcf,'Units','inches');
                                                        screenposition = get(gcf,'Position');
                                                        set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                                        text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,:),' $\mid$ N=',num2str(sum(denmap(:))),'/',num2str(numdrops),' $\mid$ R$<$2000 km}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                        text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,:),' $\mid$ N=',num2str(sum(denmap(:))),'/',num2str(numdrops),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                        text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                        text(1,1.03,['\textbf{',upper(identbasinname{loop}),'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                        text(1,1.065,['\textbf{',identexpshort{loop1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(loop1,:),'units','normalized');
                                                        for i=1:3
                                                            for j=1:11
                                                                if denmap(j,i)>=colcut0(sot)
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
														filename=[identtrackint,'/conv_az_',identinittimesunique(identloop,:),'_',identexpshort{loop1},'_',erase(erase(identconvobslegend{sot}," "),"-")];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                                        close all
                                                        alldenmap_t(sot,loop1)={denmapall};
                                                    end                             
                                                end
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
                                                             denmap(places0(i,1),places0(i,2))=sum([denmap(places0(i,1),places0(i,2)),1],'omitnan');
                                                         end
                                                     end
                                                     denmapall=denmap;
                                                 end
                                                 denmapall(isnan(denmapall))=0;                
                                                 denmap=nan(11,3);
                                                 denmap=sum(denmapall,3,'omitnan');                
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
                                                if max(max(denmap))>100000;caxis([0 100000]);colcut=5000*4;elseif max(max(denmap))>50000;caxis([0 50000]);colcut=2500*4;elseif max(max(denmap))>25000;caxis([0 25000]);colcut=1250*4;elseif max(max(denmap))>10000;caxis([0 10000]);colcut=500*4;elseif max(max(denmap))>5000;caxis([0 5000]);colcut=250*4;elseif max(max(denmap))>2500;caxis([0 2500]);colcut=125*4;elseif max(max(denmap))>1000;caxis([0 1000]);colcut=50*4;else;caxis([0 250]);colcut=12.5*4;end;
                                                if loop1==1;cmax=caxis;cmax00=cmax(2);colcut00=colcut;end;colormap(flipud(gray(20)));caxis([0 cmax00]);colormap(flipud(gray(20)))
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
                                                text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,:),' $\mid$ N=',num2str(numdrops),' $\mid$ R$<$2000 km}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                text(1,1.03,['\textbf{',upper(identbasinname{loop}),'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                                text(1,1.065,['\textbf{',identexpshort{loop1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(loop1,:),'units','normalized');
                                                for i=1:3
                                                    for j=1:11
                                                        if denmap(j,i)>=colcut00
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
                                    for loop1=1:size(identexp,1);if isempty(identdr)==1;loopfix=1;else;loopfix=size(identdr,2);end;
                                        for loop=1:loopfix
											if identhafsmodel==0;ttt=identdr{loop};else;ttt='nopenopenopenopenopenope';end;alldrops0=alldrops{loop1};alldrops0=alldrops0{loop};alldrops3{loop1}={alldrops0};
                                            if strcmp(ttt(1:3),upper(identhwrf(end-2:end)))==0  && identhafsmodel==0
                                            else
alldrops0=alldrops_stm{loop1};
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
                                                                     denmap(places0(i,1),places0(i,2))=sum([denmap(places0(i,1),places0(i,2)),1],'omitnan');
                                                                 end
                                                             end
                                                             denmapall=denmap;
                                                         end
                                                         denmapall(isnan(denmapall))=0;                
                                                         denmap=nan(11,3);
                                                         denmap=sum(denmapall,3,'omitnan');                                                       
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
                                                             denmap(places0(i,1),places0(i,2))=sum([denmap(places0(i,1),places0(i,2)),1],'omitnan');
                                                         end
                                                     end
                                                     denmapall=denmap;
                                                 end
                                                 denmapall(isnan(denmapall))=0;                
                                                 denmap=nan(11,3);
                                                 denmap=sum(denmapall,3,'omitnan');                       
                                                 alldenmap(loop1)={denmapall}; 
                                                 RLON2=RLON(loop);
                                                 STMLAT2=STMLAT(loop);
                                                 identbasinname2={identbasinname{loop}};
                                                 alldrops2{loop1}={alldrops0};
                                            end
                                        end
                                    end
                                end
								if exist('RLON2','var')==0																								
									alldenmap=repmat({nan(11,3)},1,size(identexp,1)); 
									RLON2=NaN;
									STMLAT2=NaN;
									identbasinname2={[]};
									alldrops2=repmat({{nan(0,9)}},1,size(identexp,1));
									alldenmap_t=repmat({nan(11,3)},size(identconvtype,2),size(identexp,1));
								end
								EXP_loncomp{identloop}=RLON2;
								EXP_latcomp{identloop}=STMLAT2;
								EXP_namecomp{identloop}=identbasinname2;
								alldropscomp{identloop}=alldrops2;alldropscomp3{identloop}=alldrops3;
								alldenmapcomp{identloop}=alldenmap;            
								if size(identconvtype,2)>1
									alldenmapcomp_t{identloop}=alldenmap_t;                             
								end
                            end
                            clear RLON2 STMLAT2 identbasinname2 alldrops2 alldenmap alldenmap_t identdrops identdropsdat identbasin identbasinname alldrops alldenmap alldenmap_t l lsz alldrops3
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
                                tmp0_all=alldropscomp{cyc};tmp0_obs=alldropscomp3{cyc};
                                tmp0_lon=EXP_loncomp{cyc};
                                tmp0_lat=EXP_latcomp{cyc};
                                tmp0_name=EXP_namecomp{cyc};
                                tmp0_denmap=alldenmapcomp{cyc};
                                if size(identconvobssubtype,2)>1
                                    tmp0_denmap_t=alldenmapcomp_t{cyc};                             
                                end
                                tmp2_all=tmp0_all{exl};
                                cycleswithdrops=tmp0_all{1};cycleswithobs=tmp0_obs{1};if isempty(cycleswithobs{:})==1 identobscyc(cyc)=0; else identobscyc(cyc)=1; end
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
                                for yy=1:2;spPos=[0.11 0.13 0.75 0.75]; % arrange plots the same
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
                                             counts=0;counts_tally=0;
                                             l(sot)=plot(0,5000,'.','markerfacecolor',identconvobscolors(sot,:),'markeredgecolor',identconvobscolors(sot,:));
                                             lsz(sot)=0;
                                        end
                                    else % there are no subtypes to this conventional bservation!
                                        counts=0;counts_tally=0;
                                        l(1)=plot(0,5000,'.k');lsz=0;
                                    end
                                else
                                    if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
                                        for sot=1:size(identconvobssubtype,2)
                                            [counts,centers]=hist(tmp1((tmp1(:,9)==identconvobssubtype(sot) & tmp1(:,11)==identconvobstype(sot)),5),[0:5:2000]);counts_tally(sot)=max(counts);											
                                            l(sot)=plot(centers,counts,'-','color',identconvobscolors(sot,:),'linewidth',2);            
                                            lsz(sot)=size(tmp1((tmp1(:,9)==identconvobssubtype(sot) & tmp1(:,11)==identconvobstype(sot)),1),1);
                                        end
                                    else % there are no subtypes to this conventional observation!
                                           [counts,centers]=hist(tmp1(:,5),[0:5:2000]);counts_tally=max(counts);
                                            l(1)=plot(centers,counts,'-k','linewidth',2);            
                                    end
                                end
                                if identhafsmodel==1;xlim([-0.5 1000]);else;xlim([-.5 2000]);end;
                                if exl==1
                                    ymaxallbasin=max(round(ceil(counts_tally+100),-2));clear counts_tally;
                                end
                                ylim([0 ymaxallbasin])
                                if size(identconvobssubtype,2)>1 && strcmp(pwd,'/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-AOMLMV')==0
                                        for sot=1:size(identconvobssubtype,2)
                                            identlegendconv(sot)={[identconvobslegend{sot} ' (',num2str(lsz(sot)),')']};
                                        end
                                        ll=legend(l,identlegendconv,'location','northeast');ll.FontSize=8;ll.ItemTokenSize=[10 10];
                                elseif size(identconvobssubtype,2)>1 && strcmp(pwd,'/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-AOMLMV')==1;lsz=size(tmp1,1);else;
                                        ll=legend(l,['Assimilated Observations'],'location','northeast');lsz=size(tmp1,1);ll.FontSize=8;ll.ItemTokenSize=[10 10];
                                end
                                %ll.FontSize=8;ll.ItemTokenSize=[10 10];
                                ylabel('Number of Assimilated Observations','fontsize',20)                                   
                                xlabel('Radius (km)','fontsize',20)                                   
                                set(gca,'fontsize',20)
                                grid on
                                if identhafsmodel==1;set(gca,'xtick',0:100:2000);else;set(gca,'xtick',0:250:2000);end;
                                set(gcf, 'InvertHardcopy', 'off')
                                set(gcf,'Units','inches');
                                screenposition = get(gcf,'Position');
                                set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                set(gcf, 'InvertHardcopy', 'off')                       
                                text(0,1.025,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),' $\mid$ N=',num2str(size(tmp1,1)),' $\mid$ R$<$2000 km}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',10,'fontweight','bold','interpreter','latex','units','normalized')
                                text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-5),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                                text(1,1.065,['\textbf{',identexpshort{exl},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(exl,:),'units','normalized');                    
                                ax=gca;
                                set(gca,'Color',[.9 .9 .9])
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;ax.XGrid='on';ax.XMinorGrid='on';ax.GridAlpha=0.35;
                                set(gca,'position',[spPos(1)+.035 spPos(2)+.015 spPos(3) spPos(4)-.02])
                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');
								if yy==1;set(gca,'yscale','log');yyscale='log';elseif yy==2;set(gca,'yscale','linear');yyscale='linear';end;f = getframe(hfig);filename=[identtrackint,'/',identn,'_convcomp_hist_',identexpshort{exl},'_',yyscale];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                close all;end;    
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
                                        l(1)=polarplot(0,5000,'.k');lsz=0;
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

                                if size(identconvobssubtype,2)>1 && strcmp(pwd,'/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-AOMLMV')==0
                                        for sot=1:size(identconvobssubtype,2)
                                            identlegendconv(sot)={[identconvobslegend{sot} ' (',num2str(lsz(sot)),')']};
                                        end
                                        ll=legend(l,identlegendconv,'location','northeast');ll.FontSize=8;ll.ItemTokenSize=[10 10];
                                elseif size(identconvobssubtype,2)>1 && strcmp(pwd,'/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-AOMLMV')==1;lsz=size(tmp1,1);else;
                                        ll=legend(l,['Assimilated Observations'],'location','northeast');lsz=size(tmp1,1);ll.FontSize=8;ll.ItemTokenSize=[10 10];
                                end
                                %ll.FontSize=8;ll.ItemTokenSize=[10 10];
                                ax1.ThetaDir = 'clockwise';
                                ax1.ThetaZeroLocation = 'top';
                                if identhafsmodel==1;ax1.RLim=[0 1100];else;ax1.RLim=[0 1600];end;
                                ax1.ThetaTick = [];
                                if identhafsmodel==1;rticks([75 250 500 1000]);else;rticks([75 250 500 1000 1500]);end;
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
                                if identhafsmodel==1;text(.5,.468,'75 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ]);else;text(.5,.484,'75 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5]);end;
                                if identhafsmodel==1;text(.5,.39,'250 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ]);else;text(.5,.426,'250 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5]);end;
                                if identhafsmodel==1;text(.5,.278,'500 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ]);else;text(.5,.347,'500 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5]);end;
                                if identhafsmodel==1;text(.5,.05,'1000 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5 ]);else;text(.5,.19,'1000 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5]);end;
                                if identhafsmodel==1;else;text(.5,.034,'1500 km','HorizontalAlignment','center','VerticalAlignment','top','fontsize',10,'units','normalized','color',[.5 .5 .5]);end;
                                text(0,1.025,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),' $\mid$ N=',num2str(size(tmp1,1)),' $\mid$ R$<$2000 km}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',10,'fontweight','bold','interpreter','latex','units','normalized')
                                text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-5),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                                text(1,1.065,['\textbf{',identexpshort{exl},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(exl,:),'units','normalized');                    
                                ax=gca;
                                set(gca,'Color',[.9 .9 .9])
                                set(ax, 'Layer', 'top')
                                ax1.LineWidth=1; 
                                set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window                    
                                axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);                    
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
                                        if max(tmp1_den(:))>100000;caxis([0 100000]);colcut=5000*4;elseif max(tmp1_den(:))>50000;caxis([0 50000]);colcut=2500*4;elseif max(tmp1_den(:))>25000;caxis([0 25000]);colcut=1250*4;elseif max(tmp1_den(:))>10000;caxis([0 10000]);colcut=500*4;elseif max(tmp1_den(:))>5000;caxis([0 5000]);colcut=250*4;elseif max(tmp1_den(:))>2500;caxis([0 2500]);colcut=125*4;elseif max(tmp1_den(:))>1000;caxis([0 1000]);colcut=50*4;else;caxis([0 250]);colcut=12.5*4;end;
                                        if exl==1;cmax=caxis;cmax0(sot)=cmax(2);colcut0(sot)=colcut;end;colormap(flipud(gray(20)));caxis([0 cmax0(sot)]);colormap(flipud(gray(20)))
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
                                        text(0,1.025,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),' $\mid$ N=',num2str(sum(identvals(:))),'/',num2str(size(tmp1,1)),' $\mid$ R$<$2000 km}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',10,'fontweight','bold','interpreter','latex','units','normalized')
                                        text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                        text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-5),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                                        text(1,1.065,['\textbf{',identexpshort{exl},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(exl,:),'units','normalized');                    
                                        tmpsum=sum(tmp1_den_tt,3);                
                                        for i=1:3
                                            for j=1:11
                                                if tmpsum(j,i)>=colcut0(sot)
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
                                if max(max((sum(tmp1_den,3))))>100000;caxis([0 100000]);colcut=5000*4;elseif max(max((sum(tmp1_den,3))))>50000;caxis([0 50000]);colcut=2500*4;elseif max(max((sum(tmp1_den,3))))>25000;caxis([0 25000]);colcut=1250*4;elseif max(max((sum(tmp1_den,3))))>10000;caxis([0 10000]);colcut=500*4;elseif max(max((sum(tmp1_den,3))))>5000;caxis([0 5000]);colcut=250*4;elseif max(max((sum(tmp1_den,3))))>2500;caxis([0 2500]);colcut=125*4;elseif max(max((sum(tmp1_den,3))))>1000;caxis([0 1000]);colcut=50*4;else;caxis([0 250]);colcut=12.5*4;end;
                                if exl==1;cmax=caxis;cmax00=cmax(2);colcut00=colcut;end;colormap(flipud(gray(20)));caxis([0 cmax00]);colormap(flipud(gray(20)));
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
                                text(0,1.025,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),' $\mid$ N=',num2str(size(tmp1,1)),' $\mid$ R$<$2000 km}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',10,'fontweight','bold','interpreter','latex','units','normalized')
                                text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-5),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                                text(1,1.065,['\textbf{',identexpshort{exl},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(exl,:),'units','normalized');                    
                                tmpsum=sum(tmp1_den,3);                
                                for i=1:3
                                    for j=1:11
                                        if tmpsum(j,i)>=colcut00
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
                            save([identout,'RESULTS/',identfold,'VERIFICATION/OBS/',upper(identhwrf),identn(end-1:end),'_conv.mat'],'identdroplist','identdropcyc','identobscyc','valuescomp','denmapcomp','listcomp','-v7.3')
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
									if SPEEDall(i) > 0 && SPEEDall(i) < 34./1.94384 && strcmp(CATall(i,:),'TD')==1 
										plot(LONall(i),LATall(i),'.','color',azavcm(2,:),'markersize',12);            
									elseif SPEEDall(i) >= 34./1.94384 && SPEEDall(i) < 64./1.94384 && strcmp(CATall(i,:),'TS')==1
										plot(LONall(i),LATall(i),'.','color',azavcm(3,:),'markersize',12);            
									elseif SPEEDall(i) >= 64./1.94384 && SPEEDall(i) < 83./1.94384 && strcmp(CATall(i,:),'HU')==1 
										plot(LONall(i),LATall(i),'.','color',azavcm(4,:),'markersize',12);            
									elseif SPEEDall(i) >= 83./1.94384 && SPEEDall(i) < 96./1.94384  && strcmp(CATall(i,:),'HU')==1
										plot(LONall(i),LATall(i),'.','color',azavcm(5,:),'markersize',12);            
									elseif SPEEDall(i) >= 96./1.94384 && SPEEDall(i) < 113./1.94384  && strcmp(CATall(i,:),'HU')==1
										plot(LONall(i),LATall(i),'.','color',azavcm(6,:),'markersize',12);            
									elseif SPEEDall(i) >= 113./1.94384 && SPEEDall(i) < 137./1.94384  && strcmp(CATall(i,:),'HU')==1
										plot(LONall(i),LATall(i),'.','color',azavcm(7,:),'markersize',12);           
									elseif SPEEDall(i) >= 137./1.94384 && strcmp(CATall(i,:),'HU')==1
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
                                        l(1)=plot(-360,-360,'x','color',[.5 0 .6],'markersize',2);lsz=0;
                                    end
                            else
                                if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
                                    for sot=1:size(identconvobssubtype,2)
                                         if size(lonpd((plotdrops(:,9)==identconvobssubtype(sot) & plotdrops(:,11)==identconvobstype(sot)),1),1)==0;l(sot)=plot(-360,-360,'x','color',identconvobscolors(sot,:),'markersize',2);else;l(sot)=plot(lonpd((plotdrops(:,9)==identconvobssubtype(sot) & plotdrops(:,11)==identconvobstype(sot))),latpd((plotdrops(:,9)==identconvobssubtype(sot) & plotdrops(:,11)==identconvobstype(sot))),'x','color',identconvobscolors(sot,:),'markersize',2);end;
                                         lsz(sot)=size(lonpd((plotdrops(:,9)==identconvobssubtype(sot) & plotdrops(:,11)==identconvobstype(sot)),1),1);
                                    end
                                else % there are no subtypes to this conventional bservation!
                                    l(1)=plot(lonpd,latpd,'x','color',[.5 0 .6],'markersize',2);lsz=size(lonpd,1);
                                end
                            end
                            text(0,1.025,['\textbf{DATES: ',DATEall(1,:),'$\mathbf{-}$',DATEall(end,:),' $\mid$ N=',num2str(size(lonpd,1)),' $\mid$ R$<$2000 km}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',10,'fontweight','bold','interpreter','latex','units','normalized')
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
                            if size(identconvobssubtype,2)>1 && strcmp(pwd,'/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-AOMLMV')==0% there are subtypes to this conventional observation!
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
                            lh.FontSize=9;lh.ItemTokenSize=[10 10];   
                            set(gca,'position',[spPos(1)+.02 spPos(2)+.05 spPos(3) spPos(4)])
                            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                            axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);
							filename=[identtrackint,'/',identn,'_track_withobs_',identexpshort{track}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                        end
                        %% Bar Graph to show how many of each variable
						for exl=1:size(identexp,1);if size(identconvobssubtype,2)>1
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
							% Legend
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
										 lsz(sot)=0;
									end
								else % there are no subtypes to this conventional bservation!
									counts=0;
									lsz=0;
								end
							else
								if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
									for sot=1:size(identconvobssubtype,2)
										lsz(sot)=size(tmp1((tmp1(:,9)==identconvobssubtype(sot) & tmp1(:,11)==identconvobstype(sot)),1),1);
									end
								else % there are no subtypes to this conventional observation!
									   lsz=size(tmp1,1)           
								end
							end
							b=bar(lsz);
							b.FaceColor = 'flat';
							cnt=1;
							for i=1:size(lsz,2)
								if lsz(i)==0;cnt=cnt+1;
								else	
									b.CData(i,:) =  identconvobscolors(cnt,:);
									cnt=cnt+1;
								end
							end
							%text(.5,-.11,['Assimilated Reconnaissance Data'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',20,'interpreter','tex','color','k','units','normalized');
							ylabel('Number of Assimilated Observations','fontsize',20)                                   
							%set(gca,'fontsize',20)
							ax=gca;
							ax.YGrid = 'on';
							ax.YMinorGrid='on';
							ax.GridAlpha=0.35	
							ax.YAxis.Exponent = 0;
							set(gca,'xtick',1:1:50)
							xlim([0.5 size(lsz,2)+.5]);if exl==1;fixyaxis=axis;fixyaxis0=fixyaxis(4);end;ylim([0 fixyaxis0]);
							if strcmp(identconvid,'Recon') && strcmp(pwd,'/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-AOMLMV')
								set(gca,'xticklabel',{'T','Q','UV','SPD','P3','G-IV','T','Q','UV'});ax.XAxis.FontSize = 18;
								text(.165,-.062,['HDOBS'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');        
								text(.385,-.062,['SFMR'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');
								text(.55,-.062,['TDR'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');
								text(.83,-.062,['DROPS'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');
							elseif strcmp(identconvid,'Recon+') && strcmp(pwd,'/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-AOMLMV')
								set(gca,'xticklabel',{'UV','RW','T','Q','UV','SPD','P3','G-IV','T','Q','UV'});ax.XAxis.FontSize = 18;
								text(.095,-.062,['OTHER'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');        
								text(.32,-.062,['HDOBS'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');        
								text(.5,-.062,['SFMR'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');
								text(.64,-.062,['TDR'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');
								text(.87,-.062,['DROPS'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',18,'interpreter','tex','color','k','units','normalized');
							elseif strcmp(identconvid,'Conv+Recon') && strcmp(pwd,'/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-AOMLMV')
								set(gca,'xticklabel',{'S','NS','S','NS','S','NS','88D','T','Q','UV','SPD','P3','G-IV','T','Q','UV'});ax.XAxis.FontSize = 15;annotation('line',[.479 .479],[.02 .875]);
								text(.06,-.055,['UV'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');        
								text(.19,-.055,['TQ'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');        
								text(.28,-.055,['P'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');        
								text(.345,-.055,['RO'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');        
								text(.41,-.055,['RW'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');        
								text(.53,-.055,['HDOBS'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');        
								text(.65,-.055,['SFMR'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');
								text(.75,-.055,['TDR'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');
								text(.9,-.055,['DROPS'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');
								text(.7,-.1,['RECON'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');
								text(.22,-.1,['CONV'],'HorizontalAlignment','center','VerticalAlignment','top','fontsize',15,'interpreter','tex','color','k','units','normalized');
							else
								set(gca,'xticklabel',upper(identconvobslegend))	
								xtickangle(45);ax.XAxis.FontSize = 18;		
							end					
							ax.YAxis.FontSize = 20;
							set(gca,'TickLength',[0 0])
							set(gcf, 'InvertHardcopy', 'off')
							set(gcf,'Units','inches');
							screenposition = get(gcf,'Position');
							set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
							set(gcf, 'InvertHardcopy', 'off') 
							text(0,1.03,['\textbf{INIT: ',identinittimesunique(1,:),'$\mathbf{-}$',identinittimesunique(end,:),' $\mid$ N=',num2str(sum(lsz)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
							text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
							text(1,1.03,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-5),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');
							text(1,1.065,['\textbf{',identexpshort{exl},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(exl,:),'units','normalized');                    
							set(gca,'Color',[.9 .9 .9])
							%set(ax, 'Layer', 'top')
							ax.LineWidth=1; 
							set(gca,'position',[spPos(1)+.035 spPos(2)+.015 spPos(3) spPos(4)-.02])
							set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
							axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);
							filename=[identtrackint,'/',identn,'_barcomp_',identexpshort{exl}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
							close all    
						end;end
						%% Cycle-By-Cycle to show how many of each variable
                        for exl=1:size(identexp,1) 
                            for cyc=1:size(alldropscomp,2)
                                tmp0_all=alldropscomp{cyc};                                
                                tmp2_all=tmp0_all{exl};                               
                                for i=1:size(tmp2_all,2)                                   
                                    tmp3_all=tmp2_all{i};
									clear lsz
									if isempty(tmp3_all)==1
										if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
											for sot=1:size(identconvobssubtype,2)
												 counts=0;
												 lsz(sot)=0;
											end
										else % there are no subtypes to this conventional bservation!
											counts=0;
											lsz=0;
										end
									else
										if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
											for sot=1:size(identconvobssubtype,2)
												lsz(sot)=size(tmp3_all((tmp3_all(:,9)==identconvobssubtype(sot) & tmp3_all(:,11)==identconvobstype(sot)),1),1);
											end
										else % there are no subtypes to this conventional observation!
											   lsz=size(tmp3_all,1)           
										end
									end
									aomlmvlsz(cyc,:)=lsz;
                                end
                            end  
							set(0,'defaultfigurecolor',[1 1 1]) % figure background color
							hfig=figure;
							set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
							ax1=subplot(3,4,[1:8]);
							b=barh(aomlmvlsz,'stacked','FaceColor','flat'); % stacks values in each row together
							for i=1:size(identconvobscolors,1)											
								b(i).CData= identconvobscolors(i,:);										
							end
							xlabel('Number of Assimilated Observations','fontsize',14)        
							set(gca,'fontsize',14)
							box on									
							set(gca,'fontsize',14)
							hold on                        
							ylabel('Cycle Initialization Time','fontsize',14)
							box on
							xstart=1;          
							ylim([xstart-.5 size(identinittimesunique,1)+.5])                                                   
							if size(identinittimesunique,1)>50
								set(gca,'ytick',1:4:100)
								set(gca,'yticklabel',identinittimesunique(1:4:end,:))
							else
								set(gca,'ytick',1:2:100)
								set(gca,'yticklabel',identinittimesunique(1:2:end,:))
							end                           
							set(gca,'fontsize',14)
							cnt=1;    
							set(gcf, 'InvertHardcopy', 'off')
							set(gcf,'Units','inches');
							screenposition = get(gcf,'Position');
							set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
							set(gcf, 'InvertHardcopy', 'off')																
							set(gca,'TickLength',[0 0])										
							text(1,1.052,['\textbf{',identexpshort{exl},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(exl,:),'units','normalized');
							text(1,1.025,['\textbf{',upper(identhwrf(end-2:end)),' (',identn(1:end-5),')}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color','k','units','normalized');                
							text(0,1.052,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')                                        
							%lh=legend(identlegendconv,'location','northeast');									
							%lh.FontSize=10;lh.ItemTokenSize=[10 10];								
							if strcmp(identconvid,'Recon')
								set(gca,'xtick',0:5000:100000000)
							else
								if max((sum(aomlmvlsz,2)))>1000000;set(gca,'xtick',0:100000:100000000);elseif max((sum(aomlmvlsz,2)))>100000;set(gca,'xtick',0:10000:100000000);elseif max((sum(aomlmvlsz,2)))>10000;set(gca,'xtick',0:1000:100000000);elseif max((sum(aomlmvlsz,2)))>1000;set(gca,'xtick',0:100:100000000);elseif max((sum(aomlmvlsz,2)))>100;set(gca,'xtick',0:10:100000000);end;
							end
							tmpuv = sum(sum(aomlmvlsz,2)>0);                               
							tmpphrase=[num2str(tmpuv),'/',num2str(size(identinittimesunique,1))];                    
							text(0,1.025,['\textbf{CYCLES: ',tmpphrase,' $\mid$ N=',num2str(sum(aomlmvlsz(:))),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
							set(gca,'Color',[.9 .9 .9])
							axis ij
							ax=gca;
							ax.XGrid='on';
							ax.XMinorGrid='on';
							ax.GridAlpha=0.35
							ax.XAxis.Exponent = 0;if exl==1;fixxaxis=axis;fixxaxis0=fixxaxis(2);end;xlim([0 fixxaxis0]);
							box on
							set(ax, 'Layer', 'bottom')
							ax.LineWidth=1; 
							pos=get(gca,'Position');
							set(gca,'position',[pos(1)+.01 pos(2)-.33 pos(3) pos(4)+.34])
							set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .9, 0.96]); % maximize figure window
							axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);
							filename=[identtrackint,'/',identn,'_reconcontr_',identexpshort{exl}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
							close all   
						end 
						clearvars -except identboxhist identconmetric identeps identmodelfhr identincludeobs identconvobs identserialcorr identbasinmodel identsatobs identgraphicssat identsatid identsatname identindivch identchannel identindivstorm identcomposite identstormsdone identconvobssubtype identconvobscolors identconvobslegend identns* identnewsub* identgraphicsconv identgraphicsbycycle identconvid  ident* stormsdone yearsdone identdiff identremoveex identremoveinv identcycles identmaxfhr identlevels identexp identexpshort identexpsigimp identexpsigimpshort identexpcolors identscrub identgroot identout identconv
                    end
                end
