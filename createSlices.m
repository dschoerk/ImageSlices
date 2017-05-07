images = {};
slices = {};
numImages = 10;
usedImages = 4;
w = floor(size(imread('1.jpg'), 2) / usedImages);

C = combnk(1:numImages, usedImages);
perm = randperm(size(C, 1));

for p = 1:size(C, 1)
    for i = 1:usedImages
        img = imread([int2str(C(perm(p), i)), '.jpg']);
        left = 1+w*(i-1);
        right = w*(i);
        slices{i} = img(:,left:right, :);
    end

    out = slices{1};
    for i = 2:usedImages
        out = [out slices{i}];
    end
    
    imwrite(out, ['out/', mat2str(C(p,:)), '.jpg']);
    
    [imind,cm] = rgb2ind(out,256);
    if p == 1;
        imwrite(imind,cm,'anim.gif','gif', 'Loopcount',inf,'DelayTime',0.2);
    else
        imwrite(imind,cm,'anim.gif','gif','WriteMode','append','DelayTime',0.2);
    end
end

% 1     2     3     5     6
