function UpdateAxes2(handles)
%Get the data
TableData = get(handles.DataTable, 'Data');
%get number of samples in box
NumSamples = str2double(get(handles.NumberOfSamples, 'String'));
%get the number of phases
NumInputs = str2double(get(handles.NumberOfPhases, 'String'));

hhh = waitbar(0, 'Computing. Please wait...');
%arrays of individual columns. Doing it this way because that was how i
%originally wrote the code, and its easier to make it compatable with this,
%rather than re-writing every function.
FixedPhaseUnits = zeros(1,NumInputs);
RandErrorUnits =  zeros(1,NumInputs);
PDFTypes        = zeros(1,NumInputs);%1 is uniform, 2 in triangular, 3 is normal
PDFLowerBounds  = zeros(1,NumInputs);
PDFUpperBounds  = zeros(1,NumInputs);
%Output value statistics.
MostProbableValue = 0;
MostProbableValuesProb = 0;
Margin90 = 0;
Margin70 = 0;
Margin50 = 0;
Margin30 = 0;
Average = 0;
LowestValue = 0;
LargestValue = 0;
FixedSum = 0;
%-------------------CODE---------------------
%load Data from table to individual arrays
%get Fixed Unit data, store it in array above.
for i=1:NumInputs
    FixedPhaseUnits(i) = TableData(i,1);
end
%Get upper bound value
for i=1:NumInputs
    PDFUpperBounds(i) = TableData(i,4);
end
%Get lower bound values
for i=1:NumInputs
    PDFLowerBounds(i) = TableData(i,3);
end
%add get type
for i=1:NumInputs
    PDFTypes(i) = TableData(i,2);
end

%-------------------COMPUTATIONS---------------------
%Calculations
%Compute Fixed sum, and set value to textbox.
FixedSumVal = 0;
for i=1:NumInputs
    FixedSumVal = FixedSumVal + FixedPhaseUnits(i);
end
%Compute lower and upper bound sum, and set value to textbox.
UBSumVal = 0;
for i=1:NumInputs
    UBSumVal = UBSumVal + PDFUpperBounds(i);
end

LBSumVal = 0;
for i=1:NumInputs
    LBSumVal = LBSumVal + PDFLowerBounds(i);
end




%Set all computed data to textboxes in computed data panel.


%generate One instance of random error data for each phase. loops (numSamples) ammount of times
%initialize finalData array, and array of PDFs.(doing this lowers time complexity)
FinalData = zeros(1,NumSamples);
for k=1:NumInputs
    if PDFLowerBounds(k) < PDFUpperBounds(k)
        PDFArray(k) = PDFMaker(PDFTypes(k), PDFLowerBounds(k), PDFUpperBounds(k));
    end
end
%gets an array of randomly selected errors pulled from each of their PDFS
for n=1:NumSamples
    %Compute random error values, and set into an array (one time) 
    for k=1:NumInputs
        %asserts that lower bound is less than upper bound
       if PDFLowerBounds(k) < PDFUpperBounds(k)
           pdtemp = PDFArray(k);
           RandErrorUnits(k) = random(pdtemp);
           %If the bounds are equal, it will set the error to that value.
           %else it will set it to 0
       else if PDFLowerBounds(k) == PDFUpperBounds(k)
               RandErrorUnit(k) = PDFLowerBounds(k);
           else
           RandErrorUnit(k) = 0;
           end
       end
    end
    %Sums Together all the error units in RandErrorUnits(), sets to ErrorSum
    ErrorSum = 0;
    for l=1:NumInputs
       ErrorSum = ErrorSum + RandErrorUnits(l); 
    end
    %sets one finalData as sum of fixed plus rand val. 
    FinalData(n) = FixedSumVal + ErrorSum; 
end

LowestValue =FixedSumVal + LBSumVal;%computes lowest possible value
LargestValue = FixedSumVal + UBSumVal;%computes largest possible value
average = median(FinalData);


