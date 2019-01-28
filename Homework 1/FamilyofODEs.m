a = 10;
b = 0;
tspan = 0:20;

for i = -a: a
    for j = -b: b
    [t,x] = ode45(@(t,x) -1*power(x,3) + i*x - j, tspan, linspace(-2,2,4));
    hold on;
    plot(t,x);
    hold off;
    end
end

