function [t, sol, spikeTimesModel] = Figure_S6()

P = get_common_params();

P.Iapp1 = 200;
P.Iapp2 = 200;

P.gCaTCSN = 0.9;
P.gSKCSN = 2;
P.gHCSN = 6;

P.from1 = 100;
P.to1   = 150;
delay   = 230;
P.from2 = 150 + delay;
P.to2   = P.from2 + 50;

P.tspan = 0:0.01:800;

[t, sol] = ode23(@(t,sol) FTN_Network_P_local(t,sol,P), P.tspan, P.init_cond);

VA = sol(:,1);
VE1 = sol(:,8);
VINT1 = sol(:,15);
VE2 = sol(:,22);
VINT2 = sol(:,29);
VE3 = sol(:,36);
VINTA1 = sol(:,43);
VINTA2 = sol(:,50);
VINTA3 = sol(:,57);
VCSN = sol(:,64);
VB = sol(:,71);
VINTB = sol(:,78);

spikeTimesModel = spike_times_local(VCSN,0.4);

samplingRate = 1;
step = 150;
i = 1;

figure('Color','w')
hold on
plot(t./samplingRate, VA,'Color',[0.46,0.01,0.65],'LineWidth',1); text(60,0,'A')
plot(t./samplingRate, VE1-step*i,'Color',[0.14,0.55,0.16],'LineWidth',1); text(60,-step*i,'E_1'); i=i+1;
plot(t./samplingRate, VINT1-step*i,'Color',[0.14,0.55,0.16],'LineWidth',1); text(60,-step*i,'I_1'); i=i+1;
plot(t./samplingRate, VE2-step*i,'Color',[0.14,0.55,0.16],'LineWidth',1); text(60,-step*i,'E_2'); i=i+1;
plot(t./samplingRate, VINT2-step*i,'Color',[0.14,0.55,0.16],'LineWidth',1); text(60,-step*i,'I_2'); i=i+1;
plot(t./samplingRate, VE3-step*i,'Color',[0.14,0.55,0.16],'LineWidth',1); text(60,-step*i,'E_3'); i=i+1;
plot(t./samplingRate, VINTA1-step*i,'Color',[0.95,0.72,0.02],'LineWidth',1); text(60,-step*i,'I_A_1'); i=i+1;
plot(t./samplingRate, VINTA2-step*i,'Color',[0.95,0.72,0.02],'LineWidth',1); text(60,-step*i,'I_A_2'); i=i+1;
plot(t./samplingRate, VINTA3-step*i,'Color',[0.95,0.72,0.02],'LineWidth',1); text(60,-step*i,'I_A_3'); i=i+1;
plot(t./samplingRate, VINTB-step*i,'Color',[0.61,0.62,0.67],'LineWidth',1); text(60,-step*i,'I_B'); i=i+1;
plot(t./samplingRate, VB-step*i,'Color',[0.61,0.62,0.67],'LineWidth',1); text(60,-step*i,'B'); i=i+1;
plot(t./samplingRate, VCSN-step*i,'Color',[0.04,0.17,0.55],'LineWidth',1); text(60,-step*i,'CSN');

yMin = min([VA;VE1;VINT1;VE2;VINT2;VE3;VINTA1;VINTA2;VINTA3;VB;VINTB;VCSN]) - (i * step) - 200;
yMax = max([VA;VE1;VINT1;VE2;VINT2;VE3;VINTA1;VINTA2;VINTA3;VB;VINTB;VCSN]) + 100;
axis([50 600 yMin yMax])

scaleLengthX = 25;
scaleLengthY = 100;
x_start = 570;
y_start = yMin + 100;

line([x_start, x_start + scaleLengthX], [y_start, y_start], 'Color', 'k', 'LineWidth', 2);
line([x_start, x_start], [y_start, y_start + scaleLengthY], 'Color', 'k', 'LineWidth', 2);

text(x_start + scaleLengthX/2, y_start - 50, '25 ms', 'HorizontalAlignment', 'center', 'FontSize', 10);
text(x_start - 5, y_start + scaleLengthY/2, '100 mV', 'HorizontalAlignment', 'right', 'FontSize', 10);

xlabel('Time (ms)', 'FontSize', 12, 'FontWeight', 'bold');
set(gca,'YTick',[]);
set(gca,'XTick',[]);
set(gca,'Visible','off');
box off
hold off

end


function P = get_common_params()
P.gCaTA = 0.5; P.gSKA = 2;
P.gCaTE1 = 2; P.gSKE1 = 3;
P.gCaTINT1 = 0.5; P.gCaTINT2 = 0.2; P.gCaTINTA1 = 0.2; P.gCaTINTA2 = 0.2; P.gCaTINTA3 = 0.2;
P.gCaTE2 = 3.5; P.gSKE2 = 3.5;
P.gCaTE3 = 3.5; P.gSKE3 = 3.5;
P.gCaTCSN = 0.9; P.gSKCSN = 2; P.gHCSN = 6;
P.gCaTB = 0.5; P.gSKB = 2; P.gCaTINTB = 0.2;

P.gAM_A_E1 = 20;
P.gAM_E1_I1 = 20;
P.gGA_I1_E2 = 20;
P.gAM_E2_I2 = 20;
P.gGA_I2_E3 = 20;
P.gAM_E3_I1 = 20;
P.gAM_E1_IA1 = 20;
P.gAM_E2_IA2 = 20;
P.gAM_E3_IA3 = 20;
P.gGA_IA1_CSN = 15;
P.gGA_IA2_CSN = 15;
P.gGA_IA3_CSN = 15;
P.gAM_B_IB = 15;
P.gGA_IB_I1 = 20;
P.gGA_IB_I2 = 20;
P.gGA_IB_IA2 = 20;
P.gGA_IB_IA3 = 20;
P.gAM_B_CSN = 3.5;
P.gAM_CSN_CSN = 10;

P.gNaINT = 800; P.gKINT = 1200; P.gHINT = 4; P.CINT = 20; P.krINT = 0.01;
P.gNaX = 800; P.gKX = 500; P.gHX = 6; P.CX = 20; P.krX = 0.3;
P.VL = -70; P.VK = -90; P.VNa = 70; P.VH = -30;
P.Tmax = 1; P.VT = 2; P.Kps = 5;
P.gL = 2; P.gCa = 19;
P.arGA = 5; P.adGA = 0.18; P.VGA = -100; P.arAM = 1.1; P.adAM = 0.19; P.VAM = 0;

