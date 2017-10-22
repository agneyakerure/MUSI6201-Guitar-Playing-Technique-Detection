function [answer] = slideTimeExtract(arr)

arr = arr';
len = length(arr);
ctr = 0;
j = 0;
i = 1;
answer = [];
while(i <= len)
    if(arr(i) ~= 0)
        if(i == 1)
            if(arr(i + 1) == 0)
                ctr = 0;
               
            end
        elseif(i == len)
            if(arr(i - 1) == 0)
                ctr = 0;
                
            end
            
        else
            if((arr(i + 1) == 0) || (arr(i + 2) == 0))
                ctr = 0;
                
            else
                j = i;
                ctr = ctr + 1;
                a = 0;
                while(arr(j) ~= 0)
                    a = a + arr(j);
                    answer(ctr, 1) = a;
                    j = j + 1;
                    diff = j - i;
                end
                i = i + diff;
            end
        end
    end
    i = i + 1;
end

end