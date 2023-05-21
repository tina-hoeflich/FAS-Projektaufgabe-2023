function Fs  = Pacejka(alpha, Fn, Cs, C, D, E)
    B = Cs/Fn/C/D;
    Fs = Fn*D*sin(C*atan(B*alpha - E*(B*alpha - atan(B*alpha))));
end