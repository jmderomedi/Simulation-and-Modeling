a = 10;
b = 0;
tspan = 0:20;

for i = 0: a
    [t,x] = ode45(@(t,x) -1*power(x,3) + i*x - b, tspan, linspace(-2,2,4));
    hold on;
    plot(t,x);
    hold off;
end

