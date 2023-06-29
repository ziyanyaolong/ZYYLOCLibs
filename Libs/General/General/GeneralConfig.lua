local public = {}

local private = {}

private.path = {}

private.path.ownDirPath = ""

private.path.generaDirPath = ""
private.path.generaLibDirPath = ""
private.path.generaLibPath = ""

private.path.libsDirPath = ""

public.path = {}

function public.path.setOwnDirPath(path)
    private.path.ownDirPath = path

    private.path.generaDirPath = path .. "ZYYLOCLibs/Libs/General/"
    private.path.generaLibDirPath = private.path.generaDirPath .. "General/"
    private.path.generaLibPath = private.path.generaLibDirPath .. "General"

    private.path.libsDirPath = path .. "ZYYLOCLibs/" .. "Libs/"
end

function public.path.getOwnDirPath()
    return private.path.ownDirPath
end

function public.path.getGeneraDirPath()
    return private.path.generaDirPath
end

function public.path.getGeneraLibDirPath()
    return private.path.generaLibDirPath
end

function public.path.getGeneraLibPath()
    return private.path.generaLibPath
end

function public.path.getLibsDirPath()
    return private.path.libsDirPath
end

private.mcVersion = {}

private.mcVersion.now = ""

public.mcVersion = {}

function public.mcVersion.setMcVersion(str)
    private.mcVersion.now = str
end

function public.mcVersion.getMcVersion()
    return private.mcVersion.now
end

private.libs = {}

private.libs.supportedVersions = {}
private.libs.regs = {}
private.libs.regs["Count"] = 0

public.libs = {}

function public.libs.setLibVersions(name, ...)
    local count = 0
    local strName = tostring(name)

    if (private.libs.supportedVersions[strName] ~= nil) then
        count = private.libs.supportedVersions[strName]
    else
        private.libs.supportedVersions[strName] = 0
    end

    for index, value in ipairs(...) do
        private.libs.supportedVersions[strName .. tostring(index + count)] = tostring(value)
        count = count + 1
    end

    private.libs.supportedVersions[strName] = count
end

function public.libs.getLibVersions(name)
    local array = {}
    local count = 0
    local strName = tostring(name)

    if (private.libs.supportedVersions[strName] ~= nil) then
        count = private.libs.supportedVersions[strName]
    else
        return array
    end

    for i = 0, count - 1, 1 do
        array[i] = private.libs.supportedVersions[strName .. tostring(i)]
    end

    return array
end

function public.libs.isLibVersions(name, ...)
    local tfTemp = false;
    local count = 0
    local strName = tostring(name)

    if (private.libs.supportedVersions[strName] ~= nil) then
        count = private.libs.supportedVersions[strName]
    else
        return tfTemp
    end

    for _, value in ipairs(...) do
        tfTemp = false

        for i = 0, count - 1, 1 do
            if (private.libs.supportedVersions[strName .. tostring(i)] == tostring(value)) then
                tfTemp = true
                break
            end
        end

        if (tfTemp ~= true) then
            break
        end
    end

    return tfTemp
end

function public.libs.loadLib(modName, componetName)
    local count = 0
    local modTable = private.libs.regs[tostring(modName)]

    if (modTable == nil) then
        modTable = {}
        modTable["Count"] = 0
    else
        count = modTable["Count"]
    end

    if (modTable[tostring(componetName)] == nil) then
        modTable[tostring(componetName)] = true
        modTable["Count"] = count + 1
    end

    local tempLib = require(public.path.getLibsDirPath() ..
    tostring(modName) .. "/" .. tostring(componetName) .. "/" .. tostring(componetName))
    tempLib.libFunc.initLib(require(private.path.generaLibPath))

    return tempLib
end

function public.libs.unloadLib(modName, componetName)
    if (private.libs.regs["Count"] <= 0) then
        return
    end

    local strModName = tostring(modName)
    local countPos = 0

    local tempLib = require(public.path.getLibsDirPath() ..
    tostring() .. "/" .. tostring(componetName) .. "/" .. tostring(componetName))

    tempLib.deleteLib()

    if (tempLib.generalLib ~= nil) then
        tempLib.generalLib = nil
        tempLib = nil
    end

    if (private.libs.regs[strModName] == nil) then
        for key, _ in pairs(private.libs.regs) do
            if (tostring(key) == strModName) then
                table.remove(private.libs.regs, countPos)
            end
            countPos = countPos + 1
        end

        return
    end

    countPos = 0

    for _, _ in pairs(private.libs.regs[strModName]) do
        table.remove(private.libs.regs[strModName], countPos)
        countPos = countPos + 1
    end

    countPos = 0

    for key, _ in pairs(private.libs.regs) do
        if (tostring(key) == strModName) then
            table.remove(private.libs.regs, countPos)
        end
        countPos = countPos + 1
    end
end

return public
