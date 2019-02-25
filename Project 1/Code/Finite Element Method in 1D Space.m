%F = -kx > Hookes Law
%Number of springs
%Length of springs
%Total length
%Mass, n, is at resting position, x, (LengthSpring * n)
num_masses = 5;
total_length = 20;
delta_time = 0.01;
num_steps = 999;
spring_constant = 2;
spring_length = (total_length / num_masses) + 2;
mass_position = (zeros(num_masses, num_steps));