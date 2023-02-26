-- 欢迎查看案例！
-- 本案例难度极高，掌握后，相当于灵活理解了easyUI原理
-- 并能使用奇淫巧计进行合理的功能榨干

-- 灵梦小游戏 操纵说明
-- Q,E 左右奔跑
-- K 符箓定位(攻击)
-- L 跳跃



cmd = {				-- 操控按键指定
	rightRun = UI.KEY.E,
	leftRun = UI.KEY.Q,
	attack = UI.KEY.K,
	jump = UI.KEY.L
}

set = {
	scale = {x=0.4,y=0.4},	-- 人物精灵的缩放值
	eyeCloseSpeed = 3, 	-- 人物眨眼间隔
	eyeBoringCycle = 6,	-- 人物无聊间隔
	headRange = 4,		-- 奔跑时头的上下晃动范围
	headSpeed = 0.5,	-- 奔跑时头的晃动速度
	weaponCycle = 3.2,	-- 武器动画的循环时间
	jumpCycle = 1,	-- 跳跃动画的循环时间
	runCycle = 0.3,	-- 奔跑动画的循环时间
	jumpSpeed = -12,	-- 跳跃初速度 向上为 负
	runSpeed = 10,	-- 最大奔跑速度
	runA = 0.6,		-- 奔跑加速度 应比fa 大
	g = 0.98,	-- 重力常数
	fa = 0.4 		-- 水平摩擦阻力加速度
}		-- 一些设定
set.jumpCycle = set.jumpSpeed*(-2)/set.g  -- 根据上抛运动，跳跃时间应该是这样

gameSet = {
	floor = 600,	-- 地面 y值，这里只是演示demo，没做地面检测，只给一个地面全局检测
	bornPoint = {x=300,y=600},	-- 角色出生点
}

sprite = {}		-- 包含模板、组件的绘制对象集合
-- sprite对象 以body中下部 为人物位置中心，进行 行为检测/组件绑定 等

sprite.status = {
	cmdTime = GLOBAL_CODETIME, -- 上次被用户操作的时间
	eye = 0,	-- 眼睛状态，分别有 0 ~3 对应 四种表情
	attack = false,
	right = true,
	jump = false,
	run = false,
	speed = {x=0,y=0}	-- 角色的速度向量
}	-- 角色状态 记录表

sprite.Template = {								-- 加载人物组件
	weapon = {
		{right=true,sets=LingWeapon.Talisman_0()},
		{right=true,sets=LingWeapon.Talisman_1()},
		{right=true,sets=LingWeapon.Talisman_2()},
		{right=true,sets=LingWeapon.Talisman_3()}		-- 武器动作模板
	},	-- 存表的 都含有动画
	deco = {right=true,sets=Ling.deco()},					-- 头饰 模板
	body = {right=true,sets=Ling.body()},			-- 静止的 默认身体 模板
	bodyRun = {
		{right=true,sets=Ling.body_RUN0()},		-- 奔跑第一帧 模板
		{right=true,sets=Ling.body_RUN1()}		-- 奔跑第二帧 模板
	},
	bodyJump = {
		{right=true,sets=Ling.body_JUMP0()},	-- 跳跃第一帧 模板
		{right=true,sets=Ling.body_JUMP1()},	-- 跳跃第二帧 模板
	},
	head = {right=true,sets=Ling.head()},					-- 头部 模板
	eye = {
		{right=true,sets=Ling.eye()},					-- 默认眼神 模板
		{right=true,sets=Ling.eye_CLOSE()},		-- 眼睛闭合 模板
		{right=true,sets=Ling.eye_X()},				-- 受伤眼睛 模板
		{right=true,sets=Ling.eye_BORING()}		-- 无聊眼神 模板
	}
} -- right 表示，该模板为 角色面向朝右 的模板，false代表 向左


