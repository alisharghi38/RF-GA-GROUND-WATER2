function Results = EvaluatePlot(Y,Yhat,name)


yA = mean(Y);
[n,l] =size(Y);
% Mean Squared Error
MSE = mean((Yhat - Y).^2);
%Yavg=(ones(n)*yA);
h= sum((Y-yA).^2);

% R² score, the coefficient of determination
R2 = 1 - ((n*MSE)/h);
% Root Mean Squared Error
RMSE = (mean((Yhat - Y).^2))^0.5;

% Relative Squared Error
% a = sum((ones(size(Y1))*mean(Y1) - Y1).^2);
% if a == 0
% a = 1;
% end
% RSE = sum((Yhat1 - Y1).^2)/a;

% Mean Absolute Error
MAE = mean(abs(Yhat - Y));



% Explained variance score
EVS = 1 - std(Yhat - Y)/std(Y);

% Store Results
Results.Name = [name,' Data'];
Results.RMSE = RMSE;
Results.MSE = MSE;
Results.MAE = MAE;
% Results.RSE = RSE;
Results.Error = Y - Yhat;
Results.R2 = R2;
Results.EVS = EVS;
Results.Yhat = Yhat;

figure;
subplot(2,2,[1 2]),
t = 1:numel(Y);
plot(t,Y,t,Yhat,'--','LineWidth',1.5)
legend('Y-Actual','Y-Predict');
title(['Curve Fitting: for ',name, ' Data'])
subplot(2,2,[3 4]),hist(Y-Yhat,20)
title(['Hist Error, RMSE = ',num2str(RMSE)]);
figure, plotregression(Y,Yhat,'Regression');
 xlabel(['Targets, Regression for ',name,' Data'])

disp(Results);
end
