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


%Creating Position Probability Matrix (PPM)
PPM = zeros(4,35);  %start with an initial matrix of zeros 

%indices reset 
i = 1;  %row
j = 1;  %column 

for i = 1:4; 
    for j = 1:35; 
        freq = PFM(i,j);    %replace the 0 in PFM with freq value 
        prob = freq/20;     %20 Anderson Promoters 
        PPM(i,j) = prob;    %building the PPM 
    end
end


%Now we can calculate the probabilty of a sequence (to occur naturally) given the PPM 

%user selection of promoter to evaluate 
prompt = 'Which Anderson Promoter would you like to evaluate? (ex. BBa_J23100) \n';
sequence = input(prompt);


%%%% NEED TO FIX THIS - A MESSAGE IF TYPE IN SOMETHING WRONG 

% % % for i = 1:20 
% % %     if sequence ~= AndersonMatrix(i)
% % %         fprintf("The user input cannot be read. Please try again")
% % %         prompt = 'Which Anderson Promoter would you like to evaluate? (ex. BBa_J23100) \n';
% % %         sequence = input(prompt);
% % %     else
% % %         continue 
% % %     end
% % % end


k = 1;  %index used to go through each position (35) of the sequence 

%cumulative value of probability of each base occuring
%we multiply these probabilites, as multiplying in the log-space is
%equivalent to the sum 
proda = 0;
prodc = 0;
prodg = 0;
prodt = 0; 

for k  = 1:35; 
    if sequence(k) == 'a' 
        numba = PPM(1,k);
        proda = proda + numba;
    elseif sequence(k) == 'c'
        numbc = PPM(2,k);
        prodc = prodc + numbc;
    elseif sequence(k) == 'g' 
        numbg = PPM(3,k);
        prodg = prodg + numbg;
    elseif sequence(k) == 't' 
        numbt = PPM(4,k);
        prodt = prodt + numbt;
    end
    
sum = proda + prodc + prodg + prodt;
end

%pseudocount = sum of probilities for row / number of terms 
pseudocount = sum/35;
PPM(PPM == 0) = pseudocount;

%Probability of Squence Occuring 
k = 1;  %used to go through each letter (35) of the sequence 
proda = 1;
prodc = 1;
prodg = 1;
prodt = 1; 

for k  = 1:35; 
    if sequence(k) == 'a' 
        numba = PPM(1,k);
        proda = proda * numba;
    elseif sequence(k) == 'c'
        numbc = PPM(2,k);
        prodc = prodc * numbc;
    elseif sequence(k) == 'g' 
        numbg = PPM(3,k);
        prodg = prodg * numbg;
    elseif sequence(k) == 't' 
        numbt = PPM(4,k);
        prodt = prodt * numbt;
    end
    
    product = proda*prodc*prodg*prodt;
    probability = 100*product;
end 

%% Relative Proportionality of Strength 
% probability(user chosen promoter)/probability(consensus) 

consensus = 0.6205;    %the probability of BBa_J23119 occuring (found by running the simulation) 
relativeStrength = probability/consensus;
fprintf("The Anderson promoter with sequence %s, has a %2.5f RPU strength. \n", sequence, relativeStren

        
