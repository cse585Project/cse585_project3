function [im] = SNNmean(f)

%  Fill the output image with zeroes first
%  (Step below is admittedly very cumbersome!)

% Convert f to a 16-bit number, so we can do  sums > 255 correctly

g = double(f);
[M,N]=size(f);
% Define the coordinate limits for pixels that can be properly
%     processed by the 5X5 filter

xlo = 3;   % Can't process first column
xhi = M+2; % Can't process last  column
ylo = 3;   % Can't process first row
yhi = N+2; % Can't process last  row
snn=zeros(260,260);
IM=zeros(260,260);
im=zeros(size(f));
% Compute the filtered output image


tempIM = zeros(260,260) ;
tempIM(3:258,3:258) = g ;

for x = xlo : xhi       % Don't consider boundary pixels that can't
    for y = ylo : yhi    %    be processed!
        for i = -2 : 2
            for j = 0 : 2
                    if (i==0)&&(j==0)
                        snn(x,y)=tempIM(x,y)+snn(x,y);
                    elseif (i<=0)||~(j==0)
                        if abs(tempIM(x,y)-tempIM(x-i,y-j)) < abs(tempIM(x,y)-tempIM(x+i,y+j))
                            snn(x,y)=tempIM(x-i,y-j)+snn(x,y);
                        else
                            snn(x,y)=tempIM(x+i,y+j)+snn(x,y);
                        end
                    end
            end     
        end
        IM(x,y)=round(snn(x,y) / 13);
    end
end
% Convert back to an 8-bit image
im=IM(3:258,3:258);

im = uint8(im);
end
