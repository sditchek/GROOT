%% Variable Bounds for Plotting
if identvar==1 % Absolute vorticity | isobaric
	bands=[12 26 40 54 68 82 96 110 124 138 152 166 180 194 208 222 236 250 264 278 292 306 320 334 348 362 376 390 404 418 432 446 460 474 488 502 516 530 544 558 572 586 600 614 627];
    units='10$^{-5}$ s$^{-1}$';
    varname='Absolute Vorticity';
    savename='ABSV';
    vara=-100;  % regular
    varb=100;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==2 %     Convective available potential energy | surface
	bands=661;
    units='J kg$^{-1}$';
    varname='CAPE (Surface)';
    savename='CAPE';
    vara=0;  % regular
    varb=5000;
    var1=500; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==3 %     Convective inhibition 
	bands=662;
    units='J kg$^{-1}$';
    varname='CIN (Surface)';
    savename='CIN';
    vara=-500;  % regular
    varb=0;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=1; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==4 %     Convective precipitation | surface
	bands=652;
    units='kg m$^{-2}$';
    varname='Accum. Convective Precip. (Surface)';
    savename='ACPCP';
    vara=0;  % regular
    varb=10;
    var1=1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif identvar==5 %     Convective precipitation rate | surface
	bands=649;
    units='kg m$^{-2}$ s$^{-1}$';
    varname='Convective Precip. Rate (Surface)';
    savename='CPRATE';
    vara=0;  % regular
    varb=0.1;
    var1=0.1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif identvar==6 % Dew Point Temp | 2 M
	bands=644;
    units='K';
    varname='Dew-Point Temperature (2 m)';
    savename='TDP2M';
    vara=200;  % regular
    varb=300;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==7 % Exchange Coeff | Surface
	bands=660;
    units='(kg m$^{-3}$)(m s$^{-1}$)';
    varname='Exchange Coefficient (Surface)';
    savename='ECSURF';
    vara=0;  % regular
    varb=1;
    var1=0.1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==8 % Frictional Velocity | Surface
	bands=655;
    units='m/s';
    varname='Friction Velocity (Surface)';
    savename='FVSURF';
    vara=0;  % regular
    varb=1;
    var1=0.1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==9 %     Geopotential height | isobaric
	bands=[4 18 32 46 60 74 88 102 116 130 144 158 172 186 200 214 228 242 256 270 284 298 312 326 340 354 368 382 396 410 424 438 452 466 480 494 508 522 536 550 564 578 592 606 636];
    units='dam';
    varname='Geopotential Height';
    savename='GPH';
    vara=0;  % regular
    varb=50000;
    var1=100; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==10 %    Geopotential height | surface
	bands=640;
    units='gpm';
    varname='Geopotential Height (Surface)';
    savename='SGPH';
    vara=0;  % regular
    varb=2000;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==11 % Geopotential height | tropopause
	bands=685;
    units='gpm';
    varname='Geopotential Height (Tropopause)';
    savename='TGPH';
    vara=0;  % regular
    varb=20000;
    var1=1000; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==12 % Graupel Mixing Ratio | Isobaric
	bands=[16 30 44 58 72 86 100 114 128 142 156 170 184 198 212 226 240 254 268 282 296 310 324 338 352 366 380 394 408 422 436 450 464 478 492 506 520 534 548 562 576 590 604 618 631]
    units='kg kg$^{-1}$';
    varname='Graupel Mixing Ratio';
    savename='GRPMR';
    vara=0;  % regular
    varb=0.01;
    var1=0.001; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif identvar==13 % Hourly Maximum of Downward Vertical Velocity | 2D
	bands=634;
    units='m s$^{-1}$';
    varname='Hourly Max of Downward Vertical Velocity';
    savename='HMAXVV';
    vara=-10;  % regular
    varb=10;
    var1=1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==14 % Hourly Maximum of Downward Vertical Velocity in the lowest 400 hPa| 2D
	bands=633;
    units='m s$^{-1}$';
    varname='Hourly Max of Downward Vertical Velocity in Lowest 400 hPa';
    savename='HMAXVV400';
    vara=-10;  % regular
    varb=10;
    var1=1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==15 % Hourly Maximum of Updraft Helicity over Layer 2km to 5 km AGL 
    bands=638;
	units='m$^{2}$ s$^{-2}$';
    varname='Hourly Max of Updraft Helicity (2 km - 5 km)';
    savename='HMAXUH25';
    vara=0;  % regular
    varb=50;
    var1=5; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;	
elseif identvar==16 % Hourly Maximum of Updraft Helicity over Layer 0km to 3 km AGL 
    bands=638;
	units='m$^{2}$ s$^{-2}$';
    varname='Hourly Max of Updraft Helicity (0 km - 3 km)';
    savename='HMAXUH03';
    vara=0;  % regular
    varb=50;
    var1=5; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;	
