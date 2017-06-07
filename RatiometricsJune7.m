clear all; clc;

%data imported from excel
filename = 'examplelibrary.xlsx';
numdata = xlsread(filename);
numdata(:);

%a 1D array of Anderson promoter strengths (from excel) (relative units) 
AndersonPromoterStrengths = numdata(1:end, 1);
%a 1D array of AFP8 RBS strengths (from calculator) (10 fold) 
AFP8RBSStrengths = numdata(1:10, 2);
%a 1D array of SpyTag RBS strengths (from calculator) (10 fold)
SpyTagRBSStrengths = numdata(1:10, 3);

%User inputs 
X1 = 1;  %ratio amount of AFP8
X2 = 5;  %ratio amount of SpyTag
endRatio = X1/X2;

%indeces 
i = 1;  %P1 anderson index of strengths 
j = 1;  %P2 anderson index of strengths
k = 1;  %R1 AFP8 RBS index of ti rates
m = 1;  %R2 SpyTag RBS index of ti rates 

%calculated, to be iterated, amounts of each protein
A = 0;  %AFP8 protein
B = 0;  %SpyTag protein
ratio = A/B;    %want ratio = endRatio 

for i = 1:length(AndersonPromoterStrengths); 
    P1 = AndersonPromoterStrengths(i);  %change first iteration
    R1 = AFP8RBSStrengths(k);   %constant first iteration
    P2 = AndersonPromoterStrengths(j);  %constant first interation
    R2 = SpyTagRBSStrengths(m);     %constant first iteration
    
    A = P1*R1;
    B = P2*R2;
    ratio = A/B;
    
    if ratio == endRatio
        fprintf("The user input ratio of %2.2f or %2.2f has been achieved with P1 = %2.2f, AFP8 RBS strength of %2.2f, P2 = %2.2f, and SpyTag RBS strength of %2.2f. \n", endRatio, ratio, P1, R1, P2, R2)
        break 
    else
        for k = 1:length(AFP8RBSStrengths);
           R1 = AFP8RBSStrengths(k);   %change second iteration
           P2 = AndersonPromoterStrengths(j);  %constant second interation
           R2 = SpyTagRBSStrengths(m);  %constant second iteration
           
           %update
           A = P1*R1;
           B = P2*R2;
           ratio = A/B;
           
            if ratio == endRatio
                fprintf("The user input ratio of %2.2f or %2.2f has been achieved with P1 = %2.2f, AFP8 RBS strength of %2.2f, P2 = %2.2f, and SpyTag RBS strength of %2.2f. \n", endRatio, ratio, P1, R1, P2, R2)
                break 
            else
                for j = 1:length(AndersonPromoterStrengths);
                    P2 = AndersonPromoterStrengths(j);  %change third interation
                    R2 = SpyTagRBSStrengths(m);     %constant third iteration
                    
                    %update
                    A = P1*R1;
                    B = P2*R2;
                    ratio = A/B;
           
                    if ratio == endRatio
                        fprintf("The user input ratio of %2.2f or %2.2f has been achieved with P1 = %2.2f, AFP8 RBS strength of %2.2f, P2 = %2.2f, and SpyTag RBS strength of %2.2f. \n", endRatio, ratio, P1, R1, P2, R2)
                        break
                    else
                        for m = 1:length(SpyTagRBSStrengths);
                            R2 = SpyTagRBSStrengths(m);     %constant third iteration
                            
                            %update
                            A = P1*R1;
                            B = P2*R2;
                            ratio = A/B;
                            
                            if ratio == endRatio
                                fprintf("The user input ratio of %2.2f or %2.2f has been achieved with P1 = %2.2f, AFP8 RBS strength of %2.2f, P2 = %2.2f, and SpyTag RBS strength of %2.2f. \n", endRatio, ratio, P1, R1, P2, R2)
                                break 
                            else
                                Truth = 0;
                            end
                        end
                    end
                end
            end
        end
    end
end

if Truth == 0
    fprintf("The ratio could not be completed. \n")
end                 
                        
                    
                    