P.taunbar = 10; P.tauh = 1; P.Ca_ex = 2.5; P.RTF = 26.7;
P.thetam = -35; P.thetan = -30; P.thetas = -20;
P.sigmam = -5; P.sigman = -5; P.sigmas = -0.05;
P.f = 0.1; P.eps = 0.0015; P.kCa = 0.3; P.bCa = 0.1; P.ks = 0.5;
P.taurs = 1500; P.thetarf = -105; P.thetars = -105; P.sigmarf = 5; P.sigmars = 25;
P.prf = 100; P.taur0 = 5; P.taur1 = 15; P.thetarrT = 68; P.sigmarrT = 2;
P.thetarT = -67; P.sigmarT = 2; P.thetaaT = -85; P.sigmaaT = -8;
P.thetab = 0.4; P.sigmab = -0.1; P.phirT = 0.2;

INTinit = [-67.6;0.5e-03;0.996;0.1355;0.1;5.5e-04;0.034];
Xinit = [-75;0.01;0.01;0.01;0.01;0.01;0.01];

P.init_cond = [Xinit;Xinit;INTinit;Xinit;INTinit;Xinit;INTinit;INTinit;INTinit; ...
               Xinit;Xinit;INTinit; ...
               0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01;0.01; ...
               0.01;0.01;0.01;0.01;0.01;0.01;0.01];
end


function output = FTN_Network_P_local(t,sol,P)

VA=sol(1);nA=sol(2);hA=sol(3);rTA=sol(4);CaiA=sol(5);rfA=sol(6);rsA=sol(7);
VE1=sol(8);nE1=sol(9);hE1=sol(10);rTE1=sol(11);CaiE1=sol(12);rfE1=sol(13);rsE1=sol(14);
VINT1=sol(15);nINT1=sol(16);hINT1=sol(17);rTINT1=sol(18);CaiINT1=sol(19);rfINT1=sol(20);rsINT1=sol(21);
VE2=sol(22);nE2=sol(23);hE2=sol(24);rTE2=sol(25);CaiE2=sol(26);rfE2=sol(27);rsE2=sol(28);
VINT2=sol(29);nINT2=sol(30);hINT2=sol(31);rTINT2=sol(32);CaiINT2=sol(33);rfINT2=sol(34);rsINT2=sol(35);
VE3=sol(36);nE3=sol(37);hE3=sol(38);rTE3=sol(39);CaiE3=sol(40);rfE3=sol(41);rsE3=sol(42);
VINTA1=sol(43);nINTA1=sol(44);hINTA1=sol(45);rTINTA1=sol(46);CaiINTA1=sol(47);rfINTA1=sol(48);rsINTA1=sol(49);
VINTA2=sol(50);nINTA2=sol(51);hINTA2=sol(52);rTINTA2=sol(53);CaiINTA2=sol(54);rfINTA2=sol(55);rsINTA2=sol(56);
VINTA3=sol(57);nINTA3=sol(58);hINTA3=sol(59);rTINTA3=sol(60);CaiINTA3=sol(61);rfINTA3=sol(62);rsINTA3=sol(63);
VCSN=sol(64);nCSN=sol(65);hCSN=sol(66);rTCSN=sol(67);CaiCSN=sol(68);rfCSN=sol(69);rsCSN=sol(70);
VB=sol(71);nB=sol(72);hB=sol(73);rTB=sol(74);CaiB=sol(75);rfB=sol(76);rsB=sol(77);
VINTB=sol(78);nINTB=sol(79);hINTB=sol(80);rTINTB=sol(81);CaiINTB=sol(82);rfINTB=sol(83);rsINTB=sol(84);

sAM_A_E1 = sol(85); sAM_E1_I1 = sol(86);sGA_I1_E2 = sol(87);sAM_E2_I2 = sol(88);sGA_I2_E3 = sol(89);sAM_E3_I1 = sol(90);
sAM_E1_IA1 = sol(91);sAM_E2_IA2 = sol(92);sAM_E3_IA3 = sol(93);sGA_IA1_CSN = sol(94);sGA_IA2_CSN = sol(95); sGA_IA3_CSN = sol(96);
sAM_B_IB = sol(97);sGA_IB_I1 = sol(98);sGA_IB_I2 = sol(99);sGA_IB_IA2 = sol(100);sGA_IB_IA3 = sol(101);sAM_B_CSN = sol(102);sAM_CSN_CSN = sol(103);

