 #!/bin/bash
 # Thank you, Lee Maschmeyer, for this example.
 
 read -n 1 -s -p $'Control-M leaves cursor at beginning of this line. Press Enter. \x0d'
                                   # 当然, '0d'就是二进制的回车. 
 echo >&2   #  '-s'参数使得任何输入都不将回显出来.
            #+ 所以, 明确的重起一行是必要的.
 
 read -n 1 -s -p $'Control-J leaves cursor on next line. \x0a'
            #  '0a' 等价于Control-J, 换行.
 echo >&2
 
 ###
 
 read -n 1 -s -p $'And Control-K\x0bgoes straight down.'
 echo >&2   #  Control-K 是垂直制表符.
 
 # 关于垂直制表符效果的一个更好的例子见下边:
 
 var=$'\x0aThis is the bottom line\x0bThis is the top line\x0a'
 echo "$var"
 #  这句与上边的例子使用的是同样的办法, 然而:
 echo "$var" | col
 #  这将造成垂直制表符右边的部分比左边部分高. 
 #  这也解释了为什么我们要在行首和行尾加上一个换行符 --
 #+ 这样可以避免屏幕显示混乱. 
 
 # Lee Maschmeyer的解释:
 # --------------------------
 #  在这里[第一个垂直制表符的例子中] . . . 
 #+ 这个垂直制表符使得还没回车就直接打印下来. 
 #  这只能在那些不能"后退"的设备中才行, 
 #+ 比如说Linux的console. 
 #  垂直制表符的真正意义是向上移, 而不是向下. 
 #  它可以用来让打印机打印上标. 
 #  col工具可以模拟垂直制表符的正确行为. 
 
 exit 0