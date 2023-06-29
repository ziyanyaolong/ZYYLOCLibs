local public = {}
local private = {}

public.libFunc = {}

private.generalLib = nil

function public.libFunc.initLib(libPointer)
    private.generalLib = libPointer
    private.generalLib.config.libs.setLibVersions("RbmkConsole", "1.12.2")
    private.addEnums()
end

function public.libFunc.deleteLib()

end

local componet = require("component")

--Register List
private.rbmkConsoleList = {}
private.rbmkConsoleNow = {}
private.rbmkMode = 0

--enum adds
function private.addEnums()
    --ComponetNames
    private.generalLib.enum.addToEnum("ComponetNames", "OTHER")
    private.generalLib.enum.addToEnum("ComponetNames", "FUEL")
    private.generalLib.enum.addToEnum("ComponetNames", "FUEL_SIM")
    private.generalLib.enum.addToEnum("ComponetNames", "CONTROL")
    private.generalLib.enum.addToEnum("ComponetNames", "CONTROL_AUTO")
    private.generalLib.enum.addToEnum("ComponetNames", "HEATEX")
    private.generalLib.enum.addToEnum("ComponetNames", "ABSORBER")
    private.generalLib.enum.addToEnum("ComponetNames", "COLLER")
    private.generalLib.enum.addToEnum("ComponetNames", "BOILER")
    private.generalLib.enum.addToEnum("ComponetNames", "REFLECTOR")
    private.generalLib.enum.addToEnum("ComponetNames", "STORAGE")

    --RbmkColor
    private.generalLib.enum.addToEnum("RbmkColor", "RED")
    private.generalLib.enum.addToEnum("RbmkColor", "YELLOW")
    private.generalLib.enum.addToEnum("RbmkColor", "GREEN")
    private.generalLib.enum.addToEnum("RbmkColor", "BLUE")
    private.generalLib.enum.addToEnum("RbmkColor", "PURPLE")
    private.generalLib.enum.addToEnum("RbmkColor", "NONE")

    --SimMode
    private.generalLib.enum.addToEnum("SimMode", "FALSE")
    private.generalLib.enum.addToEnum("SimMode", "TRUE")

    --RetentionData
    private.generalLib.enum.addToEnumMap("RetentionData", "BaseTable", "BaseTable")
    private.generalLib.enum.addToEnumMap("RetentionData", "Count", "Count")
    private.generalLib.enum.addToEnumMap("RetentionData", "Color", "Color")
    private.generalLib.enum.addToEnumMap("RetentionData", "Min", "Min")
    private.generalLib.enum.addToEnumMap("RetentionData", "Max", "Max")
    private.generalLib.enum.addToEnumMap("RetentionData", "Average", "Average")

    --BaseTableKeys
    private.generalLib.enum.addToEnum("BaseTableKey", "Name")
    private.generalLib.enum.addToEnum("BaseTableKey", "X")
    private.generalLib.enum.addToEnum("BaseTableKey", "Y")
    private.generalLib.enum.addToEnum("BaseTableKey", "Temperature")

    --ConsoleKeys
    private.generalLib.enum.addToEnum("RbmkConsoleKey", "Key")
    private.generalLib.enum.addToEnum("RbmkConsoleKey", "XYZ")
    private.generalLib.enum.addToEnum("RbmkConsoleKey", "SimMode")
    private.generalLib.enum.addToEnum("RbmkConsoleKey", "Curves")
    private.generalLib.enum.addToEnum("RbmkConsoleKey", "MinTable")
    private.generalLib.enum.addToEnum("RbmkConsoleKey", "MaxTable")

    --ControlTableKeys
    private.generalLib.enum.addToEnum("RbmkControlKey", "Mode")
    private.generalLib.enum.addToEnum("RbmkControlKey", "Group")
    private.generalLib.enum.addToEnum("RbmkControlKey", "MinValue")
    private.generalLib.enum.addToEnum("RbmkControlKey", "MaxValue")

    --CurveBaseTableKeys
    private.generalLib.enum.addToEnum("CurveBaseKey", "X")
    private.generalLib.enum.addToEnum("CurveBaseKey", "Y")
    private.generalLib.enum.addToEnum("CurveBaseKey", "AttributeName")
    private.generalLib.enum.addToEnum("CurveBaseKey", "AttributeValue")
    private.generalLib.enum.addToEnum("CurveBaseKey", "CurveMode")
    private.generalLib.enum.addToEnum("CurveBaseKey", "NodeNow")
    private.generalLib.enum.addToEnum("CurveBaseKey", "Property")

    --CurveTableKeys
    private.generalLib.enum.addToEnumMap("CurveTableKey", "CurveBaseTable", "CurveBaseTable")

    --CurveNodeKeys
    private.generalLib.enum.addToEnum("CurveNodeKey", "X")
    private.generalLib.enum.addToEnum("CurveNodeKey", "Y")
    private.generalLib.enum.addToEnum("CurveNodeKey", "FuncParameter")
    private.generalLib.enum.addToEnum("CurveNodeKey", "Function")
    private.generalLib.enum.addToEnum("CurveNodeKey", "NodeValue")
    private.generalLib.enum.addToEnum("CurveNodeKey", "ProcessNodeValue")

    --CurvePropertyKeys
    private.generalLib.enum.addToEnum("CurvePropertyKey", "None")
    private.generalLib.enum.addToEnum("CurvePropertyKey", "GlobalMin")
    private.generalLib.enum.addToEnum("CurvePropertyKey", "GlobalMax")
    private.generalLib.enum.addToEnum("CurvePropertyKey", "GroupMin")
    private.generalLib.enum.addToEnum("CurvePropertyKey", "GroupMax")

    --CurveMode
    private.generalLib.enum.addToEnum("CurveMode", "Static")
    private.generalLib.enum.addToEnum("CurveMode", "Dynamic")

    -- --Test Type
    -- private.generalLib.enum.addToEnum("TestType", "Mode")
    -- private.generalLib.enum.addToEnum("TestType", "Group")
    -- private.generalLib.enum.addToEnum("TestType", "MinValue")
    -- private.generalLib.enum.addToEnum("TestType", "MaxValue")
