PROGRAM read_convdiag 
!
! The arrary containning o-g 01 diagnosistic information is rdiagbuf which is setup in setupt.f90, setupq.f90, etc ...
!        rstation_id     = data(id,i)
!        cdiagbuf(ii)    = station_id         ! station id
!
!        rdiagbuf(1,ii)  = ictype(ikx)        ! observation type
!        rdiagbuf(2,ii)  = icsubtype(ikx)     ! observation subtype
!
!        rdiagbuf(3,ii)  = data(ilate,i)      ! observation latitude (degrees)
!        rdiagbuf(4,ii)  = data(ilone,i)      ! observation longitude (degrees)
!        rdiagbuf(5,ii)  = data(istnelv,i)    ! station elevation (meters)
!        rdiagbuf(6,ii)  = prest              ! observation pressure (hPa)
!        rdiagbuf(7,ii)  = data(iobshgt,i)    ! observation height (meters)
!        rdiagbuf(8,ii)  = dtime-time_offset  ! obs time (hours relative to analysis time)
!
!        rdiagbuf(9,ii)  = data(iqc,i)        ! input prepbufr qc or event mark
!        rdiagbuf(10,ii) = data(iqt,i)        ! setup qc or event mark (currently qtflg only)
!        rdiagbuf(11,ii) = data(iuse,i)       ! read_prepbufr data usage flag
!        rdiagbuf(12,ii) = one                ! analysis usage flag (1=use,-1=not used)
!        rdiagbuf(13,ii) = rwgt               ! nonlinear qc relative weight
!        rdiagbuf(14,ii) = errinv_input       ! prepbufr inverse obs error (K**-1)
!        rdiagbuf(15,ii) = errinv_adjst       ! read_prepbufr inverse obs error (K**-1)
!        rdiagbuf(16,ii) = errinv_final       ! final inverse observation error (K**-1)
!
!        rdiagbuf(17,ii) = data(itob,i)       ! temperature observation (K)
!        rdiagbuf(18,ii) = ddiff              ! obs-ges used in analysis (K)
!        rdiagbuf(19,ii) = tob-tges           ! obs-ges w/o bias correction (K) (future slot)
!
!        if (aircraft_t_bc_pof .or. aircraft_t_bc .or. aircraft_t_bc_ext) then
!           rdiagbuf(20,ii) = data(ipof,i)       ! data pof
!           rdiagbuf(21,ii) = data(ivvlc,i)      ! data vertical velocity
!           do j=1,npredt
!              rdiagbuf(21+j,ii) = predbias(j)
!           end do
!        end if
!*******************************************************************************

 implicit none

 integer,parameter:: maxn=2500000
 real(4),parameter:: r1em3 = 1.0e-3

 character:: infile*255,outdir*255,outfile*255,date*10,filetype*4,dtype*3,obstype*3,label*20
 character(8),allocatable,dimension(:) :: cdiag
 character(8),dimension(maxn) :: cwork
 
 integer:: idate,jdate,narg,lunin,jtype,ityp,ndata,nn,iflag,lev
 integer:: nlev,jiter,iout,ilev,k,nchar,nreal,ii,i,hgt,itype,stype
 
 real(4),allocatable,dimension(:,:)    :: rdiag
 real(4),dimension(maxn,0:20) :: dwork
 real(4):: hob,dq,du,dv,dvd

 logical:: first,prt

 NARG=IARGC()
 IF(NARG.LT.4) THEN
    PRINT *,'gsi_diag <diagfile> <outdir> <date> <type>'
    stop ('NEEDS at least FOUR ARGUMENTS')
 ENDIF
 CALL GETARG(1,infile)
 CALL GETARG(2,outdir)
 CALL GETARG(3,date)
 CALL GETARG(4,filetype)
 read(date,*) jdate

 outfile=trim(outdir)//'/gsidiag_'//trim(filetype)//'.'//trim(date)//'.ps_conv'
 open(unit=10,file=outfile,form='formatted',status='replace',action='Write')
 PRINT "(a16,a150)",'New ASCII File: ',outfile

 outfile=trim(outdir)//'/gsidiag_'//trim(filetype)//'.'//trim(date)//'.uv_conv'
 open(unit=11,file=outfile,form='formatted',status='replace',action='Write')
 PRINT "(a16,a150)",'New ASCII File: ',outfile

 outfile=trim(outdir)//'/gsidiag_'//trim(filetype)//'.'//trim(date)//'.t_conv'
 open(unit=12,file=outfile,form='formatted',status='replace',action='Write')
 PRINT "(a16,a150)",'New ASCII File: ',outfile

 outfile=trim(outdir)//'/gsidiag_'//trim(filetype)//'.'//trim(date)//'.q_conv'
 open(unit=13,file=outfile,form='formatted',status='replace',action='Write')
 PRINT "(a16,a150)",'New ASCII File: ',outfile

 PRINT '("stats for ",i15,10x,a150)',jdate,infile
 write(unit=10,FMT="(a10,i15,10x,a150)") "stats for ",jdate,infile
 write(unit=11,FMT="(a10,i15,10x,a150)") "stats for ",jdate,infile
 write(unit=12,FMT="(a10,i15,10x,a150)") "stats for ",jdate,infile
 write(unit=13,FMT="(a10,i15,10x,a150)") "stats for ",jdate,infile

 lunin=20
 nn=0

 close(lunin)
 open(lunin,file=infile,form='unformatted',convert="little_endian")
 first=.true. ; goto 3

