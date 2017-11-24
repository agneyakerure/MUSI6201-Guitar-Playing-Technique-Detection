function ind = findNextIndex(initialIndex, arr)
    i = initialIndex + 1;
    while(i)
        if(arr(i) == 1)
            ind = i;
            break;
        end
        i = i + 1;
    end
end