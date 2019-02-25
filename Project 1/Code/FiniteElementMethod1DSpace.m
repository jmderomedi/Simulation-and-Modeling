%Parameters to keep track of:
    %Position of each mass
    %Velocity of each mass
    %Time steps
%Parameters that can be changed
    %Mass of masses: m
%Parameters that are equal
    %Spring length: l
    %Spring constant: K

K= 1;
mass = ones(3,1);
inital = [1 2 3 0 0 1 ];    %Inital conditions
timeSteps = [0 2*pi];

%Update function with inital = [X1 X2 X3 Y1 Y2 Y3]
f = @(t,v) [v(4); v(5); v(6); ...
    (K/mass(1,1))*(v(2)-2*v(1)); ...
    (K/mass(2,1))*v(3)- 2*v(2)+v(1); ...
    (K/mass(3,1))*4 - 2*v(3)+v(2)];

[t,x] = ode45(f, timeSteps, inital);    %Runs the update function with inital parameters
plot(t,x(:,1:3))                        %Plotting only the position of the masses
xlabel('time');                         %Change to x(:,4:6) to print out velocity
ylabel('position'); 