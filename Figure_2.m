function results = Figure_2()
P = get_common_params();

cases(1) = struct('title','(A) AB-0 ms delay','from1',100,'to1',150,'from2',150,'to2',200,'reverse_order',false);
cases(2) = struct('title','(B) AB-early B','from1',100,'to1',150,'from2',120,'to2',170,'reverse_order',false);
cases(3) = struct('title','(C) AB-50 ms delay','from1',100,'to1',150,'from2',200,'to2',250,'reverse_order',false);
cases(4) = struct('title','(D) BA-0 ms delay','from1',100,'to1',150,'from2',150,'to2',200,'reverse_order',true);

figure('Color','w');
tiledlayout(2,2,'Padding','compact','TileSpacing','compact');

results = struct([]);

for k = 1:4
    [t, sol] = run_case(P, cases(k));
    nexttile;
    plot_case(t, sol, cases(k).title);
    results(k).t = t;
    results(k).sol = sol;
    results(k).case = cases(k);
end
end

function P = get_common_params()
P.Iapp1 = 200;
P.Iapp2 = 200;

P.gCaTINT1 = 0.5;
P.gCaTX2 = 0.5;
P.gCaTCSN = 0.8;

P.gSKX2 = 2;
P.gSKCSN = 2;

P.gGAi1csn = 10;
P.gAMx2csn = 1.2;
P.gAMCNCN = 5;

P.gNaINT = 800;
P.gKINT = 1200;
P.gHINT = 4;
P.CINT = 20;
P.krINT = 0.01;

P.gNaX = 450;
P.gKX = 60;
P.gHX = 6;
P.CX = 20;
P.krX = 0.3;

P.taur0 = 5;
P.taur1 = 15;
P.thetarrT = 68;
P.sigmarrT = 2;
P.thetarT = -67;
P.sigmarT = 2;
P.thetaaT = -85;
P.sigmaaT = -8;
P.thetab = 0.4;
P.sigmab = -0.1;
P.phirT = 0.2;

P.VL = -70;
P.VK = -90;
P.VNa = 70;
P.VH = -30;
P.Tmax = 1;
P.VT = 2;
P.Kps = 5;
P.gL = 2;
P.gCa = 19;
P.arGA = 5;
P.adGA = 0.18;
P.VGA = -100;
P.arAM = 1.1;
P.adAM = 0.19;
P.VAM = 0;

P.taunbar = 10;
P.tauh = 1;
P.Ca_ex = 2.5;
P.RTF = 26.7;
P.thetam = -35;
P.thetan = -30;
P.thetas = -20;
P.sigmam = -5;
P.sigman = -5;
P.sigmas = -0.05;
P.f = 0.1;
P.eps = 0.0015;
P.kCa = 0.3;
P.bCa = 0.1;
P.ks = 0.5;
P.taurs = 1500;
P.thetarf = -105;
P.thetars = -105;
P.sigmarf = 5;
P.sigmars = 25;
P.prf = 100;

P.tspan = 0:0.01:900;
P.INTinit = [-67.6; 0.5e-03; 0.996; 0.1355; 0.1; 5.5e-04; 0.034];
P.Xinit = [-75; 0.01; 0.01; 0.01; 0.01; 0.01; 0.01];
P.init_cond = [P.INTinit; P.Xinit; P.Xinit; 0.01; 0.01; 0.01];
end

function [t, sol] = run_case(P, caseDef)
P.from1 = caseDef.from1;
P.to1 = caseDef.to1;
P.from2 = caseDef.from2;
P.to2 = caseDef.to2;
P.reverse_order = caseDef.reverse_order;
[t, sol] = ode113(@(t,sol) SimpleFTN_local(t, sol, P), P.tspan, P.init_cond);
end

function plot_case(t, sol, titleStr)
vINT1 = sol(:,1);
vX2 = sol(:,8);
vCSN = sol(:,15);

step = 150;
i = 1;

hold on
plot(t, vINT1-step*i, 'Color', [0.46,0.01,0.65], 'LineWidth', 1);
text(60, -step*i, 'A');
i = i + 1;

plot(t, vX2-step*i, 'Color', [0.61,0.62,0.67], 'LineWidth', 1);
text(60, -step*i, 'B');
i = i + 1;

