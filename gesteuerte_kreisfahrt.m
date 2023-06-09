function gesteuerte_kreisfahrt(EG, Cv, Ch, Fnv, Fnh, L, iS, color)
v = 60 / 3.6;
model = 'gesteuerte_Kreisfahrt';
load_system(model);
simIn = Simulink.SimulationInput(model);
simIn = setModelParameter(simIn,...
    'SolverType', 'Fixed-step',...
    'FixedStep', '0.01', ...
    'StartTime', '0',...
    'StopTime', '360');

simIn = setBlockParameter(simIn,"gesteuerte_Kreisfahrt/Einspurmodell/Reifenkräfte/Cv", "Value",string(Cv));
simIn = setBlockParameter(simIn,"gesteuerte_Kreisfahrt/Einspurmodell/Reifenkräfte/Ch", "Value",string(Ch));
simIn = setBlockParameter(simIn,"gesteuerte_Kreisfahrt/Einspurmodell/Reifenkräfte/Fnv","Value",string(Fnv));
simIn = setBlockParameter(simIn,"gesteuerte_Kreisfahrt/Einspurmodell/Reifenkräfte/Fnh","Value",string(Fnh));

out = sim(simIn);
outputs = out.yout;
outputBeschleunigung = getElement(outputs, "ay");
outputDeltaH = getElement(outputs, "dH");

x = down_sample(outputBeschleunigung.Values.Data);
y = down_sample(outputDeltaH.Values.Data);

plot(x, y, 'Color', color);
hold on

% linear
x = linspace(0, 10, 250);
y = x.' * (L / v.^2 + EG) * iS * 180/pi;
plot(x, y.', '--', 'Color', color);
end