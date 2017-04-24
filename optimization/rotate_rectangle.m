% Create a rectangle, then rotate with a 2D matrix transform. Plot results.
PI = 3.14159;
rotation_angle = PI/6;

rect = zeros(2,400);
rect(1,1:100) = linspace(5,12,100);
rect(1,101:200) = 5;
rect(1,201:300) = linspace(5,12,100);
rect(1,301:400) = 12;
rect(2,1:100) = 4;
rect(2,101:200) = linspace(4,9,100);
rect(2,201:300) = 9;
rect(2,301:400) = linspace(4,9,100);

rotation_matrix = [cos(rotation_angle) -sin(rotation_angle); sin(rotation_angle) cos(rotation_angle)];

rotated_rect = rotation_matrix * rect;

% Add random noise to rotated_rect
sdev = .1;
mean = 0;

% Generate gaussian random numbers
rand_noise = normrnd(mean,sdev,2,400);
noisy_rect = rotated_rect + rand_noise;

% Find original rotation angle from noisy data set.
% Using Least Sum Squared Error between point sets as error function
% Basic version of gradient descent optimization
ideal_SSE = find_sum_squared_error(rotated_rect, noisy_rect);
standard_step_size = 0.00175;
loop_count = 0;
rotate_angle = 0;
rotate_matrix = [cos(rotate_angle) -sin(rotate_angle); sin(rotate_angle) cos(rotate_angle)];
rotate_rect = rotate_matrix * rect;
last_SSE = find_sum_squared_error(rotate_rect, noisy_rect);
rotate_angle = 1;
while (loop_count < 5000)
    loop_count = loop_count + 1;
    rotate_matrix = [cos(rotate_angle) -sin(rotate_angle); sin(rotate_angle) cos(rotate_angle)];
    rotate_rect = rotate_matrix * rect;
    new_SSE = find_sum_squared_error(rotate_rect, noisy_rect);
    if (new_SSE < ideal_SSE + 0.0001)
        mod_angle = mod(rotate_angle, 2*PI);
        if(mod_angle < 0)
            mod_angle = mod_angle + 2*PI;
        end
        mod_angle
        plot(rect(1,:), rect(2,:), rotate_rect(1,:), rotate_rect(2,:), noisy_rect(1,:), noisy_rect(2,:));
        axis([0 15 0 15]);
        return
    end
    rotate_angle = rotate_angle + ((((last_SSE - new_SSE)/ideal_SSE) - 1) * standard_step_size);
    last_SSE = new_SSE;
end

plot(rect(1,:), rect(2,:), rotate_rect(1,:), rotate_rect(2,:), noisy_rect(1,:), noisy_rect(2,:));
axis([0 15 0 15]);

disp('Reached loop limit');
mod_angle = mod(rotate_angle, 2*PI);
if(mod_angle < 0)
    mod_angle = mod_angle + 2*PI;
end
mod_angle