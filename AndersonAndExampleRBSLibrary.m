clear all; clc;

%data imported from excel
filename = 'examplelibrary.xlsx';
numdata = xlsread(filename);
numdata(:);

%a 1D array of Anderson promoter strengths (from excel) (relative units) 
promoterStrengths = numdata(1:end, 1);
%a 1D array of RBS strengths (from excel) (made up rn) 
RBSStrengths = numdata(1:end, 2);

j = 1;
X = 5/1; %user input
Truth = 1;

for i = 1:length(promoterStrengths);
    P = promoterStrengths(i);
    R = RBSStrengths(j);
    ratio = P/R;
    if ratio == X
        fprintf("The user input ratio of %2.2f has been achieved with a promoter strength of %2.2f and an RBS strength of %2.2f. \n", ratio, P, R)
        break
    else 
        for j = 1:length(RBSStrengths);
            R = RBSStrengths(j);
            ratio = P/R;
            if ratio == X
                fprintf("The user input ratio of %2.2f has been achieved with a promoter strength of %2.2f and an RBS strength of %2.2f. \n", ratio, P, R)
                break
            else
               Truth = 0;
            end
        end
    end
end

if Truth == 0
    fprintf("The ratio could not be completed. \n")
end

