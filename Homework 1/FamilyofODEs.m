a = 1;
b = 10;
tspan = 0:20;

for i = -b: b
    [t,x] = ode45(@(t,x) -1*power(x,3) + a*x - i, tspan, linspace(-2,2,4));
    hold on;
    plot(t,x);
    hold off;
end

