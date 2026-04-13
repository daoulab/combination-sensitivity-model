function [t, sol] = Figure_S3()

clearvars
clc

global Iapp1 Iapp2 ...
gNaINT gKINT gHINT CINT krINT gCaTINT1 gCaTINT2 ...
gHX gNaX gKX CX krX gCaTX1 gSKX1 ...
gGAi1x1 gGAi2x1 ...
gAMxx1

global VL VK VNa gL gCa taunbar tauh Ca_ex RTF thetam thetan thetas sigmam sigman sigmas f eps kCa bCa Tmax VT Kps ks ...
VH from1 to1 from2 to2 ...
taurs taur0 taur1 VGA arGA adGA arAM adAM VAM ...
thetarf thetars thetaaT thetab thetarT thetarrT sigmarf ...
sigmars sigmaaT sigmab sigmarT sigmarrT prf phirT

Iapp1 = 200;
Iapp2 = 200;

gCaTINT1 = 0.5;
gCaTINT2 = 0.5;
gCaTX1 = 0.6;
gSKX1 = 2;

gGAi1x1 = 50;
gGAi2x1 = 50;

gAMxx1 = 8;

gNaINT = 800;
gKINT = 1200;
gHINT = 4;
CINT = 20;
krINT = 0.01;

gNaX = 450;
gKX = 60;
gHX = 6;
CX = 20;
krX = 0.3;

from1 = 100;
to1 = 150;
delay = 0;
from2 = 150 + delay;
to2 = from2 + 50;

taur0 = 5;
taur1 = 15;
thetarrT = 68;
sigmarrT = 2;
thetarT = -67;
sigmarT = 2;
thetaaT = -85;
sigmaaT = -8;
thetab = 0.4;
sigmab = -0.1;
phirT = 0.2;

VL = -70;
VK = -90;
VNa = 70;
VH = -30;
Tmax = 1;
VT = 2;
Kps = 5;
gL = 2;
gCa = 19;

arGA = 5;
adGA = 0.18;
VGA = -100;
arAM = 1.1;
adAM = 0.19;
VAM = 0;

taunbar = 10;
tauh = 1;
Ca_ex = 2.5;
RTF = 26.7;
thetam = -35;
thetan = -30;
thetas = -20;
sigmam = -5;
sigman = -5;
sigmas = -0.05;
f = 0.1;
eps = 0.0015;
kCa = 0.3;
bCa = 0.1;
ks = 0.5;
taurs = 1500;
thetarf = -105;
thetars = -105;
sigmarf = 5;
sigmars = 25;
prf = 100;

tspan = 0:0.01:500;

INTinit = [-67.6;0.5e-03;0.996;0.1355;0.1;5.5e-04;0.034];
Xint = [-75;0.01;0.01;0.01;0.01;0.01;0.01];

init_cond = [INTinit; INTinit; Xint; 0.01; 0.01; 0.01];

[t, sol] = ode113(@SimpleInhibitory_local, tspan, init_cond);

vINT1 = sol(:,1);
vINT2 = sol(:,8);
vX1 = sol(:,15);

samplingRate = 1;
step = 150;
i = 1;

figure()
hold on
plot(t./samplingRate, vINT1, 'color', [0.46,0.01,0.65], 'LineWidth', 1);
text(60, mean(vINT1)+50, 'A');

plot(t./samplingRate, vINT2-step*i, 'color', [0.61,0.62,0.67], 'LineWidth', 1);
text(60, mean(vINT2)-step*i+50, 'B');
i = i + 1;

plot(t./samplingRate, vX1-step*i, 'color', [0.04,0.17,0.55], 'LineWidth', 1);
text(60, mean(vX1)-step*i+50, 'CSN');
i = i + 1;