%Sorts data, sets lowest val, sets highest value, then filters out 70%
%margin and 30% margin?
FinalDataSorted = sort(FinalData, 'ascend');
TempInt = floor(NumSamples*.30);%computes margin data ..... 
MarginData = FinalDataSorted(TempInt);
for j= TempInt+1:NumSamples-TempInt-1
    MarginData = [MarginData, FinalDataSorted(j)]; 
end
Margin30 = min(MarginData);%Sets lower margin
Margin70 = max(MarginData);%Sets upper margin

%Sorts data, sets lowest val, sets highest value, then filters out 90%
%margin and 10% margin?
FinalDataSorted = sort(FinalData, 'ascend');
TempInt = floor(NumSamples*.1);%computes margin data ..... 
MarginData = FinalDataSorted(TempInt);
for j= TempInt+1:NumSamples-TempInt-1
    MarginData = [MarginData, FinalDataSorted(j)]; 
end
Margin10 = min(MarginData);%Sets lower margin
Margin90 = max(MarginData);%Sets upper margin



%Sorts data, sets lowest val, sets highest value, then filters out 50%
FinalDataSorted = sort(FinalData, 'ascend');
TempInt = floor(NumSamples*.50);%computes margin data ..... 
MarginData = FinalDataSorted(TempInt);
for j= TempInt+1:NumSamples-TempInt-1
    MarginData = [MarginData, FinalDataSorted(j)]; 
end
Margin50 = min(MarginData);%Sets lower margin


%For Graphing
BinWidthPercentage = 5;
StepSize = (LargestValue - LowestValue )*(BinWidthPercentage*.01);
MiddleValue = median(FinalData);
LowerXAxisLimit = (((LargestValue - LowestValue) / -2 ) + MiddleValue - StepSize);
UpperXAxisLimit = (((LargestValue - LowestValue) / 2 ) + MiddleValue + StepSize);
AxisValuesRange = LowerXAxisLimit:StepSize:UpperXAxisLimit;

