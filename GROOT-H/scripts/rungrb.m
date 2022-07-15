%% %%%%%%%%%%%% %%
%% Setup script %%
%% %%%%%%%%%%%% %%
for setup=1
    % Load the startparams.mat that is set in editgrb.m
    load('startparams.mat')

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
    end
    
    if ~exist([identout,'RESULTS/',identfold], 'dir')
        disp('CREATING EXPERIMENT FOLDER')
        mkdir([identout,'RESULTS/',identfold])
    end

    % Create Directory Structure
    %if ~exist([identout,'RESULTS/',identfold,identn], 'dir')
        disp('CREATING DIRECTORY STRUCTURE')
        mkdir([identout,'RESULTS/',identfold,identn])
        mkdir([identout,'RESULTS/',identfold,identn,'/HWRFDA'])
        mkdir([identout,'RESULTS/',identfold,identn,'/FIELDS'])
        mkdir([identout,'RESULTS/',identfold,identn,'/FIELDS/DIFFSTORM'])
        mkdir([identout,'RESULTS/',identfold,identn,'/FIELDS/DIFFSYNOPTIC'])
        for tmp=1:size(identexp,1)
            mkdir([identout,'RESULTS/',identfold,identn,'/FIELDS/',identexp{tmp}])
            mkdir([identout,'RESULTS/',identfold,identn,'/FIELDS/',identexp{tmp},'/FIGURES'])
            mkdir([identout,'RESULTS/',identfold,identn,'/FIELDS/',identexp{tmp},'/FIGURES/SYNOPTIC'])
            mkdir([identout,'RESULTS/',identfold,identn,'/FIELDS/',identexp{tmp},'/FIGURES/STORM'])
            mkdir([identout,'RESULTS/',identfold,identn,'/FIELDS/',identexp{tmp},'/MATFILES'])    
        end
        mkdir([identout,'RESULTS/',identfold,identn,'/TRACKINT/'])
    %else
    %    disp('DIRECTORY STRUCTURE ALREADY EXISTS')
    %end
    identfields=[identout,'RESULTS/',identfold,identn,'/FIELDS'];
    identtrackint=[identout,'RESULTS/',identfold,identn,'/TRACKINT'];
    identhwrfda=[identout,'RESULTS/',identfold,identn,'/HWRFDA'];
    identbdecks='bdeck/';
    %% Get common initalizations between all experiments
    cnt=1;
    for tmp=1:size(identexp,1)
        identdr=dir([identscrub,identexp{tmp},'/com/',ident(5:8),'*/',ident(3:4),upper(identhwrf(end))]);
        identdr=unique({identdr.folder});
        for i=1:size(identdr,2)
            tmp2=identdr{i};
            tmp2=tmp2(end-13:end-4);
            identdr1(cnt,:)=tmp2;
            cnt=cnt+1;
        end        
    end    
    A = str2num(identdr1);
    [n, bin] = histc(A, unique(A));
    multiple = find(n > size(identexp,1)-1);
    index    = find(ismember(bin, multiple));
    identinittimesunique=unique(identdr1(index,:),'rows');

    % Add package to read grb2 files to path
    run('nctoolbox-1.1.3/setup_nctoolbox')
end