end

--RBMK find max
private.rbmkFindXMax = 15
private.rbmkFindYMax = 15

--OperatorFunc
private.operatorFunc = {}

function private.operatorFunc.allTrue(...)
    local temp = true

    for key, value in pairs { ... } do
        if (value == false) then
            temp = false
            break
        end
    end

    return temp
end

function private.operatorFunc.allFalse(...)
    local temp = true

    for key, value in pairs { ... } do
        if (value == true) then
            temp = false
            break
        end
    end

    return temp
end

function private.operatorFunc.oneTrue(...)
    local temp = false

    for key, value in pairs { ... } do
        if (value == true) then
            temp = true
            break
        end
    end

    return temp
end

function private.operatorFunc.oneFalse(...)
    local temp = false

    for key, value in pairs { ... } do
        if (value == false) then
            temp = true
            break
        end
    end

    return temp
end

--Advanced Math
private.advancedMath = {}

function private.advancedMath.mapIntervalValue(value, inMin, inMax, outMin, outMax)
    return (value - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
end

--RBMK Func
private.rbmkFunction = {}

function private.rbmkFunction.getComponetData(rbmkConsole, x, y)
    return rbmkConsole.getColumnData(x, y)
end

function private.rbmkFunction.setLevel(rbmkConsole, x, y, value)
    rbmkConsole.setColumnLevel(x, y, value)
end

function private.rbmkFunction.setColorLevel(rbmkConsole, group, value)
    rbmkConsole.setColorLevel(group, value)
end

function private.rbmkFunction.emergencyStop(rbmkConsole)
    rbmkConsole.pressAZ5()
end

--TableFunc
private.tableFunc = {}

function private.tableFunc.getValue(table, key)
    return table[key]
end

function private.tableFunc.getValueAndEnum(table, eKey, eValue)
    return table[private.generalLib.enum.get(eKey, eValue)]
end

function private.tableFunc.setValue(table, key, value)
    table[key] = value
end

function private.tableFunc.setValueAndEnum(table, eKey, eValue, value)
    table[private.generalLib.enum.get(eKey, eValue)] = value
end

--RetentionData
private.retentionDataFunc = {}

function private.retentionDataFunc.getBaseGet(table, key)
    return private.tableFunc.getValueAndEnum(table, "RetentionData", key)
end

function private.retentionDataFunc.getCount(table)
    return private.tableFunc.getValueAndEnum(table, "RetentionData", "Count")
end

function private.retentionDataFunc.getBaseTable(table)
    return private.tableFunc.getValueAndEnum(table, "RetentionData", "BaseTable")
end

function private.retentionDataFunc.setCount(table, value)
    return private.tableFunc.setValueAndEnum(table, "RetentionData", "Count", value)
end

--BaseCurveTableFunc
private.curveBaseFunc = {}

function private.curveBaseFunc.createBaseCurve(x, y, attributeName, mode, property)
    local newCurveNode = {}

    newCurveNode[private.generalLib.enum.get("CurveBaseKey", "X")] = x
    newCurveNode[private.generalLib.enum.get("CurveBaseKey", "Y")] = y
    newCurveNode[private.generalLib.enum.get("CurveBaseKey", "AttributeName")] = attributeName
    newCurveNode[private.generalLib.enum.get("CurveBaseKey", "AttributeValue")] = nil
    newCurveNode[private.generalLib.enum.get("CurveBaseKey", "CurveMode")] = mode
    newCurveNode[private.generalLib.enum.get("CurveBaseKey", "NodeNow")] = nil

    if (property == nil) then
        newCurveNode[private.generalLib.enum.get("CurveBaseKey", "Property")] = private.generalLib.enum.get(
        "CurvePropertyKey", "None")
    else
        newCurveNode[private.generalLib.enum.get("CurveBaseKey", "Property")] = property
    end

    return newCurveNode
end

function private.curveBaseFunc.getX(table)
    return private.tableFunc.getValueAndEnum(table, "CurveBaseKey", "X")
end

function private.curveBaseFunc.getY(table)
    return private.tableFunc.getValueAndEnum(table, "CurveBaseKey", "Y")
end

function private.curveBaseFunc.getAttributeName(table)
    return private.tableFunc.getValueAndEnum(table, "CurveBaseKey", "AttributeName")
end

function private.curveBaseFunc.getAttributeValue(table)
    return private.tableFunc.getValueAndEnum(table, "CurveBaseKey", "AttributeValue")
end

function private.curveBaseFunc.getCurveMode(table)
    return private.tableFunc.getValueAndEnum(table, "CurveBaseKey", "CurveMode")
end

function private.curveBaseFunc.getNodeNow(table)
    return private.tableFunc.getValueAndEnum(table, "CurveBaseKey", "NodeNow")
end

function private.curveBaseFunc.getProperty(table)
    return private.tableFunc.getValueAndEnum(table, "CurveBaseKey", "Property")
end

function private.curveBaseFunc.setX(table, value)
    private.tableFunc.setValueAndEnum(table, "CurveBaseKey", "X", value)
end

function private.curveBaseFunc.setY(table, value)
    private.tableFunc.setValueAndEnum(table, "CurveBaseKey", "Y", value)
end

function private.curveBaseFunc.setAttributeName(table, value)
    private.tableFunc.setValueAndEnum(table, "CurveBaseKey", "AttributeName", value)
end

function private.curveBaseFunc.setAttributeValue(table, value)
    private.tableFunc.setValueAndEnum(table, "CurveBaseKey", "AttributeValue", value)
end

function private.curveBaseFunc.setCurveMode(table, value)
    private.tableFunc.setValueAndEnum(table, "CurveBaseKey", "CurveMode", value)
end

function private.curveBaseFunc.setNodeNow(table, value)
    private.tableFunc.setValueAndEnum(table, "CurveBaseKey", "NodeNow", value)
end

function private.curveBaseFunc.setProperty(table, value)
    return private.tableFunc.setValueAndEnum(table, "CurveBaseKey", "Property", value)
end

--CurveTableFunc
private.curveTableFunc = {}

function private.curveTableFunc.createCurveTable(x, y, attributeName, mode, property)
    local newCurve = {}

    newCurve[private.generalLib.enum.get("RetentionData", "Count")] = 0
    newCurve[private.generalLib.enum.get("CurveTableKey", "CurveBaseTable")] = private.curveBaseFunc.createBaseCurve(x, y,
        attributeName, mode, property)

    return newCurve
end

function private.curveTableFunc.getCurveBaseTable(table)
    return private.tableFunc.getValueAndEnum(table, "CurveTableKey", "CurveBaseTable")
end

--CurveNodeFunc
private.curveNodeFunc = {}

function private.curveNodeFunc.createCurveNode(x, y, func, par, value, pvalue)
    local newCurveNode = {}

    newCurveNode[private.generalLib.enum.get("CurveNodeKey", "X")] = x
    newCurveNode[private.generalLib.enum.get("CurveNodeKey", "Y")] = y
    newCurveNode[private.generalLib.enum.get("CurveNodeKey", "Function")] = func
    newCurveNode[private.generalLib.enum.get("CurveNodeKey", "FuncParameter")] = par
    newCurveNode[private.generalLib.enum.get("CurveNodeKey", "NodeValue")] = value
    newCurveNode[private.generalLib.enum.get("CurveNodeKey", "ProcessNodeValue")] = pvalue

    return newCurveNode
end

function private.curveNodeFunc.getX(table)
    return private.tableFunc.getValueAndEnum(table, "CurveNodeKey", "X")
end

function private.curveNodeFunc.getY(table)
    return private.tableFunc.getValueAndEnum(table, "CurveNodeKey", "Y")
end

function private.curveNodeFunc.getFuncParameter(table)
    return private.tableFunc.getValueAndEnum(table, "CurveNodeKey", "FuncParameter")
end

function private.curveNodeFunc.getFunction(table)
    return private.tableFunc.getValueAndEnum(table, "CurveNodeKey", "Function")
end

function private.curveNodeFunc.getNodeValue(table)
    return private.tableFunc.getValueAndEnum(table, "CurveNodeKey", "NodeValue")
end

function private.curveNodeFunc.getProcessNodeValue(table)
    return private.tableFunc.getValueAndEnum(table, "CurveNodeKey", "ProcessNodeValue")
end

function private.curveNodeFunc.setX(table, value)
    private.tableFunc.setValueAndEnum(table, "CurveNodeKey", "X", value)
end

function private.curveNodeFunc.setY(table, value)
    private.tableFunc.setValueAndEnum(table, "CurveNodeKey", "Y", value)
end

function private.curveNodeFunc.setAttributeName(table, value)
    private.tableFunc.setValueAndEnum(table, "CurveNodeKey", "AttributeName", value)
end

function private.curveNodeFunc.setAttributeValue(table, value)
    private.tableFunc.setValueAndEnum(table, "CurveNodeKey", "AttributeValue", value)
end

function private.curveNodeFunc.setFuncParameter(table, value)
    private.tableFunc.setValueAndEnum(table, "CurveNodeKey", "FuncParameter", value)
end

function private.curveNodeFunc.setFunction(table, value)
    private.tableFunc.setValueAndEnum(table, "CurveNodeKey", "Function", value)
end

function private.curveNodeFunc.setNodeValue(table, value)
    private.tableFunc.setValueAndEnum(table, "CurveNodeKey", "NodeValue", value)
end

function private.curveNodeFunc.setProcessNodeValue(table, value)
    private.tableFunc.setValueAndEnum(table, "CurveNodeKey", "ProcessNodeValue", value)
end

--CurvesFunc
private.curvesFunc = {}

function private.curvesFunc.createCurves()
    local newCurves = {}
    newCurves[private.generalLib.enum.get("RetentionData", "Count")] = 0
    return newCurves
end

--BaseTableFunc
private.baseTableFunc = {}

function private.baseTableFunc.createBaseTable(data, x, y)
    local newBaseTable = {}

    newBaseTable[private.generalLib.enum.get("BaseTableKey", "Name")] = data.type
    newBaseTable[private.generalLib.enum.get("BaseTableKey", "X")] = x
    newBaseTable[private.generalLib.enum.get("BaseTableKey", "Y")] = y

    return newBaseTable
end

function private.baseTableFunc.getName(table)
    return private.tableFunc.getValueAndEnum(table, "BaseTableKey", "Name")
end

function private.baseTableFunc.getX(table)
    return private.tableFunc.getValueAndEnum(table, "BaseTableKey", "X")
end

function private.baseTableFunc.getY(table)
    return private.tableFunc.getValueAndEnum(table, "BaseTableKey", "Y")
end

function private.baseTableFunc.getBaseTable(table)
    return private.tableFunc.getBaseTable(table)
end

--ControlTableFunc
private.controlTableFunc = {}

function private.controlTableFunc.creteControlTable(data, x, y)
    local newRbmkConsoleControl = {}

    newRbmkConsoleControl[private.generalLib.enum.get("RetentionData", "BaseTable")] = private.createBaseTable(data, x, y)
    newRbmkConsoleControl[private.generalLib.enum.get("RbmkControlKey", "Mode")] = private.generalLib.enum.get(
    "ControlMode", "Static")
    newRbmkConsoleControl[private.generalLib.enum.get("RbmkControlKey", "Group")] = private.generalLib.enum.get(
    "RbmkColor", "NONE")
    newRbmkConsoleControl[private.generalLib.enum.get("RbmkControlKey", "MinValue")] = 0
    newRbmkConsoleControl[private.generalLib.enum.get("RbmkControlKey", "MaxValue")] = 100

    return newRbmkConsoleControl
end

function private.controlTableFunc.getMode(table)
    return private.tableFunc.getValueAndEnum(table, "RbmkControlKey", "Mode")
end

function private.controlTableFunc.getGroup(table)
    return private.tableFunc.getValueAndEnum(table, "RbmkControlKey", "Group")
end

function private.controlTableFunc.getMinValue(table)
    return private.tableFunc.getValueAndEnum(table, "RbmkControlKey", "MinValue")
end

function private.controlTableFunc.getMaxValue(table)
    return private.tableFunc.getValueAndEnum(table, "RbmkControlKey", "MaxValue")
end

function private.controlTableFunc.getBaseTable(table)
    return private.tableFunc.getBaseTable(table)
end

--MinTable
private.minTableFunc = {}

function private.minTableFunc.createMinTable()
    local newMinTable = {}
    newMinTable[private.generalLib.enum.get("RetentionData", "Count")] = 0
    return newMinTable
end

--MaxTable
private.maxTableFunc = {}

function private.maxTableFunc.createMaxTable()
    local newMaxTable = {}
    newMaxTable[private.generalLib.enum.get("RetentionData", "Count")] = 0
    return newMaxTable
end

--RbmkConsole
private.rbmkConsoleFunc = {}

function private.rbmkConsoleFunc.createRbmkConsoleTable(value)
    local newRbmkConsole = {}

    newRbmkConsole[private.generalLib.enum.get("RbmkConsoleKey", "Key")] = value
    newRbmkConsole[private.generalLib.enum.get("RbmkConsoleKey", "XYZ")] = value.getRBMKPos()
    newRbmkConsole[private.generalLib.enum.get("RbmkConsoleKey", "SimMode")] = private.generalLib.enum.get("SimMode",
        "FALSE")
    newRbmkConsole[private.generalLib.enum.get("RbmkConsoleKey", "Curves")] = private.curvesFunc.createCurves()
    newRbmkConsole[private.generalLib.enum.get("RbmkConsoleKey", "MinTable")] = private.minTableFunc.createMinTable()
    newRbmkConsole[private.generalLib.enum.get("RbmkConsoleKey", "MaxTable")] = private.maxTableFunc.createMaxTable()

    return newRbmkConsole
end

function private.rbmkConsoleFunc.getKey(table)
    return private.tableFunc.getValueAndEnum(table, "RbmkConsoleKey", "Key")
end

function private.rbmkConsoleFunc.getXYZ(table)
    return private.tableFunc.getValueAndEnum(table, "RbmkConsoleKey", "XYZ")
end

function private.rbmkConsoleFunc.getSimMode(table)
    return private.tableFunc.getValueAndEnum(table, "RbmkConsoleKey", "SimMode")
end

function private.rbmkConsoleFunc.getCurves(table)
    return private.tableFunc.getValueAndEnum(table, "RbmkConsoleKey", "Curves")
end

function private.rbmkConsoleFunc.getBaseTable(table)
    return private.retentionDataFunc.getBaseTable(table)
end

function private.rbmkConsoleFunc.getMinTable(table)
    return private.tableFunc.getValueAndEnum(table, "RbmkConsoleKey", "MinTable")
end

function private.rbmkConsoleFunc.getMaxTable(table)
    return private.tableFunc.getValueAndEnum(table, "RbmkConsoleKey", "MaxTable")
end

--Public
function public.getRbmkRunComponet(id)
    local table = private.rbmkConsoleFunc.getRunComponets(private.rbmkConsoleNow)
    if (table == nil) then
        return nil
    else
        for key, value in pairs(table)
        do
            if (value == id) then
                return key
            end
        end
    end
    return nil
end

function public.addRbmkRunComponet(id)
    local table = private.rbmkConsoleFunc.getRunComponets(private.rbmkConsoleNow)
    if (table == nil) then
        return false
    else
        for _, value in pairs(table)
        do
            if (value == id) then
                return true
            end
        end

        local tableCount = table[private.generalLib.enum.get("RetentionData", "Count")]
        table[tableCount] = id
        tableCount = tableCount + 1
    end
    return true
end

function public.getRbmkComponet(id)
    local table = private.rbmkConsoleNow[private.generalLib.enum.get("RbmkConsoleKey", "Componets")]
    if (table == nil) then
        return nil
    else
        return table[id]
    end
end

function public.getRbmkComponetFromXY(x, y)
    local table = nil
    local tempTable1 = private.rbmkConsoleNow[private.generalLib.enum.get("RbmkConsoleKey", "Componets")]

    for key, value in pairs(tempTable1)
    do
        local tempTable2 = value[private.generalLib.enum.get("RetentionData", "BaseTable")]
        if (tempTable2 ~= nil) then
            if (tempTable2[private.generalLib.enum.get("BaseTableKey", "X")] == x) then
                if (tempTable2[private.generalLib.enum.get("BaseTableKey", "Y")] == y) then
                    table = value
                    return table, key
                end
            end
        end
    end

    return nil, nil
end

function public.setRbmkConsole(key)
    private.rbmkConsoleNow = private.rbmkConsoleList[key]

    if (private.rbmkConsoleNow == nil)
    then
        return false
    else
        return true
    end
end

function public.getRbmkConsole()
    return private.rbmkConsoleNow
end

--function private.creteTemperatureEventTable()
--local newRbmkConsoleTemperature = {}
--return newRbmkConsoleTemperature
--end

function private.creteTableTest(data, x, y)
    local table = {}

    if (data.type == private.generalLib.enum.get("ComponetNames", "CONTROL")) then
        table = private.creteControlTable(data, x, y)
        --elseif (data.type == private.generalLib.enum.get("ComponetNames", "FUEL")) then
        --elseif (data.type == private.generalLib.enum.get("ComponetNames", "FUEL_SIM")) then
    else
        table[private.generalLib.enum.get("RetentionData", "BaseTable")] = private.baseTableFunc.createBaseTable(data, x,
            y)
    end

    return table
end

function private.findAllComponets(rbmkConsole)
    local componets = {}
    local data = {}
    local count = 0
    local typeName = nil

    componets[private.generalLib.enum.get("RetentionData", "Count")] = 0

    for j = 0, private.rbmkFindYMax, 1 do
        for i = 0, private.rbmkFindXMax, 1 do
            data = private.rbmkFunction.getComponetData(rbmkConsole, i, j)
            if (data.type ~= nil) then
                typeName = private.generalLib.enum.findToEnum("ComponetNames", data.type)
                if (typeName ~= nil) then
                    componets[count] = private.creteTableTest(data, i, j)
                    count = count + 1
                end
            end
        end
    end

    componets[private.generalLib.enum.get("RetentionData", "Count")] = count

    return componets
end

function private.findComponetXYFromAttribute(rbmkConsole, attributeName, flag)
    local data = {}
    local x = -1
    local y = -1
    local value = 0
    local count = 0

    for j = 0, private.rbmkFindYMax, 1 do
        for i = 0, private.rbmkFindXMax, 1 do
            data = private.rbmkFunction.getComponetData(rbmkConsole, i, j)
            if (data.type ~= nil) then
                if (data[attributeName] ~= nil) then
                    local dataValue = tonumber(data[attributeName])

                    if (dataValue == nil) then
                        goto continue
                    end

                    if (flag == private.generalLib.enum.get("RetentionData", "Min")) then
                        if (dataValue < value) then
                            value = dataValue
                            x = i
                            y = j
                        end
                    elseif (flag == private.generalLib.enum.get("RetentionData", "Max")) then
                        if (dataValue > value) then
                            value = dataValue
                            x = i
                            y = j
                        end
                    elseif (flag == private.generalLib.enum.get("RetentionData", "Average")) then
                        value = value + dataValue
                        count = count + 1
                    end
                end
            end
            ::continue::
        end
    end

    if (count ~= 0) then
        value = value / count
    end

    return x, y, value
end

function public.setCurveMode(id, openSimMode)
    local table = public.getRbmkComponet(id)

    if (table == nil) then
        return false
    end

    table[private.generalLib.enum.get("RbmkConsoleKey", "SimMode")] = private.generalLib.enum.get("SimMode", openSimMode)

    return true
end

--DefaultProcessFunction
private.defaultProcessFunction = {}

private.defaultProcessFunction.setLevel = function(value, nodeTable)
    private.rbmkFunction.setLevel(private.rbmkConsoleFunc.getKey(private.rbmkConsoleNow),
        private.curveNodeFunc.getX(nodeTable), private.curveNodeFunc.getY(nodeTable), value)
end

private.defaultProcessFunction.setGroupLevel = function(value, nodeTable)
    private.rbmkFunction.setColorLevel(private.rbmkConsoleFunc.getKey(private.rbmkConsoleNow),
        private.curveNodeFunc.getY(nodeTable), value)
end

--Run
function private.defaultCurveProcess(baseTable, curveCable, attributeValue)
    local count = private.retentionDataFunc.getCount(curveCable)
    local nodeNow = private.curveBaseFunc.getNodeNow(baseTable)

    for i = 0, count - 2, 1 do
        local nodeValue1 = private.curveNodeFunc.getNodeValue(curveCable[i])
        local nodeValue2 = private.curveNodeFunc.getNodeValue(curveCable[i + 1])

        local processNodeValue1 = private.curveNodeFunc.getProcessNodeValue(curveCable[i])
        local processNodeValue2 = private.curveNodeFunc.getProcessNodeValue(curveCable[i + 1])

        if (nodeValue1 <= nodeValue2) then
            if (attributeValue < nodeValue2) then
                if (attributeValue >= nodeValue1) then
                    if (private.curveBaseFunc.getCurveMode(baseTable) == private.generalLib.enum.get("CurveMode", "Dynamic")) then
                        if (nodeNow ~= i) then
                            private.curveBaseFunc.setNodeNow(baseTable, i)
                        end
                        local func = private.curveNodeFunc.getFunction(curveCable[i])
                        func(
                            private.advancedMath.mapIntervalValue(attributeValue, nodeValue1, nodeValue2,
                                processNodeValue1, processNodeValue2),
                            curveCable[i])
                    else
                        if (nodeNow ~= i) then
                            private.curveBaseFunc.setNodeNow(baseTable, i)
                            local func = private.curveNodeFunc.getFunction(curveCable[i])
                            func(processNodeValue1, curveCable[i])
                        end
                    end
                    return true
                end
            end
        elseif (nodeValue1 > nodeValue2) then
            if (attributeValue < nodeValue1) then
                if (attributeValue >= nodeValue2) then
                    if (private.curveBaseFunc.getCurveMode(baseTable) == private.generalLib.enum.get("CurveMode", "Dynamic")) then
                        if (nodeNow ~= i) then
                            private.curveBaseFunc.setNodeNow(baseTable, i)
                        end
                        local func = private.curveNodeFunc.getFunction(curveCable[i])
                        func(
                            private.advancedMath.mapIntervalValue(attributeValue, nodeValue2, nodeValue1,
                                processNodeValue2, processNodeValue1),
                            curveCable[i])
                    else
                        if (nodeNow ~= i) then
                            private.curveBaseFunc.setNodeNow(baseTable, i)
                            local func = private.curveNodeFunc.getFunction(curveCable[i])
                            func(processNodeValue1, curveCable[i])
                        end
                    end
                    return true
                end
            end
        end
    end
    return false
end

function private.noneCurveProcess(rbmkConsole, curveCable)
    local baseTable = private.curveTableFunc.getCurveBaseTable(curveCable)

    local attributeValue = tonumber(private.rbmkFunction.getComponetData(rbmkConsole,
        private.curveBaseFunc.getX(baseTable),
        private.curveBaseFunc.getY(baseTable))[private.curveBaseFunc.getAttributeName(baseTable)])

    if (attributeValue == nil) then
        return false
    end

    private.curveBaseFunc.setAttributeValue(baseTable, attributeValue)

    return private.defaultCurveProcess(baseTable, curveCable, attributeValue)
end

function private.globalCurveProcess(rbmkConsole, curveCable, cal)
    local baseTable = private.curveTableFunc.getCurveBaseTable(curveCable)

    local attributeName = private.curveBaseFunc.getAttributeName(baseTable)

    local x, y, value = private.findComponetXYFromAttribute(rbmkConsole, attributeName, cal)
    private.curveBaseFunc.setX(baseTable, x)
    private.curveBaseFunc.setY(baseTable, y)
    private.curveBaseFunc.setAttributeValue(baseTable, value)

    return private.defaultCurveProcess(baseTable, curveCable, value)
end

function private.groupCurveProcess(curveCable, attributeValue, cal)

end

function private.calCurve(rbmkConsole, curveCable)
    if (private.retentionDataFunc.getCount(curveCable) < 2) then
        return false
    end

    local property = private.curveBaseFunc.getProperty(private.curveTableFunc.getCurveBaseTable(curveCable))

    if (property == private.generalLib.enum.get("CurvePropertyKey", "None")) then
        private.noneCurveProcess(rbmkConsole, curveCable)
    elseif (property == private.generalLib.enum.get("CurvePropertyKey", "GlobalMin")) then
        private.globalCurveProcess(rbmkConsole, curveCable, private.generalLib.enum.get("RetentionData", "Min"))
    elseif (property == private.generalLib.enum.get("CurvePropertyKey", "GlobalMax")) then
        private.globalCurveProcess(rbmkConsole, curveCable, private.generalLib.enum.get("RetentionData", "Max"))
    elseif (property == private.generalLib.enum.get("CurvePropertyKey", "GroupMin")) then
        private.groupCurveProcess(rbmkConsole, curveCable, private.generalLib.enum.get("RetentionData", "Min"))
    elseif (property == private.generalLib.enum.get("CurvePropertyKey", "GroupMax")) then
        private.groupCurveProcess(rbmkConsole, curveCable, private.generalLib.enum.get("RetentionData", "Max"))
    end

    -- print(nodeValue1, nodeValue2, processNodeValue1, processNodeValue2, nodeNow, attributeValue)

    return true
end

function private.runUpdataCurves()
    local curves = private.rbmkConsoleFunc.getCurves(private.rbmkConsoleNow)
    local count = private.retentionDataFunc.getCount(curves)
    for i = 0, count - 1, 1 do
        private.calCurve(private.rbmkConsoleFunc.getKey(private.rbmkConsoleNow), curves[i])
    end
end

function private.runMinMaxTest()
    local countKey = private.generalLib.enum.get("RetentionData", "Count")
    local rbmkConsole = private.rbmkConsoleFunc.getKey(private.rbmkConsoleNow)

    local minTable = private.rbmkConsoleFunc.getMinTable(private.rbmkConsoleNow)
    local maxTable = private.rbmkConsoleFunc.getMaxTable(private.rbmkConsoleNow)
    for i = 0, private.rbmkFindYMax, 1 do
        for j = 0, private.rbmkFindXMax, 1 do
            local data = private.rbmkFunction.getComponetData(rbmkConsole, j, i)

            for key, value in pairs(minTable) do
                if (key ~= countKey) then
                    if (data[key] ~= nil) then
                        if (tonumber(data[key]) < tonumber(value)) then
                            public.emergencyStop()
                        end
                    end
                end
            end

            for key, value in pairs(maxTable) do
                if (key ~= countKey) then
                    if (data[key] ~= nil) then
                        if (tonumber(data[key]) > tonumber(value)) then
                            public.emergencyStop()
                        end
                    end
                end
            end
        end
    end
end

--public
function public.addNewMinValue(attributeName, value)
    private.rbmkConsoleFunc.getMinTable(private.rbmkConsoleNow)[attributeName] = value
end

function public.addNewMaxValue(attributeName, value)
    private.rbmkConsoleFunc.getMaxTable(private.rbmkConsoleNow)[attributeName] = value
end

function public.removeMinValue(attributeName, value)
    private.rbmkConsoleFunc.getMaxTable(private.rbmkConsoleNow)[attributeName] = value
end

function public.removeMaxValue(attributeName)
    if (attributeName == private.generalLib.enum.get("RetentionData", "Count")) then
        return
    end

    local table = private.rbmkConsoleFunc.getMaxTable(private.rbmkConsoleNow)
    local i = 0
    for key, _ in pairs(table) do
        if (key == attributeName) then
            table.remove(table, i)
            break
        end
        i = i + 1
    end
end

function public.emergencyStop()
    private.rbmkMode = 1
    private.rbmkFunction.emergencyStop(private.rbmkConsoleFunc.getKey(private.rbmkConsoleNow))
end

function public.regRbmkConsole(key, value)
    local table = private.rbmkConsoleFunc.createRbmkConsoleTable(value)
    private.rbmkConsoleList[key] = table
end

function public.addStaticCurve(x, y, attributeName)
    local curves = private.rbmkConsoleFunc.getCurves(private.rbmkConsoleNow)
    local count = private.retentionDataFunc.getCount(curves)

    curves[count] = private.curveTableFunc.createCurveTable(x, y, attributeName,
        private.generalLib.enum.get("CurveMode", "Static"))

    private.retentionDataFunc.setCount(curves, count + 1)

    return curves[count]
end

function public.addDynamicCurve(x, y, attributeName)
    local curves = private.rbmkConsoleFunc.getCurves(private.rbmkConsoleNow)
    local count = private.retentionDataFunc.getCount(curves)

    curves[count] = private.curveTableFunc.createCurveTable(x, y, attributeName,
        private.generalLib.enum.get("CurveMode", "Dynamic"))

    private.retentionDataFunc.setCount(curves, count + 1)

    return curves[count]
end

function public.addGlobalStaticCurve(attributeName, cal)
    local curves = private.rbmkConsoleFunc.getCurves(private.rbmkConsoleNow)
    local count = private.retentionDataFunc.getCount(curves)

    curves[count] = private.curveTableFunc.createCurveTable(-1, -1, attributeName,
        private.generalLib.enum.get("CurveMode", "Static"),
        private.generalLib.enum.get("CurvePropertyKey", "Global" .. cal))

    private.retentionDataFunc.setCount(curves, count + 1)

    return curves[count]
end

function public.addGlobalDynamicCurve(attributeName, cal)
    local curves = private.rbmkConsoleFunc.getCurves(private.rbmkConsoleNow)
    local count = private.retentionDataFunc.getCount(curves)

    curves[count] = private.curveTableFunc.createCurveTable(-1, -1, attributeName,
        private.generalLib.enum.get("CurveMode", "Dynamic"),
        private.generalLib.enum.get("CurvePropertyKey", "Global" .. cal))

    private.retentionDataFunc.setCount(curves, count + 1)

    return curves[count]
end

function public.addNodeToCurve(curve, x, y, value, pvalue, func, par)
    local count = private.retentionDataFunc.getCount(curve)
    local tempFunc = nil

    if (func == nil) then
        tempFunc = private.defaultProcessFunction.setLevel
    else
        tempFunc = func
    end

    curve[count] = private.curveNodeFunc.createCurveNode(x, y, tempFunc, par, value, pvalue)

    private.retentionDataFunc.setCount(curve, count + 1)

    return curve[count]
end

function public.addNodeToCurveGroup(curve, groupColor, value, pvalue, func, par)
    local count = private.retentionDataFunc.getCount(curve)
    local tempFunc = nil

    if (func == nil) then
        tempFunc = private.defaultProcessFunction.setGroupLevel
    else
        tempFunc = func
    end

    curve[count] = private.curveNodeFunc.createCurveNode(-1, private.generalLib.enum.get("RbmkColor", groupColor),
        tempFunc,
        par, value, pvalue)

    private.retentionDataFunc.setCount(curve, count + 1)

    return curve[count]
end

function public.removeNodeToCurve(value)
    if (value == private.generalLib.enum.get("RetentionData", "Count")) then
        return
    end

    for key, _ in pairs(private.rbmkConsoleFunc.getCurves(private.rbmkConsoleNow)) do
        if (key == value) then
            table.remove(table, value)
            break
        end
    end
end

function public.run()
    private.runMinMaxTest()
    private.runUpdataCurves()
    os.sleep(0.1)
end

function public.whileRun()
    while true do
        if (private.rbmkMode == 0) then
            public.run()
        else
            public.emergencyStop()
            os.sleep(0.1)
        end
    end
end

return public
