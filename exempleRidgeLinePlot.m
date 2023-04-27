%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%                          NAME: Ridgelines plot                          %
%                          AUTHOR: PabDawan                               %
%                          DATE: April 2023                               %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Description: Lets try to reproduce the ridgeline plot from Bertron and al. 2022
% Bertron, Y., Bowen, M., Leo, P., Samozino, P., Hintzy, F., & Morel, B. (2022).
% In-situ MMP - cadence relationship for 2- , 5- and 20-min duration : a proof of concept in U19 cyclists.
% September, 1–10. https://doi.org/10.51224/SRXIV.192
clear
close all
clc
%% First we have to make our fake dataset
% data = 14 subjects with 1000 cadence points expressed as % of optimal cadence for 3 different duration
nbSuj = 14;
data = randomData(3,nbSuj);                                                    % randomData(number of conditions,number of participants)

% Copy data vizualisation from Bertron and al.
tiledlayout(1,3,'TileSpacing','compact','Padding','compact')
nexttile
xticks(gca,[80 100 120])
xticklabels(gca,{'80\%' '100\%' '120\%'})
ridgeLinePlot(data{1})
xline(100,'LineStyle','--','LineWidth',1.5)
title('2 min')
ylabel('Relative individual distribution','Interpreter','latex')
xlim([70 130])
nexttile
ridgeLinePlot(data{2})
title('5 min')
xlabel('Cadence(\%$C_{opt}$)')
xticklabels(gca,{'80\%' '100\%' '120\%'})
xlim([70 130])

nexttile
ridgeLinePlot(data{3})
title('20 min')
xticks([80,100,120])
xticklabels(gca,{'80\%' '100\%' '120\%'})
xlim([70 130])


% Want to use your favorite color?
figure
% col = cbrewer('seq','YlOrRd',nbSuj+10);
col =     [1.0000    1.0000    0.8000
    1.0000    0.9765    0.7412
    1.0000    0.9529    0.6824
    1.0000    0.9294    0.6275
    1.0000    0.9059    0.5725
    0.9961    0.8824    0.5176
    0.9961    0.8510    0.4627
    0.9961    0.8078    0.4039
    0.9961    0.7529    0.3412
    0.9961    0.6980    0.2980
    0.9961    0.6549    0.2745
    0.9922    0.6118    0.2549
    0.9922    0.5529    0.2353
    0.9922    0.4353    0.2000
    0.9882    0.3059    0.1647
    0.9686    0.2235    0.1412
    0.9333    0.1569    0.1176
    0.8902    0.1020    0.1098
    0.8471    0.0549    0.1216
    0.8000    0.0157    0.1373
    0.7412         0    0.1490
    0.6745         0    0.1490
    0.5922         0    0.1490
    0.5020         0    0.1490];

ridgeLinePlot(data{1},col(4:end,:))

% lets improve plot aesthetics
h2 = findall(groot,'Type','figure');
arrayfun(@aesthete,h2)
% exportgraphics(h2(2),'gitHub_Exemple_RidgeLinePlot.png','Resolution','600')

movegui(gcf,'east')
% Function to change plot appearance
function aesthete(h2)
    hfig= h2;  
    picturewidth = 20; 
    hw_ratio = 1.1; 
    set(findall(hfig,'-property','FontSize'),'FontSize',17)
    set(findall(hfig,'-property','Box'),'Box','off') 
    set(findall(hfig,'-property','Interpreter'),'Interpreter','latex')
    set(findall(hfig,'-property','TickLabelInterpreter'),'TickLabelInterpreter','latex')
    set(hfig,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth])
    pos = get(hfig,'Position');
    set(hfig,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
end

% Function to create some fake data
function dataRandom = randomData(nbDataSet,numSuj)
dataRandom = cell(1,nbDataSet);
for i = 2:nbDataSet+1
    rng(i)  % for reproducibility
    data = zeros(1000,numSuj);
    for someCounter = 1:numSuj
        sDeviation = 4+i;
        average = 87+someCounter+i*2;
        data(:,someCounter) = sDeviation.*randn(1000,1) + average;
    end
    dataRandom{i-1} = data(:,randperm(width(data)));
end

end



