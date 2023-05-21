function ret = down_sample(array)
if length(array) <= 300
    ret = array;
else
    ret = downsample(array, round(length(array)/250));
end
end