plot(t, vCSN-step*i, 'Color', [0.04,0.17,0.55], 'LineWidth', 1);
text(60, -step*i, 'CSN');
i = i + 1;

yMin = min([vINT1; vX2; vCSN]) - (i * step) - 100;
yMax = max([vINT1; vX2; vCSN]) + 100;

xlim([50 300]);
ylim([yMin yMax]);

scaleLengthX = 10;
scaleLengthY = 50;
x_start = 270;
y_start = yMin + 200;

line([x_start, x_start + scaleLengthX], [y_start, y_start], 'Color', 'k', 'LineWidth', 2);
line([x_start, x_start], [y_start, y_start + scaleLengthY], 'Color', 'k', 'LineWidth', 2);

text(x_start + scaleLengthX/2, y_start - 30, '10 ms', 'HorizontalAlignment', 'center', 'FontSize', 9);
text(x_start - 5, y_start + scaleLengthY/2, '50 mV', 'HorizontalAlignment', 'right', 'FontSize', 9);

title(titleStr, 'FontWeight', 'normal');
set(gca, 'YTick', [], 'XTick', [], 'XColor', 'none', 'YColor', 'none');
box off
hold off
end

function output = SimpleFTN_local(t, sol, P)
VINT1 = sol(1);  nINT1 = sol(2);  hINT1 = sol(3);  rTINT1 = sol(4);  CaiINT1 = sol(5);  rfINT1 = sol(6);  rsINT1 = sol(7);
VX2   = sol(8);  nX2   = sol(9);  hX2   = sol(10); rTX2   = sol(11); CaiX2   = sol(12); rfX2   = sol(13); rsX2   = sol(14);
VCSN  = sol(15); nCSN  = sol(16); hCSN  = sol(17); rTCSN  = sol(18); CaiCSN  = sol(19); rfCSN  = sol(20); rsCSN  = sol(21);

sGAi1csn = sol(22);
sAMx2csn = sol(23);
sAMCNCN  = sol(24);

sinfINT1   = 1/(1 + exp((VINT1-P.thetas)/P.sigmas));
iCaLINT1   = P.gCa*(sinfINT1^2)*VINT1*(P.Ca_ex/(1-exp((2*VINT1)/P.RTF)));
aTinfINT1  = 1/(1 + exp((VINT1-P.thetaaT)/P.sigmaaT));
bTinfINT1  = 1/(1 + exp((rTINT1-P.thetab)/P.sigmab)) - 1/(1 + exp(-P.thetab/P.sigmab));
rTinfINT1  = 1/(1 + exp((VINT1-P.thetarT)/P.sigmarT));
taurTINT1  = P.taur0 + P.taur1/(1 + exp((VINT1-P.thetarrT)/P.sigmarrT));
iCaTINT1   = P.gCaTINT1*(aTinfINT1^3)*(bTinfINT1^2)*VINT1*(P.Ca_ex/(1-exp((2*VINT1)/P.RTF)));
iLINT1     = P.gL*(VINT1-P.VL);
ninfINT1   = 1/(1 + exp((VINT1-P.thetan)/P.sigman));
taunINT1   = P.taunbar/cosh((VINT1-P.thetan)/(2*P.sigman));
iKINT1     = P.gKINT*(nINT1^4)*(VINT1-P.VK);
minfINT1   = 1/(1 + exp((VINT1-P.thetam)/P.sigmam));
alphahINT1 = 0.128*exp(-(VINT1+50)/18);
betahINT1  = 4/(1 + exp(-(VINT1+27)/5));
hinfINT1   = alphahINT1/(alphahINT1 + betahINT1);
iNaINT1    = P.gNaINT*(minfINT1^3)*hINT1*(VINT1-P.VNa);
rfinfINT1  = 1/(1 + exp((VINT1-P.thetarf)/P.sigmarf));
taurfINT1  = P.prf/(-7.4*(VINT1+70)/(exp(-(VINT1+70)/0.8)-1) + 65*exp(-(VINT1+56)/23));
rsinfINT1  = 1/(1 + exp((VINT1-P.thetars)/P.sigmars));
iHINT1     = P.gHINT*(P.krINT*rfINT1 + (1-P.krINT)*rsINT1)*(VINT1-P.VH);
TINT1      = P.Tmax/(1 + exp(-(VINT1-P.VT)/P.Kps));