2  if(first) then
      close(lunin)
      open(lunin,file=infile,form='unformatted',convert="big_endian")
      first=.false.
      goto 3
   else
      stop ('bad diag file or wrong date')
   endif

3  rewind(lunin); read(lunin,err=2) idate; print *, idate,jdate
   write(unit=10,FMT="(i15,2x,i15)") idate,jdate
   write(unit=11,FMT="(i15,2x,i15)") idate,jdate
   write(unit=12,FMT="(i15,2x,i15)") idate,jdate
   write(unit=13,FMT="(i15,2x,i15)") idate,jdate

   if(idate/=jdate) goto 2

   write(unit=10,FMT="(a10,a9,a13,4a16,2a9,4a25,3a16)") &
                      &"obs. type","obs. id","obs. sub-id","latitude","longitude","pressure (hPa)","obs time","usage",&
                      &"qc-flag","final inv. obs. err.","prepbufr obs. err.","read_prepbufr obs. err.","final obs. err.",&
                      &"observation","bkgd or anl","O-B or O-A"
   write(unit=11,FMT="(a10,a9,a13,4a16,2a9,4a25,6a16)") &
                      &"obs. type","obs. id","obs. sub-id","latitude","longitude","pressure (hPa)","obs time","usage",&
                      &"qc-flag","final inv. obs. err.","prepbufr obs. err.","read_prepbufr obs. err.","final obs. err.",&
                      &"u observation","u bkgd or anl","u O-B or O-A","v observation","v bkgd or anl","v O-B or O-A"
   write(unit=12,FMT="(a10,a9,a13,4a16,2a9,4a25,3a16)") &
                      &"obs. type","obs. id","obs. sub-id","latitude","longitude","pressure (hPa)","obs time","usage",&
                      &"qc-flag","final inv. obs. err.","prepbufr obs. err.","read_prepbufr obs. err.","final obs. err.",&
                      &"observation","bkgd or anl","O-B or O-A"
   write(unit=13,FMT="(a10,a9,a13,4a16,2a9,4a25,3a16)") &
                      &"obs. type","obs. id","obs. sub-id","latitude","longitude","pressure (hPa)","obs time","usage",&
                      &"qc-flag","final inv. obs. err.","prepbufr obs. err.","read_prepbufr obs. err.","final obs. err.",&
                      &"observation","bkgd or anl","O-B or O-A"

 loopd: do; read(lunin,end=100,err=2) dtype,nchar,nreal,ii
    !print*,dtype,nchar,nreal,ii

      jtype=0
      if(dtype == ' ps') jtype=1
      if(dtype == '  q') jtype=2
      if(dtype == '  t') jtype=3
      if(dtype == ' uv') jtype=4
      if(dtype == 'spd') jtype=5

    allocate(cdiag(ii),rdiag(nreal,ii))
    read(lunin,IOSTAT=iflag) cdiag,rdiag
    
