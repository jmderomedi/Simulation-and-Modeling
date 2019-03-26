%A = imread('hourglass.png');
%A = imread('hourglass_sloped_lines.png');
A = imread('hourglass_blocks.png');

%image(A);
num_row = size(A,1); %Find size of rows of picture
num_col = size(A,2); %Find size of columns of picture

sand_prob = 0.5;     %Probabilty of sand friction
glass_prob = 0.2;    %Probabilty of glass friction
num_turns = 1000;

new_pic = (A(:,:,1) > 0) + (2*(A(:,:,3) > 0)); %Converts .png to easy to use matrix

mov_array = zeros(2,2); %Allocate moving window array

for k = 1: num_turns
    for i = 1: 2:(num_row-1) %first two is stepsize of array
        for j = 1: 2:(num_col-1)
            %[TICK]
            %Fills in the moving window array
            mov_array(1,1) = new_pic(i,j);
            mov_array(1,2) = new_pic(i,j+1);
            mov_array(2,1) = new_pic(i+1,j);
            mov_array(2,2) = new_pic(i+1,j+1);
            
            %1 Top left filled only
            if (mov_array(1,1) == 1 && mov_array(1,2) == 0 && mov_array(2,1) == 0 && mov_array(2,2) == 0)
                new_pic(i,j) = 0; %Set value to zero
                new_pic(i+1,j) = 1; %Set new value to one
                
                %2 top right filled only
            elseif (mov_array(1,1) == 0 && mov_array(1,2) == 1 && mov_array(2,1) == 0 && mov_array(2,2) == 0)
                new_pic(i,j+1) = 0;
                new_pic(i+1,j+1) = 1;
                
                %3 both left are filled
            elseif (mov_array(1,1) == 1 && mov_array(1,2) == 0 && mov_array(2,1) == 1 && mov_array(2,2) == 0)
                new_pic(i,j) = 0;
                new_pic(i+1,j+1) = 1;
                
                %4 Top left and bottom right filled
            elseif (mov_array(1,1) == 1 && mov_array(1,2) == 0 && mov_array(2,1) == 0 && mov_array(2,2) == 1)
                new_pic(i,j) = 0;
                new_pic(i+1,j) = 1;
                
                %5 bottom left and top right filled
            elseif (mov_array(1,1) == 0 && mov_array(1,2) == 1 && mov_array(2,1) == 1 && mov_array(2,2) == 0)
                new_pic(i,j+1) = 0;
                new_pic(i+1,j+1) = 1;
                
                %6 both right are filled
            elseif (mov_array(1,1) == 0 && mov_array(1,2) == 1 && mov_array(2,1) == 0 && mov_array(2,2) == 1)
                new_pic(i,j+1) = 0;
                new_pic(i+1,j) = 1;
                
                %7 All but bottom right are filled
            elseif (mov_array(1,1) == 1 && mov_array(1,2) == 1 && mov_array(2,1) == 1 && mov_array(2,2) == 0)
                new_pic(i,j+1) = 0;
                new_pic(i+1,j+1) = 1;
                
                %8 all but bottom left are filled
            elseif (mov_array(1,1) == 1 && mov_array(1,2) == 1 && mov_array(2,1) == 0 && mov_array(2,2) == 1)
                new_pic(i,j) = 0;
                new_pic(i+1,j) = 1;
                
                %9 both tops are filled
            elseif (mov_array(1,1) == 1 && mov_array(1,2) == 1 && mov_array(2,1) == 0 && mov_array(2,2) == 0)
                rand_num = rand(1,1);
                if rand_num < sand_prob %both drop down
                    new_pic(i,j) = 0;
                    new_pic(i,j+1) = 0;
                    new_pic(i+1,j) = 1;
                    new_pic(i+1,j+1) = 1;
                end %else nothing happens
                
                %10 glass in bottom right corner with both top filled
              elseif (mov_array(1,1) == 1 && mov_array(1,2) == 1 && mov_array(2,1) == 0 && mov_array(2,2) == 2)
                rand_num = rand(1,1);
                if rand_num < glass_prob %both drop down
                    new_pic(i,j) = 0;
                    new_pic(i+1,j) = 1;
                else
                    new_pic(i,j+1) = 0;
                    new_pic(i+1,j) = 1;
                end %else nothing happens
                
               %11 glass in bottom left corner with both top filled
              elseif (mov_array(1,1) == 1 && mov_array(1,2) == 1 && mov_array(2,1) == 2 && mov_array(2,2) == 0)
                rand_num = rand(1,1);
                if rand_num < glass_prob %straight down first
                    new_pic(i,j+1) = 0;
                    new_pic(i+1,j+1) = 1;
                else
                    new_pic(i,j) = 0;
                    new_pic(i+1,j+1) = 1;
                end %else nothing happens
                
               %12 glass in bottom left corner, top left filled
              elseif (mov_array(1,1) == 1 && mov_array(1,2) == 0 && mov_array(2,1) == 2 && mov_array(2,2) == 0)
                new_pic(i,j) = 0;
                new_pic(i+1,j+1) = 1;
                
               %13 glass in bottom right corner, top right filled
              elseif (mov_array(1,1) == 0 && mov_array(1,2) == 1 && mov_array(2,1) == 0 && mov_array(2,2) == 2)
                new_pic(i,j+1) = 0;
                new_pic(i+1,j) = 1;
            end %End if
        end %End for
    end %End for
    
    for i = 2: 2:(num_row-1) %first two is stepsize, starting off by one
        for j = 2: 2:(num_col-1)
            %[TOCK]
            mov_array(1,1) = new_pic(i,j);
            mov_array(1,2) = new_pic(i,j+1);
            mov_array(2,1) = new_pic(i+1,j);
            mov_array(2,2) = new_pic(i+1,j+1);
            %1 Top left filled only
            if (mov_array(1,1) == 1 && mov_array(1,2) == 0 && mov_array(2,1) == 0 && mov_array(2,2) == 0)
                new_pic(i,j) = 0; %Set value to zero
                new_pic(i+1,j) = 1; %Set new value to one
                
                %2 top right filled only
            elseif (mov_array(1,1) == 0 && mov_array(1,2) == 1 && mov_array(2,1) == 0 && mov_array(2,2) == 0)
                new_pic(i,j+1) = 0;
                new_pic(i+1,j+1) = 1;
                
                %3 both left are filled
            elseif (mov_array(1,1) == 1 && mov_array(1,2) == 0 && mov_array(2,1) == 1 && mov_array(2,2) == 0)
                new_pic(i,j) = 0;
                new_pic(i+1,j+1) = 1;
                
                %4 Top left and bottom right filled
            elseif (mov_array(1,1) == 1 && mov_array(1,2) == 0 && mov_array(2,1) == 0 && mov_array(2,2) == 1)
                new_pic(i,j) = 0;
                new_pic(i+1,j) = 1;
                
                %5 bottom left and top right filled
            elseif (mov_array(1,1) == 0 && mov_array(1,2) == 1 && mov_array(2,1) == 1 && mov_array(2,2) == 0)
                new_pic(i,j+1) = 0;
                new_pic(i+1,j+1) = 1;
                
                %6 both right are filled
            elseif (mov_array(1,1) == 0 && mov_array(1,2) == 1 && mov_array(2,1) == 0 && mov_array(2,2) == 1)
                new_pic(i,j+1) = 0;
                new_pic(i+1,j) = 1;
                
                %7 All but bottom right are filled
            elseif (mov_array(1,1) == 1 && mov_array(1,2) == 1 && mov_array(2,1) == 1 && mov_array(2,2) == 0)
                new_pic(i,j+1) = 0;
                new_pic(i+1,j+1) = 1;
                
                %8 all but bottom left are filled
            elseif (mov_array(1,1) == 1 && mov_array(1,2) == 1 && mov_array(2,1) == 0 && mov_array(2,2) == 1)
                new_pic(i,j) = 0;
                new_pic(i+1,j) = 1;
                
                %9 both tops are filled
            elseif (mov_array(1,1) == 1 && mov_array(1,2) == 1 && mov_array(2,1) == 0 && mov_array(2,2) == 0)
                rand_num = rand(1,1);
                if rand_num < sand_prob %both drop down
                    new_pic(i,j) = 0;
                    new_pic(i,j+1) = 0;
                    new_pic(i+1,j) = 1;
                    new_pic(i+1,j+1) = 1;
                end %else nothing happens
                
                %10 glass in bottom right corner with both top filled
              elseif (mov_array(1,1) == 1 && mov_array(1,2) == 1 && mov_array(2,1) == 0 && mov_array(2,2) == 2)
                rand_num = rand(1,1);
                if rand_num < glass_prob %both drop down
                    new_pic(i,j) = 0;
                    new_pic(i+1,j) = 1;
                else
                    new_pic(i,j+1) = 0;
                    new_pic(i+1,j) = 1;
                end %else nothing happens
                
               %11 glass in bottom left corner with both top filled
              elseif (mov_array(1,1) == 1 && mov_array(1,2) == 1 && mov_array(2,1) == 2 && mov_array(2,2) == 0)
                rand_num = rand(1,1);
                if rand_num < glass_prob %straight down first
                    new_pic(i,j+1) = 0;
                    new_pic(i+1,j+1) = 1;
                else
                    new_pic(i,j) = 0;
                    new_pic(i+1,j+1) = 1;
                end %else nothing happens
                
               %12 glass in bottom left corner, top left filled
              elseif (mov_array(1,1) == 1 && mov_array(1,2) == 0 && mov_array(2,1) == 2 && mov_array(2,2) == 0)
                new_pic(i,j) = 0;
                new_pic(i+1,j+1) = 1;
                
               %13 glass in bottom right corner, top right filled
              elseif (mov_array(1,1) == 0 && mov_array(1,2) == 1 && mov_array(2,1) == 0 && mov_array(2,2) == 2)
                new_pic(i,j+1) = 0;
                new_pic(i+1,j) = 1;
                
            end %End if
        end %End for
    end %End for
    imshow(new_pic);
    drawnow;
end
