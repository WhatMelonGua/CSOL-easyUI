class_uiAnime.sizeSet(width=1280,height=800)
--使用sizeSet后 默认创建的组件都经受 屏幕修正

status = {false,false,false,false,false,false,false}	
-- 教学的进度,分别为 欢迎界面 / uiComp介绍 / 图形学操作 / uiAnime介绍 / 缓动函数 / 结束语 / 退出
statusKey = UI.KEY.K 	-- 激活状态改变的按键
statusLock = {i=0,lock=true}	-- 状态锁

mask = class_uiComponent.new():setRegister(
{x=0,y=0,width=GLOBAL_WINSIZE.width,height=GLOBAL_WINSIZE.height,r=80,g=80,b=80,a=255}):boxSupply()
-- mask 第一个声明，避免遮盖其他的ui组件
function welcome( )
	statusInit()
	status[1] = true
	logoGet()
	-- P0 WELCOME激活
	uS_title.reNew({
		'欢迎使用 easyUI.lua 组件库！',
		'接下来，本案例将 ——',
		'1. 演示基础用法',
		'2. 展示特色功能',
		'3. 为您进行部分代码技法展示',
		'按 [ K ] 继续演示……'
	})
	-- 初始化标题展示，第一次展示完毕按K 为LOGOPut开始展示
	uiTitle.user = {continue=logoPut.start}  -- 传入函数对象
	uiTitle.user.target = logoPut 	-- start传入logoPut对象，等同于logoPut:start 冒号传参
	panelOpen:start()	-- 注册面板弹出动画，并开始播放
	-- callback实现了 动画续播，您可以注释掉 panelOpen，会发现所有动画都将不存在
	-- 相当于panelOpen成为了整体流程的 入点
end

function compIntro( ... )
	statusInit()
	status[2] = true
	-- 更改panel的标题展示内容
	uS_title.reNew({
		'章节一   组件化',
		'我们使用 UI.Box进行绘制',
		'但总是 多个UI.Box一起',
		'组成 某一个东西',
		'比如多个Box 组成',
		'展示框/战绩栏等',
		'我们如果要操作，',
		'通常是对 这些组件',
		'也就是 展示框/战绩栏 进行操作',
		'按 [K] 继续演示……'
	})
	-- P1 uiComp介绍
	waitDraw.user = {{DEMO.nothing,{x=300,y=300}},
					{DEMO.diamond,{x=300,y=300}},
					{DEMO.gold,{x=500,y=300}},
					{DEMO.armor,{x=300,y=600}},
					{DEMO.arrow,{x=500,y=600}},
					{DEMO.gameBar,{x=300,y=200}},
					i=1}	-- 注册组件展示动画
	waitDraw:start()
	panelOpen:start()	-- 注册面板弹出动画，并开始播放
end

function rotate( ... )
	statusInit()
	status[3] = true
	mask:Show()	-- 蒙蔽遮挡展开
	mask:Draw()
	titleFadeOut.duration = 4
	uS_title.reNew({
		'试试 组件 的图形学变换功能！',
		'按 [R/Z] 旋转 钻石！',
		'按 [F] 放大 钻石！',
		'按 [E] 缩小 钻石！',
		'按 [M/P] 镜像 钻石！',
		'最后试试 上下左右 箭头吧！',
		'您应该发现屏幕中心的 组件！',
		'试着将钻石移向 它！',
		'按下 [N] 将之与钻石组合',
		'这样他们构成整体！再一起移动！',
		'体验完毕后，您可按 [K] 继续'
	})
	-- P1 图形学功能介绍
	merger = class_uiComponent.fromTemplate(DEMO.storage):scaleSet({x=0.6,y=0.6}):localCenter()
	:positionSet({x=GLOBAL_WINSIZE.width/2,y=GLOBAL_WINSIZE.height/2}):Draw()
	rotater = class_uiComponent.fromTemplate(DEMO.diamond):localCenter()
	rotater:positionSet({x=GLOBAL_WINSIZE.width/2,y=GLOBAL_WINSIZE.height/2})
	rotater:Draw()

	panelOpen:start()	-- 注册面板弹出动画，并开始播放
end

