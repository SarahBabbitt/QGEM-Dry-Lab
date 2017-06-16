clear all; clc; 
% create a character vector by enclosing a sequence of characters with
% single quotation marks 
BBa_J23119 = 'ttgacagctagctcagtcctaggtataatgctagc';
BBa_J23100 = 'ttgacggctagctcagtcctaggtacagtgctagc';
BBa_J23101 = 'tttacagctagctcagtcctaggtattatgctagc';
BBa_J23102 = 'ttgacagctagctcagtcctaggtactgtgctagc';
BBa_J23103 = 'ctgatagctagctcagtcctagggattatgctagc';
BBa_J23104 = 'ttgacagctagctcagtcctaggtattgtgctagc';
BBa_J23105 = 'tttacggctagctcagtcctaggtactatgctagc';
BBa_J23106 = 'tttacggctagctcagtcctaggtatagtgctagc';
BBa_J23107 = 'tttacggctagctcagccctaggtattatgctagc';
BBa_J23108 = 'ctgacagctagctcagtcctaggtataatgctagc';
BBa_J23109 = 'tttacagctagctcagtcctagggactgtgctagc';
BBa_J23110 = 'tttacggctagctcagtcctaggtacaatgctagc';
BBa_J23111 = 'ttgacggctagctcagtcctaggtatagtgctagc';
BBa_J23112 = 'ctgatagctagctcagtcctagggattatgctagc';
BBa_J23113 = 'ctgatggctagctcagtcctagggattatgctagc';
BBa_J23114 = 'tttatggctagctcagtcctaggtacaatgctagc';
BBa_J23115 = 'tttatagctagctcagcccttggtacaatgctagc';
BBa_J23116 = 'ttgacagctagctcagtcctagggactatgctagc';
BBa_J23117 = 'ttgacagctagctcagtcctagggattgtgctagc';
BBa_J23118 = 'ttgacggctagctcagtcctaggtattgtgctagc';

AndersonMatrix = [BBa_J23119; BBa_J23100; BBa_J23101; BBa_J23102; BBa_J23103; BBa_J23104; BBa_J23105; BBa_J23106; BBa_J23107; BBa_J23108; BBa_J23109; BBa_J23110; BBa_J23111; BBa_J23112; BBa_J23113; BBa_J23114; BBa_J23115; BBa_J23116; BBa_J23117; BBa_J23118];
PFM = zeros(4,35);

%indices 
i = 1; %row
j = 1; %column

%running count of frequency of each base in Anderson Promoter Library 
acount = 0;
ccount = 0;
gcount = 0;
tcount = 0;

%Creating a Position Frequency Matrix (PFM)
for j = 1:35
    for i = 1:20
    value = AndersonMatrix(i,j);
    
    if value == 'a';
        acount = acount + 1;
    elseif value == 'c';
        ccount = ccount + 1;
    elseif value == 'g';
        gcount = gcount + 1;
    elseif value == 't';
        tcount = tcount + 1;
    end   
   
    PFM(1,j) = acount;
    PFM(2,j) = ccount;
    PFM(3,j) = gcount;
    PFM(4,j) = tcount;
    
end

%fprintf("In column %2.f, there were %2.f a's, %2.f c's, %2.f g's, and %2.f t's. \n", j, acount, ccount, gcount, tcount)

%reset counts, after each column has been run through
acount = 0;
ccount = 0;
gcount = 0;
tcount = 0;
end

%% Creating PWM 
% convert from PFM using equation log2((f+p*sqrt(N))/(N+sqrt(N)) / (p)
% where,
    %f = PFM(i,j)
    %p = 0.25   - background prob, assume equality
    %N = 20     - sum column

PWM = zeros(4,35);
p = 0.25;
N = 20; 

%indices 
i = 1; %row
j = 1; %column

for i = 1:4 
    for j = 1:35 
        PWM(i,j) = log2(((PFM(i,j)+ p*sqrt(N))/(N + sqrt(N)))/p);
    end
end

consensus = PWM(BBa_J23100);
relativeRPU = PWM(BBa_J23103)/consensus

        

