function vx_cmd = fcn(t)
    if t<30
        vx_cmd=0;
    else 
        incrementCount=1+floor((t-30)/5);
        disp(incrementCount)
        if (incrementCount<=30) vx_cmd=0.1666*incrementCount;
        else 
            vx_cmd=5;
        end
    end
