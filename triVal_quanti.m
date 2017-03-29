function   Gcode = triVal_quanti(G,ratio)
     if nargin==2 % all + +
         thr=[1+ratio,1-ratio]*mean2(G);
         
         Gcode=ones(size(G));
         Gcode(G>thr(1))=2;
         Gcode(G<thr(2))=0;
     else % + -
         thr1=mean2(G(G>0));
         thr2=mean2(G(G<0));

         Gcode=ones(size(G));
         Gcode(G>thr1)=2;
         Gcode(G<thr2)=0;
     end
     