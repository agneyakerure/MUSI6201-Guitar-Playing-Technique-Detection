function arr = togetherEqual(arr1, arr2)
len1 = length(arr1);
arr = zeros(len1, 1);

for i = 1 : len1
    if(arr1(i) == 1 || arr2(i) == 1)
        arr(i) = 1;
    end
end
end