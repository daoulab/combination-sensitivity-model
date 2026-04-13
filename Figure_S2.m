function [t, sol] = Figure_S2()

clc

global Iapp1 Iapp2 ...
gHX gNaX gKX CX krX gCaTX1 gCaTX2 gCaTX3 gSKX1 gSKX2 gSKX3 ...
gAMxx1 gAMxx2 gAMxx3 gAMx1x3 gAMx2x3

global VL VK VNa gL gCa taunbar tauh Ca_ex RTF thetam thetan thetas ...
sigmam sigman sigmas f eps kCa bCa Tmax VT Kps ks ...
VH from1 to1 from2 to2 ...
taurs taur0 taur1 arAM adAM VAM ...
thetarf thetars thetaaT thetab thetarT thetarrT sigmarf ...
sigmars sigmaaT sigmab sigmarT sigmarrT prf phirT

Iapp1 = 200;
Iapp2 = 200;

gCaTX1 = 0.5;
gCaTX2 = 0.5;
gCaTX3 = 0.5;
gSKX1 = 0.5;
gSKX2 = 0.5;
gSKX3 = 0.2;

gAMxx3 = 12;
gAMx1x3 = 2.9;
gAMx2x3 = 3.12;

gNaX = 800;
gKX = 500;
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

Xint = [-75;0.01;0.01;0.01;0.01;0.01;0.01];
init_cond = [Xint; Xint; Xint; 0.01; 0.01; 0.01];

[t, sol] = ode23(@SimpleSummation_local, tspan, init_cond);

vX1 = sol(:,1);
vX2 = sol(:,8);
vX3 = sol(:,15);

samplingRate = 1;
step = 150;
i = 1;

figure()
hold on
plot(t./samplingRate, vX1, 'color', [0.46,0.01,0.65], 'LineWidth', 1);
text(60, 0, 'A')

plot(t./samplingRate, vX2-step*i, 'color', [0.61,0.62,0.67], 'LineWidth', 1);
text(60, -step*i, 'B');
i = i + 1;

plot(t./samplingRate, vX3-step*i, 'color', [0.04,0.17,0.55], 'LineWidth', 1);
text(60, -step*i, 'CSN');
i = i + 1;

yMin = min([vX1; vX2; vX3]) - (i * step) - 200;
yMax = max([vX1; vX2; vX3]) + 100;
axis([50 500 yMin yMax])

scaleLengthX = 10;
scaleLengthY = 50;

x_start = 370;
y_start = yMin + 300;

line([x_start, x_start + scaleLengthX], [y_start, y_start], 'Color', 'k', 'LineWidth', 2);
line([x_start, x_start], [y_start, y_start + scaleLengthY], 'Color', 'k', 'LineWidth', 2);

text(x_start + scaleLengthX/2, y_start - 30, '10 ms', ...
    'HorizontalAlignment', 'center', 'FontSize', 10);
text(x_start - 5, y_start + scaleLengthY/2, '50 mV', ...
    'HorizontalAlignment', 'right', 'FontSize', 10);

xlabel('Time (ms)', 'FontSize', 12, 'FontWeight', 'bold');
set(gca, 'YTick', []);
set(gca, 'XTick', []);
set(gca, 'Visible', 'off');
box off
hold off

end


function output = SimpleSummation_local(t, sol)

global Iapp1 Iapp2 ...
gHX gNaX gKX CX krX gCaTX1 gCaTX2 gCaTX3 gSKX1 gSKX2 gSKX3 ...
gAMxx1 gAMxx2 gAMxx3 gAMx1x3 gAMx2x3

global VL VK VNa gL gCa taunbar tauh Ca_ex RTF thetam thetan thetas ...
sigmam sigman sigmas f eps kCa bCa Tmax VT Kps ks ...
VH from1 to1 from2 to2 ...
taurs taur0 taur1 arAM adAM VAM ...
thetarf thetars thetaaT thetab thetarT thetarrT sigmarf ...
sigmars sigmaaT sigmab sigmarT sigmarrT prf phirT

