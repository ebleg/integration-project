function [filterdata] = remove_switching(rawdata)
    delta = diff(rawdata);
    filter = abs(delta) > 0.08;
    
    filterdata = rawdata;
    
    for i = 2:numel(filter)
        if filter(i) && ~filter(i-1)
            filterdata(i+1:end) = filterdata(i+1:end) + 2*pi;
        end
    end
end

