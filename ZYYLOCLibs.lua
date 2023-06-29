local public = {}
local private = {}

private.ownDirPath = ""
private.config = ""
private.generalLib = nil

function public.getGeneralLib(ownDirPath)
    if (ownDirPath ~= nil) then
        private.generalLib = require(ownDirPath .. "ZYYLOCLibs/Libs/General/General/General")
        private.generalLib.initGeneral(ownDirPath)
    else
        if (private.generalLib == nil) then
            private.generalLib = require(private.ownDirPath .. "ZYYLOCLibs/Libs/General/General/General")
            private.generalLib.initGeneral(private.ownDirPath)
        end
    end

    return private.generalLib
end

function public.getOwnDirPath(ownDirPath)
    return private.private.ownDirPath
end

return public