%% %%%%%%%%% %%
%% Get BDECK %%
%% %%%%%%%%% %%
for bdecks=1
    filename = [identbdecks,'b',lower(ident),'.dat'];
    [identhemi,DATEall,BASINall,NAMEall,CATall,LATall,POall,SE50all,LONall,PRESSall,SE64all,NE34all,RAD34all,SPEEDall,NE50all,RAD50all,SW34all,NE64all,RAD64all,SW50all,NW34all,RMWall,SW64all,NW50all,ROall,NW64all,SE34all,FHRall,INTCHall]=atcf(filename,1);
    save([identout,'RESULTS/',identfold,identn,'/',identn,'_data.mat'])
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%% HWRFDA: pre-GSI & post-GSI graphics and difference fields %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%wrfghost_d03: background right before GSI
%wrfghost_d02: background right before GSI
%gsi_out_storm1ghost_parent: output right after GSI
%gsi_out_storm1ghost: output right after GSI
if identda==1    
    disp(['STARTING HWRFDA GRAPHICS'])
    % Load all Storm Centers for All Cycles and Forecasts
    load([identout,'RESULTS/',identfold,identn,'/',identn,'_latlon.mat']);
    % run loops
    for identloop=identbatch%1:size(identinittimesunique,1)
       disp(['STARTING HWRFDA GRAPHICS: INDIVIDUAL CYCLE'])
       disp(['CYCLE INIT DATE: ',identinittimesunique(identloop,:)])
       for hwrfvariables=1:size(identexp,1)
            load([identout,'RESULTS/',identfold,identn,'/',identn,'_latlon.mat']);
            identexp0=identexp{hwrfvariables};
            disp(['EXPERIMENT: ',identexp0])
            for identfhr=1 % init time only
                if isnan(BT_lat(identloop,identfhr))==1
                    disp('BT has a NaN...skipping date!')
                else
                    wrfg2=[identscrub,identexp0,'/HWRFDA/',identinittimesunique(identloop,:),'/',ident(3:4),upper(identhwrf(end)),'/wrfghost_d02'];
                    wrfg3=[identscrub,identexp0,'/HWRFDA/',identinittimesunique(identloop,:),'/',ident(3:4),upper(identhwrf(end)),'/wrfghost_d03'];
                    gsig2=[identscrub,identexp0,'/HWRFDA/',identinittimesunique(identloop,:),'/',ident(3:4),upper(identhwrf(end)),'/gsi_out_storm1ghost_parent'];
                    gsig3=[identscrub,identexp0,'/HWRFDA/',identinittimesunique(identloop,:),'/',ident(3:4),upper(identhwrf(end)),'/gsi_out_storm1ghost'];

                    % Get all variables for this cycle/experiment                                          
                    q_b2=ncread(wrfg2,'Q'); % kg/kg
                    u_b2=ncread(wrfg2,'U'); %m/s
                    v_b2=ncread(wrfg2,'V'); %m/s
                    t_b2=ncread(wrfg2,'T'); % K
                    glon_b2=ncread(wrfg2,'GLON').*180/pi;
                    glat_b2=ncread(wrfg2,'GLAT').*180/pi;
                    pint_b2=ncread(wrfg2,'PINT'); % Pa                    
                    sm_b2=ncread(wrfg2,'SM'); % Sea mask; =1 for sea, =0 for land 
                    for lndmsk=1:size(pint_b2,3)
                        lev=pint_b2(:,:,lndmsk,1)/100;
                        ocean=sm_b2(:,:,1,1);
                        plev_b2(lndmsk)=nanmean(lev(ocean==1));
                    end
                    p0 = 1000;          %mb standard ref. pressure
                    Kappa = .286;       %R/cp
                    for i = 1:size(plev_b2,2)-1
                        pt_b2(:,:,i) = t_b2(:,:,i).*(p0/plev_b2(i)).^Kappa;%equation for potential temperature.
                    end
                    press=[1000 925 850 700 600 500 400 300 250 200 150 100 50]; % Dunion sounding
                    values=[299.6 301.7 304.6 312.3 317.9 325 332.7 339.9 343 346.6 354.2 383.5 494.5]; % Dunion sounding
                    anom_b2=spline(press,values,plev_b2);

                    q_a2=ncread(gsig2,'Q');
                    u_a2=ncread(gsig2,'U');
                    v_a2=ncread(gsig2,'V');
                    t_a2=ncread(gsig2,'T');
                    glon_a2=ncread(gsig2,'GLON').*180/pi;
                    glat_a2=ncread(gsig2,'GLAT').*180/pi;
                    pint_a2=ncread(gsig2,'PINT');                    
                    sm_a2=ncread(gsig2,'SM'); % Sea mask; =1 for sea, =0 for land 
                    for lndmsk=1:size(pint_a2,3)
                        lev=pint_a2(:,:,lndmsk,1)/100;
                        ocean=sm_a2(:,:,1,1);
                        plev_a2(lndmsk)=nanmean(lev(ocean==1));
                    end
                    p0 = 1000;          %mb standard ref. pressure
                    Kappa = .286;       %R/cp
                    for i = 1:size(plev_a2,2)-1
                        pt_a2(:,:,i) = t_a2(:,:,i).*(p0/plev_a2(i)).^Kappa;%equation for potential temperature.
                    end
                    press=[1000 925 850 700 600 500 400 300 250 200 150 100 50]; % Dunion sounding
                    values=[299.6 301.7 304.6 312.3 317.9 325 332.7 339.9 343 346.6 354.2 383.5 494.5]; % Dunion sounding
                    anom_a2=spline(press,values,plev_a2);
                    
                    q_b3=ncread(wrfg3,'Q');
                    u_b3=ncread(wrfg3,'U');
                    v_b3=ncread(wrfg3,'V');
                    t_b3=ncread(wrfg3,'T');
                    glon_b3=ncread(wrfg3,'GLON').*180/pi;
                    glat_b3=ncread(wrfg3,'GLAT').*180/pi;
                    pint_b3=ncread(wrfg3,'PINT');                    
                    sm_b3=ncread(wrfg3,'SM'); % Sea mask; =1 for sea, =0 for land 
                    for lndmsk=1:size(pint_b3,3)
                        lev=pint_b3(:,:,lndmsk,1)/100;
                        ocean=sm_b3(:,:,1,1);
                        plev_b3(lndmsk)=nanmean(lev(ocean==1));
                    end 
                    p0 = 1000;          %mb standard ref. pressure
                    Kappa = .286;       %R/cp
                    for i = 1:size(plev_b3,2)-1
                        pt_b3(:,:,i) = t_b3(:,:,i).*(p0/plev_b3(i)).^Kappa;%equation for potential temperature.
                    end
                    press=[1000 925 850 700 600 500 400 300 250 200 150 100 50]; % Dunion sounding
                    values=[299.6 301.7 304.6 312.3 317.9 325 332.7 339.9 343 346.6 354.2 383.5 494.5]; % Dunion sounding
                    anom_b3=spline(press,values,plev_b3);

                    q_a3=ncread(gsig3,'Q');
                    u_a3=ncread(gsig3,'U');
                    v_a3=ncread(gsig3,'V');
                    t_a3=ncread(gsig3,'T');
                    glon_a3=ncread(gsig3,'GLON').*180/pi;
                    glat_a3=ncread(gsig3,'GLAT').*180/pi;
                    pint_a3=ncread(gsig3,'PINT');                     
                    sm_a3=ncread(gsig3,'SM'); % Sea mask; =1 for sea, =0 for land 
                    for lndmsk=1:size(pint_a3,3)
                        lev=pint_a3(:,:,lndmsk,1)/100;
                        ocean=sm_a3(:,:,1,1);
                        plev_a3(lndmsk)=nanmean(lev(ocean==1));
                    end
                    p0 = 1000;          %mb standard ref. pressure
                    Kappa = .286;       %R/cp
                    for i = 1:size(plev_a3,2)-1
                        pt_a3(:,:,i) = t_a3(:,:,i).*(p0/plev_a3(i)).^Kappa;%equation for potential temperature.
                    end
                    press=[1000 925 850 700 600 500 400 300 250 200 150 100 50]; % Dunion sounding
                    values=[299.6 301.7 304.6 312.3 317.9 325 332.7 339.9 343 346.6 354.2 383.5 494.5]; % Dunion sounding
                    anom_a3=spline(press,values,plev_a3);

                    %RH                                          
                    Rd=287.04;
                    Rv=461.5;
                    eps=Rd/Rv;
                    satvap=6.1121*exp(17.502*((t_b2-273.16)./(t_b2-32.19)));
                    vappress=pint_b2(:,:,1:end-1).*q_b2./(100*(eps+q_b2*(1-eps)));
                    rh_b2=100*(vappress./satvap);
                    satvap=6.1121*exp(17.502*((t_a2-273.16)./(t_a2-32.19)));
                    vappress=pint_a2(:,:,1:end-1).*q_a2./(100*(eps+q_a2*(1-eps)));
                    rh_a2=100*(vappress./satvap);                        
                    satvap=6.1121*exp(17.502*((t_b3-273.16)./(t_b3-32.19)));
                    vappress=pint_b3(:,:,1:end-1).*q_b3./(100*(eps+q_b3*(1-eps)));
                    rh_b3=100*(vappress./satvap);
                    satvap=6.1121*exp(17.502*((t_a3-273.16)./(t_a3-32.19)));
                    vappress=pint_a3(:,:,1:end-1).*q_a3./(100*(eps+q_a3*(1-eps)));
                    rh_a3=100*(vappress./satvap);                       

                    % WIND SPEED
                    ws_b2=sqrt(u_b2.^2+v_b2.^2);
                    ws_a2=sqrt(u_a2.^2+v_a2.^2);
                    ws_b3=sqrt(u_b3.^2+v_b3.^2);
                    ws_a3=sqrt(u_a3.^2+v_a3.^2);                                        
                    
                    % VORTICITY & DIVERGENCE
                    for dv=1:size(u_b2,3)
                        vort_b2(:,:,dv)=((10^5).*curl(glon_b2'*111110,glat_b2'*111110,u_b2(:,:,dv)',v_b2(:,:,dv)'))';
                        divg_b2(:,:,dv)=((10^5).*divergence(glon_b2'*111110,glat_b2'*111110,u_b2(:,:,dv)',v_b2(:,:,dv)'))';
                        vort_a2(:,:,dv)=((10^5).*curl(glon_a2'*111110,glat_a2'*111110,u_a2(:,:,dv)',v_a2(:,:,dv)'))';
                        divg_a2(:,:,dv)=((10^5).*divergence(glon_a2'*111110,glat_a2'*111110,u_a2(:,:,dv)',v_a2(:,:,dv)'))';
                        vort_b3(:,:,dv)=((10^5).*curl(glon_b3'*111110,glat_b3'*111110,u_b3(:,:,dv)',v_b3(:,:,dv)'))';
                        divg_b3(:,:,dv)=((10^5).*divergence(glon_b3'*111110,glat_b3'*111110,u_b3(:,:,dv)',v_b3(:,:,dv)'))';
                        vort_a3(:,:,dv)=((10^5).*curl(glon_a3'*111110,glat_a3'*111110,u_a3(:,:,dv)',v_a3(:,:,dv)'))';
                        divg_a3(:,:,dv)=((10^5).*divergence(glon_a3'*111110,glat_a3'*111110,u_a3(:,:,dv)',v_a3(:,:,dv)'))';
                    end                                        

                    % Centers
                    stmcn_b2=vort_b2;
                    stmcn_b2(1:(388/2-50),:,:)=NaN;
                    stmcn_b2((388/2+50):end,:,:)=NaN;
                    stmcn_b2(:,1:(778/2-50),:)=NaN;
                    stmcn_b2(:,(778/2+50):end,:)=NaN;
                    maximum = squeeze(squeeze(max(max(stmcn_b2))));
                    for sci=22 % around 850 hPa
                        [ysc_b2,xsc_b2]=find(stmcn_b2(:,:,sci)==maximum(sci));  
                    end

                    stmcn_a2=vort_a2;
                    stmcn_a2(1:(388/2-50),:,:)=NaN;
                    stmcn_a2((388/2+50):end,:,:)=NaN;
                    stmcn_a2(:,1:(778/2-50),:)=NaN;
                    stmcn_a2(:,(778/2+50):end,:)=NaN;
                    maximum = squeeze(squeeze(max(max(stmcn_a2))));
                    for sci=22 % around 850 hPa
                        [ysc_a2,xsc_a2]=find(stmcn_a2(:,:,sci)==maximum(sci));  
                    end

                    stmcn_b3=vort_b3;
                    stmcn_b3(1:(498/2-100),:,:)=NaN;
                    stmcn_b3((498/2+100):end,:,:)=NaN;
                    stmcn_b3(:,1:(1000/2-100),:)=NaN;
                    stmcn_b3(:,(1000/2+100):end,:)=NaN;
                    maximum = squeeze(squeeze(max(max(stmcn_b3))));
                    for sci=22 % around 850 hPa
                        [ysc_b3,xsc_b3]=find(stmcn_b3(:,:,sci)==maximum(sci));  
                    end
                    stmcn_a3=vort_a3;
                    stmcn_a3(1:(498/2-100),:,:)=NaN;
                    stmcn_a3((498/2+100):end,:,:)=NaN;
                    stmcn_a3(:,1:(1000/2-100),:)=NaN;
                    stmcn_a3(:,(1000/2+100):end,:)=NaN;
                    maximum = squeeze(squeeze(max(max(stmcn_a3))));
                    for sci=22 % around 850 hPa
                        [ysc_a3,xsc_a3]=find(stmcn_a3(:,:,sci)==maximum(sci));  
                    end
                    
                    % Find the storm center
                    LATall=EXP_lat(identloop,(str2num(num2str(3*(identfhr-1),'%03d'))/3)+1,hwrfvariables);
                    LONall=EXP_lon(identloop,(str2num(num2str(3*(identfhr-1),'%03d'))/3)+1,hwrfvariables);                                         

                    run customcolorbars
                end
            end
            % Assign to EXP
            MSLP_B2(:,hwrfvariables)=[ysc_b2;xsc_b2];
            MSLP_A2(:,hwrfvariables)=[ysc_a2;xsc_a2];
            MSLP_B3(:,hwrfvariables)=[ysc_b3;xsc_b3];
            MSLP_A3(:,hwrfvariables)=[ysc_a3;xsc_a3];
            PLEV2(:,hwrfvariables)=plev_b2;
            PLEV3(:,hwrfvariables)=plev_b3;
            LATA(hwrfvariables)=LATall;
            LONA(hwrfvariables)=LONall;
            GLON_2(:,:,hwrfvariables)=glon_a2;
            GLAT_2(:,:,hwrfvariables)=glat_a2;
            GLON_3(:,:,hwrfvariables)=glon_a3;
            GLAT_3(:,:,hwrfvariables)=glat_a3;
            WS_B2(:,:,:,hwrfvariables)=ws_b2;
            WS_B3(:,:,:,hwrfvariables)=ws_b3;
            WS_A2(:,:,:,hwrfvariables)=ws_a2;
            WS_A3(:,:,:,hwrfvariables)=ws_a3;
            RH_B2(:,:,:,hwrfvariables)=rh_b2;
            RH_B3(:,:,:,hwrfvariables)=rh_b3;
            RH_A2(:,:,:,hwrfvariables)=rh_a2;
            RH_A3(:,:,:,hwrfvariables)=rh_a3;
            U_B2(:,:,:,hwrfvariables)=u_b2;
            U_B3(:,:,:,hwrfvariables)=u_b3;
            U_A2(:,:,:,hwrfvariables)=u_a2;
            U_A3(:,:,:,hwrfvariables)=u_a3;
            V_B2(:,:,:,hwrfvariables)=v_b2;
            V_B3(:,:,:,hwrfvariables)= v_b3;
            V_A2(:,:,:,hwrfvariables)= v_a2;
            V_A3(:,:,:,hwrfvariables)= v_a3; 
            RVRT_B2(:,:,:,hwrfvariables)=vort_b2;
            RVRT_B3(:,:,:,hwrfvariables)= vort_b3;
            RVRT_A2(:,:,:,hwrfvariables)= vort_a2;
            RVRT_A3(:,:,:,hwrfvariables)= vort_a3; 
            DIVG_B2(:,:,:,hwrfvariables)=divg_b2;
            DIVG_B3(:,:,:,hwrfvariables)= divg_b3;
            DIVG_A2(:,:,:,hwrfvariables)= divg_a2;
            DIVG_A3(:,:,:,hwrfvariables)= divg_a3;            
            Q_B2(:,:,:,hwrfvariables)=q_b2;
            Q_B3(:,:,:,hwrfvariables)= q_b3;
            Q_A2(:,:,:,hwrfvariables)= q_a2;
            Q_A3(:,:,:,hwrfvariables)= q_a3;            
            T_B2(:,:,:,hwrfvariables)=t_b2;
            T_B3(:,:,:,hwrfvariables)= t_b3;
            T_A2(:,:,:,hwrfvariables)= t_a2;
            T_A3(:,:,:,hwrfvariables)= t_a3;
            PT_B2(:,:,:,hwrfvariables)=pt_b2;
            PT_B3(:,:,:,hwrfvariables)= pt_b3;
            PT_A2(:,:,:,hwrfvariables)= pt_a2;
            PT_A3(:,:,:,hwrfvariables)= pt_a3; 
            P_B2(:,:,:,hwrfvariables)=pint_b2;
            P_B3(:,:,:,hwrfvariables)= pint_b3;
            P_A2(:,:,:,hwrfvariables)= pint_a2;
            P_A3(:,:,:,hwrfvariables)= pint_a3;
            SM_B2(:,:,:,hwrfvariables)=sm_b2;
            SM_B3(:,:,:,hwrfvariables)= sm_b3;
            SM_A2(:,:,:,hwrfvariables)= sm_a2;
            SM_A3(:,:,:,hwrfvariables)= sm_a3;
            ANOM_B2(:,hwrfvariables)=anom_b2;
            ANOM_A2(:,hwrfvariables)=anom_a2;
            ANOM_B3(:,hwrfvariables)=anom_b3;
            ANOM_A3(:,hwrfvariables)=anom_a3;
            clearvars -except skip* ident* hwrfvariables mslp* ANOM* PT* SM* WS* RVRT* DIVG_* MSLP* PLEV* RH_* V_* U_* GLON_* GLAT_* LONA LATA P_* T_* Q_*
            disp(['COMPLETED CYCLE #', num2str(identloop),' for ',identexp0,'!'])
       end
       disp(['STARTING HWRFDA GRAPHICS: EXPERIMENT COMPARISION'])   
       for df=1:size(identdiff,1)
            % Set Experiments
            exp1=identdiff(df,1);
            exp2=identdiff(df,2);
            load([identout,'RESULTS/',identfold,identn,'/',identn,'_latlon.mat']);
            for identfhr=1 % init time only
                if isnan(BT_lat(identloop,identfhr))==1
                    disp('BT has a NaN...skipping date!')
                else      
                    % Find the storm center
                    run customcolorbars
                    identvar=1;
                    for varloop=1:9
                        if varloop==1
                            identvariables={'u-component_of_wind_isobaric'};
                            tmp1=U_B2;
                            tmp2=U_A2;
                            tmp3=U_B3;
                            tmp4=U_A3;
                        elseif varloop==2
                            identvariables={'v-component_of_wind_isobaric'};
                            tmp1=V_B2;
                            tmp2=V_A2;
                            tmp3=V_B3;
                            tmp4=V_A3;
                        elseif varloop==3
                            identvariables={'Relative_humidity_isobaric'};
                            tmp1=RH_B2;
                            tmp2=RH_A2;
                            tmp3=RH_B3;
                            tmp4=RH_A3;                                                       
                        elseif varloop==4
                            identvariables={'wind_speed_isobaric'};
                            tmp1=WS_B2;
                            tmp2=WS_A2;
                            tmp3=WS_B3;
                            tmp4=WS_A3;
                        elseif varloop==5
                            identvariables={'Relative_vorticity_isobaric'};
                            tmp1=RVRT_B2;
                            tmp2=RVRT_A2;
                            tmp3=RVRT_B3;
                            tmp4=RVRT_A3;
                        elseif varloop==6
                            identvariables={'Divergence_isobaric'};
                            tmp1=DIVG_B2;
                            tmp2=DIVG_A2;
                            tmp3=DIVG_B3;
                            tmp4=DIVG_A3;
                        elseif varloop==7
                            identvariables={'Temperature_isobaric'};
                            tmp1=T_B2;
                            tmp2=T_A2;
                            tmp3=T_B3;
                            tmp4=T_A3;
                        elseif varloop==8
                            identvariables={'Specific_humidity_isobaric'};
                            tmp1=Q_B2.*1000;
                            tmp2=Q_A2.*1000;
                            tmp3=Q_B3.*1000;
                            tmp4=Q_A3.*1000;
                        elseif varloop==9
                            identvariables={'Pressure_isobaric'};
                            tmp1=P_B2/100;
                            tmp2=P_A2/100;
                            tmp3=P_B3/100;
                            tmp4=P_A3/100;                          
                        end

                        if varloop<9 % since hwrf output is in pressure levels
                            run customvariables
                        end
                        
                        % Azimuthal Averages
                        tmptmp1=tmp1(MSLP_B2(1,1)-140:MSLP_B2(1,1)+140,MSLP_B2(2,1)-140:MSLP_B2(2,1)+140,:,:);
                        radbin=0.033;
                        pltcen=140;
                        pltkm=500;
                        pltpt=ceil(pltkm/(radbin*111.11))+1; % to get to 500 km
                        rds=0:radbin*111.11:pltcen*radbin*111.11;
                        tmp1AZAV=nan(size(tmptmp1,3),size(2:pltpt+1,2),size(tmptmp1,4)); %preallocate                        
                        if varloop<3
                            % RADIAL WIND & TANGENTIAL WIND                    
                            rds2=sort(rds*-1);
                            rds=[rds2 rds(2:end)]';
                            [x,y] = meshgrid(rds,rds);
                            [theta,rho] = cart2pol(x,y);
                            theta=((flipud((theta+pi)')));
                            if varloop==1
                                tmptmp1=(U_B2(MSLP_B2(1,1)-140:MSLP_B2(1,1)+140,MSLP_B2(2,1)-140:MSLP_B2(2,1)+140,:,:).*cos(theta) + V_B2(MSLP_B2(1,1)-140:MSLP_B2(1,1)+140,MSLP_B2(2,1)-140:MSLP_B2(2,1)+140,:,:).*sin(theta));                                
                            elseif varloop==2
                                tmptmp1=(-U_B2(MSLP_B2(1,1)-140:MSLP_B2(1,1)+140,MSLP_B2(2,1)-140:MSLP_B2(2,1)+140,:,:).*sin(theta) + V_B2(MSLP_B2(1,1)-140:MSLP_B2(1,1)+140,MSLP_B2(2,1)-140:MSLP_B2(2,1)+140,:,:).*cos(theta));                    
                            end
                        end                        
                        rds=0:radbin*111.11:pltcen*radbin*111.11;
                        for t=1:size(tmp1,4)
                            cnt=2;
                            for i=2:pltpt 
                                inner_rad = rds(i-1)/radbin/111.11;
                                outer_rad = rds(i+1)/radbin/111.11;
                                center = pltcen+1;  %% this is not the center! FIX HERE
                                mask1_size = pltcen*2+1;
                                [x,y] = meshgrid(1:mask1_size,1:mask1_size);
                                distance = (x-center).^2+(y-center).^2;
                                mask = distance<outer_rad^2 & distance>inner_rad^2;
                                mask=repmat(mask,1,1,size(tmp1AZAV,1));
                                valtest=tmptmp1(:,:,:,t);
                                valtest(mask==0)=NaN;
                                tmp1AZAV(:,cnt,t)=squeeze(nanmean(nanmean(valtest,1),2));
                                rdsplt2(cnt)=rds(i);
                                cnt=cnt+1;                                
                            end                            
                            tmp1AZAV(:,1,t)=squeeze(tmptmp1(pltcen+1,pltcen+1,:,t));
                            rdsplt2(1)=rds(1);
                            t
                        end

                        tmptmp2=tmp2(MSLP_A2(1,1)-140:MSLP_A2(1,1)+140,MSLP_A2(2,1)-140:MSLP_A2(2,1)+140,:,:);
                        radbin=0.033;
                        pltcen=140;
                        pltkm=500;
                        pltpt=ceil(pltkm/(radbin*111.11))+1; % to get to 500 km
                        rds=0:radbin*111.11:pltcen*radbin*111.11;
                        tmp2AZAV=nan(size(tmptmp2,3),size(2:pltpt+1,2),size(tmptmp2,4)); %preallocate
                        if varloop<3
                            % RADIAL WIND & TANGENTIAL WIND                    
                            rds2=sort(rds*-1);
                            rds=[rds2 rds(2:end)]';
                            [x,y] = meshgrid(rds,rds);
                            [theta,rho] = cart2pol(x,y);
                            theta=((flipud((theta+pi)')));
                            if varloop==1
                                tmptmp2=(U_A2(MSLP_A2(1,1)-140:MSLP_A2(1,1)+140,MSLP_A2(2,1)-140:MSLP_A2(2,1)+140,:,:).*cos(theta) + V_A2(MSLP_A2(1,1)-140:MSLP_A2(1,1)+140,MSLP_A2(2,1)-140:MSLP_A2(2,1)+140,:,:).*sin(theta));                                
                            elseif varloop==2
                                tmptmp2=(-U_A2(MSLP_A2(1,1)-140:MSLP_A2(1,1)+140,MSLP_A2(2,1)-140:MSLP_A2(2,1)+140,:,:).*sin(theta) + V_A2(MSLP_A2(1,1)-140:MSLP_A2(1,1)+140,MSLP_A2(2,1)-140:MSLP_A2(2,1)+140,:,:).*cos(theta));                    
                            end
                        end 
                        rds=0:radbin*111.11:pltcen*radbin*111.11;
                        for t=1:size(tmp1,4)
                            cnt=2;
                            for i=2:pltpt 
                                inner_rad = rds(i-1)/radbin/111.11;
                                outer_rad = rds(i+1)/radbin/111.11;
                                center = pltcen+1;  %% this is not the center! FIX HERE
                                mask1_size = pltcen*2+1;
                                [x,y] = meshgrid(1:mask1_size,1:mask1_size);
                                distance = (x-center).^2+(y-center).^2;
                                mask = distance<outer_rad^2 & distance>inner_rad^2;
                                mask=repmat(mask,1,1,size(tmp2AZAV,1));
                                valtest=tmptmp2(:,:,:,t);
                                valtest(mask==0)=NaN;
                                tmp2AZAV(:,cnt,t)=squeeze(nanmean(nanmean(valtest,1),2));
                                rdsplt2(cnt)=rds(i);
                                cnt=cnt+1;                                
                            end                            
                            tmp2AZAV(:,1,t)=squeeze(tmptmp2(pltcen+1,pltcen+1,:,t));
                            rdsplt2(1)=rds(1);
                            t
                        end

                        tmptmp3=tmp3(MSLP_B3(1,1)-210:MSLP_B3(1,1)+210,MSLP_B3(2,1)-210:MSLP_B3(2,1)+210,:,:);
                        radbin=0.011;
                        pltcen=210;
                        pltkm=250;
                        pltpt=ceil(pltkm/(radbin*111.11))+1; % to get to 250 km
                        rds=0:radbin*111.11:pltcen*radbin*111.11;
                        tmp3AZAV=nan(size(tmptmp3,3),size(2:pltpt+1,2),size(tmptmp3,4)); %preallocate
                        if varloop<3
                            % RADIAL WIND & TANGENTIAL WIND                    
                            rds2=sort(rds*-1);
                            rds=[rds2 rds(2:end)]';
                            [x,y] = meshgrid(rds,rds);
                            [theta,rho] = cart2pol(x,y);
                            theta=((flipud((theta+pi)')));
                            if varloop==1
                                tmptmp3=(U_B3(MSLP_B3(1,1)-210:MSLP_B3(1,1)+210,MSLP_B3(2,1)-210:MSLP_B3(2,1)+210,:,:).*cos(theta) + V_B3(MSLP_B3(1,1)-210:MSLP_B3(1,1)+210,MSLP_B3(2,1)-210:MSLP_B3(2,1)+210,:,:).*sin(theta));                                
                            elseif varloop==2
                                tmptmp3=(-U_B3(MSLP_B3(1,1)-210:MSLP_B3(1,1)+210,MSLP_B3(2,1)-210:MSLP_B3(2,1)+210,:,:).*sin(theta) + V_B3(MSLP_B3(1,1)-210:MSLP_B3(1,1)+210,MSLP_B3(2,1)-210:MSLP_B3(2,1)+210,:,:).*cos(theta));                    
                            end
                        end
                        rds=0:radbin*111.11:pltcen*radbin*111.11;
                        for t=1:size(tmp3,4)
                            cnt=2;
                            for i=2:pltpt 
                                inner_rad = rds(i-1)/radbin/111.11;
                                outer_rad = rds(i+1)/radbin/111.11;
                                center = pltcen+1;  %% this is not the center! FIX HERE
                                mask1_size = pltcen*2+1;
                                [x,y] = meshgrid(1:mask1_size,1:mask1_size);
                                distance = (x-center).^2+(y-center).^2;
                                mask = distance<outer_rad^2 & distance>inner_rad^2;
                                mask=repmat(mask,1,1,size(tmp3AZAV,1));
                                valtest=tmptmp3(:,:,:,t);
                                valtest(mask==0)=NaN;
                                tmp3AZAV(:,cnt,t)=squeeze(nanmean(nanmean(valtest,1),2));
                                rdsplt3(cnt)=rds(i);
                                cnt=cnt+1;                                
                            end                            
                            tmp3AZAV(:,1,t)=squeeze(tmptmp3(pltcen+1,pltcen+1,:,t));
                            rdsplt3(1)=rds(1);
                            t
                        end

                        tmptmp4=tmp4(MSLP_A3(1,1)-210:MSLP_A3(1,1)+210,MSLP_A3(2,1)-210:MSLP_A3(2,1)+210,:,:);
                        radbin=0.011;
                        pltcen=210;
                        pltkm=250;
                        pltpt=ceil(pltkm/(radbin*111.11))+1; % to get to 500 km
                        rds=0:radbin*111.11:pltcen*radbin*111.11;
                        tmp4AZAV=nan(size(tmptmp4,3),size(2:pltpt+1,2),size(tmptmp4,4)); %preallocate
                        if varloop<3
                            % RADIAL WIND & TANGENTIAL WIND                    
                            rds2=sort(rds*-1);
                            rds=[rds2 rds(2:end)]';
                            [x,y] = meshgrid(rds,rds);
                            [theta,rho] = cart2pol(x,y);
                            theta=((flipud((theta+pi)')));
                            if varloop==1
                                tmptmp4=(U_A3(MSLP_A3(1,1)-210:MSLP_A3(1,1)+210,MSLP_A3(2,1)-210:MSLP_A3(2,1)+210,:,:).*cos(theta) + V_A3(MSLP_A3(1,1)-210:MSLP_A3(1,1)+210,MSLP_A3(2,1)-210:MSLP_A3(2,1)+210,:,:).*sin(theta));                                
                            elseif varloop==2
                                tmptmp4=(-U_A3(MSLP_A3(1,1)-210:MSLP_A3(1,1)+210,MSLP_A3(2,1)-210:MSLP_A3(2,1)+210,:,:).*sin(theta) + V_A3(MSLP_A3(1,1)-210:MSLP_A3(1,1)+210,MSLP_A3(2,1)-210:MSLP_A3(2,1)+210,:,:).*cos(theta));                    
                            end
                        end
                        rds=0:radbin*111.11:pltcen*radbin*111.11;
                        for t=1:size(tmp3,4)
                            cnt=2;
                            for i=2:pltpt 
                                inner_rad = rds(i-1)/radbin/111.11;
                                outer_rad = rds(i+1)/radbin/111.11;
                                center = pltcen+1;  %% this is not the center! FIX HERE
                                mask1_size = pltcen*2+1;
                                [x,y] = meshgrid(1:mask1_size,1:mask1_size);
                                distance = (x-center).^2+(y-center).^2;
                                mask = distance<outer_rad^2 & distance>inner_rad^2;
                                mask=repmat(mask,1,1,size(tmp3AZAV,1));
                                valtest=tmptmp4(:,:,:,t);
                                valtest(mask==0)=NaN;
                                tmp4AZAV(:,cnt,t)=squeeze(nanmean(nanmean(valtest,1),2));
                                rdsplt3(cnt)=rds(i);
                                cnt=cnt+1;                                
                            end                            
                            tmp4AZAV(:,1,t)=squeeze(tmptmp4(pltcen+1,pltcen+1,:,t));
                            rdsplt3(1)=rds(1);
                            t
                        end

                        % Setup Plan
                        diff2_1s=tmp2(:,:,:,exp1)-tmp1(:,:,:,exp1);
                        diff2_2s=tmp2(:,:,:,exp2)-tmp1(:,:,:,exp2);
                        diff2_3s=diff2_1s-diff2_2s;
                        diff2_1c=tmp1(:,:,:,exp1)-tmp1(:,:,:,exp2);
                        diff2_2c=tmp2(:,:,:,exp1)-tmp2(:,:,:,exp2);                            
                        tmp1(tmp1<cmin)=cmin;
                        tmp2(tmp2<cmin)=cmin;
                        diff2_1s(diff2_1s<dmin)=dmin;
                        diff2_2s(diff2_2s<dmin)=dmin;
                        diff2_3s(diff2_3s<dmin)=dmin;
                        diff2_1c(diff2_1c<dmin)=dmin;
                        diff2_2c(diff2_2c<dmin)=dmin; 
                        diff3_1s=tmp4(:,:,:,exp1)-tmp3(:,:,:,exp1);
                        diff3_2s=tmp4(:,:,:,exp2)-tmp3(:,:,:,exp2);
                        diff3_3s=diff3_1s-diff3_2s;
                        diff3_1c=tmp3(:,:,:,exp1)-tmp3(:,:,:,exp2);
                        diff3_2c=tmp4(:,:,:,exp1)-tmp4(:,:,:,exp2);                            
                        tmp3(tmp3<cmin)=cmin;
                        tmp4(tmp4<cmin)=cmin;
                        diff3_1s(diff3_1s<dmin)=dmin;
                        diff3_2s(diff3_2s<dmin)=dmin;
                        diff3_3s(diff3_3s<dmin)=dmin;
                        diff3_1c(diff3_1c<dmin)=dmin;
                        diff3_2c(diff3_2c<dmin)=dmin;
                                                
                        spPos1=[0.050    0.665    0.1829*1.2   0.2157*1.2];
                        spPos2=[0.380    0.665    0.1829*1.2   0.2157*1.2];
                        spPos3=[0.710    0.665    0.1829*1.2   0.2157*1.2];
                        spPos4=[0.050    0.380    0.1829*1.2   0.2157*1.2];
                        spPos5=[0.380    0.380    0.1829*1.2   0.2157*1.2];
                        spPos6=[0.710    0.380    0.1829*1.2   0.2157*1.2];
                        spPos7=[0.050    0.095    0.1829*1.2   0.2157*1.2];
                        spPos8=[0.380    0.095    0.1829*1.2   0.2157*1.2];
                        spPos9=[0.710    0.095    0.1829*1.2   0.2157*1.2];
                        
                        % Plot
                        % D02
                        plev=[850,500,200];
                        for plp=1:3
                            [val,idx]=min(abs(plev(plp) - PLEV2(:,1).'));
                            pla(plp)=idx;
                        end
                        cnt=1;
                        for pl=pla % 850, 500, 200 average sigma levels land mask
                            if varloop==9
                                tmp1=P_B2./100;
                                tmp2=P_A2./100;
                                tmp3=P_B3./100;
                                tmp4=P_A3./100;
                                units='hPa';
                                varname='Pressure';
                                savename='PRES';
                                vara=plev(cnt)-10;  % regular
                                varb=plev(cnt)+10;
                                var1=2; % difference
                                levs=1;  % 3d (1) 2d (0)
                                cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
                                cbar2=3;
                            elseif varloop==7
                                tmp1=T_B2;
                                tmp2=T_A2;
                                tmp3=T_B3;
                                tmp4=T_A3;
                                vara=round(mean(mean((tmp1(:,:,pl,1)))))-5;  % regular
                                varb=round(mean(mean((tmp1(:,:,pl,1)))))+5;
                                var1=2; % difference
                                levs=1;  % 3d (1) 2d (0)
                                cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
                                cbar2=3;                                
                            elseif varloop==8
                                tmp1=Q_B2.*1000;
                                tmp2=Q_A2.*1000;
                                tmp3=Q_B3.*1000;
                                tmp4=Q_A3.*1000;
                                units='g kg$^{-1}$';
                                vara=round(mean(mean((tmp1(:,:,pl,1)))))-5;  % regular
                                varb=round(mean(mean((tmp1(:,:,pl,1)))))+5;
                                var1=5; % difference
                                levs=1;  % 3d (1) 2d (0)
                                cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
                                cbar2=3;
                            end
                            if varloop==9 || varloop==7 || varloop==8                                
                                % Create bounds
                                cmin=vara;
                                if cbar1==8
                                cmax=179.6./1.94384;
                                cntr0=[vara varb];
                                cntr=[vara:(varb-vara)/28:varb];
                                cntr1=[vara:(varb-vara)/14:varb];  
                                else
                                cmax=varb;
                                cntr0=[vara varb];
                                cntr=[vara:(varb-vara)/20:varb];
                                cntr1=[vara:2*(varb-vara)/20:varb];  
                                end

                                dmin=-1*var1;
                                dmax=var1;
                                dcntr0=[-1*var1 var1];
                                dcntr=[-1*var1:var1/10:var1];
                                dcntr1=[-1*var1:2*var1/10:var1];
                                %% Set Colorbars
                                if cbar1==1
                                    WC1=negzeroc;
                                elseif cbar1==2
                                    WC1=zeroposc;
                                elseif cbar1==3
                                    WC1=negposc;
                                elseif cbar1==4
                                    WC1=wetc;
                                elseif cbar1==5
                                    WC1=drywetc;
                                elseif cbar1==6
                                    WC1=radarc;
                                elseif cbar1==7
                                    WC1=tpwc;
                                elseif cbar1==8
                                    WC1=windc;
                                end
                                if cbar2==1
                                    WC2=negzeroc;
                                elseif cbar2==2
                                    WC2=zeroposc;
                                elseif cbar2==3
                                    WC2=negposc;
                                elseif cbar2==4
                                    WC2=wetc;
                                elseif cbar2==5
                                    WC2=drywetc;
                                elseif cbar2==6
                                    WC2=radarc;
                                elseif cbar2==7
                                    WC2=tpwc;
                                end
                                % Refix Colorbars
                                diff2_1s=tmp2(:,:,:,exp1)-tmp1(:,:,:,exp1);
                                diff2_2s=tmp2(:,:,:,exp2)-tmp1(:,:,:,exp2);
                                diff2_3s=diff2_1s-diff2_2s;
                                diff2_1c=tmp1(:,:,:,exp1)-tmp1(:,:,:,exp2);
                                diff2_2c=tmp2(:,:,:,exp1)-tmp2(:,:,:,exp2);                            
                                tmp1(tmp1<cmin)=cmin;
                                tmp2(tmp2<cmin)=cmin;
                                diff2_1s(diff2_1s<dmin)=dmin;
                                diff2_2s(diff2_2s<dmin)=dmin;
                                diff2_3s(diff2_3s<dmin)=dmin;
                                diff2_1c(diff2_1c<dmin)=dmin;
                                diff2_2c(diff2_2c<dmin)=dmin; 
                                diff3_1s=tmp4(:,:,:,exp1)-tmp3(:,:,:,exp1);
                                diff3_2s=tmp4(:,:,:,exp2)-tmp3(:,:,:,exp2);
                                diff3_3s=diff3_1s-diff3_2s;
                                diff3_1c=tmp3(:,:,:,exp1)-tmp3(:,:,:,exp2);
                                diff3_2c=tmp4(:,:,:,exp1)-tmp4(:,:,:,exp2);                            
                                tmp3(tmp3<cmin)=cmin;
                                tmp4(tmp4<cmin)=cmin;
                                diff3_1s(diff3_1s<dmin)=dmin;
                                diff3_2s(diff3_2s<dmin)=dmin;
                                diff3_3s(diff3_3s<dmin)=dmin;
                                diff3_1c(diff3_1c<dmin)=dmin;
                                diff3_2c(diff3_2c<dmin)=dmin;
                            end
                            set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                            hfig=figure;
                            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                            ax1=subplot(3,3,1);
                            contourf(GLON_2(:,:,exp1),GLAT_2(:,:,exp1),tmp1(:,:,pl,exp1),cntr)
                            hold on
                            if varloop==4 || varloop<3
                                contour(GLON_2(:,:,exp1),GLAT_2(:,:,exp1),tmp1(:,:,pl,exp1),cntr)
                                windbarbm(GLAT_2(:,:,exp1),GLON_2(:,:,exp1),U_B2(:,:,pl,exp1),V_B2(:,:,pl,exp1),20,1,[0 0 0])
                            else
                                contourf(GLON_2(:,:,exp1),GLAT_2(:,:,exp1),tmp1(:,:,pl,exp1),cntr1,'k')
                            end
                            caxis([cmin cmax])
                            axis([GLON_2(194,389,exp1)-10 GLON_2(194,389,exp1)+10 GLAT_2(194,389,exp1)-10 GLAT_2(194,389,exp1)+10])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])                            
                            cl1=colorbar;
                            if varloop==4
                                colormap(gca,custommap(28,WC1))
                                set(cl1,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',10)
                                set(cl1,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
                                %text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.44,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.74,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');                                                
                            else
                                set(cl1,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',10)
                                adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl1,'YTicklabel',adaa) 
                            end
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)                                
                            ax2=subplot(3,3,2);
                            contourf(GLON_2(:,:,exp1),GLAT_2(:,:,exp1),tmp2(:,:,pl,exp1),cntr)
                            hold on
                            if varloop==4 || varloop<3
                                contour(GLON_2(:,:,exp1),GLAT_2(:,:,exp1),tmp2(:,:,pl,exp1),cntr)
                                windbarbm(GLAT_2(:,:,exp1),GLON_2(:,:,exp1),U_A2(:,:,pl,exp1),V_A2(:,:,pl,exp1),20,1,[0 0 0])
                            else
                                contourf(GLON_2(:,:,exp1),GLAT_2(:,:,exp1),tmp2(:,:,pl,exp1),cntr1,'k')
                            end
                            caxis([cmin cmax])
                            axis([GLON_2(194,389,exp1)-10 GLON_2(194,389,exp1)+10 GLAT_2(194,389,exp1)-10 GLAT_2(194,389,exp1)+10])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])
                            cl2=colorbar;
                            if varloop==4
                                colormap(gca,custommap(28,WC1))
                                set(cl2,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',10)
                                set(cl2,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
				%text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.44,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.74,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');                                                
                            else
                                set(cl2,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',10)
                                adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl2,'YTicklabel',adaa) 
                            end
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ A}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                            ax3=subplot(3,3,3);
                            contourf(GLON_2(:,:,exp1),GLAT_2(:,:,exp1),diff2_1s(:,:,pl),dcntr)
                            hold on
                            if varloop==4 || varloop<3
                                contour(GLON_2(:,:,exp1),GLAT_2(:,:,exp1),diff2_1s(:,:,pl),dcntr)
                                windbarbm(GLAT_2(:,:,exp1),GLON_2(:,:,exp1),U_B2(:,:,pl,exp1),V_B2(:,:,pl,exp1),20,1,[1 1 1])
                                windbarbm(GLAT_2(:,:,exp1),GLON_2(:,:,exp1),U_A2(:,:,pl,exp1),V_A2(:,:,pl,exp1),20,1,[0 0 0])
                            else
                                contourf(GLON_2(:,:,exp1),GLAT_2(:,:,exp1),diff2_1s(:,:,pl),dcntr1,'k')
                            end
                            caxis([dmin dmax])
                            axis([GLON_2(194,389,exp1)-10 GLON_2(194,389,exp1)+10 GLAT_2(194,389,exp1)-10 GLAT_2(194,389,exp1)+10])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])
                            cl3=colorbar;
                            set(cl3,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                            adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                            if sum(adaa)>0
                            else
                                adaa((size(adaa,2)+1)/2)=0;
                            end
                            set(cl3,'YTicklabel',adaa)
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ A-B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                            ax4=subplot(3,3,4);
                            contourf(GLON_2(:,:,exp2),GLAT_2(:,:,exp2),tmp1(:,:,pl,exp2),cntr)
                            hold on
                            if varloop==4 || varloop<3
                                contour(GLON_2(:,:,exp2),GLAT_2(:,:,exp2),tmp1(:,:,pl,exp2),cntr)
                                windbarbm(GLAT_2(:,:,exp2),GLON_2(:,:,exp2),U_B2(:,:,pl,exp2),V_B2(:,:,pl,exp2),20,1,[0 0 0])
                            else
                                contourf(GLON_2(:,:,exp2),GLAT_2(:,:,exp2),tmp1(:,:,pl,exp2),cntr1,'k')
                            end
                            caxis([cmin cmax])
                            axis([GLON_2(194,389,exp2)-10 GLON_2(194,389,exp2)+10 GLAT_2(194,389,exp2)-10 GLAT_2(194,389,exp2)+10])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])
                            cl4=colorbar;
                            if varloop==4
                                colormap(gca,custommap(28,WC1))
                                set(cl4,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',10)
                                set(cl4,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
				%text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.44,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.74,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');                                                
                            else
                                set(cl4,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',10)
                                adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl4,'YTicklabel',adaa) 
                            end
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                            ax5=subplot(3,3,5);
                            contourf(GLON_2(:,:,exp2),GLAT_2(:,:,exp2),tmp2(:,:,pl,exp2),cntr)
                            hold on
                            if varloop==4 || varloop<3
                                contour(GLON_2(:,:,exp2),GLAT_2(:,:,exp2),tmp2(:,:,pl,exp2),cntr)
                                windbarbm(GLAT_2(:,:,exp2),GLON_2(:,:,exp2),U_A2(:,:,pl,exp2),V_A2(:,:,pl,exp2),20,1,[0 0 0])
                            else
                                contourf(GLON_2(:,:,exp2),GLAT_2(:,:,exp2),tmp2(:,:,pl,exp2),cntr1,'k')
                            end
                            caxis([cmin cmax])
                            axis([GLON_2(194,389,exp2)-10 GLON_2(194,389,exp2)+10 GLAT_2(194,389,exp2)-10 GLAT_2(194,389,exp2)+10])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])
                            cl5=colorbar;
                            if varloop==4
                                colormap(gca,custommap(28,WC1))
                                set(cl5,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',10)
                                set(cl5,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
				%text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.44,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.74,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');                                                
                            else
                                set(cl5,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',10)
                                adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl5,'YTicklabel',adaa) 
                            end 
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ A}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                            ax6=subplot(3,3,6);
                            contourf(GLON_2(:,:,exp2),GLAT_2(:,:,exp2),diff2_2s(:,:,pl),dcntr)
                            hold on
                            if varloop==4 || varloop<3
                                contour(GLON_2(:,:,exp2),GLAT_2(:,:,exp2),diff2_2s(:,:,pl),dcntr)
                                windbarbm(GLAT_2(:,:,exp2),GLON_2(:,:,exp2),U_B2(:,:,pl,exp2),V_B2(:,:,pl,exp2),20,1,[1 1 1])
                                windbarbm(GLAT_2(:,:,exp2),GLON_2(:,:,exp2),U_A2(:,:,pl,exp2),V_A2(:,:,pl,exp2),20,1,[0 0 0])
                            else
                                contourf(GLON_2(:,:,exp2),GLAT_2(:,:,exp2),diff2_2s(:,:,pl),dcntr1,'k')
                            end
                            caxis([dmin dmax])
                            axis([GLON_2(194,389,exp2)-10 GLON_2(194,389,exp2)+10 GLAT_2(194,389,exp2)-10 GLAT_2(194,389,exp2)+10])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])
                            cl6=colorbar;
                            set(cl6,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                            adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                            if sum(adaa)>0
                            else
                                adaa((size(adaa,2)+1)/2)=0;
                            end
                            set(cl6,'YTicklabel',adaa)
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ A-B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                            ax7=subplot(3,3,7);
                            contourf(GLON_2(:,:,exp2),GLAT_2(:,:,exp2),diff2_1c(:,:,pl),dcntr)
                            hold on
                            if varloop==4 || varloop<3
                                contour(GLON_2(:,:,exp2),GLAT_2(:,:,exp2),diff2_1c(:,:,pl),dcntr)
                                windbarbm(GLAT_2(:,:,exp2),GLON_2(:,:,exp2),U_B2(:,:,pl,exp2),V_B2(:,:,pl,exp2),20,1,[1 1 1])
                                windbarbm(GLAT_2(:,:,exp1),GLON_2(:,:,exp1),U_B2(:,:,pl,exp1),V_B2(:,:,pl,exp1),20,1,[0 0 0])
                            else
                                contourf(GLON_2(:,:,exp2),GLAT_2(:,:,exp2),diff2_1c(:,:,pl),dcntr1,'k')
                            end
                            caxis([dmin dmax])
                            axis([GLON_2(194,389,exp2)-10 GLON_2(194,389,exp2)+10 GLAT_2(194,389,exp2)-10 GLAT_2(194,389,exp2)+10])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])
                            cl7=colorbar;
                            set(cl7,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                            adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                            if sum(adaa)>0
                            else
                                adaa((size(adaa,2)+1)/2)=0;
                            end
                            set(cl7,'YTicklabel',adaa)
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                            text(1,1.08,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                            text(0.98,1.08,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');                                            
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                            ax8=subplot(3,3,8);
                            contourf(GLON_2(:,:,exp2),GLAT_2(:,:,exp2),diff2_2c(:,:,pl),dcntr)
                            hold on
                            if varloop==4 || varloop<3
                                contour(GLON_2(:,:,exp2),GLAT_2(:,:,exp2),diff2_2c(:,:,pl),dcntr)
                                windbarbm(GLAT_2(:,:,exp2),GLON_2(:,:,exp2),U_A2(:,:,pl,exp2),V_A2(:,:,pl,exp2),20,1,[1 1 1])
                                windbarbm(GLAT_2(:,:,exp1),GLON_2(:,:,exp1),U_A2(:,:,pl,exp1),V_A2(:,:,pl,exp1),20,1,[0 0 0])
                            else
                                contourf(GLON_2(:,:,exp2),GLAT_2(:,:,exp2),diff2_2c(:,:,pl),dcntr1,'k')
                            end
                            caxis([dmin dmax])
                            axis([GLON_2(194,389,exp2)-10 GLON_2(194,389,exp2)+10 GLAT_2(194,389,exp2)-10 GLAT_2(194,389,exp2)+10])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])
                            cl8=colorbar;
                            set(cl8,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                            adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                            if sum(adaa)>0
                            else
                                adaa((size(adaa,2)+1)/2)=0;
                            end
                            set(cl8,'YTicklabel',adaa)
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                            text(1,1.08,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                            text(0.98,1.08,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');                                            
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ A}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                            ax9=subplot(3,3,9);
                            contourf(GLON_2(:,:,exp2),GLAT_2(:,:,exp2),diff2_3s(:,:,pl),dcntr)
                            hold on
                            contourf(GLON_2(:,:,exp2),GLAT_2(:,:,exp2),diff2_3s(:,:,pl),dcntr1,'k')
                            caxis([dmin dmax])
                            axis([GLON_2(194,389,exp2)-10 GLON_2(194,389,exp2)+10 GLAT_2(194,389,exp2)-10 GLAT_2(194,389,exp2)+10])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])
                            cl9=colorbar;
                            set(cl9,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                            adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                            if sum(adaa)>0
                            else
                                adaa((size(adaa,2)+1)/2)=0;
                            end
                            set(cl9,'YTicklabel',adaa)
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                            text(1,1.08,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                            text(0.98,1.08,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');                                            
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ A-B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)                               

                            % Rest of Plot
                            colormap(ax1,custommap(20,WC1))
                            colormap(ax2,custommap(20,WC1))
                            colormap(ax3,custommap(20,WC2))
                            colormap(ax4,custommap(20,WC1))
                            colormap(ax5,custommap(20,WC1))
                            colormap(ax6,custommap(20,WC2))
                            colormap(ax7,custommap(20,WC2))
                            colormap(ax8,custommap(20,WC2))
                            colormap(ax9,custommap(20,WC2))
                            set(gcf, 'InvertHardcopy', 'off')
                            set(gcf,'Units','inches');
                            screenposition = get(gcf,'Position');
                            set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                            set(gcf, 'InvertHardcopy', 'off')                                                                       
                            set(ax1,'Position',spPos1)
                            set(ax2,'Position',spPos2)
                            set(ax3,'Position',spPos3)
                            set(ax4,'Position',spPos4)
                            set(ax5,'Position',spPos5)
                            set(ax6,'Position',spPos6)
                            set(ax7,'Position',spPos7)
                            set(ax8,'Position',spPos8)
                            set(ax9,'Position',spPos9)                                
                            clP=get(cl1,'Position');
                            set(cl1,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
                            clP=get(cl2,'Position');
                            set(cl2,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
                            clP=get(cl3,'Position');
                            set(cl3,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
                            clP=get(cl4,'Position');
                            set(cl4,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
                            clP=get(cl5,'Position');
                            set(cl5,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
                            clP=get(cl6,'Position');
                            set(cl6,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
                            clP=get(cl7,'Position');
                            set(cl7,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
                            clP=get(cl8,'Position');
                            set(cl8,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
                            clP=get(cl9,'Position');
                            set(cl9,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
                            %f = getframe(hfig);
							filename=[identhwrfda,'/',identn,'_',identinittimesunique(identloop,:),'_PLEV',num2str(plev(cnt)),'_',savename,'_D02_HWRFDA'];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;print(filename,'-dpng');end;					                            
                            %imwrite(f.cdata,[identhwrfda,'/',identn,'_',identinittimesunique(identloop,:),'_PLEV',num2str(plev(cnt)),'_',savename,'_D02_HWRFDA.png'],'pdf');
                            close all 
                            cnt=cnt+1;
                        end

                        % D03
                        plev=[850,500,200];
                        for plp=1:3
                            [val,idx]=min(abs(plev(plp) - PLEV2(:,1).'));
                            pla(plp)=idx;
                        end
                        cnt=1;
                        for pl=pla % 850 (22), 500 (37), 200 (54) average sigma levels
                            if varloop==9
                                tmp1=P_B2./100;
                                tmp2=P_A2./100;
                                tmp3=P_B3./100;
                                tmp4=P_A3./100;
                                units='hPa';
                                varname='Pressure';
                                savename='PRES';
                                vara=plev(cnt)-10;  % regular
                                varb=plev(cnt)+10;
                                var1=2; % difference
                                levs=1;  % 3d (1) 2d (0)
                                cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
                                cbar2=3;
                            elseif varloop==7
                                tmp1=T_B2;
                                tmp2=T_A2;
                                tmp3=T_B3;
                                tmp4=T_A3;
                                if round(mean(mean((tmp1(:,:,pl,1)))))-5<0
                                    vara=0;
                                else
                                    vara=round(mean(mean((tmp1(:,:,pl,1)))))-5;  % regular
                                end
                                varb=round(mean(mean((tmp1(:,:,pl,1)))))+5;
                                var1=2; % difference
                                levs=1;  % 3d (1) 2d (0)
                                cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
                                cbar2=3;                                
                            elseif varloop==8
                                tmp1=Q_B2.*1000;
                                tmp2=Q_A2.*1000;
                                tmp3=Q_B3.*1000;
                                tmp4=Q_A3.*1000;
                                units='g kg$^{-1}$';
                                if round(mean(mean((tmp1(:,:,pl,1)))))-5<0
                                    vara=0;
                                else
                                    vara=round(mean(mean((tmp1(:,:,pl,1)))))-5;  % regular
                                end
                                varb=round(mean(mean((tmp1(:,:,pl,1)))))+5;
                                var1=5; % difference
                                levs=1;  % 3d (1) 2d (0)
                                cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
                                cbar2=3;
                            end
                            if varloop==9 || varloop==7 || varloop==8                                
                                % Create bounds
                                cmin=vara;
                                if cbar1==8
                                cmax=179.6./1.94384;
                                cntr0=[vara varb];
                                cntr=[vara:(varb-vara)/28:varb];
                                cntr1=[vara:(varb-vara)/14:varb];  
                                else
                                cmax=varb;
                                cntr0=[vara varb];
                                cntr=[vara:(varb-vara)/20:varb];
                                cntr1=[vara:2*(varb-vara)/20:varb];  
                                end

                                dmin=-1*var1;
                                dmax=var1;
                                dcntr0=[-1*var1 var1];
                                dcntr=[-1*var1:var1/10:var1];
                                dcntr1=[-1*var1:2*var1/10:var1];
                                %% Set Colorbars
                                if cbar1==1
                                    WC1=negzeroc;
                                elseif cbar1==2
                                    WC1=zeroposc;
                                elseif cbar1==3
                                    WC1=negposc;
                                elseif cbar1==4
                                    WC1=wetc;
                                elseif cbar1==5
                                    WC1=drywetc;
                                elseif cbar1==6
                                    WC1=radarc;
                                elseif cbar1==7
                                    WC1=tpwc;
                                elseif cbar1==8
                                    WC1=windc;
                                end
                                if cbar2==1
                                    WC2=negzeroc;
                                elseif cbar2==2
                                    WC2=zeroposc;
                                elseif cbar2==3
                                    WC2=negposc;
                                elseif cbar2==4
                                    WC2=wetc;
                                elseif cbar2==5
                                    WC2=drywetc;
                                elseif cbar2==6
                                    WC2=radarc;
                                elseif cbar2==7
                                    WC2=tpwc;
                                end
                                % Refix Colorbars
                                diff2_1s=tmp2(:,:,:,exp1)-tmp1(:,:,:,exp1);
                                diff2_2s=tmp2(:,:,:,exp2)-tmp1(:,:,:,exp2);
                                diff2_3s=diff2_1s-diff2_2s;
                                diff2_1c=tmp1(:,:,:,exp1)-tmp1(:,:,:,exp2);
                                diff2_2c=tmp2(:,:,:,exp1)-tmp2(:,:,:,exp2);                            
                                tmp1(tmp1<cmin)=cmin;
                                tmp2(tmp2<cmin)=cmin;
                                diff2_1s(diff2_1s<dmin)=dmin;
                                diff2_2s(diff2_2s<dmin)=dmin;
                                diff2_3s(diff2_3s<dmin)=dmin;
                                diff2_1c(diff2_1c<dmin)=dmin;
                                diff2_2c(diff2_2c<dmin)=dmin; 
                                diff3_1s=tmp4(:,:,:,exp1)-tmp3(:,:,:,exp1);
                                diff3_2s=tmp4(:,:,:,exp2)-tmp3(:,:,:,exp2);
                                diff3_3s=diff3_1s-diff3_2s;
                                diff3_1c=tmp3(:,:,:,exp1)-tmp3(:,:,:,exp2);
                                diff3_2c=tmp4(:,:,:,exp1)-tmp4(:,:,:,exp2);                            
                                tmp3(tmp3<cmin)=cmin;
                                tmp4(tmp4<cmin)=cmin;
                                diff3_1s(diff3_1s<dmin)=dmin;
                                diff3_2s(diff3_2s<dmin)=dmin;
                                diff3_3s(diff3_3s<dmin)=dmin;
                                diff3_1c(diff3_1c<dmin)=dmin;
                                diff3_2c(diff3_2c<dmin)=dmin;
                            end
                            set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                            hfig=figure;
                            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                            ax1=subplot(3,3,1);
                            contourf(GLON_3(:,:,exp1),GLAT_3(:,:,exp1),tmp3(:,:,pl,exp1),cntr)
                            hold on
                            if varloop==4 || varloop<3
                                contour(GLON_3(:,:,exp1),GLAT_3(:,:,exp1),tmp3(:,:,pl,exp1),cntr)
                                windbarbm(GLAT_3(:,:,exp1),GLON_3(:,:,exp1),U_B3(:,:,pl,exp1),V_B3(:,:,pl,exp1),40,1,[0 0 0])
                            else
                                contourf(GLON_3(:,:,exp1),GLAT_3(:,:,exp1),tmp3(:,:,pl,exp1),cntr1,'k')
                            end
                            caxis([cmin cmax])
                            axis([GLON_3(249,500,exp1)-5 GLON_3(249,500,exp1)+5 GLAT_3(249,500,exp1)-5 GLAT_3(249,500,exp1)+5])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])                            
                            cl1=colorbar;
                            if varloop==4
                                colormap(gca,custommap(28,WC1))
                                set(cl1,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',10)
                                set(cl1,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
                                %text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.44,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.74,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');                                                
                            else
                                set(cl1,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',10)
                                adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl1,'YTicklabel',adaa) 
                            end
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)                                
                            ax2=subplot(3,3,2);
                            contourf(GLON_3(:,:,exp1),GLAT_3(:,:,exp1),tmp4(:,:,pl,exp1),cntr)
                            hold on
                            if varloop==4 || varloop<3
                                contour(GLON_3(:,:,exp1),GLAT_3(:,:,exp1),tmp4(:,:,pl,exp1),cntr)
                                windbarbm(GLAT_3(:,:,exp1),GLON_3(:,:,exp1),U_A3(:,:,pl,exp1),V_A3(:,:,pl,exp1),40,1,[0 0 0])
                            else
                                contourf(GLON_3(:,:,exp1),GLAT_3(:,:,exp1),tmp4(:,:,pl,exp1),cntr1,'k')
                            end
                            caxis([cmin cmax])
                            axis([GLON_3(249,500,exp1)-5 GLON_3(249,500,exp1)+5 GLAT_3(249,500,exp1)-5 GLAT_3(249,500,exp1)+5])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])
                            cl2=colorbar;
                            if varloop==4
                                colormap(gca,custommap(28,WC1))
                                set(cl2,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',10)
                                set(cl2,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
                                %text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.44,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.74,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');                                                
                            else
                                set(cl2,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',10)
                                adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl2,'YTicklabel',adaa) 
                            end
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ A}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                            ax3=subplot(3,3,3);
                            contourf(GLON_3(:,:,exp1),GLAT_3(:,:,exp1),diff3_1s(:,:,pl),dcntr)
                            hold on
                            if varloop==4 || varloop<3
                                contour(GLON_3(:,:,exp1),GLAT_3(:,:,exp1),diff3_1s(:,:,pl),dcntr)
                                windbarbm(GLAT_3(:,:,exp1),GLON_3(:,:,exp1),U_B3(:,:,pl,exp1),V_B3(:,:,pl,exp1),40,1,[1 1 1])
                                windbarbm(GLAT_3(:,:,exp1),GLON_3(:,:,exp1),U_A3(:,:,pl,exp1),V_A3(:,:,pl,exp1),40,1,[0 0 0])
                            else
                                contourf(GLON_3(:,:,exp1),GLAT_3(:,:,exp1),diff3_1s(:,:,pl),dcntr1,'k')
                            end
                            caxis([dmin dmax])
                            axis([GLON_3(249,500,exp1)-5 GLON_3(249,500,exp1)+5 GLAT_3(249,500,exp1)-5 GLAT_3(249,500,exp1)+5])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])
                            cl3=colorbar;
                            set(cl3,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                            adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                            if sum(adaa)>0
                            else
                                adaa((size(adaa,2)+1)/2)=0;
                            end
                            set(cl3,'YTicklabel',adaa)
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ A-B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                            ax4=subplot(3,3,4);
                            contourf(GLON_3(:,:,exp2),GLAT_3(:,:,exp2),tmp3(:,:,pl,exp2),cntr)
                            hold on
                            if varloop==4 || varloop<3
                                contour(GLON_3(:,:,exp2),GLAT_3(:,:,exp2),tmp3(:,:,pl,exp2),cntr)
                                windbarbm(GLAT_3(:,:,exp2),GLON_3(:,:,exp2),U_B3(:,:,pl,exp2),V_B3(:,:,pl,exp2),40,1,[0 0 0])
                            else
                                contourf(GLON_3(:,:,exp2),GLAT_3(:,:,exp2),tmp3(:,:,pl,exp2),cntr1,'k')
                            end
                            caxis([cmin cmax])
                            axis([GLON_3(249,500,exp2)-5 GLON_3(249,500,exp2)+5 GLAT_3(249,500,exp2)-5 GLAT_3(249,500,exp2)+5])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])
                            cl4=colorbar;
                            if varloop==4
                                colormap(gca,custommap(28,WC1))
                                set(cl4,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',10)
                                set(cl4,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
                                %text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.44,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.74,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');                                                
                            else
                                set(cl4,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',10)
                                adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl4,'YTicklabel',adaa) 
                            end
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                            ax5=subplot(3,3,5);
                            contourf(GLON_3(:,:,exp2),GLAT_3(:,:,exp2),tmp4(:,:,pl,exp2),cntr)
                            hold on
                            if varloop==4 || varloop<3
                                contour(GLON_3(:,:,exp2),GLAT_3(:,:,exp2),tmp4(:,:,pl,exp2),cntr)
                                windbarbm(GLAT_3(:,:,exp2),GLON_3(:,:,exp2),U_A3(:,:,pl,exp2),V_A3(:,:,pl,exp2),40,1,[0 0 0])
                            else
                                contourf(GLON_3(:,:,exp2),GLAT_3(:,:,exp2),tmp4(:,:,pl,exp2),cntr1,'k')
                            end
                            caxis([cmin cmax])
                            axis([GLON_3(249,500,exp2)-5 GLON_3(249,500,exp2)+5 GLAT_3(249,500,exp2)-5 GLAT_3(249,500,exp2)+5])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])
                            cl5=colorbar;
                            if varloop==4
                                colormap(gca,custommap(28,WC1))
                                set(cl5,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',10)
                                set(cl5,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
                                %text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.44,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                %text(1.21,.74,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');                                                
                            else
                                set(cl5,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',10)
                                adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl5,'YTicklabel',adaa) 
                            end 
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ A}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                            ax6=subplot(3,3,6);
                            contourf(GLON_3(:,:,exp2),GLAT_3(:,:,exp2),diff3_2s(:,:,pl),dcntr)
                            hold on
                            if varloop==4 || varloop<3
                                contour(GLON_3(:,:,exp2),GLAT_3(:,:,exp2),diff3_2s(:,:,pl),dcntr)
                                windbarbm(GLAT_3(:,:,exp2),GLON_3(:,:,exp2),U_B3(:,:,pl,exp2),V_B3(:,:,pl,exp2),40,1,[1 1 1])
                                windbarbm(GLAT_3(:,:,exp2),GLON_3(:,:,exp2),U_A3(:,:,pl,exp2),V_A3(:,:,pl,exp2),40,1,[0 0 0])
                            else
                                contourf(GLON_3(:,:,exp2),GLAT_3(:,:,exp2),diff3_2s(:,:,pl),dcntr1,'k')
                            end
                            caxis([dmin dmax])
                            axis([GLON_3(249,500,exp2)-5 GLON_3(249,500,exp2)+5 GLAT_3(249,500,exp2)-5 GLAT_3(249,500,exp2)+5])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])
                            cl6=colorbar;
                            set(cl6,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                            adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                            if sum(adaa)>0
                            else
                                adaa((size(adaa,2)+1)/2)=0;
                            end
                            set(cl6,'YTicklabel',adaa)
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ A-B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                            ax7=subplot(3,3,7);
                            contourf(GLON_3(:,:,exp2),GLAT_3(:,:,exp2),diff3_1c(:,:,pl),dcntr)
                            hold on
                            if varloop==4 || varloop<3
                                contour(GLON_3(:,:,exp2),GLAT_3(:,:,exp2),diff3_1c(:,:,pl),dcntr)
                                windbarbm(GLAT_3(:,:,exp2),GLON_3(:,:,exp2),U_B3(:,:,pl,exp2),V_B3(:,:,pl,exp2),40,1,[1 1 1])
                                windbarbm(GLAT_3(:,:,exp1),GLON_3(:,:,exp1),U_B3(:,:,pl,exp1),V_B3(:,:,pl,exp1),40,1,[0 0 0])
                            else
                                contourf(GLON_3(:,:,exp2),GLAT_3(:,:,exp2),diff3_1c(:,:,pl),dcntr1,'k')
                            end
                            caxis([dmin dmax])
                            axis([GLON_3(249,500,exp2)-5 GLON_3(249,500,exp2)+5 GLAT_3(249,500,exp2)-5 GLAT_3(249,500,exp2)+5])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])
                            cl7=colorbar;
                            set(cl7,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                            adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                            if sum(adaa)>0
                            else
                                adaa((size(adaa,2)+1)/2)=0;
                            end
                            set(cl7,'YTicklabel',adaa)
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                            text(1,1.08,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                            text(0.98,1.08,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');                                            
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                            ax8=subplot(3,3,8);
                            contourf(GLON_3(:,:,exp2),GLAT_3(:,:,exp2),diff3_2c(:,:,pl),dcntr)
                            hold on
                            if varloop==4 || varloop<3
                                contour(GLON_3(:,:,exp2),GLAT_3(:,:,exp2),diff3_2c(:,:,pl),dcntr)
                                windbarbm(GLAT_3(:,:,exp2),GLON_3(:,:,exp2),U_A3(:,:,pl,exp2),V_A3(:,:,pl,exp2),40,1,[1 1 1])
                                windbarbm(GLAT_3(:,:,exp1),GLON_3(:,:,exp1),U_A3(:,:,pl,exp1),V_A3(:,:,pl,exp1),40,1,[0 0 0])
                            else
                                contourf(GLON_3(:,:,exp2),GLAT_3(:,:,exp2),diff3_2c(:,:,pl),dcntr1,'k')
                            end
                            caxis([dmin dmax])
                            axis([GLON_3(249,500,exp2)-5 GLON_3(249,500,exp2)+5 GLAT_3(249,500,exp2)-5 GLAT_3(249,500,exp2)+5])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])
                            cl8=colorbar;
                            set(cl8,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                            adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                            if sum(adaa)>0
                            else
                                adaa((size(adaa,2)+1)/2)=0;
                            end
                            set(cl8,'YTicklabel',adaa)
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                            text(1,1.08,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                            text(0.98,1.08,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');                                            
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ A}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                            ax9=subplot(3,3,9);
                            contourf(GLON_3(:,:,exp2),GLAT_3(:,:,exp2),diff3_3s(:,:,pl),dcntr)
                            hold on
                            contourf(GLON_3(:,:,exp2),GLAT_3(:,:,exp2),diff3_3s(:,:,pl),dcntr1,'k')
                            caxis([dmin dmax])
                            axis([GLON_3(249,500,exp2)-5 GLON_3(249,500,exp2)+5 GLAT_3(249,500,exp2)-5 GLAT_3(249,500,exp2)+5])
                            load coastlines
                            plot(coastlon,coastlat,'k','linewidth',2);
                            xlabel('Longitude','fontsize',20)
                            ylabel('Latitude','fontsize',20)
                            set(gca,'fontsize',9)
                            set(gca,'plotboxaspectratio',[1 1 1])
                            cl9=colorbar;
                            set(cl9,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                            adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                            if sum(adaa)>0
                            else
                                adaa((size(adaa,2)+1)/2)=0;
                            end
                            set(cl9,'YTicklabel',adaa)
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                            text(1,1.08,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                            text(0.98,1.08,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');                                            
                            text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV*: ',num2str(plev(cnt)),' $\mid$ A-B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                            text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                            %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)                               

                            % Rest of Plot
                            colormap(ax1,custommap(20,WC1))
                            colormap(ax2,custommap(20,WC1))
                            colormap(ax3,custommap(20,WC2))
                            colormap(ax4,custommap(20,WC1))
                            colormap(ax5,custommap(20,WC1))
                            colormap(ax6,custommap(20,WC2))
                            colormap(ax7,custommap(20,WC2))
                            colormap(ax8,custommap(20,WC2))
                            colormap(ax9,custommap(20,WC2))
                            set(gcf, 'InvertHardcopy', 'off')
                            set(gcf,'Units','inches');
                            screenposition = get(gcf,'Position');
                            set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                            set(gcf, 'InvertHardcopy', 'off')                                                                       
                            set(ax1,'Position',spPos1)
                            set(ax2,'Position',spPos2)
                            set(ax3,'Position',spPos3)
                            set(ax4,'Position',spPos4)
                            set(ax5,'Position',spPos5)
                            set(ax6,'Position',spPos6)
                            set(ax7,'Position',spPos7)
                            set(ax8,'Position',spPos8)
                            set(ax9,'Position',spPos9)                                
                            clP=get(cl1,'Position');
                            set(cl1,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
                            clP=get(cl2,'Position');
                            set(cl2,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
                            clP=get(cl3,'Position');
                            set(cl3,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
                            clP=get(cl4,'Position');
                            set(cl4,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
                            clP=get(cl5,'Position');
                            set(cl5,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
                            clP=get(cl6,'Position');
                            set(cl6,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
                            clP=get(cl7,'Position');
                            set(cl7,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
                            clP=get(cl8,'Position');
                            set(cl8,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
                            clP=get(cl9,'Position');
                            set(cl9,'Position',[clP(1)+.02 clP(2)+.02 0.01 clP(4)-.04])
							filename=[identhwrfda,'/',identn,'_',identinittimesunique(identloop,:),'_PLEV',num2str(plev(cnt)),'_',savename,'_D03_HWRFDA'];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;print(filename,'-dpng');end;					                            
                            close all 
                            cnt=cnt+1;
                        end                        
                        if varloop==9
                        else 
                            % Setup AZAV   
                            if varloop==1
                                identvariables={'radial-component_of_wind_isobaric'};                            
                                run customvariables
                            elseif varloop==2
                                identvariables={'tangential-component_of_wind_isobaric'};                            
                                run customvariables
                            end

                            diff2_1sAZAV=tmp2AZAV(:,:,exp1)-tmp1AZAV(:,:,exp1);
                            diff2_2sAZAV=tmp2AZAV(:,:,exp2)-tmp1AZAV(:,:,exp2);
                            diff2_3sAZAV=diff2_1sAZAV-diff2_2sAZAV;
                            diff2_1cAZAV=tmp1AZAV(:,:,exp1)-tmp1AZAV(:,:,exp2);
                            diff2_2cAZAV=tmp2AZAV(:,:,exp1)-tmp2AZAV(:,:,exp2);                            
                            tmp1AZAV(tmp1AZAV<cmin)=cmin;
                            tmp2AZAV(tmp2AZAV<cmin)=cmin;
                            diff2_1sAZAV(diff2_1sAZAV<dmin)=dmin;
                            diff2_2sAZAV(diff2_2sAZAV<dmin)=dmin;
                            diff2_3sAZAV(diff2_3sAZAV<dmin)=dmin;
                            diff2_1cAZAV(diff2_1cAZAV<dmin)=dmin;
                            diff2_2cAZAV(diff2_2cAZAV<dmin)=dmin; 
                            diff3_1sAZAV=tmp4AZAV(:,:,exp1)-tmp3AZAV(:,:,exp1);
                            diff3_2sAZAV=tmp4AZAV(:,:,exp2)-tmp3AZAV(:,:,exp2);
                            diff3_3sAZAV=diff3_1sAZAV-diff3_2sAZAV;
                            diff3_1cAZAV=tmp3AZAV(:,:,exp1)-tmp3AZAV(:,:,exp2);
                            diff3_2cAZAV=tmp4AZAV(:,:,exp1)-tmp4AZAV(:,:,exp2);                            
                            tmp3AZAV(tmp3AZAV<cmin)=cmin;
                            tmp4AZAV(tmp4AZAV<cmin)=cmin;
                            diff3_1sAZAV(diff3_1sAZAV<dmin)=dmin;
                            diff3_2sAZAV(diff3_2sAZAV<dmin)=dmin;
                            diff3_3sAZAV(diff3_3sAZAV<dmin)=dmin;
                            diff3_1cAZAV(diff3_1cAZAV<dmin)=dmin;
                            diff3_2cAZAV(diff3_2cAZAV<dmin)=dmin;

                            spPos1=[0.070    0.665    0.1829*1.2   0.2157*1.2];
                            spPos2=[0.400    0.665    0.1829*1.2   0.2157*1.2];
                            spPos3=[0.730    0.665    0.1829*1.2   0.2157*1.2];
                            spPos4=[0.070    0.380    0.1829*1.2   0.2157*1.2];
                            spPos5=[0.400    0.380    0.1829*1.2   0.2157*1.2];
                            spPos6=[0.730    0.380    0.1829*1.2   0.2157*1.2];
                            spPos7=[0.070    0.095    0.1829*1.2   0.2157*1.2];
                            spPos8=[0.400    0.095    0.1829*1.2   0.2157*1.2];
                            spPos9=[0.730    0.095    0.1829*1.2   0.2157*1.2];
                        
                            if varloop<8
                                run customvariables
                            end
                        
                            % D02 AZAV
                            for pl=1                                 
                                set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                hfig=figure;
                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                ax1=subplot(3,3,1);                            
                                contourf(rdsplt2,PLEV2(1:74,exp1),tmp1AZAV(:,:,exp1),cntr)
                                hold on
                                contourf(rdsplt2,PLEV2(1:74,exp1),tmp1AZAV(:,:,exp1),cntr1,'k')
                                caxis([cmin cmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'fontsize',9)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 500])
                                set(gca,'xTick',[0:100:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9)
                                cl1=colorbar;                                
                                if varloop==4
                                    colormap(gca,custommap(28,WC1))
                                    set(cl1,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',10)
				    set(cl1,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
                                    %text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');                                                
                                else
                                    set(cl1,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',10)
                                    adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                    if sum(adaa)>0
                                    else
                                        adaa((size(adaa,2)+1)/2)=0;
                                    end
                                    set(cl1,'YTicklabel',adaa) 
                                end 
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                ax2=subplot(3,3,2);
                                contourf(rdsplt2,PLEV2(1:74,exp1),tmp2AZAV(:,:,exp1),cntr)
                                hold on
                                contourf(rdsplt2,PLEV2(1:74,exp1),tmp2AZAV(:,:,exp1),cntr1,'k')
                                caxis([cmin cmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'fontsize',9)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 500])
                                set(gca,'xTick',[0:100:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9)
                                cl2=colorbar;
                                if varloop==4
                                    colormap(gca,custommap(28,WC1))
                                    set(cl2,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',10)
                                    set(cl2,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
				    %text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');                                                
                                else
                                    set(cl2,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',10)
                                    adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                    if sum(adaa)>0
                                    else
                                        adaa((size(adaa,2)+1)/2)=0;
                                    end
                                    set(cl2,'YTicklabel',adaa) 
                                end 
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ A}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                                ax3=subplot(3,3,3);
                                contourf(rdsplt2,PLEV2(1:74,exp1),diff2_1sAZAV(:,:),dcntr)
                                hold on
                                contourf(rdsplt2,PLEV2(1:74,exp1),diff2_1sAZAV(:,:),dcntr1,'k')
                                caxis([dmin dmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'fontsize',9)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 500])
                                set(gca,'xTick',[0:100:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9)
                                cl3=colorbar;
                                set(cl3,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                                adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl3,'YTicklabel',adaa)
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ A-B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                                ax4=subplot(3,3,4);
                                contourf(rdsplt2,PLEV2(1:74,exp1),tmp1AZAV(:,:,exp2),cntr)
                                hold on
                                contourf(rdsplt2,PLEV2(1:74,exp1),tmp1AZAV(:,:,exp2),cntr1,'k')
                                caxis([cmin cmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'fontsize',9)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 500])
                                set(gca,'xTick',[0:100:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9)
                                cl4=colorbar;
                                if varloop==4
                                    colormap(gca,custommap(28,WC1))
                                    set(cl4,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',10)
                                    set(cl4,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
				    %text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');                                               
                                else
                                    set(cl4,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',10)
                                    adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                    if sum(adaa)>0
                                    else
                                        adaa((size(adaa,2)+1)/2)=0;
                                    end
                                    set(cl4,'YTicklabel',adaa) 
                                end 
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                                ax5=subplot(3,3,5);
                                contourf(rdsplt2,PLEV2(1:74,exp1),tmp2AZAV(:,:,exp2),cntr)
                                hold on
                                contourf(rdsplt2,PLEV2(1:74,exp1),tmp2AZAV(:,:,exp2),cntr1,'k')
                                caxis([cmin cmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'fontsize',9)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 500])
                                set(gca,'xTick',[0:100:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9)
                                cl5=colorbar;
                                if varloop==4
                                    colormap(gca,custommap(28,WC1))
                                    set(cl5,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',10)
                                    set(cl5,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
				    %text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');                                                
                                else
                                    set(cl5,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',10)
                                    adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                    if sum(adaa)>0
                                    else
                                        adaa((size(adaa,2)+1)/2)=0;
                                    end
                                    set(cl5,'YTicklabel',adaa) 
                                end 
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ A}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                                ax6=subplot(3,3,6);
                                contourf(rdsplt2,PLEV2(1:74,exp1),diff2_2sAZAV(:,:),dcntr)
                                hold on
                                contourf(rdsplt2,PLEV2(1:74,exp1),diff2_2sAZAV(:,:),dcntr1,'k')
                                caxis([dmin dmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'fontsize',9)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 500])
                                set(gca,'xTick',[0:100:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9)
                                cl6=colorbar;
                                set(cl6,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                                adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl6,'YTicklabel',adaa)
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ A-B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                                ax7=subplot(3,3,7);
                                contourf(rdsplt2,PLEV2(1:74,exp1),diff2_1cAZAV(:,:),dcntr)
                                hold on
                                contourf(rdsplt2,PLEV2(1:74,exp1),diff2_1cAZAV(:,:),dcntr1,'k')
                                caxis([dmin dmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'fontsize',9)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 500])
                                set(gca,'xTick',[0:100:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9)
                                cl7=colorbar;
                                set(cl7,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                                adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl7,'YTicklabel',adaa)
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                                text(1,1.08,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                                text(0.98,1.08,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');                                            
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                                ax8=subplot(3,3,8);
                                contourf(rdsplt2,PLEV2(1:74,exp1),diff2_2cAZAV(:,:),dcntr)
                                hold on
                                contourf(rdsplt2,PLEV2(1:74,exp1),diff2_2cAZAV(:,:),dcntr1,'k')
                                caxis([dmin dmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'fontsize',9)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 500])
                                set(gca,'xTick',[0:100:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9); set(gca,'fontsize',9)
                                cl8=colorbar;
                                set(cl8,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                                adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl8,'YTicklabel',adaa)
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                                text(1,1.08,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                                text(0.98,1.08,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');                                            
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ A}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                                ax9=subplot(3,3,9);
                                contourf(rdsplt2,PLEV2(1:74,exp1),diff2_3sAZAV(:,:),dcntr)
                                hold on
                                contourf(rdsplt2,PLEV2(1:74,exp1),diff2_3sAZAV(:,:),dcntr1,'k')
                                caxis([dmin dmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 500])
                                set(gca,'xTick',[0:100:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9); 
                                set(gca,'fontsize',9)
                                cl9=colorbar;
                                set(cl9,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                                adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl9,'YTicklabel',adaa)
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                                text(1,1.08,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                                text(0.98,1.08,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');                                            
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ A-B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)                               

                                % Rest of Plot
                                colormap(ax1,custommap(20,WC1))
                                colormap(ax2,custommap(20,WC1))
                                colormap(ax3,custommap(20,WC2))
                                colormap(ax4,custommap(20,WC1))
                                colormap(ax5,custommap(20,WC1))
                                colormap(ax6,custommap(20,WC2))
                                colormap(ax7,custommap(20,WC2))
                                colormap(ax8,custommap(20,WC2))
                                colormap(ax9,custommap(20,WC2))
                                set(gcf, 'InvertHardcopy', 'off')
                                set(gcf,'Units','inches');
                                screenposition = get(gcf,'Position');
                                set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                set(gcf, 'InvertHardcopy', 'off')                                                                       
                                set(ax1,'Position',spPos1)
                                set(ax2,'Position',spPos2)
                                set(ax3,'Position',spPos3)
                                set(ax4,'Position',spPos4)
                                set(ax5,'Position',spPos5)
                                set(ax6,'Position',spPos6)
                                set(ax7,'Position',spPos7)
                                set(ax8,'Position',spPos8)
                                set(ax9,'Position',spPos9)                                
                                clP=get(cl1,'Position');
                                set(cl1,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                clP=get(cl2,'Position');
                                set(cl2,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                clP=get(cl3,'Position');
                                set(cl3,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                clP=get(cl4,'Position');
                                set(cl4,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                clP=get(cl5,'Position');
                                set(cl5,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                clP=get(cl6,'Position');
                                set(cl6,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                clP=get(cl7,'Position');
                                set(cl7,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                clP=get(cl8,'Position');
                                set(cl8,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                clP=get(cl9,'Position');
                                set(cl9,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                %f = getframe(hfig);
								filename=[identhwrfda,'/',identn,'_',identinittimesunique(identloop,:),'_AZAV_',savename,'_D02_HWRFDA'];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;print(filename,'-dpng');end;					                            
                                %imwrite(f.cdata,[identhwrfda,'/',identn,'_',identinittimesunique(identloop,:),'_PLEV',num2str(plev(cnt)),'_',savename,'_D02_HWRFDA.png'],'pdf');
                                close all 
                                cnt=cnt+1;
                            end

                            % D03 AZAV                        
                            for pl=1                                 
                                set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                hfig=figure;
                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                ax1=subplot(3,3,1);
                                contourf(rdsplt3,PLEV3(1:74,exp1),tmp3AZAV(:,:,exp1),cntr)
                                hold on
                                contourf(rdsplt3,PLEV3(1:74,exp1),tmp3AZAV(:,:,exp1),cntr1,'k')
                                caxis([cmin cmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'fontsize',9)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 250])
                                set(gca,'xTick',[0:50:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9)
                                cl1=colorbar;                                
                                if varloop==4
                                    colormap(gca,custommap(28,WC1))
                                    set(cl1,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',10)
                                    set(cl1,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
				    %text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');                                                
                                else
                                    set(cl1,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',10)
                                    adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                    if sum(adaa)>0
                                    else
                                        adaa((size(adaa,2)+1)/2)=0;
                                    end
                                    set(cl1,'YTicklabel',adaa) 
                                end 
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                ax2=subplot(3,3,2);
                                contourf(rdsplt3,PLEV3(1:74,exp1),tmp4AZAV(:,:,exp1),cntr)
                                hold on
                                contourf(rdsplt3,PLEV3(1:74,exp1),tmp4AZAV(:,:,exp1),cntr1,'k')
                                caxis([cmin cmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'fontsize',9)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 250])
                                set(gca,'xTick',[0:50:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9)
                                cl2=colorbar;
                                if varloop==4
                                    colormap(gca,custommap(28,WC1))
                                    set(c2,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',10)
                                    set(c2,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
				    %text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');                                                
                                else
                                    set(cl2,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',10)
                                    adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                    if sum(adaa)>0
                                    else
                                        adaa((size(adaa,2)+1)/2)=0;
                                    end
                                    set(cl2,'YTicklabel',adaa) 
                                end 
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ A}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                                ax3=subplot(3,3,3);
                                contourf(rdsplt3,PLEV3(1:74,exp1),diff3_1sAZAV(:,:),dcntr)
                                hold on
                                contourf(rdsplt3,PLEV3(1:74,exp1),diff3_1sAZAV(:,:),dcntr1,'k')
                                caxis([dmin dmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'fontsize',9)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 250])
                                set(gca,'xTick',[0:50:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9)
                                cl3=colorbar;
                                set(cl3,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                                adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl3,'YTicklabel',adaa)
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ A-B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                                ax4=subplot(3,3,4);
                                contourf(rdsplt3,PLEV3(1:74,exp1),tmp3AZAV(:,:,exp2),cntr)
                                hold on
                                contourf(rdsplt3,PLEV3(1:74,exp1),tmp3AZAV(:,:,exp2),cntr1,'k')
                                caxis([cmin cmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'fontsize',9)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 250])
                                set(gca,'xTick',[0:50:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9)
                                cl4=colorbar;
                                if varloop==4
                                    colormap(gca,custommap(28,WC1))
                                    set(cl4,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',10)
                                    set(cl4,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
				    %text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');                                                
                                else
                                    set(cl4,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',10)
                                    adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                    if sum(adaa)>0
                                    else
                                        adaa((size(adaa,2)+1)/2)=0;
                                    end
                                    set(cl4,'YTicklabel',adaa) 
                                end 
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                                ax5=subplot(3,3,5);
                                contourf(rdsplt3,PLEV3(1:74,exp1),tmp4AZAV(:,:,exp2),cntr)
                                hold on
                                contourf(rdsplt3,PLEV3(1:74,exp1),tmp4AZAV(:,:,exp2),cntr1,'k')
                                caxis([cmin cmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'fontsize',9)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 250])
                                set(gca,'xTick',[0:50:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9)
                                cl5=colorbar;
                                if varloop==4
                                    colormap(gca,custommap(28,WC1))
                                    set(cl5,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',10)
                                    set(cl5,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
                                    %text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');
                                    %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',5,'color','k','units','normalized');                                                
                                else
                                    set(cl5,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',10)
                                    adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                    if sum(adaa)>0
                                    else
                                        adaa((size(adaa,2)+1)/2)=0;
                                    end
                                    set(cl5,'YTicklabel',adaa) 
                                end 
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ A}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                                ax6=subplot(3,3,6);
                                contourf(rdsplt3,PLEV3(1:74,exp1),diff3_2sAZAV(:,:),dcntr)
                                hold on
                                contourf(rdsplt3,PLEV3(1:74,exp1),diff3_2sAZAV(:,:),dcntr1,'k')
                                caxis([dmin dmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'fontsize',9)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 250])
                                set(gca,'xTick',[0:50:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9)
                                cl6=colorbar;
                                set(cl6,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                                adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl6,'YTicklabel',adaa)
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ A-B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                                ax7=subplot(3,3,7);
                                contourf(rdsplt3,PLEV3(1:74,exp1),diff3_1cAZAV(:,:),dcntr)
                                hold on
                                contourf(rdsplt3,PLEV3(1:74,exp1),diff3_1cAZAV(:,:),dcntr1,'k')
                                caxis([dmin dmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'fontsize',9)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 250])
                                set(gca,'xTick',[0:50:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9)
                                cl7=colorbar;
                                set(cl7,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                                adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl7,'YTicklabel',adaa)
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                                text(1,1.08,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                                text(0.98,1.08,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');                                            
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                                ax8=subplot(3,3,8);
                                contourf(rdsplt3,PLEV3(1:74,exp1),diff3_2cAZAV(:,:),dcntr)
                                hold on
                                contourf(rdsplt3,PLEV3(1:74,exp1),diff3_2cAZAV(:,:),dcntr1,'k')
                                caxis([dmin dmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'fontsize',9)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 250])
                                set(gca,'xTick',[0:50:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9); set(gca,'fontsize',9)
                                cl8=colorbar;
                                set(cl8,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                                adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl8,'YTicklabel',adaa)
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                                text(1,1.08,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                                text(0.98,1.08,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');                                            
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ A}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)
                                ax9=subplot(3,3,9);
                                contourf(rdsplt3,PLEV3(1:74,exp1),diff3_3sAZAV(:,:),dcntr)
                                hold on
                                contourf(rdsplt3,PLEV3(1:74,exp1),diff3_3sAZAV(:,:),dcntr1,'k')
                                caxis([dmin dmax])
                                axis ij
                                xlabel('Radius (km)','fontsize',20)
                                ylabel('Pressure* (hPa)','fontsize',20)
                                set(gca,'plotboxaspectratio',[1 1 1])
                                ylim([0 1000]); xlim([0 250])
                                set(gca,'xTick',[0:50:1000],'fontsize',20);
                                set(gca,'yTick',[0:100:1000],'fontsize',20); set(gca,'fontsize',9); 
                                set(gca,'fontsize',9)
                                cl9=colorbar;
                                set(cl9,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',10)
                                adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
                                if sum(adaa)>0
                                else
                                    adaa((size(adaa,2)+1)/2)=0;
                                end
                                set(cl9,'YTicklabel',adaa)
                                ax=gca;
                                box on
                                set(ax, 'Layer', 'top')
                                ax.LineWidth=1;  
                                text(1,1.04,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
                                text(1,1.08,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color','k','units','normalized');
                                text(0.98,1.08,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');                                            
                                text(0,1.04,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ A-B}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')                                
                                text(0,1.08,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',6,'fontweight','bold','interpreter','latex','units','normalized')
                                %plot(LONall,LATall,'o','markerfacecolor','k','markeredgecolor','w','markersize',5)                               

                                % Rest of Plot
                                colormap(ax1,custommap(20,WC1))
                                colormap(ax2,custommap(20,WC1))
                                colormap(ax3,custommap(20,WC2))
                                colormap(ax4,custommap(20,WC1))
                                colormap(ax5,custommap(20,WC1))
                                colormap(ax6,custommap(20,WC2))
                                colormap(ax7,custommap(20,WC2))
                                colormap(ax8,custommap(20,WC2))
                                colormap(ax9,custommap(20,WC2))
                                set(gcf, 'InvertHardcopy', 'off')
                                set(gcf,'Units','inches');
                                screenposition = get(gcf,'Position');
                                set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                set(gcf, 'InvertHardcopy', 'off')                                                                       
                                set(ax1,'Position',spPos1)
                                set(ax2,'Position',spPos2)
                                set(ax3,'Position',spPos3)
                                set(ax4,'Position',spPos4)
                                set(ax5,'Position',spPos5)
                                set(ax6,'Position',spPos6)
                                set(ax7,'Position',spPos7)
                                set(ax8,'Position',spPos8)
                                set(ax9,'Position',spPos9)                                
                                clP=get(cl1,'Position');
                                set(cl1,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                clP=get(cl2,'Position');
                                set(cl2,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                clP=get(cl3,'Position');
                                set(cl3,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                clP=get(cl4,'Position');
                                set(cl4,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                clP=get(cl5,'Position');
                                set(cl5,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                clP=get(cl6,'Position');
                                set(cl6,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                clP=get(cl7,'Position');
                                set(cl7,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                clP=get(cl8,'Position');
                                set(cl8,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                clP=get(cl9,'Position');
                                set(cl9,'Position',[clP(1)+.01 clP(2)+.02 0.01 clP(4)-.04])
                                %f = getframe(hfig);
								filename=[identhwrfda,'/',identn,'_',identinittimesunique(identloop,:),'_AZAV_',savename,'_D03_HWRFDA'];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;print(filename,'-dpng');end;					                            
                                %imwrite(f.cdata,[identhwrfda,'/',identn,'_',identinittimesunique(identloop,:),'_PLEV',num2str(plev(cnt)),'_',savename,'_D02_HWRFDA.png'],'pdf');
                                close all 
                                cnt=cnt+1;
                            end
                        end
                    end
                end 
            end
        end
       disp(['COMPLETED CYCLE #', num2str(identloop),' for ',identexpshort{exp1},' & ',identexpshort{exp2},' COMPARISION'])
       clearvars -except skip* ident* hwrfvariables
    end                      
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%% Generated error statisics for later usage %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
for errorstats=1
    if identgraphics==1
            clear l 
            % Parameters
            trkerr_sz=0; % find longest lead time - initialize value
            spPos=[0.11 0.13+.05 0.75 0.75-.05]; % arrange plots the same
            clPos=[0.88 0.13+.05 0.04 0.75-.05]; % arrange plots the same
            % Initialize BT
            BT_lon=nan(size(identinittimesunique,1),identmodelfhr);
            BT_lat=nan(size(identinittimesunique,1),identmodelfhr);
            BT_maxspd=nan(size(identinittimesunique,1),identmodelfhr);
            BT_minpres=nan(size(identinittimesunique,1),identmodelfhr);
            BT_ne34=nan(size(identinittimesunique,1),identmodelfhr);
            BT_ne50=nan(size(identinittimesunique,1),identmodelfhr);
            BT_ne64=nan(size(identinittimesunique,1),identmodelfhr);
            BT_se34=nan(size(identinittimesunique,1),identmodelfhr);
            BT_se50=nan(size(identinittimesunique,1),identmodelfhr);
            BT_se64=nan(size(identinittimesunique,1),identmodelfhr);
            BT_sw34=nan(size(identinittimesunique,1),identmodelfhr);
            BT_sw50=nan(size(identinittimesunique,1),identmodelfhr);
            BT_sw64=nan(size(identinittimesunique,1),identmodelfhr);
            BT_nw34=nan(size(identinittimesunique,1),identmodelfhr);
            BT_nw50=nan(size(identinittimesunique,1),identmodelfhr);
            BT_nw64=nan(size(identinittimesunique,1),identmodelfhr);
            BT_po=nan(size(identinittimesunique,1),identmodelfhr);
            BT_ro=nan(size(identinittimesunique,1),identmodelfhr);
            BT_rmw=nan(size(identinittimesunique,1),identmodelfhr);         

            % Initialize EXP
            EXP_lon=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_lat=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_maxspd=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_minpres=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_ne34=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_ne50=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_ne64=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_se34=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_se50=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_se64=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_sw34=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_sw50=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_sw64=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_nw34=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_nw50=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_nw64=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_po=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_ro=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            EXP_rmw=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));         

            % Initialize Errors
            ateerr_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            xteerr_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            trkerr_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            interr_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            spderr_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            ne34err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            se34err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            sw34err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            nw34err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            ne50err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            se50err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            sw50err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            nw50err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            ne64err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            se64err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            sw64err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            nw64err_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            poerr_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            roerr_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));
            rmwerr_exp=nan(size(identinittimesunique,1),identmodelfhr,size(identexp,1));

            % Individual Cycles
            for identloop=1:size(identinittimesunique,1)
                load([identout,'RESULTS/',identfold,identn,'/',identn,'_data.mat'])
                for i=1:size(DATEall,1)
                    if strcmp(identinittimesunique(identloop,:),DATEall(i,:))==1
                        initnum=i
                    end
                end
                if exist('initnum','var')==0 %% to take care of invests not in BT
                else
                    %% BT
                    initsize=size(DATEall,1)-initnum+1;
                    bt_date=DATEall(initnum:end,:);
                    bt_cat=CATall(initnum:end,:);
                    bt_lat=LATall(initnum:end);
                    bt_lon=LONall(initnum:end);
                    bt_maxspd=SPEEDall(initnum:end);
                    bt_minpres=PRESSall(initnum:end);
                    bt_ne34=NE34all(initnum:end);
                    bt_ne50=NE50all(initnum:end);
                    bt_ne64=NE64all(initnum:end);
                    bt_se34=SE34all(initnum:end);
                    bt_se50=SE50all(initnum:end);
                    bt_se64=SE64all(initnum:end);
                    bt_sw34=SW34all(initnum:end);
                    bt_sw50=SW50all(initnum:end);
                    bt_sw64=SW64all(initnum:end);
                    bt_nw34=NW34all(initnum:end);
                    bt_nw50=NW50all(initnum:end);
                    bt_nw64=NW64all(initnum:end);
                    bt_po=POall(initnum:end);
                    bt_ro=ROall(initnum:end);
                    bt_rmw=RMWall(initnum:end); 

                    %% EXP - grab stats file
                    % Initialize Individual
                    exp_fhr=nan(100,size(identexp,1));
                    exp_lon=nan(100,size(identexp,1));
                    exp_lat=nan(100,size(identexp,1));
                    exp_minpres=nan(100,size(identexp,1));
                    exp_maxspd=nan(100,size(identexp,1));                   
                    exp_ne34=nan(100,size(identexp,1));
                    exp_ne50=nan(100,size(identexp,1));
                    exp_ne64=nan(100,size(identexp,1));
                    exp_se34=nan(100,size(identexp,1));
                    exp_se50=nan(100,size(identexp,1));
                    exp_se64=nan(100,size(identexp,1));
                    exp_sw34=nan(100,size(identexp,1));
                    exp_sw50=nan(100,size(identexp,1));
                    exp_sw64=nan(100,size(identexp,1));
                    exp_nw34=nan(100,size(identexp,1));
                    exp_nw50=nan(100,size(identexp,1));
                    exp_nw64=nan(100,size(identexp,1));
                    exp_po=nan(100,size(identexp,1));
                    exp_ro=nan(100,size(identexp,1));
                    exp_rmw=nan(100,size(identexp,1)); 
                    % Loop
                    for tmp=1:size(identexp,1)                
                        filename = dir([identnoscrub,'atcf/',identexp{tmp},'/',identhwrf,'.',identinittimesunique(identloop,:),'*']);filename=[identgroovpr,identexpshort{tmp},'/',filename.name];
                        [identhemi,DATEall,BASINall,NAMEall,CATall,LATall,POall,SE50all,LONall,PRESSall,SE64all,NE34all,RAD34all,SPEEDall,NE50all,RAD50all,SW34all,NE64all,RAD64all,SW50all,NW34all,RMWall,SW64all,NW50all,ROall,NW64all,SE34all,FHRall,INTCHall]=atcf(filename,0);
                        initsizeexp=size(FHRall,2);
                        exp_fhr(1:initsizeexp,tmp)=FHRall';
                        exp_lon(1:initsizeexp,tmp)=LONall;
                        exp_lat(1:initsizeexp,tmp)=LATall;
                        exp_minpres(1:initsizeexp,tmp)=PRESSall;
                        exp_maxspd(1:initsizeexp,tmp)=SPEEDall;                    
                        exp_ne34(1:initsizeexp,tmp)=NE34all;
                        exp_ne50(1:initsizeexp,tmp)=NE50all;
                        exp_ne64(1:initsizeexp,tmp)=NE64all;
                        exp_se34(1:initsizeexp,tmp)=SE34all;
                        exp_se50(1:initsizeexp,tmp)=SE50all;
                        exp_se64(1:initsizeexp,tmp)=SE64all;
                        exp_sw34(1:initsizeexp,tmp)=SW34all;
                        exp_sw50(1:initsizeexp,tmp)=SW50all;
                        exp_sw64(1:initsizeexp,tmp)=SW64all;
                        exp_nw34(1:initsizeexp,tmp)=NW34all;
                        exp_nw50(1:initsizeexp,tmp)=NW50all;
                        exp_nw64(1:initsizeexp,tmp)=NW64all;
                        exp_po(1:initsizeexp,tmp)=POall;
                        exp_ro(1:initsizeexp,tmp)=ROall;
                        exp_rmw(1:initsizeexp,tmp)=RMWall;                    
                    end  
                    % Cut off rows with NaNs to make lengths equal
                    exp_lon(any(isnan(exp_fhr), 2), :) = [];
                    exp_lat(any(isnan(exp_fhr), 2), :) = [];
                    exp_minpres(any(isnan(exp_fhr), 2), :) = [];
                    exp_maxspd(any(isnan(exp_fhr), 2), :) = [];                  
                    exp_ne34(any(isnan(exp_fhr), 2), :) = [];
                    exp_ne50(any(isnan(exp_fhr), 2), :) = [];
                    exp_ne64(any(isnan(exp_fhr), 2), :) = [];
                    exp_se34(any(isnan(exp_fhr), 2), :) = [];
                    exp_se50(any(isnan(exp_fhr), 2), :) = [];
                    exp_se64(any(isnan(exp_fhr), 2), :) = [];
                    exp_sw34(any(isnan(exp_fhr), 2), :) = [];
                    exp_sw50(any(isnan(exp_fhr), 2), :) = [];
                    exp_sw64(any(isnan(exp_fhr), 2), :) = [];
                    exp_nw34(any(isnan(exp_fhr), 2), :) = [];
                    exp_nw50(any(isnan(exp_fhr), 2), :) = [];
                    exp_nw64(any(isnan(exp_fhr), 2), :) = [];
                    exp_po(any(isnan(exp_fhr), 2), :) = [];
                    exp_ro(any(isnan(exp_fhr), 2), :) = [];
                    exp_rmw(any(isnan(exp_fhr), 2), :) = []; 
                    exp_fhr(any(isnan(exp_fhr), 2), :) = [];
                    % Measure size
                    initsizeexp=size(exp_lon,1);                
                    % Make BT and EXP same size
                    if initsize>initsizeexp                    
                        bt_cat=bt_cat(1:initsizeexp,:);
                        bt_lon=bt_lon(1:initsizeexp);
                        bt_lat=bt_lat(1:initsizeexp);
                        bt_minpres=bt_minpres(1:initsizeexp);
                        bt_maxspd=bt_maxspd(1:initsizeexp);
                        bt_date=bt_date(1:initsizeexp,:);                    
                        bt_ne34=bt_ne34(1:initsizeexp);
                        bt_ne50=bt_ne50(1:initsizeexp);
                        bt_ne64=bt_ne64(1:initsizeexp);
                        bt_se34=bt_se34(1:initsizeexp);
                        bt_se50=bt_se50(1:initsizeexp);
                        bt_se64=bt_se64(1:initsizeexp);
                        bt_sw34=bt_sw34(1:initsizeexp);
                        bt_sw50=bt_sw50(1:initsizeexp);
                        bt_sw64=bt_sw64(1:initsizeexp);
                        bt_nw34=bt_nw34(1:initsizeexp);
                        bt_nw50=bt_nw50(1:initsizeexp);
                        bt_nw64=bt_nw64(1:initsizeexp);
                        bt_po=bt_po(1:initsizeexp);
                        bt_ro=bt_ro(1:initsizeexp);
                        bt_rmw=bt_rmw(1:initsizeexp);   
                        initsize=initsizeexp;
                    else
                        exp_fhr=exp_fhr(1:initsize,:);
                        exp_lon=exp_lon(1:initsize,:);
                        exp_lat=exp_lat(1:initsize,:);
                        exp_minpres=exp_minpres(1:initsize,:);
                        exp_maxspd=exp_maxspd(1:initsize,:);
                        exp_ne34=exp_ne34(1:initsize,:);
                        exp_ne50=exp_ne50(1:initsize,:);
                        exp_ne64=exp_ne64(1:initsize,:);
                        exp_se34=exp_se34(1:initsize,:);
                        exp_se50=exp_se50(1:initsize,:);
                        exp_se64=exp_se64(1:initsize,:);
                        exp_sw34=exp_sw34(1:initsize,:);
                        exp_sw50=exp_sw50(1:initsize,:);
                        exp_sw64=exp_sw64(1:initsize,:);
                        exp_nw34=exp_nw34(1:initsize,:);
                        exp_nw50=exp_nw50(1:initsize,:);
                        exp_nw64=exp_nw64(1:initsize,:);
                        exp_po=exp_po(1:initsize,:);
                        exp_ro=exp_ro(1:initsize,:);
                        exp_rmw=exp_rmw(1:initsize,:);   
                    end         

                    %% Turn missing spots into NaNs
                    exp_ne34(exp_ne34==0)=NaN;
                    exp_ne50(exp_ne50==0)=NaN;
                    exp_ne64(exp_ne64==0)=NaN;
                    exp_se34(exp_se34==0)=NaN;
                    exp_se50(exp_se50==0)=NaN;
                    exp_se64(exp_se64==0)=NaN;
                    exp_sw34(exp_sw34==0)=NaN;
                    exp_sw50(exp_sw50==0)=NaN;
                    exp_sw64(exp_sw64==0)=NaN;
                    exp_nw34(exp_nw34==0)=NaN;
                    exp_nw50(exp_nw50==0)=NaN;
                    exp_nw64(exp_nw64==0)=NaN;
                    exp_po(exp_po<0)=NaN;
                    exp_ro(exp_ro<0)=NaN;
                    bt_ne34(bt_ne34==0)=NaN;
                    bt_ne50(bt_ne50==0)=NaN;
                    bt_ne64(bt_ne64==0)=NaN;
                    bt_se34(bt_se34==0)=NaN;
                    bt_se50(bt_se50==0)=NaN;
                    bt_se64(bt_se64==0)=NaN;
                    bt_sw34(bt_sw34==0)=NaN;
                    bt_sw50(bt_sw50==0)=NaN;
                    bt_sw64(bt_sw64==0)=NaN;
                    bt_nw34(bt_nw34==0)=NaN;
                    bt_nw50(bt_nw50==0)=NaN;
                    bt_nw64(bt_nw64==0)=NaN;                
                    bt_po(bt_po<0)=NaN;
                    bt_ro(bt_ro<0)=NaN;

                    %% Save lat/lons
                    for ct=1:size(bt_cat,1)
                        BT_cat(identloop,ct)={bt_cat(ct,:)};
                    end
                    BT_lon(identloop,1:size(bt_lon,2))=bt_lon;
                    BT_lat(identloop,1:size(bt_lat,2))=bt_lat;
                    BT_maxspd(identloop,1:size(bt_maxspd,2))=bt_maxspd;
                    BT_minpres(identloop,1:size(bt_minpres,2))=bt_minpres;                
                    BT_ne34(identloop,1:size(bt_lon,2))=bt_ne34;
                    BT_ne50(identloop,1:size(bt_lon,2))=bt_ne50;
                    BT_ne64(identloop,1:size(bt_lon,2))=bt_ne64;
                    BT_se34(identloop,1:size(bt_lon,2))=bt_se34;
                    BT_se50(identloop,1:size(bt_lon,2))=bt_se50;
                    BT_se64(identloop,1:size(bt_lon,2))=bt_se64;
                    BT_sw34(identloop,1:size(bt_lon,2))=bt_sw34;
                    BT_sw50(identloop,1:size(bt_lon,2))=bt_sw50;
                    BT_sw64(identloop,1:size(bt_lon,2))=bt_sw64;
                    BT_nw34(identloop,1:size(bt_lon,2))=bt_nw34;
                    BT_nw50(identloop,1:size(bt_lon,2))=bt_nw50;
                    BT_nw64(identloop,1:size(bt_lon,2))=bt_nw64;
                    BT_po(identloop,1:size(bt_lon,2))=bt_po;
                    BT_ro(identloop,1:size(bt_lon,2))=bt_ro;
                    BT_rmw(identloop,1:size(bt_lon,2))=bt_rmw; 
                    EXP_lon(identloop,1:size(exp_lon,1),:)=exp_lon;
                    EXP_lat(identloop,1:size(exp_lat,1),:)=exp_lat;
                    EXP_maxspd(identloop,1:size(exp_maxspd,1),:)=exp_maxspd;
                    EXP_minpres(identloop,1:size(exp_minpres,1),:)=exp_minpres;
                    EXP_ne34(identloop,1:size(exp_lon,1),:)=exp_ne34;
                    EXP_ne50(identloop,1:size(exp_lon,1),:)=exp_ne50;
                    EXP_ne64(identloop,1:size(exp_lon,1),:)=exp_ne64;
                    EXP_se34(identloop,1:size(exp_lon,1),:)=exp_se34;
                    EXP_se50(identloop,1:size(exp_lon,1),:)=exp_se50;
                    EXP_se64(identloop,1:size(exp_lon,1),:)=exp_se64;
                    EXP_sw34(identloop,1:size(exp_lon,1),:)=exp_sw34;
                    EXP_sw50(identloop,1:size(exp_lon,1),:)=exp_sw50;
                    EXP_sw64(identloop,1:size(exp_lon,1),:)=exp_sw64;
                    EXP_nw34(identloop,1:size(exp_lon,1),:)=exp_nw34;
                    EXP_nw50(identloop,1:size(exp_lon,1),:)=exp_nw50;
                    EXP_nw64(identloop,1:size(exp_lon,1),:)=exp_nw64;
                    EXP_po(identloop,1:size(exp_lon,1),:)=exp_po;
                    EXP_ro(identloop,1:size(exp_lon,1),:)=exp_ro;
                    EXP_rmw(identloop,1:size(exp_lon,1),:)=exp_rmw;   

                    % Across- and Along-Track Errors
                    for exp=1:size(identexp,1)
                        for acal=2:size(bt_lon,2)
                            % Set points
                            bt_lonn1=bt_lon(acal-1);
                            bt_latn1=bt_lat(acal-1);
                            bt_lon0=bt_lon(acal);
                            bt_lat0=bt_lat(acal);       
                            exp_lon0=exp_lon(acal,exp);
                            exp_lat0=exp_lat(acal,exp);
                            % Fine perpendicular coordinates from point to line                
                            a = [bt_lonn1, bt_latn1]; %line - x1
                            b = [bt_lon0, bt_lat0]; % line - x2
                            c = [exp_lon0, exp_lat0]; %point - x0
                            ab = b - a; %// Find x2 - x1
                            %// -(x1 - x0).(x2 - x1) / (|x2 - x1|^2)
                            t = -(a - c)*(ab.') / (ab*ab.'); %// Calculate t
                            %// Find point of intersection
                            Xinter = a + (b - a)*t;
                            int_lon0=Xinter(1);
                            int_lat0=Xinter(2);            
                            % BT0 to GH0 (hypotenuse)
                            dist_BT0GH0=deg2km(distance('gc',[bt_lat0,bt_lon0],[exp_lat0,exp_lon0]));
                            dist_BTn1int0=deg2km(distance('gc',[bt_latn1,bt_lonn1],[int_lat0,int_lon0]));
                            dist_BTn1BT0=deg2km(distance('gc',[bt_latn1,bt_lonn1],[bt_lat0,bt_lon0]));
                            % Across-Track Error: GH0 to intersection point
                            XTE=deg2km(distance('gc',[int_lat0,int_lon0],[exp_lat0,exp_lon0]));                     
                            % Position Left Right:
                            % if value > 0, p2 is on the left side of the line.
                            % if value = 0, p2 is on the same line.
                            % if value < 0, p2 is on the right side of the line.
                            value = (bt_lon0 - bt_lonn1).*(exp_lat0 - bt_latn1) - (exp_lon0 - bt_lonn1).*(bt_lat0 - bt_latn1);
                            if value > 0
                               XTE=XTE*-1;
                            end
                            % Along-Track Error
                            ATE=deg2km(distance('gc',[bt_lat0,bt_lon0],[int_lat0,int_lon0]));
                            % Distance from n1 to int and n1 to bt0. which is longer? 
                            if dist_BTn1BT0 > dist_BTn1int0
                               ATE=-1.*ATE; 
                            end        
                            ateerr_exp(identloop,acal,exp)=ATE;
                            xteerr_exp(identloop,acal,exp)=XTE;
                        end
                    end                


                    %% Find errors - ALL init times                
                    for tmp=1:size(identexp,1)
                        trkerr_exp(identloop,1:initsize,tmp)=(deg2km(distance('gc',bt_lat,bt_lon,exp_lat(:,tmp)',exp_lon(:,tmp)')));
                        trkerr_sz=max(size(bt_lat,2),trkerr_sz);
                        interr_exp(identloop,1:initsize,tmp)=(exp_minpres(:,tmp)-bt_minpres');
                        spderr_exp(identloop,1:initsize,tmp)=(exp_maxspd(:,tmp)-bt_maxspd');
                        ne34err_exp(identloop,1:initsize,tmp)=(exp_ne34(:,tmp)-bt_ne34');
                        se34err_exp(identloop,1:initsize,tmp)=(exp_se34(:,tmp)-bt_se34');
                        sw34err_exp(identloop,1:initsize,tmp)=(exp_sw34(:,tmp)-bt_sw34');
                        nw34err_exp(identloop,1:initsize,tmp)=(exp_nw34(:,tmp)-bt_nw34');
                        ne50err_exp(identloop,1:initsize,tmp)=(exp_ne50(:,tmp)-bt_ne50');
                        se50err_exp(identloop,1:initsize,tmp)=(exp_se50(:,tmp)-bt_se50');
                        sw50err_exp(identloop,1:initsize,tmp)=(exp_sw50(:,tmp)-bt_sw50');
                        nw50err_exp(identloop,1:initsize,tmp)=(exp_nw50(:,tmp)-bt_nw50');
                        ne64err_exp(identloop,1:initsize,tmp)=(exp_ne64(:,tmp)-bt_ne64');
                        se64err_exp(identloop,1:initsize,tmp)=(exp_se64(:,tmp)-bt_se64');
                        sw64err_exp(identloop,1:initsize,tmp)=(exp_sw64(:,tmp)-bt_sw64');
                        nw64err_exp(identloop,1:initsize,tmp)=(exp_nw64(:,tmp)-bt_nw64');            
                        poerr_exp(identloop,1:initsize,tmp)=(exp_po(:,tmp)-bt_po');
                        roerr_exp(identloop,1:initsize,tmp)=(exp_ro(:,tmp)-bt_ro');
                        rmwerr_exp(identloop,1:initsize,tmp)=(exp_rmw(:,tmp)-bt_rmw');
                    end
                end
            end

            save([identout,'RESULTS/',identfold,identn,'/',identn,'_latlon.mat'],'BT*','EXP*');        
            save([identout,'RESULTS/',identfold,identn,'/',identn,'_errors.mat'],'*err_exp','trkerr_sz')       
            clearvars -except identgraphicsconv identgraphicsbycycle identconvid identbasinscale stormsdone identremovename yearsdone BT* EXP* ident* skip* spPos clPos ateerr_exp xteerr_exp
            clearvars -except identgraphicsconv identgraphicsbycycle identconvid identbasinscale ident* skip* stormsdone yearsdone
            clearvars -except ident* skip*
    end
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%% SYNOPTIC: creates .mat files of chosen variables %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
for hwrfvariables=1:size(identexp,1)
    if identsynoptic==1
        identexp0=identexp{hwrfvariables};
        disp(['EXPERIMENT: ',identexp0])
        pltcen=150; % number of gridpoints in each direction - goes to just over 3000 km
        % Load all Storm Centers for All Cycles and Forecasts
        load([identout,'RESULTS/',identfold,identn,'/',identn,'_latlon.mat']);
        % run loops
        for identvar=identv
            for identloop=identbatch % value set in batch script to run parallel for all cycles
                % initialize variables (should be same for each!)
                disp(['CYCLE INIT DATE: ',identinittimesunique(identloop,:)])
                var_f=nan(pltcen*2+1,pltcen*2+1,identlevels,identmodelfhr,'single'); %lonxlatxlevelsxFHR (1 for each init)
                varlt_f=nan(pltcen*2+1,pltcen*2+1,identmodelfhr,'single');
                varln_f=nan(pltcen*2+1,pltcen*2+1,identmodelfhr,'single');
                for identfhr=1:identmaxfhr % loop over number of forecast hours for that cycle
                    if isnan(BT_lat(identloop,identfhr))==1
                        disp('BT has a NaN...skipping date!')
                    else
                        ncid=ncgeodataset([identscrub,identexp0,'/com/',identinittimesunique(identloop,:),'/',ident(3:4),upper(identhwrf(end)),'/',identhwrf,'.',identinittimesunique(identloop,:),'.hwrfprs.synoptic.0p125.f',num2str(3*(identfhr-1),'%03d'),'.grb2']);
                        identvariables=sort(ncid.variables);
                        for i=1:size(identvariables,1)
                            if strcmp(identvariables{i},'height_above_ground')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'height_above_ground_layer')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'height_above_ground_layer_bounds')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'height_above_ground1')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'height_above_ground2')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'isobaric')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'isobaric1')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'lat')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'lon')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'time')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'time1')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'time1_bounds')==1
                                identvariables{i}=[];
                            end
                        end      
                        sv = ncid.geovariable('Latitude_-90_to_90_surface');
                        nlat=squeeze(sv.data(:,:,:,:));
                        nlat=permute(nlat,[2 1]);    
                        sv = ncid.geovariable('East_Longitude_0_to_360_surface');
                        elon=squeeze(sv.data(:,:,:,:));
                        elon=permute(elon,[2 1]);
                        elon(elon>180)=elon(elon>180)-360;      
                        sv = ncid.geovariable('isobaric');
                        plev=squeeze(sv.data(:,:,:,:))/100;     
                        sv = ncid.geovariable{identvariables{identvar}};
                        % Find the storm center
                        LATall=EXP_lat(identloop,(str2num(num2str(3*(identfhr-1),'%03d'))/3)+1,hwrfvariables);
                        LONall=EXP_lon(identloop,(str2num(num2str(3*(identfhr-1),'%03d'))/3)+1,hwrfvariables); 
                        tmp1 = abs(nlat-LATall);
                        tmp2 = abs(elon-LONall);
                        tmp1(tmp1>1)=NaN;
                        tmp2(tmp2>1)=NaN;
                        tmp3=tmp1.*tmp2;
                        minimum=min(min(tmp3));
                        [gx,gy]=find(tmp3==minimum);
						for weirdgrid=1:100
							if isnan(tmp3(gx-1,gy-1))==1 | isnan(tmp3(gx+1,gy+1))==1 | isnan(tmp3(gx-1,gy+1))==1 | isnan(tmp3(gx+1,gy-1))==1
								tmp3(gx,gy)=NaN;
								minimum=min(min(tmp3));							
								[gx,gy]=find(tmp3==minimum);
							end
						end
                        A=[LONall LATall];
                        for i=1:size(gx,1)
                            B(i,:)=[elon(gx(i),gy(i)) nlat(gx(i),gy(i))];
                        end
                        dist2 = sum((B - A) .^ 2, 2);
                        %find the smallest distance and use that as an index into B:
                        clear B A
                        [ax,ay] = min(dist2);
                        gx=gx(ay);
                        gy=gy(ay);
                        nlat=nlat(gx-pltcen:gx+pltcen,gy-pltcen:gy+pltcen);
                        elon=elon(gx-pltcen:gx+pltcen,gy-pltcen:gy+pltcen);
                        
                        if size(size(sv.data),2)==3
                            if strcmp(identvariables{identvar},'Pressure_reduced_to_MSL_msl')==1 || strcmp(identvariables{identvar},'Pressure_surface')==1 || strcmp(identvariables{identvar},'Pressure_tropopause')==1
                                tmpvar=squeeze(sv.data(:,gy-pltcen:gy+pltcen,gx-pltcen:gx+pltcen))/100;  
                            elseif strcmp(identvariables{identvar},'Absolute_vorticity_isobaric')==1
                                tmpvar=squeeze(sv.data(:,gy-pltcen:gy+pltcen,gx-pltcen:gx+pltcen)).*10^5;  
                            elseif strcmp(identvariables{identvar},'u-component_of_wind_height_above_ground')==1 || strcmp(identvariables{identvar},'u-component_of_wind_isobaric')==1 || strcmp(identvariables{identvar},'u-component_of_wind_tropopause')==1 || strcmp(identvariables{identvar},'v-component_of_wind_height_above_ground')==1 || strcmp(identvariables{identvar},'v-component_of_wind_isobaric')==1 || strcmp(identvariables{identvar},'v-component_of_wind_tropopause')==1
                                tmpvar=squeeze(sv.data(:,gy-pltcen:gy+pltcen,gx-pltcen:gx+pltcen));  
                            else
                                tmpvar=squeeze(sv.data(:,gy-pltcen:gy+pltcen,gx-pltcen:gx+pltcen));  
                            end
                            tmpvar=permute(tmpvar,[2 1]);                           
                        elseif size(size(sv.data),2)==4
                            if strcmp(identvariables{identvar},'Pressure_reduced_to_MSL_msl')==1 || strcmp(identvariables{identvar},'Pressure_surface')==1 || strcmp(identvariables{identvar},'Pressure_tropopause')==1
                                tmpvar=squeeze(sv.data(:,:,gy-pltcen:gy+pltcen,gx-pltcen:gx+pltcen))./100;  
                            elseif strcmp(identvariables{identvar},'Geopotential_height_isobaric')==1
                                tmpvar=squeeze(sv.data(:,:,gy-pltcen:gy+pltcen,gx-pltcen:gx+pltcen))./10; 
                            elseif strcmp(identvariables{identvar},'Absolute_vorticity_isobaric')==1
                                tmpvar=squeeze(sv.data(:,:,gy-pltcen:gy+pltcen,gx-pltcen:gx+pltcen)).*10^5;  
                            elseif strcmp(identvariables{identvar},'u-component_of_wind_height_above_ground')==1 || strcmp(identvariables{identvar},'u-component_of_wind_isobaric')==1 || strcmp(identvariables{identvar},'u-component_of_wind_tropopause')==1 || strcmp(identvariables{identvar},'v-component_of_wind_height_above_ground')==1 || strcmp(identvariables{identvar},'v-component_of_wind_isobaric')==1 || strcmp(identvariables{identvar},'v-component_of_wind_tropopause')==1
                                tmpvar=squeeze(sv.data(:,:,gy-pltcen:gy+pltcen,gx-pltcen:gx+pltcen));  
                            else
                                tmpvar=squeeze(sv.data(:,:,gy-pltcen:gy+pltcen,gx-pltcen:gx+pltcen));  
                            end
                            if size(tmpvar,3)==1
                                tmpvar=permute(tmpvar,[2 1]);                                
                            else
                                tmpvar=permute(tmpvar,[3 2 1]);
                            end
                        end                            
                        % Fix any missing values
                        for nans=1
                            plev(plev<-9.0000e+30)=NaN;	                
                            nlat(nlat<-9.0000e+30)=NaN;	
                            elon(elon<-9.0000e+30)=NaN;	
                            tmpvar(tmpvar<-9.0000e+30)=NaN;	
                        end
                        % Storm Center the Synoptic Grid
                        gridlat=nlat;
                        gridlon=elon;
                        % Make grid larger
                        grlon=[nan(size(gridlon,1),300) gridlon nan(size(gridlon,1),300)];
                        grlat=[nan(size(gridlon,1),300) gridlat nan(size(gridlon,1),300)];
                        gvar=[nan(size(gridlon,1),300,size(tmpvar,3)) tmpvar nan(size(gridlon,1),300,size(tmpvar,3))];
                        grlon=cat(1,nan(300,size(grlon,2)), grlon, nan(300,size(grlon,2)));
                        grlat=cat(1,nan(300,size(grlon,2)), grlat, nan(300,size(grlon,2)));
                        gvar=cat(1,nan(300,size(grlon,2),size(tmpvar,3)), gvar, nan(300,size(grlon,2),size(tmpvar,3)));
                        % Grab current date/fhr LAT/LON                        
                        LATall=EXP_lat(identloop,(str2num(num2str(3*(identfhr-1),'%03d'))/3)+1,hwrfvariables);
                        LONall=EXP_lon(identloop,(str2num(num2str(3*(identfhr-1),'%03d'))/3)+1,hwrfvariables); 
                        % Find the storm center
                        tmp1 = abs(grlat-LATall);
                        tmp2 = abs(grlon-LONall);
                        tmp1(tmp1>1)=NaN;
                        tmp2(tmp2>1)=NaN;
                        tmp3=tmp1.*tmp2;
                        minimum=min(min(tmp3));
                        [gx,gy]=find(tmp3==minimum);
						for weirdgrid=1:100
							if isnan(tmp3(gx-1,gy-1))==1 | isnan(tmp3(gx+1,gy+1))==1 | isnan(tmp3(gx-1,gy+1))==1 | isnan(tmp3(gx+1,gy-1))==1
								tmp3(gx,gy)=NaN;
								minimum=min(min(tmp3));							
								[gx,gy]=find(tmp3==minimum);
							end
						end
                        A=[LONall LATall];
                        for i=1:size(gx,1)
                            B(i,:)=[grlon(gx(i),gy(i)) grlat(gx(i),gy(i))];
                        end
                        dist2 = sum((B - A) .^ 2, 2);
                        %find the smallest distance and use that as an index into B:
                        clear B A
                        [ax,ay] = min(dist2);
                        gx=gx(ay);
                        gy=gy(ay);
                        % Create Storm-Centered Grid
                        test=squeeze(gvar(gx-pltcen:gx+pltcen,gy-pltcen:gy+pltcen,1:size(tmpvar,3)));
                        testlt=grlat(gx-pltcen:gx+pltcen,gy-pltcen:gy+pltcen);
                        testln=grlon(gx-pltcen:gx+pltcen,gy-pltcen:gy+pltcen);               
                        var_f(:,:,1:size(tmpvar,3),identfhr)=test;
                        varlt_f(:,:,identfhr)=testlt;
                        varln_f(:,:,identfhr)=testln;
                    end
                    disp(['CYCLE: ', num2str(identloop),' FHR: ',num2str(identfhr)])
                end
                if sum(sum(sum(~isnan(var_f(:,:,2,:)))))==0
                    var_f=squeeze(var_f(:,:,1,:));
                end
                save([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_synoptic_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{identvar},'.mat'],'-v7.3','var_f','varlt_f','varln_f','plev');
                clear var*
                disp(['COMPLETED CYCLE #: ', num2str(identloop),' for ',identvariables{identvar},'!'])
            end
        end
        clearvars -except skip* ident* hwrfvariables
    end
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%% STORM: creates .mat files of chosen variables %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
for hwrfvariables=1:size(identexp,1)
    if identstorm==1
        identexp0=identexp{hwrfvariables};
        disp(['EXPERIMENT: ',identexp0])
        pltcen=400; % number of gridpoints in each direction
        pltcen2=306; % new number of gridpoints in each direction
        % Load all Storm Centers for All Cycles and Forecasts
        load([identout,'RESULTS/',identfold,identn,'/',identn,'_latlon.mat']);
        % run loops
        for identvar=identv
            for identloop=identbatch % value set in batch script to run parallel for all cycles
                % initialize variables (should be same for each!)
                disp(['CYCLE INIT DATE: ',identinittimesunique(identloop,:)])
                var_f=nan(pltcen2*2+1,pltcen2*2+1,identlevels,identmodelfhr,'single'); %lonxlatxlevelsxFHR (1 for each init)
                varlt_f=nan(pltcen2*2+1,pltcen2*2+1,identmodelfhr,'single');
                varln_f=nan(pltcen2*2+1,pltcen2*2+1,identmodelfhr,'single');
                for identfhr=1:identmaxfhr % loop over number of forecast hours for that cycle
                    if isnan(BT_lat(identloop,identfhr))==1
                        disp('BT has a NaN...skipping date!')
                    else
                        ncid=ncgeodataset([identscrub,identexp0,'/com/',identinittimesunique(identloop,:),'/',ident(3:4),upper(identhwrf(end)),'/',identhwrf,'.',identinittimesunique(identloop,:),'.hwrfprs.storm.0p015.f',num2str(3*(identfhr-1),'%03d'),'.grb2']);
                        identvariables=sort(ncid.variables);
                        for i=1:size(identvariables,1)
                            if strcmp(identvariables{i},'height_above_ground')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'height_above_ground_layer')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'height_above_ground_layer_bounds')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'height_above_ground1')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'height_above_ground2')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'isobaric')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'isobaric1')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'lat')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'lon')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'time')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'time1')==1
                                identvariables{i}=[];
                            end
                            if strcmp(identvariables{i},'time1_bounds')==1
                                identvariables{i}=[];
                            end
                        end      
                        sv = ncid.geovariable('Latitude_-90_to_90_surface');
                        nlat=squeeze(sv.data(:,:,:,:));
                        nlat=permute(nlat,[2 1]); 
                        nlat=nlat(701-pltcen:701+pltcen,701-pltcen:701+pltcen);
                        sv = ncid.geovariable('East_Longitude_0_to_360_surface');
                        elon=squeeze(sv.data(:,:,:,:));
                        elon=permute(elon,[2 1]);
                        elon(elon>180)=elon(elon>180)-360; 
                        elon=elon(701-pltcen:701+pltcen,701-pltcen:701+pltcen);
                        sv = ncid.geovariable('isobaric');
                        plev=squeeze(sv.data(:,:,:,:))/100;  
                        sv = ncid.geovariable{identvariables{identvar}};
                        if size(size(sv.data),2)==3
                            if strcmp(identvariables{identvar},'Pressure_reduced_to_MSL_msl')==1 || strcmp(identvariables{identvar},'Pressure_surface')==1 || strcmp(identvariables{identvar},'Pressure_tropopause')==1
                                tmpvar=squeeze(sv.data(:,701-pltcen:701+pltcen,701-pltcen:701+pltcen))/100;  
                            elseif strcmp(identvariables{identvar},'Absolute_vorticity_isobaric')==1
                                tmpvar=squeeze(sv.data(:,701-pltcen:701+pltcen,701-pltcen:701+pltcen)).*10^5;  
                            elseif strcmp(identvariables{identvar},'u-component_of_wind_height_above_ground')==1 || strcmp(identvariables{identvar},'u-component_of_wind_isobaric')==1 || strcmp(identvariables{identvar},'u-component_of_wind_tropopause')==1 || strcmp(identvariables{identvar},'v-component_of_wind_height_above_ground')==1 || strcmp(identvariables{identvar},'v-component_of_wind_isobaric')==1 || strcmp(identvariables{identvar},'v-component_of_wind_tropopause')==1
                                tmpvar=squeeze(sv.data(:,701-pltcen:701+pltcen,701-pltcen:701+pltcen));  
                            else
                                tmpvar=squeeze(sv.data(:,701-pltcen:701+pltcen,701-pltcen:701+pltcen));  
                            end
                            tmpvar=permute(tmpvar,[2 1]);                           
                        elseif size(size(sv.data),2)==4
                            if strcmp(identvariables{identvar},'Pressure_reduced_to_MSL_msl')==1 || strcmp(identvariables{identvar},'Pressure_surface')==1 || strcmp(identvariables{identvar},'Pressure_tropopause')==1
                                tmpvar=squeeze(sv.data(:,:,701-pltcen:701+pltcen,701-pltcen:701+pltcen))/100;  
                            elseif strcmp(identvariables{identvar},'Absolute_vorticity_isobaric')==1
                                tmpvar=squeeze(sv.data(:,:,701-pltcen:701+pltcen,701-pltcen:701+pltcen)).*10^5;  
                            elseif strcmp(identvariables{identvar},'Geopotential_height_isobaric')==1
                                tmpvar=squeeze(sv.data(:,:,701-pltcen:701+pltcen,701-pltcen:701+pltcen))./10;  
                            elseif strcmp(identvariables{identvar},'u-component_of_wind_height_above_ground')==1 || strcmp(identvariables{identvar},'u-component_of_wind_isobaric')==1 || strcmp(identvariables{identvar},'u-component_of_wind_tropopause')==1 || strcmp(identvariables{identvar},'v-component_of_wind_height_above_ground')==1 || strcmp(identvariables{identvar},'v-component_of_wind_isobaric')==1 || strcmp(identvariables{identvar},'v-component_of_wind_tropopause')==1
                                tmpvar=squeeze(sv.data(:,:,701-pltcen:701+pltcen,701-pltcen:701+pltcen));  
                            else
                                tmpvar=squeeze(sv.data(:,:,701-pltcen:701+pltcen,701-pltcen:701+pltcen));  
                            end
                            if size(tmpvar,3)==1
                                tmpvar=permute(tmpvar,[2 1]);
                            else
                                tmpvar=permute(tmpvar,[3 2 1]);
                            end
                        end         
                        % Fix any missing values
                        for nans=1
                            plev(plev<-9.0000e+30)=NaN;	                
                            nlat(nlat<-9.0000e+30)=NaN;	
                            elon(elon<-9.0000e+30)=NaN;	
                            tmpvar(tmpvar<-9.0000e+30)=NaN;	
                        end

                        % Storm Center the Synoptic Grid
                        gridlat=nlat;
                        gridlon=elon;
                        % Make grid larger
                        grlon=[nan(size(gridlon,1),300) gridlon nan(size(gridlon,1),300)];
                        grlat=[nan(size(gridlon,1),300) gridlat nan(size(gridlon,1),300)];
                        gvar=[nan(size(gridlon,1),300,size(tmpvar,3)) tmpvar nan(size(gridlon,1),300,size(tmpvar,3))];
                        grlon=cat(1,nan(300,size(grlon,2)), grlon, nan(300,size(grlon,2)));
                        grlat=cat(1,nan(300,size(grlon,2)), grlat, nan(300,size(grlon,2)));
                        gvar=cat(1,nan(300,size(grlon,2),size(tmpvar,3)), gvar, nan(300,size(grlon,2),size(tmpvar,3)));
                        % Grab current date/fhr LAT/LON
                        LATall=EXP_lat(identloop,(str2num(num2str(3*(identfhr-1),'%03d'))/3)+1,hwrfvariables);
                        LONall=EXP_lon(identloop,(str2num(num2str(3*(identfhr-1),'%03d'))/3)+1,hwrfvariables);
                        % Find the storm center
                        tmp1 = abs(grlat-LATall);
                        tmp2 = abs(grlon-LONall);
                        tmp1(tmp1>1)=NaN;
                        tmp2(tmp2>1)=NaN;
                        tmp3=tmp1.*tmp2;
                        minimum=min(min(tmp3));
                        [gx,gy]=find(tmp3==minimum);
						for weirdgrid=1:100
							if isnan(tmp3(gx-1,gy-1))==1 | isnan(tmp3(gx+1,gy+1))==1 | isnan(tmp3(gx-1,gy+1))==1 | isnan(tmp3(gx+1,gy-1))==1
								tmp3(gx,gy)=NaN;
								minimum=min(min(tmp3));							
								[gx,gy]=find(tmp3==minimum);
							end
						end
                        A=[LONall LATall];
                        for i=1:size(gx,1)
                            B(i,:)=[grlon(gx(i),gy(i)) grlat(gx(i),gy(i))];
                        end
                        dist2 = sum((B - A) .^ 2, 2);
                        %find the smallest distance and use that as an index into B:
                        clear B A
                        [ax,ay] = min(dist2);
                        gx=gx(ay);
                        gy=gy(ay);
                        % Create Storm-Centered Grid
                        test=squeeze(gvar(gx-pltcen2:gx+pltcen2,gy-pltcen2:gy+pltcen2,1:size(tmpvar,3)));
                        testlt=grlat(gx-pltcen2:gx+pltcen2,gy-pltcen2:gy+pltcen2);
                        testln=grlon(gx-pltcen2:gx+pltcen2,gy-pltcen2:gy+pltcen2);               
                        var_f(:,:,1:size(tmpvar,3),identfhr)=test;
                        varlt_f(:,:,identfhr)=testlt;
                        varln_f(:,:,identfhr)=testln;
                    end
                    disp(['CYCLE: ', num2str(identloop),' FHR: ',num2str(identfhr)])
                end
                if sum(sum(sum(~isnan(var_f(:,:,2,:)))))==0
                    var_f=squeeze(var_f(:,:,1,:));
                end
                if identvar==7
                    identvariables{identvar}='Convective_precipitation_surface_Accumulation';
                elseif identvar==11
                    identvariables{identvar}='Downward_Long-Wave_Radp_Flux_surface_Average';
                elseif identvar==13
                    identvariables{identvar}='Downward_Short-Wave_Radiation_Flux_surface_Average';
                elseif identvar==20
                    identvariables{identvar}='Large-scale_precipitation_non-convective_surface_Accumulation';
                elseif identvar==53
                    identvariables{identvar}='Total_precipitation_surface_Accumulation';
                elseif identvar==55
                    identvariables{identvar}='Upward_Long-Wave_Radp_Flux_surface_Average';
                elseif identvar==57
                    identvariables{identvar}='Upward_Short-Wave_Radiation_Flux_surface_Average';
                end    
                save([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_storm_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{identvar},'.mat'],'-v7.3','var_f','varlt_f','varln_f','plev');
                clear var*
                disp(['COMPLETED CYCLE #: ', num2str(identloop),' for ',identvariables{identvar},'!'])
            end
        end
        clearvars -except skip* ident*
    end
end

ncid=ncgeodataset([identscrub,identexp{1},'/com/',identinittimesunique(1,:),'/',ident(3:4),upper(identhwrf(end)),'/',identhwrf,'.',identinittimesunique(1,:),'.hwrfprs.storm.0p015.f',num2str(3*(1-1),'%03d'),'.grb2']);
identvariables=sort(ncid.variables);
sv = ncid.geovariable('isobaric');
plev=squeeze(sv.data(:,:,:,:))/100;   
for i=1:size(identpresplan,2)
    identpresplan(i)=find(plev==identpresplan(i));
end
for i=1:size(identvariables,1)
    if strcmp(identvariables{i},'height_above_ground')==1
        identvariables{i}=[];
    end
    if strcmp(identvariables{i},'height_above_ground_layer')==1
        identvariables{i}=[];
    end
    if strcmp(identvariables{i},'height_above_ground_layer_bounds')==1
        identvariables{i}=[];
    end
    if strcmp(identvariables{i},'height_above_ground1')==1
        identvariables{i}=[];
    end
    if strcmp(identvariables{i},'height_above_ground2')==1
        identvariables{i}=[];
    end
    if strcmp(identvariables{i},'isobaric')==1
        identvariables{i}=[];
    end
    if strcmp(identvariables{i},'isobaric1')==1
        identvariables{i}=[];
    end
    if strcmp(identvariables{i},'lat')==1
        identvariables{i}=[];
    end
    if strcmp(identvariables{i},'lon')==1
        identvariables{i}=[];
    end
    if strcmp(identvariables{i},'time')==1
        identvariables{i}=[];
    end
    if strcmp(identvariables{i},'time1')==1
        identvariables{i}=[];
    end
    if strcmp(identvariables{i},'time1_bounds')==1
        identvariables{i}=[];
    end
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%% Convert U/V to RAD & TAN & WNDSPD for both STORM and SYNOPTIC %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
% Synoptic
for hwrfvariables=1
    if identsynopticrt==1
        for radtan=1:3
            if radtan==1        
                if sum(ismember(identv, [73,76]))==2
                    identvarname1='radial-component_of_wind_height_above_ground';
                    identvarname2='tangential-component_of_wind_height_above_ground'; 
                    identvarname3='wind_speed_height_above_ground';
                    tmpvar1=73;
                    tmpvar2=76;
                    identv=[identv 80 83 87];                    
                end
            elseif radtan==2       
                if sum(ismember(identv, [74,77]))==2
                    identvarname1='radial-component_of_wind_isobaric';
                    identvarname2='tangential-component_of_wind_isobaric'; 
                    identvarname3='wind_speed_isobaric';                    
                    tmpvar1=74;
                    tmpvar2=77; 
                    identv=[identv 81 84 88];
                end
            elseif radtan==3       
                if sum(ismember(identv, [75,78]))==2
                    identvarname1='radial-component_of_wind_tropopause';
                    identvarname2='tangential-component_of_wind_tropopause';
                    identvarname3='wind_speed_tropopause';
                    tmpvar1=75;
                    tmpvar2=78; 
                    identv=[identv 82 85 89];                                        
                end
            end           
            if exist('tmpvar1','var')==1
                for hwrfvariable=1:size(identexp,1)
                    identexp0=identexp{hwrfvariable};
                    disp(['EXPERIMENT: ',identexp0])
                    for identgrid=1
                        load([identout,'RESULTS/',identfold,identn,'/',identn,'_latlon.mat']);
                        for identloop=identbatch
                            if isnan(BT_lat(identloop,1))==1
                                disp('BT has a NaN...skipping date!')
                            else                      
                                if identgrid==1 % SYNOPTIC
                                    pltcen=150;
                                    rds1=0:0.125*111.11:pltcen*0.125*111.11; %0.125 res for hwrf synoptic grid  
                                    rds2=sort(rds1*-1);
                                    rds=[rds2 rds1(2:end)]';
                                    identgridname='synoptic';
                                end

                                if isfile([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{tmpvar1},'.mat'])==1                                
                                    load([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{tmpvar1},'.mat']);
                                    u=var_f;
                                    load([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{tmpvar2},'.mat']);
                                    v=var_f;
                                    [x,y] = meshgrid(rds,rds);
                                    [theta,rho] = cart2pol(x,y);
                                    theta=((flipud((theta+pi)')));
                                    U_r=(u.*cos(theta) + v.*sin(theta));
                                    U_t=(-u.*sin(theta) + v.*cos(theta));
                                    var_f=U_r;
                                    save([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvarname1,'.mat'],'-v7.3','var_f','varlt_f','varln_f','plev');
                                    var_f=U_t;
                                    save([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvarname2,'.mat'],'-v7.3','var_f','varlt_f','varln_f','plev');
                                    var_f=sqrt(u.^2+v.^2);                                    
                                    save([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvarname3,'.mat'],'-v7.3','var_f','varlt_f','varln_f','plev');
                                    disp(['COMPLETED RADTAN AND WNDSPD FOR ',upper(identgridname),' CYCLE #: ', num2str(identloop),'!'])                                    
                                else
                                    disp(['NO SUCH FILE EXISTS - YOU DID NOT CREATE .MAT FILES FOR THE ',identgridname,' GRID'])
                                end
                            end
                        end
                        clearvars -except skip* ident* tmpvar*
                    end
                end    
            end
            clear tmpvar1 tmpvar2
        end
        clearvars -except skip* ident*
    end
end 

% STORM
for hwrfvariables=1
    if identstormrt==1
        for radtan=1:3
            if radtan==1        
                if sum(ismember(identv, [73,76]))==2
                    identvarname1='radial-component_of_wind_height_above_ground';
                    identvarname2='tangential-component_of_wind_height_above_ground'; 
                    identvarname3='wind_speed_height_above_ground';
                    tmpvar1=73;
                    tmpvar2=76;
                    identv=[identv 80 83 87];                    
                end
            elseif radtan==2       
                if sum(ismember(identv, [74,77]))==2
                    identvarname1='radial-component_of_wind_isobaric';
                    identvarname2='tangential-component_of_wind_isobaric'; 
                    identvarname3='wind_speed_isobaric';                    
                    tmpvar1=74;
                    tmpvar2=77; 
                    identv=[identv 81 84 88];
                end
            elseif radtan==3       
                if sum(ismember(identv, [75,78]))==2
                    identvarname1='radial-component_of_wind_tropopause';
                    identvarname2='tangential-component_of_wind_tropopause';
                    identvarname3='wind_speed_tropopause';
                    tmpvar1=75;
                    tmpvar2=78; 
                    identv=[identv 82 85 89];                                        
                end
            end           
            if exist('tmpvar1','var')==1
                for hwrfvariable=1:size(identexp,1)
                    identexp0=identexp{hwrfvariable};
                    disp(['EXPERIMENT: ',identexp0])
                    for identgrid=1
                        load([identout,'RESULTS/',identfold,identn,'/',identn,'_latlon.mat']);
                        for identloop=identbatch
                            if isnan(BT_lat(identloop,1))==1
                                disp('BT has a NaN...skipping date!')
                            else                      
                                if identgrid==1 % STORM
                                    pltcen=306;
                                    rds1=0:0.015*111.11:pltcen*0.015*111.11; %0.015 res for hwrf storm grid  
                                    rds2=sort(rds1*-1);
                                    rds=[rds2 rds1(2:end)]';
                                    identgridname='storm';
                                end

                                if isfile([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{tmpvar1},'.mat'])==1                                
                                    load([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{tmpvar1},'.mat']);
                                    u=var_f;
                                    load([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{tmpvar2},'.mat']);
                                    v=var_f;
                                    [x,y] = meshgrid(rds,rds);
                                    [theta,rho] = cart2pol(x,y);
                                    theta=((flipud((theta+pi)')));
                                    U_r=(u.*cos(theta) + v.*sin(theta));
                                    U_t=(-u.*sin(theta) + v.*cos(theta));
                                    var_f=U_r;
                                    save([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvarname1,'.mat'],'-v7.3','var_f','varlt_f','varln_f','plev');
                                    var_f=U_t;
                                    save([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvarname2,'.mat'],'-v7.3','var_f','varlt_f','varln_f','plev');
                                    var_f=sqrt(u.^2+v.^2);                                    
                                    save([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvarname3,'.mat'],'-v7.3','var_f','varlt_f','varln_f','plev');
                                    disp(['COMPLETED RADTAN AND WNDSPD FOR ',upper(identgridname),' CYCLE #: ', num2str(identloop),'!'])                                    
                                else
                                    disp(['NO SUCH FILE EXISTS - YOU DID NOT CREATE .MAT FILES FOR THE ',identgridname,' GRID'])
                                end
                            end
                        end
                        clearvars -except skip* ident* tmpvar*
                    end
                end    
            end
            clear tmpvar1 tmpvar2
        end
        clearvars -except skip* ident*
    end
end 

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
%% Convert AVort to RVort for both STORM and SYNOPTIC %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%
% Synoptic
for hwrfvariables=1
    if identsynopticav==1
        for radtan=1
            if radtan==1        
                if sum(ismember(identv,1))==1
                    identvarname1='Relative_vorticity_isobaric';
                    tmpvar1=1;
                    identv=[identv 86];                    
                end
            end           
            if exist('tmpvar1','var')==1
                for hwrfvariable=1:size(identexp,1)
                    identexp0=identexp{hwrfvariable};
                    disp(['EXPERIMENT: ',identexp0])
                    for identgrid=1
                        load([identout,'RESULTS/',identfold,identn,'/',identn,'_latlon.mat']);
                        for identloop=identbatch
                            if isnan(BT_lat(identloop,1))==1
                                disp('BT has a NaN...skipping date!')
                            else                      
                                if identgrid==1 % SYNOPTIC
                                    pltcen=150;
                                    rds1=0:0.125*111.11:pltcen*0.125*111.11; %0.125 res for hwrf synoptic grid  
                                    rds2=sort(rds1*-1);
                                    rds=[rds2 rds1(2:end)]';
                                    identgridname='synoptic'; 
                                end

                                if isfile([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{tmpvar1},'.mat'])==1                                
                                    load([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{tmpvar1},'.mat']);
                                    omega=0.00007292;
                                    for tmp=1:size(var_f,3)
                                        var_f(:,:,tmp,:)=(squeeze(var_f(:,:,tmp,:))./10^5-(2.*omega.*sin(varlt_f.*(pi/180)))).*10^5; 
                                    end
                                    save([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvarname1,'.mat'],'-v7.3','var_f','varlt_f','varln_f','plev');
                                    disp(['COMPLETED RVRT FOR CYCLE #: ', num2str(identloop),'!'])
                                else
                                    disp(['NO SUCH FILE EXISTS - YOU DID NOT CREATE .MAT FILES FOR THE ',identgridname,' GRID'])
                                end
                            end
                        end
                        clearvars -except skip* ident* tmpvar*
                    end
                end    
            end
            clear tmpvar1 tmpvar2
        end
        clearvars -except skip* ident*
    end
end 

% Storm
for hwrfvariables=1
    if identstormav==1
        for radtan=1
            if radtan==1        
                if sum(ismember(identv,1))==1
                    identvarname1='Relative_vorticity_isobaric';
                    tmpvar1=1;
                    identv=[identv 86];                    
                end
            end           
            if exist('tmpvar1','var')==1
                for hwrfvariable=1:size(identexp,1)
                    identexp0=identexp{hwrfvariable};  
                    disp(['EXPERIMENT: ',identexp0])                    
                    for identgrid=1
                        load([identout,'RESULTS/',identfold,identn,'/',identn,'_latlon.mat']);
                        for identloop=identbatch
                            if isnan(BT_lat(identloop,1))==1
                                disp('BT has a NaN...skipping date!')
                            else                      
                                if identgrid==1 % STORM
                                    pltcen=306;
                                    rds1=0:0.015*111.11:pltcen*0.015*111.11; %0.015 res for hwrf storm grid  
                                    rds2=sort(rds1*-1);
                                    rds=[rds2 rds1(2:end)]';
                                    identgridname='storm';
                                end

                                if isfile([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{tmpvar1},'.mat'])==1                                
                                    load([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{tmpvar1},'.mat']);
                                    omega=0.00007292;
                                    for tmp=1:size(var_f,3)
                                        var_f(:,:,tmp,:)=(squeeze(var_f(:,:,tmp,:))./10^5-(2.*omega.*sin(varlt_f.*(pi/180)))).*10^5; 
                                    end
                                    save([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_',identgridname,'_',identexp0,'_',identinittimesunique(identloop,:),'_',identvarname1,'.mat'],'-v7.3','var_f','varlt_f','varln_f','plev');
                                    disp(['COMPLETED RVRT FOR CYCLE #: ', num2str(identloop),'!'])
                                else
                                    disp(['NO SUCH FILE EXISTS - YOU DID NOT CREATE .MAT FILES FOR THE ',identgridname,' GRID'])
                                end
                            end
                        end
                        clearvars -except skip* ident* tmpvar*
                    end
                end    
            end
            clear tmpvar1 tmpvar2
        end
        clearvars -except skip* ident*
    end
end 

identvariables{7,:}='Convective_precipitation_surface_Accumulation';
identvariables{11,:}='Downward_Long-Wave_Radp_Flux_surface_Average';
identvariables{13,:}='Downward_Short-Wave_Radiation_Flux_surface_Average';
identvariables{20,:}='Large-scale_precipitation_non-convective_surface_Accumulation';
identvariables{53,:}='Total_precipitation_surface_Accumulation';
identvariables{55,:}='Upward_Long-Wave_Radp_Flux_surface_Average';
identvariables{57,:}='Upward_Short-Wave_Radiation_Flux_surface_Average';
identvariables{80,:}='radial-component_of_wind_height_above_ground';
identvariables{81,:}='radial-component_of_wind_isobaric';
identvariables{82,:}='radial-component_of_wind_tropopause';
identvariables{83,:}='tangential-component_of_wind_height_above_ground';
identvariables{84,:}='tangential-component_of_wind_isobaric';
identvariables{85,:}='tangential-component_of_wind_tropopause';
identvariables{86,:}='Relative_vorticity_isobaric';
identvariables{87,:}='wind_speed_height_above_ground';
identvariables{88,:}='wind_speed_isobaric';
identvariables{89,:}='wind_speed_tropopause';

%% %%%%%%%%%%%%%%%%%%%%%% %%
%% Synoptic Grid Graphics %%
%% %%%%%%%%%%%%%%%%%%%%%% %%
for hwrfplots=1
    if identgraphicssynoptic==1
        % Users can change this 
        pltkm=2000; % how far out the storm-centered plot should go
        innerradu=19; % radav: start at 250 km
        outerradu=73; % radav: 3D end at 1000 km
        outerradu2=73; % radav 2D: end at 1000 km
        % End of user settings
        pltcen=150;% how many gridpoints from center .mat files
        radbin=0.125; % resolution of synoptic grid
        pltpt=ceil(pltkm/(radbin*111.11))+1; % to get to pltkm km
        nav=nan(size(identinittimesunique,1),identmodelfhr);
        spPos=[0.11 0.13 0.75 0.75]; % arrange plots the same
        clPos=[0.88 0.13 0.04 0.75]; % arrange plots the same
        % Don't plot u- or v- wind from SYNOPTIC grid        
        % All Graphics
        for identvar=identvar0
            disp(['STARTING VARIABLE: ',identvariables{identvar}])                        
            load([identout,'RESULTS/',identfold,identn,'/',identn,'_latlon.mat']);
            for identloop=identbatch %1:size(identinittimesunique,1)
                if sum(isnan(BT_lat(identloop,:)))==size(BT_lat,2)
                    disp('BT is all NaNs...skipping date!')
                else
                    %% Get data for each experiment
                    for identexploop=identvarexp0%1:size(identexp,1)
                        % This will loop over EXP experiments - same code for each!
                        identexp0=identexp{identexploop};
                        disp(['EXPERIMENT: ',identexp0])                    
                        if identvar==88
                            load([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_synoptic_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{74},'.mat']);
                            u=var_f;
                            load([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_synoptic_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{77},'.mat']);
                            v=var_f;
                            load([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_synoptic_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{16},'.mat']);
                            gph=var_f;
                        end
                        load([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_synoptic_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{identvar}])
                        run customcolorbars
                        run customvariables % gets the colorbars and the variable bounds
                        if levs==1
                            %% Creates Plan-View plots for each init/fhr at each level: var_f=(lon)x(lat)x(plev)x(fhr)
                            if identplan==1
                                if isfile([identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((1-1)*3),'_PLEV',num2str(plev(7)),'_',savename,'_PLAN.png'])==0 || isfile([identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((1-1)*3),'_PLEV',num2str(plev(7)),'_',savename,'_PLAN.eps'])==0
                                    for loop=1:size(var_f,4)
                                        if isnan(BT_lat(identloop,loop))==1 || (identvar>=80 && identvar <=85)
                                        else
                                            for loop1=identpresplan % 850,700,500,200 %1:size(var_f,3)                                             
                                                tmpplt=var_f;
                                                tmpplt(tmpplt<cmin)=cmin;
                                                set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                                hfig=figure;
                                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                                ax1=subplot(3,4,[1:8]);
                                                hold on                                                                
                                                [c,h]=contourf(varln_f(:,:,loop),varlt_f(:,:,loop),tmpplt(:,:,loop1,loop),cntr);
                                                hold on
                                                if identvar==88
                                                    [c1,h1]=contour(varln_f(:,:,loop),varlt_f(:,:,loop),tmpplt(:,:,loop1,loop),cntr);
                                                    windbarbm(varlt_f(:,:,loop),varln_f(:,:,loop),u(:,:,loop1,loop),v(:,:,loop1,loop),20,1,[.5 .5 .5])
                                                    [g1,p1]=contour(varln_f(:,:,loop),varlt_f(:,:,loop),gph(:,:,loop1,loop),[0:2:2000],'w','linewidth',2); 
                                                    clabel(g1,p1,[0:4:2000],'color','k','labelspacing',1000)
                                                else
                                                    [c1,h1]=contour(varln_f(:,:,loop),varlt_f(:,:,loop),tmpplt(:,:,loop1,loop),cntr1,'k');
                                                end
                                                
                                                caxis([cmin cmax])
                                                axis([varln_f(pltcen+1,pltcen+1,loop)-(pltkm/111.11) varln_f(pltcen+1,pltcen+1,loop)+(pltkm/111.11) varlt_f(pltcen+1,pltcen+1,loop)-(pltkm/111.11) varlt_f(pltcen+1,pltcen+1,loop)+(pltkm/111.11)])
                                                colormap(custommap(20,WC1))
                                                load coastlines
                                                plot(coastlon,coastlat,'k','linewidth',2);
                                                xlabel('Longitude','fontsize',20)
                                                ylabel('Latitude','fontsize',20)
                                                viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],0/111.11,'Color','k','linewidth',1);
                                                viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],250/111.11,'Color','k','linewidth',1);
                                                viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],500/111.11,'Color','k','linewidth',1);
                                                viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],750/111.11,'Color','k','linewidth',1);
                                                viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],1000/111.11,'Color','k','linewidth',1);
                                                viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],1250/111.11,'Color','k','linewidth',1);                                
                                                viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],1500/111.11,'Color','k','linewidth',1);                                
                                                viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],1750/111.11,'Color','k','linewidth',1);                                
                                                viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],2000/111.11,'Color','k','linewidth',1);                                
                                                set(gca,'fontsize',20)
                                                set(gca,'plotboxaspectratio',[1 1 1])
                                                cl=colorbar;
                                                if identvar==88
                                                    colormap(gca,custommap(28,WC1))
                                                    set(cl,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',20)
                                                    set(cl,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
						    %text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                    %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                    %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                    %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                    %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                    %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                    %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');                                                
                                                else
                                                    set(cl,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',20)
                                                    adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                                    if sum(adaa)>0
                                                    else
                                                        adaa((size(adaa,2)+1)/2)=0;
                                                    end
                                                    set(cl,'YTicklabel',adaa) 
                                                end
                                                set(gcf, 'InvertHardcopy', 'off')
                                                set(gcf,'Units','inches');
                                                screenposition = get(gcf,'Position');
                                                set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                                set(gcf, 'InvertHardcopy', 'off')
                                                text(1,1.03,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
                                                text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ FHR: ',num2str((loop-1)*3),' $\mid$ PLEV: ',num2str(plev(loop1)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
                                                if identvar==88
                                                    text(0,1.065,['\textbf{',varname,' (',units,') \& GPH (dam) $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
                                                else
                                                    text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
                                                end
                                                ax=gca;
                                                box on
                                                set(ax, 'Layer', 'top')
                                                ax.LineWidth=1;  
                                                set(gca,'position',spPos)
                                                set(cl,'position',clPos)
                                                set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                                f = getframe(hfig);
                                                filename=[identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_PLEV',num2str(plev(loop1)),'_',savename,'_PLAN'];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                                %print([identfields,'/',identexp,'/FIGURES/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_PLEV',num2str(plev(loop1)),'_',savename,'_PLAN'],'-dpdf','-r200');
                                                close all 
                                            end
                                        end
                                    end  
                                end
                            end
                            
                            %% Creates Azav at init time for each forecast hr: (levs)x(radius)x(fhr)
                            rds=0:radbin*111.11:pltcen*radbin*111.11;
                            vectRAW=nan(size(var_f,3),size(2:pltpt+1,2),size(var_f,4)); % preallocate
                            for t=1:size(var_f,4)
                                cnt=2;
                                for i=2:pltpt
                                    inner_rad = rds(i-1)/radbin/111.11;
                                    outer_rad = rds(i)/radbin/111.11;
                                    ringa=pi*rds(i)*rds(i)-pi*rds(i-1)*rds(i-1);
                                    center = pltcen+1; 
                                    mask1_size = pltcen*2+1;
                                    [x,y] = meshgrid(1:mask1_size,1:mask1_size);
                                    distance = (x-center).^2+(y-center).^2;
                                    mask = distance<outer_rad^2 & distance>inner_rad^2;
                                    mask=repmat(mask,1,1,size(var_f,3));
                                    valtest=var_f(:,:,:,t);
                                    valtest(mask==0)=NaN;
                                    vectRAW(:,cnt,t)=squeeze(nanmean(nanmean(valtest,1),2));
                                    rdsplt(cnt)=rds(i);
                                    cnt=cnt+1;                                
                                end                      
                                vectRAW(:,2,t)=vectRAW(:,3,t)./2;
                                vectRAW(:,1,t)=vectRAW(:,2,t)./2;
                                rdsplt(1)=rds(1);
                                t
                            end                                                       
                            
                            %% For 3D only, make a (radius)x(plev) plot for each fhr. This does not exist for the 1-level 2D plots.
                            if isfile([identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((1-1)*3),'_',savename,'_RPAZAV.png'])==0 || isfile([identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((1-1)*3),'_',savename,'_RPAZAV.eps'])==0
                                for loop=1:size(vectRAW,3) 
                                    if isnan(BT_lat(identloop,loop))==1
                                    else
                                        tmpplt=vectRAW;
                                        tmpplt(tmpplt<cmin)=cmin;
                                        set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                        hfig=figure;
                                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                        ax1=subplot(3,4,[1:8]);
                                        hold on
                                        [c,h]=contourf(rdsplt,plev,tmpplt(:,:,loop),cntr);
                                        hold on
                                        [c1,h1]=contour(rdsplt,plev,tmpplt(:,:,loop),cntr1,'k');
                                        axis ij
                                        caxis([cmin cmax])
                                        ylim([0 1000])
                                        xlim([0 pltkm])
                                        colormap(custommap(20,WC1))
                                        xlabel('Radius (km)','fontsize',22)
                                        ylabel('Pressure (hPa)','fontsize',22)
                                        set(gca,'yTick',[0:100:1000],'fontsize',22)
                                        set(gca,'xtick',0:250:pltkm,'fontsize',22)
                                        set(gca,'fontsize',20)
                                        set(gca,'plotboxaspectratio',[1 1 1])
                                        cl=colorbar;
                                        if identvar==88
                                            colormap(gca,custommap(28,WC1))
                                                set(cl,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',20)
                                                set(cl,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
						%text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');                                                                                                                                    
                                        else
                                            set(cl,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',20)
                                            adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                            if sum(adaa)>0
                                            else
                                                adaa((size(adaa,2)+1)/2)=0;
                                            end
                                            set(cl,'YTicklabel',adaa) 
                                        end                                       
                                        set(gcf, 'InvertHardcopy', 'off')
                                        set(gcf,'Units','inches');
                                        screenposition = get(gcf,'Position');
                                        set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                        set(gcf, 'InvertHardcopy', 'off')
                                        text(1,1.03,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
                                        text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ FHR: ',num2str((loop-1)*3),' $\mid$ AZAV}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
                                        text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
                                        ax=gca;
                                        box on
                                        set(ax, 'Layer', 'top')
                                        ax.LineWidth=1;       
                                        set(gca,'position',spPos)
                                        set(cl,'position',clPos)
                                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                        f = getframe(hfig);
                                        filename=[identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_',savename,'_RPAZAV'];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                        %print([identfields,'/',identexp,'/FIGURES/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_',savename,'_RPAZAV'],'-dpdf','-r200');
                                        close all
                                    end
                                end
                            end
                            
                            %% For 3D only, make a (radius)x(fhr) plot for each level. This is the default for the 1-level 2D plots.
                            if isfile([identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((1-1)*3),'_',savename,'_3DRTAZAV.png'])==0 ||  isfile([identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((1-1)*3),'_',savename,'_3DRTAZAV.eps'])==0
                                for loop=identpresplan % 850,700,500,200 %1:size(var_f,3)
                                    tmpplt=vectRAW;
                                    tmpplt(tmpplt<cmin)=cmin;
                                    set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                    hfig=figure;
                                    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                    ax1=subplot(3,4,[1:8]);
                                    hold on
                                    [c,h]=contourf(0:3:size(vectRAW,3)*3-1,rdsplt,squeeze(tmpplt(loop,:,:)),cntr);
                                    hold on
                                    [c1,h1]=contour(0:3:size(vectRAW,3)*3-1,rdsplt,squeeze(tmpplt(loop,:,:)),cntr1,'k');
                                    caxis([cmin cmax])
                                    ylim([0 pltkm])
                                    xlim([0 identmaxfhr*3-3])
                                    colormap(custommap(20,WC1))
                                    ylabel('Radius (km)','fontsize',22)
                                    xlabel('Forecast Hour','fontsize',22)
                                    set(gca,'xtick',0:12:size(vectRAW,3)*3-1,'fontsize',22)
                                    set(gca,'ytick',0:100:pltkm,'fontsize',22)
                                    set(gca,'fontsize',20)
                                    set(gca,'plotboxaspectratio',[1 1 1])
                                    cl=colorbar;
                                    if identvar==88
                                        colormap(gca,custommap(28,WC1))
                                        set(cl,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',20)
                                        set(cl,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
					%text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');                                                                                                                                  
                                    else
                                        set(cl,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',20)
                                        adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                        if sum(adaa)>0
                                        else
                                            adaa((size(adaa,2)+1)/2)=0;
                                        end
                                        set(cl,'YTicklabel',adaa) 
                                    end   
                                    set(gcf, 'InvertHardcopy', 'off')
                                    set(gcf,'Units','inches');
                                    screenposition = get(gcf,'Position');
                                    set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                    set(gcf, 'InvertHardcopy', 'off')
                                    text(1,1.03,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
                                    text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV: ',num2str(plev(loop)),' $\mid$ AZAV}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
                                    text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                                                          
                                    ax=gca;
                                    box on
                                    set(ax, 'Layer', 'top')
                                    ax.LineWidth=1;       
                                    set(gca,'position',spPos)
                                    set(cl,'position',clPos)
                                    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                    f = getframe(hfig);
                                    filename=[identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_PLEV',num2str(plev(loop)),'_',savename,'_3DRTAZAV'];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                    %print([identfields,'/',identexp,'/FIGURES/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_',savename,'_3DRTAZAV'],'-dpdf','-r200');
                                    close all
                                end
                            end
                            
                            %% Create azav plot of plev vs. forecast hour for rad-averaged area      
                            rds=rdsplt;
                            innerrad=innerradu;
                            outerrad=outerradu;
                            filerad=[num2str(round(rds(innerrad))),'_',num2str(round(rds(outerrad)))];
                            % Radially Averaged from innerrad to outerrad km
                            TotalA=pi*(rds(outerrad)^2)-pi*(rds(innerrad)^2);  
                            for i=innerrad+1:outerrad
                                RingA(i-innerrad)=pi*(rds(i))^2-pi*(rds(i-1))^2;
                                vals_d(:,i-innerrad,:)=([vectRAW(:,i,:)+vectRAW(:,i-1,:)]/2);
                            end
                            for i=1:outerrad-innerrad
                                Ddi(:,i,:)=vals_d(:,i,:).*RingA(i);
                            end
                            navi=squeeze(sum(Ddi,2)/TotalA); % (plev)x(fhr)
                            clear TotalA RingA vals_d Ddi
                            if isfile([identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_EVO_',filerad,'_',savename,'.png'])==0 || isfile([identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_EVO_',filerad,'_',savename,'.eps'])==0
                                for loop=1
                                    tmpplt=navi;
                                    tmpplt(tmpplt<cmin)=cmin;
                                    set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                    hfig=figure;
                                    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                    ax1=subplot(3,4,[1:8]);
                                    hold on
                                    [c,h]=contourf(0:3:size(navi,2)*3-1,plev,tmpplt,cntr);
                                    hold on
                                    [c1,h1]=contour(0:3:size(navi,2)*3-1,plev,tmpplt,cntr1,'k');
                                    axis ij
                                    caxis([cmin cmax])
                                    ylim([0 1000])
                                    xlim([0 identmaxfhr*3-3])
                                    colormap(custommap(20,WC1))
                                    xlabel('Forecast Hour','fontsize',22)
                                    ylabel('Pressure (hPa)','fontsize',22)
                                    set(gca,'yTick',[0:100:1000],'fontsize',22)
                                    set(gca,'xtick',0:12:size(navi,2)*3-1,'fontsize',22)
                                    set(gca,'fontsize',20)
                                    set(gca,'plotboxaspectratio',[1 1 1])
                                    cl=colorbar;
                                    if identvar==88
                                        colormap(gca,custommap(28,WC1))
                                        set(cl,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',20)
                                        set(cl,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
					%text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');                                                                                                                                     
                                    else
                                        set(cl,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',20)
                                        adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                        if sum(adaa)>0
                                        else
                                            adaa((size(adaa,2)+1)/2)=0;
                                        end
                                        set(cl,'YTicklabel',adaa) 
                                    end   
                                    set(gcf, 'InvertHardcopy', 'off')
                                    set(gcf,'Units','inches');
                                    screenposition = get(gcf,'Position');
                                    set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                    set(gcf, 'InvertHardcopy', 'off')
                                    text(1,1.03,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
                                    text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ $\mathbf{\overline{r}}$=',num2str(ceil(rds(innerradu(1)))),'$\mathbf{-}$',num2str(ceil(rds(outerradu(1)))), ' km}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
                                    text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
                                    ax=gca;
                                    box on
                                    set(ax, 'Layer', 'top')
                                    ax.LineWidth=1; 
                                    set(gca,'position',spPos)
                                    set(cl,'position',clPos)                                
                                    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                    f = getframe(hfig);
                                    filename=[identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_EVO_',filerad,'_',savename];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                    %print([identfields,'/',identexp,'/FIGURES/',identn,'_',identinittimesunique(identloop,:),'_EVO_',filerad,'_',savename],'-dpdf','-r200');
                                    close all
                                end
                            end                              
                                                      
                        elseif levs==0
                            %% Creates Plan-View plots for each init/fhr: var_f=(lon)x(lat)x(fhr)
                            if identplan==1
                                if isfile([identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((1-1)*3),'_',savename,'_PLAN.png'])==0 || isfile([identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((1-1)*3),'_',savename,'_PLAN.eps'])==0                           
                                    for loop=1:size(var_f,3) % (lon)x(lat)x(fhr)
                                        if isnan(BT_lat(identloop,loop))==1
                                        else
                                        tmpplt=var_f;
                                        tmpplt(tmpplt<cmin)=cmin;
                                        set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                        hfig=figure;
                                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                        ax1=subplot(3,4,[1:8]);
                                        hold on                                                                
                                        [c,h]=contourf(varln_f(:,:,loop),varlt_f(:,:,loop),tmpplt(:,:,loop),cntr);
                                        hold on
                                        [c1,h1]=contour(varln_f(:,:,loop),varlt_f(:,:,loop),tmpplt(:,:,loop),cntr1,'k');
                                        caxis([cmin cmax])
                                        axis([varln_f(pltcen+1,pltcen+1,loop)-(pltkm/111.11) varln_f(pltcen+1,pltcen+1,loop)+(pltkm/111.11) varlt_f(pltcen+1,pltcen+1,loop)-(pltkm/111.11) varlt_f(pltcen+1,pltcen+1,loop)+(pltkm/111.11)])
                                        colormap(custommap(20,WC1))
                                        load coastlines
                                        plot(coastlon,coastlat,'k','linewidth',2);
                                        xlabel('Longitude','fontsize',20)
                                        ylabel('Latitude','fontsize',20)
                                        viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],0/111.11,'Color','k','linewidth',1);
                                        viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],250/111.11,'Color','k','linewidth',1);
                                        viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],500/111.11,'Color','k','linewidth',1);
                                        viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],750/111.11,'Color','k','linewidth',1);
                                        viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],1000/111.11,'Color','k','linewidth',1);
                                        viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],1250/111.11,'Color','k','linewidth',1);                                
                                        viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],1500/111.11,'Color','k','linewidth',1);                                
                                        viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],1750/111.11,'Color','k','linewidth',1);                                
                                        viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],2000/111.11,'Color','k','linewidth',1);                                  
                                        set(gca,'fontsize',20)
                                        set(gca,'plotboxaspectratio',[1 1 1])
                                        cl=colorbar;
                                        set(cl,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',20)
                                        adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                        if sum(adaa)>0
                                        else
                                            adaa((size(adaa,2)+1)/2)=0;
                                        end
                                        set(cl,'YTicklabel',adaa) 
                                        set(gcf, 'InvertHardcopy', 'off')
                                        set(gcf,'Units','inches');
                                        screenposition = get(gcf,'Position');
                                        set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                        set(gcf, 'InvertHardcopy', 'off')
                                        text(1,1.03,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
                                        text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ FHR: ',num2str((loop-1)*3),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
                                        text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
                                        ax=gca;
                                        box on
                                        set(ax, 'Layer', 'top')
                                        ax.LineWidth=1;  
                                        set(gca,'position',spPos)
                                        set(cl,'position',clPos)
                                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                        f = getframe(hfig);
                                        filename=[identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_',savename,'_PLAN'];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                        %print([identfields,'/',identexp,'/FIGURES/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_',savename,'_PLAN'],'-dpdf','-r200');
                                        close all                            
                                        end
                                    end
                                end
                            end
                            
                            %% Creates RT Azav for each init time: vectRAW=(radius)x(fhr)
                            rds=0:radbin*111.11:pltcen*radbin*111.11;  
                            vectRAW=nan(size(rds,2),size(var_f,3)); %preallocate (radius)x(fhr)
                            for t=1:size(var_f,3)
                                for i=2:size(rds,2)
                                    %% MASK: +/- 100 km about radius
                                    inner_rad = rds(i-1)/radbin/111.11;
                                    outer_rad = rds(i)/radbin/111.11;
                                    ringa=pi*rds(i)*rds(i)-pi*rds(i-1)*rds(i-1);
                                    center = pltcen+1; 
                                    mask1_size = pltcen*2+1;
                                    [x,y] = meshgrid(1:mask1_size,1:mask1_size);
                                    distance = (x-center).^2+(y-center).^2;
                                    mask = distance<=outer_rad^2 & distance>=inner_rad^2;
                                    valtest=var_f(:,:,t);
                                    valtest(mask==0)=NaN;
                                    vectRAW(i,t)=squeeze(nanmean(nanmean(valtest,1),2));
                                end
                                t
                            end    
                            vectRAW(1,t)=vectRAW(2,t)./2;
                            %vectRAW(2,t)=vectRAW(3,t)./2;
                            
                            if isfile([identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_',savename,'_2DRTAZAV.png'])==0 || isfile([identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_',savename,'_2DRTAZAV.eps'])==0
                                for loop=1 % (radius)x(fhr) for the current (cycle)
                                    tmpplt=vectRAW;
                                    tmpplt(tmpplt<cmin)=cmin;
                                    set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                    hfig=figure;
                                    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                    ax1=subplot(3,4,[1:8]);
                                    hold on
                                    [c,h]=contourf(0:3:size(vectRAW,2)*3-1,rds,tmpplt,cntr);
                                    hold on
                                    [c1,h1]=contour(0:3:size(vectRAW,2)*3-1,rds,tmpplt,cntr1,'k');
                                    caxis([cmin cmax])
                                    ylim([0 pltkm])
                                    xlim([0 identmaxfhr*3-3])
                                    colormap(custommap(20,WC1))
                                    cl=colorbar;
                                    xlabel('Forecast Hour','fontsize',22)
                                    ylabel('Radius (km)','fontsize',22)
                                    set(gca,'yTick',[0:100:pltkm],'fontsize',22)
                                    set(gca,'xtick',0:12:size(vectRAW,2)*3-1,'fontsize',22)
                                    set(gca,'fontsize',20)
                                    set(gca,'plotboxaspectratio',[1 1 1])
                                    set(cl,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',20)
                                    adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                    if sum(adaa)>0
                                    else
                                        adaa((size(adaa,2)+1)/2)=0;
                                    end
                                    set(cl,'YTicklabel',adaa) 
                                    set(gcf, 'InvertHardcopy', 'off')
                                    set(gcf,'Units','inches');
                                    screenposition = get(gcf,'Position');
                                    set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                    set(gcf, 'InvertHardcopy', 'off')
                                    identexp0tex=regexprep(identexp0, '_', '-');
                                    text(1,1.03,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
                                    text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
                                    text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                                                          
                                    ax=gca;
                                    box on
                                    set(ax, 'Layer', 'top')
                                    ax.LineWidth=1;    
                                    set(gca,'position',spPos)
                                    set(cl,'position',clPos)
                                    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                    f = getframe(hfig);
                                    filename=[identfields,'/',identexp0,'/FIGURES/SYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_',savename,'_2DRTAZAV'];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                    %print([identfields,'/',identexp,'/FIGURES/',identn,'_',identinittimesunique(identloop,:),'_',savename,'_2DRTAZAV'],'-dpdf','-r200');
                                    close all
                                end
                            end
                            
                        end
                                                
                        %% Assign to EXP
                        if identexploop>1
				if levs==1
					load([identout,'RESULTS/',identfold,identn,'/',identn,'_SYNOPTIC_',identinittimesunique(identloop,:),'_',savename,'.mat']);
				elseif levs==0
					load([identout,'RESULTS/',identfold,identn,'/',identn,'_SYNOPTIC_',identinittimesunique(identloop,:),'_',savename,'.mat']);
				end
			end
			if levs==1
                            EXPplan(:,:,:,:,identexploop)=var_f;
                            EXPvectnav(:,:,:,identexploop)=vectRAW;
                            EXPvectnavi(:,:,:,identexploop)=navi;
			    save([identout,'RESULTS/',identfold,identn,'/',identn,'_SYNOPTIC_',identinittimesunique(identloop,:),'_',savename,'.mat'],'EXPplan','EXPvectnav','EXPvectnavi','-v7.3');
                        elseif levs==0
                            EXPplan(:,:,:,identexploop)=var_f;
                            EXPvectnav(:,:,identexploop)=vectRAW;      
			    save([identout,'RESULTS/',identfold,identn,'/',identn,'_SYNOPTIC_',identinittimesunique(identloop,:),'_',savename,'.mat'],'EXPplan','EXPvectnav','-v7.3');
                        end   
			['COMPLETED - EXP: ', identexpshort{identexploop},' | CYCLE: ',num2str(identloop),' | VARIABLE: ',savename]
                    end
                    
                    if identvarexp0==size(identexp,1) % if it's the last experiment, that means all needed data has been saved and generated from above!
						
						if strcmp(identdiff,'all')==1
							identdiff=nchoosek(1:size(identexp,1),2);
						end
						
						%% Differences 
						for df=1:size(identdiff,1)
							% Set Experiments
							exp1=identdiff(df,1);
							exp2=identdiff(df,2);
							% Difference: PLAN
							if levs==1   
								if identplan==1
									for loop=1:size(var_f,4) 
										if isnan(BT_lat(identloop,loop))==1
										else
											for loop1=identpresplan % 850,700,500,200 %1:size(var_f,3) 
												set(0,'defaultfigurecolor',[1 1 1]) % figure background color
												hfig=figure;
												rds1=0:0.125*111.11:pltcen*0.125*111.11; %0.125 res for hwrf synoptic grid  
												rds2=sort(rds1*-1);
												rds=[rds2 rds1(2:end)]';
												set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
												ax1=subplot(3,4,[1:8]);
												hold on                     
												diffplt=fliplr(EXPplan(:,:,loop1,loop,exp1)-EXPplan(:,:,loop1,loop,exp2))';
												diffplt(diffplt<min(dcntr))=min(dcntr);
												[c,h]=contourf(rds,rds,diffplt,dcntr);
												hold on
												[c1,h1]=contour(rds,rds,diffplt,dcntr);
												caxis([dmin dmax])
												axis([-pltkm pltkm -pltkm pltkm])
												colormap(custommap(20,WC2))              
												xlabel('Distance (km)','fontsize',20)
												ylabel('Distance (km)','fontsize',20)
												viscircles([0 0],0,'Color','k','linewidth',1);
												viscircles([0 0],250,'Color','k','linewidth',1);
												viscircles([0 0],500,'Color','k','linewidth',1);
												viscircles([0 0],750,'Color','k','linewidth',1);
												viscircles([0 0],1000,'Color','k','linewidth',1);
												viscircles([0 0],1250,'Color','k','linewidth',1);                                
												viscircles([0 0],1500,'Color','k','linewidth',1);                                
												viscircles([0 0],1750,'Color','k','linewidth',1);                                
												viscircles([0 0],2000,'Color','k','linewidth',1);                                
												set(gca,'fontsize',20)
												set(gca,'plotboxaspectratio',[1 1 1])
												cl=colorbar;
												set(cl,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',20)
												adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
												if sum(adaa)>0
												else
													adaa((size(adaa,2)+1)/2)=0;
												end
												set(gca,'xtick',-2000:500:2000)
												set(gca,'ytick',-2000:500:2000)  
												set(cl,'YTicklabel',adaa) 
												set(gcf, 'InvertHardcopy', 'off')
												set(gcf,'Units','inches');
												screenposition = get(gcf,'Position');
												set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
												set(gcf, 'InvertHardcopy', 'off')
												text(1,1.03,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
												text(1,1.065,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color','k','units','normalized');
												text(0.98,1.065,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
												text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ FHR: ',num2str((loop-1)*3),' $\mid$ PLEV: ',num2str(plev(loop1)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
												text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
												ax=gca;
												box on
												set(ax, 'Layer', 'top')
												ax.LineWidth=1; 
												set(gca,'position',spPos)
												set(cl,'position',clPos)                
												set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
												f = getframe(hfig);
												filename=[identfields,'/DIFFSYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_PLEV',num2str(plev(loop1)),'_',savename,'_PLANDIFF_',identexpshort{exp1},'-',identexpshort{exp2}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
												%print([identfields,'/',identn,'_',identinittimesunique(loop,:),'_FHR',num2str((loop-1)*3),'_PLEV',num2str(plev(loop1)),'_',savename,'_PLANDIFF'],'-dpdf','-r200');
												close all
											end
										end
									end
								end
							elseif levs==0
								if identplan==1
									for loop=1:size(var_f,3) % by fhr
										if isnan(BT_lat(identloop,loop))==1
										else
											set(0,'defaultfigurecolor',[1 1 1]) % figure background color
											hfig=figure;
											rds1=0:0.125*111.11:pltcen*0.125*111.11; %0.125 res for hwrf synoptic grid  
											rds2=sort(rds1*-1);
											rds=[rds2 rds1(2:end)]';
											set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
											ax1=subplot(3,4,[1:8]);
											hold on                     
											diffplt=fliplr(EXPplan(:,:,loop,exp1)-EXPplan(:,:,loop,exp2))';
											diffplt(diffplt<min(dcntr))=min(dcntr);
											[c,h]=contourf(rds,rds,diffplt,dcntr);
											hold on
											[c1,h1]=contour(rds,rds,diffplt,dcntr);
											caxis([dmin dmax])
											axis([-pltkm pltkm -pltkm pltkm])
											colormap(custommap(20,WC2))              
											xlabel('Distance (km)','fontsize',20)
											ylabel('Distance (km)','fontsize',20)
											viscircles([0 0],0,'Color','k','linewidth',1);
											viscircles([0 0],250,'Color','k','linewidth',1);
											viscircles([0 0],500,'Color','k','linewidth',1);
											viscircles([0 0],750,'Color','k','linewidth',1);
											viscircles([0 0],1000,'Color','k','linewidth',1);
											viscircles([0 0],1250,'Color','k','linewidth',1);                                
											viscircles([0 0],1500,'Color','k','linewidth',1);                                
											viscircles([0 0],1750,'Color','k','linewidth',1);                                
											viscircles([0 0],2000,'Color','k','linewidth',1);                                
											set(gca,'fontsize',20)
											set(gca,'plotboxaspectratio',[1 1 1])
											cl=colorbar;
											set(cl,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',20)
											adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
											if sum(adaa)>0
											else
												adaa((size(adaa,2)+1)/2)=0;
											end
											set(gca,'xtick',-2000:500:2000)
											set(gca,'ytick',-2000:500:2000)  
											set(cl,'YTicklabel',adaa) 
											set(gcf, 'InvertHardcopy', 'off')
											set(gcf,'Units','inches');
											screenposition = get(gcf,'Position');
											set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
											set(gcf, 'InvertHardcopy', 'off')                                    
											text(1,1.03,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
											text(1,1.065,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color','k','units','normalized');
											text(0.98,1.065,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
											text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ FHR: ',num2str((loop-1)*3),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
											text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
											ax=gca;
											box on
											set(ax, 'Layer', 'top')
											ax.LineWidth=1; 
											set(gca,'position',spPos)
											set(cl,'position',clPos)                
											set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
											f = getframe(hfig);
											filename=[identfields,'/DIFFSYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_',savename,'_PLANDIFF_',identexpshort{exp1},'-',identexpshort{exp2}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
											%print([identfields,'/',identn,'_',identinittimesunique(loop,:),'_FHR',num2str((loop-1)*3),'_',savename,'_PLANDIFF'],'-dpdf','-r200');
											close all  
										end
									end
								end
							end
							% Difference: AZAV
							if levs==1
								% (fhr)x(radius) for a single (plev) for each (cycle)
								for loop=identpresplan % 850,700,500,200 %1:size(var_f,3)
									set(0,'defaultfigurecolor',[1 1 1]) % figure background color
									hfig=figure;
									rds=0:0.125*111.11:pltcen*0.125*111.11;   
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
									ax1=subplot(3,4,[1:8]);
									hold on
									diffplt=squeeze((EXPvectnav(loop,:,:,exp1)-EXPvectnav(loop,:,:,exp2)));
									diffplt(diffplt<min(dcntr))=min(dcntr);                
									[c,h]=contourf(0:3:size(EXPvectnav,3)*3-1,rdsplt,diffplt,dcntr);
									hold on
									[c1,h1]=contour(0:3:size(EXPvectnav,3)*3-1,rdsplt,diffplt,dcntr,'k');
									caxis([dmin dmax])
									ylim([0 pltkm])
									xlim([0 identmaxfhr*3-3])
									colormap(custommap(20,WC2))
									cl=colorbar;
									xlabel('Forecast Hour','fontsize',22)
									ylabel('Radius (km)','fontsize',22)
									set(gca,'yTick',[0:100:pltkm],'fontsize',22)
									set(gca,'xtick',0:12:size(EXPvectnav,3)*3-1,'fontsize',22)
									set(gca,'fontsize',20)
									set(gca,'plotboxaspectratio',[1 1 1])
									set(cl,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',20)
									adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
									if sum(adaa)>0
									else
										adaa((size(adaa,2)+1)/2)=0;
									end
									set(cl,'YTicklabel',adaa) 
									set(gcf, 'InvertHardcopy', 'off')
									set(gcf,'Units','inches');
									screenposition = get(gcf,'Position');
									set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
									set(gcf, 'InvertHardcopy', 'off')
									text(1,1.03,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
									text(1,1.065,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color','k','units','normalized');
									text(0.98,1.065,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
									text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV: ',num2str(plev(loop)),' $\mid$ AZAV}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
									text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
									ax=gca;
									box on
									set(ax, 'Layer', 'top')
									ax.LineWidth=1;
									set(gca,'position',spPos)
									set(cl,'position',clPos)                
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
									f = getframe(hfig);
									filename=[identfields,'/DIFFSYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_PLEV',num2str(plev(loop)),'_',savename,'_3DRTAZAV_DIFF_',identexpshort{exp1},'-',identexpshort{exp2}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
									%print([identfields,'/',identn,'_',identinittimesunique(loop,:),'_FHR',num2str((loop1-1)*3),savename,'_3DRTAZAV_DIFF'],'-dpdf','-r200');
									close all
								end
								% (radius)x(plev) for a single (fhr) for each (cycle)
								for loop=1:size(EXPvectnav,3) %1:fhr
									if isnan(BT_lat(identloop,loop))==1
									else
										set(0,'defaultfigurecolor',[1 1 1]) % figure background color
										hfig=figure;
										rds=0:0.125*111.11:pltcen*0.125*111.11;   
										set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
										ax1=subplot(3,4,[1:8]);
										hold on
										diffplt=squeeze((EXPvectnav(:,:,loop,exp1)-EXPvectnav(:,:,loop,exp2)));
										diffplt(diffplt<min(dcntr))=min(dcntr);                
										[c,h]=contourf(rdsplt,plev,diffplt,dcntr);
										hold on
										[c1,h1]=contour(rdsplt,plev,diffplt,dcntr,'k');
										caxis([dmin dmax])
										axis ij
										ylim([0 1000])
										xlim([0 pltkm])
										colormap(custommap(20,WC2))
										xlabel('Radius (km)','fontsize',22)
										ylabel('Pressure (hPa)','fontsize',22)
										set(gca,'yTick',[0:100:1000],'fontsize',22)
										set(gca,'xtick',0:250:pltkm,'fontsize',22)
										cl=colorbar;
										set(gca,'fontsize',20)
										set(gca,'plotboxaspectratio',[1 1 1])
										set(cl,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',20)
										adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
										if sum(adaa)>0
										else
											adaa((size(adaa,2)+1)/2)=0;
										end
										set(cl,'YTicklabel',adaa) 
										set(gcf, 'InvertHardcopy', 'off')
										set(gcf,'Units','inches');
										screenposition = get(gcf,'Position');
										set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
										set(gcf, 'InvertHardcopy', 'off')                                
										text(1,1.03,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
										text(1,1.065,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color','k','units','normalized');
										text(0.98,1.065,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
										text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ FHR: ',num2str((loop-1)*3),' $\mid$ AZAV}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
										text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
										ax=gca;
										box on
										set(ax, 'Layer', 'top')
										ax.LineWidth=1;
										set(gca,'position',spPos)
										set(cl,'position',clPos)                
										set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
										f = getframe(hfig);
										filename=[identfields,'/DIFFSYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_',savename,'_RPAZAV_DIFF_',identexpshort{exp1},'-',identexpshort{exp2}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
										%print([identfields,'/',identn,'_',identinittimesunique(loop,:),'_FHR',num2str((loop1-1)*3),savename,'_RPAZAV_DIFF'],'-dpdf','-r200');
										close all
									end
								end
								% (plev)x(fhr) one plot
								for loop=1:size(EXPvectnavi,3)
									set(0,'defaultfigurecolor',[1 1 1]) % figure background color
									hfig=figure;
									rds=rdsplt;
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
									ax1=subplot(3,4,[1:8]);
									hold on
									diffplt=squeeze(EXPvectnavi(:,:,loop,exp1)-EXPvectnavi(:,:,loop,exp2));
									innerrad=innerradu(loop);
									outerrad=outerradu(loop);
									filerad=[num2str(round(rds(innerrad))),'_',num2str(round(rds(outerrad)))];    
									diffplt(diffplt<min(dcntr))=min(dcntr);                
									[c,h]=contourf(0:3:size(EXPvectnavi,2)*3-1,plev,diffplt,dcntr);
									hold on
									[c1,h1]=contour(0:3:size(EXPvectnavi,2)*3-1,plev,diffplt,dcntr,'k');
									caxis([dmin dmax])
									axis ij
									ylim([0 1000])
									xlim([0 identmaxfhr*3-3])
									colormap(custommap(20,WC2))
									xlabel('Forecast Hour','fontsize',22)
									ylabel('Pressure (hPa)','fontsize',22)
									set(gca,'yTick',[0:100:1000],'fontsize',22)
									set(gca,'xtick',0:12:size(EXPvectnavi,2)*3-1,'fontsize',22)
									cl=colorbar;
									set(gca,'fontsize',20)
									set(gca,'plotboxaspectratio',[1 1 1])
									set(cl,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',20)
									adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
									if sum(adaa)>0
									else
										adaa((size(adaa,2)+1)/2)=0;
									end
									set(cl,'YTicklabel',adaa) 
									set(gcf, 'InvertHardcopy', 'off')
									set(gcf,'Units','inches');
									screenposition = get(gcf,'Position');
									set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
									set(gcf, 'InvertHardcopy', 'off')                                
									text(1,1.03,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
									text(1,1.065,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color','k','units','normalized');
									text(0.98,1.065,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
									text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ $\mathbf{\overline{r}}$=',num2str(ceil(rds(innerradu(loop)))),'$\mathbf{-}$',num2str(ceil(rds(outerradu(loop)))), ' km}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
									text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
									ax=gca;
									box on
									set(ax, 'Layer', 'top')
									ax.LineWidth=1;
									set(gca,'position',spPos)
									set(cl,'position',clPos)                
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
									f = getframe(hfig);
									filename=[identfields,'/DIFFSYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_EVODIFF_',identexpshort{exp1},'-',identexpshort{exp2},'_',filerad,'_',savename];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
									%print([identfields,'/',identn,'_',identinittimesunique(loop,:),'_FHR',num2str((loop1-1)*3),savename,'_RPAZAV_DIFF'],'-dpdf','-r200');
									close all
								end                        
							elseif levs==0
								for loop=1
									set(0,'defaultfigurecolor',[1 1 1]) % figure background color
									hfig=figure;
									rds=0:0.125*111.11:pltcen*0.125*111.11; %0.125 res for hwrf synoptic grid  
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
									ax1=subplot(3,4,[1:8]);
									hold on
									diffplt=(EXPvectnav(:,:,exp1)-EXPvectnav(:,:,exp2));
									diffplt(diffplt<min(dcntr))=min(dcntr);                
									[c,h]=contourf(0:3:size(EXPvectnav,2)*3-1,rds,diffplt,dcntr);
									hold on
									[c1,h1]=contour(0:3:size(EXPvectnav,2)*3-1,rds,diffplt,dcntr,'k');
									caxis([dmin dmax])
									ylim([0 pltkm])
									xlim([0 identmaxfhr*3-3])
									colormap(custommap(20,WC2))
									cl=colorbar;
									xlabel('Forecast Hour','fontsize',22)
									ylabel('Radius (km)','fontsize',22)
									set(gca,'yTick',[0:100:pltkm],'fontsize',22)
									set(gca,'xtick',0:12:size(EXPvectnav,2)*3-1,'fontsize',22)
									set(gca,'fontsize',20)
									set(gca,'plotboxaspectratio',[1 1 1])
									set(cl,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',20)
									adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
									if sum(adaa)>0
									else
										adaa((size(adaa,2)+1)/2)=0;
									end
									set(cl,'YTicklabel',adaa) 
									set(gcf, 'InvertHardcopy', 'off')
									set(gcf,'Units','inches');
									screenposition = get(gcf,'Position');
									set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
									set(gcf, 'InvertHardcopy', 'off')                                
									text(1,1.03,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
									text(1,1.065,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color','k','units','normalized');
									text(0.98,1.065,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
									text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
									text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
									ax=gca;
									box on
									set(ax, 'Layer', 'top')
									ax.LineWidth=1;  
									set(gca,'position',spPos)
									set(cl,'position',clPos)                
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
									f = getframe(hfig);
									filename=[identfields,'/DIFFSYNOPTIC/',identn,'_',identinittimesunique(identloop,:),'_',savename,'_2DRTAZAV_DIFF_',identexpshort{exp1},'-',identexpshort{exp2}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
									%print([identfields,'/',identn,'_',identinittimesunique(loop,:),'_',savename,'_2DRTAZAV_DIFF'],'-dpdf','-r200');
									close all
								end
							end
						['COMPLETED DIFFERENCES - EXP: ', identexpshort{exp1},'-',identexpshort{exp2},' | CYCLE: ',num2str(identloop),' | VARIABLE: ',savename]
						end
						
						%% Scrubs .mat files for each experiment
						for i=1:size(identexp,1)
							%delete([identfields,'/',identexp{i},'/MATFILES/',identhwrf,'_synoptic_',identexp{i},'_',identinittimesunique(identloop,:),'_',identvariables{identvar},'.mat'])
						end 
					end					
               end
            end
            clearvars -except ident* skip* pltkm innerradu* outerradu* pltcen radbin pltpt nav spPos clPos
            disp(['ENDING VARIABLE: ',identvariables{identvar}])                        
        end 
    end
end

%% %%%%%%%%%%%%%%%%%%% %%
%% Storm Grid Graphics %%
%% %%%%%%%%%%%%%%%%%%% %%
for hwrfplots=1
    if identgraphicsstorm==1
       % Users can change this 
        pltkm=500; % how far out the storm-centered plot should go
        innerradu=[1,1,31]; % radav: 0 km, 0 km, 250 km
        outerradu=[10,31,61]; % radav: 80 km, 250 km, 500 km
        innerradu2=1; % radav 2D: start at 0 km
        outerradu2=151; % radav 2D: end at 250 km
        % End of user settings
        pltcen=306;% how many gridpoints from center .mat files
        radbin=0.015; % resolution of storm grid
        pltpt=ceil(pltkm/(radbin*111.11))+1; % to get to 500 km
        nav=nan(size(identinittimesunique,1),identmodelfhr);
        spPos=[0.11 0.13 0.75 0.75]; % arrange plots the same
        clPos=[0.88 0.13 0.04 0.75]; % arrange plots the same
        % All Graphics
        for identvar=identvar0
            disp(['STARTING VARIABLE: ',identvariables{identvar}])                        
            load([identout,'RESULTS/',identfold,identn,'/',identn,'_latlon.mat']);
            for identloop=identbatch %1:size(identinittimesunique,1)
                if sum(isnan(BT_lat(identloop,:)))==size(BT_lat,2)
                    disp('BT is all NaNs...skipping date!')
                else
                    %% Get data for each experiment
                    for identexploop=identvarexp0%1:size(identexp,1)
                        % This will loop over EXP experiments - same code for each!
                        identexp0=identexp{identexploop};
                        disp(['EXPERIMENT: ',identexp0])                        
                        if identvar==88
                            load([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_storm_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{74},'.mat']);
                            u=var_f;
                            load([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_storm_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{77},'.mat']);
                            v=var_f;
                            load([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_storm_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{16},'.mat']);
                            gph=var_f;
                        end
                        load([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_storm_',identexp0,'_',identinittimesunique(identloop,:),'_',identvariables{identvar}])
                        run customcolorbars
                        run customvariables % gets the colorbars and the variable bounds
                        if levs==1
                            %% Creates Plan-View plots for each init/fhr at each level: var_f=(lon)x(lat)x(plev)x(fhr)
                            if identplan==1
                                if isfile([identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((1-1)*3),'_PLEV',num2str(plev(7)),'_',savename,'_PLAN.png'])==0 || isfile([identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((1-1)*3),'_PLEV',num2str(plev(7)),'_',savename,'_PLAN.eps'])==0
                                for loop=1:size(var_f,4)
                                    if isnan(BT_lat(identloop,loop))==1 || (identvar>=80 && identvar <=85)
                                    else
                                        for loop1=identpresplan % 850,700,500,200 %1:size(var_f,3)
                                            tmpplt=var_f;
                                            tmpplt(tmpplt<cmin)=cmin;
                                            set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                            hfig=figure;
                                            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                            ax1=subplot(3,4,[1:8]);
                                            hold on                                                          
                                            [c,h]=contourf(varln_f(:,:,loop),varlt_f(:,:,loop),tmpplt(:,:,loop1,loop),cntr);
                                            hold on
                                            if identvar==88
                                                [c1,h1]=contour(varln_f(:,:,loop),varlt_f(:,:,loop),tmpplt(:,:,loop1,loop),cntr);
                                                windbarbm(varlt_f(:,:,loop),varln_f(:,:,loop),u(:,:,loop1,loop),v(:,:,loop1,loop),20,1,[.5 .5 .5])
                                                [g1,p1]=contour(varln_f(:,:,loop),varlt_f(:,:,loop),gph(:,:,loop1,loop),[0:2:2000],'w','linewidth',2); 
                                                clabel(g1,p1,[0:4:2000],'color','k','labelspacing',1000)
                                            else
                                                [c1,h1]=contour(varln_f(:,:,loop),varlt_f(:,:,loop),tmpplt(:,:,loop1,loop),cntr1,'k');
                                            end                                            
                                            caxis([cmin cmax])
                                            axis([varln_f(pltcen+1,pltcen+1,loop)-(pltkm/111.11) varln_f(pltcen+1,pltcen+1,loop)+(pltkm/111.11) varlt_f(pltcen+1,pltcen+1,loop)-(pltkm/111.11) varlt_f(pltcen+1,pltcen+1,loop)+(pltkm/111.11)])
                                            colormap(custommap(20,WC1))
                                            load coastlines
                                            plot(coastlon,coastlat,'k','linewidth',2);
                                            xlabel('Longitude','fontsize',20)
                                            ylabel('Latitude','fontsize',20)
                                            viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],0/111.11,'Color','k','linewidth',1);
                                            viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],100/111.11,'Color','k','linewidth',1);
                                            viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],200/111.11,'Color','k','linewidth',1);
                                            viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],300/111.11,'Color','k','linewidth',1);
                                            viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],400/111.11,'Color','k','linewidth',1);
                                            viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],500/111.11,'Color','k','linewidth',1);                                
                                            set(gca,'fontsize',20)
                                            set(gca,'plotboxaspectratio',[1 1 1])
                                            cl=colorbar;
                                            if identvar==88
                                                colormap(gca,custommap(28,WC1))
                                                set(cl,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',20)
                                                set(cl,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
						%text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');                                                
                                            else
                                                set(cl,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',20)
                                                adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                                if sum(adaa)>0
                                                else
                                                    adaa((size(adaa,2)+1)/2)=0;
                                                end
                                                set(cl,'YTicklabel',adaa) 
                                            end
                                            set(gcf, 'InvertHardcopy', 'off')
                                            set(gcf,'Units','inches');
                                            screenposition = get(gcf,'Position');
                                            set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                            set(gcf, 'InvertHardcopy', 'off')
                                            text(1,1.03,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
                                            text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ FHR: ',num2str((loop-1)*3),' $\mid$ PLEV: ',num2str(plev(loop1)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
                                            if identvar==88
                                                    text(0,1.065,['\textbf{',varname,' (',units,') \& GPH (dam) $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
                                                else
                                                    text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
                                            end
                                            ax=gca;
                                            box on
                                            set(ax, 'Layer', 'top')
                                            ax.LineWidth=1;  
                                            set(gca,'position',spPos)
                                            set(cl,'position',clPos)
                                            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                            f = getframe(hfig);
											filename=[identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_PLEV',num2str(plev(loop1)),'_',savename,'_PLAN'];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                            %print([identfields,'/',identexp,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_PLEV',num2str(plev(loop1)),'_',savename,'_PLAN'],'-dpdf','-r200');
                                            close all 
                                        end
                                    end
                                end
                                end
                            end
                            
                            %% Creates Azav at init time for each forecast hr: (levs)x(radius)x(fhr)
                            rds=0:radbin*111.11:pltcen*radbin*111.11;
                            vectRAW=nan(size(var_f,3),size(6:5:pltpt+5,2),size(var_f,4)); %preallocate
                            for t=1:size(var_f,4)
                                cnt=2;
                                for i=6:5:pltpt % 7:6:pltpt before
                                    inner_rad = rds(i-2)/radbin/111.11;
                                    outer_rad = rds(i+2)/radbin/111.11;
                                    ringa=pi*rds(i+2)*rds(i+2)-pi*rds(i-3)*rds(i-2);
                                    center = pltcen+1; 
                                    mask1_size = pltcen*2+1;
                                    [x,y] = meshgrid(1:mask1_size,1:mask1_size);
                                    distance = (x-center).^2+(y-center).^2;
                                    mask = distance<outer_rad^2 & distance>inner_rad^2;
                                    mask=repmat(mask,1,1,size(var_f,3));
                                    valtest=var_f(:,:,:,t);
                                    valtest(mask==0)=NaN;
                                    vectRAW(:,cnt,t)=squeeze(nanmean(nanmean(valtest,1),2));
                                    rdsplt(cnt)=rds(i);
                                    cnt=cnt+1;                                
                                end                        
                                inner_rad = rds(1); % accounts for the first bin
                                outer_rad = rds(3)/radbin/111.11; % 4 before
                                ringa=pi*rds(3)*rds(3)-pi*rds(1)*rds(1); % 4 before
                                center = pltcen+1; 
                                mask1_size = pltcen*2+1;
                                [x,y] = meshgrid(1:mask1_size,1:mask1_size);
                                distance = (x-center).^2+(y-center).^2;
                                mask = distance<outer_rad^2 & distance>inner_rad^2;
                                mask=repmat(mask,1,1,size(var_f,3));
                                valtest=var_f(:,:,:,t);
                                valtest(mask==0)=NaN;
                                vectRAW(:,1,t)=squeeze(nanmean(nanmean(valtest,1),2));
                                rdsplt(1)=rds(1);
                                t
                            end
                            
                            %% For 3D only, make a (radius)x(plev) plot for each fhr. This does not exist for the 1-level 2D plots.
                            if isfile([identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((1-1)*3),'_',savename,'_RPAZAV.png'])==0 || isfile([identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((1-1)*3),'_',savename,'_RPAZAV.eps'])==0
                                for loop=1:size(vectRAW,3)                                    
                                    if isnan(BT_lat(identloop,loop))==1
                                    else
                                        tmpplt=vectRAW;
                                        tmpplt(tmpplt<cmin)=cmin;
                                        set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                        hfig=figure;
                                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                        ax1=subplot(3,4,[1:8]);
                                        hold on
                                        [c,h]=contourf(rdsplt,plev,tmpplt(:,:,loop),cntr);
                                        hold on
                                        [c1,h1]=contour(rdsplt,plev,tmpplt(:,:,loop),cntr1,'k');
                                        axis ij
                                        caxis([cmin cmax])
                                        ylim([0 1000])
                                        xlim([0 pltkm])
                                        colormap(custommap(20,WC1))
                                        xlabel('Radius (km)','fontsize',22)
                                        ylabel('Pressure (hPa)','fontsize',22)
                                        set(gca,'yTick',[0:100:1000],'fontsize',22)
                                        set(gca,'xtick',0:100:pltkm,'fontsize',22)
                                        set(gca,'fontsize',20)
                                        set(gca,'plotboxaspectratio',[1 1 1])
                                        cl=colorbar;
                                        if identvar==88
                                                colormap(gca,custommap(28,WC1))
                                                set(cl,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',20)
                                                set(cl,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
						%text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                                %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');                                                
                                            else
                                                set(cl,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',20)
                                                adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                                if sum(adaa)>0
                                                else
                                                    adaa((size(adaa,2)+1)/2)=0;
                                                end
                                                set(cl,'YTicklabel',adaa) 
                                        end                                                                                   
                                        set(gcf, 'InvertHardcopy', 'off')
                                        set(gcf,'Units','inches');
                                        screenposition = get(gcf,'Position');
                                        set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                        set(gcf, 'InvertHardcopy', 'off')
                                        text(1,1.03,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
                                        text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ FHR: ',num2str((loop-1)*3),' $\mid$ AZAV}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
                                        text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
                                        ax=gca;
                                        box on
                                        set(ax, 'Layer', 'top')
                                        ax.LineWidth=1;       
                                        set(gca,'position',spPos)
                                        set(cl,'position',clPos)
                                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                        f = getframe(hfig);
										filename=[identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_',savename,'_RPAZAV'];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                        %print([identfields,'/',identexp,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_',savename,'_RPAZAV'],'-dpdf','-r200');
                                        close all
                                    end
                                end                                
                            end
                            
                            %% For 3D only, make a (radius)x(fhr) plot for each level. This is the default for the 1-level 2D plots.
                            if isfile([identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((1-1)*3),'_',savename,'_3DRTAZAV.png'])==0 || isfile([identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((1-1)*3),'_',savename,'_3DRTAZAV.eps'])==0
                                for loop=identpresplan
                                    tmpplt=vectRAW;
                                    tmpplt(tmpplt<cmin)=cmin;
                                    set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                    hfig=figure;
                                    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                    ax1=subplot(3,4,[1:8]);
                                    hold on
                                    [c,h]=contourf(0:3:size(vectRAW,3)*3-1,rdsplt,squeeze(tmpplt(loop,:,:)),cntr);
                                    hold on
                                    [c1,h1]=contour(0:3:size(vectRAW,3)*3-1,rdsplt,squeeze(tmpplt(loop,:,:)),cntr1,'k');
                                    caxis([cmin cmax])
                                    ylim([0 pltkm])
                                    xlim([0 identmaxfhr*3-3])
                                    colormap(custommap(20,WC1))
                                    ylabel('Radius (km)','fontsize',22)
                                    xlabel('Forecast Hour','fontsize',22)
                                    set(gca,'xtick',0:12:size(vectRAW,3)*3-1,'fontsize',22)
                                    set(gca,'ytick',0:100:pltkm,'fontsize',22)
                                    set(gca,'fontsize',20)
                                    set(gca,'plotboxaspectratio',[1 1 1])
                                    cl=colorbar;
                                    if identvar==88
                                        colormap(gca,custommap(28,WC1))
                                        set(cl,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',20)
                                        set(cl,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
					%text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');                                                
                                    else
                                        set(cl,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',20)
                                        adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                        if sum(adaa)>0
                                        else
                                            adaa((size(adaa,2)+1)/2)=0;
                                        end
                                        set(cl,'YTicklabel',adaa) 
                                    end                                            
                                    set(gcf, 'InvertHardcopy', 'off')
                                    set(gcf,'Units','inches');
                                    screenposition = get(gcf,'Position');
                                    set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                    set(gcf, 'InvertHardcopy', 'off')                                
                                    text(1,1.03,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
                                    text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV: ',num2str(plev(loop)),' $\mid$ AZAV}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
                                    text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                                                          
                                    ax=gca;
                                    box on
                                    set(ax, 'Layer', 'top')
                                    ax.LineWidth=1;       
                                    set(gca,'position',spPos)
                                    set(cl,'position',clPos)
                                    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                    f = getframe(hfig);
									filename=[identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_PLEV',num2str(plev(loop)),'_',savename,'_3DRTAZAV'];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                    %print([identfields,'/',identexp,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_',savename,'_3DRTAZAV'],'-dpdf','-r200');
                                    close all
                                end
                            end
                            
                            %% Create azav plot of plev vs. forecast hour for rad-averaged area (0-75, 0-250, 250-end)
                            rds=rdsplt;                            
                            for tmploop=1:size(innerradu,2)
                                innerrad=innerradu(tmploop);
                                outerrad=outerradu(tmploop);
                                filerad=[num2str(round(rds(innerrad))),'_',num2str(round(rds(outerrad)))];
                                % Radially Averaged from innerrad to outerrad km
                                TotalA=pi*(rds(outerrad)^2)-pi*(rds(innerrad)^2);  
                                for i=innerrad+1:outerrad
                                    RingA(i-innerrad)=pi*(rds(i))^2-pi*(rds(i-1))^2;
                                    vals_d(:,i-innerrad,:)=([vectRAW(:,i,:)+vectRAW(:,i-1,:)]/2);
                                end
                                for i=1:outerrad-innerrad
                                    Ddi(:,i,:)=vals_d(:,i,:).*RingA(i);
                                end
                                navi(:,:,tmploop)=squeeze(sum(Ddi,2)/TotalA); % (plev)x(fhr)
                                clear TotalA RingA vals_d Ddi
                                if isfile([identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_EVO_',filerad,'_',savename,'.png'])==0 || isfile([identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_EVO_',filerad,'_',savename,'.eps'])==0
                                    for loop=1
                                        tmpplt=navi(:,:,tmploop);
                                        tmpplt(tmpplt<cmin)=cmin;
                                        set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                        hfig=figure;
                                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                        ax1=subplot(3,4,[1:8]);
                                        hold on
                                        [c,h]=contourf(0:3:size(navi,2)*3-1,plev,tmpplt,cntr);
                                        hold on
                                        [c1,h1]=contour(0:3:size(navi,2)*3-1,plev,tmpplt,cntr1,'k');
                                        axis ij
                                        caxis([cmin cmax])
                                        ylim([0 1000])
                                        xlim([0 identmaxfhr*3-3])
                                        colormap(custommap(20,WC1))
                                        xlabel('Forecast Hour','fontsize',22)
                                        ylabel('Pressure (hPa)','fontsize',22)
                                        set(gca,'yTick',[0:100:1000],'fontsize',22)
                                        set(gca,'xtick',0:12:size(navi,2)*3-1,'fontsize',22)
                                        set(gca,'fontsize',20)
                                        set(gca,'plotboxaspectratio',[1 1 1])
                                        cl=colorbar;
                                        if identvar==88
                                            colormap(gca,custommap(28,WC1))
                                            set(cl,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',20)
                                            set(cl,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
					    %text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                            %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                            %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                            %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                            %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                            %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                            %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');                                                
                                        else
                                            set(cl,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',20)
                                            adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                            if sum(adaa)>0
                                            else
                                                adaa((size(adaa,2)+1)/2)=0;
                                            end
                                            set(cl,'YTicklabel',adaa) 
                                        end 
                                        set(gcf, 'InvertHardcopy', 'off')
                                        set(gcf,'Units','inches');
                                        screenposition = get(gcf,'Position');
                                        set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                        set(gcf, 'InvertHardcopy', 'off')    
                                        text(1,1.03,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
                                        text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ $\mathbf{\overline{r}}$=',num2str(ceil(rds(innerradu(tmploop)))),'$\mathbf{-}$',num2str(ceil(rds(outerradu(tmploop)))), ' km}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
                                        text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
                                        ax=gca;
                                        box on
                                        set(ax, 'Layer', 'top')
                                        ax.LineWidth=1; 
                                        set(gca,'position',spPos)
                                        set(cl,'position',clPos)                                
                                        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                        f = getframe(hfig);
										filename=[identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_EVO_',filerad,'_',savename];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                        %print([identfields,'/',identexp,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_EVO_',filerad,'_',savename],'-dpdf','-r200');
                                        close all
                                    end
                                end  
                            end
                            
                        elseif levs==0
                            %% Creates Plan-View plots for each init/fhr: var_f=(lon)x(lat)x(fhr)
                            if isfile([identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((1-1)*3),'_',savename,'_PLAN.png'])==0 || isfile([identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((1-1)*3),'_',savename,'_PLAN.eps'])==0
                                for loop=1:size(var_f,3) % (lon)x(lat)x(fhr)
                                    if isnan(BT_lat(identloop,loop))==1
                                    else
                                    tmpplt=var_f;
                                    tmpplt(tmpplt<cmin)=cmin;
                                    set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                    hfig=figure;
                                    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                    ax1=subplot(3,4,[1:8]);
                                    hold on                                                                
                                    [c,h]=contourf(varln_f(:,:,loop),varlt_f(:,:,loop),tmpplt(:,:,loop),cntr);
                                    hold on
                                    [c1,h1]=contour(varln_f(:,:,loop),varlt_f(:,:,loop),tmpplt(:,:,loop),cntr1,'k');
                                    caxis([cmin cmax])
                                    axis([varln_f(pltcen+1,pltcen+1,loop)-(pltkm/111.11) varln_f(pltcen+1,pltcen+1,loop)+(pltkm/111.11) varlt_f(pltcen+1,pltcen+1,loop)-(pltkm/111.11) varlt_f(pltcen+1,pltcen+1,loop)+(pltkm/111.11)])
                                    colormap(custommap(20,WC1))
                                    load coastlines
                                    plot(coastlon,coastlat,'k','linewidth',2);
                                    xlabel('Longitude','fontsize',20)
                                    ylabel('Latitude','fontsize',20)
                                    viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],0/111.11,'Color','k','linewidth',1);
                                    viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],100/111.11,'Color','k','linewidth',1);
                                    viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],200/111.11,'Color','k','linewidth',1);
                                    viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],300/111.11,'Color','k','linewidth',1);
                                    viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],400/111.11,'Color','k','linewidth',1);
                                    viscircles([varln_f(pltcen+1,pltcen+1,loop) varlt_f(pltcen+1,pltcen+1,loop)],500/111.11,'Color','k','linewidth',1);                                
                                    set(gca,'fontsize',20)
                                    set(gca,'plotboxaspectratio',[1 1 1])
                                    cl=colorbar;
                                    if identvar==88
                                        colormap(gca,custommap(28,WC1))
                                        set(cl,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',20)
                                        set(cl,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
					%text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');                                                
                                    else
                                        set(cl,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',20)
                                        adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                        if sum(adaa)>0
                                        else
                                            adaa((size(adaa,2)+1)/2)=0;
                                        end
                                        set(cl,'YTicklabel',adaa) 
                                    end
                                    set(gcf, 'InvertHardcopy', 'off')
                                    set(gcf,'Units','inches');
                                    screenposition = get(gcf,'Position');
                                    set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                    set(gcf, 'InvertHardcopy', 'off')
                                    text(1,1.03,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
                                    text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ FHR: ',num2str((loop-1)*3),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
                                    text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
                                    ax=gca;
                                    box on
                                    set(ax, 'Layer', 'top')
                                    ax.LineWidth=1;  
                                    set(gca,'position',spPos)
                                    set(cl,'position',clPos)
                                    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                    f = getframe(hfig);
									filename=[identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_',savename,'_PLAN'];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                    %print([identfields,'/',identexp,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_',savename,'_PLAN'],'-dpdf','-r200');
                                    close all        
                                    end
                                end
                            end
                            
                            %% Creates RT Azav for each init time: vectRAW=(radius)x(fhr)
                            rds=0:radbin*111.11:pltcen*radbin*111.11;  
                            vectRAW=nan(size(rds,2),size(var_f,3)); %preallocate (radius)x(fhr)
                            for t=1:size(var_f,3)
                                for i=2:size(rds,2)
                                    %% MASK: +/- 100 km about radius
                                    inner_rad = rds(i-1)/radbin/111.11;
                                    outer_rad = rds(i)/radbin/111.11;
                                    ringa=pi*rds(i)*rds(i)-pi*rds(i-1)*rds(i-1);
                                    center = pltcen+1; 
                                    mask1_size = pltcen*2+1;
                                    [x,y] = meshgrid(1:mask1_size,1:mask1_size);
                                    distance = (x-center).^2+(y-center).^2;
                                    mask = distance<=outer_rad^2 & distance>=inner_rad^2;
                                    valtest=var_f(:,:,t);
                                    valtest(mask==0)=NaN;
                                    vectRAW(i,t)=squeeze(nanmean(nanmean(valtest,1),2));
                                end
                                t
                            end    
                            vectRAW(1,:)=squeeze(var_f(center,center,:)); % (radius)x(fhr)
                            if isfile([identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_',savename,'_2DRTAZAV.png'])==0 || isfile([identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_',savename,'_2DRTAZAV.eps'])==0
                                for loop=1 % (radius)x(fhr) for the current (cycle)
                                    tmpplt=vectRAW;
                                    tmpplt(tmpplt<cmin)=cmin;
                                    set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                                    hfig=figure;
                                    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                                    ax1=subplot(3,4,[1:8]);
                                    hold on
                                    [c,h]=contourf(0:3:size(vectRAW,2)*3-1,rds,tmpplt,cntr);
                                    hold on
                                    [c1,h1]=contour(0:3:size(vectRAW,2)*3-1,rds,tmpplt,cntr1,'k');
                                    caxis([cmin cmax])
                                    ylim([0 pltkm])
                                    xlim([0 identmaxfhr*3-3])
                                    colormap(custommap(20,WC1))
                                    cl=colorbar;
                                    if identvar==88
                                        colormap(gca,custommap(28,WC1))
                                        set(cl,'ticks',[0,34,64,83,96,113,137]./1.94384,'fontsize',20)
                                        set(cl,'ticklabels',{'TD','TS','H1','H2','H3','H4','H5'})
					%text(1.21,-.015,['(TD)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.175,['(TS)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.34,['(C1)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.45,['(C2)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.52,['(C3)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.615,['(C4)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');
                                        %text(1.21,.75,['(C5)'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',12,'color','k','units','normalized');                                                
                                    else
                                        set(cl,'YTick',cmin:cntr1(2)-cntr1(1):cmax,'fontsize',20)
                                        adaa=cmin:cntr1(2)-cntr1(1):cmax;
                                        if sum(adaa)>0
                                        else
                                            adaa((size(adaa,2)+1)/2)=0;
                                        end
                                        set(cl,'YTicklabel',adaa) 
                                    end
                                    xlabel('Forecast Hour','fontsize',22)
                                    ylabel('Radius (km)','fontsize',22)
                                    set(gca,'yTick',[0:100:pltkm],'fontsize',22)
                                    set(gca,'xtick',0:12:size(vectRAW,2)*3-1,'fontsize',22)
                                    set(gca,'fontsize',20)
                                    set(gca,'plotboxaspectratio',[1 1 1])                                    
                                    set(gcf, 'InvertHardcopy', 'off')
                                    set(gcf,'Units','inches');
                                    screenposition = get(gcf,'Position');
                                    set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                                    set(gcf, 'InvertHardcopy', 'off')                                    
                                    text(1,1.03,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
                                    text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
                                    text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                                                          
                                    ax=gca;
                                    box on
                                    set(ax, 'Layer', 'top')
                                    ax.LineWidth=1;    
                                    set(gca,'position',spPos)
                                    set(cl,'position',clPos)
                                    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                                    f = getframe(hfig);
									filename=[identfields,'/',identexp0,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_',savename,'_2DRTAZAV'];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                                    %print([identfields,'/',identexp,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_',savename,'_2DRTAZAV'],'-dpdf','-r200');
                                    close all
                                end
                            end
                                
                        end
                        
                        %% Assign to EXP
                        if identexploop>1
				if levs==1
					load([identout,'RESULTS/',identfold,identn,'/',identn,'_STORM_',identinittimesunique(identloop,:),'_',savename,'.mat']);
				elseif levs==0
					load([identout,'RESULTS/',identfold,identn,'/',identn,'_STORM_',identinittimesunique(identloop,:),'_',savename,'.mat']);
				end
			end
			if levs==1
                            EXPplan(:,:,:,:,identexploop)=var_f;
                            EXPvectnav(:,:,:,identexploop)=vectRAW;
                            EXPvectnavi(:,:,:,identexploop)=navi;
			    save([identout,'RESULTS/',identfold,identn,'/',identn,'_STORM_',identinittimesunique(identloop,:),'_',savename,'.mat'],'EXPplan','EXPvectnav','EXPvectnavi','-v7.3');
                        elseif levs==0
                            EXPplan(:,:,:,identexploop)=var_f;
                            EXPvectnav(:,:,identexploop)=vectRAW;      
			    save([identout,'RESULTS/',identfold,identn,'/',identn,'_STORM_',identinittimesunique(identloop,:),'_',savename,'.mat'],'EXPplan','EXPvectnav','-v7.3');
                        end    
			['COMPLETED - EXP: ', identexpshort{identexploop},' | CYCLE: ',num2str(identloop),' | VARIABLE: ',savename]
                    end                   
                    
                    if identvarexp0==size(identexp,1) % if it's the last experiment, that means all needed data has been saved and generated from above!					
						if strcmp(identdiff,'all')==1
							identdiff=nchoosek(1:size(identexp,1),2);
						end
						
						%% Differences 
						for df=1:size(identdiff,1)
							% Set Experiments
							exp1=identdiff(df,1);
							exp2=identdiff(df,2);
							% Difference: PLAN
							if levs==1
								if identplan==1
									for loop=1:size(var_f,4) 
										if isnan(BT_lat(identloop,loop))==1
										else
											for loop1=identpresplan 
												set(0,'defaultfigurecolor',[1 1 1]) % figure background color
												hfig=figure;
												rds1=0:0.015*111.11:pltcen*0.015*111.11; %0.125 res for hwrf synoptic grid  
												rds2=sort(rds1*-1);
												rds=[rds2 rds1(2:end)]';
												set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
												ax1=subplot(3,4,[1:8]);
												hold on                     
												diffplt=fliplr(EXPplan(:,:,loop1,loop,exp1)-EXPplan(:,:,loop1,loop,exp2))';
												diffplt(diffplt<min(dcntr))=min(dcntr);
												[c,h]=contourf(rds,rds,diffplt,dcntr);
												hold on
												[c1,h1]=contour(rds,rds,diffplt,dcntr);
												caxis([dmin dmax])
												axis([-pltkm pltkm -pltkm pltkm])
												colormap(custommap(20,WC2))              
												xlabel('Distance (km)','fontsize',20)
												ylabel('Distance (km)','fontsize',20)
												viscircles([0 0],0,'Color','k','linewidth',1);
												viscircles([0 0],100,'Color','k','linewidth',1);
												viscircles([0 0],200,'Color','k','linewidth',1);
												viscircles([0 0],300,'Color','k','linewidth',1);
												viscircles([0 0],400,'Color','k','linewidth',1);
												viscircles([0 0],500,'Color','k','linewidth',1);                                
												set(gca,'fontsize',20)
												set(gca,'plotboxaspectratio',[1 1 1])
												cl=colorbar;
												set(cl,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',20)
												adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
												if sum(adaa)>0
												else
													adaa((size(adaa,2)+1)/2)=0;
												end
												set(gca,'xtick',-500:250:500)
												set(gca,'ytick',-500:250:500)  
												set(cl,'YTicklabel',adaa) 
												set(gcf, 'InvertHardcopy', 'off')
												set(gcf,'Units','inches');
												screenposition = get(gcf,'Position');
												set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
												set(gcf, 'InvertHardcopy', 'off')
												text(1,1.03,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
												text(1,1.065,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color','k','units','normalized');
												text(0.98,1.065,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
												text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ FHR: ',num2str((loop-1)*3),' $\mid$ PLEV: ',num2str(plev(loop1)),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
												text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
												ax=gca;
												box on
												set(ax, 'Layer', 'top')
												ax.LineWidth=1; 
												set(gca,'position',spPos)
												set(cl,'position',clPos)                
												set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
												f = getframe(hfig);
												filename=[identfields,'/DIFFSTORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_PLEV',num2str(plev(loop1)),'_',savename,'_PLANDIFF_',identexpshort{exp1},'-',identexpshort{exp2}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
												%print([identfields,'/',identn,'_',identinittimesunique(loop,:),'_FHR',num2str((loop-1)*3),'_PLEV',num2str(plev(loop1)),'_',savename,'_PLANDIFF'],'-dpdf','-r200');
												close all
											end
										end
									end
								end    
							elseif levs==0
								if identplan==1
									for loop=1:size(var_f,3) % by fhr
										if isnan(BT_lat(identloop,loop))==1
										else
											set(0,'defaultfigurecolor',[1 1 1]) % figure background color
											hfig=figure;
											rds1=0:0.015*111.11:pltcen*0.015*111.11; %0.125 res for hwrf synoptic grid  
											rds2=sort(rds1*-1);
											rds=[rds2 rds1(2:end)]';
											set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
											ax1=subplot(3,4,[1:8]);
											hold on                     
											diffplt=fliplr(EXPplan(:,:,loop,exp1)-EXPplan(:,:,loop,exp2))';
											diffplt(diffplt<min(dcntr))=min(dcntr);
											[c,h]=contourf(rds,rds,diffplt,dcntr);
											hold on
											[c1,h1]=contour(rds,rds,diffplt,dcntr);
											caxis([dmin dmax])
											axis([-pltkm pltkm -pltkm pltkm])
											colormap(custommap(20,WC2))              
											xlabel('Distance (km)','fontsize',20)
											ylabel('Distance (km)','fontsize',20)
											viscircles([0 0],0,'Color','k','linewidth',1);
											viscircles([0 0],100,'Color','k','linewidth',1);
											viscircles([0 0],200,'Color','k','linewidth',1);
											viscircles([0 0],300,'Color','k','linewidth',1);
											viscircles([0 0],400,'Color','k','linewidth',1);
											viscircles([0 0],500,'Color','k','linewidth',1);                                
											set(gca,'fontsize',20)
											set(gca,'plotboxaspectratio',[1 1 1])
											cl=colorbar;
											set(cl,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',20)
											adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
											if sum(adaa)>0
											else
												adaa((size(adaa,2)+1)/2)=0;
											end
											set(gca,'xtick',-500:250:500)
											set(gca,'ytick',-500:250:500)  
											set(cl,'YTicklabel',adaa) 
											set(gcf, 'InvertHardcopy', 'off')
											set(gcf,'Units','inches');
											screenposition = get(gcf,'Position');
											set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
											set(gcf, 'InvertHardcopy', 'off')                                    
											text(1,1.03,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
											text(1,1.065,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color','k','units','normalized');
											text(0.98,1.065,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
											text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ FHR: ',num2str((loop-1)*3),'}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
											text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
											ax=gca;
											box on
											set(ax, 'Layer', 'top')
											ax.LineWidth=1; 
											set(gca,'position',spPos)
											set(cl,'position',clPos)                
											set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
											f = getframe(hfig);
											filename=[identfields,'/DIFFSTORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_',savename,'_PLANDIFF_',identexpshort{exp1},'-',identexpshort{exp2}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
											%print([identfields,'/',identn,'_',identinittimesunique(loop,:),'_FHR',num2str((loop-1)*3),'_',savename,'_PLANDIFF'],'-dpdf','-r200');
											close all  
										end
									end
								end
							end
							% Difference: AZAV
							if levs==1
								% (fhr)x(radius) for a single (plev) for each (cycle)
								for loop=identpresplan
									set(0,'defaultfigurecolor',[1 1 1]) % figure background color
									hfig=figure;
									rds=0:0.015*111.11:pltcen*0.015*111.11;   
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
									ax1=subplot(3,4,[1:8]);
									hold on
									diffplt=squeeze((EXPvectnav(loop,:,:,exp1)-EXPvectnav(loop,:,:,exp2)));
									diffplt(diffplt<min(dcntr))=min(dcntr);                
									[c,h]=contourf(0:3:size(EXPvectnav,3)*3-1,rdsplt,diffplt,dcntr);
									hold on
									[c1,h1]=contour(0:3:size(EXPvectnav,3)*3-1,rdsplt,diffplt,dcntr,'k');
									caxis([dmin dmax])
									ylim([0 pltkm])
									xlim([0 identmaxfhr*3-3])
									colormap(custommap(20,WC2))
									cl=colorbar;
									xlabel('Forecast Hour','fontsize',22)
									ylabel('Radius (km)','fontsize',22)
									set(gca,'yTick',[0:100:pltkm],'fontsize',22)
									set(gca,'xtick',0:12:size(EXPvectnav,3)*3-1,'fontsize',22)
									set(gca,'fontsize',20)
									set(gca,'plotboxaspectratio',[1 1 1])
									set(cl,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',20)
									adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
									if sum(adaa)>0
									else
										adaa((size(adaa,2)+1)/2)=0;
									end
									set(cl,'YTicklabel',adaa) 
									set(gcf, 'InvertHardcopy', 'off')
									set(gcf,'Units','inches');
									screenposition = get(gcf,'Position');
									set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
									set(gcf, 'InvertHardcopy', 'off')
									text(1,1.03,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
									text(1,1.065,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color','k','units','normalized');
									text(0.98,1.065,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
									text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ PLEV: ',num2str(plev(loop)),' $\mid$ AZAV}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
									text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
									ax=gca;
									box on
									set(ax, 'Layer', 'top')
									ax.LineWidth=1;
									set(gca,'position',spPos)
									set(cl,'position',clPos)                
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
									f = getframe(hfig);
									filename=[identfields,'/DIFFSTORM/',identn,'_',identinittimesunique(identloop,:),'_PLEV',num2str(plev(loop)),'_',savename,'_3DRTAZAV_DIFF_',identexpshort{exp1},'-',identexpshort{exp2}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
									%print([identfields,'/',identn,'_',identinittimesunique(loop,:),'_FHR',num2str((loop1-1)*3),savename,'_3DRTAZAV_DIFF'],'-dpdf','-r200');
									close all
								end
								% (radius)x(plev) for a single (fhr) for each (cycle)
								for loop=1:size(EXPvectnav,3) %1:fhr
									if isnan(BT_lat(identloop,loop))==1
									else
										set(0,'defaultfigurecolor',[1 1 1]) % figure background color
										hfig=figure;
										rds=0:0.015*111.11:pltcen*0.015*111.11;   
										set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
										ax1=subplot(3,4,[1:8]);
										hold on
										diffplt=squeeze((EXPvectnav(:,:,loop,exp1)-EXPvectnav(:,:,loop,exp2)));
										diffplt(diffplt<min(dcntr))=min(dcntr);                
										[c,h]=contourf(rdsplt,plev,diffplt,dcntr);
										hold on
										[c1,h1]=contour(rdsplt,plev,diffplt,dcntr,'k');
										caxis([dmin dmax])
										axis ij
										ylim([0 1000])
										xlim([0 pltkm])
										colormap(custommap(20,WC2))
										xlabel('Radius (km)','fontsize',22)
										ylabel('Pressure (hPa)','fontsize',22)
										set(gca,'yTick',[0:100:1000],'fontsize',22)
										set(gca,'xtick',0:100:pltkm,'fontsize',22)
										cl=colorbar;
										set(gca,'fontsize',20)
										set(gca,'plotboxaspectratio',[1 1 1])
										set(cl,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',20)
										adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
										if sum(adaa)>0
										else
											adaa((size(adaa,2)+1)/2)=0;
										end
										set(cl,'YTicklabel',adaa) 
										set(gcf, 'InvertHardcopy', 'off')
										set(gcf,'Units','inches');
										screenposition = get(gcf,'Position');
										set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
										set(gcf, 'InvertHardcopy', 'off')                                
										text(1,1.03,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
										text(1,1.065,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color','k','units','normalized');
										text(0.98,1.065,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
										text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ FHR: ',num2str((loop-1)*3),' $\mid$ AZAV}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
										text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
										ax=gca;
										box on
										set(ax, 'Layer', 'top')
										ax.LineWidth=1;
										set(gca,'position',spPos)
										set(cl,'position',clPos)                
										set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
										f = getframe(hfig);
										filename=[identfields,'/DIFFSTORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_',savename,'_RPAZAV_DIFF_',identexpshort{exp1},'-',identexpshort{exp2}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
										%print([identfields,'/',identn,'_',identinittimesunique(loop,:),'_FHR',num2str((loop1-1)*3),savename,'_RPAZAV_DIFF'],'-dpdf','-r200');
										close all
									end
								end
								% (plev)x(fhr) one plot
								for loop=1:size(EXPvectnavi,3)
									set(0,'defaultfigurecolor',[1 1 1]) % figure background color
									hfig=figure;
									rds=rdsplt;
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
									ax1=subplot(3,4,[1:8]);
									hold on
									diffplt=squeeze(EXPvectnavi(:,:,loop,exp1)-EXPvectnavi(:,:,loop,exp2));
									innerrad=innerradu(loop);
									outerrad=outerradu(loop);
									filerad=[num2str(round(rds(innerrad))),'_',num2str(round(rds(outerrad)))];    
									diffplt(diffplt<min(dcntr))=min(dcntr);                
									[c,h]=contourf(0:3:size(EXPvectnavi,2)*3-1,plev,diffplt,dcntr);
									hold on
									[c1,h1]=contour(0:3:size(EXPvectnavi,2)*3-1,plev,diffplt,dcntr,'k');
									caxis([dmin dmax])
									axis ij
									ylim([0 1000])
									xlim([0 identmaxfhr*3-3])
									colormap(custommap(20,WC2))
									xlabel('Forecast Hour','fontsize',22)
									ylabel('Pressure (hPa)','fontsize',22)
									set(gca,'yTick',[0:100:1000],'fontsize',22)
									set(gca,'xtick',0:12:size(EXPvectnavi,2)*3-1,'fontsize',22)
									cl=colorbar;
									set(gca,'fontsize',20)
									set(gca,'plotboxaspectratio',[1 1 1])
									set(cl,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',20)
									adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
									if sum(adaa)>0
									else
										adaa((size(adaa,2)+1)/2)=0;
									end
									set(cl,'YTicklabel',adaa) 
									set(gcf, 'InvertHardcopy', 'off')
									set(gcf,'Units','inches');
									screenposition = get(gcf,'Position');
									set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
									set(gcf, 'InvertHardcopy', 'off')                                
									text(1,1.03,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
									text(1,1.065,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color','k','units','normalized');
									text(0.98,1.065,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
									text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ $\mathbf{\overline{r}}$=',num2str(ceil(rds(innerradu(loop)))),'$\mathbf{-}$',num2str(ceil(rds(outerradu(loop)))), ' km}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
									text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
									ax=gca;
									box on
									set(ax, 'Layer', 'top')
									ax.LineWidth=1;
									set(gca,'position',spPos)
									set(cl,'position',clPos)                
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
									f = getframe(hfig);
									filename=[identfields,'/DIFFSTORM/',identn,'_',identinittimesunique(identloop,:),'_EVODIFF_',identexpshort{exp1},'-',identexpshort{exp2},'_',filerad,'_',savename];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
									%print([identfields,'/',identn,'_',identinittimesunique(loop,:),'_FHR',num2str((loop1-1)*3),savename,'_RPAZAV_DIFF'],'-dpdf','-r200');
									close all
								end                        
							elseif levs==0
								for loop=1
									set(0,'defaultfigurecolor',[1 1 1]) % figure background color
									hfig=figure;
									rds=0:0.015*111.11:pltcen*0.015*111.11; %0.125 res for hwrf synoptic grid  
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
									ax1=subplot(3,4,[1:8]);
									hold on
									diffplt=(EXPvectnav(:,:,exp1)-EXPvectnav(:,:,exp2));
									diffplt(diffplt<min(dcntr))=min(dcntr);                
									[c,h]=contourf(0:3:size(EXPvectnav,2)*3-1,rds,diffplt,dcntr);
									hold on
									[c1,h1]=contour(0:3:size(EXPvectnav,2)*3-1,rds,diffplt,dcntr,'k');
									caxis([dmin dmax])
									ylim([0 pltkm])
									xlim([0 identmaxfhr*3-3])
									colormap(custommap(20,WC2))
									cl=colorbar;
									xlabel('Forecast Hour','fontsize',22)
									ylabel('Radius (km)','fontsize',22)
									set(gca,'yTick',[0:100:pltkm],'fontsize',22)
									set(gca,'xtick',0:12:size(EXPvectnav,2)*3-1,'fontsize',22)
									set(gca,'fontsize',20)
									set(gca,'plotboxaspectratio',[1 1 1])
									set(cl,'YTick',dmin:dcntr1(2)-dcntr1(1):dmax,'fontsize',20)
									adaa=dmin:dcntr1(2)-dcntr1(1):dmax;
									if sum(adaa)>0
									else
										adaa((size(adaa,2)+1)/2)=0;
									end
									set(cl,'YTicklabel',adaa) 
									set(gcf, 'InvertHardcopy', 'off')
									set(gcf,'Units','inches');
									screenposition = get(gcf,'Position');
									set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
									set(gcf, 'InvertHardcopy', 'off')                                
									text(1,1.03,['\textbf{',identexpshort{exp2},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp2,:),'units','normalized');
									text(1,1.065,['\textbf{-}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color','k','units','normalized');
									text(0.98,1.065,['\textbf{',identexpshort{exp1},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(exp1,:),'units','normalized');
									text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
									text(0,1.065,['\textbf{',varname,' (',units,') $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
									ax=gca;
									box on
									set(ax, 'Layer', 'top')
									ax.LineWidth=1;  
									set(gca,'position',spPos)
									set(cl,'position',clPos)                
									set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
									f = getframe(hfig);
									filename=[identfields,'/DIFFSTORM/',identn,'_',identinittimesunique(identloop,:),'_',savename,'_2DRTAZAV_DIFF_',identexpshort{exp1},'-',identexpshort{exp2}];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
									%print([identfields,'/',identn,'_',identinittimesunique(loop,:),'_',savename,'_2DRTAZAV_DIFF'],'-dpdf','-r200');
									close all
								end
							end
						['COMPLETED DIFFERENCES - EXP: ', identexpshort{exp1},'-',identexpshort{exp2},' | CYCLE: ',num2str(identloop),' | VARIABLE: ',savename]
						end
						
						%% Scrubs .mat files for each experiment
						for i=1:size(identexp,1)
						
							%delete([identfields,'/',identexp{i},'/MATFILES/',identhwrf,'_storm_',identexp{i},'_',identinittimesunique(identloop,:),'_',identvariables{identvar},'.mat'])
						end 
					end					
                end
            end
            clearvars -except ident* skip* pltkm innerradu* outerradu* pltcen radbin pltpt nav spPos clPos
            disp(['ENDING VARIABLE: ',identvariables{identvar}])                        
        end
    end
end             
        
%% %%%%%%%%%%%%%% %%
%% Shear Graphics %%
%% %%%%%%%%%%%%%% %%
% SHIPS: magnitude difference between 850- and 200-hPa wind vectors, 
% averaged over 200Ã¢â‚¬â€œ800-km radius from vortex center (DeMaria et al. 2005)
for shear=1
    if identshear==1
        load([identout,'RESULTS/',identfold,identn,'/',identn,'_latlon.mat']);
        for identloop=identbatch
            if isnan(BT_lat(identloop,1))==1
                disp('BT has a NaN...skipping date!')
            else                                
                for identexploop=1:size(identexp,1)
                    identexp0=identexp{identexploop};
                    clear tmp
                    if isfile([identfields,'/',identexp0,'/FIGURES/',identn,'_',identinittimesunique(identloop,:),'_VWS.png'])==0 || isfile([identfields,'/',identexp0,'/FIGURES/',identn,'_',identinittimesunique(identloop,:),'_VWS.eps'])==0
                    % This will loop over EXP experiments - same code for each!
                    tmp(1)=isfile([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_synoptic_',identexp0,'_',identinittimesunique(identloop,:),'_u-component_of_wind_isobaric.mat'])==1;
                    tmp(2)=isfile([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_synoptic_',identexp0,'_',identinittimesunique(identloop,:),'_v-component_of_wind_isobaric.mat'])==1;
                        if sum(tmp)==2
                            spPos=[0.11 0.13 0.75 0.75]; % arrange plots the same
                            load([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_synoptic_',identexp0,'_',identinittimesunique(identloop,:),'_u-component_of_wind_isobaric.mat'])
                            u850 = squeeze(var_f(:,:,7,:));
                            u200 = squeeze(var_f(:,:,33,:));                 
                            load([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_synoptic_',identexp0,'_',identinittimesunique(identloop,:),'_v-component_of_wind_isobaric.mat'])
                            v850 = squeeze(var_f(:,:,7,:));
                            v200 = squeeze(var_f(:,:,33,:)); 
                            pltkm=2000; % how far out the storm-centered plot should go
                            pltcen=150;% how many gridpoints from center .mat files
                            radbin=0.125; % resolution of synoptic grid
                            pltpt=ceil(pltkm/(radbin*111.11))+1; % to get to 2000 km
                            rds=0:radbin*111.11:pltcen*radbin*111.11;
                            inner_rad = rds(15)/radbin/111.11;
                            outer_rad = rds(59)/radbin/111.11;
                            ringa=pi*rds(59)*rds(59)-pi*rds(15)*rds(15);
                            center = pltcen+1; 
                            mask1_size = pltcen*2+1;
                            [x,y] = meshgrid(1:mask1_size,1:mask1_size);
                            distance = (x-center).^2+(y-center).^2;
                            mask = distance<outer_rad^2 & distance>inner_rad^2;
                            mask=repmat(mask,1,1,size(u850,3));
                            u850(mask==0)=NaN;
                            v850(mask==0)=NaN;
                            u200(mask==0)=NaN;
                            v200(mask==0)=NaN;
                            u850=squeeze(nanmean(nanmean(u850,1),2));
                            v850=squeeze(nanmean(nanmean(v850,1),2));
                            u200=squeeze(nanmean(nanmean(u200,1),2));
                            v200=squeeze(nanmean(nanmean(v200,1),2));
                            ushear=u200-u850;
                            vshear=v200-v850;
                            shearmag=sqrt(ushear.^2 + vshear.^2);
                            sheardir=atan2(vshear,ushear).*180/pi;  

                            set(0,'defaultfigurecolor',[1 1 1]) % figure background color
                            hfig=figure;
                            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]); % maximize figure window
                            axis([-1 23 -5 80])
                            trkerr_sz=size(shearmag,1);
                            if mod(trkerr_sz*3,skiphr)==0  % xrange to nearest tickmark
                                if mod(trkerr_sz*3,12)==0
                                    xlim([-1 ((trkerr_sz*3))/skiphr+1])
                                    xlimend=((trkerr_sz*3))/skiphr+1;
                                else
                                    xlim([-1 ((trkerr_sz*3)+(12-mod(trkerr_sz*3,12)))/skiphr+1])
                                    xlimend=((trkerr_sz*3)+(12-mod(trkerr_sz*3,12)))/skiphr+1;
                                end
                            else
                                if mod(trkerr_sz*3-3,12)==0
                                    xlim([-1 ((trkerr_sz*3)-3)/skiphr+1])
                                    xlimend=((trkerr_sz*3)-3)/skiphr+1;
                                else
                                    xlim([-1 ((trkerr_sz*3)-3+(12-mod(trkerr_sz*3-3,12)))/skiphr+1]) 
                                    xlimend=((trkerr_sz*3)-3+(12-mod(trkerr_sz*3-3,12)))/skiphr+1;
                                end
                            end
                            xlim([-1 xlimend*2+1]);
                            list=1:size(1:43,2);
                            shearmg=shearmag(1:end);
                            hold on
                            p = plot(list,shearmg,'-','color',identexpcolors(identexploop,:),'linewidth',2);
                            plot(list(1:skip:end),shearmg(1:skip:end),'.','color',identexpcolors(identexploop,:),'markersize',12);                        
                            for k = 1:skip:size(list,2)
                                % get the data coordinates:
                                theta = sheardir(k)*pi/180;              % Angle of arrow, from x-axis
                                L = 2;                          % Length of arrow
                                x0 = [list(k)];
                                y0 = [shearmg(k)];
                                xEnd = x0+L*cos(theta);          % X coordinate of arrow end
                                yEnd = y0+L*sin(theta);          % Y coordinate of arrow end   
                                x=[x0 xEnd];
                                y=[y0 yEnd];  
                                % plot the arrow
                                arrow3([x0 y0], [xEnd yEnd],'k')                                                          
                            end
                            arrow3('update',[1,.3,1])
                            axis([-1 xlimend*2+1 -5 80])
                            box on            
                            set(gca,'xtick',1:4:50)
                            set(gca,'ytick',0:10:100)
                            set(gca,'xticklabel',0:skiphr*skiptick:identmaxfhr*3)
                            grid on
                            set(gca,'gridcolor','k','gridalpha',.4,'ygrid','off')
                            set(gca,'fontsize',20)      
                            hold off
                            box on
                            ylabel('200-850 hPa Magnitude (m/s)','fontsize',22)
                            xlabel('Forecast Hour','fontsize',22)
                            set(gca,'fontsize',20)
                            set(gcf, 'InvertHardcopy', 'off')
                            set(gcf,'Units','inches');
                            screenposition = get(gcf,'Position');
                            set(gcf,'PaperPosition',[0 0 screenposition(4) screenposition(4)],'PaperSize',[screenposition(4) screenposition(4)]);
                            set(gcf, 'InvertHardcopy', 'off') 
                            text(1,1.03,['\textbf{',identexpshort{identexploop},'}'],'HorizontalAlignment','right','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','color',identexpcolors(identexploop,:),'units','normalized');
                            text(0,1.03,['\textbf{INIT: ',identinittimesunique(identloop,: ),' $\mid$ AZAV $\mid$ $\mathbf{\overline{r}}$=200','$\mathbf{-}$800 km}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')
                            text(0,1.065,['\textbf{Vertical Wind Shear (m/s) $\mid$ ',upper(identhwrf(end-2:end)),' (',identn(1:end-2),')}'],'HorizontalAlignment','left','VerticalAlignment','top','fontsize',16,'fontweight','bold','interpreter','latex','units','normalized')                                            
                            ax=gca;
                            box on
                            set(ax, 'Layer', 'top')
                            ax.LineWidth=1;  
                            set(gca,'Color',[.9 .9 .9])
                            set(gca,'position',spPos)
                            set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, .72, 0.96]); % maximize figure window
                            f = getframe(hfig);
							filename=[identfields,'/',identexp0,'/FIGURES/',identn,'_',identinittimesunique(identloop,:),'_VWS'];if identeps==1;set(gcf,'PaperPositionMode','auto');print([filename,'.eps'],'-depsc','-r0');else;imwrite(f.cdata,[filename,'.png'],'png');end;					
                            %print([identfields,'/',identexp,'/FIGURES/STORM/',identn,'_',identinittimesunique(identloop,:),'_FHR',num2str((loop-1)*3),'_',savename,'_3DRTAZAV'],'-dpdf','-r200');
                            close all 

                            % FIND DIFFERENT PLACE Scrubs .mat files for each experiment                        
                            %delete([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_synoptic_',identexp0,'_',identinittimesunique(identloop,:),'_u-component_of_wind_isobaric.mat'])
                            %delete([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_synoptic_',identexp0,'_',identinittimesunique(identloop,:),'_v-component_of_wind_isobaric.mat'])
                            %delete([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_storm_',identexp0,'_',identinittimesunique(identloop,:),'_u-component_of_wind_isobaric.mat'])
                            %delete([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_storm_',identexp0,'_',identinittimesunique(identloop,:),'_v-component_of_wind_isobaric.mat'])

                        else
                            disp(['MISSING FILES: CANNOT CREATE SHEAR GRAPHIC FOR INIT:',identinittimesunique(identloop,:)])
                        end
                    else
                        disp('VWS GRAPHIC ALREADY EXISTS...SKIPPING')
                    end
                end            
            end
        end 
    end
end

%% %%%%%%%% %%
%% Clean-Up %%
%% %%%%%%%% %%
% Remove all .mat files
for cleanup=1
    if identsynopticclean==1
        for identloop=identbatch 
            for identexploop=1:size(identexp,1)
                identexp0=identexp{identexploop};
                delete([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_synoptic_',identexp0,'*'])
                delete([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_synoptic_',identexp0,'*'])
		delete([identout,'RESULTS/',identfold,identn,'/',identn,'_SYNOPTIC_','*','_','*','.mat'])
            end
        end 
    end
end
for cleanup=1
    if identstormclean==1
        for identloop=identbatch 
            for identexploop=1:size(identexp,1)
                identexp0=identexp{identexploop};
                delete([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_storm_',identexp0,'*'])
                delete([identfields,'/',identexp0,'/MATFILES/',identhwrf,'_storm_',identexp0,'*'])
		delete([identout,'RESULTS/',identfold,identn,'/',identn,'_STORM_','*','_','*','.mat'])
            end
        end 
    end
end