axes(handles.MainAxes);
cla reset
hold on
FinalPDF = pdf(fitdist(FinalData', 'Normal'), AxisValuesRange);
FinalCDF = cdf(fitdist(FinalData', 'Normal'), AxisValuesRange);
%cdfpl = cdfplot(FinalData);
%FinalCDFin = cdf(fitdist(AxisValuesRange', 'Normal'), FinalData);


plot(AxisValuesRange, FinalCDF, 'LineWidth', 2);
line([Margin70, Margin70], [0,.7], 'Color', [.8,0 ,.8]);
line([Margin90, Margin90], [0,.9], 'Color', [.7,.7,0]);
line([Margin50, Margin50], [0,.5], 'Color', [0,.6,.6]);
line([Margin30, Margin30], [0,.3], 'Color', [.5,0,.3]);
line([Margin10, Margin10], [0,.1], 'Color', [.4,.4,0]);
scatter([Margin90, Margin70, Margin50, Margin30,Margin10], [.9, .7,.5,.3, .1], 'LineWidth', 2, 'MarkerFaceColor', [1,0,0], 'MarkerEdgeColor', [1,0,0]);
xlabel('Units');
ylabel('Probability');
title('Cumalative Distribution Function');
grid;

hold off

axes(handles.SideAxes);
cla
histfit(FinalData)
xlabel('Units');
ylabel('Number of samples');
title('Histogram of Randomly Generated Possablities');
datacursormode on;
grid;

MPUOutputProb = max(FinalPDF);
MPUOutput = median(FinalData);


UN90s = strrep(num2str(ceil(Margin90 - FixedSumVal)),'000000000', 'B' );
UN70s = strrep(num2str(ceil(Margin70 - FixedSumVal)),'000000000', 'B' );
UN50s = strrep(num2str(ceil(Margin50 - FixedSumVal)),'000000000', 'B' );
UN30s = strrep(num2str(ceil(Margin30 - FixedSumVal)),'000000000', 'B' );
UN10s = strrep(num2str(ceil(Margin10 - FixedSumVal)),'000000000', 'B' );

FSS = strrep(num2str(ceil(FixedSumVal)),'000000000', 'B' );
LBS = strrep(num2str(ceil(LBSumVal)),'000000000', 'B' );
UBS = strrep(num2str(ceil(UBSumVal)),'000000000', 'B' );
AVG = strrep(num2str(ceil(average)),'000000000', 'B' );



M90s = strrep(num2str(ceil(Margin90)),'000000000', 'B' );
M70s = strrep(num2str(ceil(Margin70)),'000000000', 'B' );
M50s = strrep(num2str(ceil(Margin50)),'000000000', 'B' );
M30s = strrep(num2str(ceil(Margin30)),'000000000', 'B' );
M10s = strrep(num2str(ceil(Margin10)),'000000000', 'B' );
LowV = strrep(num2str(ceil(LowestValue)), '000000000', 'B' );
LargeV = strrep(num2str(ceil(LargestValue)), '000000000', 'B' );

FSS = strrep(FSS,'000000', 'm' );
LBS = strrep(LBS,'000000', 'm' );
UBS = strrep(UBS,'000000', 'm' );
AVG = strrep(AVG,'000000', 'm' );

UN90s = strrep(UN90s,'000000', 'm' );
UN70s = strrep(UN70s,'000000', 'm' );
UN50s = strrep(UN50s,'000000', 'm' );
UN30s = strrep(UN30s,'000000', 'm' );
UN10s = strrep(UN10s,'000000', 'm' );

M90s = strrep(M90s,'000000', 'm' );
M70s = strrep(M70s,'000000', 'm' );
M50s = strrep(M50s,'000000', 'm' );
M30s = strrep(M30s,'000000', 'm' );
M10s = strrep(M10s,'000000', 'm' );
LowV = strrep(LowV,'000000', 'm' );
LargeV = strrep(LargeV,'000000', 'm' );

%FSS = strrep(FSS,'000', 'k' );
%LBS = strrep(LBS,'000', 'k' );
%UBS = strrep(UBS,'000', 'k' );
%AVG = strrep(AVG,'000', 'k' );
%UN90s = strrep(UN90s,'000', 'k' );
%UN70s = strrep(UN70s,'000', 'k' );
%UN50s = strrep(UN50s,'000', 'k' );
%UN30s = strrep(UN30s,'000', 'k' );
%UN10s = strrep(UN10s,'000', 'k' );
%M90s = strrep(M90s,'000', 'k' );
%M70s = strrep(M70s,'000', 'k' );
%M50s = strrep(M50s,'000', 'k' );
%M30s = strrep(M30s,'000', 'k' );
%M10s = strrep(M10s,'000', 'k' );
%LowV = strrep(LowV,'000', 'k' );
%LargeV = strrep(LargeV,'000', 'k' );


%set data
set(handles.MinValue,'String', LowV);
set(handles.MaxValue,'String',LargeV);
set(handles.M90,'String',M90s);
set(handles.M70,'String',M70s);
set(handles.M50,'String',M50s);
set(handles.M30,'String',M30s);
set(handles.M10,'String',M10s);

set(handles.UN90 ,'String',UN90s);
set(handles.UN70,'String',UN70s);
set(handles.UN50,'String',UN50s);
set(handles.UN30,'String',UN30s);
set(handles.UN10,'String',UN10s);


set(handles.LowerBoundSum, 'String', LBS);
set(handles.FixedSum,'String', FSS);
set(handles.UpperBoundSum, 'String', UBS);
set(handles.Average, 'String', AVG);

%set(handles.lowerMargin,'String',LowerMargin);
%set(handles.upperMargin,'String',UpperMargin);
%set(handles.MostProbableUnit, 'String', num2str(MPUOutput));
%set(handles.MostProbableUnitProb, 'String', num2str(MPUOutputProb));
%set(handles.AvgRndErr, 'String', num2str(MPUOutput-FixedSumVal));
close(hhh)


