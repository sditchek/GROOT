% GET ID
tmpnm0=dir(identgrootpr);
tmpnm={tmpnm0.name};
tmpnm=tmpnm(3:end);
for i=1:size(tmpnm,2)
	tmpuni=tmpnm{i};
	tmpunique(i,:)=tmpuni(1:9);
end
tmpunique=unique(tmpunique,'rows');
% GET NAME
 for stmdn=1:size(tmpunique,1)   %GROOT-G Change Start
	identtmp1=tmpunique(stmdn,1:4);
	identtmp2=tmpunique(stmdn,6:9);
	identtmp3=identtmp1(3:4);
	if strcmp(identtmp3,'AL')==1
		identtmp4='l';
	elseif strcmp(identtmp3,'EP')==1
		identtmp4='e';
	elseif strcmp(identtmp3,'WP')==1
		identtmp4='w';
	elseif strcmp(identtmp3,'CP')==1
		identtmp4='c';
	end
	addpath([identout,'scripts/']);
	identbdecks=[identout,'bdeck/'];
	filename = [identbdecks,'b',lower(identtmp1(3:4)),identtmp1(1:2),identtmp2,'.dat']
	isfile(filename)
	if isfile(filename)==1; 
		[identhemi,DATEall,BASINall,NAMEall,CATall,LATall,POall,SE50all,LONall,PRESSall,SE64all,NE34all,RAD34all,SPEEDall,NE50all,RAD50all,SW34all,NE64all,RAD64all,SW50all,NW34all,RMWall,SW64all,NW50all,ROall,NW64all,SE34all,FHRall]=atcf(filename,1);
		identn=unique(NAMEall,'rows','stable');
		identn=identn(end,:);
		identn=identn(isletter(identn));
		ident=[identtmp1(3:4),identtmp1(1:2),identtmp2];      % basin, ID, and year (e.g., AL092016)
		identn=[identn,identtmp2(3:4)];                       % NAMEYY (e.g., HERMINE16)
		identhwrf{stmdn,:}=[lower(identn(1:end-2)),lower(identtmp1(1:2)),lower(identtmp4),'.',identtmp2];
		if strcmp(identtmp1(1),'9')==1; 
			identn=[identn(1:6) upper(identtmp1),identtmp2(3:4)];
		end 
	end;
end
% RENAME FILES
fid = fopen([identout,'tclookup.txt'],'wt');
for id=1:size(identhwrf,1)
	tcl=['rename ',tmpunique(id,:),' ',identhwrf{id},' *'] 
	fprintf(fid,'%s\n',tcl);
end
fclose(fid);
