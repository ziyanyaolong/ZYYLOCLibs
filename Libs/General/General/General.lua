local public = {}

public.config = nil
public.enum = nil

function public.initGeneral(ownDirPath)
    if (public.config ~= nil) then
        if (ownDirPath ~= public.config.path.getOwnDirPath()) then
            
        end
    else
        public.config = require(ownDirPath .. "ZYYLOCLibs/Libs/General/General/GeneralConfig")
        public.config.path.setOwnDirPath(ownDirPath)
        public.enum = require(public.config.path.getGeneraLibDirPath() .. "/Enum")
    end
end

return public