VX1 = sol(1);   nX1 = sol(2);   hX1 = sol(3);   rTX1 = sol(4);   CaiX1 = sol(5);   rfX1 = sol(6);   rsX1 = sol(7);
VX2 = sol(8);   nX2 = sol(9);   hX2 = sol(10);  rTX2 = sol(11);  CaiX2 = sol(12);  rfX2 = sol(13);  rsX2 = sol(14);
VX3 = sol(15);  nX3 = sol(16);  hX3 = sol(17);  rTX3 = sol(18);  CaiX3 = sol(19);  rfX3 = sol(20);  rsX3 = sol(21);

sAMx1x3 = sol(22);
sAMx2x3 = sol(23);
sAMxx3  = sol(24);

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
taurTX1 = taur0 + taur1/(1+exp((VX1-thetarrT)/sigmarrT));
iCaTX1 = gCaTX1*(aTinfX1^3)*(bTinfX1^2)*VX1*(Ca_ex/(1-exp((2*VX1)/RTF)));
kinfX1 = (CaiX1^2)/(CaiX1^2+(ks^2));
iSKX1 = gSKX1*kinfX1*(VX1-VK);
rinffX1 = 1./(1+exp((VX1-thetarf)/sigmarf));
rinfsX1 = 1./(1+exp((VX1-thetars)/sigmars));
taurfX1 = prf./(-7.4*(VX1+70)./(exp(-(VX1+70)/0.8)-1)+65*exp(-(VX1+56)/23));
iHX1 = gHX*(krX*rfX1+(1-krX)*rsX1)*(VX1-VH);
iLX1 = gL*(VX1-VL);
TX1 = Tmax/(1+exp(-(VX1-VT)/Kps));

minfX2 = 1/(1+exp((VX2-thetam)/sigmam));
ninfX2 = 1/(1+exp((VX2-thetan)/sigman));
tauNX2 = taunbar./cosh((VX2-thetan)/(2*sigman));
alphaHX2 = 0.128*exp(-(VX2+50)/18);
betaHX2 = 4/(1+exp(-(VX2+27)/5));
hinfX2 = alphaHX2/(alphaHX2+betaHX2);
iNaX2 = gNaX*(minfX2^3)*hX2*(VX2-VNa);
iKX2 = gKX*(nX2^4)*(VX2-VK);
sinfX2 = 1/(1+exp((VX2-thetas)/sigmas));
iCaLX2 = gCa*(sinfX2^2)*VX2*(Ca_ex/(1-exp((2*VX2)/RTF)));
aTinfX2 = 1/(1+exp((VX2-thetaaT)/sigmaaT));
bTinfX2 = 1/(1+exp((rTX2-thetab)/sigmab)) - 1/(1+exp(-thetab/sigmab));
rTinfX2 = 1/(1+exp((VX2-thetarT)/sigmarT));
taurTX2 = taur0 + taur1/(1+exp((VX2-thetarrT)/sigmarrT));
iCaTX2 = gCaTX2*(aTinfX2^3)*(bTinfX2^2)*VX2*(Ca_ex/(1-exp((2*VX2)/RTF)));
kinfX2 = (CaiX2^2)/(CaiX2^2+(ks^2));
iSKX2 = gSKX2*kinfX2*(VX2-VK);
rinffX2 = 1./(1+exp((VX2-thetarf)/sigmarf));
rinfsX2 = 1./(1+exp((VX2-thetars)/sigmars));
taurfX2 = prf./(-7.4*(VX2+70)./(exp(-(VX2+70)/0.8)-1)+65*exp(-(VX2+56)/23));
iHX2 = gHX*(krX*rfX2+(1-krX)*rsX2)*(VX2-VH);
iLX2 = gL*(VX2-VL);
TX2 = Tmax/(1+exp(-(VX2-VT)/Kps));

