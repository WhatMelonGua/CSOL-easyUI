class_uiComponent:sizeSet({width=1280,height=800})
-- 如果您设计的是 人物界面，请一定要加这句话
-- 我这里是 1280x800 屏，就填写如上，别用UI.ScreeSize获取的来填，那个会变化！
-- 这可以保证你的界面 在任何电脑屏幕下 都能显示完全！这是屏幕修正自适应的力量！
class_uiComponent.fixAble = true		
-- 默认创建的组件都接受 屏幕适应修正， 要设置为true  否则默认为false，sizeSet将不被使用，屏幕修正无法进行


-- 根据UIBoxPainter模板创建 斧头组件
futou = class_uiComponent.fromTemplate(ceshi.futou)

-- 如果你不想通过模板创建，而是通过以往传统的 set一个个设置box，请如下填写：
-- futou = class_uiComponent.new() -- 创建新的uiComp对象，它现在是空的，什么都没有
-- futou:setRegister(
--	{x=40,y=45,width=20,height=200,r=202,g=153,b=68,a=255},
--	{x=60,y=225,width=5,height=20,r=225,g=176,b=91,a=255},
--	{x=35,y=45,width=5,height=50,r=210,g=161,b=75,a=255},
--	{x=30,y=45,width=5,height=30,r=225,g=176,b=91,a=255},
--	{x=40,y=245,width=15,height=5,r=192,g=137,b=42,a=255},
--	{x=35,y=185,width=5,height=40,r=225,g=176,b=91,a=255},
--	{x=75,y=0,width=20,height=55,r=181,g=179,b=188,a=255},
--	{x=92,y=0,width=8,height=65,r=224,g=222,b=232,a=255},
--	{x=0,y=0,width=30,height=15,r=218,g=215,b=229,a=255},
--	{x=20,y=5,width=60,height=40,r=250,g=60,b=60,a=255},
--	{x=10,y=0,width=75,height=5,r=238,g=129,b=129,a=255},
--	{x=50,y=45,width=30,height=5,r=226,g=60,b=60,a=255},
--	{x=10,y=5,width=40,height=20,r=250,g=60,b=60,a=255},
--	{x=35,y=0,width=20,height=45,r=255,g=255,b=255,a=100},
--	{x=80,y=15,width=5,height=20,r=250,g=60,b=60,a=255},
--)
-- 通过setRegister 把斧头的box 的 setArg逐个注入 组件内
-- futou:boxSupply()  -- 除了setArg我们还要由 box来画出来，我们通过boxSupply 自动创建和set一样多的 box
-- futou:Draw() 绘制即可，默认绘制位置在 x=0,y=0，您可以通过positionSet 更改位置，剩余的都和fromtemplate一样啦！

-- 相当于fromTemplate 帮你省略了 new + 补充box/set的 步骤，相同setArg的情况下 二者本质是一样的

-- 创建完毕，将斧头坐标设置在 x=200，y=300 位置
futou:positionSet({x=300,y=300})
-- 把斧头变成原来的 0.5 倍大小
futou:scaleSet({x=1,y=1})
-- 设定完毕，进行绘制
futou:Draw()

function UI.Event:OnKeyDown (inputs)
	if inputs[UI.KEY.R] then		-- 按下R键，斧头顺时针旋转 90度 1次
		print('------------')
		futou:setRotate(1)
		futou:Draw()	-- 别忘了更新绘制，不然不显示旋转后的效果
	end
end

-- 下边我们试试动画效果！

function UI.Event:OnUpdate( t )
	class_uiAnime:queueActivate( t )		-- 用动画的话，这句必写
	-- 这一句是激活 动画管理器 用的，不激活动画将全部失效！
	-- 因为动画就是由 管理器 来管理、处理播放的！
end


-- 给futou 申请动画		-- new函数的写法见文档说明！多看多练哦
futouAnime = class_uiAnime.new({
target=futou, -- 声明动画的对象是 斧头组件
duration = 3, -- 此动画在3秒内完成
stage={
	{rate=0,pos={x=300,y=300},scale={x=1,y=1}},	-- 动画进行到0 也就是刚开始，位置pos 和缩放scale的大小
	{rate=0.5,pos={x=400,y=300},scale={x=1,y=1}},	-- 动画至一半 也就是0.5的
	{rate=1,pos={x=400,y=500},scale={x=1,y=1}}	-- 动画结束的状态
},
loop = true,	-- loop=true 开启动画循环
easing = {name='easeIn',parm=3}	-- 缓动函数，很神奇的东西，可在文档翻阅！
})

futouAnime:start()
-- 使用start激活动画，否则动画不播放！