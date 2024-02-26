data = readtable('measured_data.csv'); 
time = data.Var4; 
force = data.Var2;

% Find the maximum force and its corresponding time
[max_force, idx] = max(force);
max_time = time(idx);

% Divide the data into two phases
phase1_idx = time <= 109.95;
phase2_idx = time > 109.95;

% Calculate the average forces for each phase
avg_force_phase1 = mean(force(phase1_idx));
avg_force_phase2 = mean(force(phase2_idx));

% Create the plot
plot(time(phase1_idx), force(phase1_idx), 'b', time(phase2_idx), force(phase2_idx), 'r');
hold on; % Keep the plot to add more elements

% Annotate the maximum force point
plot(max_time, max_force, 'kp', 'MarkerSize', 10, 'MarkerFaceColor', 'green');
text(max_time, max_force, [' (' num2str(max_time) ', ' num2str(max_force) ' kN)'], ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

% Plot the average force lines
yline(avg_force_phase1, 'b--', ['Avg: ' num2str(avg_force_phase1) ' kN']);
yline(avg_force_phase2, 'r--', ['Avg: ' num2str(avg_force_phase2) ' kN']);

% Add labels, title, and legend
xlabel('Time (seconds)');
ylabel('Force (kN)');
title('Force vs Time');
legend('Glider on ground', 'Glider in air', 'Location', 'best');

hold off; % Release the plot hold