function animeIntro( ... )
	statusInit()
	status[4] = true
	-- 更改panel的标题展示内容
	uS_title.reNew({
		'章节二 动画',
		'动画在easyUI中',
		'也不单单是 从这->到那',
		'这里提供了缓动函数',
		'让动画变成 在这顿下->飞到那',
		'这样更有动感的动画',
		'缓动函数可查看参考文档',
		'按 [K] 查看缓动函数的效果'
	})
	-- P2 uiAnime介绍
	panelOpen:start()	-- 注册面板弹出动画，并开始播放
end

function animeShow( ... )
	statusInit()
	status[5] = true
	animeTemplateGet()
	uS_title.reNew({
	'下面对 easyUI自带的',
	'缓动函数系列 进行展示',
	'下方示例，stage安排相同',
	'使用了不同的缓动',
	'就出现了不同的效果',
	'在适当场景使用 效果极佳',
	'播放完毕后',
	'按 [K] 结束介绍。'	
	})
	-- P2 uiAnime展示
	panelOpen:start()	-- 注册面板弹出动画，并开始播放
	animeEnder:Draw()	-- 展示动画结尾线条
	animeStarter:Draw()	-- 展示动画结尾线条
	InAnime:start()
end

function allEnd()
	statusInit()
	status[6] = true
	uS_title.reNew({
	'恭喜您 > u <',
	'教程就到此为止了！',
	'期待您能利用easyUI',
	'完成更高质量的界面设计！',
	'小彩蛋:',
	'(聊天输入1~7',
	'可跳转至对应的介绍阶段)',
	'不要忘记查看 示例源码 u_0',
	'按 [K] 结束'
	})
	panelOpen:start()
end

function allShutdown( ... )
	waitDraw:finish()-- body
	if merger then 
		merger:destroy()
	end
	if rotater then
		rotater:destroy()
	end
	if diamond1 then
		InAnime:finish()
		OutAnime:finish()
		InoutAnime:finish()
		diamond1:destroy()
		diamond2:destroy()
		diamond3:destroy()
		animeEnder:destroy()
		animeStarter:destroy()
		animeTitle:destroy()
	end
	logoPut.user.order = 1
end

function win( )
	UI.Signal(0)
end

function statusInit( ... )	-- 选择status需要初始化的 如 easyUI的logo动画 + 蒙蔽消除
	uiTitle.user = {}  -- 清除函数对象
	mask:Hide()		-- 隐藏钻石移动界面的 蒙版
	if merger then 
		merger:destroy()
	end
	if rotater then
		rotater:destroy()
	end
end

statusInterface = {
	welcome,
	compIntro,
	rotate,
	animeIntro,
	animeShow,
	allEnd,
	win
}

winSize = {width=1280,height=800}
class_uiComponent:sizeSet(GLOBAL_WINSIZE)	-- sizeSet设置 ui设计用电脑的屏幕尺寸	
-- 全局uiComp设定，ui的设计尺寸是基于1280x800屏的，会通过屏幕尺寸的比例进行缩放变化，保证内容全部展示，但会有些许的缩放差异 [UI屏幕修正 功能]

uS_title = {
	order = 0,
	Color = {r=40,g=100,b=160,a=255},
	titleTexts = {},
	finish = false
}		
-- 非常精彩的技巧！ 轮播title列表！ 众多title，我们只用了一个 uiComp 和2个对应的 uiAnime！
-- 很好的设计，或许是。
function uS_title.fadeInStage( target,process )
	local stage = {pos=target.pos,scale=target.scale}
	local fadeTime = 0.6
	if process <= fadeTime then
		tool_ui.setsCommand(target.sets,{a=process*255/fadeTime})
	end
	return stage
end
function uS_title.fadeOutStage( target,process )
	local stage = {pos=target.pos,scale=target.scale}
	local fadeTime = 1
	if process <= fadeTime then
		tool_ui.setsCommand(target.sets,{a=(fadeTime-process)*255/fadeTime})
	end
	return stage
end
-- 以上是stage Function
function uS_title.triggerText( ) -- 动画进入前的 激发函数，处理uiTitle的文本展示内容
	uS_title.order = uS_title.order+1
	local nextTitle = uS_title.titleTexts[uS_title.order]
	if nextTitle then	-- 检测title是否播放完毕
		generator:textUpdate(uiTitle,{text=nextTitle,color=uS_title.Color})
	else
		return
	end
end
function uS_title.showEnd( )	-- 显示进入Anime 的回调函数
	local nextTitle = uS_title.titleTexts[uS_title.order+1]
	if nextTitle then
		titleFadeOut:start()
	else
		uS_title.finish = true
	end
