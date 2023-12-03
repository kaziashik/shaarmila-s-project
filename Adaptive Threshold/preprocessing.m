function [image] = preprocessing(image, Newbit)
    H = 100;
    type = 0;
    Gamma = 0.4;
    C = 1;

    Max = max(max(image));
    Maxbit = round(log2(double(Max)));
    fprintf('\t\t max intensity =  %g\n', Max);
    fprintf('\t\t max Bit =  %g\n', Maxbit);

    [image] = imagenormalization(image, Newbit);
    H = H + 1; figure(H); imshow(image, [0 max(max(image))]); title('image after normalization');

    [counts3, x3] = imhist(image, 2^Newbit);
    counts3(1) = 0;
    Z = movmean(counts3, 5);
    H = H + 1; figure(H); plot(x3, Z, 'g'); title('histogram after normalization');

    [image] = BackgroundRemoval(image, type);
    H = H + 1; figure(H); imshow(image, [0 max(max(image))]); title('image after background removal');
    [counts3, x3] = imhist(image, 2^Newbit);
    counts3(1) = 0;
    Z = movmean(counts3, 5);
    H = H + 1; figure(H); plot(x3, Z, 'g'); title('histogram after background removal');

    [image] = imagenhancement(image, Gamma, C, Newbit);
    H = H + 1; figure(H); imshow(image, [0 max(max(image))]); title('image after gamma law');
    [counts2, x2] = imhist(image, 2^Newbit);
    counts2(1) = 0;
    Z = movmean(counts2, 10);
    H = H + 1; figure(H); plot(x2, Z, 'g'); title('histogram after gamma law');
end
