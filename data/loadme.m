if(exist('zmat')~=2)
    error('you must install ZMat toolbox to use this feature: http://github.com/fangq/zmat_mex')
end

if(exist('loadjson','file'))
    DigiBreast=loadjson('DigiBreast_lzma.jdat');
    DigiBreast=DigiBreast.DigiBreast;
else
    if(exist('jsonencode','builtin'))
        DigiBreast=jsondecode(fileread('DigiBreast_lzma.jdat'));
        if(exist('jsonencode','builtin'))
            DigiBreast=jdatadecode(DigiBreast.DigiBreast);
        end
    else
        error('you must install JSONLab from http://github.com/fangq/jsonlab')
    end
end