end
function uS_title.hideEnd( userAnime )	-- 消隐退出Anime 的回调函数
	if not uS_title.finish then
		titleFadeIn:start()
	else
		uS_title.finish = false --hideEnd 被动制备showEnd调用，finish被锁死不会调用
		if statusLock.i > 1 then 
			statusLock.lock = true 	--	状态教学 解锁
		end
		uiTitle:boxClear() 	--清空box即时
		-- 因此若被调用，且finish了，只能来自Panel，表示该段落结束，初始化finish为未结束。
		if userAnime.target.user == nil then	-- 无user则直接退出
			return
		end -- 这里user数据是存在 anime的执行target里的，所以需要.target.user
		if type(userAnime.target.user.continue) == 'function' then	-- 标题打印后继续的动作函数
			userAnime.target.user.continue(userAnime.target.user.target)
			return
		else
			return
		end
	end
end
function uS_title.reNew( titles,start )
	uS_title.titleTexts = titles
	uS_title.finish = false
	uS_title.order = 0
	if start then
		panelOpen:start()
	end
end
-- 是的，通过激发+双回调函数，进入/退出 动画间进行相互调用，形成了衔尾蛇般的 循环！
-- 直至检测title显示完毕，终止

uS_Panel = {width=640,height=60,gap=6}
function uS_Panel.titleShow( )
	titleFadeIn:start()
end
function uS_Panel.titleHide( anime )
	titleFadeOut:start()
end
-- 一些ui项目的既定值


generator = class_uiTextGenerator.new(LanaPixel)	-- 构建文字生成器，设定根据字库LanaPixel生成

uiPanel = class_uiComponent.new():setRegister(
{x=0,y=0,width = uS_Panel.width+uS_Panel.gap, height = uS_Panel.height, r=0,g=0,b=0,a=120},
{x=0,y=0,width = uS_Panel.width, height = uS_Panel.height, r=255,g=255,b=255,a=200}
):boxSupply()			-- 通过uiComponent创建 一个面板用于显示 标题文字

panelOpen = class_uiAnime.new({
target=uiPanel,duration=0.6,easing={ name='easeOutBack',parm={3,2} },stage={
	{rate=0,pos={x=0,y=0},scale={x=0,y=1}},
	{rate=1,pos={x=0,y=0},scale={x=1,y=1}}
},callback=uS_Panel.titleShow	-- 连续动画的奇淫巧计，下一个动画放在上一个的 callback回调函数内
})
panelClose = class_uiAnime.new({
target=uiPanel,duration=1.2,easing={ name='easeInBack',parm={3,2} },stage={
	{rate=0,pos={x=0,y=0},scale={x=1,y=1}},
	{rate=1,pos={x=0,y=0},scale={x=0,y=1}}
},trigger=uS_Panel.titleHide
})

uiTitle = generator:textComponent({x=10,y=8},'',40,uS_title.Color)
-- 创建 标题文字 uiComponent组件
titleFadeIn = class_uiAnime.new({
target=uiTitle,duration=2.4,easing={ name='easeOut',parm=3 },stage=uS_title.fadeInStage,
trigger=uS_title.triggerText,callback=uS_title.showEnd
})
titleFadeOut = class_uiAnime.new({
target=uiTitle,duration=1.2,easing={ name='easeOut',parm=3 },stage=uS_title.fadeOutStage,
callback=uS_title.hideEnd
})

-- 至此title 展示板功能完成，若您希望，可以将其通过伪类打包，加入.new()函数 实现新的功能UI组件！
-- 展示板的生命周期应该是 panelOpen 开始，在此前uS_title应该被设定/变更好 下一步要展示的titles
-- 最终步入panelClose 结束，再次设定uS_tile 通过penelStart开始下一轮展示！

-- easyUI动态绘图
letter_e = nil
letter_a = nil
letter_s = nil
letter_y = nil
letter_U = nil
letter_I = nil
LOGO = {letter_e}