-- 结合uiboxPainter的box耗费，我们提前声明 组件 并申请相应数量的Box
sprite.Comp = {		-- new里加 false 不进行屏幕修正（其实人物也不会变形，也可以进行修正！）
	weapon = class_uiComponent.new(false):boxCreate(11),		-- 随身武器，最下层
	deco = class_uiComponent.new(false):boxCreate(19),		-- 人物先申请 头饰，先申请会被遮挡，图层关系很重要
	body = class_uiComponent.new(false):boxCreate(28),		-- 身体，Template保证对应/小于 28个Box即可，其他模板亦然
	head = class_uiComponent.new(false):boxCreate(49),		-- 头部在 第三层，将遮挡 deco 和body 而被 eye遮挡
	eye = class_uiComponent.new(false):boxCreate(6)			-- 申请完毕，通过setLink改变链接到不同的 eye状态/body状态		
}

function sprite.setScaleInit( )	-- 缩放初始化为 设定值
	for i,comp in pairs(sprite.Comp) do
		comp:scaleSet(set.scale)
	end
end
function sprite.setCenterInit( )	-- 设定各组件的 肢体意义的中心点
	local temps = sprite.Template
	for i,temp in pairs(temps.weapon) do
		class_uiComponent.localMove(temp, {x=35,y=45},set.scale) 
	end
	class_uiComponent.localMove(temps.deco, {x=145,y=115},set.scale) 
	-- 根据uiBoxPainter 观察得到合适的中心点
	class_uiComponent.localMove(temps.body, {x=90,y=185},set.scale)	
	-- body中心点  中下部
	for i,temp in pairs(temps.bodyRun) do
		class_uiComponent.localMove(temp, {x=120,y=185},set.scale) 
	end
	for i,temp in pairs(temps.bodyJump) do
		class_uiComponent.localMove(temp, {x=125,y=185},set.scale) 
	end
	class_uiComponent.localMove(temps.head, {x=125,y=190},set.scale) 
	class_uiComponent.localMove(temps.eye[1], {x=45,y=50},set.scale) 
	class_uiComponent.localMove(temps.eye[2], {x=45,y=50},set.scale) 	-- 不同表情 对应同一定位点(对于头部)
	class_uiComponent.localMove(temps.eye[3], {x=45,y=40},set.scale) 
	class_uiComponent.localMove(temps.eye[4], {x=40,y=30},set.scale) 
end

sprite.setScaleInit()
sprite.setCenterInit()		-- 初始化各组件的 中心点(用于人物组装)

sprite.Template.bodyJump[3] = sprite.Template.bodyJump[2]
sprite.Template.bodyJump[4] = sprite.Template.bodyJump[1]		-- 倒序引用 要在centerInit后 避免二次初始化
-- 在外边才声明是保证 right=true是引用的 二者关联的

-- 模板获得 key为 sets 是为了适配 class_uiComp的 mirror函数(对表内键为sets的表进行镜像)


function sprite.TemplateGet( temp )		-- 检测模板方向，并矫正返回
	if sprite.status.right ~= temp.right then	-- 反向，则进行 mirror左右镜像 进行方向反转
		class_uiComponent.setMirror(temp,'y')
		temp.right = not temp.right
	end
	return temp.sets
end
function sprite.AnimeIndexGet( animeList,process )
	local i = process//(1/#animeList)+1	-- 自适应，可更改weapon动画帧数也能用
	if i > #animeList then i = #animeList end
	return i
end
function sprite.born( )		-- 角色复活初始化函数
	print('sprite has been borned')
	sprite.Comp.body:positionSet(gameSet.bornPoint)	-- 移动至复活点
	-- 因为eye/head 等组件采用 父子对象绑定制，无需直接管理其position
	-- 而是通过 bindPosition 来绑定至 父对象
end
function sprite.weaponAnime(target,process)
	local i = sprite.AnimeIndexGet(sprite.Template.weapon,process)	-- 获取当前需要替换的动画播放帧
	target:setLink(sprite.TemplateGet(sprite.Template.weapon[i]))
	if not sprite.status.attack then	-- 不攻击，符箓武器跟随人物移动
		local direction = -1
		if sprite.status.right then direction = 1 end
		tool_ui.bindPosition( target,sprite.Comp.body,
			tool_ui.vectorMultiply({x=-185*direction,y=-145},set.scale) )
		-- 绑定父对象 身体
	end
	return nil	-- 借助uiAnime只是为了保持fps稳定，我们的动画不需要 stage来实现		-- 武器动画