minfX3 = 1/(1+exp((VX3-thetam)/sigmam));
ninfX3 = 1/(1+exp((VX3-thetan)/sigman));
tauNX3 = taunbar./cosh((VX3-thetan)/(2*sigman));
alphaHX3 = 0.128*exp(-(VX3+50)/18);
betaHX3 = 4/(1+exp(-(VX3+27)/5));
hinfX3 = alphaHX3/(alphaHX3+betaHX3);
iNaX3 = gNaX*(minfX3^3)*hX3*(VX3-VNa);
iKX3 = gKX*(nX3^4)*(VX3-VK);
sinfX3 = 1/(1+exp((VX3-thetas)/sigmas));
iCaLX3 = gCa*(sinfX3^2)*VX3*(Ca_ex/(1-exp((2*VX3)/RTF)));
aTinfX3 = 1/(1+exp((VX3-thetaaT)/sigmaaT));
bTinfX3 = 1/(1+exp((rTX3-thetab)/sigmab)) - 1/(1+exp(-thetab/sigmab));
rTinfX3 = 1/(1+exp((VX3-thetarT)/sigmarT));
taurTX3 = taur0 + taur1/(1+exp((VX3-thetarrT)/sigmarrT));
iCaTX3 = gCaTX3*(aTinfX3^3)*(bTinfX3^2)*VX3*(Ca_ex/(1-exp((2*VX3)/RTF)));
kinfX3 = (CaiX3^2)/(CaiX3^2+(ks^2));
iSKX3 = gSKX3*kinfX3*(VX3-VK);
rinffX3 = 1./(1+exp((VX3-thetarf)/sigmarf));
rinfsX3 = 1./(1+exp((VX3-thetars)/sigmars));
taurfX3 = prf./(-7.4*(VX3+70)./(exp(-(VX3+70)/0.8)-1)+65*exp(-(VX3+56)/23));
iHX3 = gHX*(krX*rfX3+(1-krX)*rsX3)*(VX3-VH);
iLX3 = gL*(VX3-VL);
TX3 = Tmax/(1+exp(-(VX3-VT)/Kps));

iAMxx3  = gAMxx3*sAMxx3*(VX3-VAM);
iAMx1x3 = gAMx1x3*sAMx1x3*(VX3-VAM);
iAMx2x3 = gAMx2x3*sAMx2x3*(VX3-VAM);

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

output(1)  = (-iNaX1-iKX1-iCaLX1-iCaTX1-iSKX1-iHX1-iLX1+curr1)/CX;
output(2)  = (ninfX1-nX1)/tauNX1;
output(3)  = (hinfX1-hX1)/tauh;
output(4)  = phirT*(rTinfX1-rTX1)/taurTX1;
output(5)  = -f*(eps*(iCaLX1+iCaTX1)+ kCa*(CaiX1-bCa));
output(6)  = (rinffX1-rfX1)/taurfX1;
output(7)  = (rinfsX1-rsX1)/taurs;

output(8)  = (-iNaX2-iKX2-iCaLX2-iCaTX2-iSKX2-iHX2-iLX2+curr2)/CX;
output(9)  = (ninfX2-nX2)/tauNX2;
output(10) = (hinfX2-hX2)/tauh;
output(11) = phirT*(rTinfX2-rTX2)/taurTX2;
output(12) = -f*(eps*(iCaLX2+iCaTX2)+ kCa*(CaiX2-bCa));
output(13) = (rinffX2-rfX2)/taurfX2;
output(14) = (rinfsX2-rsX2)/taurs;

output(15) = (-iNaX3-iKX3-iCaLX3-iCaTX3-iSKX3-iHX3-iLX3-iAMx2x3-iAMx1x3-iAMxx3)/CX;
output(16) = (ninfX3-nX3)/tauNX3;
output(17) = (hinfX3-hX3)/tauh;
output(18) = phirT*(rTinfX3-rTX3)/taurTX3;
output(19) = -f*(eps*(iCaLX3+iCaTX3)+ kCa*(CaiX3-bCa));
output(20) = (rinffX3-rfX3)/taurfX3;
output(21) = (rinfsX3-rsX3)/taurs;

output(22) = arAM*TX1*(1-sAMx1x3)-adAM*sAMx1x3;
output(23) = arAM*TX2*(1-sAMx2x3)-adAM*sAMx2x3;
output(24) = arAM*TX3*(1-sAMxx3)-adAM*sAMxx3;

end