function logoGet( ... )
	letter_e = generator:textComponent({x=0,y=0},'e',60):localCenter()
	letter_e.user = {offset=-100}
	letter_a = generator:textComponent({x=0,y=0},'a',60):localCenter()
	letter_a.user = {offset=-60}
	letter_s = generator:textComponent({x=0,y=0},'s',60):localCenter()
	letter_s.user = {offset=-20}
	letter_y = generator:textComponent({x=0,y=0},'y',60):localCenter()
	letter_y.user = {offset=20}
	letter_U = generator:textComponent({x=0,y=0},'U',60):localCenter()
	letter_U.user = {offset=70}
	letter_I = generator:textComponent({x=0,y=0},'I',60):localCenter()
	letter_I.user = {offset=110}
	LOGO = {letter_e,letter_a,letter_s,letter_y,letter_U,letter_I}
	logoPut.target=LOGO[1]
end
-- LOGO字母组成表
function welcomeEnd(  )
	local ea = letter_e:mergeInit(letter_a)
	letter_e:destroy()
	letter_a:destroy()
	local sy = letter_s:mergeInit(letter_y)
	letter_s:destroy()
	letter_y:destroy()
	local ui = letter_U:mergeInit(letter_I)
	letter_U:destroy()
	letter_I:destroy()
	local easy = ea:mergeInit(sy)
	ea:destroy()
	sy:destroy()
	local logo = easy:mergeInit(ui):localCenter()
	:positionSet({x=GLOBAL_WINSIZE.width/2,y=GLOBAL_WINSIZE.height/2})
	easy:destroy()
	ui:destroy()
	LOGO = nil
	scaleOut.target = logo
	scaleOut:start()
end
function printLOGO( userAnime )	-- 依次执行LOGO字母弹出动画,作为callback
	-- 使用了 uiClass 自带user用户数据，获取self得以进行 参数定制
	tool_ui.setsCommand(LOGO[userAnime.user.order].sets,{r=math.random()*255,g=math.random()*255,b=math.random()*255})
	LOGO[userAnime.user.order]:Draw()
	userAnime.user.order = userAnime.user.order + 1
	if userAnime.user.order > userAnime.user.total then	-- 大于LOGO表长，展示结束，退出！
		welcomeEnd()
		return
	end
	userAnime.target = LOGO[userAnime.user.order]
	local set_x = GLOBAL_WINSIZE.width/2 + userAnime.target.user.offset
	userAnime.stage[1].pos.x = set_x
	userAnime.stage[2].pos.x = set_x
	userAnime:start()
end

logoPut = class_uiAnime.new({
target=nil,duration=0.8,easing={ name='easeOutBack',parm={2,1.2} },stage={
	{rate=0,pos={x=GLOBAL_WINSIZE.width/2-100,y=GLOBAL_WINSIZE.height/2},scale={x=6,y=0}},
	{rate=1,pos={x=GLOBAL_WINSIZE.width/2-100,y=GLOBAL_WINSIZE.height/2},scale={x=6,y=6}}
},basic=0.25,callback=printLOGO
})	-- 创建logo单个字母的 弹出动画
logoPut.user = {order=1,total=6}	--uiClass.user:用户声明的其他内容
-- 按下K键,logoPut动画，依靠user数据 + callback回调，实现一次性弹出所有logo字母


function scaleFade( target,process )
	local stage = {pos=target.pos,scale={x=1+process*15,y=1+process*15}}
	tool_ui.setsCommand(target.sets,{a=(1-process)*255})
	return stage
end
function destroyComps( anime )
	anime.target:destroy()
	anime.target = nil
	statusLock.lock = true 	--	解锁
end

scaleOut = class_uiAnime.new({
target=nil,duration=1,easing={ name='easeIn', parm=4}, stage=scaleFade
,callback=destroyComps
})

function fadeInOut( target, process )	-- 渐隐后渐出
	local stage = {pos=target.pos,scale=target.scale}
	local fadeTime = 0.6
	local outTime = 0.9
	if process <= fadeTime then
		tool_ui.setsCommand(target.sets,{a=process*255/fadeTime})
	elseif process > outTime then
		tool_ui.setsCommand(target.sets,{a=(1-process)*255/(1-outTime)})
	end
	return stage
end
function drawNext( userAnime )
	if userAnime.target then
		userAnime.target:destroy()	-- 先清空不用的
	end
	userAnime.target = class_uiComponent.fromTemplate(userAnime.user[userAnime.user.i][1])
	-- 再切换绘制下一个
	userAnime.target:positionSet(userAnime.user[userAnime.user.i][2])
	userAnime.user.i = userAnime.user.i+1
