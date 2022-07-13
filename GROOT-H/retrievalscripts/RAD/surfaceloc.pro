PRO surfaceloc, date
read_diags, 'path', $
	obsdata, metadata, swap_endian=1
cenlon=metadata.cenlon
cenlat=metadata.cenlat
qc_flag=obsdata.qc_flag
dims=size(qc_flag, /dimensions)
openw, lun, 'qcflags_'+strtrim(date,2)+'.txt', /get_lun
for i=0,dims[1]-1 do for j=0,dims[0]-1 do printf, lun, cenlat[i], cenlon[i], j+1, qc_flag[j,i]
close, lun
print, 'file created'
END