minfA = 1/(1+exp((VA-P.thetam)/P.sigmam)); ninfA = 1/(1+exp((VA-P.thetan)/P.sigman));tauNA = P.taunbar./cosh((VA-P.thetan)/(2*P.sigman)); alphaHA = 0.128*exp(-(VA+50)/18); betaHA = 4/(1+exp(-(VA+27)/5)); hinfA = alphaHA/(alphaHA+betaHA); iNaA = P.gNaX*(minfA^3)*hA*(VA-P.VNa); iKA = P.gKX*(nA^4)*(VA-P.VK);sinfA = 1/(1+exp((VA-P.thetas)/P.sigmas));iCaLA = P.gCa*(sinfA^2)*VA*(P.Ca_ex/(1-exp((2*VA)/P.RTF)));aTinfA = 1/(1+exp((VA-P.thetaaT)/P.sigmaaT));bTinfA = 1/(1+exp((rTA-P.thetab)/P.sigmab))-1/(1+exp(-P.thetab/P.sigmab)); rTinfA = 1/(1+exp((VA-P.thetarT)/P.sigmarT));taurTA = P.taur0+P.taur1/(1+exp((VA-P.thetarrT)/P.sigmarrT));iCaTA=P.gCaTA*(aTinfA^3)*(bTinfA^2)*VA*(P.Ca_ex/(1-exp((2*VA)/P.RTF))); kinfA = (CaiA^2)/(CaiA^2+(P.ks^2)); iSKA = P.gSKA*kinfA*(VA-P.VK); rinffA = 1./(1+exp((VA-P.thetarf)/P.sigmarf));rinfsA = 1./(1+exp((VA-P.thetars)/P.sigmars));taurfA = P.prf./(-7.4*(VA+70)./(exp(-(VA+70)/0.8)-1)+65*exp(-(VA+56)/23)); iHA = P.gHX*(P.krX*rfA+(1-P.krX)*rsA)*(VA-P.VH); iLA = P.gL*(VA-P.VL); TA = P.Tmax/(1+exp(-(VA-P.VT)/P.Kps));
minfE1 = 1/(1+exp((VE1-P.thetam)/P.sigmam)); ninfE1 = 1/(1+exp((VE1-P.thetan)/P.sigman)); tauNE1 = P.taunbar./cosh((VE1-P.thetan)/(2*P.sigman)); alphaHE1 = 0.128*exp(-(VE1+50)/18); betaHE1 = 4/(1+exp(-(VE1+27)/5)); hinfE1 = alphaHE1/(alphaHE1+betaHE1); iNaE1 = P.gNaX*(minfE1^3)*hE1*(VE1-P.VNa); iKE1 = P.gKX*(nE1^4)*(VE1-P.VK);sinfE1 = 1/(1+exp((VE1-P.thetas)/P.sigmas));iCaLE1 = P.gCa*(sinfE1^2)*VE1*(P.Ca_ex/(1-exp((2*VE1)/P.RTF)));aTinfE1 = 1/(1+exp((VE1-P.thetaaT)/P.sigmaaT));bTinfE1 = 1/(1+exp((rTE1-P.thetab)/P.sigmab))-1/(1+exp(-P.thetab/P.sigmab));rTinfE1 = 1/(1+exp((VE1-P.thetarT)/P.sigmarT));taurTE1 = P.taur0+P.taur1/(1+exp((VE1-P.thetarrT)/P.sigmarrT));iCaTE1=P.gCaTE1*(aTinfE1^3)*(bTinfE1^2)*VE1*(P.Ca_ex/(1-exp((2*VE1)/P.RTF))); kinfE1 = (CaiE1^2)/(CaiE1^2+(P.ks^2));iSKE1 = P.gSKE1*kinfE1*(VE1-P.VK);rinffE1 = 1./(1+exp((VE1-P.thetarf)/P.sigmarf));rinfsE1 = 1./(1+exp((VE1-P.thetars)/P.sigmars));taurfE1 = P.prf./(-7.4*(VE1+70)./(exp(-(VE1+70)/0.8)-1)+65*exp(-(VE1+56)/23)); iHE1 = P.gHX*(P.krX*rfE1+(1-P.krX)*rsE1)*(VE1-P.VH);iLE1 = P.gL*(VE1-P.VL); TE1 = P.Tmax/(1+exp(-(VE1-P.VT)/P.Kps));
sinfINT1=1/(1+ exp((VINT1-P.thetas)/P.sigmas)); iCaLINT1=P.gCa*(sinfINT1^2)*VINT1*(P.Ca_ex/(1-exp((2*VINT1)/P.RTF))); aTinfINT1=1/(1+ exp((VINT1-P.thetaaT)/P.sigmaaT)); bTinfINT1 = 1/(1+exp((rTINT1-P.thetab)/P.sigmab))-1/(1+exp(-P.thetab/P.sigmab)); rTinfINT1=1/(1+exp((VINT1-P.thetarT)/P.sigmarT)); taurTINT1=P.taur0+P.taur1/(1+exp((VINT1-P.thetarrT)/P.sigmarrT)); iCaTINT1=P.gCaTINT1*(aTinfINT1^3)*(bTinfINT1^2)*VINT1*(P.Ca_ex/(1-exp((2*VINT1)/P.RTF))); iLINT1=P.gL*(VINT1-P.VL); ninfINT1=1/(1+ exp((VINT1-P.thetan)/P.sigman)); taunINT1=P.taunbar/cosh((VINT1-P.thetan)/(2*P.sigman));  iKINT1=P.gKINT*(nINT1^4)*(VINT1-P.VK); minfINT1=1/(1+exp((VINT1-P.thetam)/P.sigmam)); alphahINT1=0.128*exp(-(VINT1+50)/18); betahINT1=4/(1+exp(-(VINT1+27)/5)); hinfINT1=alphahINT1/(alphahINT1 + betahINT1);  iNaINT1=P.gNaINT*(minfINT1^3)*hINT1*(VINT1-P.VNa);  rfinfINT1=1/(1+exp((VINT1-P.thetarf)/P.sigmarf)); taurfINT1=P.prf/(-7.4*(VINT1+70)/(exp(-(VINT1+70)/0.8)-1)+65*exp(-(VINT1+56)/23)); rsinfINT1=1/(1+exp((VINT1-P.thetars)/P.sigmars)); iHINT1=P.gHINT*(P.krINT*rfINT1+(1-P.krINT)*rsINT1)*(VINT1-P.VH); TINT1 = P.Tmax/(1+exp(-(VINT1-P.VT)/P.Kps));
minfE2 = 1/(1+exp((VE2-P.thetam)/P.sigmam)); ninfE2 = 1/(1+exp((VE2-P.thetan)/P.sigman)); tauNE2 = P.taunbar./cosh((VE2-P.thetan)/(2*P.sigman)); alphaHE2 = 0.128*exp(-(VE2+50)/18); betaHE2 = 4/(1+exp(-(VE2+27)/5)); hinfE2 = alphaHE2/(alphaHE2+betaHE2); iNaE2 = P.gNaX*(minfE2^3)*hE2*(VE2-P.VNa); iKE2 = P.gKX*(nE2^4)*(VE2-P.VK); sinfE2 = 1/(1+exp((VE2-P.thetas)/P.sigmas)); iCaLE2 = P.gCa*(sinfE2^2)*VE2*(P.Ca_ex/(1-exp((2*VE2)/P.RTF))); aTinfE2 = 1/(1+exp((VE2-P.thetaaT)/P.sigmaaT)); bTinfE2 = 1/(1+exp((rTE2-P.thetab)/P.sigmab))-1/(1+exp(-P.thetab/P.sigmab)); rTinfE2 = 1/(1+exp((VE2-P.thetarT)/P.sigmarT)); taurTE2 = P.taur0+P.taur1/(1+exp((VE2-P.thetarrT)/P.sigmarrT)); iCaTE2=P.gCaTE2*(aTinfE2^3)*(bTinfE2^2)*VE2*(P.Ca_ex/(1-exp((2*VE2)/P.RTF))); kinfE2 = (CaiE2^2)/(CaiE2^2+(P.ks^2)); iSKE2 = P.gSKE2*kinfE2*(VE2-P.VK); rinffE2 = 1./(1+exp((VE2-P.thetarf)/P.sigmarf)); rinfsE2 = 1./(1+exp((VE2-P.thetars)/P.sigmars)); taurfE2 = P.prf./(-7.4*(VE2+70)./(exp(-(VE2+70)/0.8)-1)+65*exp(-(VE2+56)/23)); iHE2 = P.gHX*(P.krX*rfE2+(1-P.krX)*rsE2)*(VE2-P.VH); iLE2 = P.gL*(VE2-P.VL); TE2 = P.Tmax/(1+exp(-(VE2-P.VT)/P.Kps));
sinfINT2=1/(1+ exp((VINT2-P.thetas)/P.sigmas)); iCaLINT2=P.gCa*(sinfINT2^2)*VINT2*(P.Ca_ex/(1-exp((2*VINT2)/P.RTF))); aTinfINT2=1/(1+ exp((VINT2-P.thetaaT)/P.sigmaaT)); bTinfINT2 = 1/(1+exp((rTINT2-P.thetab)/P.sigmab))-1/(1+exp(-P.thetab/P.sigmab)); rTinfINT2=1/(1+exp((VINT2-P.thetarT)/P.sigmarT)); taurTINT2=P.taur0+P.taur1/(1+exp((VINT2-P.thetarrT)/P.sigmarrT)); iCaTINT2=P.gCaTINT2*(aTinfINT2^3)*(bTinfINT2^2)*VINT2*(P.Ca_ex/(1-exp((2*VINT2)/P.RTF))); iLINT2=P.gL*(VINT2-P.VL); ninfINT2=1/(1+ exp((VINT2-P.thetan)/P.sigman)); taunINT2=P.taunbar/cosh((VINT2-P.thetan)/(2*P.sigman));  iKINT2=P.gKINT*(nINT2^4)*(VINT2-P.VK); minfINT2=1/(1+exp((VINT2-P.thetam)/P.sigmam)); alphahINT2=0.128*exp(-(VINT2+50)/18); betahINT2=4/(1+exp(-(VINT2+27)/5)); hinfINT2=alphahINT2/(alphahINT2 + betahINT2);  iNaINT2=P.gNaINT*(minfINT2^3)*hINT2*(VINT2-P.VNa);  rfinfINT2=1/(1+exp((VINT2-P.thetarf)/P.sigmarf)); taurfINT2=P.prf/(-7.4*(VINT2+70)/(exp(-(VINT2+70)/0.8)-1)+65*exp(-(VINT2+56)/23)); rsinfINT2=1/(1+exp((VINT2-P.thetars)/P.sigmars)); iHINT2=P.gHINT*(P.krINT*rfINT2+(1-P.krINT)*rsINT2)*(VINT2-P.VH); TINT2 = P.Tmax/(1+exp(-(VINT2-P.VT)/P.Kps));
minfE3 = 1/(1+exp((VE3-P.thetam)/P.sigmam)); ninfE3 = 1/(1+exp((VE3-P.thetan)/P.sigman)); tauNE3 = P.taunbar./cosh((VE3-P.thetan)/(2*P.sigman)); alphaHE3 = 0.128*exp(-(VE3+50)/18); betaHE3 = 4/(1+exp(-(VE3+27)/5)); hinfE3 = alphaHE3/(alphaHE3+betaHE3); iNaE3 = P.gNaX*(minfE3^3)*hE3*(VE3-P.VNa); iKE3 = P.gKX*(nE3^4)*(VE3-P.VK); sinfE3 = 1/(1+exp((VE3-P.thetas)/P.sigmas)); iCaLE3 = P.gCa*(sinfE3^2)*VE3*(P.Ca_ex/(1-exp((2*VE3)/P.RTF))); aTinfE3 = 1/(1+exp((VE3-P.thetaaT)/P.sigmaaT)); bTinfE3 = 1/(1+exp((rTE3-P.thetab)/P.sigmab))-1/(1+exp(-P.thetab/P.sigmab)); rTinfE3 = 1/(1+exp((VE3-P.thetarT)/P.sigmarT)); taurTE3 = P.taur0+P.taur1/(1+exp((VE3-P.thetarrT)/P.sigmarrT)); iCaTE3=P.gCaTE3*(aTinfE3^3)*(bTinfE3^2)*VE3*(P.Ca_ex/(1-exp((2*VE3)/P.RTF))); kinfE3 = (CaiE3^2)/(CaiE3^2+(P.ks^2)); iSKE3 = P.gSKE3*kinfE3*(VE3-P.VK); rinffE3 = 1./(1+exp((VE3-P.thetarf)/P.sigmarf)); rinfsE3 = 1./(1+exp((VE3-P.thetars)/P.sigmars)); taurfE3 = P.prf./(-7.4*(VE3+70)./(exp(-(VE3+70)/0.8)-1)+65*exp(-(VE3+56)/23)); iHE3 = P.gHX*(P.krX*rfE3+(1-P.krX)*rsE3)*(VE3-P.VH); iLE3 = P.gL*(VE3-P.VL); TE3 = P.Tmax/(1+exp(-(VE3-P.VT)/P.Kps));
sinfINTA1=1/(1+ exp((VINTA1-P.thetas)/P.sigmas)); iCaLINTA1=P.gCa*(sinfINTA1^2)*VINTA1*(P.Ca_ex/(1-exp((2*VINTA1)/P.RTF))); aTinfINTA1=1/(1+ exp((VINTA1-P.thetaaT)/P.sigmaaT)); bTinfINTA1 = 1/(1+exp((rTINTA1-P.thetab)/P.sigmab))-1/(1+exp(-P.thetab/P.sigmab)); rTinfINTA1=1/(1+exp((VINTA1-P.thetarT)/P.sigmarT)); taurTINTA1=P.taur0+P.taur1/(1+exp((VINTA1-P.thetarrT)/P.sigmarrT)); iCaTINTA1=P.gCaTINTA1*(aTinfINTA1^3)*(bTinfINTA1^2)*VINTA1*(P.Ca_ex/(1-exp((2*VINTA1)/P.RTF))); iLINTA1=P.gL*(VINTA1-P.VL); ninfINTA1=1/(1+ exp((VINTA1-P.thetan)/P.sigman)); taunINTA1=P.taunbar/cosh((VINTA1-P.thetan)/(2*P.sigman));  iKINTA1=P.gKINT*(nINTA1^4)*(VINTA1-P.VK); minfINTA1=1/(1+exp((VINTA1-P.thetam)/P.sigmam)); alphahINTA1=0.128*exp(-(VINTA1+50)/18); betahINTA1=4/(1+exp(-(VINTA1+27)/5)); hinfINTA1=alphahINTA1/(alphahINTA1 + betahINTA1);  iNaINTA1=P.gNaINT*(minfINTA1^3)*hINTA1*(VINTA1-P.VNa);  rfinfINTA1=1/(1+exp((VINTA1-P.thetarf)/P.sigmarf)); taurfINTA1=P.prf/(-7.4*(VINTA1+70)/(exp(-(VINTA1+70)/0.8)-1)+65*exp(-(VINTA1+56)/23)); rsinfINTA1=1/(1+exp((VINTA1-P.thetars)/P.sigmars)); iHINTA1=P.gHINT*(P.krINT*rfINTA1+(1-P.krINT)*rsINTA1)*(VINTA1-P.VH); TINTA1 = P.Tmax/(1+exp(-(VINTA1-P.VT)/P.Kps));
sinfINTA2=1/(1+ exp((VINTA2-P.thetas)/P.sigmas)); iCaLINTA2=P.gCa*(sinfINTA2^2)*VINTA2*(P.Ca_ex/(1-exp((2*VINTA2)/P.RTF))); aTinfINTA2=1/(1+ exp((VINTA2-P.thetaaT)/P.sigmaaT)); bTinfINTA2 = 1/(1+exp((rTINTA2-P.thetab)/P.sigmab))-1/(1+exp(-P.thetab/P.sigmab)); rTinfINTA2=1/(1+exp((VINTA2-P.thetarT)/P.sigmarT)); taurTINTA2=P.taur0+P.taur1/(1+exp((VINTA2-P.thetarrT)/P.sigmarrT)); iCaTINTA2=P.gCaTINTA2*(aTinfINTA2^3)*(bTinfINTA2^2)*VINTA2*(P.Ca_ex/(1-exp((2*VINTA2)/P.RTF))); iLINTA2=P.gL*(VINTA2-P.VL); ninfINTA2=1/(1+ exp((VINTA2-P.thetan)/P.sigman)); taunINTA2=P.taunbar/cosh((VINTA2-P.thetan)/(2*P.sigman));  iKINTA2=P.gKINT*(nINTA2^4)*(VINTA2-P.VK); minfINTA2=1/(1+exp((VINTA2-P.thetam)/P.sigmam)); alphahINTA2=0.128*exp(-(VINTA2+50)/18); betahINTA2=4/(1+exp(-(VINTA2+27)/5)); hinfINTA2=alphahINTA2/(alphahINTA2 + betahINTA2);  iNaINTA2=P.gNaINT*(minfINTA2^3)*hINTA2*(VINTA2-P.VNa);  rfinfINTA2=1/(1+exp((VINTA2-P.thetarf)/P.sigmarf)); taurfINTA2=P.prf/(-7.4*(VINTA2+70)/(exp(-(VINTA2+70)/0.8)-1)+65*exp(-(VINTA2+56)/23)); rsinfINTA2=1/(1+exp((VINTA2-P.thetars)/P.sigmars)); iHINTA2=P.gHINT*(P.krINT*rfINTA2+(1-P.krINT)*rsINTA2)*(VINTA2-P.VH); TINTA2 = P.Tmax/(1+exp(-(VINTA2-P.VT)/P.Kps));
sinfINTA3=1/(1+ exp((VINTA3-P.thetas)/P.sigmas)); iCaLINTA3=P.gCa*(sinfINTA3^2)*VINTA3*(P.Ca_ex/(1-exp((2*VINTA3)/P.RTF))); aTinfINTA3=1/(1+ exp((VINTA3-P.thetaaT)/P.sigmaaT)); bTinfINTA3 = 1/(1+exp((rTINTA3-P.thetab)/P.sigmab))-1/(1+exp(-P.thetab/P.sigmab)); rTinfINTA3=1/(1+exp((VINTA3-P.thetarT)/P.sigmarT)); taurTINTA3=P.taur0+P.taur1/(1+exp((VINTA3-P.thetarrT)/P.sigmarrT)); iCaTINTA3=P.gCaTINTA3*(aTinfINTA3^3)*(bTinfINTA3^2)*VINTA3*(P.Ca_ex/(1-exp((2*VINTA3)/P.RTF))); iLINTA3=P.gL*(VINTA3-P.VL); ninfINTA3=1/(1+ exp((VINTA3-P.thetan)/P.sigman)); taunINTA3=P.taunbar/cosh((VINTA3-P.thetan)/(2*P.sigman));  iKINTA3=P.gKINT*(nINTA3^4)*(VINTA3-P.VK); minfINTA3=1/(1+exp((VINTA3-P.thetam)/P.sigmam)); alphahINTA3=0.128*exp(-(VINTA3+50)/18); betahINTA3=4/(1+exp(-(VINTA3+27)/5)); hinfINTA3=alphahINTA3/(alphahINTA3 + betahINTA3);  iNaINTA3=P.gNaINT*(minfINTA3^3)*hINTA3*(VINTA3-P.VNa);  rfinfINTA3=1/(1+exp((VINTA3-P.thetarf)/P.sigmarf)); taurfINTA3=P.prf/(-7.4*(VINTA3+70)/(exp(-(VINTA3+70)/0.8)-1)+65*exp(-(VINTA3+56)/23)); rsinfINTA3=1/(1+exp((VINTA3-P.thetars)/P.sigmars)); iHINTA3=P.gHINT*(P.krINT*rfINTA3+(1-P.krINT)*rsINTA3)*(VINTA3-P.VH); TINTA3 = P.Tmax/(1+exp(-(VINTA3-P.VT)/P.Kps));
minfCSN = 1/(1+exp((VCSN-P.thetam)/P.sigmam)); ninfCSN = 1/(1+exp((VCSN-P.thetan)/P.sigman)); tauNCSN = P.taunbar./cosh((VCSN-P.thetan)/(2*P.sigman)); alphaHCSN = 0.128*exp(-(VCSN+50)/18); betaHCSN = 4/(1+exp(-(VCSN+27)/5)); hinfCSN = alphaHCSN/(alphaHCSN+betaHCSN); iNaCSN = P.gNaX*(minfCSN^3)*hCSN*(VCSN-P.VNa); iKCSN = P.gKX*(nCSN^4)*(VCSN-P.VK);sinfCSN = 1/(1+exp((VCSN-P.thetas)/P.sigmas));iCaLCSN = P.gCa*(sinfCSN^2)*VCSN*(P.Ca_ex/(1-exp((2*VCSN)/P.RTF)));aTinfCSN = 1/(1+exp((VCSN-P.thetaaT)/P.sigmaaT));bTinfCSN = 1/(1+exp((rTCSN-P.thetab)/P.sigmab))-1/(1+exp(-P.thetab/P.sigmab));rTinfCSN = 1/(1+exp((VCSN-P.thetarT)/P.sigmarT));taurTCSN = P.taur0+P.taur1/(1+exp((VCSN-P.thetarrT)/P.sigmarrT));iCaTCSN=P.gCaTCSN*(aTinfCSN^3)*(bTinfCSN^2)*VCSN*(P.Ca_ex/(1-exp((2*VCSN)/P.RTF))); kinfCSN = (CaiCSN^2)/(CaiCSN^2+(P.ks^2));iSKCSN = P.gSKCSN*kinfCSN*(VCSN-P.VK);rinffCSN = 1./(1+exp((VCSN-P.thetarf)/P.sigmarf));rinfsCSN = 1./(1+exp((VCSN-P.thetars)/P.sigmars));taurfCSN = P.prf./(-7.4*(VCSN+70)./(exp(-(VCSN+70)/0.8)-1)+65*exp(-(VCSN+56)/23)); iHCSN = P.gHCSN*(P.krX*rfCSN+(1-P.krX)*rsCSN)*(VCSN-P.VH);iLCSN = P.gL*(VCSN-P.VL); TCSN = P.Tmax/(1+exp(-(VCSN-P.VT)/P.Kps));
minfB = 1/(1+exp((VB-P.thetam)/P.sigmam)); ninfB = 1/(1+exp((VB-P.thetan)/P.sigman));tauNB = P.taunbar./cosh((VB-P.thetan)/(2*P.sigman)); alphaHB = 0.128*exp(-(VB+50)/18); betaHB = 4/(1+exp(-(VB+27)/5)); hinfB = alphaHB/(alphaHB+betaHB); iNaB = P.gNaX*(minfB^3)*hB*(VB-P.VNa); iKB = P.gKX*(nB^4)*(VB-P.VK);sinfB = 1/(1+exp((VB-P.thetas)/P.sigmas));iCaLB = P.gCa*(sinfB^2)*VB*(P.Ca_ex/(1-exp((2*VB)/P.RTF)));aTinfB = 1/(1+exp((VB-P.thetaaT)/P.sigmaaT));bTinfB = 1/(1+exp((rTB-P.thetab)/P.sigmab))-1/(1+exp(-P.thetab/P.sigmab)); rTinfB = 1/(1+exp((VB-P.thetarT)/P.sigmarT));taurTB = P.taur0+P.taur1/(1+exp((VB-P.thetarrT)/P.sigmarrT));iCaTB=P.gCaTB*(aTinfB^3)*(bTinfB^2)*VB*(P.Ca_ex/(1-exp((2*VB)/P.RTF))); kinfB = (CaiB^2)/(CaiB^2+(P.ks^2)); iSKB = P.gSKB*kinfB*(VB-P.VK); rinffB = 1./(1+exp((VB-P.thetarf)/P.sigmarf));rinfsB = 1./(1+exp((VB-P.thetars)/P.sigmars));taurfB = P.prf./(-7.4*(VB+70)./(exp(-(VB+70)/0.8)-1)+65*exp(-(VB+56)/23)); iHB = P.gHX*(P.krX*rfB+(1-P.krX)*rsB)*(VB-P.VH); iLB = P.gL*(VB-P.VL); TB = P.Tmax/(1+exp(-(VB-P.VT)/P.Kps));
sinfINTB=1/(1+ exp((VINTB-P.thetas)/P.sigmas)); iCaLINTB=P.gCa*(sinfINTB^2)*VINTB*(P.Ca_ex/(1-exp((2*VINTB)/P.RTF))); aTinfINTB=1/(1+ exp((VINTB-P.thetaaT)/P.sigmaaT)); bTinfINTB = 1/(1+exp((rTINTB-P.thetab)/P.sigmab))-1/(1+exp(-P.thetab/P.sigmab)); rTinfINTB=1/(1+exp((VINTB-P.thetarT)/P.sigmarT)); taurTINTB=P.taur0+P.taur1/(1+exp((VINTB-P.thetarrT)/P.sigmarrT)); iCaTINTB=P.gCaTINTB*(aTinfINTB^3)*(bTinfINTB^2)*VINTB*(P.Ca_ex/(1-exp((2*VINTB)/P.RTF))); iLINTB=P.gL*(VINTB-P.VL); ninfINTB=1/(1+ exp((VINTB-P.thetan)/P.sigman)); taunINTB=P.taunbar/cosh((VINTB-P.thetan)/(2*P.sigman));  iKINTB=P.gKINT*(nINTB^4)*(VINTB-P.VK); minfINTB=1/(1+exp((VINTB-P.thetam)/P.sigmam)); alphahINTB=0.128*exp(-(VINTB+50)/18); betahINTB=4/(1+exp(-(VINTB+27)/5)); hinfINTB=alphahINTB/(alphahINTB + betahINTB);  iNaINTB=P.gNaINT*(minfINTB^3)*hINTB*(VINTB-P.VNa);  rfinfINTB=1/(1+exp((VINTB-P.thetarf)/P.sigmarf)); taurfINTB=P.prf/(-7.4*(VINTB+70)/(exp(-(VINTB+70)/0.8)-1)+65*exp(-(VINTB+56)/23)); rsinfINTB=1/(1+exp((VINTB-P.thetars)/P.sigmars)); iHINTB=P.gHINT*(P.krINT*rfINTB+(1-P.krINT)*rsINTB)*(VINTB-P.VH); TINTB = P.Tmax/(1+exp(-(VINTB-P.VT)/P.Kps));