elseif identvar==17 % Ice Water Mixing Ratio | Isobaric
    bands=[13 27 41 55 69 83 97 111 125 139 153 167 181 195 209 223 237 251 265 279 293 307 321 335 349 363 377 391 405 419 433 447 461 475 489 503 517 531 545 559 573 587 601 615 628]
	units='kg kg$^{-1}$';
    varname='Ice Water Mixing Ratio';
    savename='IWMR';
    vara=0;  % regular
    varb=0.1;
    var1=0.01; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif identvar==18 % Land Cover
    bands=693
	units='Proportion';
    varname='Land Cover';
    savename='LAND';
    vara=0;  % regular
    varb=1;
    var1=0.1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==19 % Large Scale Precip
    units='kg m$^{-2}$';
    varname='Large-Scale Precip. (Surface)';
    savename='LSPCP';
    vara=0;  % regular
    varb=200;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif identvar==20 % 
	bands=659;
    units='W m$^{-2}$';
    varname='Net Latent Heat Flux (Surface)';
    savename='LHTFL';
    vara=0;  % regular
    varb=500;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==21   %  MSLP (Eta model reduction) 
	bands=635;
    units='hPa';
    varname='Mean Sea Level Pressure';
    savename='MSLPETA';
    vara=975;  % regular
    varb=1025;
    var1=2; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==22 % Composite Refl.
	bands=2
    units='dB';
    varname='Composite Reflectivity';
    savename='REFC';
    vara=-25;  % regular
    varb=75;
    var1=20; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=6; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif identvar==23 % momentum flux u
	bands=656;
    units='N m$^{-2}$';
    varname='Momentum Flux (U-component; Surface)';
    savename='UMFLX';
    vara=-10;  % regular
    varb=10;
    var1=1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==24 % momentum flux v
	bands=657;
    units='N m$^{-2}$';
    varname='Momentum Flux (V-component; Surface)';
    savename='VMFLX';
    vara=-10;  % regular
    varb=10;
    var1=1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==25 % PBL 
	bands=690;
    units='m';
    varname='PBL Height (Surface)';
    savename='PBL';
    vara=0;  % regular
    varb=3000;
    var1=100; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==26 % Precip Water
	bands=663;
    units='kg m$^{-2}$';
    varname='Total Precipitable Water';
    savename='PWAT';
    vara=0;  % regular
    varb=100;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=7; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif identvar==27 % Precip Rate
    bands=650;
	units='kg m$^{-2}$ s$^{-1}$';
    varname='Precip. Rate (Surface)';
    savename='PRATE';
    vara=0;  % regular
    varb=0.1;
    var1=0.01; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif identvar==28 % Surface Pressure
	bands=639;
    units='hPa';
    varname='Pressure (Surface)';
    savename='PRESSURF';
    vara=500;  % regular
    varb=1000;
    var1=100; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==29 % Tropopause Pressure
    bands=684;
	units='hPa';
    varname='Pressure (Tropopause)';
    savename='PRESTROP';
    vara=0;  % regular
    varb=500;
    var1=100; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==30 % MSLP
	bands=1;
    units='hPa';
    varname='Mean Sea Level Pressure';
    savename='MSLP';
    vara=980;  % regular
    varb=1020;
    var1=2; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==31 % Rain Mixing Ratio
	bands=[14 28 42 56 70 84 98 112 126 140 154 168 182 196 210 224 238 252 266 280 294 308 322 336 350 364 378 392 406 420 434 448 462 476 490 504 518 532 546 560 574 588 602 616 629];
    units='kg kg$^{-1}$';
    varname='Rain Mixing Ratio';
    savename='RWMR';
    vara=0;  % regular
    varb=0.1;
    var1=0.01; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif identvar==32 % Reflectivity
	bands=[17 31 45 59 73 87 101 115 129 143 157 171 185 199 213 227 241 255 269 283 297 311 325 339 353 367 381 395 409 423 437 451 465 479 493 507 521 535 549 563 577 591 605 619 632];
    units='dB';
    varname='Radar Reflectivity';
    savename='REFD';
    vara=-25;  % regular
    varb=75;
    var1=20; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=6; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif identvar==33 % RH 2 M
	bands=645;
    units='\%';
    varname='Rel. Humidity (2 m)';
    savename='RH2M';
    vara=0;  % regular
    varb=100;
    var1=20; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=5; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==34 % RH Isobaric
	bands=[6 20 34 48 62 76 90 104 118 132 146 160 174 188 202 216 230 244 258 272 286 300 314 328 342 356 370 384 398 412 426 440 454 468 482 496 510 524 538 552 566 580 594 608 621];
    units='\%';
    varname='Rel. Humidity';
    savename='RH';
    vara=0;  % regular
    varb=100;
    var1=30; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=5; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==35 % net sens heat flux
	bands=658;
    units='W m$^{-2}$';
    varname='Net Sensible Heat Flux (Surface)';
    savename='SHTFL';
    vara=-1000;  % regular
    varb=1000;
    var1=100; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==36 % snow mixing ratio
	bands=[15 29 43 57 71 85 99 113 127 141 155 169 183 197 211 225 239 253 267 281 295 309 323 337 351 365 379 393 407 421 435 449 463 477 491 505 519 533 547 561 575 589 603 617 630];
    units='kg kg$^{-1}$';
    varname='Snow Mixing Ratio';
    savename='SNMR';
    vara=0;  % regular
    varb=0.01;
    var1=0.001; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif identvar==37 % specific humid. 2m
	bands=643
    units='kg kg$^{-1}$';
    varname='Specific Humidity (2 m)';
    savename='Q2M';
    vara=0;  % regular
    varb=0.025;
    var1=0.0025; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=5; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==38 % specific humid. isobaric
	bands=[7 21 35 49 63 77 91 105 119 133 147 161 175 189 203 217 231 245 259 273 287 301 315 329 343 357 371 385 399 413 427 441 455 469 483 497 511 525 539 553 567 581 595 609 622];
    units='kg kg$^{-1}$';
    varname='Specific Humidity';
    savename='Q';
    vara=0;  % regular
    varb=0.025;
    var1=0.0025; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=5; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==39 % storm relative helicity
	bands=683;
    units='J kg$^{-1}$';
    varname='Storm-Rel. Helicity (3000 m)';
    savename='HLCY';
    vara=-500;  % regular
    varb=500;
    var1=50; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==40 % surface roughness
	bands=654;
    units='m';
    varname='Roughness (Surface)';
    savename='SR';
    vara=0;  % regular
    varb=3;
    var1=0.3; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==41 % 2 m temp
	bands=642;
    units='K';
    varname='Temperature (2 m)';
    savename='TEMP2M';
    vara=275;  % regular
    varb=325;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==42 % temp tropopause
    bands=686;
	units='K';
    varname='Temperature (Tropopause)';
    savename='TEMPTROPO';
    vara=175;  % regular
    varb=255;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==43 % cloud top temp
	bands=671;
    units='K';
    varname='Temperature (Cloud Top)';
    savename='TEMPCT';
    vara=-500;  % regular
    varb=300;
    var1=5; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==44 % temp isobar
	bands=[5 19 33 47 61 75 89 103 117 131 145 159 173 187 201 215 229 243 257 271 285 299 313 327 341 355 369 383 397 411 425 439 453 467 481 495 509 523 537 551 565 579 593 607 620];
    units='K';
    varname='Temperature';
    savename='TEMP';
    vara=175;  % regular
    varb=325;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3; 
