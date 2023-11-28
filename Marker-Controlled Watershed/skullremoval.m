function [image]=skullremoval(image)

H=0;
% Threshold the image
binaryImage = image > 136;
% Display the image.
H=H+1;figure(H);
imshow(binaryImage, []);
title('Binary Image', 'FontSize', 10, 'Interpreter', 'None');

% Fill the image
binaryImage = imfill(binaryImage, 'holes');
% Erode it a bit to come within the couter circle.
se = strel('disk', 20, 4); % Make round structuring element.
binaryImage = imerode(binaryImage, se);
% Display the image.
H=H+1;figure(H);
imshow(binaryImage, []);
title('Binary Image', 'FontSize', 10, 'Interpreter', 'None');

% "Erase" outside the mask by setting the original image to white.
image(~binaryImage) = 0; 
% Display the image.
H=H+1;figure(H);
imshow(image, []);
title('Final Gray Scale Image', 'FontSize', 10, 'Interpreter', 'None');
