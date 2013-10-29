function h=getLoadFrameHandleWithBuffer(basefilename,extension,channelPrefix,filenameDigits,findNeuronsInRed,greenChIs1,FirstImNum,LastImNum)
%This is a little crazy here. So basically this function returns a handle
%to another function that the tracker will call everytime it wants to load
%a frame.


%This is the handle to the function below, loadFrame
h=@loadFrame;

    %This is a function that generates a filename based on an ID number.
    %This function is required by the buffer machinery. It's what allows
    %the buffer to look a few frames forward and backward and then load
    %them from the filesystem. This will get turned into a function handle
    %when everything is initialized and will get passed into the buffer
    %machinery.
    function filename=getFileNameFromNumber(num)
        filename=[basefilename sprintf(['%.' num2str(filenameDigits) 'd'],num)  extension];

    end



    %This is the function that the tracker calls whenever it wants a new
    %frame.
    function [I, ret]=loadFrame(num)
        
                
        if num<FirstImNum || num>LastImNum
            %Out of Range
            ret=true;
        else
             

            
            %Create the circular Buffer in persistant mode
            persistent circBuff;
            
            
            
            %If circBuffer doesn't yet exist, we better create it
            if isempty(circBuff); %This section should only run once
                
                %Set Buffer Paramaters
                bufferSize=100;
                ListOfAllowedImageIDs=FirstImNum:LastImNum;

                %Read the first image to get filesize
                filename=getFileNameFromNumber(num);
                iminfo=imfinfo(filename);
            
                disp(['Getting image size information by inspecting ' filename ]);
                imagesize=[iminfo.Width iminfo.Height];

                %Actually create the new buffer machinery here.
                circBuff=superFileBuff(bufferSize,imagesize,ListOfAllowedImageIDs,@getFileNameFromNumber);
            end
            
            
            
            %Load in a frame by asking the buffer machinery to provide it
            I=circBuff.loadFile(num);

            ret=false; %We are in range
        end
        
        
    end
end