end
function sprite.bodyAnime(target,process)
	sprite.positionUpdate( target )
	sprite.vectorNature()
	if sprite.status.run then
		local i = sprite.AnimeIndexGet(sprite.Template.bodyRun,process)
		if i > #sprite.Template.bodyRun then i = #sprite.Template.bodyRun end	--	防止超过
		target:setLink( sprite.TemplateGet(sprite.Template.bodyRun[i]) )
	elseif sprite.status.jump then
		local i = sprite.AnimeIndexGet(sprite.Template.bodyJump,process)
		if i > #sprite.Template.bodyJump then i = #sprite.Template.bodyJump end	--	防止超过
		target:setLink( sprite.TemplateGet(sprite.Template.bodyJump[i]) )
	else
		target:setLink( sprite.TemplateGet(sprite.Template.body) )
	end
	return nil		
	-- 借助uiAnime只是为了保持fps稳定，我们的动画不需要 stage来实现		-- 身体动画 + 判断器实现
end
function sprite.headAnime(target,process)	-- 头部 父对象为 身体
	target:setLink( sprite.TemplateGet(sprite.Template.head) )
	if sprite.status.run then		-- 跑步需要头部抖动显示动感
		local yMove = (process-0.5)*set.headRange
		tool_ui.bindPosition(target,sprite.Comp.body,
		tool_ui.vectorMultiply({x=-5,y=yMove-160},set.scale) )	-- offset参数是 相对body中心的定位
		-- 绑定至 身体父对象
	else
		tool_ui.bindPosition(target,sprite.Comp.body,
		tool_ui.vectorMultiply({x=-5,y=-160},set.scale) )	-- offset参数是 相对body中心的定位
		-- 绑定至 身体父对象
	end
end
function sprite.decoAnime(target,process)	-- 头饰 父对象为 头部
	target:setLink( sprite.TemplateGet(sprite.Template.deco) )
	tool_ui.bindPosition( target,sprite.Comp.head,
		tool_ui.vectorMultiply({x=-5,y=-130},set.scale) )
	-- 绑定至 头部父对象
end
function sprite.eyeAnime(target,process)	-- 眼睛 父对象为 头部
	local expression = sprite.status.eye % #sprite.Template.eye + 1 -- 整除，防止eyeStatus取值超过4
	if (UI.GetTime() - sprite.status.cmdTime) > set.eyeBoringCycle then	-- 长时间不操作显示无聊表情
		expression = 4 		--第4个索引 是 无聊眼神
	end
	if expression < 3 then	-- 当眼睛处于 正常状态 [0|1] 进行眨眼动画
		local eyeSt = process//0.9+1		-- 10%的时间留给 闭眼，因为眨眼过程中，闭眼是很快的一瞬
		sprite.Comp.eye:setLink( sprite.TemplateGet(sprite.Template.eye[eyeSt]) )
	else --否则正在进行 表情操作 优先展示表情
		sprite.Comp.eye:setLink( sprite.TemplateGet(sprite.Template.eye[expression]) )
	end
	tool_ui.bindPosition( target,sprite.Comp.head,
	tool_ui.vectorMultiply({x=0,y=-45},set.scale) )	-- 绑定至 头部父对象
end
-- 动画会自动对 target 进行Draw绘制，我们不用在 sprite.XXAnime 中调用了
sprite.anime = {
	weapon = class_uiAnime.new({
		target=sprite.Comp.weapon,duration=set.weaponCycle,stage=sprite.weaponAnime,loop=true	--循环检测
	}),
	body = class_uiAnime.new({
		target=sprite.Comp.body,duration=1,stage=sprite.bodyAnime,loop=true,
		trigger=sprite.born
	}),
	head = class_uiAnime.new({
		target=sprite.Comp.head,duration=set.headSpeed,stage=sprite.headAnime,loop=true,
		easing={name='easeIn',parm=3}
	}),
	eye = class_uiAnime.new({
		target=sprite.Comp.eye,duration=set.eyeCloseSpeed,stage=sprite.eyeAnime,loop=true,
		easing={name='easeIn',parm=3}
	}),
	deco = class_uiAnime.new({
		target=sprite.Comp.deco,duration=1,stage=sprite.decoAnime,loop=true
	})
}

