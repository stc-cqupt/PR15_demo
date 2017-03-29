function out= extract_features(Gray, patternMapping,GFlag, LFlag, GR, LR, F, ratio)


Base=[9 3 1]';
nBase=27;
     
%% ==================Gradient channel======================
     [G1 G2 G3] = compute_gradient(Gray,F);

% ternary quantization
     [Gcode1] = triVal_quanti(G1, ratio);
     [Gcode2] = triVal_quanti(G2, ratio);
     [Gcode3] = triVal_quanti(G3, ratio);    
% ternary coding
     Gcode=[Gcode1(:) Gcode2(:) Gcode3(:)]*Base;
     Gcode=reshape(Gcode,size(G1));
% local frequency feature extraction      
     if GFlag ==1
         G=G1;
     elseif GFlag ==2
         G=G2;
     else
         G=G3;
     end
     [LBP1 Frefeat1 CoefNums1]= Frefeature_lbp(G,GR,8*GR,patternMapping{GR},'x'); % G1,G2    
     Gcode_HybridMap=Gcode(GR+1:end-GR,GR+1:end-GR); %频率域 采样点对齐！！
     
%% ====================LOG channel======================
     [L1 L2 L3] = compute_LOG(Gray,F);
% ternary quantization
     [Lcode1] = triVal_quanti(L1);
     [Lcode2] = triVal_quanti(L2);
     [Lcode3] = triVal_quanti(L3);     
% ternary coding
     Lcode=[Lcode1(:) Lcode2(:) Lcode3(:)]*Base;
     Lcode=reshape(Lcode,size(L1));
% local frequency feature extraction       
     if LFlag ==1
         L=L1;
     elseif LFlag ==2
         L=L2;
     else
         L=L3;
     end
     [LBP2 Frefeat2 CoefNums2] = Frefeature_lbp(L,LR,8*LR,patternMapping{LR},'x'); % G1,G2 好   
     Lcode_HybridMap = Lcode(LR+1:end-LR,LR+1:end-LR); %频率域 采样点对齐！！     

%% ===============histogram=======================
         Hist3D1 = hist3([Gcode_HybridMap(:),Frefeat1(:)],{0:nBase-1,0:2^CoefNums1-1});
         Hist3D2 = hist3([Lcode_HybridMap(:),Frefeat2(:)],{0:nBase-1,0:2^CoefNums2-1});
         
         out = [reshape(Hist3D1,1,numel(Hist3D1)) reshape(Hist3D2,1,numel(Hist3D2))];
         out=out';