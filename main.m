%Turn your pictures into lego art

close all
clear all

%% INPUTS:
% filename = 'images/apple.jpg'; %path to image file
filename = 'images/rainbow.jpg';

width = 50; %width of image in legos

%% Load and showoriginal image 
im = imread(filename);
figure
imshow(im)
title('Original')

%% Enhance Color
%Couldn't get something working for this yet. HSV conversion was closest
%but ended up with negative pixel values I couldn't deal with

% origmax = max(im(:))./255;
% hsv = rgb2hsv(im);
% hsv(:, :, 2) = hsv(:, :, 2) * 1.5;
% im = hsv2rgb(hsv);
% 
    % 
% minval = min(im(:));
% maxval = max(im(:));
% pxRange = maxval-minval;
% im = (single(im) - minval).*(single(origmax)./pxRange);

% im = single(im).*1.2./255;
% im(im > 1) = 1;
% 
% figure
% imshow(im)
% title('Color Enhanced Image')


%% Rescale based on desired width
scale = width/size(im, 2);
im = imresize(im, scale);
figure
imshow(im, 'InitialMagnification',5000)
title('Resized Image')

%% Recolor based on available lego colors

%Lego round colormap
%brick options:
%https://www.lego.com/en-us/page/static/pick-a-brick?query=round&page=2&filters.i0.key=variants.attributes.designNumber&filters.i0.values.i0=6141
%brick colors found here:
%https://www.bartneck.de/2016/09/09/the-curious-case-of-lego-colors/

colors = [0, 61, 165;... %Bright Blue
          255, 130, 0;... %Bright Orange
          239, 51, 64;... %Bright Red
          0, 150, 57;...%Bright Green
          44, 82, 52;... %Dark Green
          211, 188, 141;... %Brick Yellow
          162, 170, 173;... %Medium Stone Grey
          122, 62, 58;...%Reddish Brown
          51	0	114;...Medium Lilac
          152	29	151;...%Light Purple
          49	38	29;...%Black
          181	189	0;...%Bright Yellowish Green
          91	103	112;...%Dark Stone Grey
          217	217	214]./255;%White         

%Corresponding Brick IDs to be used later
legoElementID = [614123;...%Bright Blue
                4157103;... %Bright Orange
                614121;... %Bright Red
                6109808; ... %Bright Green
                4569058; ... %Dark Green
                4161734;... %Brick Yellow
                4211525;... %Medium Stone Grey
                4216581;...%Reddish Brown
                4566522;...%Medium Lilac
                4517996;...%Light Purple
                614126;...%Black
                4183133;...%Bright Yellowish Green
                4210633;...%Dark Stone Grey
                614101];%White
      
%Find nearest lego for each pixel
numColors = size(colors,1);
distance = zeros(numColors, 1);
im = single(im)./255;
for ii = 1:size(im,1)
    for jj = 1:size(im,2)
        im_color = squeeze((im(ii, jj, :)))';
        for cc = 1:size(colors, 1)
            distance(cc) = sqrt(sum( (im_color - colors(cc, :)).^2 ) );
        end
        [~, ind] = min(distance);
        lego_colored_im(ii, jj, :) = colors(ind, :); 
    end
end

figure
imshow(lego_colored_im, 'InitialMagnification',5000)
title('Recolored Image')