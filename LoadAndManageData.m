function [TrainData,TestData] = LoadAndManageData(name)
%% Load Data


data = importdata(['DataSets\',name]);
if isstruct(data)
data = data.data;
end
Inputs = data(:,1:end-1);
%% finding Nan elements
Targets = data(:,end);
% Inputs = knnimpute(Inputs);

NSamples = size(Inputs,1);

%% Normalaization

%Inputs = Normalaization(Inputs);
%Targets = Normalaization(Targets);

%% Test and Train Data
rng(0);
TrPercent = 80;
TrNum = round(NSamples * TrPercent / 100);

  R = randperm(NSamples);
%  
  trIndex = R(1 : TrNum);
%  tsIndex = R(1+TrNum : end);
% 
 TrainData.Inputs = Inputs(trIndex,:);
 TrainData.Targets = Targets(trIndex,:);

 %TestData.Inputs = Inputs(tsIndex,:);
 %TestData.Targets = Targets(tsIndex,:);
 %TrainData.Inputs = Inputs(1:TrNum,:);
 %TrainData.Targets=Targets(1:TrNum);
 TestData.Inputs =Inputs(TrNum+1:end,:);
 TestData.Targets =Targets(TrNum+1:end);
end

% function X = Normalaization(X)
% 
% Min = min(X);
% Max = max(X);
% 
% for i = 1:numel(Min)
%     
%    X(:,i) = 2*(X(:,i) -Min(i))/(Max(i) - Min(i))-1 ; 
%     
% end
% 
% end