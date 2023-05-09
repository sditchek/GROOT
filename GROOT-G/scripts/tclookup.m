% GET ID
tmpnm0=dir(identgrootpr);
tmpnm={tmpnm0.name};
tmpnm=tmpnm(3:end);
for i=1:size(tmpnm,2)
	tmpuni=tmpnm{i};
	tmpunique(i,:)=tmpuni(1:8);
end
tmpunique=unique(tmpunique,'rows');
% GET NAME
 for stmdn=1:size(tmpunique,1)   %GROOT-G Change Start
	identtmp1=tmpunique(stmdn,1:3);
	identtmp2=tmpunique(stmdn,5:8);
	identtmp3=identtmp1(3);clear identtmp4;
	if strcmp(identtmp3,'l')==1
		identtmp4='al';
	elseif strcmp(identtmp3,'e')==1
		identtmp4='ep';
	elseif strcmp(identtmp3,'w')==1
		identtmp4='wp';
	elseif strcmp(identtmp3,'c')==1
		identtmp4='cp';
	end
	addpath([identout,'scripts/']);
	identbdecks=[identout,'bdeck/'];
	filename = [identbdecks,'b',lower(identtmp4),identtmp1(1:2),identtmp2,'.dat']
	isfile(filename)
	if isfile(filename)==1; 
		[identhemi,DATEall,BASINall,NAMEall,CATall,LATall,POall,SE50all,LONall,PRESSall,SE64all,NE34all,RAD34all,SPEEDall,NE50all,RAD50all,SW34all,NE64all,RAD64all,SW50all,NW34all,RMWall,SW64all,NW50all,ROall,NW64all,SE34all,FHRall]=atcf(filename,1);
		identn=unique(NAMEall,'rows','stable');
		if sum(isletter(identn(end,:)))==0;identn=identn(end-1,:);else;identn=identn(end,:);end;
		identn=identn(double(identn)>0);
		ident=[identtmp4,identtmp1(1:2),identtmp2];      % basin, ID, and year (e.g., AL092016)
		identn=[identn,identtmp2(3:4)];                       % NAMEYY (e.g., HERMINE16)
		if exist('identtmp4','var')==0;identtmp3=lower(BASINall{:});end;
		identhwrf{stmdn,:}=[lower(identn(1:end-2)),lower(identtmp1(1:2)),lower(identtmp3),'.',identtmp2];	
		if strcmp(identtmp1(1),'9')==1; 
			identhwrf{stmdn,:}=['invest',lower(identtmp1(1:2)),lower(identtmp4),'.',identtmp2];
		end 
	elseif strcmp(identtmp1(1),'9')==1;
		identhwrf{stmdn,:}=['invest',lower(identtmp1(1:2)),lower(identtmp4),'.',identtmp2];
	end;
end
% RENAME FILES
fid = fopen([identout,'tclookup.txt'],'wt');
for id=1:size(identhwrf,1)
	if isempty(identhwrf{id})==1
	else
		tcl=['rename ',tmpunique(id,:),' ',identhwrf{id},' *'] 
		fprintf(fid,'%s\n',tcl);
	end
end
fclose(fid);
