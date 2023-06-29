# ZYYLOCLibs
为OpenComputers这个mod编写的兼容其他mod的库或程序

相关库寻找指示：

1.第一级文件一般为指示相关的类别，有以下内容：

Program:可以直接调用的程序

Lib:库文件

2.Lib:文件夹中一般都是Mod的名称的文件夹，在这文件夹之中，是该mod相关组件的文件夹的名称，在这个组件文件中，是该组件相关的lua库，如：

Lib（Lib-库类型文件）/hbm（mod名称）/RbmkConsole（mod组件的名称）/RbmkConsole.lua（具体的库）；

3.一般在组件文件夹下和组件文件夹同名的lua文件是主文件（即使用require()函数可以直接调用）；

4.在一些文件夹中看到Test和Examples的文件夹名称，理解如下：

Test:一般放作者的测试的文件（不建议个人直接使用）

Examples:一般放示例程序（一般在组件文件夹下会有）

5.后面的字被猫给抓花了~~~喵~~~
