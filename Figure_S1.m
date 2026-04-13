clear; clc;

%% Supplementary Figure S1 (A-F)

N = 50;

%% ===== Intrinsic parameters: panels A-C =====
intrinsicMin = [2.6 2.5 0.4 1 3 2 1 1 2];
intrinsicMax = [4.4 5.0 0.9 10 4 5 3.8 7 30];

intrinsicDist = zeros(N, numel(intrinsicMin));
for i = 1:numel(intrinsicMin)
    a = intrinsicMin(i);
    b = intrinsicMax(i);
    intrinsicDist(:, i) = a + (b - a) .* rand(N, 1);
end

intrinsicColorsA = [
    0.14,0.55,0.16;
    0.14,0.55,0.16;
    0.04,0.17,0.55
];

intrinsicColorsB = [
    0.14,0.55,0.16;
    0.14,0.55,0.16;
    0.14,0.55,0.16;
    0.04,0.17,0.55;
    0.61,0.62,0.67
];

intrinsicColorsC = [
    0.04,0.17,0.55
];

intrinsicA = intrinsicDist(:, 1:3);
intrinsicB = intrinsicDist(:, 4:8);
intrinsicC = intrinsicDist(:, 9);

labelsA = {'g_{Ca_T}(E_2)','g_{Ca_T}(E_3)','g_{Ca_T}(CSN)'};
labelsB = {'g_{SK}(E_1)','g_{SK}(E_2)','g_{SK}(E_3)','g_{SK}(CSN)','g_{SK}(B)'};
labelsC = {'g_{H}(CSN)'};

%% ===== Synaptic parameters: panels D-F =====
synMin = [15 10 15 17 17 10 5 10 10 5 8 8 1.4 5 5 5];
synMax = [25 30 30 30 30 30 30 30 30 30 30 30 4 25 25 30];

synDist = zeros(N, numel(synMin));
for i = 1:numel(synMin)
    a = synMin(i);
    b = synMax(i);
    synDist(:, i) = a + (b - a) .* rand(N, 1);
end

synColorsD = repmat([0.14,0.55,0.16], 9, 1);

synColorsE = [
    0.04,0.17,0.55;
    0.04,0.17,0.55;
    0.04,0.17,0.55;
    0.04,0.17,0.55
];

synColorsF = [
    0.61,0.62,0.67;
    0.14,0.55,0.16;
    0.95,0.72,0.02
];

synD = synDist(:, 1:9);
synE = synDist(:, 10:13);
synF = synDist(:, 14:16);

labelsD = {'g_{AM}(A-E_1)','g_{AM}(E_1-I_1)','g_{GA}(I_1-E_2)', ...
           'g_{AM}(E_2-I_2)','g_{GA}(I_2-E_3)','g_{AM}(E_3-I_1)', ...
           'g_{AM}(E_1-I_A1)','g_{AM}(E_2-I_A2)','g_{AM}(E_3-I_A3)'};

labelsE = {'g_{GA}(I_A1-CSN)','g_{GA}(I_A2-CSN)','g_{GA}(I_A3-CSN)','g_{AM}(B-CSN)'};

labelsF = {'g_{AM}(B-I_B)','g_{GA}(I_B-I_1)','g_{GA}(I_B-I_A3)'};

%% ===== Plot all panels in one figure =====
figure('Color','w','Position',[100 60 1700 900]);
tiledlayout(2,3,'Padding','compact','TileSpacing','compact');

nexttile;
plot_box_swarm(intrinsicA, intrinsicColorsA, labelsA, '(A)');

nexttile;
plot_box_swarm(intrinsicB, intrinsicColorsB, labelsB, '(B)');

nexttile;
plot_box_swarm(intrinsicC, intrinsicColorsC, labelsC, '(C)');

nexttile;
plot_box_swarm(synD, synColorsD, labelsD, '(D)');

nexttile;
plot_box_swarm(synE, synColorsE, labelsE, '(E)');

nexttile;
plot_box_swarm(synF, synColorsF, labelsF, '(F)');

%% ===== Local function =====
function plot_box_swarm(dataMat, boxColors, tickLabels, panelTitle)
    hold on

    [nRows, nCols] = size(dataMat);

    for k = 1:nCols
        b = boxchart(k * ones(nRows,1), dataMat(:,k), 'BoxWidth', 0.6);
        b.BoxFaceColor = boxColors(k,:);
        b.LineWidth = 1.5;
    end

    x = repmat(1:nCols, nRows, 1);
    swarmchart(x, dataMat, [], 'black');

    set(gca, 'XTick', 1:nCols);
    set(gca, 'XTickLabel', tickLabels);
    xtickangle(30);
    box off
    title(panelTitle);
    hold off
end