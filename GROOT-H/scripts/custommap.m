function mycolormap = custommap(m,mycmap)
cindex = linspace(1,size(mycmap,1),m);
r = interp1([1:size(mycmap,1)],mycmap(:,1),cindex);
g = interp1([1:size(mycmap,1)],mycmap(:,2),cindex);
b = interp1([1:size(mycmap,1)],mycmap(:,3),cindex);
mycolormap = [r' g' b'];