minfX2   = 1/(1 + exp((VX2-P.thetam)/P.sigmam));
ninfX2   = 1/(1 + exp((VX2-P.thetan)/P.sigman));
tauNX2   = P.taunbar./cosh((VX2-P.thetan)/(2*P.sigman));
alphaHX2 = 0.128*exp(-(VX2+50)/18);
betaHX2  = 4/(1 + exp(-(VX2+27)/5));
hinfX2   = alphaHX2/(alphaHX2 + betaHX2);
iNaX2    = P.gNaX*(minfX2^3)*hX2*(VX2-P.VNa);
iKX2     = P.gKX*(nX2^4)*(VX2-P.VK);
sinfX2   = 1/(1 + exp((VX2-P.thetas)/P.sigmas));
iCaLX2   = P.gCa*(sinfX2^2)*VX2*(P.Ca_ex/(1-exp((2*VX2)/P.RTF)));
aTinfX2  = 1/(1 + exp((VX2-P.thetaaT)/P.sigmaaT));
bTinfX2  = 1/(1 + exp((rTX2-P.thetab)/P.sigmab)) - 1/(1 + exp(-P.thetab/P.sigmab));
rTinfX2  = 1/(1 + exp((VX2-P.thetarT)/P.sigmarT));
taurTX2  = P.taur0 + P.taur1/(1 + exp((VX2-P.thetarrT)/P.sigmarrT));
iCaTX2   = P.gCaTX2*(aTinfX2^3)*(bTinfX2^2)*VX2*(P.Ca_ex/(1-exp((2*VX2)/P.RTF)));
kinfX2   = (CaiX2^2)/(CaiX2^2 + (P.ks^2));
iSKX2    = P.gSKX2*kinfX2*(VX2-P.VK);
rinffX2  = 1/(1 + exp((VX2-P.thetarf)/P.sigmarf));
rinfsX2  = 1/(1 + exp((VX2-P.thetars)/P.sigmars));
taurfX2  = P.prf./(-7.4*(VX2+70)./(exp(-(VX2+70)/0.8)-1) + 65*exp(-(VX2+56)/23));
iHX2     = P.gHX*(P.krX*rfX2 + (1-P.krX)*rsX2)*(VX2-P.VH);
iLX2     = P.gL*(VX2-P.VL);
TX2      = P.Tmax/(1 + exp(-(VX2-P.VT)/P.Kps));

minfCSN   = 1/(1 + exp((VCSN-P.thetam)/P.sigmam));
ninfCSN   = 1/(1 + exp((VCSN-P.thetan)/P.sigman));
tauNCSN   = P.taunbar./cosh((VCSN-P.thetan)/(2*P.sigman));
alphaHCSN = 0.128*exp(-(VCSN+50)/18);
betaHCSN  = 4/(1 + exp(-(VCSN+27)/5));
hinfCSN   = alphaHCSN/(alphaHCSN + betaHCSN);
iNaCSN    = P.gNaX*(minfCSN^3)*hCSN*(VCSN-P.VNa);
iKCSN     = P.gKX*(nCSN^4)*(VCSN-P.VK);
sinfCSN   = 1/(1 + exp((VCSN-P.thetas)/P.sigmas));
iCaLCSN   = P.gCa*(sinfCSN^2)*VCSN*(P.Ca_ex/(1-exp((2*VCSN)/P.RTF)));
aTinfCSN  = 1/(1 + exp((VCSN-P.thetaaT)/P.sigmaaT));
bTinfCSN  = 1/(1 + exp((rTCSN-P.thetab)/P.sigmab)) - 1/(1 + exp(-P.thetab/P.sigmab));
rTinfCSN  = 1/(1 + exp((VCSN-P.thetarT)/P.sigmarT));
taurTCSN  = P.taur0 + P.taur1/(1 + exp((VCSN-P.thetarrT)/P.sigmarrT));
iCaTCSN   = P.gCaTCSN*(aTinfCSN^3)*(bTinfCSN^3)*VCSN*(P.Ca_ex/(1-exp((2*VCSN)/P.RTF)));
kinfCSN   = (CaiCSN^2)/(CaiCSN^2 + (P.ks^2));
iSKCSN    = P.gSKCSN*kinfCSN*(VCSN-P.VK);
rinffCSN  = 1/(1 + exp((VCSN-P.thetarf)/P.sigmarf));
rinfsCSN  = 1/(1 + exp((VCSN-P.thetars)/P.sigmars));
taurfCSN  = P.prf./(-7.4*(VCSN+70)./(exp(-(VCSN+70)/0.8)-1) + 65*exp(-(VCSN+56)/23));
iHCSN     = P.gHX*(P.krX*rfCSN + (1-P.krX)*rsCSN)*(VCSN-P.VH);
iLCSN     = P.gL*(VCSN-P.VL);
TCSN      = P.Tmax/(1 + exp(-(VCSN-P.VT)/P.Kps));