function sprite.run( right )	-- 确定人物 速度
	if sprite.status.jump then return end	-- 您不能在空中跑步
	sprite.status.cmdTime = UI.GetTime()
	sprite.anime.body.duration = set.runCycle	-- 跑步动画播放速度
	local direction = -1
	if right then direction = 1 end
	if sprite.status.speed.x*direction < set.runSpeed then
		sprite.status.speed = tool_ui.vectorAdd(sprite.status.speed,{x=direction*set.runA,y=0})
	else --加速最大，不再加速
		sprite.status.speed.x = direction*set.runSpeed
	end
end
function sprite.jump( )
	sprite.status.cmdTime = UI.GetTime()
	sprite.status.run = false -- 跳跃时无法在空中奔跑
	sprite.status.jump = true
	sprite.anime.body.duration = set.jumpCycle*0.6	-- *0.8是为了缩短实际播放时间，让所有帧得以展现
	-- 否则最后一帧直接变为 落地的 静止模板
	sprite.anime.body.timer.start = UI.GetTime()	-- 刷新跳跃动画起始时间
	sprite.status.speed = tool_ui.vectorAdd(sprite.status.speed,{x=0,y=set.jumpSpeed})	
	-- 在现有速度上 增加向上的跳跃速度
end
function sprite.attack( )
	sprite.status.cmdTime = UI.GetTime()
	sprite.status.attack = true
	sprite.status.eye = 2
end
function sprite.positionUpdate( target )
	target:positionSet(tool_ui.vectorAdd(target.pos, sprite.status.speed))
	-- 很简单，位置更新，原位置加上现在的 速度(vector*fps) 并不是很严格，改变fps会影响快慢
end
function sprite.vectorNature( )			-- 模拟自然的 vector变化
	local status = sprite.status
	local direction = 1 					-- 角色朝向
	if status.right then direction = -1 end
	if status.jump then
		if status.speed.y > -set.jumpSpeed or status.speed.y == -set.jumpSpeed then 	-- or地面检测
			status.speed.y = 0
			sprite.Comp.body:positionSet({x=sprite.Comp.body.pos.x,y=gameSet.floor})
			status.jump = false
		else
			status.speed = tool_ui.vectorAdd(status.speed,{x=0,y=set.g})	-- 重力加速度
		end
	end
	if not status.run then	-- 不奔跑开始减速
		if status.speed.x*direction < 0 then 	-- 这里不取0 是怕存在 0.xxx的情况
			status.speed = tool_ui.vectorAdd(status.speed,{x=set.fa*direction,y=0})
		else
			status.speed.x = 0
		end
	end
end

function sprite.start( )		-- 激活sprite人物的所有动画对象
	for key,anime in pairs(sprite.anime) do
		anime:start()
	end
end

sprite.start() 		-- 激活人物 动画/事件 周期


function UI.Event:OnUpdate (time)
	class_uiAnime:queueActivate( time )	-- 激活全局动画，流程得以运行
end

function UI.Event:OnKeyDown (inputs)
	if inputs[cmd.jump] and not sprite.status.jump then
		sprite.jump()
	elseif inputs[cmd.attack] then
		sprite.attack()
	end
end

function UI.Event:OnKeyUp (inputs)
	if inputs[cmd.rightRun] then
		sprite.status.run = false
	elseif inputs[cmd.leftRun] then
		sprite.status.run = false
	elseif inputs[cmd.attack] then
		sprite.status.attack = false
		sprite.status.eye = 0
	end
end

function UI.Event:OnInput (inputs)
	if inputs[cmd.rightRun] and not sprite.status.jump then	-- 跳跃时不可奔跑
		sprite.status.right = true
		sprite.status.run = true
		sprite.run(true)
	elseif inputs[cmd.leftRun] and not sprite.status.jump then
		sprite.status.right = false
		sprite.status.run = true
		sprite.run(false)
	end
end
