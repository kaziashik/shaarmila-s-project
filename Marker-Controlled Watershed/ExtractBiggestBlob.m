% ExtractBiggestBlob for Acute & Hemorrhage FLAIR Stroke Image

function [image]=ExtractBiggestBlob(image)

format long g;
format compact;
fontSize = 20;
H=110;

% Get the dimensions of the image.
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(image);
% Display the original gray scale image.
H=H+1;figure(H);
imshow(image, []);
title('Original Grayscale Image', 'FontSize', fontSize);

% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Give a name to the title bar.
set(gcf,'name','Demo by ImageAnalyst','numbertitle','off')
% Let's compute and display the histogram.
[pixelCount, grayLevels] = imhist(image);
H=H+1;figure(H);
bar(pixelCount);
grid on;
title('Histogram of original image', 'FontSize', fontSize);
xlim([0 grayLevels(end)]); % Scale x axis manually.

% Threshold the image to binarize it.
binaryImage = image > 255;
% Fill holes
binaryImage = imfill(binaryImage, 'holes');
% Display the image.
H=H+1;figure(H);
imshow(binaryImage, []);
title('Binary Image', 'FontSize', fontSize);

% Get all the blob properties.  Can only pass in originalImage in version R2008a and later.
[labeledImage, numberOfBlobs] = bwlabel(binaryImage);
% % Display the image.
% H=H+1;figure(H);
% imshow([labeledImage, numberOfBlobs]);

blobMeasurements = regionprops(labeledImage, 'area', 'Centroid');
% Get all the areas
allAreas = [blobMeasurements.Area] % No semicolon so it will print to the command window.
menuOptions{1} = '0'; % Add option to extract no blobs.

% Display areas on image
for k = 1 : numberOfBlobs           % Loop through all blobs.
    thisCentroid = [blobMeasurements(k).Centroid(1), blobMeasurements(k).Centroid(2)];
    message = sprintf('Area = %d', allAreas(k));
    text(thisCentroid(1), thisCentroid(2), message, 'Color', 'r');
    menuOptions{k+1} = sprintf('%d', k);
end

% Ask user how many blobs to extract.
numberToExtract = menu('How many do you want to extract', menuOptions) - 1;
% Ask user if they want the smallest or largest blobs.
promptMessage = sprintf('Do you want the %d largest, or %d smallest, blobs?',...
    numberToExtract, numberToExtract);
titleBarCaption = 'Largest or Smallest?';
sizeOption = questdlg(promptMessage, titleBarCaption, 'Largest', 'Smallest', 'Cancel', 'Largest');
if strcmpi(sizeOption, 'Cancel')
    return;
elseif strcmpi(sizeOption, 'Smallest')
    % If they want the smallest, make the number negative.
    numberToExtract = -numberToExtract;
end

%---------------------------------------------------------------------------
% Extract the largest area using our custom function ExtractNLargestBlobs().
% This is the meat of the demo!
biggestBlob = ExtractNLargestBlobs(binaryImage, numberToExtract);
%---------------------------------------------------------------------------
% Display the image.
H=H+1;figure(H);
imshow(biggestBlob, []);

% Make the number positive again.  We don't need it negative for smallest extraction anymore.
numberToExtract = abs(numberToExtract);
if numberToExtract == 1
    caption = sprintf('Extracted %s Blob', sizeOption);
elseif numberToExtract > 1
    caption = sprintf('Extracted %d %s Blobs', numberToExtract, sizeOption);
else % It's zero
    caption = sprintf('Extracted 0 Blobs.');
end
title(caption, 'FontSize', fontSize);
msgbox('Done with demo!');
 
% Mask the image with the circle.
if numberOfColorBands == 1
    maskedImage = image; % Initialize with the entire image.
    maskedImage(~biggestBlob) = 0; % Zero image outside the circle mask.
else
    % Mask the image.
    maskedImage = bsxfun(@times, image, cast(biggestBlob,class(image)));
end
 
% Display it in the lower right plot. 
H=H+1;figure(H);
imshow(maskedImage, []); 
% Change imshow to image() if you don't have the Image Processing Toolbox.
title('Image masked with the circle.', 'FontSize', fontSize);
 
image=maskedImage;
H=H+1;figure(H);
imshow(image, []); 