xlabel('Time (msec)', 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Membrane Potential (mV)', 'FontSize', 12, 'FontWeight', 'bold');
title('AB-0msDelay')
set(gca,'YTick',[]);
set(gca,'XTick',[]);
set(gca,'Visible','off');
box off

yMin = min([vINT1; vINT2; vX1]) - (i * step) + 10;
yMax = max([vINT1; vINT2; vX1]) + 100;
axis([50 500 yMin yMax])

scaleLengthX = 10;
scaleLengthY = 50;

x_start = 350;
y_start = yMin + 100;

line([x_start, x_start + scaleLengthX], [y_start, y_start], 'Color', 'k', 'LineWidth', 2);
line([x_start, x_start], [y_start, y_start + scaleLengthY], 'Color', 'k', 'LineWidth', 2);

text(x_start + scaleLengthX / 2, y_start - 30, '10 ms', 'HorizontalAlignment', 'center', 'FontSize', 10);
text(x_start - 5, y_start + scaleLengthY / 2, '50 mV', 'HorizontalAlignment', 'right', 'FontSize', 10);

hold off

end


function output = SimpleInhibitory_local(t, sol)

global Iapp1 Iapp2 ...
gNaINT gKINT gHINT CINT krINT gCaTINT1 gCaTINT2 ...
gHX gNaX gKX CX krX gCaTX1 gSKX1 ...
gGAi1x1 gGAi2x1 ...
gAMxx1

global VL VK VNa gL gCa taunbar tauh Ca_ex RTF thetam thetan thetas sigmam sigman sigmas f eps kCa bCa Tmax VT Kps ks ...
VH from1 to1 from2 to2 ...
taurs taur0 taur1 VGA arGA adGA arAM adAM VAM ...
thetarf thetars thetaaT thetab thetarT thetarrT sigmarf ...
sigmars sigmaaT sigmab sigmarT sigmarrT prf phirT

VINT1 = sol(1); nINT1 = sol(2); hINT1 = sol(3); rTINT1 = sol(4); CaiINT1 = sol(5); rfINT1 = sol(6); rsINT1 = sol(7);
VINT2 = sol(8); nINT2 = sol(9); hINT2 = sol(10); rTINT2 = sol(11); CaiINT2 = sol(12); rfINT2 = sol(13); rsINT2 = sol(14);
VX1 = sol(15); nX1 = sol(16); hX1 = sol(17); rTX1 = sol(18); CaiX1 = sol(19); rfX1 = sol(20); rsX1 = sol(21);

sGAi1x1 = sol(22);
sGAi2x1 = sol(23);
sAMxx1 = sol(24);

sinfINT1 = 1/(1+ exp((VINT1-thetas)/sigmas));
iCaLINT1 = gCa*(sinfINT1^2)*VINT1*(Ca_ex/(1-exp((2*VINT1)/RTF)));
aTinfINT1 = 1/(1+ exp((VINT1-thetaaT)/sigmaaT));
bTinfINT1 = 1/(1+exp((rTINT1-thetab)/sigmab)) - 1/(1+exp(-thetab/sigmab));
rTinfINT1 = 1/(1+exp((VINT1-thetarT)/sigmarT));
taurTINT1 = taur0+taur1/(1+exp((VINT1-thetarrT)/sigmarrT));
iCaTINT1 = gCaTINT1*(aTinfINT1^3)*(bTinfINT1^3)*VINT1*(Ca_ex/(1-exp((2*VINT1)/RTF)));
iLINT1 = gL*(VINT1-VL);
ninfINT1 = 1/(1+ exp((VINT1-thetan)/sigman));
taunINT1 = taunbar/cosh((VINT1-thetan)/(2*sigman));
iKINT1 = gKINT*(nINT1^4)*(VINT1-VK);
minfINT1 = 1/(1+exp((VINT1-thetam)/sigmam));
alphahINT1 = 0.128*exp(-(VINT1+50)/18);
betahINT1 = 4/(1+exp(-(VINT1+27)/5));
hinfINT1 = alphahINT1/(alphahINT1 + betahINT1);
iNaINT1 = gNaINT*(minfINT1^3)*hINT1*(VINT1-VNa);
rfinfINT1 = 1/(1+exp((VINT1-thetarf)/sigmarf));
taurfINT1 = prf/(-7.4*(VINT1+70)/(exp(-(VINT1+70)/0.8)-1)+65*exp(-(VINT1+56)/23));
rsinfINT1 = 1/(1+exp((VINT1-thetars)/sigmars));
iHINT1 = gHINT*(krINT*rfINT1+(1-krINT)*rsINT1)*(VINT1-VH);
TINT1 = Tmax/(1+exp(-(VINT1-VT)/Kps));

sinfINT2 = 1/(1+ exp((VINT2-thetas)/sigmas));
iCaLINT2 = gCa*(sinfINT2^2)*VINT2*(Ca_ex/(1-exp((2*VINT2)/RTF)));
aTinfINT2 = 1/(1+ exp((VINT2-thetaaT)/sigmaaT));
bTinfINT2 = 1/(1+exp((rTINT2-thetab)/sigmab)) - 1/(1+exp(-thetab/sigmab));
rTinfINT2 = 1/(1+exp((VINT2-thetarT)/sigmarT));
taurTINT2 = taur0+taur1/(1+exp((VINT2-thetarrT)/sigmarrT));
iCaTINT2 = gCaTINT2*(aTinfINT2^3)*(bTinfINT2^3)*VINT2*(Ca_ex/(1-exp((2*VINT2)/RTF)));
iLINT2 = gL*(VINT2-VL);
ninfINT2 = 1/(1+ exp((VINT2-thetan)/sigman));
taunINT2 = taunbar/cosh((VINT2-thetan)/(2*sigman));
iKINT2 = gKINT*(nINT2^4)*(VINT2-VK);
minfINT2 = 1/(1+exp((VINT2-thetam)/sigmam));
alphahINT2 = 0.128*exp(-(VINT2+50)/18);
betahINT2 = 4/(1+exp(-(VINT2+27)/5));
hinfINT2 = alphahINT2/(alphahINT2 + betahINT2);
iNaINT2 = gNaINT*(minfINT2^3)*hINT2*(VINT2-VNa);
rfinfINT2 = 1/(1+exp((VINT2-thetarf)/sigmarf));
taurfINT2 = prf/(-7.4*(VINT2+70)/(exp(-(VINT2+70)/0.8)-1)+65*exp(-(VINT2+56)/23));
rsinfINT2 = 1/(1+exp((VINT2-thetars)/sigmars));
iHINT2 = gHINT*(krINT*rfINT2+(1-krINT)*rsINT2)*(VINT2-VH);
TINT2 = Tmax/(1+exp(-(VINT2-VT)/Kps));

minfX1 = 1/(1+exp((VX1-thetam)/sigmam));
ninfX1 = 1/(1+exp((VX1-thetan)/sigman));
tauNX1 = taunbar./cosh((VX1-thetan)/(2*sigman));
alphaHX1 = 0.128*exp(-(VX1+50)/18);
betaHX1 = 4/(1+exp(-(VX1+27)/5));
hinfX1 = alphaHX1/(alphaHX1+betaHX1);
iNaX1 = gNaX*(minfX1^3)*hX1*(VX1-VNa);
iKX1 = gKX*(nX1^4)*(VX1-VK);
sinfX1 = 1/(1+exp((VX1-thetas)/sigmas));
iCaLX1 = gCa*(sinfX1^2)*VX1*(Ca_ex/(1-exp((2*VX1)/RTF)));
aTinfX1 = 1/(1+exp((VX1-thetaaT)/sigmaaT));
bTinfX1 = 1/(1+exp((rTX1-thetab)/sigmab)) - 1/(1+exp(-thetab/sigmab));
rTinfX1 = 1/(1+exp((VX1-thetarT)/sigmarT));
taurTX1 = taur0+taur1/(1+exp((VX1-thetarrT)/sigmarrT));
iCaTX1 = gCaTX1*(aTinfX1^3)*(bTinfX1^3)*VX1*(Ca_ex/(1-exp((2*VX1)/RTF)));
kinfX1 = (CaiX1^2)/(CaiX1^2+(ks^2));
iSKX1 = gSKX1*kinfX1*(VX1-VK);
rinffX1 = 1./(1+exp((VX1-thetarf)/sigmarf));
rinfsX1 = 1./(1+exp((VX1-thetars)/sigmars));
taurfX1 = prf./(-7.4*(VX1+70)./(exp(-(VX1+70)/0.8)-1)+65*exp(-(VX1+56)/23));
iHX1 = gHX*(krX*rfX1+(1-krX)*rsX1)*(VX1-VH);
iLX1 = gL*(VX1-VL);
TX1 = Tmax/(1+exp(-(VX1-VT)/Kps));

iGAi1x1 = gGAi1x1*sGAi1x1*(VX1-VGA);
iGAi2x1 = gGAi2x1*sGAi2x1*(VX1-VGA);
iAMxx1 = gAMxx1*sAMxx1*(VX1-VAM);

if (t>from1 && t<to1)
    curr1 = Iapp1;
else
    curr1 = 0;
end

if (t>from2 && t<to2)
    curr2 = Iapp2;
else
    curr2 = 0;
end

output = zeros(24,1);

output(1) = (-iNaINT1-iKINT1-iCaLINT1-iCaTINT1-iHINT1-iLINT1 + curr1)/CINT;
output(2) = (ninfINT1-nINT1)/taunINT1;
output(3) = (hinfINT1-hINT1)/tauh;
output(4) = phirT*(rTinfINT1-rTINT1)/taurTINT1;
output(5) = -f*(eps*(iCaLINT1+iCaTINT1)+ kCa*(CaiINT1-bCa));
output(6) = (rfinfINT1-rfINT1)/taurfINT1;
output(7) = (rsinfINT1-rsINT1)/taurs;

output(8) = (-iNaINT2-iKINT2-iCaLINT2-iCaTINT2-iHINT2-iLINT2+curr2)/CINT;
output(9) = (ninfINT2-nINT2)/taunINT2;
output(10) = (hinfINT2-hINT2)/tauh;
output(11) = phirT*(rTinfINT2-rTINT2)/taurTINT2;
output(12) = -f*(eps*(iCaLINT2+iCaTINT2)+ kCa*(CaiINT2-bCa));
output(13) = (rfinfINT2-rfINT2)/taurfINT2;
output(14) = (rsinfINT2-rsINT2)/taurs;

output(15) = (-iNaX1-iKX1-iCaLX1-iCaTX1-iSKX1-iHX1-iLX1-iGAi1x1-iGAi2x1-iAMxx1)/CX;
output(16) = (ninfX1-nX1)/tauNX1;
output(17) = (hinfX1-hX1)/tauh;
output(18) = phirT*(rTinfX1-rTX1)/taurTX1;
output(19) = -f*(eps*(iCaLX1+iCaTX1)+ kCa*(CaiX1-bCa));
output(20) = (rinffX1-rfX1)/taurfX1;
output(21) = (rinfsX1-rsX1)/taurs;

output(22) = arGA*TINT1*(1-sGAi1x1)-adGA*sGAi1x1;
output(23) = arGA*TINT2*(1-sGAi2x1)-adGA*sGAi2x1;
output(24) = arAM*TX1*(1-sAMxx1)-adAM*sAMxx1;

end