end
function loopWithTrigger( anime )
	if anime.target then
		anime.target:destroy()
	end
	if anime.user.i > #anime.user then
		return
	end
	anime:start()
end
-- compIntro环节 的绘制，并延迟一段时间后 callback绘制另一个
waitDraw = class_uiAnime.new({
target=nil,duration=5.2,easing= { name='linear', parm=nil}, stage=fadeInOut,
trigger = drawNext, callback = loopWithTrigger
})

-- rotate环节 声明
rotater = nil
merger = nil
rotateKey = UI.KEY.R
scaleKey = UI.KEY.F
smallKey = UI.KEY.E
mirrorKey = UI.KEY.M
upKey = UI.KEY.UP 
downKey = UI.KEY.DOWN 
leftKey = UI.KEY.LEFT 
rightKey = UI.KEY.RIGHT
mergeKey = UI.KEY.N



-- 动画回调/激活
function animeTrigger( ... )	-- 使用trigger来 激活并行动画
	if animeTime > # animeGroup then return end
	InAnime.easing = animeGroup[animeTime][1]
	OutAnime.easing = animeGroup[animeTime][2]
	InoutAnime.easing = animeGroup[animeTime][3]
	generator:textUpdate(animeTitle,{text=animeInfo[animeTime],color=animeColor})
	animeTitle:Draw()
	animeTime = animeTime + 1 -- 记录播到第几组动画组
	OutAnime:start()
	InoutAnime:start()
end
function nextAnimeGroup( userAnime )	-- 反复start达到loop循环的效果
	if animeTime > # animeGroup then 
		if userAnime.user ~= nil then
			diamond1:destroy()
			diamond2:destroy()
			diamond3:destroy()
			animeEnder:destroy()
			animeStarter:destroy()
			animeTitle:destroy()
			-- 清理不使用的 动画/组件对象
			return
		end
		generator:textUpdate(animeTitle,{text='播放完毕！',color=animeColor})
		animeTitle:Draw()
		userAnime.user = {finish=true}
		userAnime:start()
		return 
	end
	animeEnder.sets[1].r=255	-- 动画开始，结束线变色
	animeEnder:Draw() -- 绘制更新
	--改变展示标题 的提示文字
	InAnime:start()
end
function waitOne( ... )
	animeEnder.sets[1].r=0	-- 动画结束，结束线变色
	animeEnder:Draw() -- 绘制更新
	waitForOne:start()
end
function doNothingAnime( ... ) -- 什么都不做的动画
	
end
-- 动画模板
InAnime = nil
OutAnime = nil
InoutAnime = nil
waitForOne = nil
animeTitle = nil
animeEnder = nil
animeStarter = nil

stage1 = nil
stage2 = nil
stage3 = nil
-- P2 动画
diamond1 = nil
diamond2 = nil
diamond3 = nil
-- 依次播放的动画组 和 parm
animeTime = nil
animeGroup = nil
animeColor = nil
animeInfo = nil
function animeTemplateGet( ... )
	diamond1 = class_uiComponent.fromTemplate(DEMO.diamond):localCenter()
	diamond2 = diamond1:clone() -- 克隆获得新个体
	diamond3 = diamond1:clone()
	stage1 = {
	{rate=0,pos={x=200,y=200},scale={x=1,y=1}},
	{rate=1,pos={x=800,y=200},scale={x=1,y=1}}
	}
	stage2 = {
	{rate=0,pos={x=200,y=350},scale={x=1,y=1}},
	{rate=1,pos={x=800,y=350},scale={x=1,y=1}}
	}
	stage3 = {
	{rate=0,pos={x=200,y=500},scale={x=1,y=1}},
	{rate=1,pos={x=800,y=500},scale={x=1,y=1}}
	}
	-- 依次播放的动画组 和 parm
	animeTime = 1
	animeGroup = {
		{{ name='easeIn', parm=2},{ name='easeOut', parm=2},{ name='easeInOut', parm=2}},
		{{name='easeInBack',parm={3,1.7}},{name='easeOutBack',parm={3,1.7}},{name='easeInOutBack',parm={3,1.7}}},
		{{name='easeInElastic',parm={2,0.3}},{name='easeOutElastic',parm={2,0.3}},{name='easeInOutElastic',parm={2,0.3}}},
		{{name='linear',parm=nil},{name='shock',parm=4},{name='shockTo',parm=4}}
	}
	animeColor = {r=40,g=80,b=140,a=200}
	animeInfo = {
		'ease系列',
		'easeBack系列',
		'easeElastic系列',
		'linear\n& shock系列'
	}
	InAnime = class_uiAnime.new({
	target=diamond1,duration=5.2,easing=nil , stage=stage1,duration=8,
	trigger=animeTrigger,callback=waitOne
	})
	OutAnime = class_uiAnime.new({
	target=diamond2,duration=5.2,easing=nil , stage=stage2,duration=8
	})
	InoutAnime = class_uiAnime.new({
	target=diamond3,duration=5.2,easing=nil , stage=stage3,duration=8
	})
	waitForOne = class_uiAnime.new({
		target=diamond1,duration=3,stage=doNothingAnime,callback = nextAnimeGroup
	}) -- 不动 的 间隔动画，没有动画效果，只是停顿3秒
	animeTitle = generator:textComponent({x=40,y=100},'',40)
	animeEnder = class_uiComponent.new():setRegister({x=860,y=160,width=10,height=400,r=255,g=30,b=60,a=200}):boxSupply()
	animeStarter = class_uiComponent.new():setRegister({x=140,y=160,width=10,height=400,r=50,g=30,b=160,a=200}):boxSupply()
	return
