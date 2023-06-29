local componet = require("component")

public = {}
local private = {}

--Register List
private.rbmkConsoleList = {}
private.rbmkConsoleNow = {}
private.rbmkMode = 0

--const
--enum
public.enum = {}
function public.enum.addToEnum(name, value)
    if (public.enum[name] == nil) then
        local newTable = {}
        public.enum[name] = newTable
        public.enum[name]["EnumCount"] = 0
    end

    public.enum[name][public.enum[name]["EnumCount"]] = value
    public.enum[name][value] = public.enum[name]["EnumCount"]

    public.enum[name]["EnumCount"] = public.enum[name]["EnumCount"] + 1
end

function public.enum.addToEnumMap(name, key, value)
    if (public.enum[name] == nil) then
        local newTable = {}
        public.enum[name] = newTable
        public.enum[name]["EnumCount"] = 0
    end

    public.enum[name][key] = value

    public.enum[name]["EnumCount"] = public.enum[name]["EnumCount"] + 1
end

function public.enum.findToEnum(name, value)
    if (public.enum[name] == nil) then
        return nil
    end
    return public.enum[name][value]
end

function public.enum.get(name, value)
    return public.enum[name][value]
end

--enum adds
--ComponetNames
public.enum.addToEnum("ComponetNames", "OTHER")
public.enum.addToEnum("ComponetNames", "FUEL")
public.enum.addToEnum("ComponetNames", "FUEL_SIM")
public.enum.addToEnum("ComponetNames", "CONTROL")
public.enum.addToEnum("ComponetNames", "CONTROL_AUTO")
public.enum.addToEnum("ComponetNames", "HEATEX")
public.enum.addToEnum("ComponetNames", "ABSORBER")
public.enum.addToEnum("ComponetNames", "COLLER")
public.enum.addToEnum("ComponetNames", "BOILER")
public.enum.addToEnum("ComponetNames", "REFLECTOR")
public.enum.addToEnum("ComponetNames", "STORAGE")

--RbmkColor
public.enum.addToEnum("RbmkColor", "RED")
public.enum.addToEnum("RbmkColor", "YELLOW")
public.enum.addToEnum("RbmkColor", "GREEN")
public.enum.addToEnum("RbmkColor", "BLUE")
public.enum.addToEnum("RbmkColor", "PURPLE")
public.enum.addToEnum("RbmkColor", "NONE")

--SimMode
public.enum.addToEnum("SimMode", "FALSE")
public.enum.addToEnum("SimMode", "TRUE")

--RetentionData
public.enum.addToEnumMap("RetentionData", "BaseTable", "BaseTable")
public.enum.addToEnumMap("RetentionData", "Count", "Count")
public.enum.addToEnumMap("RetentionData", "Color", "Color")
public.enum.addToEnumMap("RetentionData", "Min", "Min")
public.enum.addToEnumMap("RetentionData", "Max", "Max")
public.enum.addToEnumMap("RetentionData", "Average", "Average")

--BaseTableKeys
public.enum.addToEnum("BaseTableKey", "Name")
public.enum.addToEnum("BaseTableKey", "X")
public.enum.addToEnum("BaseTableKey", "Y")
public.enum.addToEnum("BaseTableKey", "Temperature")

--ConsoleKeys
public.enum.addToEnum("RbmkConsoleKey", "Key")
public.enum.addToEnum("RbmkConsoleKey", "XYZ")
public.enum.addToEnum("RbmkConsoleKey", "SimMode")
public.enum.addToEnum("RbmkConsoleKey", "Curves")
public.enum.addToEnum("RbmkConsoleKey", "MinTable")
public.enum.addToEnum("RbmkConsoleKey", "MaxTable")

--ControlTableKeys
public.enum.addToEnum("RbmkControlKey", "Mode")
public.enum.addToEnum("RbmkControlKey", "Group")
public.enum.addToEnum("RbmkControlKey", "MinValue")
public.enum.addToEnum("RbmkControlKey", "MaxValue")

