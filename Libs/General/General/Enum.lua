local enum = {}

enum = {}
function enum.addToEnum(name, value)
    if (enum[name] == nil) then
        local newTable = {}
        enum[name] = newTable
        enum[name]["EnumCount"] = 0
    end

    enum[name][enum[name]["EnumCount"]] = value
    enum[name][value] = enum[name]["EnumCount"]

    enum[name]["EnumCount"] = enum[name]["EnumCount"] + 1
end

function enum.addToEnumMap(name, key, value)
    if (enum[name] == nil) then
        local newTable = {}
        enum[name] = newTable
        enum[name]["EnumCount"] = 0
    end

    enum[name][key] = value

    enum[name]["EnumCount"] = enum[name]["EnumCount"] + 1
end

function enum.findToEnum(name, value)
    if (enum[name] == nil) then
        return nil
    end
    return enum[name][value]
end

function enum.get(name, value)
    return enum[name][value]
end

return enum