!   if(jtype==4) then
    !print*,ii
    loopi: do i=1,ii
       itype=rdiag(1,i);                    ! observation type  !!if(itype>=240.and.itype<=260) cycle ! skip satwinds
       stype=rdiag(2,i)                     ! observation subtype
       nn=nn+1; if(nn.gt.maxn) cycle        ! don't overflow arrays
       cwork(nn)=cdiag(i)                   ! station id
       dwork(nn,0)=jtype                    ! observation type (ps,q,t,uv,etc) 
       dwork(nn,1)=itype                    ! oi report type 
       dwork(nn,2)=rdiag(3,i)               ! observation latitude(degrees) 
       dwork(nn,3)=rdiag(4,i)               ! observation longitude(degrees)
       dwork(nn,4)=rdiag(5,i)               ! station elevation(meters) 
       dwork(nn,5)=rdiag(6,i)               ! observation pressure (hpa) 
       dwork(nn,6)=rdiag(7,i)               ! observation height (meters) 
       dwork(nn,7)=rdiag(8,i)               ! obs time (hours relat. to anal. time) 
       dwork(nn,8)=rdiag(9,i)               ! input prepbufr qc or event mark 
       dwork(nn,9)=rdiag(11,i)              ! read_prepbufr data usage flag 
       dwork(nn,10)=rdiag(12,i)             ! data usage flag((1=use, -1=not used) 
       dwork(nn,11)=rdiag(13,i)*.25         ! variational qc weight 
       dwork(nn,12)=rdiag(16,i)             ! final inverse observation error (K)

       !if(dwork(nn,11)<.5.or.rdiag(16,i)<=.00010) cycle
       !if(dwork(nn,10)< 0.0) cycle
       !print*,trim(dtype),pob,ityp,lev


       if( trim(dtype) == ' uv') then
          dwork(nn,15)=rdiag(17,i)             ! u observation
          dwork(nn,16)=rdiag(17,i)-rdiag(18,i) ! u background or analysis
          dwork(nn,17)=rdiag(20,i)             ! v observation
          dwork(nn,18)=rdiag(20,i)-rdiag(21,i) ! v background or analysis
          dwork(nn,19)=rdiag(23,i)             ! 10m wind reduction factor 
          du=dwork(nn,15)-dwork(nn,16)
          dv=dwork(nn,17)-dwork(nn,18)
          dvd=du*du+dv*dv

          !if(ityp==120) print*,du,dv

          write(unit=11,FMT="(a10,i9,i13,3f16.8,f16.2,2f9.1,4f25.6,6f16.8)") &
                             &trim(dtype),itype,stype,dwork(nn,2),dwork(nn,3),dwork(nn,5),dwork(nn,7),dwork(nn,10),dwork(nn,8),&
                             &dwork(nn,12),1.0/rdiag(14,i),1.0/rdiag(15,i),1.0/dwork(nn,12),dwork(nn,15),dwork(nn,16),rdiag(18,i),&
                             &dwork(nn,17),dwork(nn,18),rdiag(21,i)
       else if( trim(dtype) == '  q') then
          dwork(nn,15)=rdiag(17,i)             ! observation   
          dwork(nn,16)=rdiag(17,i)-rdiag(18,i) ! background or analysis   
          dwork(nn,17)=rdiag(20,i)             ! guess saturation specific humidity 
          dq=(dwork(nn,15)-dwork(nn,16))*1.e6

          write(unit=13,FMT="(a10,i9,i13,3f16.8,f16.2,2f9.1,4f25.6,3f16.8)") &
                             &trim(dtype),itype,stype,dwork(nn,2),dwork(nn,3),dwork(nn,5),dwork(nn,7),dwork(nn,10),dwork(nn,8),&
                             &dwork(nn,12),1.0/rdiag(14,i),1.0/rdiag(15,i),1.0/dwork(nn,12),dwork(nn,15),dwork(nn,16),rdiag(18,i)
       else if( trim(dtype) == ' ps') then
          dwork(nn,15)=rdiag(17,i)             ! observation   
          dwork(nn,16)=rdiag(17,i)-rdiag(18,i) ! background or analysis   
          dq=dwork(nn,15)-dwork(nn,16)

          !rdiag(14,i): prepbufr inverse obs error, !rdiag(15,i):read_prepbufr inverse obs error
          write(unit=10,FMT="(a10,i9,i13,3f16.8,f16.2,2f9.1,4f25.6,3f16.8)") &
                             &trim(dtype),itype,stype,dwork(nn,2),dwork(nn,3),dwork(nn,5),dwork(nn,7),dwork(nn,10),dwork(nn,8),&
                             &dwork(nn,12),1.0/rdiag(14,i),1.0/rdiag(15,i),1.0/dwork(nn,12),dwork(nn,15),dwork(nn,16),rdiag(18,i)
       else if( trim(dtype) == '  t') then
          dwork(nn,15)=rdiag(17,i)             ! observation   
          dwork(nn,16)=rdiag(17,i)-rdiag(18,i) ! background or analysis   
          dq=dwork(nn,15)-dwork(nn,16)

          !rdiag(14,i): prepbufr inverse obs error, !rdiag(15,i):read_prepbufr inverse obs error
          write(unit=12,FMT="(a10,i9,i13,3f16.8,f16.2,2f9.1,4f25.6,3f16.8)") &
                             &trim(dtype),itype,stype,dwork(nn,2),dwork(nn,3),dwork(nn,5),dwork(nn,7),dwork(nn,10),dwork(nn,8),&
                             &dwork(nn,12),1.0/rdiag(14,i),1.0/rdiag(15,i),1.0/dwork(nn,12),dwork(nn,15),dwork(nn,16),rdiag(18,i)
       endif

    enddo loopi ! end data store loop

    deallocate(cdiag,rdiag)
 enddo loopd ! ending read data do loop


100 ndata=nn
    if(ndata.gt.maxn) then
       print*,'ndata=',ndata
       stop ('too many diag records')
    endif
    close(lunin)

    close(unit=10)
    close(unit=11)
    close(unit=12)
    close(unit=13)

end program
