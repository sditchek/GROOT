%% Conventional Obs Composite - all and by year, if multiple years present
            if identconv==1;[a,b,c]=unique(identconvobscolors,'rows','stable');identconvid_filename=identconvid_filename(b);identconvobscolors=identconvobscolors(b,:);identconvobslegend=identconvobslegend(b);identconvobssubtype=identconvobssubtype(b);identconvobstype=1001:1001+size(identconvobssubtype,2);identsubtypekeep=identsubtypekeep(b);             
                if size(unique(yearsdone,'rows'),1)==1
                    convyear=size(unique(yearsdone,'rows'),1);
                else
                    convyear=size(unique(yearsdone,'rows'),1)+1;
                end;set(groot,'defaultAxesXTickLabelRotationMode','manual');set(groot,'defaultAxesYTickLabelRotationMode','manual');set(groot,'defaultAxesZTickLabelRotationMode','manual'); 
                for yrlp=1:convyear
                    if yrlp==1
                    else
                       yrlpa=unique(yearsdone,'rows');
                       curyear=yrlpa(yrlp-1,:);
                       curyearcut=curyear(3:4);
                    end    
					 
                    for j=1:size(identexp,1) 
                        if yrlp==1
                            identdr=dir([identout,'RESULTS/',identfold,'VERIFICATION/OBS/*.mat']);
                        else
                            identdr=dir([identout,'RESULTS/',identfold,'VERIFICATION/OBS/*',curyearcut,'_*.mat']);
                        end
                        identdr={identdr.name};
                        compvalues=[];
                        compdenmap=[];
                        compdenmap_t=[];
                        compinner=zeros(1,size(identexp,1));
                        compgale=zeros(1,size(identexp,1));
                        compouter=zeros(1,size(identexp,1));
                        compinner_t=zeros(1,size(identexp,1));
                        compgale_t=zeros(1,size(identexp,1));
                        compouter_t=zeros(1,size(identexp,1));
                        for i=1:size(identdr,2)
                            load([identout,'RESULTS/',identfold,'VERIFICATION/OBS/',identdr{i}])
                            identdroplist{:}
                            presum=valuescomp{j};
                            presum=sum(presum,3);
                            compvalues=cat(1,compvalues,presum);

                            if size(identconvobssubtype,2)>1
                                compdenmap_t=cat(1,compdenmap_t,denmapcomp_t{j});
                                compinner_t=identdroplist{5}+compinner_t;
                                compgale_t=identdroplist{6}+compgale_t;
                                compouter_t=identdroplist{7}+compouter_t;
                            end

                            if sum(sum(denmapcomp{j}))==0
                            else
                                compdenmap=cat(3,compdenmap,denmapcomp{j});
                            end
                            compinner=identdroplist{2}+compinner;
                            compgale=identdroplist{3}+compgale;
                            compouter=identdroplist{4}+compouter;
                        end

                        % Histogram Composite Graphic
                        for yy=1:2;spPos=[0.11 0.13+.05 0.75 0.75-.05]; % arrange plots the same
                        set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                        hfig=figure;
                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                        ax1=subplot(3,4,[1:8]);
                        set(gca,'plotboxaspectratio',[1 1 1])
                        box on
                        set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                        hold on
                        if isempty(compvalues)==1
                            if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
                                for sot=1:size(identconvobssubtype,2)
                                     l(sot)=plot(0,5000,'.','markerfacecolor',identconvobscolors(sot,:),'markeredgecolor',identconvobscolors(sot,:));
                                     lsz(sot)=0;
                                end
                            else % there are no subtypes to this conventional bservation!
                                l(1)=plot(0,5000,'.k');lsz=0;
                            end
                        else
                            if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
                                for sot=1:size(identconvobssubtype,2)
                                    [counts,centers]=hist(compvalues((compvalues(:,9)==identconvobssubtype(sot) & compvalues(:,11)==identconvobstype(sot)),5),[0:5:2000]);counts_tally(sot)=max(counts);
                                    l(sot)=plot(centers,counts,'-','color',identconvobscolors(sot,:),'linewidth',2);centersmatrix(j,sot,:)=centers;countsmatrix(j,sot,:)=counts;            
                                    lsz(sot)=size(compvalues((compvalues(:,9)==identconvobssubtype(sot) & compvalues(:,11)==identconvobstype(sot)),1),1);
                                end
                            else % there are no subtypes to this conventional observation!
                                   [counts,centers]=hist(compvalues(:,5),[0:5:2000]);counts_tally(sot)=max(counts);centersmatrix(j,:)=centers;countsmatrix(j,:)=counts; 
                                    l(1)=plot(centers,counts,'-k','linewidth',2);            
                            end
                        end
                        if identhafsmodel==1;xlim([-0.5 1000]);else;xlim([-.5 2000]);end;
                        if yrlp==1 && j==1
                            ymaxallbasin=max(round(ceil(counts_tally+100),-2));clear counts_tally;
                        end
                        ylim([0 ymaxallbasin])
                        if size(identconvobssubtype,2)>1
                                for sot=1:size(identconvobssubtype,2)
                                    identlegendconv(sot)={[identconvobslegend{sot} ' (',num2str(lsz(sot)),')']};
                                end
                                ll=legend(l,identlegendconv,'location','northeast');
                        else
                                ll=legend(l,['Assimilated Observations'],'location','northeast');lsz=size(compvalues,1);
                        end
                        ll.FontSize=8;ll.ItemTokenSize=[10 10];identlegendconvtotal{j}=identlegendconv;
                        ylabel('Number of Assimilated Observations','fontsize',20)                                   
                        xlabel('Radius (km)','fontsize',20)                                   
                        set(gca,'fontsize',20)
                        grid on
                        if identhafsmodel==1;set(gca,'xtick',0:100:2000);else;set(gca,'xtick',0:250:2000);end;
                        set(gcf, 'InvertHardcopy', 'off')
                        set(gcf,'Units','inches');
                        screenposition = get(gcf,'Position');
                        set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                        set(gcf, 'InvertHardcopy', 'off');clear tmpyr  
                        for tmpdr=1:size(identdr,2)
                            tmp=identdr{tmpdr};
                            tmpyr1=str2num(tmp(end-10:end-9));
                            if tmpyr1<80
                                tmpyr(tmpdr)=tmpyr1+2000;
                            else
                                tmpyr(tmpdr)=tmpyr1+1900;
                            end
                        end
                        tmpuv = unique(tmpyr);
                        tmpn  = histc(tmpyr,tmpuv); 
                        if size(tmpuv,2)>5;tmpphrase=[num2str(sum(tmpn)),' $\mid$ YEARS: ',num2str(size(tmpuv,2))];else;tmpphrase='';
                        for tmpdr=1:length(tmpn)
                            if tmpdr==length(tmpn)
                                tmpphrase=[tmpphrase, num2str(tmpn(tmpdr)),'(',num2str(tmpuv(tmpdr)),')'];
                            else
                                tmpphrase=[tmpphrase, num2str(tmpn(tmpdr)),'(',num2str(tmpuv(tmpdr)),') $\mid$ '];
                            end
                        end;end;    
		text(0,1.025,['\textbf{STORMS: ',tmpphrase,'$\mid$ N=',num2str(size(compvalues,1)),' $\mid$ R$<$2000 km}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',10,'fontweight','bold','interpreter','latex','units','normalized')
                        text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                        text(1,1.03,['\textbf{',identexpshort{j},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(j,:),'units','normalized');                    
                        ax=gca;
                        set(gca,'Color',[.9 .9 .9])
                        set(ax, 'Layer', 'top')
                        ax.LineWidth=1;ax.XGrid='on';ax.XMinorGrid='on';ax.GridAlpha=0.35;ax.YAxis.Exponent = 0;
                        set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                        axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');if yy==1;set(gca,'yscale','log');yyscale='log';elseif yy==2;set(gca,'yscale','linear');yyscale='linear';end;f = getframe(hfig);
                        if yrlp==1
							filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_hist_',identexpshort{j},'_',yyscale];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                        else
							filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_hist_',identexpshort{j},'_',yyscale,'_',curyear];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                        end
                        close all    
						end
                        % Storm-Relative Composite Plan-View Graphic
                        spPos=[0.11 0.13+.05 0.75 0.75-.05]; % arrange plots the same
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
                        if isempty(compvalues)==1
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
                                        if size(compvalues((compvalues(:,9)==identconvobssubtype(sot) & compvalues(:,11)==identconvobstype(sot)),6)*pi/180,1)==0; l(sot)=polarplot(0,5000,'.','markerfacecolor',identconvobscolors(sot,:),'markeredgecolor',identconvobscolors(sot,:));else;l(sot)=polarplot(compvalues((compvalues(:,9)==identconvobssubtype(sot) & compvalues(:,11)==identconvobstype(sot)),6)*pi/180,compvalues((compvalues(:,9)==identconvobssubtype(sot) & compvalues(:,11)==identconvobstype(sot)),5),'.','color',identconvobscolors(sot,:));end;
										lsz(sot)=size(compvalues((compvalues(:,9)==identconvobssubtype(sot) & compvalues(:,11)==identconvobstype(sot)),1),1);
                                end
                            else % there are no subtypes to this conventional bservation!
                                    l(1)=polarplot(compvalues(:,6)*pi/180,compvalues(:,5),'.k');
                            end
                        end
                        if size(identconvobssubtype,2)>1
                                for sot=1:size(identconvobssubtype,2)
                                    identlegendconv(sot)={[identconvobslegend{sot} ' (',num2str(lsz(sot)),')']};
                                end
                                l=legend(l,identlegendconv,'location','northeast');
                        else
                                l=legend(l,['Assimilated Observations'],'location','northeast');lsz=size(compvalues,1);
                        end
                        l.FontSize=8;l.ItemTokenSize=[10 10];
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
                        clear tmpyr;for tmpdr=1:size(identdr,2)
                            tmp=identdr{tmpdr};
                            tmpyr1=str2num(tmp(end-10:end-9));
                            if tmpyr1<80
                                tmpyr(tmpdr)=tmpyr1+2000;
                            else
                                tmpyr(tmpdr)=tmpyr1+1900;
                            end
                        end
                        tmpuv = unique(tmpyr);
                        tmpn  = histc(tmpyr,tmpuv); 
                        if size(tmpuv,2)>5;tmpphrase=[num2str(sum(tmpn)),' $\mid$ YEARS: ',num2str(size(tmpuv,2))];else;tmpphrase='';
                        for tmpdr=1:length(tmpn)
                            if tmpdr==length(tmpn)
                                tmpphrase=[tmpphrase, num2str(tmpn(tmpdr)),'(',num2str(tmpuv(tmpdr)),')'];
                            else
                                tmpphrase=[tmpphrase, num2str(tmpn(tmpdr)),'(',num2str(tmpuv(tmpdr)),') $\mid$ '];
                            end
                        end;end;    
                        text(-.015,1.030,['\textbf{STORMS: ',tmpphrase,'$\mid$ N=',num2str(size(compvalues,1)),' $\mid$ R$<$2000 km}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',10,'fontweight','bold','interpreter','latex','units','normalized')
                        text(-.015,1.07,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                        text(1.015,1.035,['\textbf{',identexpshort{j},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(j,:),'units','normalized');                    
                        ax=gca;
                        set(gca,'Color',[.9 .9 .9])
                        set(ax, 'Layer', 'top')
                        ax.LineWidth=1; 
                        set(gca,'position',[spPos(1)+.035 spPos(2)+.015 spPos(3) spPos(4)-.02])
                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                        axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);
                        if yrlp==1
							filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_plan_',identexpshort{j}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                        else
                            filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_plan_',identexpshort{j},'_',curyear];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                        end
                        close all         
                        %% Denmap for Subtypes  
                        if size(identconvobssubtype,2)>1
                            for sot=1:size(identconvobssubtype,2)
                                clear tmp1_den_tt
                                if isempty(compdenmap_t)==1
                                    tmp1_den_tt=zeros(11,3);
                                else
                                    for soti=1:size(compdenmap_t,1)
                                        tmp1_den_tt(:,:,soti)=compdenmap_t{soti,sot};
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
                                caxis([0 5000])
                                colormap(flipud(gray(20)))
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
                                text(0,1.025,['\textbf{STORMS: ',tmpphrase,'$\mid$ N=',num2str(sum(identvals(:))),'/',num2str(sum(compdenmap(:))),' $\mid$ R$<$2000 km}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',10,'fontweight','bold','interpreter','latex','units','normalized')
                                text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                text(1,1.03,['\textbf{',identexpshort{j},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(j,:),'units','normalized');                    
                                tmpsum=sum(tmp1_den_tt,3);if max(max((sum(tmpsum,3))))>100000;caxis([0 100000]);colcut=5000*4;elseif max(max((sum(tmpsum,3))))>50000;caxis([0 50000]);colcut=2500*4;elseif max(max((sum(tmpsum,3))))>25000;caxis([0 25000]);colcut=1250*4;elseif max(max((sum(tmpsum,3))))>10000;caxis([0 10000]);colcut=500*4;elseif max(max((sum(tmpsum,3))))>5000;caxis([0 5000]);colcut=250*4;elseif max(max((sum(tmpsum,3))))>2500;caxis([0 2500]);colcut=125*4;elseif max(max((sum(tmpsum,3))))>1000;caxis([0 1000]);colcut=50*4;else;caxis([0 250]);colcut=12.5*4;end;if j==1;cmax=caxis;cmax0(sot)=cmax(2);colcut0(sot)=colcut;end;colormap(flipud(gray(20)));caxis([0 cmax0(sot)]);colormap(flipud(gray(20)));                                                                   
                                for i=1:3
                                    for jj=1:11
                                        if tmpsum(jj,i)>=colcut0(sot)
                                        text(i,jj, num2str(tmpsum(jj,i)), 'color','w','HorizontalAlignment', 'Center','fontsize',16)
                                        else
                                        text(i,jj, num2str(tmpsum(jj,i)), 'HorizontalAlignment', 'Center','fontsize',16)
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
                                if yrlp==1
									filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_az_',identexpshort{j},'_',erase(erase(identconvobslegend{sot}," "),"-")];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                else
									filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_az_',identexpshort{j},'_',curyear,'_',erase(erase(identconvobslegend{sot}," "),"-")];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                end
                                close all   
                            end
                        end
                        %% Density Map                
                        set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                        hfig=figure;
                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                        ax1=subplot(3,4,[1:8]);  
                        if isempty(compdenmap)==1
                            compdenmap=zeros(11,3);
                        end               
                        identvals=sum(sum(compdenmap,1),3);
                        imagesc(sum(compdenmap,3))
                        xlabel('','fontsize',20)
                        ylabel('Pressure (hPa)','fontsize',20)                                   
                        set(gca,'fontsize',20)
                        set(gca,'xtick',1:3)
                        set(gca,'xticklabel',{'<75 km','75-250 km','>250 km'});
                        set(gca,'ytick',0.5:1:12)
                        set(gca,'yticklabel',{'0','100','200','300','400','500','600','700','800','900','1000','1100'});
                        colorbar
                        caxis([0 5000])
                        colormap(flipud(gray(20)))
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
                        text(0,1.025,['\textbf{STORMS: ',tmpphrase,'$\mid$ N=',num2str(tmpsum),' $\mid$ R$<$2000 km}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',10,'fontweight','bold','interpreter','latex','units','normalized')
                        text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                        text(1,1.03,['\textbf{',identexpshort{j},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(j,:),'units','normalized');                    
                        tmpsum=sum(compdenmap,3);if max(max((sum(tmpsum,3))))>100000;caxis([0 100000]);colcut=5000*4;elseif max(max((sum(tmpsum,3))))>50000;caxis([0 50000]);colcut=2500*4;elseif max(max((sum(tmpsum,3))))>25000;caxis([0 25000]);colcut=1250*4;elseif max(max((sum(tmpsum,3))))>10000;caxis([0 10000]);colcut=500*4;elseif max(max((sum(tmpsum,3))))>5000;caxis([0 5000]);colcut=250*4;elseif max(max((sum(tmpsum,3))))>2500;caxis([0 2500]);colcut=125*4;elseif max(max((sum(tmpsum,3))))>1000;caxis([0 1000]);colcut=50*4;else;caxis([0 250]);colcut=12.5*4;end;if j==1;cmax=caxis;cmax00=cmax(2);colcut00=colcut;end;colormap(flipud(gray(20)));caxis([0 cmax00]);colormap(flipud(gray(20)));                            
                        for i=1:3
                            for jj=1:11
                                if tmpsum(jj,i)>=colcut00
                                text(i,jj, num2str(tmpsum(jj,i)), 'color','w','HorizontalAlignment', 'Center','fontsize',16)
                                else
                                text(i,jj, num2str(tmpsum(jj,i)), 'HorizontalAlignment', 'Center','fontsize',16)
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
                        if yrlp==1
							filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_az_',identexpshort{j}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                        else
							filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_az_',identexpshort{j},'_',curyear];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                        end
                        close all   
                    end
                    % Histogram Difference Composite Graphic
			for yy=1:2;for j=2:size(identexp,1) 

			spPos=[0.11 0.13+.05 0.75 0.75-.05]; % arrange plots the same
                        set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                        hfig=figure;
                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                        ax1=subplot(3,4,[1:8]);
                        set(gca,'plotboxaspectratio',[1 1 1])
                        box on
                        set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                        hold on
                        if isempty(compvalues)==1
                            if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
                                for sot=1:size(identconvobssubtype,2)
                                     l(sot)=plot(0,5000,'.','markerfacecolor',identconvobscolors(sot,:),'markeredgecolor',identconvobscolors(sot,:));
                                     lsz(sot)=0;
                                end
                            else % there are no subtypes to this conventional bservation!
                                l(1)=plot(0,5000,'.k');lsz=0;
                            end
                        else
                            if size(identconvobssubtype,2)>1 % there are subtypes to this conventional observation!
                                for sot=1:size(identconvobssubtype,2)
                                    l(sot)=plot(squeeze(centersmatrix(j,sot,:)),squeeze(countsmatrix(1,sot,:)-countsmatrix(j,sot,:)),'-','color',identconvobscolors(sot,:),'linewidth',2);
                                    lsz(sot)=sum(countsmatrix(1,sot,:)-countsmatrix(j,sot,:));
                                end
                            else % there are no subtypes to this conventional observation!
                                   l(1)=plot(squeeze(centersmatrix(j,:)),squeeze(countsmatrix(1,:)-countsmatrix(j,:)),'-','color',identconvobscolors,'linewidth',2);
                                   lsz(1)=sum(countsmatrix(1,:)-countsmatrix(j,:));          
                            end
                        end
                        xlim([-.5 2000])
                        if yrlp==1 && j==1
                            ymaxallbasin=round(max(counts)/100)*100+50;
                        end
                        ylim([0 ymaxallbasin])
                        if size(identconvobssubtype,2)>1
                                for sot=1:size(identconvobssubtype,2)
                                    identlegendconv(sot)={[identconvobslegend{sot} ' (',num2str(lsz(sot)),')']};
                                end
                                ll=legend(l,identlegendconv,'location','northeast');
                        else
                                ll=legend(l,['Assimilated Observations'],'location','northeast');lsz=size(compvalues,1);
                        end
                        ll.FontSize=8;ll.ItemTokenSize=[10 10];
                        ylabel('Diff Btw Number of Assimilated Observations','fontsize',20)                                   
                        xlabel('Radius (km)','fontsize',20)                                   
                        set(gca,'fontsize',20)
                        grid on
                        set(gca,'xtick',0:250:2000)
                        set(gcf, 'InvertHardcopy', 'off')
                        set(gcf,'Units','inches');
                        screenposition = get(gcf,'Position');
                        set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                        set(gcf, 'InvertHardcopy', 'off');clear tmpyr;  
                        for tmpdr=1:size(identdr,2)
                            tmp=identdr{tmpdr};
                            tmpyr1=str2num(tmp(end-10:end-9));
                            if tmpyr1<80
                                tmpyr(tmpdr)=tmpyr1+2000;
                            else
                                tmpyr(tmpdr)=tmpyr1+1900;
                            end
                        end
                        tmpuv = unique(tmpyr);
                        tmpn  = histc(tmpyr,tmpuv); 
                        if size(tmpuv,2)>5;tmpphrase=[num2str(sum(tmpn)),' $\mid$ YEARS: ',num2str(size(tmpuv,2))];else;tmpphrase='';
                        for tmpdr=1:length(tmpn)
                            if tmpdr==length(tmpn)
                                tmpphrase=[tmpphrase, num2str(tmpn(tmpdr)),'(',num2str(tmpuv(tmpdr)),')'];
                            else
                                tmpphrase=[tmpphrase, num2str(tmpn(tmpdr)),'(',num2str(tmpuv(tmpdr)),') $\mid$ '];
                            end
                        end;end;    
                        text(0,1.027,['\textbf{TCS: ',tmpphrase,'$\mid$ N=',num2str(sum(lsz)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',10,'fontweight','bold','interpreter','latex','units','normalized')
                        text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations - Differences from ',identexpshort{j},'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                        text(1,1.03,['\textbf{',identexpshort{1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(1,:),'units','normalized');                    
                        ax=gca;
                        set(gca,'Color',[.9 .9 .9])
                        set(ax, 'Layer', 'top')
                        ax.LineWidth=1; ax.XGrid='on';ax.XMinorGrid='on';ax.GridAlpha=0.35;ax.YAxis.Exponent = 0;
                        set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                        axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');if yy==1;set(gca,'yscale','log');yyscale='log';elseif yy==2;set(gca,'yscale','linear');yyscale='linear';end;f = getframe(hfig);
                        if yrlp==1
				filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_histdiff_',identexpshort{j},'_',yyscale];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                        else
				filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_histdiff_',identexpshort{j},'_',yyscale,'_',curyear];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                        end
                        close all   
		end;end																		
					% Bar Graph Totals
					 for j=1:size(identexp,1) 
                        if yrlp==1
                            identdr=dir([identout,'RESULTS/',identfold,'VERIFICATION/OBS/*.mat']);
                        else
                            identdr=dir([identout,'RESULTS/',identfold,'VERIFICATION/OBS/*',curyearcut,'_*.mat']);
                        end
                        identdr={identdr.name};
                        compvalues=[];
                        compdenmap=[];
                        compdenmap_t=[];
                        compinner=zeros(1,size(identexp,1));
                        compgale=zeros(1,size(identexp,1));
                        compouter=zeros(1,size(identexp,1));
                        compinner_t=zeros(1,size(identexp,1));
                        compgale_t=zeros(1,size(identexp,1));
                        compouter_t=zeros(1,size(identexp,1));
                        for i=1:size(identdr,2)
                            load([identout,'RESULTS/',identfold,'VERIFICATION/OBS/',identdr{i}])
                            identdroplist{:}
                            presum=valuescomp{j};
                            presum=sum(presum,3);
                            compvalues=cat(1,compvalues,presum);

                            if size(identconvobssubtype,2)>1
                                compdenmap_t=cat(1,compdenmap_t,denmapcomp_t{j});
                                compinner_t=identdroplist{5}+compinner_t;
                                compgale_t=identdroplist{6}+compgale_t;
                                compouter_t=identdroplist{7}+compouter_t;
                            end

                            if sum(sum(denmapcomp{j}))==0
                            else
                                compdenmap=cat(3,compdenmap,denmapcomp{j});
                            end
                            compinner=identdroplist{2}+compinner;
                            compgale=identdroplist{3}+compgale;
                            compouter=identdroplist{4}+compouter;
                        end
						%% Bar Graph to show how many of each variable
						if size(identconvobssubtype,2)>1
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
							if isempty(compvalues)==1
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
										lsz(sot)=size(compvalues((compvalues(:,9)==identconvobssubtype(sot) & compvalues(:,11)==identconvobstype(sot)),1),1);
									end
								else % there are no subtypes to this conventional observation!
									   lsz=size(compvalues,1)           
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
							xlim([0.5 size(lsz,2)+.5]);if j==1;fixyaxis=axis;fixyaxis0=fixyaxis(4);end;ylim([0 fixyaxis0]);
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
							text(0,1.027,['\textbf{TCS: ',tmpphrase,'$\mid$ N=',num2str(sum(lsz)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',10,'fontweight','bold','interpreter','latex','units','normalized')
							text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
							text(1,1.03,['\textbf{',identexpshort{j},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(j,:),'units','normalized');                                           							
							set(gca,'Color',[.9 .9 .9])
							%set(ax, 'Layer', 'top')
							ax.LineWidth=1;ax.YAxis.Exponent = 0; 
							set(gca,'position',[spPos(1)+.035 spPos(2)+.015 spPos(3) spPos(4)-.02])
							set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
							axes(ax1);ht=text(1,0,['Plot generated using GROOT'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',8,'fontweight','bold','interpreter','latex','color','k','units','normalized');f = getframe(hfig);
							if yrlp==1
								filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_barcomp_',identexpshort{j}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
							else
								filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_barcomp_',identexpshort{j},'_',curyear];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
							end
							close all    
						end
						end
					% Cycle-By-Cycle to show how many of each variable
                        for exl=1:size(identexp,1) 
							clear lsz aomlmvlsz
							if yrlp==1
								identdr=dir([identout,'RESULTS/',identfold,'VERIFICATION/OBS/*.mat']);
							else
									identdr=dir([identout,'RESULTS/',identfold,'VERIFICATION/OBS/*',curyearcut,'_*.mat']);
							end
							identdr={identdr.name};
                            for i=1:size(identdr,2)
								load([identout,'RESULTS/',identfold,'VERIFICATION/OBS/',identdr{i}])
								identdroplist{:}
								presum=valuescomp{exl};
								presum=sum(presum,3);
								compvalues=presum;								
								if isempty(compvalues)==1
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
											lsz(sot)=size(compvalues((compvalues(:,9)==identconvobssubtype(sot) & compvalues(:,11)==identconvobstype(sot)),1),1);
										end
									else % there are no subtypes to this conventional observation!
										   lsz=size(compvalues,1)           
									end
								end
								aomlmvlsz(i,:)=lsz;
							end							
							 % sort by year and then by name                               
							clear tmpid tmpnm
						   for i=1:size(stormsdone,2);
								tmpidid=stormsdone{i}
								tmpid(i,:)=tmpidid(end-2:end-1);	
								tmpnm{i}=[tmpidid(end-2:end),' (',upper(tmpidid(1)),tmpidid(2:end-3),')'];
							end							
							tmpid=str2num(tmpid);
							if size(yearsdone,1)==1;
								tmpyrid=[str2num(yearsdone)' tmpid];
							else;
								tmpyrid=[str2num(yearsdone) tmpid];
							end;
							if yrlp>1
								tmpyrid=tmpyrid(tmpyrid(:,1)==str2num(curyear),:);
								tmpnm=tmpnm(tmpyrid(:,1)==str2num(curyear));
							end
							[a_sorted, a_order] = sortrows(tmpyrid,[1,2]);		
							clear tmpid;
                            nm_pct = aomlmvlsz(a_order,:);							
                            tmpnm = tmpnm(a_order);
							% plot
							set(0,'defaultfigurecolor',[1 1 1]) % figure background color
							hfig=figure;
							set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
							ax1=subplot(3,4,[1:8]);
							b=barh(nm_pct,'stacked','FaceColor','flat'); % stacks values in each row together
							for i=1:size(identconvobscolors,1)											
								b(i).CData= identconvobscolors(i,:);										
							end
							xlabel('Number of Assimilated Observations','fontsize',14)        
							set(gca,'fontsize',14)
							box on									
							set(gca,'fontsize',14)
							hold on                        
							box on
							xstart=1;          
							ylim([xstart-.5 size(tmpnm,2)+.5])                                                   							
							set(gca,'yticklabel',tmpnm)
							set(gca,'fontsize',14)
							cnt=1;  
							if size(identconvobssubtype,2)>1								
								ll=legend(b,identlegendconvtotal{exl},'location','northeast');
							else
									ll=legend(l,['Assimilated Observations'],'location','northeast');lsz=size(compvalues,1);
							end
							ll.FontSize=8;ll.ItemTokenSize=[10 10];							
							set(gcf, 'InvertHardcopy', 'off')
							set(gcf,'Units','inches');
							screenposition = get(gcf,'Position');
							set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
							set(gcf, 'InvertHardcopy', 'off')																
							set(gca,'TickLength',[0 0])																
							text(0,1.025,['\textbf{TCS: ',tmpphrase,'$\mid$ N=',num2str(sum(nm_pct(:))),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',10,'fontweight','bold','interpreter','latex','units','normalized')
							text(0,1.06,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
							text(1,1.03,['\textbf{',identexpshort{exl},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(exl,:),'units','normalized');                                           																															
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
							if yrlp==1
								filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_reconcontr_',identexpshort{exl}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
							else
								filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_reconcontr_',identexpshort{exl},'_',curyear];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
							end
							close all   
						end 
						
				end
				clearvars -except identboxhist identconmetric identeps identmodelfhr identincludeobs identconvobs identserialcorr identbasinmodel identsatobs identgraphicssat identsatid identsatname identindivch identchannel identindivstorm identcomposite identstormsdone convyear ymaxallbasin identconvobssubtype identconvobscolors identconvobslegend identns* identnewsub* identgraphicsbycycle identgraphicsconv yrlp identconvid  ident* skip* stormsdone yearsdone               
            end
