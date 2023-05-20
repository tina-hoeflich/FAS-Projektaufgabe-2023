% Fahrzeugparameter
L = 2.8;  % Radstand
m = 1550; % Masse
J = 2800; % Trägheitsmoment
g = 9.81; % Erdbeschleunigung
iS =16;   % Lenkübersetzung
Lv =L*0.48;     % Abstand Vorderachse - Schwerpunkt
Lh =L*(1-0.48); % Abstand Hinterachse - Schwerpunkt
hs = 0.5; % Schwerpunkthöhe

% Schräglaufsteifigkeiten, nur zur Berechnung des Pacejka-Parameters B
Cv =  75000;  % vorne
Ch = 150000;  % hinten

% Pacejka Block-Parameter, siehe
% https://www.edy.es/dev/docs/pacejka-94-parameters-explained-a-comprehensive-guide/
C = 1.9; % Form 1 ... 2
D = 1;   % D = µ = Maximum 0.1 ... 1.9
E = 1;   % Krümmung -10 ... 1

% Pacejka Block-inputs
% Achslasten vorne & hinten
Fnv = m * g * Lh / L; Fnh = m * g * Lv / L;

% Parameter B für vorne und hinten, benötigt für Seitenkraft-Diagramm
Bv = Cv/Fnv/C/D; Bh = Ch/Fnh/C/D; 

% Check, ob die Pacejka-Parameter Bv und Bh im erlaubten Bereich [4 ... 12] 
% liegen
Bmin = 4; Bmax = 12;
msg = 'Parameter %s = %g außerhalb des erlaubten Bereichs [%g ... %g]';
if Bv < Bmin || Bv > Bmax
    error(msg, 'Bv', Bv, Bmin, Bmax)
end
if Bh < Bmin || Bh > Bmax
    error(msg, 'Bh', Bh, Bmin, Bmax)
end

disp('FzgDaten geladen')