elseif identvar==45 % temp surface
	bands=641;
    units='K';
    varname='Temperature (Surface)';
    savename='TEMPSURF';
    vara=275;  % regular
    varb=325;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3; 
elseif identvar==46 % 
	bands=666;
    units='kg m$^{-2}$';
    varname='Column-Integrated Rain';
    savename='TCOLR';
    vara=0;  % regular
    varb=50;
    var1=1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif identvar==47 % 
	bands=667;
    units='kg m$^{-2}$';
    varname='Column-Integrated Snow';
    savename='TCOLS';
    vara=0;  % regular
    varb=50;
    var1=1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif identvar==48 % 
	bands=665;
    units='kg m$^{-2}$';
    varname='Column-Integrated Cloud Ice';
    savename='TCOLI';
    vara=0;  % regular
    varb=50;
    var1=1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif identvar==49 % 
	bands=664;
    units='kg m$^{-2}$';
    varname='Column-Integrated Cloud Water';
    savename='TCOLW';
    vara=0;  % regular
    varb=50;
    var1=1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif identvar==50 % 
	bands=668;
    units='kg m$^{-2}$';
    varname='Column-Integrated Condensate';
    savename='TCOLC';
    vara=0;  % regular
    varb=50;
    var1=1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif identvar==51 % 
	bands=651;
    units='kg m$^{-2}$';
    varname='Accum. Total Precip. (Surface)';
    savename='TP';
    vara=0;  % regular
    varb=200;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=4; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=5;
