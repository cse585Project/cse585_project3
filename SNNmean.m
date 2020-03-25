function [IM] = SNNmean(f,M,N)

%  Fill the output image with zeroes first
%  (Step below is admittedly very cumbersome!)

% Convert f to a 16-bit number, so we can do  sums > 255 correctly

g = double(f);

% Define the coordinate limits for pixels that can be properly
%     processed by the 5X5 filter

xlo = 3;   % Can't process first column
xhi = M-2; % Can't process last  column
ylo = 3;   % Can't process first row
yhi = N-2; % Can't process last  row
snn=zeros(size(f));
IM=zeros(size(f));
% Compute the filtered output image

for x = xlo : xhi        % Don't consider boundary pixels that can't
    for y = ylo : yhi    %    be processed!
        for i = -2 : 2
            for j = 0 : 2
                    if (i==0)&&(j==0)
                        snn(x,y)=g(x,y)+snn(x,y);
                    elseif (i<=0)||~(j==0)
                        if abs(g(x,y)-g(x-i,y-j)) < abs(g(x,y)-g(x+i,y+j))
                            snn(x,y)=g(x-i,y-j)+snn(x,y);
                        else
                            snn(x,y)=g(x+i,y+j)+snn(x,y);
                        end
                    end
            end     
        end
        IM(x,y)=snn(x,y) / 13;
    end
end
% Convert back to an 8-bit image
IM = uint8(IM);
end