iAM_A_E1=P.gAM_A_E1*sAM_A_E1*(VE1-P.VAM);
iAM_E1_I1=P.gAM_E1_I1*sAM_E1_I1*(VINT1-P.VAM);
iGA_I1_E2=P.gGA_I1_E2*sGA_I1_E2*(VE2-P.VGA);
iAM_E2_I2=P.gAM_E2_I2*sAM_E2_I2*(VINT2-P.VAM);
iGA_I2_E3=P.gGA_I2_E3*sGA_I2_E3*(VE3-P.VGA);
iAM_E3_I1=P.gAM_E3_I1*sAM_E3_I1*(VINT1-P.VAM);
iAM_E1_IA1=P.gAM_E1_IA1*sAM_E1_IA1*(VINTA1-P.VAM);
iAM_E2_IA2=P.gAM_E2_IA2*sAM_E2_IA2*(VINTA2-P.VAM);
iAM_E3_IA3=P.gAM_E3_IA3*sAM_E3_IA3*(VINTA3-P.VAM);
iGA_IA1_CSN=P.gGA_IA1_CSN*sGA_IA1_CSN*(VCSN-P.VGA);
iGA_IA2_CSN=P.gGA_IA2_CSN*sGA_IA2_CSN*(VCSN-P.VGA);
iGA_IA3_CSN=P.gGA_IA3_CSN*sGA_IA3_CSN*(VCSN-P.VGA);
iAM_B_IB=P.gAM_B_IB*sAM_B_IB*(VINTB-P.VAM);
iGA_IB_I1=P.gGA_IB_I1*sGA_IB_I1*(VINT1-P.VGA);
iGA_IB_I2=P.gGA_IB_I2*sGA_IB_I2*(VINT2-P.VGA);
iGA_IB_IA2=P.gGA_IB_IA2*sGA_IB_IA2*(VINTA2-P.VGA);
iGA_IB_IA3=P.gGA_IB_IA3*sGA_IB_IA3*(VINTA3-P.VGA);
iAM_B_CSN=P.gAM_B_CSN*sAM_B_CSN*(VCSN-P.VAM);
iAM_CSN_CSN=P.gAM_CSN_CSN*sAM_CSN_CSN*(VCSN-P.VAM);

