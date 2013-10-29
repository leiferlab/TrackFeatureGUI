function h=getLoadFrameHandleWithBuffer(basefilename,extension,channelPrefix,filenameDigits,findNeuronsInRed,greenChIs1,FirstImNum,LastImNum)
h=@loadFrame;


    function filename=getFileNameFromNumber(num)
        filename=[basefilename sprintf(['%.' num2str(filenameDigits) 'd'],num)  extension];

    end



    function [I, ret]=loadFrame(num)
        
                
        if num<FirstImNum || num>LastImNum
            %Out of Range
            ret=true;
        else
             
            %Set Buffer Paramaters
            bufferSize=100;
            ListOfAllowedImageIDs=FirstImNum:LastImNum;
            namingHandle=@getFilenamefromNumber;
            
            
            %HARD CODE IN imgsize
            disp('Andy! Dont forget to un-hardcode in the image size');
            imagesize=[512,512];
            
            %Create the circular Buffer in persistant mode
            persistent circBuff;
            
            %If circBuffer doesn't yet exist, we better create it
            if isempty(circBuff);
               circBuff=superFileBuff(bufferSize,imagesize,ListOfAllowedImageIDs,@getFileNameFromNumber);
            end
            
            
            
            %Load in a frame
            I=circBuff.loadFile(num);

            ret=false; %We are in range
        end
        
        
    end
end