%% Variable Bounds for Plotting
if strcmp(identvariables{identvar},'Absolute_vorticity_isobaric')==1
    units='10$^{-5}$ s$^{-1}$';
    varname='Absolute Vorticity';
    savename='ABSV';
    vara=-40;  % regular
    varb=40;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Cloud_ice_isobaric')==1
    units='kg m$^{-2}$';
    varname='Cloud Ice';
    savename='CICE';
    vara=0;  % regular
    varb=0.001;
    var1=0.0001; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},'Cloud_mixing_ratio_isobaric')==1
    units='kg kg$^{-1}$';
    varname='Cloud Mixing Ratio';
    savename='CLDWMR';
    vara=0;  % regular
    varb=0.01;
    var1=0.001; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},'Composite_reflectivity_entire_atmosphere')==1
    units='dB';
    varname='Composite Reflectivity';
    savename='REFC';
    vara=-25;  % regular
    varb=75;
    var1=20; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=6; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},'Convective_available_potential_energy_surface')==1
    units='J kg$^{-1}$';
    varname='CAPE (Surface)';
    savename='CAPE';
    vara=0;  % regular
    varb=5000;
    var1=500; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Convective_inhibition_surface')==1
    units='J kg$^{-1}$';
    varname='CIN (Surface)';
    savename='CIN';
    vara=-500;  % regular
    varb=0;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=1; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},['Convective_precipitation_surface_Accumulation'])==1
    units='kg m$^{-2}$';
    varname='Accum. Convective Precip. (Surface)';
    savename='ACPCP';
    vara=0;  % regular
    varb=10;
    var1=1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},'Dew-point_temperature_height_above_ground')==1
    units='K';
    varname='Dew-Point Temperature (2 m)';
    savename='TDP2M';
    vara=200;  % regular
    varb=300;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Dew-point_temperature_isobaric')==1
    units='K';
    varname='Dew-Point Temperature';
    savename='DPT';
    vara=200;  % regular
    varb=300;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Downward_Long-Wave_Radp_Flux_surface')==1
    units='W m$^{-2}$';
    varname='Downward LW Rad. Flux (Surface)';
    savename='DLWRF';
    vara=350;  % regular
    varb=500;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},['Downward_Long-Wave_Radp_Flux_surface_Average'])==1
    units='W m$^{-2}$';
    varname='Hr.-Av. Downward LW Rad. Flux (Surface)';
    savename='ADLWRF';
    vara=350;  % regular
    varb=500;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Downward_Short-Wave_Radiation_Flux_surface')==1
    units='W m$^{-2}$';
    varname='Downward SW Rad. Flux (Surface)';
    savename='DLWRF';
    vara=0;  % regular
    varb=500;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},['Downward_Short-Wave_Radiation_Flux_surface_Average'])==1
    units='W m$^{-2}$';
    varname='Hr.-Av. Downward SW Rad. Flux (Surface)';
    savename='ADSWRF';
    vara=0;  % regular
    varb=500;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Drag_Coefficient_height_above_ground')==1
    units='non-dim';
    varname='Drag Coefficient';
    savename='CD';
    vara=0;  % regular
    varb=300;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Geopotential_height_isobaric')==1
    units='dam';
    varname='Geopotential Height';
    savename='GPH';
    vara=0;  % regular
    varb=50000;
    var1=100; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Geopotential_height_surface')==1
    units='gpm';
    varname='Geopotential Height (Surface)';
    savename='SGPH';
    vara=0;  % regular
    varb=2000;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Geopotential_height_tropopause')==1
    units='gpm';
    varname='Orography';
    savename='OROG';
    vara=0;  % regular
    varb=20000;
    var1=1000; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},['Large-scale_precipitation_non-convective_surface_Accumulation'])==1
    units='kg m$^{-2}$';
    varname='Accum. Non-Convective Precip. (Surface)';
    savename='NCPCP';
    vara=0;  % regular
    varb=200;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},'Latent_heat_net_flux_surface')==1
    units='W m$^{-2}$';
    varname='Net Surface Latent Heat Flux (Surface)';
    savename='LHTFL';
    vara=0;  % regular
    varb=500;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Momentum_flux_u-component_surface')==1
    units='N m$^{-2}$';
    varname='Momentum Flux (U-component; Surface)';
    savename='UFLX';
    vara=-1;  % regular
    varb=1;
    var1=0.1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Momentum_flux_v-component_surface')==1
    units='N m$^{-2}$';
    varname='Momentum Flux (V-component; Surface)';
    savename='VFLX';
    vara=-1;  % regular
    varb=1;
    var1=0.1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Planetary_Boundary_Layer_Height_surface')==1
    units='m';
    varname='PBL Height (Surface)';
    savename='PBL';
    vara=0;  % regular
    varb=3000;
    var1=100; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Potential_temperature_tropopause')==1
    units='K';
    varname='Potential Temperature (Tropopause)';
    savename='PT';
    vara=300;  % regular
    varb=400;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Precipitable_water_entire_atmosphere')==1
    units='kg m$^{-2}$';
    varname='Total Precipitable Water';
    savename='PWAT';
    vara=0;  % regular
    varb=80;
    var1=20; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=7; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},'Precipitation_rate_surface')==1
    units='kg m$^{-2}$ s$^{-1}$';
    varname='Precip. Rate (Surface)';
    savename='PRATE';
    vara=0;  % regular
    varb=0.1;
    var1=0.1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},'Pressure_reduced_to_MSL_msl')==1
    units='hPa';
    varname='Mean Sea Level Pressure';
    savename='MSLP';
    vara=980;  % regular
    varb=1020;
    var1=2; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Pressure_surface')==1
    units='hPa';
    varname='Pressure (Surface)';
    savename='SP';
    vara=900;  % regular
    varb=1050;
    var1=1020; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Pressure_tropopause')==1
    units='Pa';
    varname='Pressure (Tropopause)';
    savename='PRES';
    vara=100;  % regular
    varb=150;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Rain_mixing_ratio_isobaric')==1
    units='kg kg$^{-1}$';
    varname='Rain Mixing Ratio';
    savename='RWMR';
    vara=0;  % regular
    varb=0.1;
    var1=0.01; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},'Reflectivity_isobaric')==1
    units='dB';
    varname='Derived Radar Reflectivity';
    savename='REFD';
    vara=-25;  % regular
    varb=75;
    var1=20; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=6; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},'Relative_humidity_height_above_ground')==1
    units='\%';
    varname='Rel. Humidity (2 m)';
    savename='RH2M';
    vara=0;  % regular
    varb=100;
    var1=20; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=5; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Relative_humidity_isobaric')==1
    units='\%';
    varname='Rel. Humidity';
    savename='RH';
    vara=0;  % regular
    varb=100;
    var1=30; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=5; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Rime_Factor_isobaric')==1
    units='non-dim';
    varname='Rime Factor';
    savename='RIME';
    vara=0;  % regular
    varb=50;
    var1=5; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},'Sensible_heat_net_flux_surface')==1
    units='W m$^{-2}$';
    varname='Net Sensible Heat Flux (Surface)';
    savename='SHTFL';
    vara=-200;  % regular
    varb=200;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Snow_mixing_ratio_isobaric')==1
    units='kg kg$^{-1}$';
    varname='Snow Mixing Ratio';
    savename='SNMR';
    vara=0;  % regular
    varb=0.01;
    var1=0.001; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},'Specific_humidity_height_above_ground')==1
    units='kg kg$^{-1}$';
    varname='Specific Humidity (2 m)';
    savename='Q2M';
    vara=0;  % regular
    varb=0.1;
    var1=0.01; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=5; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Specific_humidity_isobaric')==1
    units='kg kg$^{-1}$';
    varname='Specific Humidity';
    savename='Q';
    vara=0;  % regular
    varb=0.1;
    var1=0.01; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=5; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Storm_relative_helicity_height_above_ground_layer')==1
    units='J kg$^{-1}$';
    varname='Storm-Rel. Helicity (1500 m)';
    savename='HLCY';
    vara=-200;  % regular
    varb=200;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Surface_roughness_surface')==1
    units='m';
    varname='Roughness (Surface)';
    savename='SR';
    vara=0;  % regular
    varb=1;
    var1=0.1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Temperature_height_above_ground')==1
    units='K';
    varname='Temperature (2 m)';
    savename='TEMP2M';
    vara=275;  % regular
    varb=325;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Temperature_isobaric')==1
    units='K';
    varname='Temperature';
    savename='TEMP';
    vara=150;  % regular
    varb=350;
    var1=5; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Temperature_surface')==1
    units='K';
    varname='Temperature (Surface)';
    savename='TEMPSURF';
    vara=275;  % regular
    varb=325;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Temperature_tropopause')==1
    units='K';
    varname='Temperature (Tropopause)';
    savename='TEMPTROPO';
    vara=175;  % regular
    varb=225;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Total_Column_Integrated_Rain_entire_atmosphere')==1
    units='kg m$^{-2}$';
    varname='Column-Integrated Rain';
    savename='TCOLR';
    vara=0;  % regular
    varb=50;
    var1=1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},'Total_Column_Integrated_Snow_entire_atmosphere')==1
    units='kg m$^{-2}$';
    varname='Column-Integrated Rain Vorticity';
    savename='TCOLS';
    vara=0;  % regular
    varb=50;
    var1=1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},'Total_Column-Integrated_Cloud_Ice_entire_atmosphere')==1
    units='kg m$^{-2}$';
    varname='Column-Integrated Cloud Ice';
    savename='TCOLI';
    vara=0;  % regular
    varb=5;
    var1=0.5; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},'Total_Column-Integrated_Cloud_Water_entire_atmosphere')==1
    units='kg m$^{-2}$';
    varname='Column-Integrated Cloud Water';
    savename='TCOLW';
    vara=0;  % regular
    varb=10;
    var1=1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},'Total_Column-Integrated_Condensate_entire_atmosphere')==1
    units='kg m$^{-2}$';
    varname='Column-Integrated Condensate';
    savename='TCOLC';
    vara=0;  % regular
    varb=100;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},'Total_Condensate_isobaric')==1
    units='kg kg$^{-1}$';
    varname='Total Condensate';
    savename='TCOND';
    vara=0;  % regular
    varb=0.1;
    var1=0.01; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},['Total_precipitation_surface_Accumulation'])==1
    units='kg m$^{-2}$';
    varname='Accum. Total Precip. (Surface)';
    savename='TP';
    vara=0;  % regular
    varb=200;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif strcmp(identvariables{identvar},'Upward_Long-Wave_Radp_Flux_surface')==1
    units='10$^{-5}$ s$^{-1}$';
    varname='Upward LW Rad. Flux (Surface)';
    savename='ULWRF';
    vara=350;  % regular
    varb=500;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Upward_Long-Wave_Radp_Flux_surface_0_Average')==1
    units='W m$^{-2}$';
    varname='Hr.-Av. Upward LW Rad. Flux (Surface)';
    savename='AULWRF';
    vara=350;  % regular
    varb=500;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Upward_Short-Wave_Radiation_Flux_surface')==1
    units='W m$^{-2}$';
    varname='Upward SW Rad. Flux (Surface)';
    savename='USWRF';
    vara=0;  % regular
    varb=100;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},['Upward_Short-Wave_Radiation_Flux_surface_Average'])==1
    units='W m$^{-2}$';
    varname='Hr.-Av. Upward SW Rad. Flux (Surface)';
    savename='AUSWRF';
    vara=0;  % regular
    varb=100;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'VAR10-3-203_FROM_7-0-0_height_above_ground')==1
    units='non-dim';
    varname='Heat Exchange Coefficient (10 m)';
    savename='HEC10M';
    vara=0;  % regular
    varb=1;
    var1=0.1; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Vertical_Speed_Shear_tropopause')==1
    units='s$^{-1}$';
    varname='Vertical Speed Shear (Tropopause)';
    savename='ABSV';
    vara=-0.2;  % regular
    varb=0.2;
    var1=0.01; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Vertical_velocity_pressure_isobaric')==1
    units='Pa s$^{-1}$';
    varname='Vertical Velocity';
    savename='W';
    vara=-20;  % regular
    varb=20;
    var1=5; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Water_temperature_surface')==1
    units='K';
    varname='Sea Surface Temperature';
    savename='SST';
    vara=275;  % regular
    varb=325;
    var1=1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'u-component_of_wind_height_above_ground')==1
    units='kts';
    varname='Zonal Wind (10 m)';
    savename='U10M';
    vara=-10;  % regular
    varb=10;
    var1=1; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'u-component_of_wind_isobaric')==1
    units='kts';
    varname='Zonal Wind';
    savename='U';
    vara=-50;  % regular
    varb=50;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'u-component_of_wind_tropopause')==1
    units='kts';
    varname='Zonal Wind (Tropopause)';
    savename='UTROPO';
    vara=-20;  % regular
    varb=20;
    var1=2; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'v-component_of_wind_height_above_ground')==1
    units='kts';
    varname='Meridional Wind (10 m)';
    savename='V10M';
    vara=-10;  % regular
    varb=10;
    var1=1; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'v-component_of_wind_isobaric')==1
    units='kts';
    varname='Meridional Wind';
    savename='V';
    vara=-50;  % regular
    varb=50;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'v-component_of_wind_tropopause')==1
    units='kts';
    varname='Meridional Wind (Tropopause)';
    savename='VTROPO';
    vara=-20;  % regular
    varb=20;
    var1=2; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'radial-component_of_wind_height_above_ground')==1
    units='kts';
    varname='Radial Wind (10 m)';
    savename='RADWND10M';
    vara=-10;  % regular
    varb=10;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'tangential-component_of_wind_height_above_ground')==1
    units='kts';
    varname='Tangential Wind (10 m)';
    savename='TANWND10M';
    vara=-50;  % regular
    varb=50;
    var1=20; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'radial-component_of_wind_isobaric')==1
    units='kts';
    varname='Radial Wind';
    savename='RADWND';
    vara=-10;  % regular
    varb=10;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'tangential-component_of_wind_isobaric')==1
    units='kts';
    varname='Tangential Wind';
    savename='TANWND';
    vara=-50;  % regular
    varb=50;
    var1=20; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'radial-component_of_wind_tropopause')==1
    units='kts';
    varname='Radial Wind (Tropopause)';
    savename='RADWNDTROPO';
    vara=-10;  % regular
    varb=10;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'tangential-component_of_wind_tropopause')==1
    units='kts';
    varname='Tangential Wind (Tropopause)';
    savename='TANWNDTROPO';
    vara=-50;  % regular
    varb=50;
    var1=20; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'Relative_vorticity_isobaric')==1
    units='10$^{-5}$ s$^{-1}$';
    varname='Rel. Vorticity';
    savename='RVRT';
    vara=-40;  % regular
    varb=40;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'wind_speed_height_above_ground')==1
    units='kts';
    varname='Wind Speed (10 m)';
    savename='WS10M';
    vara=0;  % regular
    varb=180;
    var1=5; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=8; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif strcmp(identvariables{identvar},'wind_speed_isobaric')==1
    units='kts';
    varname='Wind Speed';
    savename='WS';
    vara=0;  % regular
    varb=180;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=8; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7) windc(8)
    cbar2=3;
elseif strcmp(identvariables{identvar},'wind_speed_tropopause')==1
    units='kts';
    varname='Wind Speed (Tropopause)';
    savename='WSTROPO';
    vara=0;  % regular
    varb=180;
    var1=5; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=8; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;    
elseif strcmp(identvariables{identvar},'Divergence_isobaric')==1
    units='10$^{-5}$ s$^{-1}$';
    varname='Divergence';
    savename='DIVG';
    vara=-40;  % regular
    varb=40;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
end    

%% Create bounds
cmin=vara;
if cbar1==8
cmax=179.6;
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

