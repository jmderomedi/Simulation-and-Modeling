num_tries = 9999;
num_points = 1000;
pos = (zeros(num_points, num_tries)) +3;  %Creates array of all '25'

for n = 1: num_tries
    for m = 1: num_points
        if pos(m,n) ~= 0   %If cell is not zero, do math
            pos(m,n+1) = pos(m,n) + 2*(rand(1,1)<=0.5) - 1;
        else
            pos(m,n+1) = 0; %Sets the next cells to zero
        end
    end
end
figure; plot(1:(num_tries+1),pos(1:10,:));

[value, index] = min(pos, [], 2);   %Finds the min values of each row
                                    %and saves the value and index
broke = index(value == 0);          %Saves the indexes of 'bankrupts'
brokemean = mean(broke);            %Finds the mean of indexes
standDev = std(broke);              %Finds the std of indexes
figure; hist(broke)