elseif identvar==52 % 
	bands=689;
    units='s$^{-1}$';
    varname='Vertical Speed Shear (Tropopause)';
    savename='VSSTROP';
    vara=-0.1;  % regular
    varb=0.1;
    var1=0.01; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==53 % 
	bands=[9 23 37 51 65 79 93 107 121 135 149 163 177 191 205 219 233 247 261 275 289 303 317 331 345 359 373 387 401 415 429 443 457 471 485 499 513 527 541 555 569 583 597 611 624];
    units='m s$^{-1}$';
    varname='Vertical Velocity (Geometric)';
    savename='WGEO';
    vara=-50;  % regular
    varb=50;
    var1=5; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==54 % 
	bands=[8 22 36 50 64 78 92 106 120 134 148 162 176 190 204 218 232 246 260 274 288 302 316 330 344 358 372 386 400 414 428 442 456 470 484 498 512 526 540 554 568 582 596 610 623];
    units='Pa s$^{-1}$';
    varname='Vertical Velocity';
    savename='WPRES';
    vara=-50;  % regular
    varb=50;
    var1=5; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3; 
elseif identvar==55 % 
	bands=694;
    units='K';
    varname='Sea Surface Temperature';
    savename='SST';
    vara=260;  % regular
    varb=325;
    var1=1; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=2; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==56 % wind speed gusts
	bands=3;
    units='m/s';
    varname='Wind Speed (Gusts)';
    savename='WSGUSTS';
    vara=0;  % regular
    varb=50;
    var1=5; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=8; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==58 % 10m U
	bands=646;
	units='m/s';
    varname='Zonal Wind (10 m)';
    savename='U10M';
    vara=-50;  % regular
    varb=50;
    var1=5; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==59 % 10m V
	bands=647;
    units='m/s';
    varname='Meridional Wind (10 m)';
    savename='V10M';
    vara=-50;  % regular
    varb=50;
    var1=5; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==60 % trop U
	bands=687;
    units='m/s';
    varname='Zonal Wind (Tropopause)';
    savename='UTROPO';
    vara=-50;  % regular
    varb=50;
    var1=5; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==61 % trop V
    bands=688;
	units='m/s';
    varname='Meridional Wind (Tropopause)';
    savename='VTROPO';
    vara=-50;  % regular
    varb=50;
    var1=5; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==62 % U
    bands=[10 24 38 52 66 80 94 108 122 136 150 164 178 192 206 220 234 248 262 276 290 304 318 332 346 360 374 388 402 416 430 444 458 472 486 500 514 528 542 556 570 584 598 612 625];
	units='m/s';
    varname='Zonal Wind';
    savename='U';
    vara=-50;  % regular
    varb=50;
    var1=5; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==63 % V
	bands=[11 25 39 53 67 81 95 109 123 137 151 165 179 193 207 221 235 249 263 277 291 305 319 333 347 361 375 389 403 417 431 445 459 473 487 501 515 529 543 557 571 585 599 613 626];
    units='m/s';
    varname='Meridional Wind';
    savename='V';
    vara=-50;  % regular
    varb=50;
    var1=5; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;







elseif identvar==65 % 
    units='10$^{-5}$ s$^{-1}$';
    varname='Rel. Vorticity';
    savename='RVRT';
    vara=-40;  % regular
    varb=40;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==66 % 
    units='m/s';
    varname='Radial Wind (10 m)';
    savename='RADWND10M';
    vara=-10;  % regular
    varb=10;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==67 % 
    units='m/s';
    varname='Tangential Wind (10 m)';
    savename='TANWND10M';
    vara=-50;  % regular
    varb=50;
    var1=20; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==68 % 
    units='m/s';
    varname='Wind Speed (10 m)';
    savename='WS10M';
    vara=0;  % regular
    varb=180;
    var1=5; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=8; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==69 % 
    units='m/s';
    varname='Radial Wind (Tropopause)';
    savename='RADWNDTROPO';
    vara=-10;  % regular
    varb=10;
    var1=10; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==70 % 
    units='m/s';
    varname='Tangential Wind (Tropopause)';
    savename='TANWNDTROPO';
    vara=-50;  % regular
    varb=50;
    var1=20; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==71 % 
    units='m/s';
    varname='Wind Speed (Tropopause)';
    savename='WSTROPO';
    vara=0;  % regular
    varb=180;
    var1=5; % difference
    levs=0;  % 3d (1) 2d (0)
    cbar1=8; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;  	
elseif identvar==72 % 
    units='m/s';
    varname='Radial Wind';
    savename='RADWND';
    vara=-10;  % regular
    varb=10;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==73 % 
    units='m/s';
    varname='Tangential Wind';
    savename='TANWND';
    vara=-50;  % regular
    varb=50;
    var1=20; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=3; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7)
    cbar2=3;
elseif identvar==74 % 
    units='m/s';
    varname='Wind Speed';
    savename='WS';
    vara=0;  % regular
    varb=180;
    var1=10; % difference
    levs=1;  % 3d (1) 2d (0)
    cbar1=8; % negzero(1) zeropos(2) negpos(3) wet(4) wetdry(5) radar(6) tpw(7) windc(8)
    cbar2=3;
end    






















%% Create bounds
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
