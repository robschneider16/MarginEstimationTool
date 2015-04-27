function pd = PDFMaker(type, low, high)
%creates an instance of a PDF with a sepsific type.

%-----------------CODE-----------------
%creates one probability density formula with min, and max values of a and b respectively
a = low; % local min/lower bound for PD
b = high; % local max/upper bound for PD
if type==1
    pd = makedist('Uniform', 'lower', a , 'upper', b);
else if type==2
        pd = makedist('Triangular', 'a', a ,'b', (b+a)/2, 'c', b);
    else
         pd = makedist('Uniform', 'Lower', a, 'upper', b);
    end
end



