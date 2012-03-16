function h=getLoadFrameHandle(basefilename,extension,filenameDigits,imInfo,findNeuronsInRed,FirstImNum,LastImNum)
h=@loadFrame;

    function [Iout, ret]=loadFrame(num)
        %ret is zero (false) when things worked
        %ret is one (true) when out of range
        currPts='';

        ret=false;
                
        if num<FirstImNum || num>LastImNum
            %Out of Range
            ret=true;
        else
            
            %Load in a frame
            I=imread(getFileName(num,basefilename,extension,filenameDigits));

            %Split into two and align and such
            [Ig Ir]=splitImageIntoChannels(I,imInfo);
                
                
            if findNeuronsInRed==1
                splitI=Ir;
            else
                splitI=Ig;
            end
            
            Iout=splitI;

            ret=false; %We are in range
        end
        
    end

    


end