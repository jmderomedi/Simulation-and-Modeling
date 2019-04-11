%Gas Lattice Simulation 



% matrix for space of gas. 
gas_space_size = 100; % size of matrix
gas_space = zeros(gas_space_size+1,gas_space_size+1,6);
%Page 1  = North Direction 
%Page 2  = East Directions
%Page 3  = South Direction
%Page 4  = West Direction 
%Page 5  = Wall  
%Page 6  = Collisions 
%Drawing walls on four sides 

gas_space([1,gas_space_size+1],:,5) = 1; 
gas_space(:,[1,gas_space_size+1],5) = 1; 
empty_walled = gas_space; % Create walled matrix
rng(60); 
turns = 1000; 
pause('on');
pressure_image = imread('D:\American Work\2019 Spring\Simulations and Modeling\Homework\Project 2\Pressure_wave_3.png');
for i = 1:100
    for j = 1:100
        if pressure_image(i,j,1) == 255 && pressure_image(i,j,2)==255 && pressure_image(i,j,3)==255
            gas_space(i,j,4) = 1; 
        elseif pressure_image(i,j,1)== 255
            gas_space(i,j,1) = 1; 
        elseif pressure_image(i,j,2) == 255
            gas_space(i,j,2) = 1; 
        elseif pressure_image(i,j,3) == 255 
            gas_space(i,j,3) = 1; 
        end
     
    
    end
end
for i=1:turns
    new_gas_space = empty_walled; 
    %gas_space(2,2,randi(4))= 1;   %Source at origin point (NW)
    %gas_space(50,50,randi(4))= 1; %Source at midpoint 
    %gas_space(100,100,randi(4))= 1; %Source at south-east point
    for j = (1:gas_space_size+1)
        for k = (1:gas_space_size+1)
            %Particle Collision Detection
            %Two particle collision
            if sum(gas_space(j,k,1:4)) > 1
                if gas_space(j,k,1) == 1
                    gas_space(j,k,1) = 0;
                    new_gas_space(j+1,k,3) = 1; 
                end 
                if gas_space(j,k,2) == 1
                    gas_space(j,k,2) = 0;
                    try
                        new_gas_space(j,k-1,4) = 1;
                    catch
                        new_gas_space(j,k,4)=1; 
                    end
                end 
                if gas_space(j,k,3) == 1
                    gas_space(j,k,3) = 0;
                    try
                        new_gas_space(j-1,k,3) = 1;
                    catch
                        new_gas_space(j,k,3) = 1;
                    end
                end
                if gas_space(j,k,4) == 1
                    gas_space(j,k,4) = 0;
                    new_gas_space(j,k+1,4) = 1; 
                end
            end 
            %Wall Collision Detection
            %North Wall 
            if gas_space(j,k,1) == 1 && gas_space(j,k,5) == 1
                gas_space(j,k,1) = 0;
                new_gas_space(j+1,k,3) = 1; 
            end
            %East Wall 
            if gas_space(j,k,2) == 1 && gas_space(j,k,5) == 1
                gas_space(j,k,2) = 0; 
                new_gas_space(j,k-1,4) = 1; 
            end
            %South Wall 
            if gas_space(j,k,3) == 1 && gas_space(j,k,5) == 1
                gas_space(j,k,3) = 0; 
                try
                    new_gas_space(j-1,k,1) = 1; 
                catch 
                    new_gas_space(j,k,1) = 1;
                end
            end 
            %West Wall 
            if gas_space(j,k,4) == 1 && gas_space(j,k,5) == 1
                gas_space(j,k,4) = 0; 
                new_gas_space(j,k+1,2) = 1; 
            end 
            %Movement 
            %Northward 
            if gas_space(j,k,1) == 1
                gas_space(j,k,1) = 0;
                try
                    new_gas_space(j-1,k,1) = 1; 
                catch 
                    new_gas_space(j,k,1) = 1; 
                end
            end
            %Eastward
            if gas_space(j,k,2) == 1
                gas_space(j,k,2) = 0; 
                new_gas_space(j,k+1,2) = 1; 
            end
            %Southward
            if gas_space(j,k,3) == 1
                gas_space(j,k,3) = 0; 
                new_gas_space(j+1,k,3) = 1; 
            end
            %Westward
            if gas_space(j,k,4) == 1
                gas_space(j,k,4) = 0; 
                new_gas_space(j,k-1,4) = 1; 
            end 
        end 
    end
    gas_space = new_gas_space; 
    %hFig = figure('Toolbar','none',...
              %'Menubar','none');
    hIm = imshow(gas_space(:,:,1)|gas_space(:,:,2)| gas_space(:,:,3)|gas_space(:,:,4));
    %truesize([300 300])
    %hSP = imscrollpanel(hFig,hIm); 
    %pause(0.2);
end

        
    