if (t>P.from1 && t<P.to1)
    curr1=P.Iapp1;
else
    curr1=0;
end

if (t>P.from2 && t<P.to2)
    curr2=P.Iapp2;
else
    curr2=0;
end

output=zeros(103,1);

output(1)=(-iNaA-iKA-iCaLA-iCaTA-iSKA-iHA-iLA+curr1)/P.CX;
output(2)=(ninfA-nA)/tauNA;
output(3)=(hinfA-hA)/P.tauh;
output(4)=P.phirT*(rTinfA-rTA)/taurTA;
output(5)=-P.f*(P.eps*(iCaLA+iCaTA)+ P.kCa*(CaiA-P.bCa));
output(6)=(rinffA-rfA)/taurfA;
output(7)=(rinfsA-rsA)/P.taurs;

output(8)=(-iNaE1-iKE1-iCaLE1-iCaTE1-iSKE1-iHE1-iLE1-iAM_A_E1)/P.CX;
output(9)=(ninfE1-nE1)/tauNE1;
output(10)=(hinfE1-hE1)/P.tauh;
output(11)=P.phirT*(rTinfE1-rTE1)/taurTE1;
output(12)=-P.f*(P.eps*(iCaLE1+iCaTE1)+ P.kCa*(CaiE1-P.bCa));
output(13)=(rinffE1-rfE1)/taurfE1;
output(14)=(rinfsE1-rsE1)/P.taurs;

