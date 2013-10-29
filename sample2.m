%This script is a sandbox for testing the TrackFeatureGUI
delete(timerfindall); clear all; close all; clear classes;
addpath('circFileBuff');

REVIEW_GREEN_CH=true;

%Get INformation
basefilename='/Users/leifer/Downloads/newstack/newstack';
digits=3;
extension='.tif';

minRange=1;
maxRange=75;

findNeuronsInRed=true;
radiusSmooth=4;



greenChIs1=true;
channelPrefix='' %normally 'c'
findNeuronsInRed=true;
    
    %Load only the red channels
    loadFrame=getLoadFrameHandleWithBuffer(basefilename,extension,...
        channelPrefix,digits,findNeuronsInRed,greenChIs1,...
        minRange,maxRange);
        
    


    
findFeatures=getFindFeatureCandidatesHandle(5,radiusSmooth);




[pointRed,~]=BrightObjectTracker(loadFrame,findFeatures,minRange,maxRange);


