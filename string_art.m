

img0 = imread('./walter.png');
img0 = sum(img0, 3);
img0 = img0/max(img0(:));
img0 = 1-img0;
n_pins = 150;

nx0 = size(img0, 1);
ny0 = size(img0, 2);
nx = 512;
ny = 512;
r = 194;
img = zeros(nx);
[x,y] = meshgrid(-(nx/2):(nx/2-1), -(ny/2):(ny/2-1));
r = r-10;

img = img0;
% img((nx/2-nx0/2):(nx/2+nx0/2-1), (ny/2-ny0/2):(ny/2+ny0/2-1)) = img0;
% for testing
% img(:) = 0;
% img((x-0).^2 + (y-30).^2 < 30^2) = 2;
% img((x-100).^2 + (y-80).^2 < 30^2) = 1;
% img((x-50).^2 + (y+120).^2 < 30^2) = 1;
img(x.^2 + y.^2 > r^2) = 0;


pin_positions = zeros(n_pins, 2);
angles = linspace(0, 2*pi, n_pins+1)(1:end-1);
pin_positions(:, 1) = r*cos(angles)+nx/2;
pin_positions(:, 2) = r*sin(angles)+ny/2;

r = ifftshift(sqrt(x.^2 + y.^2 + 50^2)/2);
img = real(ifft2(fft2(img).*r));
% imagesc(img)

% return

%% Part 1

% output = zeros(n_pins, n_pins);
% bin_output = zeros(n_pins, n_pins);

% width = 1;

% for i_pin = 1:n_pins
%     for j_pin = i_pin+1:n_pins
%         start_x = pin_positions(i_pin, 1);
%         start_y = pin_positions(i_pin, 2);
%         end_x = pin_positions(j_pin, 1);
%         end_y = pin_positions(j_pin, 2);
%         min_x = max(floor(min(start_x, end_x)), 1);
%         max_x = ceil(max(start_x, end_x));
%         min_y = max(floor(min(start_y, end_y)), 1);
%         max_y = ceil(max(start_y, end_y));
%         string_vector = [end_x - start_x, end_y - start_y];
%         string_vector = string_vector / norm(string_vector);
%         para_rotation = [string_vector(1), -string_vector(2); string_vector(2), string_vector(1)];
%         perp_rotation = [-string_vector(2), -string_vector(1); string_vector(1), -string_vector(2)];
%         slope = string_vector(2) / string_vector(1);
%         slope = max(min(slope, 10000), -10000);

%         for ii = min_x-width:max_x+width
%             center_y = slope*(ii-start_x) + start_y;
%             low_y = floor(min(max(center_y - width*abs(slope), min_y), max_y));
%             high_y = ceil(min(max(center_y + width*abs(slope), min_y), max_y));
%             for jj = low_y-width:high_y+width
%                 separation = abs(([ii-start_x, jj-start_y] * perp_rotation)(1));

%                 bin_output(i_pin, j_pin) = bin_output(i_pin, j_pin) + max(0, width-separation);
%                 output(i_pin, j_pin) = output(i_pin, j_pin) + img(ii, jj)*max(0, width-separation);
%             end
%         end
%     end
%     i_pin
% end



%% Part 2

pairs =  [];

for ii = 1:size(output,1)
    for jj = ii+1:size(output,2)
        if output(ii,jj) > 0
            if bin_output(ii,jj) == 0
                [ii,jj]
            end
            % pairs = [pairs; output(ii,jj)/bin_output(ii,jj), ii, jj];
            pairs = [pairs; output(ii,jj), ii, jj];
        end
    end
end

% sort by first column
pairs = flipud(sortrows(pairs, 1));

imagesc(img*0)
hold on
strings_x = [];
strings_y = [];
for ii = 1:100
% plot(x, y, '-', 'Color',[0.2 0.5 0.9 0.8], 'LineWidth',2.5)
    strings_x = [strings_x; [pin_positions(pairs(ii,2), 2), pin_positions(pairs(ii,3), 2)]];
    strings_y = [strings_y; [pin_positions(pairs(ii,2), 1), pin_positions(pairs(ii,3), 1)]];
    % plot([pin_positions(pairs(ii,2), 2), pin_positions(pairs(ii,3), 2)], 
    % [pin_positions(pairs(ii,2), 1), pin_positions(pairs(ii,3), 1)],
    % 'r-', 'LineWidth',0.5)
end
plot(strings_x', strings_y', 'r-', 'LineWidth',0.5)