clc; clear all; close all;

% Get the filename of the image from the user
img_filename = input('Enter the filename of the image (ex: project.jpg): ', 's');

% Check if the file exists
if exist(img_filename, 'file') == 2
    % File exists, proceed with reading the image
    inpict = imread(img_filename);
    imshow(inpict, 'border', 'tight')

    % Allow the user to draw a freehand region around the object
    h = imfreehand;
    mask = createMask(h);
    delete(h);

    % Blur the background outside the mask with a higher blur amount
    blurred_background = imgaussfilt(inpict, 20); % Increase the blur amount

    % Convert mask to double for blending
    mask = im2double(mask);

    % Compose the output image
    outpict = im2double(blurred_background) .* (1 - mask) + im2double(inpict) .* mask;
    outpict = im2uint8(outpict);

    % Show the composited image
    imshow(outpict, 'border', 'tight');

    % Get the output filename from the user
    output_filename = input('Enter the filename to save the blurred image (e.g., blurred_project.jpg): ', 's');

    % Save the composited image
    imwrite(outpict, output_filename);
else
    % Image file does not exist
    error('Error: The specified image file does not exist.');
end