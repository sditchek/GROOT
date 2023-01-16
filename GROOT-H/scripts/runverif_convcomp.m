%% Conventional Obs Composite - all and by year, if multiple years present
            if identconv==1
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

                            if size(identconvtype,2)>1
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
                            if size(identconvtype,2)>1 % there are subtypes to this conventional observation!
                                for sot=1:size(identconvtype,2)
                                     l(sot)=plot(0,5000,'.','markerfacecolor',identconvcolors(sot,:),'markeredgecolor',identconvcolors(sot,:));
                                     lsz(sot)=0;
                                end
                            else % there are no subtypes to this conventional bservation!
                                l(1)=plot(0,5000,'.k');
                            end
                        else
                            if size(identconvtype,2)>1 % there are subtypes to this conventional observation!
                                for sot=1:size(identconvtype,2)
                                    [counts,centers]=hist(compvalues((compvalues(:,9)==identconvtype(sot)),5),[0:5:2000]);
                                    l(sot)=plot(centers,counts,'-','color',identconvcolors(sot,:),'linewidth',2);            
                                    lsz(sot)=size(compvalues((compvalues(:,9)==identconvtype(sot)),1),1);
                                end
                            else % there are no subtypes to this conventional observation!
                                   [counts,centers]=hist(compvalues(:,5),[0:5:2000]);
                                    l(1)=plot(centers,counts,'-k','linewidth',2);            
                            end
                        end
                        xlim([-.5 2000])
                        if yrlp==1 && j==1
                            ymaxallbasin=round(max(counts)/100)*100+50;
                        end
                        ylim([0 ymaxallbasin])
                        if size(identconvtype,2)>1
                                for sot=1:size(identconvtype,2)
                                    identlegendconv(sot)={[identconvlegend{sot} ' (',num2str(lsz(sot)),')']};
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
                        text(0,1.027,['\textbf{TCS: ',tmpphrase,'$\mid$ N=',num2str(size(compvalues,1)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',10,'fontweight','bold','interpreter','latex','units','normalized')
                        text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                        text(1,1.03,['\textbf{',identexpshort{j},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(j,:),'units','normalized');                    
                        ax=gca;
                        set(gca,'Color',[.9 .9 .9])
                        set(ax, 'Layer', 'top')
                        ax.LineWidth=1; 
                        set(gca,'position',[spPos(1)+.035 spPos(2) spPos(3) spPos(4)])
                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                        f = getframe(hfig);
                        if yrlp==1
							filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_hist_',identexpshort{j}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                        else
							filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_hist_',identexpshort{j},'_',curyear];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                        end
                        close all    

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
                            if size(identconvtype,2)>1 % there are subtypes to this conventional observation!
                                for sot=1:size(identconvtype,2)
                                     l(sot)=polarplot(0,5000,'.','markerfacecolor',identconvcolors(sot,:),'markeredgecolor',identconvcolors(sot,:));
                                     lsz(sot)=0;
                                end
                            else % there are no subtypes to this conventional bservation!
                                l(1)=polarplot(0,5000,'.k');
                            end
                        else
                            if size(identconvtype,2)>1 % there are subtypes to this conventional observation!
                                for sot=1:size(identconvtype,2)
                                    l(sot)=polarplot(compvalues((compvalues(:,9)==identconvtype(sot)),6)*pi/180,compvalues((compvalues(:,9)==identconvtype(sot)),5),'.','color',identconvcolors(sot,:));
                                    lsz(sot)=size(compvalues((compvalues(:,9)==identconvtype(sot)),1),1);
                                end
                            else % there are no subtypes to this conventional bservation!
                                    l(1)=polarplot(compvalues(:,6)*pi/180,compvalues(:,5),'.k');
                            end
                        end
                        if size(identconvtype,2)>1
                                for sot=1:size(identconvtype,2)
                                    identlegendconv(sot)={[identconvlegend{sot} ' (',num2str(lsz(sot)),')']};
                                end
                                l=legend(l,identlegendconv,'location','northeast');
                        else
                                l=legend(l,['Assimilated Observations'],'location','northeast');
                        end
                        l.FontSize=10;
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
                        text(-.015,1.032,['\textbf{TCS: ',tmpphrase,'$\mid$ N=',num2str(size(compvalues,1)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',10,'fontweight','bold','interpreter','latex','units','normalized')
                        text(-.015,1.07,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                        text(1.015,1.035,['\textbf{',identexpshort{j},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(j,:),'units','normalized');                    
                        ax=gca;
                        set(gca,'Color',[.9 .9 .9])
                        set(ax, 'Layer', 'top')
                        ax.LineWidth=1; 
                        set(gca,'position',[spPos(1)+.035 spPos(2)+.015 spPos(3) spPos(4)-.02])
                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                        f = getframe(hfig);
                        if yrlp==1
							filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_plan_',identexpshort{j}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                        else
                            filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_plan_',identexpshort{j},'_',curyear];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                        end
                        close all         
                        %% Denmap for Subtypes  
                        if size(identconvtype,2)>1
                            for sot=1:size(identconvtype,2)
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
                                text(0,1.027,['\textbf{TCS: ',tmpphrase,'$\mid$ N=',num2str(sum(identvals(:))),'/',num2str(sum(compdenmap(:))),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',10,'fontweight','bold','interpreter','latex','units','normalized')
                                text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                                text(1,1.03,['\textbf{',identexpshort{j},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(j,:),'units','normalized');                    
                                tmpsum=sum(tmp1_den_tt,3);                
                                for i=1:3
                                    for jj=1:11
                                        if tmpsum(jj,i)>=4000
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
                                f = getframe(hfig);
                                if yrlp==1
									filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_az_',identexpshort{j},'_type',num2str(identconvtype(sot))];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                else
									filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_az_',identexpshort{j},'_',curyear,'_type',num2str(identconvtype(sot))];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
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
                        text(0,1.027,['\textbf{TCS: ',tmpphrase,'$\mid$ N=',num2str(tmpsum),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',10,'fontweight','bold','interpreter','latex','units','normalized')
                        text(0,1.065,['\textbf{Assimilated ',identconvid,' Observations}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','units','normalized')
                        text(1,1.03,['\textbf{',identexpshort{j},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',14,'fontweight','bold','interpreter','latex','color',identexpcolors(j,:),'units','normalized');                    
                        tmpsum=sum(compdenmap,3);                            
                        for i=1:3
                            for jj=1:11
                                if tmpsum(jj,i)>=4000
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
                        f = getframe(hfig);
                        if yrlp==1
							filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_az_',identexpshort{j}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                        else
							filename=[identout,'RESULTS/',identfold,'/VERIFICATION/OBS/COMP_conv_az_',identexpshort{j},'_',curyear];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                        end
                        close all   
                    end
                    clearvars -except identconmetric identeps identmodelfhr identincludeobs identconvobs identserialcorr identbasinmodel identsatobs identgraphicssat identsatid identsatname identindivch identchannel identindivstorm identcomposite identstormsdone convyear ymaxallbasin identconvtype identconvcolors identconvlegend identns* identnewsub identgraphicsbycycle identgraphicsconv yrlp identconvid  ident* skip* stormsdone yearsdone

                end
            end
            
