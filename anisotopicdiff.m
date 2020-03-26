function diff = anisotopicdiff(img, t, K, option)
% Input
%   img - grayscale image I=I(x,y)
%   t - iteration
%   K - parameter used in g(.)
%   option - option to choose different g(.)
%   lambda(hidden) - 0.25
% Output
%   diff img after diffusion

diff = double(img); % initially
[M,N] = size(img);
lambda = 0.25; % as required

for iter=1:t
    for i=1:M
        for j=1:N
           if j==N
              deltaNI = -diff(i,j);
           else
               deltaNI = diff(i,j+1)-diff(i,j);
           end
           if j==1
               deltaSI = -diff(i,j);
           else
               deltaSI = diff(i,j-1)-diff(i,j);
           end
           if i==N
               deltaEI = -diff(i,j);
           else
               deltaEI = diff(i+1,j)-diff(i,j);
           end
           if i==1
               deltaWI = -diff(i,j);
           else
               deltaWI = diff(i-1,j)-diff(i,j);
           end
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

            diff(i,j) = diff(i,j) + lambda * ...
                (cN .* deltaNI ...
                + cS .* deltaSI ...
                + cW .* deltaWI ...
                + cE .* deltaEI);
        end
    end
end


diff = uint8(diff);

end