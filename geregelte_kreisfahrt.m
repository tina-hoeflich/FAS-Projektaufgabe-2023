function geregelte_kreisfahrt(EG, Cv, Ch, Fnv, Fnh, kp, ki, L, iS, color)
R = 42.5;
soll_beschleunigung = linspace(0.2, 10, 50);
model = 'geregelte_Kreisfahrt';
load_system(model);
simIn = Simulink.SimulationInput(model);
simIn = setModelParameter(simIn,...
    'SolverType', 'Fixed-step',...
    'FixedStep', '0.01', ...
    'StartTime', '0',...
    'StopTime',num2str(250-0.2));

simIn = setBlockParameter(simIn,"geregelte_Kreisfahrt/Einspurmodell/Reifenkräfte/Cv", "Value",string(Cv));
simIn = setBlockParameter(simIn,"geregelte_Kreisfahrt/Einspurmodell/Reifenkräfte/Ch", "Value",string(Ch));
simIn = setBlockParameter(simIn,"geregelte_Kreisfahrt/Einspurmodell/Reifenkräfte/Fnv","Value",string(Fnv));
simIn = setBlockParameter(simIn,"geregelte_Kreisfahrt/Einspurmodell/Reifenkräfte/Fnh","Value",string(Fnh));

simIn = setBlockParameter(simIn, "geregelte_Kreisfahrt/Beschleunigung", "OutValues", mat2str(soll_beschleunigung));
simIn = setBlockParameter(simIn, "geregelte_Kreisfahrt/Steuerung", "P", num2str(kp));
simIn = setBlockParameter(simIn, "geregelte_Kreisfahrt/Steuerung", "I", num2str(ki));

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
y = (L / R + EG * x) * iS * 180/pi;
plot(x, y.', '--', 'Color', color);
end