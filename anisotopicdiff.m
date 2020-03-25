function diff = anisotopicdiff(img, t, K, option)
% Input
%   img - grayscale image I=I(x,y)
%   t - iteration
%   K - parameter used in g(.)
%   option - option to choose different g(.)
%   lambda(hidden) - 0.25
% Output
%   diff img after diffusion

maskN = [0,1,0;0,-1,0;0,0,0];
maskS = [0,0,0;0,-1,0;0,1,0];
maskE = [0,0,0;0,-1,1;0,0,0];
maskW = [0,0,0;1,-1,0;0,0,0];

diff = double(img); % initially
lambda = 0.25; % as required

for i=1:t
    deltaNI = conv2(diff,maskN,'same');
    deltaSI = conv2(diff,maskS,'same');
    deltaWI = conv2(diff,maskW,'same');
    deltaEI = conv2(diff,maskE,'same');
    
    % update c = g(.)
    if option==1
        cN = exp(-(deltaNI/K).^2);
        cS = exp(-(deltaSI/K).^2);
        cW = exp(-(deltaWI/K).^2);
        cE = exp(-(deltaEI/K).^2);
    else
        cN = 1./(1+(deltaNI/K).^2);
        cS = 1./(1+(deltaSI/K).^2);
        cW = 1./(1+(deltaWI/K).^2);
        cE = 1./(1+(deltaEI/K).^2);
    end
    
    diff = diff + lambda * ...
        (cN .* deltaNI ...
        + cS .* deltaSI ...
        + cW .* deltaWI ...
        + cE .* deltaEI);
    
end
diff = uint8(diff);

end