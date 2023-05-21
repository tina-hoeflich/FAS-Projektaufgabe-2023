function geregelte_kreisfahrt(EG, Cv, Ch, Fnv, Fnh, kp, ki, L, iS, color)
v = 60 / 3.6;
soll_beschleunigung = linspace(0.2, 10, 50);
model = 'Kreisfahrt_geregelt';
load_system(model);
simIn = Simulink.SimulationInput(model);
simIn = setModelParameter(simIn,...
    'SolverType', 'Fixed-step',...
    'FixedStep', '0.01', ...
    'StartTime', '0',...
    'StopTime', '360');

simIn = setBlockParameter(simIn,"Kreisfahrt_geregelt/Einspurmodell/Reifenkräfte/Cv", "Value",string(Cv));
simIn = setBlockParameter(simIn,"Kreisfahrt_geregelt/Einspurmodell/Reifenkräfte/Ch", "Value",string(Ch));
simIn = setBlockParameter(simIn,"Kreisfahrt_geregelt/Einspurmodell/Reifenkräfte/Fnv","Value",string(Fnv));
simIn = setBlockParameter(simIn,"Kreisfahrt_geregelt/Einspurmodell/Reifenkräfte/Fnh","Value",string(Fnh));

%simIn = setBlockParameter(simIn, "Kreisfahrt_geregelt/Beschleunigung", "OutValues", mat2str(soll_beschleunigung));
simIn = setBlockParameter(simIn, "Kreisfahrt_geregelt/Steuerung", "P", num2str(kp));
simIn = setBlockParameter(simIn, "Kreisfahrt_geregelt/Steuerung", "I", num2str(ki));

out = sim(simIn);
outputs = out.yout;
outputBeschleunigung = getElement(outputs, "ay");
outputDeltaH = getElement(outputs, "deltaH");

x = outputBeschleunigung.Values.Data;
y = outputDeltaH.Values.Data;

plot(x, y, 'Color', color);
hold on

% linear
x = linspace(0, 10, 250);
y = x.' * (L / v.^2 + EG) * iS * 180/pi;
plot(x, y.', '--', 'Color', color);
end