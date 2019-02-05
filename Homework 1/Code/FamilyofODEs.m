a = 2;
b = 2;
tspan = [0 10];

for i = -a: a
    for j = -b: b
    [t,x] = ode45(@(t,x) -1*power(x,3) + i*x - j, tspan, linspace(-4,4,10));
    %[t,x] = ode45(@(t,x) -1*power(x,3) + i*x - j, tspan, [0 2]);
    hold on;
    plot(t,x);
    hold off;
    end
end

