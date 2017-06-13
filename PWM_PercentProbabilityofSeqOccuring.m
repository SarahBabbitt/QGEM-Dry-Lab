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


i = 1; %rows
j = 1; %columns
acount = 0;
ccount = 0;
gcount = 0;
tcount = 0;

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

acount = 0;
ccount = 0;
gcount = 0;
tcount = 0;
end


% Position Probability Matrix 
PPM = zeros(4,35);
i = 1;
j = 1;

for i = 1:4; 
    for j = 1:35; 
        freq = PFM(i,j);
        prob = freq/20;
        PPM(i,j) = prob;
    end
end


%Now we can calculate the probabilty of a sequence given the PPM :) 
%pseudocount = sum of prob for row / number of terms 
prompt = 'Which Anderson Promoter would you like to evaluate? \n';
sequence = input(prompt);

k = 1;  %used to go through each letter (35) of the sequence 
proda = 0;
prodc = 0;
prog = 0;
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
        prog = prog + numbg;
    elseif sequence(k) == 't' 
        numbt = PPM(4,k);
        prodt = prodt + numbt;
    end
    
sum = proda + prodc + prog + prodt;
end

pseudocount = sum/35;
PPM(PPM == 0) = pseudocount;
PPM

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

fprintf("The probability of %s occuring is %2.2f percent \n", sequence, probability)
probability

        
