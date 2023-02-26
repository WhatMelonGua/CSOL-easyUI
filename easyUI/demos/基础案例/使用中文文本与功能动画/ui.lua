--class_uiComponent:sizeSet({width=你的屏幕宽,height=你的屏幕高})
-- 试试这个把！！！这个是最关键的！一定在设计时变成你的屏幕尺寸！
-- 这里的width千万别用 UI.ScreenSize获取，因为那是个函数，是一直变化的！
-- 也就是当客户端运行时，他的UI.ScreenSize和你的未必是一样的！
-- 一定要在游戏 设置里 查看 视频分辨率 的俩数字填进去！
class_uiComponent:sizeSet({width=1280,height=800})
-- 设置 设计（写代码那台电脑游戏运行时的）屏幕尺寸 我这里是 1280x800
-- 如果你的不是，你会发现我的内容还是说完好展示！没有缺失，位置也比较均匀
-- 这就是uiComp自带的屏幕修正功能！
-- 想让他好好运作 一定要sizeSet！	-- 如果你能通过屏幕中央进行定位，那么您可以不用fixAble和sizeSet！

-- 不使用sizeSet 默认组件不进行屏幕修正（就是对组件拉伸，保证都在屏幕内）

bar = class_uiComponent.new():setRegister(
	{x=0,y=0,width=1280,height=100,r=255,g=255,b=255,a=155}
):boxSupply()		-- 标准的初始化Comp构建流程，先new，在注入set，最后boxSupply创建UI.Box
-- 我们直接绘制这个文字展示条,设定位置后绘制
bar:positionSet({x=0,y=80}):Draw()

-- 创建一个文字发生器
generator = class_uiTextGenerator.new(LanaPixel)	-- 基于LanaPixel字体生成文本

hello_text = generator:textComponent({x=100,y=100},'欢迎来到 easyUI 实战！\n使用\\n换行！',30) 
-- 在 x=100，y=100位置，生成 40字号大小 黑色的 如上文本， \\ 其实是 \，这是电脑识别特殊字符的方式
-- \n在电脑看来就是 下一行，所以只输入一个 \ 电脑会混淆，要输入 \\ 表示 我们理解的 \
anime_rate = generator:textComponent({x=600,y=100},'',32,{r=255,g=100,b=40,a=255}) 
-- 空文字，后边用 textUpdate更新，显示动画进行度 并设置颜色

hello_text:Draw()
-- 绘制文本

-- 通过UIBoxPainter模板 创建 钻石一枚
diamond = class_uiComponent.fromTemplate(Demo.diamond):localCenter()
-- localCenter把中心点移至 组件中央，可以试试删除:localCenter() 观察动画位置的改变！
-- diamon先不绘制，动画激活后会自动每帧绘制！


-- 这个动画函数，让钻石做 半圆周运动！
function diamondMove( target,process )	-- 这里target就是动画对象，也就是开头的 diamond钻石组件
	local stageInfo = {pos={x=nil,y=nil},scale={x=0.6,y=0.6}} -- 返回stage给动画用,以钻石的0.6倍大小
	-- 这里我们不涉及大小变化，所以 scale都是固定的，x，y待定先为 nil
	-- process代表动画进行程度
	local point = {x=500,y=300}		-- 圆形路径的圆心位置
	local r = 200    -- 圆形半径
	-- 圆形的公式是 (x-a)^2 + (y-b)^2 = r^2 这里r=200 ，a b代表圆心的 x，y坐标
	-- 我们假设圆心是 0，0 好计算，算出来在位移 point的x y 结果一样哒！(相对位移)
	local x = (process-0.5)*2*r -- 坐标轴圆的 x取值范围是 直径 = 2个半径
	-- 把圆形放在坐标轴内，我们初中的内容， 通过x 求算y值！函数！
	-- 因为process动画进度 代表0~1 的值，意思是 动画进行了百分之多少（百分比最大为1）
	-- 所以我们 process-0.5，这样 process=0.5 才是 圆形中心处（x=0）！（最左边x=-0.5*r，最右边x=0.5*r对称）
	local y = (r^2 - x^2)^(1/2) -- 移项，开根号算出y
	-- 给stage的位置注入 x 和 y
	stageInfo.pos.x = point.x + x --为什么是point减去，相当于point是坐标系原点！（0,0）
	stageInfo.pos.y = point.y - y 	-- 加y就是下半圆咯

	-- 最后更新下文字 动画进行程度
	generator:textUpdate(anime_rate,{text='动画进度: '..string.format("%.4f",process),color={r=255,g=100,b=50,a=255}})
	-- 更新文字，.. 是链接前后两个字符；
	-- string.format 是 把process转为 字符串，并且 %.4f 代表 保留4位小数 %.2f就是保留2位
	anime_rate:Draw()	-- Draw绘制才会更新
	-- 更新完毕

	return stageInfo
	-- 返回stageInfo，动画接收到就会进行逐帧绘制啦！
	-- 当然这个变量名称你可以改 stage/stageInfo/jiliguala 都可以随便你
end

function allCycleMove( target,process )	
	-- 有能力可以把 stage= 改成这个函数，是全部圆周运动，可以研究下实现原理
	process = process*2
	local stageInfo = {pos={x=nil,y=nil},scale={x=0.6,y=0.6}} 
	local point = {x=500,y=300}		
	local r = 200   
	local x = (process-0.5)*2*r
	if process > 1 then
		x = (process-1.5)*2*r*(-1)
	end
	local y = (r^2 - x^2)^(1/2) 
	stageInfo.pos.x = point.x + x 
	stageInfo.pos.y = point.y - y 	
	if process > 1 then
		stageInfo.pos.y = point.y + y 
	end
	-- 最后更新下文字 动画进行程度
	generator:textUpdate(anime_rate,{text='动画进度: '..string.format("%.4f",process/2),color={r=255,g=100,b=50,a=255}})
	-- 更新文字，.. 是链接前后两个字符；
	-- string.format 是 把process转为 字符串，并且 %.4f 代表 保留4位小数 %.2f就是保留2位
	anime_rate:Draw()	-- Draw绘制才会更新
	-- 更新完毕

	return stageInfo
	-- 返回stageInfo，动画接收到就会进行逐帧绘制啦！
	-- 当然这个变量名称你可以改 stage/stageInfo/jiliguala 都可以随便你
end

-- 创建动画对象，并开启循环播放
cycleAnime = class_uiAnime.new({
target = diamond,
stage = diamondMove, 		-- stage支持 表/函数操控动画！很灵活哒！ 表类型的见 案例<基本绘制与动画>
--stage = allCycleMove,	
duration = 3,
loop = true	
})

cycleAnime:start()		-- 开启动画

function UI.Event:OnUpdate( t )
	class_uiAnime:queueActivate(t)		-- 激活动画管理器，否则动画都不生效
end