iGAi1csn = P.gGAi1csn*sGAi1csn*(VCSN-P.VGA);
iAMx2csn = P.gAMx2csn*sAMx2csn*(VCSN-P.VAM);
iAMCNCN  = P.gAMCNCN*sAMCNCN*(VCSN-P.VAM);

if ~P.reverse_order
    if (t > P.from1 && t < P.to1)
        curr1 = P.Iapp1;
    else
        curr1 = 0;
    end

    if (t > P.from2 && t < P.to2)
        curr2 = P.Iapp2;
    else
        curr2 = 0;
    end
else
    if (t > P.from1 && t < P.to1)
        curr2 = P.Iapp2;
    else
        curr2 = 0;
    end

    if (t > P.from2 && t < P.to2)
        curr1 = P.Iapp1;
    else
        curr1 = 0;
    end
end

output = zeros(24,1);

output(1)  = (-iNaINT1-iKINT1-iCaLINT1-iCaTINT1-iHINT1-iLINT1+curr1)/P.CINT;
output(2)  = (ninfINT1-nINT1)/taunINT1;
output(3)  = (hinfINT1-hINT1)/P.tauh;
output(4)  = P.phirT*(rTinfINT1-rTINT1)/taurTINT1;
output(5)  = -P.f*(P.eps*(iCaLINT1+iCaTINT1) + P.kCa*(CaiINT1-P.bCa));
output(6)  = (rfinfINT1-rfINT1)/taurfINT1;
output(7)  = (rsinfINT1-rsINT1)/P.taurs;

output(8)  = (-iNaX2-iKX2-iCaLX2-iCaTX2-iSKX2-iHX2-iLX2+curr2)/P.CX;
output(9)  = (ninfX2-nX2)/tauNX2;
output(10) = (hinfX2-hX2)/P.tauh;
output(11) = P.phirT*(rTinfX2-rTX2)/taurTX2;
output(12) = -P.f*(P.eps*(iCaLX2+iCaTX2) + P.kCa*(CaiX2-P.bCa));
output(13) = (rinffX2-rfX2)/taurfX2;
output(14) = (rinfsX2-rsX2)/P.taurs;

output(15) = (-iNaCSN-iKCSN-iCaLCSN-iCaTCSN-iSKCSN-iHCSN-iLCSN-iGAi1csn-iAMx2csn-iAMCNCN)/P.CX;
output(16) = (ninfCSN-nCSN)/tauNCSN;
output(17) = (hinfCSN-hCSN)/P.tauh;
output(18) = P.phirT*(rTinfCSN-rTCSN)/taurTCSN;
output(19) = -P.f*(P.eps*(iCaLCSN+iCaTCSN) + P.kCa*(CaiCSN-P.bCa));
output(20) = (rinffCSN-rfCSN)/taurfCSN;
output(21) = (rinfsCSN-rsCSN)/P.taurs;

output(22) = P.arGA*TINT1*(1-sGAi1csn) - P.adGA*sGAi1csn;
output(23) = P.arAM*TX2*(1-sAMx2csn) - P.adAM*sAMx2csn;
output(24) = P.arAM*TCSN*(1-sAMCNCN) - P.adAM*sAMCNCN;
end