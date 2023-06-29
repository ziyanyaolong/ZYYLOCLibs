local public = {}
local private = {}

public.libFunc = {}

private.generalLib = nil

function public.initLib(libPointer)
    private.generalLib = libPointer
    private.generalLib.config.libs.setLibVersions("RbmkCrane", "1.12.2")
end

function public.deleteLib()

end

local component = require("component")
local math = require("math")

local RbmkCrane = {}

local waitTime = 2
local waitLoadUnLoadTime = 5

local rbmkCraneList = {}
local rbmkCraneNow = {}

local rbmkCraneKey = 0
local nowXKey = 1
local nowYKey = 2

local function testToRange1(value, min, max)
    if (value > min)
    then
        if (value < max)
        then
            return true
        end
    end
    return false
end

local function decToInt(doubleNumber)
    local number = 0
    local numberInt, numberDec = math.modf(doubleNumber)

    if (numberInt >= 0) then
        number = math.floor(doubleNumber + 0.5)
    elseif (numberInt < 0) then
        number = math.ceil(doubleNumber - 0.5)
    else
        number = 0
    end
    return number
end

function RbmkCrane.addX(number)
    for i = 1, number, 1
    do
        rbmkCraneNow[rbmkCraneKey].moveRight()
        rbmkCraneNow[nowXKey] = rbmkCraneNow[nowXKey] + 1
        os.sleep(waitTime)
    end
end

function RbmkCrane.addY(number)
    for i = 1, number, 1
    do
        rbmkCraneNow[rbmkCraneKey].moveUp()
        rbmkCraneNow[nowYKey] = rbmkCraneNow[nowYKey] + 1
        os.sleep(waitTime)
    end
end

function RbmkCrane.subX(number)
    for i = 1, number, 1
    do
        rbmkCraneNow[rbmkCraneKey].moveLeft()
        rbmkCraneNow[nowXKey] = rbmkCraneNow[nowXKey] - 1
        os.sleep(waitTime)
    end
end

function RbmkCrane.subY(number)
    for i = 1, number, 1
    do
        rbmkCraneNow[rbmkCraneKey].moveDown()
        rbmkCraneNow[nowYKey] = rbmkCraneNow[nowYKey] - 1
        os.sleep(waitTime)
    end
end

function RbmkCrane.aaXY(number)
    for i = 1, number, 1
    do
        rbmkCraneNow[rbmkCraneKey].moveUpRight()
        rbmkCraneNow[nowXKey] = rbmkCraneNow[nowXKey] + 1
        rbmkCraneNow[nowYKey] = rbmkCraneNow[nowYKey] + 1
        os.sleep(waitTime)
    end
end

function RbmkCrane.asXY(number)
    for i = 1, number, 1
    do
        rbmkCraneNow[rbmkCraneKey].moveDownRight()
        rbmkCraneNow[nowXKey] = rbmkCraneNow[nowXKey] + 1
        rbmkCraneNow[nowYKey] = rbmkCraneNow[nowYKey] - 1
        os.sleep(waitTime)
    end
end

function RbmkCrane.saXY(number)
    for i = 1, number, 1
    do
        rbmkCraneNow[rbmkCraneKey].moveUpLeft()
        rbmkCraneNow[nowXKey] = rbmkCraneNow[nowXKey] - 1
        rbmkCraneNow[nowYKey] = rbmkCraneNow[nowYKey] + 1
        os.sleep(waitTime)
    end
end

function RbmkCrane.ssXY(number)
    for i = 1, number, 1
    do
        rbmkCraneNow[rbmkCraneKey].moveDownLeft()
        rbmkCraneNow[nowXKey] = rbmkCraneNow[nowXKey] - 1
        rbmkCraneNow[nowYKey] = rbmkCraneNow[nowYKey] - 1
        os.sleep(waitTime)
    end
end

