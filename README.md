# ZYYLOCLibs
为OpenComputers这个mod编写的兼容其他mod的库或程序

相关库寻找指示：

1.第一级文件一般为指示相关的类别，有以下内容：

ZYYLOCLibs.lua:起始引用文件，当你需要引用本库时，使用require("ZYYLOCLibs/ZYYLOCLibs.lua")来开始使用本库，这是必须使用require来使用的

Program:可以直接调用的程序

Lib:库文件

2.Lib:文件夹中一般都是Mod的名称的文件夹，在这文件夹之中，是该mod相关组件的文件夹的名称，在这个组件文件中，是该组件相关的lua库，如：

Lib（Lib-库类型文件）/hbm（mod名称）/RbmkConsole（mod组件的名称）/RbmkConsole.lua（具体的库）；

3.在mod文件夹中如果含有'mc版本_mod名称'的文件夹，那这些文件夹中一般是对不同版本下或者不同作者fork出的mod做的额外的兼容；

4.本作者一般会做兼容，所以你在实际使用时直接把整个库Lib或者这一个项目下载下来（可以直接打包为zip或者git下载），所有文件打包丢到你要用的地方就行，如：

Lib（Lib-库类型文件）/hbm（mod名称）/XX（所有文件和文件夹）；

5.一般在组件文件夹下和组件文件夹同名的lua文件是主文件（即使用require()函数可以直接调用）；

6.在一些文件夹中看到Test和Examples的文件夹名称，理解如下：

Test:一般放作者的测试的文件（不建议个人直接使用）

Examples:一般放示例程序（一般在组件文件夹下会有）

7.如Lib/General/XX中，可以看到General文件夹，这里一般放通用类型的lua文件，比如一些数学函数算法、事件等内容，这个文件夹中的内容是必须的

8.本库使用热加载模式，所以不要使用lua默认的require()函数来引用库，你应使用本库自带的loadLib()函数来引用库，如：

local ocLibs = require("ZYYLOCLibs/ZYYLOCLibs")

local generalLib = ocLibs.getGeneralLib()

local rbmkco = generalLib.config.libs.loadLib("mod名称", "组件名称")

9.你可以删除Libs中任何包含mod名称的文件夹，以此来减小本库体积

10.后面的字被猫给抓花了~~~喵~~~
