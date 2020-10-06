function ff = scatter_with_trend(x,y)
    % Plot Scatter Plot 
    mdl = fitlm(x,y);
    [~,pi] = predict(mdl,x,'Prediction','observation');
    
    ff=gcf;
    hold on
    h = plot(mdl);
    
    % Data properties 
    h(1).Color = 'black';
    h(1).Marker = '.';
    h(1).MarkerSize = 3;
    
    % Trendline properties 
    h(2).Color = 'black';
    h(2).LineStyle = '-';
    
    %Confidence band properties 
    h(3).Color = [0.75 0.75 0.75];
    h(3).LineStyle = '-';
    patch([h(3).XData fliplr(h(2).XData)],[h(3).YData fliplr(h(2).YData)],[0.75 0.75 0.75],'FaceAlpha',0.5,'EdgeColor',[0.75 0.75 0.75])
    
    h(4).Color = [0.75 0.75 0.75];
    h(4).LineStyle = '-';
    patch([h(4).XData fliplr(h(2).XData)],[h(4).YData fliplr(h(2).YData)],[0.75 0.75 0.75],'FaceAlpha',0.5,'EdgeColor',[0.75 0.75 0.75])
    
    % Prediction Limits 
    PL = plot(x,pi,':','Color',[0.50 0.50 0.50],'Linewidth',0.5);
    
    axesHandles = findall(ff,'type','axes');
    get(axesHandles,'position'); 
    
    % Observations, parameters, Error DF, MSE, R-square, Adjusted R-square
%     axesHandles.Position = [0.1 0.11 0.65 0.815];
%     observations = mdl.NumObservations;
%     parameters = size(mdl.Variables,2);
%     ErrorDF = mdl.DFE;
%     MSE = mdl.MSE;
%     Rsquare = mdl.Rsquared.Ordinary;
%     ARsquare = mdl.Rsquared.Adjusted;
% 
%     str(1) = {sprintf('Observations   %d',observations)}; 
%     str(2) = {sprintf('Parameters      %d',parameters)};
%     str(3) = {sprintf('Error DF        %d',ErrorDF)};
%     str(3) = {sprintf('MSE                %.2f',MSE)};
%     str(4) = {sprintf('R-Square         %.4f',Rsquare)};
%     str(5) = {sprintf('Adj R-Square   %.3f',ARsquare)};
% 
%     XL = get(gca,'XLim');
%     YL = get(gca,'YLim'); 
%     text(XL(2)+(XL(2)-XL(1))/50,median(YL),str,'outside','visible','on');
    
    % Legend
    % lgd = legend([h(2) h(3) PL(1)],'Fit','95% Confidence Limits','95% Prediction Limits','Location','southoutside');
    % lgd.NumColumns = 3;

    hold off 
    
end