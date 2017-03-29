% The code is for:
% Exploring space-frequency co-occurrences via local quantized patterns for texture representation. 
% Pattern Recognition 48(8): 2621-2632 (2015),
% Tiecheng Song, Hongliang Li, Fanman Meng, Qingbo Wu, Bing Luo
% tggwin@gmail.com
%==========================================================
close all,clear all,clc
F=Gaussianfilters;
ratio=0.4;
GFlag=3; LFlag=1; % G1 G2 G3
GR=2; LR=2;

                
load('patternMapping.mat')
rootpic = './Outex_TC_00010/';
picNum = 4320;

datadir = 'results';
if exist(datadir,'dir');
else
   mkdir(datadir);
end

tic
for i=1:picNum;
    filename = sprintf('%s//images//%06d.ras', rootpic, i-1);
    display(['..' num2str(i)])
    Gray = imread(filename);
    Gray = im2double(Gray);%

     Hist_feat(i,:) = extract_features(Gray, patternMapping,GFlag, LFlag, GR, LR, F, ratio);

end

trainTxt = sprintf('%s000//train.txt', rootpic);
testTxt = sprintf('%s000//test.txt', rootpic);
[trainIDs, trainClassIDs] = ReadOutexTxt(trainTxt); %trainIDs:1-4320; trainClassIDs: 0-23.
[testIDs, testClassIDs] = ReadOutexTxt(testTxt);

CP = cal_AP(Hist_feat, trainIDs, trainClassIDs, testIDs, testClassIDs)
   
display(['... consuming ' num2str(toc/60) ' mins'])
save(['./results/TC10_G'  num2str(GFlag) 'L' num2str(LFlag) 'R' num2str(GR) num2str(LR)  '.mat'], 'CP');



