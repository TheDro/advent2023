

img0 = imread('./cat_face.png');
img0 = sum(img0, 3);
n_pins = 50;

nx0 = size(img0, 1);
ny0 = size(img0, 2);
nx = 800;
ny = 800;
r = 250;
img = zeros(nx);
[x,y] = meshgrid(-(nx/2):(nx/2-1), -(ny/2):(ny/2-1));

img((nx/2-nx0/2):(nx/2+nx0/2-1), (ny/2-ny0/2):(ny/2+ny0/2-1)) = img0;
img(x.^2 + y.^2 > r^2) = 0;



pin_positions = zeros(n_pins, 2);
angles = linspace(0, 2*pi, n_pins+1)(1:end-1);
pin_positions(:, 1) = r*cos(angles)+nx/2;
pin_positions(:, 2) = r*sin(angles)+ny/2;

% imagesc(img)
% hold on
% plot(pin_positions(:, 1), pin_positions(:, 2), 'r.')

output = zeros(n_pins, n_pins);
bin_output = zeros(n_pins, n_pins);

width = 2;

for i_pin = 1:1
    for j_pin = i_pin+1:n_pins
        start_x = pin_positions(i_pin, 1);
        start_y = pin_positions(i_pin, 2);
        end_x = pin_positions(j_pin, 1);
        end_y = pin_positions(j_pin, 2);
        min_x = max(floor(min(start_x, end_x)), 1);
        max_x = ceil(max(start_x, end_x));
        min_y = max(floor(min(start_y, end_y)), 1);
        max_y = ceil(max(start_y, end_y));
        string_vector = [end_x - start_x, end_y - start_y];
        string_vector = string_vector / norm(string_vector);
        para_rotation = [string_vector(1), -string_vector(2); string_vector(2), string_vector(1)];
        perp_rotation = [-string_vector(2), -string_vector(1); string_vector(1), -string_vector(2)];
        slope = string_vector(2) / string_vector(1);
        slope = max(min(slope, 10000), -10000);

        for ii = min_x-width:max_x+width
            center_y = slope*(ii-start_x) + start_y;
            low_y = floor(min(max(center_y - width*abs(slope), min_y), max_y));
            high_y = ceil(min(max(center_y + width*abs(slope), min_y), max_y));
            for jj = low_y-width:high_y+width
                separation = abs(([ii-start_x, jj-start_y] * perp_rotation)(1));
                % if (separation > 20)
                %   separation
                %   bleh = 1
                % end
              
                bin_ouput(i_pin, j_pin) = bin_output(i_pin, j_pin) + max(0, width-separation);
                output(i_pin, j_pin) = output(i_pin, j_pin) + img(ii, jj)*max(0, width-separation);
                % img(ii,jj) = separation;
            end
        end
        j_pin
    end
    bleh = 1;
end