output(15)=(-iNaINT1-iKINT1-iCaLINT1-iCaTINT1-iHINT1-iLINT1-iAM_E1_I1-iAM_E3_I1-iGA_IB_I1)/P.CINT;
output(16)=(ninfINT1-nINT1)/taunINT1;
output(17)=(hinfINT1-hINT1)/P.tauh;
output(18)=P.phirT*(rTinfINT1-rTINT1)/taurTINT1;
output(19)=-P.f*(P.eps*(iCaLINT1+iCaTINT1)+ P.kCa*(CaiINT1-P.bCa));
output(20)=(rfinfINT1-rfINT1)/taurfINT1;
output(21)=(rsinfINT1-rsINT1)/P.taurs;

output(22)=(-iNaE2-iKE2-iCaLE2-iCaTE2-iSKE2-iHE2-iLE2-iGA_I1_E2)/P.CX;
output(23)=(ninfE2-nE2)/tauNE2;
output(24)=(hinfE2-hE2)/P.tauh;
output(25)=P.phirT*(rTinfE2-rTE2)/taurTE2;
output(26)=-P.f*(P.eps*(iCaLE2+iCaTE2)+ P.kCa*(CaiE2-P.bCa));
output(27)=(rinffE2-rfE2)/taurfE2;
output(28)=(rinfsE2-rsE2)/P.taurs;

