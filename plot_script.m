data = readtable('measured_data.csv'); 
time = data.Var4; 
force = data.Var2;

% Find the maximum force and its corresponding time for the entire dataset
[max_force, idx] = max(force);
max_time = time(idx);

% Divide the data into two phases
phase1_idx = time <= 109.95;
phase2_idx = time > 109.95;

% Calculate the average forces for each phase
avg_force_phase1 = mean(force(phase1_idx));
avg_force_phase2 = mean(force(phase2_idx));

% Find the maximum force and its corresponding time for the second phase
[max_force_phase2, idx_phase2] = max(force(phase2_idx));
max_time_phase2 = time(idx_phase2 + find(phase2_idx, 1) - 1);  % Adjust index for the second phase

% Set figure size
figure('Position', [100, 100, 1049, 420]); % Width of 1049 pixels approximates one pixel per second

% Create the plot for phase 1
plot(time(phase1_idx), force(phase1_idx), 'red'); % Glider on ground
hold on; % Keep the plot to add more elements

% Create the plot for phase 2
plot(time(phase2_idx), force(phase2_idx), 'blue'); % Glider in air

% Annotate the maximum force point for the entire dataset
plot(max_time, max_force, 'kp', 'MarkerSize', 10, 'MarkerFaceColor', 'red');
text(max_time, max_force, ['(' num2str(max_time, '%.2f') ' s, ' num2str(max_force) ' kN)'], ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

% Annotate the maximum force point for the second phase
plot(max_time_phase2, max_force_phase2, 'kp', 'MarkerSize', 10, 'MarkerFaceColor', 'blue');
text(max_time_phase2, max_force_phase2, ['(' num2str(max_time_phase2, '%.2f') ' s, ' num2str(max_force_phase2) ' kN)'], ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'left');

% Plot and annotate the average force lines for both phases
line([time(1), time(end)], [avg_force_phase1, avg_force_phase1], 'Color', 'red', 'LineStyle', '--');
text(time(end), avg_force_phase1, [' Avg: ' num2str(avg_force_phase1, '%.2f') ' kN'], ...
    'Color', 'red', 'HorizontalAlignment', 'left');

line([time(1), time(end)], [avg_force_phase2, avg_force_phase2], 'Color', 'blue', 'LineStyle', '--');
text(time(end), avg_force_phase2, [' Avg: ' num2str(avg_force_phase2, '%.2f') ' kN'], ...
    'Color', 'blue', 'HorizontalAlignment', 'left');

% Add labels, title, and legend
xlim([min(time) max(time)]);
xlabel('Time (seconds)');
ylabel('Force (kN)');
title('Rope tension forces in aerotow');
legend({'Glider on ground', 'Glider in air', 'Max Force Overall', 'Max Force in Air', 'Avg Force on ground', 'Avg Force in air'}, 'Location', 'best');
grid on
hold off; % Release the plot hold