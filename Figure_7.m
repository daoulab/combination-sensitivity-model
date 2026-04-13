clear; clc;

%% ===== 1. Embedded matrices ==========================================

M1 = [ ...
    3,4,4,4,4,5,5,5,6,6;
    4,4,4,5,5,5,6,6,7,7;
    4,5,5,6,6,7,7,8,8,9;
    4,5,5,6,6,7,7,7,8,8;
    5,6,6,7,7,8,8,9,10,10;
    5,6,6,7,7,8,8,9,9,9;
    6,7,7,8,9,9,9,10,11,11;
    5,6,7,7,8,8,8,9,9,9;
    5,6,6,6,6,7,7,7,8,8;
    5,6,5,6,6,6,9,6,6,3];

M2 = [ ...
    4,4,4,4,4,4,4,4,4,4;
    4,4,4,4,4,4,5,5,5,5;
    5,5,5,5,5,5,6,6,6,6;
    5,5,5,5,5,6,6,6,6,6;
    6,6,6,6,6,7,7,7,7,7;
    6,6,6,6,6,7,7,7,7,7;
    7,7,7,7,8,8,8,8,8,8;
    6,6,7,7,6,6,6,7,8,7;
    5,5,6,6,6,8,8,8,6,7;
    5,5,5,5,7,7,7,8,6,6];

M3 = [ ...
    4,4,4,4,4,4,5,5,5,5;
    4,4,5,5,5,5,5,5,5,5;
    5,5,5,5,5,5,5,6,6,6;
    5,5,5,6,6,6,6,6,6,6;
    6,6,6,6,6,6,6,6,7,7;
    6,6,6,7,7,7,7,7,7,7;
    7,7,7,7,7,7,7,7,7,7;
    7,7,7,7,7,7,7,7,8,8;
    8,8,8,8,8,8,8,8,8,8;
    8,8,8,8,8,8,8,8,8,8];

M4 = [ ...
    1,1,2,2,3,3,3,4,4,4;
    3,4,4,4,4,4,5,5,5,5;
    4,4,4,4,4,5,5,5,5,5;
    4,4,4,4,5,5,5,5,5,5;
    4,4,4,4,5,5,5,5,5,5;
    4,4,4,4,4,5,5,5,5,5;
    4,4,4,4,4,5,5,5,5,5;
    4,4,4,4,4,5,5,5,5,5;
    4,4,4,4,4,5,5,5,5,5;
    4,4,4,4,4,5,5,5,5,5];

M5 = [ ...
    0,0,0,0,0,0,0,0,0,0;
    0,3,5,7,7,7,7,7,7,7;
    0,3,6,7,8,8,8,8,8,8;
    0,3,6,8,9,9,9,9,9,9;
    0,3,6,8,9,10,10,10,10,10;
    1,4,7,9,10,10,10,10,10,10;
    3,5,8,10,11,11,11,11,11,11;
    3,5,8,10,11,11,11,11,11,11;
    3,5,8,10,11,12,12,12,12,12;
    2,5,8,10,12,12,12,12,12,12];

M6 = [ ...
    0,0,0,0,0,0,0,2,3,4;
    0,0,0,0,0,0,0,2,3,3;
    0,0,0,0,0,0,0,2,3,4;
    0,0,2,4,4,5,6,7,7,7;
    0,0,3,4,4,5,5,6,7,7;
    1,0,0,3,4,5,5,6,6,7;
    0,0,0,3,4,5,5,6,6,6;
    0,0,2,4,4,5,5,6,6,6;
    2,0,1,4,4,5,5,6,6,6;
    0,1,1,4,4,5,5,6,6,6];

%% ===== 2. Shared color range across all matrices =====================

allValues = [M1(:); M2(:); M3(:); M4(:); M5(:); M6(:)];
cmin = min(allValues);
cmax = max(allValues);

fprintf('Shared color range: [%.3f  %.3f]\n', cmin, cmax);

%% ===== 3. Define parameter axes ======================================

delays = linspace(0,230,10);
gTCSNs = linspace(0.4,0.9,10);
gHCSNs = linspace(2,20,10);

gGABA_IA2_CSN = linspace(4,30,10);
gAMPA_B_CSN   = linspace(2.4,4,10);

durationsA = linspace(10,200,10);
durationsB = linspace(10,200,10);

S1Strength = linspace(10,300,10);
S2Strength = linspace(10,300,10);

%% ===== 4. Delay vs gCaT ==============================================

plotHeatAndImage(M1, delays, gTCSNs, cmin, cmax, ...
    'Delay (ms)', 'g_{CaT} (CSN)', ...
    'Delay vs g_{CaT} (CSN)', ...
    'Delay_vs_gCaT');

%% ===== 5. Delay vs gH ================================================

plotHeatAndImage(M2, delays, gHCSNs, cmin, cmax, ...
    'Delay (ms)', 'g_{h} (CSN)', ...
    'Delay vs g_{h} (CSN)', ...
    'Delay_vs_gH');

%% ===== 6. Intrinsic Conductance Interaction ==========================

plotHeatAndImage(M3, gTCSNs, gHCSNs, cmin, cmax, ...
    'g_{CaT} (CSN)', 'g_{h} (CSN)', ...
    'Intrinsic Conductance Interaction (CSN)', ...
    'Intrinsics_CSN');

%% ===== 7. Synaptic Drive Interaction =================================

plotHeatAndImage(M4, gGABA_IA2_CSN, gAMPA_B_CSN, cmin, cmax, ...
    'g_{GABA} (IA_2 \rightarrow CSN)', 'g_{AMPA} (B \rightarrow CSN)', ...
    'Synaptic Drive Interaction (CSN)', ...
    'Synaptics_CSN');

%% ===== 8. S1 × S2 Duration Interaction ===============================

plotHeatAndImage(M5, durationsA, durationsB, cmin, cmax, ...
    'Duration of stimulus 1 (ms)', 'Duration of stimulus 2 (ms)', ...
    'S1–S2 Duration Interaction', ...
    'S1S2_Durations');

%% ===== 9. S1 × S2 Intensity Interaction ==============================

plotHeatAndImage(M6, S1Strength, S2Strength, cmin, cmax, ...
    'Intensity of stimulus 1 (pA)', 'Intensity of stimulus 2 (pA)', ...
    'S1–S2 Intensity Interaction', ...
    'S1S2_Intensities');

%% ===== Local function ================================================

function plotHeatAndImage(M, xvals, yvals, cmin, cmax, xlab, ylab, ttl, figPrefix)
    Mplot = M.';

    figure('Name', [figPrefix '_heatmap'], 'Color', 'w');
    h = heatmap(xvals, flip(yvals), flipud(Mplot), 'CellLabelColor', 'none');
    colormap(h, 'copper');
    caxis(h, [cmin cmax]);
    xlabel(xlab);
    ylabel(ylab);
    title(ttl);

    figure('Name', [figPrefix '_imagesc'], 'Color', 'w');
    imagesc(xvals, yvals, Mplot);
    set(gca, 'YDir', 'normal');
    colormap('copper');
    caxis([cmin cmax]);
    colorbar;
    xlabel(xlab);
    ylabel(ylab);
    title(ttl);
end