--CurveBaseTableKeys
public.enum.addToEnum("CurveBaseKey", "X")
public.enum.addToEnum("CurveBaseKey", "Y")
public.enum.addToEnum("CurveBaseKey", "AttributeName")
public.enum.addToEnum("CurveBaseKey", "AttributeValue")
public.enum.addToEnum("CurveBaseKey", "CurveMode")
public.enum.addToEnum("CurveBaseKey", "NodeNow")
public.enum.addToEnum("CurveBaseKey", "Property")

--CurveTableKeys
public.enum.addToEnumMap("CurveTableKey", "CurveBaseTable", "CurveBaseTable")

--CurveNodeKeys
public.enum.addToEnum("CurveNodeKey", "X")
public.enum.addToEnum("CurveNodeKey", "Y")
public.enum.addToEnum("CurveNodeKey", "FuncParameter")
public.enum.addToEnum("CurveNodeKey", "Function")
public.enum.addToEnum("CurveNodeKey", "NodeValue")
public.enum.addToEnum("CurveNodeKey", "ProcessNodeValue")

--CurvePropertyKeys
public.enum.addToEnum("CurvePropertyKey", "None")
public.enum.addToEnum("CurvePropertyKey", "GlobalMin")
public.enum.addToEnum("CurvePropertyKey", "GlobalMax")
public.enum.addToEnum("CurvePropertyKey", "GroupMin")
public.enum.addToEnum("CurvePropertyKey", "GroupMax")

--CurveMode
public.enum.addToEnum("CurveMode", "Static")
public.enum.addToEnum("CurveMode", "Dynamic")

-- --Test Type
-- public.enum.addToEnum("TestType", "Mode")
-- public.enum.addToEnum("TestType", "Group")
-- public.enum.addToEnum("TestType", "MinValue")
-- public.enum.addToEnum("TestType", "MaxValue")

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
    return table[public.enum.get(eKey, eValue)]
end

function private.tableFunc.setValue(table, key, value)
    table[key] = value
end

