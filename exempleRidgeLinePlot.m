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
data = randomData(3,14);                                                    % randomData(number of conditions,number of participants)

% Copy data vizualisation from Bertron and al.
tiledlayout(1,3,'TileSpacing','compact','Padding','compact')
nexttile
xticks(gca,[80 100 120])
xticklabels(gca,{'80\%' '100\%' '120\%'})
ridgeLinePlot(data{1})
xline(100,'LineStyle','--','LineWidth',1.5)
title('2 min')
ylabel('Relative individual distribution','Interpreter','latex')

nexttile
ridgeLinePlot(data{2})
xlabel('Cadence(\%$C_{opt}$)')
nexttile
ridgeLinePlot(data{3})

% Want to use your favorite color?
figure
ridgeLinePlot(data{1},autumn(width(data{1})))

% lets improve plot aesthetics
h2 = findall(groot,'Type','figure');
arrayfun(@aesthete,h2)
% exportgraphics(h2(2),'gitHub_Exemple_RidgeLinePlot.png','Resolution','600')

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



