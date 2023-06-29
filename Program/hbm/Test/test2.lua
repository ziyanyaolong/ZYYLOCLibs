local rbmkco = require("rbmk_console")
local component = require("component")
local rbmk_console = component.rbmk_console

rbmkco.regRbmkConsole("A", rbmk_console)
rbmkco.setRbmkConsole("A")

rbmkco.addNewMaxValue("coreTemp", 3800)
rbmkco.addNewMinValue("water", 200)

local curve = rbmkco.addGlobalDynamicCurve("coreTemp", "Max")
rbmkco.addNodeToCurveGroup(curve, "RED", 20, 0.8)
rbmkco.addNodeToCurveGroup(curve, "RED", 100, 0)
rbmkco.addNodeToCurveGroup(curve, "RED", 1000, 1)
rbmkco.addNodeToCurveGroup(curve, "RED", 1200, 0.3)
rbmkco.addNodeToCurveGroup(curve, "RED", 3000, 0.5)
rbmkco.addNodeToCurveGroup(curve, "RED", 4000, 0)

local curve2 = rbmkco.addGlobalDynamicCurve("coreTemp", "Max")
rbmkco.addNodeToCurveGroup(curve2, "YELLOW", 20, 0.8)
rbmkco.addNodeToCurveGroup(curve2, "YELLOW", 100, 0.2)
rbmkco.addNodeToCurveGroup(curve2, "YELLOW", 1000, 1)
rbmkco.addNodeToCurveGroup(curve2, "YELLOW", 1200, 0.3)
rbmkco.addNodeToCurveGroup(curve2, "YELLOW", 3000, 0.5)
rbmkco.addNodeToCurveGroup(curve2, "YELLOW", 4000, 0)

local curve3 = rbmkco.addGlobalDynamicCurve("coreTemp", "Max")
rbmkco.addNodeToCurveGroup(curve3, "GREEN", 20, 0.5)
rbmkco.addNodeToCurveGroup(curve3, "GREEN", 100, 0.2)
rbmkco.addNodeToCurveGroup(curve3, "GREEN", 1000, 1)
rbmkco.addNodeToCurveGroup(curve3, "GREEN", 1200, 0.3)
rbmkco.addNodeToCurveGroup(curve3, "GREEN", 3000, 0.5)
rbmkco.addNodeToCurveGroup(curve3, "GREEN", 4000, 0)

local curve4 = rbmkco.addGlobalStaticCurve("coreTemp", "Max")
rbmkco.addNodeToCurveGroup(curve4, "BLUE", 20, 0.5)
rbmkco.addNodeToCurveGroup(curve4, "BLUE", 100, 0.2)
rbmkco.addNodeToCurveGroup(curve4, "BLUE", 1000, 0.5)
rbmkco.addNodeToCurveGroup(curve4, "BLUE", 1800, 0.25)
rbmkco.addNodeToCurveGroup(curve4, "BLUE", 3000, 0.10)
rbmkco.addNodeToCurveGroup(curve4, "BLUE", 3500, 0)

rbmkco.whileRun()
