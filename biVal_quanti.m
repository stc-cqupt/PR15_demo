function   Gcode = biVal_quanti(G,x)
% if nargin==1
     thr=mean2(G);
     Gcode=ones(size(G));
     Gcode(G<thr)=0;
% else
%      thr=mean2(G);
%      Gcode=ones(size(G));
%      Gcode(G<thr)=0;
% end