end


function UI.Event:OnUpdate( t )
	class_uiAnime:queueActivate( t )
	statusCheck()
end


function randomSet( )
	math.randomseed(UI.GetTime()*1000)
end

function UI.Event:OnInput( inputs )	-- ↑,↓,←,→ 移动
	local moveSpeed = 1
	if rotater ~= nil and statusLock.i == 3 then
		if inputs[UI.KEY.Z] then
			rotater:setRotate(1,false)
			rotater:Draw()
		end
		if inputs[UI.KEY.P] then
			rotater:setMirror('x')
			rotater:Draw()
		end
		if inputs[upKey] then
			rotater:positionSet(tool_ui.vectorAdd(rotater.pos,{x=0,y=-moveSpeed}))
			rotater:Draw()
		end
		if inputs[downKey] then
			rotater:positionSet(tool_ui.vectorAdd(rotater.pos,{x=0,y=moveSpeed}))
			rotater:Draw()
		end
		if inputs[leftKey] then
			rotater:positionSet(tool_ui.vectorAdd(rotater.pos,{x=-moveSpeed,y=0}))
			rotater:Draw()
		end
		if inputs[rightKey] then
			rotater:positionSet(tool_ui.vectorAdd(rotater.pos,{x=moveSpeed,y=0}))
			rotater:Draw()
		end
	end
end
function UI.Event:OnKeyDown (inputs)
	if rotater ~= nil and statusLock.i == 3 then
		if inputs[rotateKey] then
			rotater:setRotate(1)
			rotater:Draw()
			return
		elseif inputs[scaleKey] then
			rotater:scaleSet(tool_ui.vectorAdd(rotater.scale,{x=1,y=1}))
			rotater:Draw()
			return
		elseif inputs[smallKey] then
			rotater:scaleSet(tool_ui.vectorAdd(rotater.scale,{x=-1,y=-1}))
			rotater:Draw()
			return
		elseif inputs[mirrorKey] then
			rotater:setMirror('y')
			rotater:Draw()
			return
		elseif inputs[mergeKey] and merger ~= nil then
			local mergeComp = rotater:merge(merger,true)
			rotater:destroy()
			rotater = mergeComp:Draw()
			merger:destroy()
			merger = nil
		end
	end
	if inputs[statusKey] and uS_title.finish then
		panelClose:start()
		randomSet()
		return
	end
end


function statusCheck(  )
	if statusLock.lock then
		statusLock.i = statusLock.i + 1
		if statusLock.i > #status then return end -- 全部播放完则结束
		statusInterface[statusLock.i]() -- 激活动画入口
		statusLock.lock = false --上锁，等待动画介绍结束 触发解锁
	end
end


function UI.Event:OnChat( text )
	stage = tonumber(text)//1
	print('codeCommand:',stage)
	if 0 < stage and stage < 8 then
		allShutdown()	-- 清空其他教程的残留进程
		statusLock.lock = true
		statusLock.i = stage - 1
	else
		print('UnKnow codeCommand')
	end
end