output(29)=(-iNaINT2-iKINT2-iCaLINT2-iCaTINT2-iHINT2-iLINT2-iAM_E2_I2-iGA_IB_I2)/P.CINT;
output(30)=(ninfINT2-nINT2)/taunINT2;
output(31)=(hinfINT2-hINT2)/P.tauh;
output(32)=P.phirT*(rTinfINT2-rTINT2)/taurTINT2;
output(33)=-P.f*(P.eps*(iCaLINT2+iCaTINT2)+ P.kCa*(CaiINT2-P.bCa));
output(34)=(rfinfINT2-rfINT2)/taurfINT2;
output(35)=(rsinfINT2-rsINT2)/P.taurs;

output(36)=(-iNaE3-iKE3-iCaLE3-iCaTE3-iSKE3-iHE3-iLE3-iGA_I2_E3)/P.CX;
output(37)=(ninfE3-nE3)/tauNE3;
output(38)=(hinfE3-hE3)/P.tauh;
output(39)=P.phirT*(rTinfE3-rTE3)/taurTE3;
output(40)=-P.f*(P.eps*(iCaLE3+iCaTE3)+ P.kCa*(CaiE3-P.bCa));
output(41)=(rinffE3-rfE3)/taurfE3;
output(42)=(rinfsE3-rsE3)/P.taurs;

output(43)=(-iNaINTA1-iKINTA1-iCaLINTA1-iCaTINTA1-iHINTA1-iLINTA1-iAM_E1_IA1)/P.CINT;
output(44)=(ninfINTA1-nINTA1)/taunINTA1;
output(45)=(hinfINTA1-hINTA1)/P.tauh;
output(46)=P.phirT*(rTinfINTA1-rTINTA1)/taurTINTA1;
output(47)=-P.f*(P.eps*(iCaLINTA1+iCaTINTA1)+ P.kCa*(CaiINTA1-P.bCa));
output(48)=(rfinfINTA1-rfINTA1)/taurfINTA1;
output(49)=(rsinfINTA1-rsINTA1)/P.taurs;

output(50)=(-iNaINTA2-iKINTA2-iCaLINTA2-iCaTINTA2-iHINTA2-iLINTA2-iAM_E2_IA2-iGA_IB_IA2)/P.CINT;
output(51)=(ninfINTA2-nINTA2)/taunINTA2;
output(52)=(hinfINTA2-hINTA2)/P.tauh;
output(53)=P.phirT*(rTinfINTA2-rTINTA2)/taurTINTA2;
output(54)=-P.f*(P.eps*(iCaLINTA2+iCaTINTA2)+ P.kCa*(CaiINTA2-P.bCa));
output(55)=(rfinfINTA2-rfINTA2)/taurfINTA2;
output(56)=(rsinfINTA2-rsINTA2)/P.taurs;