function private.tableFunc.setValueAndEnum(table, eKey, eValue, value)
    table[public.enum.get(eKey, eValue)] = value
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

    newCurveNode[public.enum.get("CurveBaseKey", "X")] = x
    newCurveNode[public.enum.get("CurveBaseKey", "Y")] = y
    newCurveNode[public.enum.get("CurveBaseKey", "AttributeName")] = attributeName
    newCurveNode[public.enum.get("CurveBaseKey", "AttributeValue")] = nil
    newCurveNode[public.enum.get("CurveBaseKey", "CurveMode")] = mode
    newCurveNode[public.enum.get("CurveBaseKey", "NodeNow")] = nil

    if (property == nil) then
        newCurveNode[public.enum.get("CurveBaseKey", "Property")] = public.enum.get("CurvePropertyKey", "None")
    else
        newCurveNode[public.enum.get("CurveBaseKey", "Property")] = property
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

    newCurve[public.enum.get("RetentionData", "Count")] = 0
    newCurve[public.enum.get("CurveTableKey", "CurveBaseTable")] = private.curveBaseFunc.createBaseCurve(x, y,
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

    newCurveNode[public.enum.get("CurveNodeKey", "X")] = x
    newCurveNode[public.enum.get("CurveNodeKey", "Y")] = y
    newCurveNode[public.enum.get("CurveNodeKey", "Function")] = func
    newCurveNode[public.enum.get("CurveNodeKey", "FuncParameter")] = par
    newCurveNode[public.enum.get("CurveNodeKey", "NodeValue")] = value
    newCurveNode[public.enum.get("CurveNodeKey", "ProcessNodeValue")] = pvalue

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
    newCurves[public.enum.get("RetentionData", "Count")] = 0
    return newCurves
end

--BaseTableFunc
private.baseTableFunc = {}

function private.baseTableFunc.createBaseTable(data, x, y)
    local newBaseTable = {}

    newBaseTable[public.enum.get("BaseTableKey", "Name")] = data.type
    newBaseTable[public.enum.get("BaseTableKey", "X")] = x
    newBaseTable[public.enum.get("BaseTableKey", "Y")] = y

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

    newRbmkConsoleControl[public.enum.get("RetentionData", "BaseTable")] = private.createBaseTable(data, x, y)
    newRbmkConsoleControl[public.enum.get("RbmkControlKey", "Mode")] = public.enum.get("ControlMode", "Static")
    newRbmkConsoleControl[public.enum.get("RbmkControlKey", "Group")] = public.enum.get("RbmkColor", "NONE")
    newRbmkConsoleControl[public.enum.get("RbmkControlKey", "MinValue")] = 0
    newRbmkConsoleControl[public.enum.get("RbmkControlKey", "MaxValue")] = 100

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
    newMinTable[public.enum.get("RetentionData", "Count")] = 0
    return newMinTable
end

--MaxTable
private.maxTableFunc = {}

function private.maxTableFunc.createMaxTable()
    local newMaxTable = {}
    newMaxTable[public.enum.get("RetentionData", "Count")] = 0
    return newMaxTable
end

--RbmkConsole
private.rbmkConsoleFunc = {}

function private.rbmkConsoleFunc.createRbmkConsoleTable(value)
    local newRbmkConsole = {}

    newRbmkConsole[public.enum.get("RbmkConsoleKey", "Key")] = value
    newRbmkConsole[public.enum.get("RbmkConsoleKey", "XYZ")] = value.getRBMKPos()
    newRbmkConsole[public.enum.get("RbmkConsoleKey", "SimMode")] = public.enum.get("SimMode", "FALSE")
    newRbmkConsole[public.enum.get("RbmkConsoleKey", "Curves")] = private.curvesFunc.createCurves()
    newRbmkConsole[public.enum.get("RbmkConsoleKey", "MinTable")] = private.minTableFunc.createMinTable()
    newRbmkConsole[public.enum.get("RbmkConsoleKey", "MaxTable")] = private.maxTableFunc.createMaxTable()

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

        local tableCount = table[public.enum.get("RetentionData", "Count")]
        table[tableCount] = id
        tableCount = tableCount + 1
    end
    return true
end

function public.getRbmkComponet(id)
    local table = private.rbmkConsoleNow[public.enum.get("RbmkConsoleKey", "Componets")]
    if (table == nil) then
        return nil
    else
        return table[id]
    end
end

function public.getRbmkComponetFromXY(x, y)
    local table = nil
    local tempTable1 = private.rbmkConsoleNow[public.enum.get("RbmkConsoleKey", "Componets")]

    for key, value in pairs(tempTable1)
    do
        local tempTable2 = value[public.enum.get("RetentionData", "BaseTable")]
        if (tempTable2 ~= nil) then
            if (tempTable2[public.enum.get("BaseTableKey", "X")] == x) then
                if (tempTable2[public.enum.get("BaseTableKey", "Y")] == y) then
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

    if (data.type == public.enum.get("ComponetNames", "CONTROL")) then
        table = private.creteControlTable(data, x, y)
        --elseif (data.type == public.enum.get("ComponetNames", "FUEL")) then
        --elseif (data.type == public.enum.get("ComponetNames", "FUEL_SIM")) then
    else
        table[public.enum.get("RetentionData", "BaseTable")] = private.baseTableFunc.createBaseTable(data, x, y)
    end

    return table
end

function private.findAllComponets(rbmkConsole)
    local componets = {}
    local data = {}
    local count = 0
    local typeName = nil

    componets[public.enum.get("RetentionData", "Count")] = 0

    for j = 0, private.rbmkFindYMax, 1 do
        for i = 0, private.rbmkFindXMax, 1 do
            data = private.rbmkFunction.getComponetData(rbmkConsole, i, j)
            if (data.type ~= nil) then
                typeName = public.enum.findToEnum("ComponetNames", data.type)
                if (typeName ~= nil) then
                    componets[count] = private.creteTableTest(data, i, j)
                    count = count + 1
                end
            end
        end
    end

    componets[public.enum.get("RetentionData", "Count")] = count

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

                    if(dataValue == nil) then
                        goto continue
                    end

                    if (flag == public.enum.get("RetentionData", "Min")) then
                        if (dataValue < value) then
                            value = dataValue
                            x = i
                            y = j
                        end
                    elseif (flag == public.enum.get("RetentionData", "Max")) then
                        if (dataValue > value) then
                            value = dataValue
                            x = i
                            y = j
                        end
                    elseif (flag == public.enum.get("RetentionData", "Average")) then
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

    table[public.enum.get("RbmkConsoleKey", "SimMode")] = public.enum.get("SimMode", openSimMode)

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
                    if (private.curveBaseFunc.getCurveMode(baseTable) == public.enum.get("CurveMode", "Dynamic")) then
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
                    if (private.curveBaseFunc.getCurveMode(baseTable) == public.enum.get("CurveMode", "Dynamic")) then
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

    if (property == public.enum.get("CurvePropertyKey", "None")) then
        private.noneCurveProcess(rbmkConsole, curveCable)
    elseif (property == public.enum.get("CurvePropertyKey", "GlobalMin")) then
        private.globalCurveProcess(rbmkConsole, curveCable, public.enum.get("RetentionData", "Min"))
    elseif (property == public.enum.get("CurvePropertyKey", "GlobalMax")) then
        private.globalCurveProcess(rbmkConsole, curveCable, public.enum.get("RetentionData", "Max"))
    elseif (property == public.enum.get("CurvePropertyKey", "GroupMin")) then
        private.groupCurveProcess(rbmkConsole, curveCable, public.enum.get("RetentionData", "Min"))
    elseif (property == public.enum.get("CurvePropertyKey", "GroupMax")) then
        private.groupCurveProcess(rbmkConsole, curveCable, public.enum.get("RetentionData", "Max"))
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
    local countKey = public.enum.get("RetentionData", "Count")
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
    if (attributeName == public.enum.get("RetentionData", "Count")) then
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

    curves[count] = private.curveTableFunc.createCurveTable(x, y, attributeName, public.enum.get("CurveMode", "Static"))

    private.retentionDataFunc.setCount(curves, count + 1)

    return curves[count]
end

function public.addDynamicCurve(x, y, attributeName)
    local curves = private.rbmkConsoleFunc.getCurves(private.rbmkConsoleNow)
    local count = private.retentionDataFunc.getCount(curves)

    curves[count] = private.curveTableFunc.createCurveTable(x, y, attributeName, public.enum.get("CurveMode", "Dynamic"))

    private.retentionDataFunc.setCount(curves, count + 1)

    return curves[count]
end

function public.addGlobalStaticCurve(attributeName, cal)
    local curves = private.rbmkConsoleFunc.getCurves(private.rbmkConsoleNow)
    local count = private.retentionDataFunc.getCount(curves)

    curves[count] = private.curveTableFunc.createCurveTable(-1, -1, attributeName,
        public.enum.get("CurveMode", "Static"), public.enum.get("CurvePropertyKey", "Global" .. cal))

    private.retentionDataFunc.setCount(curves, count + 1)

    return curves[count]
end

function public.addGlobalDynamicCurve(attributeName, cal)
    local curves = private.rbmkConsoleFunc.getCurves(private.rbmkConsoleNow)
    local count = private.retentionDataFunc.getCount(curves)

    curves[count] = private.curveTableFunc.createCurveTable(-1, -1, attributeName,
        public.enum.get("CurveMode", "Dynamic"), public.enum.get("CurvePropertyKey", "Global" .. cal))

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

    curve[count] = private.curveNodeFunc.createCurveNode(-1, public.enum.get("RbmkColor", groupColor), tempFunc,
        par, value, pvalue)

    private.retentionDataFunc.setCount(curve, count + 1)

    return curve[count]
end

function public.removeNodeToCurve(value)
    if (value == public.enum.get("RetentionData", "Count")) then
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
