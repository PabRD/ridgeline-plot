function ridgeLinePlot(data,colorMatrix)
% Quick function to visualize ridgelines plot with data distribution for
% each participants and median as lines
%
%   RIDGELINEPLOT(data) plot a ridgeline plot with default color using parula
%   palette. data must be a n by m matrix with n=observations and
%   m=participants
%
%   RIDGELINEPLOT(data,colorMatrix) specifies your own color with a n by 3
%   palette. n must be equal to the number of participants
%   ALSO SEE https://www.data-to-viz.com/graph/ridgeline.html
%
% @MatPab

if nargin>1
    colMat = colorMatrix;
else
    colMat = parula(width(data));
end
col = mat2cell(colMat,ones(width(data),1));


medianData = median(data);
[~,orderMedian] = sort(medianData);
sortedMedian = medianData(orderMedian);
data = data(:,orderMedian);
% dataN = normalize(data,'range');
offset = .3;
step = 1 - offset;
horizontalPos = 0:step:width(data)*step-step;
hold on
% lets plot horizontal lines
arrayfun(@(x) plot([0 1000],[x x],'k','LineWidth',.5),horizontalPos)


% now, prepare data for distribution display
[f,xi] = arrayfun(@(x) ksdensity(data(:,x)),1:width(data),'uni',0);
f = cellfun(@(x) normalize(x,'range'),f,'uni',0);
f = cellfun(@(x,y) x+y,f,fliplr(num2cell(horizontalPos)),'uni',0);

% plot medians
% fMedian = reshape(cell2mat(f),[],14);
% xiMedian = reshape(cell2mat(xi),[],14);
posMedian = cellfun(@(x,y,z) interp1(x,y,z),xi,f,num2cell(sortedMedian));
posMedian = posMedian - fliplr(horizontalPos);

posMedianDef = [fliplr(horizontalPos); fliplr(horizontalPos)+posMedian];
plot([sortedMedian; sortedMedian],posMedianDef)

xMedians = repmat(sortedMedian,2,1);
yMedians = posMedianDef;
medianHandle = plot(fliplr(xMedians),fliplr(yMedians));

colMedian = flipud(colMat);
arrayfun(@(x,y) set(x,'LineStyle','-','LineWidth',2,'Color',colMedian(y,:)),medianHandle,(1:width(data))')
yticklabels([])

% patch violin
cellfun(@(x,y,z) patch(x,y,z,'facealpha',0.5),xi,f,col');

xlim([min(data,[],'all') max(data,[],'all')])
ylim([min(horizontalPos) max(horizontalPos)+1.3])
yticks([])

% Text with particpant number
numParticipant = cellstr(strcat('\#',num2str(orderMedian')));
numParticipant = regexprep(numParticipant, ' ', '');

xText = repmat(min(data,[],'all')+0.5,1,width(data));
text(xText,horizontalPos+0.3,numParticipant,'interpreter','latex')

end