output(57)=(-iNaINTA3-iKINTA3-iCaLINTA3-iCaTINTA3-iHINTA3-iLINTA3-iAM_E3_IA3-iGA_IB_IA3)/P.CINT;
output(58)=(ninfINTA3-nINTA3)/taunINTA3;
output(59)=(hinfINTA3-hINTA3)/P.tauh;
output(60)=P.phirT*(rTinfINTA3-rTINTA3)/taurTINTA3;
output(61)=-P.f*(P.eps*(iCaLINTA3+iCaTINTA3)+ P.kCa*(CaiINTA3-P.bCa));
output(62)=(rfinfINTA3-rfINTA3)/taurfINTA3;
output(63)=(rsinfINTA3-rsINTA3)/P.taurs;

output(64)=(-iNaCSN-iKCSN-iCaLCSN-iCaTCSN-iSKCSN-iHCSN-iLCSN-iGA_IA1_CSN-iGA_IA2_CSN-iGA_IA3_CSN-iAM_B_CSN-iAM_CSN_CSN)/P.CX;
output(65)=(ninfCSN-nCSN)/tauNCSN;
output(66)=(hinfCSN-hCSN)/P.tauh;
output(67)=P.phirT*(rTinfCSN-rTCSN)/taurTCSN;
output(68)=-P.f*(P.eps*(iCaLCSN+iCaTCSN)+ P.kCa*(CaiCSN-P.bCa));
output(69)=(rinffCSN-rfCSN)/taurfCSN;
output(70)=(rinfsCSN-rsCSN)/P.taurs;

output(71)=(-iNaB-iKB-iCaLB-iCaTB-iSKB-iHB-iLB+curr2)/P.CX;
output(72)=(ninfB-nB)/tauNB;
output(73)=(hinfB-hB)/P.tauh;
output(74)=P.phirT*(rTinfB-rTB)/taurTB;
output(75)=-P.f*(P.eps*(iCaLB+iCaTB)+ P.kCa*(CaiB-P.bCa));
output(76)=(rinffB-rfB)/taurfB;
output(77)=(rinfsB-rsB)/P.taurs;

output(78)=(-iNaINTB-iKINTB-iCaLINTB-iCaTINTB-iHINTB-iLINTB-iAM_B_IB)/P.CINT;
output(79)=(ninfINTB-nINTB)/taunINTB;
output(80)=(hinfINTB-hINTB)/P.tauh;
output(81)=P.phirT*(rTinfINTB-rTINTB)/taurTINTB;
output(82)=-P.f*(P.eps*(iCaLINTB+iCaTINTB)+ P.kCa*(CaiINTB-P.bCa));
output(83)=(rfinfINTB-rfINTB)/taurfINTB;
output(84)=(rsinfINTB-rsINTB)/P.taurs;

output(85)=P.arAM*TA*(1-sAM_A_E1)-P.adAM*sAM_A_E1;
output(86)=P.arAM*TE1*(1-sAM_E1_I1)-P.adAM*sAM_E1_I1;
output(87)=P.arGA*TINT1*(1-sGA_I1_E2)-P.adGA*sGA_I1_E2;
output(88)=P.arAM*TE2*(1-sAM_E2_I2)-P.adAM*sAM_E2_I2;
output(89)=P.arGA*TINT2*(1-sGA_I2_E3)-P.adGA*sGA_I2_E3;
output(90)=P.arAM*TE3*(1-sAM_E3_I1)-P.adAM*sAM_E3_I1;
output(91)=P.arAM*TE1*(1-sAM_E1_IA1)-P.adAM*sAM_E1_IA1;
output(92)=P.arAM*TE2*(1-sAM_E2_IA2)-P.adAM*sAM_E2_IA2;
output(93)=P.arAM*TE3*(1-sAM_E3_IA3)-P.adAM*sAM_E3_IA3;
output(94)=P.arGA*TINTA1*(1-sGA_IA1_CSN)-P.adGA*sGA_IA1_CSN;
output(95)=P.arGA*TINTA2*(1-sGA_IA2_CSN)-P.adGA*sGA_IA2_CSN;
output(96)=P.arGA*TINTA3*(1-sGA_IA3_CSN)-P.adGA*sGA_IA3_CSN;
output(97)=P.arAM*TB*(1-sAM_B_IB)-P.adAM*sAM_B_IB;
output(98)=P.arGA*TINTB*(1-sGA_IB_I1)-P.adGA*sGA_IB_I1;
output(99)=P.arGA*TINTB*(1-sGA_IB_I2)-P.adGA*sGA_IB_I2;
output(100)=P.arGA*TINTB*(1-sGA_IB_IA2)-P.adGA*sGA_IB_IA2;
output(101)=P.arGA*TINTB*(1-sGA_IB_IA3)-P.adGA*sGA_IB_IA3;
output(102)=P.arAM*TB*(1-sAM_B_CSN)-P.adAM*sAM_B_CSN;
output(103)=P.arAM*TCSN*(1-sAM_CSN_CSN)-P.adAM*sAM_CSN_CSN;
end


function out1 = spike_times_local(trace,threshold)
gim = trace;

if nargin>1
    threshold1=threshold;
else
    threshold1=0.5;
end

set_crossgi=find(gim(1:end) > threshold1*max(gim));

if isempty(set_crossgi) < 1
    index_shift_posgi(1)=min(set_crossgi);
    index_shift_neggi(length(set_crossgi))=max(set_crossgi);

    for i=1:length(set_crossgi)-1
        if set_crossgi(i+1) > set_crossgi(i)+1
            index_shift_posgi(i+1)=i;
            index_shift_neggi(i)=i;
        end
    end

    set_cross_plusgi = set_crossgi(find(index_shift_posgi));
    set_cross_minusgi = set_crossgi(find(index_shift_neggi));
    set_cross_minusgi(length(set_cross_plusgi)) = set_crossgi(end);

    nspikes = length(set_cross_plusgi);

    spikemax = zeros(1,nspikes);
    for i=1:nspikes
        spikemax(i)=min(find(gim(set_cross_plusgi(i):set_cross_minusgi(i)) == max(gim(set_cross_plusgi(i):set_cross_minusgi(i))),1,'first')) + set_cross_plusgi(i)-1;
    end
else
    spikemax=[];
end

out1 = spikemax;
end