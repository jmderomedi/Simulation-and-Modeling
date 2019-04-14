%Gas Lattice Simulation
%A 'gas' particle moves in one of four directions
%If two or more particles occupy a single cell it is seen as a collision
%They bounce off each other
%Same in regards to walls, which are the edges of the imported PNG
%To fix the issue of the order particles are updated, two matrix's are used
    %One for the updates then it is saved to a second then displayed
    %This will give the impression that it was updated at once

%Alex Meves
%James Deromedi
%

gas_space_size = 100; %Matrix Size
gas_space = zeros(gas_space_size+1,gas_space_size+1,6);
%Page 1  = North Direction 
%Page 2  = East Directions
%Page 3  = South Direction
%Page 4  = West Direction 
%Page 5  = Wall  

gas_space([1,gas_space_size+1],:,5) = 1;
gas_space(:,[1,gas_space_size+1],5) = 1; 
empty_walled = gas_space; % Create walled matrix
%rng(60); %Testing
turns = 10000;
%pause('on'); %Testing
pressure_image = imread('D:\American Work\2019 Spring\Simulations and Modeling\Homework\Project 2\Pressure_wave_3.png');
%Read in the .PNG file and assign directions to the particles by color
%White -> West
%Red -> North
%Green -> East
%Blue -> South
for i = 1:100
    for j = 1:100
        if pressure_image(i,j,1) == 255 && pressure_image(i,j,2)==255 && pressure_image(i,j,3)==255
            gas_space(i,j,4) = 1; 
        elseif pressure_image(i,j,1)== 255 %If Red
            gas_space(i,j,1) = 1; 
        elseif pressure_image(i,j,2) == 255 %If Green
            gas_space(i,j,2) = 1; 
        elseif pressure_image(i,j,3) == 255 %If Blue
            gas_space(i,j,3) = 1; 
        end
    end
end

%Step through the number of turns
for i=1:turns
    new_gas_space = empty_walled; %Create empty matrix that will be filled after
    %gas_space(2,2,randi(4))= 1;   %Testing
    %gas_space(50,50,randi(4))= 1; %Testing
    %gas_space(100,100,randi(4))= 1; %Testing
    
    for j = (1:gas_space_size+1)
        for k = (1:gas_space_size+1)
            %Particle Collision Detection=================================
            %Two particle collision=======================================
            if sum(gas_space(j,k,1:4)) > 1 %Check if more than one particle exists
                
                if gas_space(j,k,1) == 1 %North moving
                    gas_space(j,k,1) = 0;
                    try
                        new_gas_space(j,k+1,2) = 1; %Change it to East
                    catch
                        new_gas_space(j,k,2) = 1;
                    end
                end
                if gas_space(j,k,2) == 1 %East moving
                    gas_space(j,k,2) = 0;
                    try
                        new_gas_space(j+1,k,1) = 1; %Change it to North
                    catch
                        new_gas_space(j,k,1)= 1; 
                    end
                end 
                if gas_space(j,k,3) == 1 %South moving
                    gas_space(j,k,3) = 0;
                    try
                        new_gas_space(j,k-1,4) = 1; %Change it to West
                    catch
                        new_gas_space(j,k,4) = 1;
                    end
                end
                if gas_space(j,k,4) == 1 %West moving
                    gas_space(j,k,4) = 0;
                    try
                        new_gas_space(j-1,k,3) = 1; %Change it to North
                    catch
                        new_gas_space(j,k,3) = 1;
                    end
                end
            end 
            
            %Wall Collision Detection=====================================
            %=============================================================
            if gas_space(j,k,1) == 1 && gas_space(j,k,5) == 1 %North Wall 
                gas_space(j,k,1) = 0;
                new_gas_space(j+1,k,3) = 1; 
            end
            if gas_space(j,k,2) == 1 && gas_space(j,k,5) == 1 %East Wall 
                gas_space(j,k,2) = 0; 
                new_gas_space(j,k-1,4) = 1; 
            end
            if gas_space(j,k,3) == 1 && gas_space(j,k,5) == 1 %South Wall 
                gas_space(j,k,3) = 0; 
                try
                    new_gas_space(j-1,k,1) = 1; 
                catch 
                    new_gas_space(j,k,1) = 1;
                end
            end 
            if gas_space(j,k,4) == 1 && gas_space(j,k,5) == 1 %West Wall 
                gas_space(j,k,4) = 0; 
                new_gas_space(j,k+1,2) = 1; 
            end 
            
            %Normal Movements============================================
            %============================================================
            if gas_space(j,k,1) == 1 %Northward 
                gas_space(j,k,1) = 0;
                try
                    new_gas_space(j-1,k,1) = 1; 
                catch 
                    new_gas_space(j,k,1) = 1; 
                end
            end
            if gas_space(j,k,2) == 1 %Eastward
                gas_space(j,k,2) = 0; 
                new_gas_space(j,k+1,2) = 1; 
            end
            if gas_space(j,k,3) == 1 %Southward
                gas_space(j,k,3) = 0; 
                new_gas_space(j+1,k,3) = 1; 
            end
            if gas_space(j,k,4) == 1 %Westward
                gas_space(j,k,4) = 0; 
                new_gas_space(j,k-1,4) = 1; 
            end 
        end 
    end
    gas_space = new_gas_space; %Update the old matrix with all the new moves
    hIm = imshow(gas_space(:,:,1)|gas_space(:,:,2)| gas_space(:,:,3)|gas_space(:,:,4));
end

        
    


