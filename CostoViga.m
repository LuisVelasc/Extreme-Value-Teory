function [Costo]=CostoViga(L,Le,rec,BApoyo,B,H,fc,d,Asc,As1,As2,Av,sEApoyo,sECentro,Vfc)
% Esta función determina el costo de la viga actual

% Costos de los materiales
Cfc = [104.08,	108.42,	112.94,	118.08,	123.23,	128.38,	133.53,	138.68,	142.84,	148.99,	159.29]; % dls/m3
Cacero = 1.27; % dls/kg
Ccimbra = 11.0; % dls/m2

% Costo del concreto
Concreto=(L+BApoyo)*B*H*Cfc(1,find(Vfc==fc));

% Costo del acero longitudinal
Longitudinal=(L+BApoyo+H)*(Asc+As1+As2)*Cacero*7860;

% Costo estribos
if(Le-BApoyo/2-d<0)
    Lc=L-BApoyo;
    EstribosApoyo=2*(1+1)*(B-2*rec+H-2*rec)*Av*Cacero*7860;
    EstribosCentro=(round(Lc/sECentro)-1)*(B-2*rec+H-2*rec)*Av*Cacero*7860;
else
    Lc=L-(2*round((Le-BApoyo/2-d)/sEApoyo)*sEApoyo+d+BApoyo/2);
    EstribosApoyo=2*(round((Le-BApoyo/2)/sEApoyo)+1)*(B-2*rec+H-2*rec)*Av*Cacero*7860;
    EstribosCentro=(round(Lc/sECentro)-1)*(B-2*rec+H-2*rec)*Av*Cacero*7860;
end

% Costo cimbra
Cimbra=(L+BApoyo)*(B+2*H)*Ccimbra;

% Costo total
Costo=Concreto+Longitudinal+EstribosApoyo+EstribosCentro+Cimbra;
end