function RbmkCrane.moveToX(targetX, oldX)
    local calX = targetX - oldX

    if (calX > 0)
    then
        RbmkCrane.addX(math.abs(calX))
    elseif (calX < 0)
    then
        RbmkCrane.subX(math.abs(calX))
    end
end

function RbmkCrane.moveToY(targetY, oldY)
    local calY = targetY - oldY

    if (calY > 0)
    then
        RbmkCrane.addY(math.abs(calY))
    elseif (calY < 0)
    then
        RbmkCrane.subY(math.abs(calY))
    end
end

function RbmkCrane.moveX(targetX)
    if (targetX > 0)
    then
        RbmkCrane.addX(math.abs(targetX))
    elseif (targetX < 0)
    then
        RbmkCrane.subX(math.abs(targetX))
    end
end

function RbmkCrane.moveY(targetY)
    if (targetY > 0)
    then
        RbmkCrane.addY(math.abs(targetY))
    elseif (targetY < 0)
    then
        RbmkCrane.subY(math.abs(targetY))
    end
end

function RbmkCrane.moveToPos(targetX, targetY, oldX, oldY)
    local calX = targetX - oldX
    local calY = targetY - oldY

    local minXY = math.min(math.abs(calX), math.abs(calY))

    if (calX > 0)
    then
        if (calY > 0)
        then
            RbmkCrane.aaXY(minXY)
        end
        if (calY < 0)
        then
            RbmkCrane.asXY(minXY)
        end
    elseif (calX < 0)
    then
        if (calY > 0)
        then
            RbmkCrane.saXY(minXY)
        end
        if (calY < 0)
        then
            RbmkCrane.ssXY(minXY)
        end
    end

    if (calX > 0)
    then
        calX = calX - minXY
    elseif (calX < 0)
    then
        calX = calX + minXY
    end

    if (calY > 0)
    then
        calY = calY - minXY
    elseif (calY < 0)
    then
        calY = calY + minXY
    end
    
    if (calX == 0)
    then
        RbmkCrane.moveY(calY)
    elseif (calY == 0)
    then
        RbmkCrane.moveX(calX)
    end
end

function RbmkCrane.moveToPosAuto(targetX, targetY)
    RbmkCrane.moveToPos(targetX, targetY, rbmkCraneNow[nowXKey], rbmkCraneNow[nowYKey])
end

function RbmkCrane.moveToPosAutoInGet(targetX, targetY)
    local x, y = rbmkCraneNow[rbmkCraneKey].getPos()
    RbmkCrane.moveToPos(targetX, targetY, decToInt(x), decToInt(y))
end

function RbmkCrane.posReset()
    local x, y = rbmkCraneNow[rbmkCraneKey].getPos()
    rbmkCraneNow[nowXKey] = decToInt(x)
    rbmkCraneNow[nowYKey] = decToInt(y)
    RbmkCrane.moveToPos(0, 0, rbmkCraneNow[nowXKey], rbmkCraneNow[nowYKey])
    rbmkCraneNow[nowXKey] = 0
    rbmkCraneNow[nowYKey] = 0
end

function RbmkCrane.loadUnload()
    rbmkCraneNow[rbmkCraneKey].loadUnload()
    os.sleep(waitLoadUnLoadTime)
end

function RbmkCrane.getPos()
    return rbmkCraneNow[nowXKey], rbmkCraneNow[nowYKey]
end

function RbmkCrane.getPosInGet()
    return rbmkCraneNow[rbmkCraneKey].getPos()
end

function RbmkCrane.regRbmkCrane(key, value)
    local nowX, nowY = value.getPos()
    local newRbmkCrane = {}
    newRbmkCrane[rbmkCraneKey] = value
    newRbmkCrane[nowXKey] = nowX
    newRbmkCrane[nowYKey] = nowY
    rbmkCraneList[key] = newRbmkCrane
end

function RbmkCrane.setRbmkCrane(key)
    rbmkCraneNow = rbmkCraneList[key]
end

return RbmkCrane