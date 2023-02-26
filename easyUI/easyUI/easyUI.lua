GLOBAL_WINSIZE = UI.ScreenSize()	-- 全局项 winSize 本地客户端的屏幕尺寸
GLOBAL_CODETIME	= UI.GetTime()		-- 全局项 codeTime 代码开始运行的时间

-- CLASS-base
class_base = {}
class_base.__index = class_base
-- class基类方法 type() ->返回类的名称
function class_base:type()
	if self.ui_type ~= nil then
		return self.ui_type
	else
		return type(self)
	end
end

-- CLASS-uiAnime
class_uiAnime = {ui_type='uiAnime',curve={},queue={},accrue=1,t_gap=0.04,t_log=GLOBAL_CODETIME,n_log=0}	-- 基类 Anime
class_uiAnime.__index = class_uiAnime
setmetatable(class_uiAnime,class_base)
-- uiAnime新建，属性初始化
function class_uiAnime.new( set )
	if set.delay == nil then set.delay = 0 end
	if set.basic == nil then set.basic = 0 end
	if set.duration == nil then set.duration = 1 end
	if set.easing == nil then set.easing = {name='linear',parm=1} end
	if set.loop == nil then set.loop = false end
	if set.reverse == nil then set.reverse = false end
	local table = {target=set.target,delay=set.delay,basic=set.basic,timer={start=-1,duration=set.duration},	-- timer.start < 0 表示未激活
	easing=set.easing,stage=set.stage,loop=set.loop,reverse=set.reverse,trigger=set.trigger,callback=set.callback,
	package=set.package,id=nil}
	setmetatable(table,class_uiAnime)
	return table
end
-- uiAnime全局操作 设定更新帧数		|传入帧数/秒	默认24fps
function class_uiAnime:fpsSet( fps )
	self.t_gap = 1/fps
end
-- uiAnime操作	插入队列	|传入自定义id，若nil将自动分配	->返回动画的序列id识别号
function class_uiAnime:register( id )
	-- id分配器
	if id == nil then
		if self.id ~= nil then
			if self.queue[self.id] == self then		-- 已存在，直接返回
				return self.id
			elseif self.queue[self.id] == nil then
				id = self.id
				goto REG
			else
				id = '#'..tostring(self.accrue)
				class_uiAnime.accrue = class_uiAnime.accrue + 1 	-- 非表，用self.__index返回为 替代值，非本身，因此使用uiAnime.accrue
				goto REG
			end
		else
			id = '#'..tostring(self.accrue)
			class_uiAnime.accrue = class_uiAnime.accrue + 1 	-- 非表，用self.__index返回为 替代值，非本身，因此使用uiAnime.accrue
			goto REG
		end
	end
	:: REG ::
	self.queue[id] = self
	self.id = id
	return self.id
end
-- uiAnime操作  删除此动画预设
function class_uiAnime:destroy( )
	if self.queue[self.id] == self then		-- 清除queue激活
		self.queue[self.id] = nil
	end
	tool_table._deepNil(self.timer)
	tool_table._deepNil(self.easing)
	tool_table._deepNil(self.stage)
	tool_table.surfaceNil(self)
	-- 暂时不作垃圾回收		-- 主要因为不包含box，不需要即时性
end
-- uiAnime操作	反向动画	|根据reverse取反
function class_uiAnime:orderReverse( )
	self.reverse = not self.reverse
end
-- uiAnime操作	启动动画	|传入自定义id，若nil将自动分配 call是否启动start函数(不填写->启动)	->返回动画的序列id识别号
function class_uiAnime:start( id,call )
	if call == nil then call = true end
	self:register(id)
	self.timer.start = UI.GetTime()
	if type(self.trigger) == 'function' and call then
		self.trigger(self)
	end
	return self.id
end
-- uiAnime操作	时停	动画将保持此状态直至重新激活
function class_uiAnime:stop( )
	if self.id == nil then
		print("ERROR| Anime has'nt start, id is nil   <from ui_Anime =class_uiAnime=>")
		return 
	else
		self.basic = self:_timerProcess( UI.GetTime() )		--	冻结帧process
		self.timer.start = -1						-- 清除process进度
		return 
	end
end
-- uiAnime操作	结束	动画无论进行何处将直接 变成结束状态	|call是否启动callback回调函数(不填写->不启动)
function class_uiAnime:finish( call )
	if self.id == nil then
		print("ERROR| Anime has'nt start, id is nil   <from ui_Anime =class_uiAnime=>")
		return 
	else
		if call == nil then call = false end
		self.queue[self.id] = nil
		self.timer.start = -1
		self.basic = 0
		if type(self.callback) == 'function' and call then
			self.callback(self)
		end
		return 
	end
end
-- uiAnime操作	循环重启	动画结束后将自动调用start进行loop循环，而不进行queue的nil清空
function class_uiAnime:loopStart( call )
	if self.id == nil then
		print("ERROR| Anime has'nt start, id is nil   <from ui_Anime =class_uiAnime=>")
		return
	else
		if call == nil then call = false end
		self.basic = 0
		self.timer.start = UI.GetTime()
		if type(self.callback) == 'function' and call then
			self.callback(self)
		end
		return
	end
end
-- uiAnime操作 查询process	->返回当前经缓动曲线修正过的process
function class_uiAnime:getProcess( )
	return self.curve[self.easing.name](self:_timerProcess(UI.GetTime()),self.easing.parm)
end
function queueCheck( queue )
	local out = 'que={'
	for key,anime in pairs(queue) do
		out = out .. key .. ','
	end
	print(out..'}')
end
-- queue操作	激活动画queue绘制进程
function class_uiAnime:queueActivate( t )
	if not self:_fpsCheck(t) then		-- fps未到更新时间，不进行更新
		return
	end
	local finishList = {} -- 用于储存本帧需要结束的动画， 遍历过程中无法直接nil，需要专门开一个结束进程
	for id,anime in pairs(self.queue) do
		if anime.timer.start < 0 then goto CONTINUE end		-- 小于-1的start 表示动画未激活
		local rate = anime:_timerProcess(t)
		local process = anime.curve[anime.easing.name](rate,anime.easing.parm)
		if type(anime.stage) == 'function' then		-- 函数动画控制
			local stage = anime.stage( anime.target,process )
			if stage ~= nil then
				if stage.pos ~= nil then anime.target:positionSet(stage.pos) end
				if stage.scale ~= nil then anime.target:scaleSet(stage.scale) end
			end
			anime:_draw()
			local finishFlag = anime:_endCheck(rate)
			if finishFlag then table.insert(finishList,anime) end	-- 检测若结束，添加至追责表

		elseif type(anime.stage) == 'table' then		-- 分段动画激活
			local rank = 1 								-- 默认为1是准备 process = 1时重开
			local cycle =  math.abs(process) // 1
			for i,stage in pairs(anime.stage) do
				if process-cycle > stage.rate then		-- 不限定process>0 是允许用户自定义负数区的动画stage
					rank = i
				elseif process+cycle < 0 and process+cycle < -stage.rate then	--支持process正负变化
					rank = -i
				end
			end
			local absRank = math.abs(rank)
			-- 确定 动画stage基础值
			local base = {pos={},scale={}}
			local diff = {pos={},scale={}}
			base.pos.x = anime.stage[absRank].pos.x+(anime.stage[#anime.stage].pos.x-anime.stage[1].pos.x)*cycle
			base.pos.y = anime.stage[absRank].pos.y+(anime.stage[#anime.stage].pos.y-anime.stage[1].pos.y)*cycle
			base.scale.x = anime.stage[absRank].scale.x+(anime.stage[#anime.stage].scale.x-anime.stage[1].scale.x)*cycle
			base.scale.y = anime.stage[absRank].scale.y+(anime.stage[#anime.stage].scale.y-anime.stage[1].scale.y)*cycle
			-- 确定 动画前后stage差值
			diff.pos.x = anime.stage[absRank+1].pos.x - anime.stage[absRank].pos.x
			diff.pos.y = anime.stage[absRank+1].pos.y - anime.stage[absRank].pos.y
			diff.scale.x = anime.stage[absRank+1].scale.x - anime.stage[absRank].scale.x
			diff.scale.y = anime.stage[absRank+1].scale.y - anime.stage[absRank].scale.y
			diff.fix = (math.abs(process) - cycle - anime.stage[absRank].rate)/(anime.stage[absRank+1].rate - anime.stage[absRank].rate)
			if rank < 0 then	-- 小于零，diff反向变化，base也距stage-0进行变化
				base.pos = {x=2*anime.stage[1].pos.x-base.pos.x,y=2*anime.stage[1].pos.y-base.pos.y}
				base.scale = {x=2*anime.stage[1].scale.x-base.scale.x,y=2*anime.stage[1].scale.y-base.scale.y}
				diff.fix = -diff.fix
			end
			anime.target:positionSet({x=base.pos.x+diff.pos.x*diff.fix, y=base.pos.y+diff.pos.y*diff.fix})
			anime.target:scaleSet({x=base.scale.x+diff.scale.x*diff.fix, y=base.scale.y+diff.scale.y*diff.fix})
			anime:_draw()
			local finishFlag = anime:_endCheck(rate)
			if finishFlag then table.insert(finishList,anime) end	-- 检测若结束，添加至追责表

		end
		::CONTINUE::
	end
	for i,anime in pairs(finishList) do
		anime:finish(true)
	end
end
-- queue操作	清空动画队列
function class_uiAnime:queueClear( )
	for id,anime in pairs(self.queue) do
		anime.basic = 0 					-- 偏移全置0		
		anime.timer.start = -1 				-- 全部停止激活
		-- id防止注册已finish的anime搅局，不进行nil
	end
	self.queue = {}
end
-- queue操作	anime全体暂停
function class_uiAnime:queueStop( )
	for id,anime in pairs(self.queue) do
		anime:stop()
	end
end
-- queue操作	anime全体启动
function class_uiAnime:queueStart( )
	for id,anime in pairs(self.queue) do
		anime:start()
	end
end
-- uiAnime时间曲线函数
function class_uiAnime.curve.linear( rate )
	return rate
end
function class_uiAnime.curve.easeIn( rate,n )
	return rate^n
end
function class_uiAnime.curve.easeOut( rate,n )
	return 1-(1-rate)^n
end
function class_uiAnime.curve.easeInOut( rate,n )
	rate = 2*rate
	if rate < 1 then
		return class_uiAnime.curve.easeIn(rate,n)/2
	else
		return class_uiAnime.curve.easeOut(rate-1,n)/2+0.5
	end
end
function class_uiAnime.curve.shock( rate,n )	-- n为Anime摆动次数
	return math.sin(rate*n*math.pi)*(1-rate)
end
function class_uiAnime.curve.shockTo( rate,n )	-- n为Anime摆动次数
	return math.sin(rate*n*math.pi)*(1-rate)+rate
end
function class_uiAnime.curve.easeInBack( rate,parm )
	return (parm[2]+1)*rate^parm[1]-parm[2]*rate^(parm[1]-1)
end
function class_uiAnime.curve.easeOutBack( rate,parm )
	rate = 1 - rate
	return rate^(parm[1]-1)*(-(parm[2]+1)*rate+parm[2])+1
end
function class_uiAnime.curve.easeInOutBack( rate,parm )
	rate = 2*rate
	if rate < 1 then
		return class_uiAnime.curve.easeInBack(rate,parm)/2
	else
		return class_uiAnime.curve.easeOutBack(rate-1,parm)/2+0.5
	end
end
function class_uiAnime.curve.easeInElastic( rate,parm )
	rate = rate - 1
	local parmGet = -parm[2]/4
	return parm[1]^(10*rate)*math.sin((rate-parmGet)*2*math.pi/parm[2])
end
function class_uiAnime.curve.easeOutElastic( rate,parm )
	rate = -rate
	local parmGet = -parm[2]/4
	return 1-(parm[1]^(10*rate)*math.sin((rate-parmGet)*2*math.pi/parm[2]))
end
function class_uiAnime.curve.easeInOutElastic( rate,parm )
	rate = 2*rate
	if rate < 1 then
		return class_uiAnime.curve.easeInElastic(rate,parm)/2
	else
		return class_uiAnime.curve.easeOutElastic(rate-1,parm)/2+0.5
	end
end

-- uiAnime工具 fps检验
function class_uiAnime:_fpsCheck( t )
	if self.n_log > 120 then		-- 避免性能不足导致帧数欠债过多，即时跟紧时间
		self.t_log = t
		self.n_log = 0
		return true
	end
	if (t - self.t_log) > self.t_gap then
		self.t_log = self.t_log + self.t_gap
		self.n_log = self.n_log + 1
		return true
	else
		return false
	end
end
-- uiAnime工具 _时间步骤转process x坐标
function class_uiAnime:_timerProcess( now )
	if self.timer.start < 0 then		-- start < 0 未激活，直接返回basic值
		if self.reverse then
			return 1-self.basic
		else
			return self.basic
		end
	else 								-- start >= 0 正常的UI时间，为激活
		local process = self.basic+(now-self.delay-self.timer.start)/self.timer.duration
		if process > 1 then
			return 1
		elseif process < 0 then
			return 0
		end
		if self.reverse then
			return 1-process
		else
			return process
		end
	end
end
-- uiAnime工具	Anime绘制
function class_uiAnime:_draw()
	if type(self.package) == 'function' then	-- pacakge兼容判断
		self.target:Draw(self.package(self))
		return
	else
		self.target:Draw(self.package)
		return
	end
end
-- uiAnime工具	Anime终止检测
function class_uiAnime:_endCheck( rate )
	if rate == 1 then
		if self.loop then
			self:loopStart(false)
			return false
		else
			--self:finish(true) 循环中引发错误，不能在循环中清空/增添自己
			return true
		end
	end
end

-- CLASS-uiComponent
class_uiComponent = {ui_type='uiComponent',size_design={width=1920,height=1080},fix_factor={x=1,y=1},fixAble_default=false}	-- 基类 uiComponent,默认以1920x1080屏幕作基准画面
class_uiComponent.__index = class_uiComponent
setmetatable(class_uiComponent,class_base)
-- 初始化 计算fix_factor
class_uiComponent.fix_factor = {x=GLOBAL_WINSIZE.width/class_uiComponent.size_design.width,y=GLOBAL_WINSIZE.height/class_uiComponent.size_design.height}
-- 实例化new uiComponent类	->返回component类
function class_uiComponent.new( fixAble )
	if fixAble == nil then
		fixAble = class_uiComponent.fixAble_default
	end
	local comp = {boxs={},sets={},plugins={},pos={x=0,y=0},scale={x=1,y=1},
	visible=true,fix=fixAble}	-- 基类属性初始化
	setmetatable(comp,class_uiComponent)
	return comp
end
-- 通过模板实例化 uiComponent
function class_uiComponent.fromTemplate( template,fixAble )
	if fixAble == nil then
		fixAble = class_uiComponent.fixAble_default
	end
	local comp = {boxs={},sets={},plugins={},pos={x=0,y=0},scale={x=1,y=1},
	visible=true,fix=fixAble}
	setmetatable(comp,class_uiComponent)
	comp:setLink(template())
	comp:boxSupply()
	return comp
end
-- 清除/摧毁 当前 uiComponent 将进行所有值的全清空
function class_uiComponent:destroy( )
	tool_table.deepNil(self)
	tool_table.surfaceNil(self)
end
-- 复制生成新的 uiComponent,所有内容将复制继承	->返回此状态的新Component复制体
function class_uiComponent:clone( )
	local clone = {boxs={},sets=tool_table.deepCopy(self.sets),plugins=tool_table.deepCopy(self.plugins),pos={x=self.pos.x,y=self.pos.y},
	scale={x=self.scale.x,y=self.scale.y},visible=true,fix=true}
	setmetatable(clone,class_uiComponent)
	clone:boxCreate(#self.boxs)
	if self.visible then clone:Show()			-- 囊括显示状态
	else clone:Hide() end
	return clone
end
-- 引用源数据产生的新box Component 	-> 返回link链接数据信息的 Component
function class_uiComponent:linkCopy( )
	local linker = {boxs={},sets=self.sets,plugins=tool_table.deepCopy(self.plugins),pos=tool_table.deepCopy(self.pos),scale=tool_table.deepCopy(self.scale),
	visible=true,fix=self.fix}
	setmetatable(linker,class_uiComponent)
	clone:boxCreate(#self.boxs)
	if self.visible then linker:Show()			-- 囊括显示状态
	else linker:Hide() end
	return linker
end

-- uiComponent操作	设置位置
function class_uiComponent:positionSet( position )
	self.pos = {x=position.x,y=position.y}
	return self
end
-- uiComponent操作	设置缩放
function class_uiComponent:scaleSet( scale )
	if type(scale) == 'table' then
		self.scale = {x=scale.x,y=scale.y}
		return self
	elseif type(scale) == 'number' then
		self.scale = {x=scale,y=scale}
		return self
	end
end
-- uiComponent操作	获取sets的area区间
function class_uiComponent:getArea( )
	if #self.sets == 0 then return end 		-- 无set则return
	local min = {x=math.huge,y=math.huge}
	local max = {x=-math.huge,y=-math.huge}
	for i,set in pairs(self.sets) do
		if set.x < min.x then
			min.x = set.x
		end
		if set.y < min.y then
			min.y = set.y
		end
		if set.x+set.width > max.x then
			max.x = set.x+set.width
		end
		if set.y+set.height > max.y then
			max.y = set.y+set.height
		end
	end
	return {min,max}
end
-- uiComponent操作	set本地坐标位移		| 传入二维向量Table {x=[int],y=[int]}
function class_uiComponent:localMove( move )
	for i,set in pairs(self.sets) do
		set.x = set.x - move.x
		set.y = set.y - move.y
	end
	return self
end
-- uiComponent操作	set本地坐标位移至中央(忽略空白区)
function class_uiComponent:localCenter( )
	local area = self:getArea()
	self:localMove({x=(area[1].x+area[2].x)/2,y=(area[1].y+area[2].y)/2})
	return self
end
-- uiComponent操作	与另一uiComponent合并	->返回新的合并uiComponent 原先的组件并不会被删除
function class_uiComponent:merge( component,front )
	local group = class_uiComponent.new(self.fix)
	group.pos = tool_table.deepCopy(self.pos)
	group.scale = tool_table.deepCopy(self.scale)
	if not front then
		for i,set in pairs(self.sets) do
			group:setRegister( tool_table.deepCopy(set) )
		end
	end
	for i,set in pairs(component.sets) do
		local set_n = tool_table.deepCopy(set)
		group:setRegister( class_uiComponent._setMapping(set_n,component,self) )
	end
	if front then
		for i,set in pairs(self.sets) do
			group:setRegister( tool_table.deepCopy(set) )
		end
	end
	group:boxCreate(#self.boxs+#component.boxs)
	return group
end
-- uiComponent操作	与另一uiComponent合并并初始化坐标	->返回新的合并uiComponent 原先的组件并不会被删除
function class_uiComponent:mergeInit( component )	
	local group = class_uiComponent.new(self.fix)
	for i,set in pairs(self.sets) do
		local set_n = tool_table.deepCopy(set)
		group:setRegister( self:_setNormalize(set_n,{x=1,y=1}) )
	end
	for i,set in pairs(component.sets) do
		local set_n = tool_table.deepCopy(set)
		group:setRegister( component:_setNormalize(set_n,{x=1,y=1}) )
	end
	local base = group:getArea()[1]
	group:localMove(base)	-- 中心点 移至左上角
	group:positionSet(base)
	group:boxCreate(#self.boxs+#component.boxs)
	return group
end
-- uiComponent操作	全体组隐藏
function class_uiComponent:Hide( )
	for i,box in pairs(self.boxs) do
		box:Hide()
	end
	self.visible = false
	return self
end
-- uiComponent操作	全体组显示
function class_uiComponent:Show( )
	for i,box in pairs(self.boxs) do
		box:Show()
	end
	self.visible = true
	return self
end

-- boxs注册		|参数num为注册多少个
-- tip:此操作将会在原有boxs上追加创建，不会清除原有的box
function class_uiComponent:boxCreate( num )
	for i=1,num,1 do
		table.insert( self.boxs, UI.Box.Create() )
	end
	return self
end
-- boxs补充
-- tip:此操作根据set数补充box
function class_uiComponent:boxSupply( )
	local addNum = #self.sets - # self.boxs
	self:boxCreate(addNum)
	return self
end
-- boxs齐准
-- tip:若box少则补充，box多则削减，设计cg所以请尽可能在需要时调用
function class_uiComponent:boxAdapt( )
	local diffNum = #self.sets - # self.boxs
	if diffNum > 0 then
		self:boxCreate(diffNum)
	elseif diffNum < 0 then
		self:boxDelete(math.abs(diffNum))
	end
	return self
end
-- boxs删除 【从后向前删除】
function class_uiComponent:boxDelete( deleteNum )
	if deleteNum > #self.boxs then deleteNum = #self.boxs end
	for i=1,deleteNum,1 do
		table.remove(self.boxs)
	end
	collectgarbage('collect')
	return self
end
-- boxs清空
function class_uiComponent:boxClear( )
	tool_table.deepNil(self.boxs)
    return self
end
-- boxs计数		-> 返回当前boxs使用了多少UI.Box
function class_uiComponent:boxCount( )
	return #self.boxs
end

-- sets注册		|参数可为 单个set/set集群
function class_uiComponent:setRegister( ... )
	sets = {...}
	for key,set in pairs(sets) do
		table.insert(self.sets,set)
	end
    return self
end
-- sets移植		|参数 uiBox类/setstore
function class_uiComponent:setCopy( obj )
	if obj.ui_type == 'uiComponent' then
		self.sets = tool_table.deepCopy(obj.sets)
		return self
	elseif obj.type == 'uiSetStore' then
		self.sets = tool_table.deepCopy(obj)
		return self
	end
end
-- sets指向链接 此set遭受更改将牵连本Component表现
function class_uiComponent:setLink( obj )
	if obj.ui_type == 'uiComponent' then
		self.sets = obj.sets
		return self
	elseif type(obj) == 'table' then
		self.sets = obj
		return self
	end
end
-- sets清空
function class_uiComponent:setClear( )
	tool_table._deepNil(self.sets)
    return self
end
-- set操作		|镜像sets	传入对称轴 以 x / y 进行轴对称
function class_uiComponent:setMirror( axis )
	if axis == 'x' or axis == 'X' then
		for i,set in pairs(self.sets) do
			set.y = -set.y
			set.height = -set.height
		end
		return self
	elseif axis == 'y' or axis == 'Y' then
		for i,set in pairs(self.sets) do
			set.x = -set.x
			set.width = -set.width
		end
		return self
	end
end
-- set操作		|旋转sets	传入旋转角次ro	ro=1为 90° ro=2则代表180 turn为顺时针/逆时针， false为顺时针，true为逆时针
function class_uiComponent:setRotate( ro,turn )
	if turn then turn = -1
	else turn = 1 end
	for p = 1,ro,1 do
		for i,set in pairs(self.sets) do
			local buffer = set.x
			set.x = -turn*set.y
			set.y = turn*buffer
			buffer = set.width
			set.width = -turn*set.height
			set.height = turn*buffer
		end
	end
	return self
end

-- 设计UI时相对屏幕size尺寸设置		|参数应为table {width=[int],height=[int]}		->返回修改后的基准size
-- tip:uiBox自适应各个屏幕尺寸进行box变化
function class_uiComponent:sizeSet( size )
	self.fixAble = true		-- 开启sizeSet 说明你肯定要使用屏幕修正啦，这个就自动变true了
	self.size_design = size
	self.fix_factor = {x=GLOBAL_WINSIZE.width/self.size_design.width,y=GLOBAL_WINSIZE.height/self.size_design.height}	-- 更新factor
	return self
end

-- plugins添加绘制插件函数		|传入函数名称
-- tip:函数类似 function(box,set,i)	function|接收单个box和set及index次序，进行绘制过程中的更改	function->返回 box,set
function class_uiComponent:pluginRegister( ... )
	plugins = {...}
	for key,plugin in pairs(plugins) do
		table.insert(self.plugins,plugin)
	end
	return self
end
-- callback设定
function class_uiComponent:callbackSet( func )
	self.callback = func
	return self
end
-- callback清理
function class_uiComponent:callbackClear(  )
	self.callback = nil
	return self
end

-- uiComponent绘制函数
function class_uiComponent:Draw( package )
	local factor = {x=1,y=1}
	if self.fix then
		factor = self.fix_factor
	end
	-- boxs池取sets绘制
	for i,box in pairs(self.boxs) do
		local box_n = box
		if self.sets[i] then
			local set_n = tool_table.deepCopy(self.sets[i])
			for key,plugin in pairs(self.plugins) do 			-- plugin生效
				local box_t,set_t = plugin(box_n,set_n,i,package)
				if box_t ~= nil then box_n = box_t end			-- 防止box空值
				if set_t ~= nil then set_n = set_t end			-- 防止set空值
			end
			set_n = self:_setNormalize(set_n,factor)			-- 适配多屏幕
			box_n:Set(set_n)
		else   		-- box和set不对齐，默认不显示透明
			box_n:Set({x=0,y=0,width=0,height=0,r=0,g=0,b=0,a=0})
		end
	end
	-- draw完毕回调函数
	if self.callback ~= nil then
		self.callback(self)
	end
	return self
end

-- uiComponent的set标准化函数
function class_uiComponent:_setNormalize( set,factor )
	set.x = (self.pos.x+set.x*self.scale.x)*factor.x
	set.width = set.width*self.scale.x*factor.x
	set.y = (self.pos.y+set.y*self.scale.y)*factor.y
	set.height = set.height*self.scale.y*factor.y
	return set
end
-- set表 中心变换映射，用于merge时合并
function class_uiComponent._setMapping( set,from,to )	-- 从from点到to点映射
	local diff = {pos={x=from.pos.x-to.pos.x,y=from.pos.y-to.pos.y},
				scale={x=from.scale.x/to.scale.x,y=from.scale.y/to.scale.y}}
	set.x = (diff.pos.x+set.x*diff.scale.x)
	set.width = set.width*diff.scale.x
	set.y = (diff.pos.y+set.y*diff.scale.y)
	set.height = set.height*diff.scale.y
	return set
end


-- CLASS-uiTextGenerator
class_uiTextGenerator = {ui_type='uiTextGenerator'}
class_uiTextGenerator.__index = class_uiTextGenerator
setmetatable(class_uiTextGenerator,class_base)

-- 文字发生器	新建	| 传入uiFont字符集	->返回文字发生器table
-- tip: 一般的，一个地图构建一个文字发生器即可，除非是使用不同的字体，需使用不同的发生器
function class_uiTextGenerator.new( uiFont )
	if uiFont.ui_type == 'uiFont' or uiFont.ui_type == 'uiFonts' then
		local generator = {font=uiFont}
		setmetatable(generator,class_uiTextGenerator)
		return generator
	else
		return nil
	end
end

-- 文字发生器 构建函数	| 传入 字符串, fixAble 		->返回uiComponent类的 文字对象
function class_uiTextGenerator:textComponent( pos,str,fontSize,color,space,fixAble )
	if fontSize == nil then fontSize = self.font._fontSize end
	if color == nil then color = {r=0,g=0,b=0,a=255} end
	if space == nil then space = {x=1,y=2} end
	if type(space) == 'number' then space = {x=space, y=2} end
	space.y = self.font._fontSize + space.y -- 补全字高，真正的行间距设定
	fontSize = fontSize/self.font._fontSize	-- 更新字号为 scale放大系数
	str = self._str2table(str)
	local text = class_uiComponent.new(fixAble)
	local sets = self:_getTextSets(str, space, color)
	text:setLink(sets)
	text:positionSet(pos)
	text:scaleSet(fontSize)
	text:boxSupply()
	return text
end

-- 文字发生器 辅助函数	帮助uiComp完成一些文字内容的更新		| textSet {text='',color={r=,g=,b=,a=},space={x=,y=}}
function class_uiTextGenerator:textUpdate( comp, textSet )
	tool_table._deepNil(comp.sets)
	if textSet.color == nil then textSet.color = {r=0,g=0,b=0,a=255} end
	if textSet.space == nil then textSet.space = {x=1,y=2} end
	textSet.space.y = self.font._fontSize + textSet.space.y -- 补全字高，真正的行间距设定
	comp:setLink( self:_getTextSets( self._str2table(textSet.text), textSet.space, textSet.color ) )
	comp:boxAdapt()
	return comp
end
-- 文件发生器 辅助函数	改变字号
function class_uiTextGenerator:fontsizeSet( comp, fontSize )
	comp:scaleSet(fontSize/self.font._fontSize)
	return comp
end
-- 发生器内置函数	获取sets|集合使用了以下3个内置函数|		--> 传入 要设置的文本	间距
function class_uiTextGenerator:_getTextSets( str, space, color )
	local sets = {}
	local gap = {x=0,y=0}
	for i,char in pairs(str) do
		if char == ' ' then 			-- 类的上色设计缺陷，需专门为空格展开判断，不分配box，而是直接跳跃gap
			gap.x = gap.x + math.floor(self.font._fontSize/2) + space.x
			goto CONTINUE
		end
		if char == '\n' then			-- 若为换行则进行位移
			gap.y = gap.y + space.y
			gap.x = 0 					-- 缩进归0
			goto CONTINUE
		end
		local fset = self.font:_getFset(char)
		local len = self._getBoxNum(fset)
		for pointer = 1,len,1 do
			table.insert(sets,self._setTransform(fset, color, pointer, gap))
		end
		gap.x = gap.x + fset[#fset] + space.x
		:: CONTINUE ::
	end
	return sets
end
-- 发生器内置函数	string转table
function class_uiTextGenerator._str2table( str )
	local list = {}
	local i = 1
	while i <= #str do
		local char = string.sub(str, i, i)
		if string.byte(char) > 223 then 		-- 中日韩文
			table.insert(list, string.sub(str, i, i+2))
			i = i + 3
		elseif string.byte(char) < 128 then		-- 标准ascii
			table.insert(list, char)
			i = i + 1
		else 					-- ？？？ 拉丁文一系列奇怪
			table.insert(list, string.sub(str, i, i+1))
			i = i + 2
		end
	end
	return list
end
-- 发生器内置函数	获取font所需box数
function class_uiTextGenerator._getBoxNum( fset )
	return math.floor(#fset/4)
end
-- 发生器内置函数	据fontSet获取box的set转换
function class_uiTextGenerator._setTransform( fset, color, pointer, gap)
	pointer = pointer*4-3 	-- 替换为 实际的index
	return {x=fset[pointer]+gap.x, y=fset[pointer+1]+gap.y, width=fset[pointer+2], height=fset[pointer+3], r=color.r, g=color.g, b=color.b, a=color.a}
end





-- table工具函数
tool_table = {}
-- 深拷贝，将完全构建一份相同的新表
function tool_table.deepCopy( table )
	local copy = {}
	for key,val in pairs(table) do
		if type(val) == 'table' then
			copy[key] = tool_table.deepCopy( val )
		else
			copy[key] = val
		end
	end
	return copy
end
-- 深清除，将完全清除table的内容
function tool_table.deepNil( table )
	tool_table._deepNil(table)
	collectgarbage("collect")	-- 及时垃圾回收，防止后续代码受影响
end
-- 深清除，但不作垃圾回收
function tool_table._deepNil( table )
	for key,val in pairs(table) do
		if type(val) ~= 'table' then
			table[key] = nil
			goto CONTINUE
		elseif next(val) ~= nil then
			tool_table._deepNil( val )
		end
		:: CONTINUE ::
	end
end
-- 浅清除，仅将表第一次置空
function tool_table.surfaceNil( table )
	for key,val in pairs(table) do
		table[key] = nil
	end
end
-- 深输出，将完全输出表内的每一键值对
function tool_table.deepPrint( table, info )
	local connector = nil
	if info == nil then 
		info = '' 
		connector = ''
	else
		connector = ' -> '
	end
	for key,val in pairs(table) do
		if type(val) == 'table' then
			tool_table.deepPrint( val,info..connector..key )
		else
			print(info..connector..key,': ',val)
		end
	end
end
-- 全计数，将对key 及 index的存在的表层内容进行元素个数的计数
function tool_table.allCount( table )
	local count = 0
	for i,v in pairs(table) do
		count = count + 1
	end
	return count
end


-- ui类工具
tool_ui = {}
-- 瞬时绑定位置
function tool_ui.bindPosition( user,target,offset )
	if offset == nil then
		offset = {x=0,y=0}
	end
	local diff = {x=0,y=0}
	if target.ui_type ~= nil then
		diff = {x=target.pos.x+offset.x,y=target.pos.y+offset.y}
	else
		local set = target:Get()
		diff = {x=set.x+offset.x,y=set.y+offset.y}
	end
	if user.ui_type ~= nil then
		user:positionSet({x=diff.x,y=diff.y})
		user:Draw()
		return
	elseif type(user.Get) == 'function' then
		local set = user:Get()
		set.x = diff.x
		set.y = diff.y
		user:Set(set)
		return
	end
end
-- 瞬时绑定放大倍数
function tool_ui.bindScale( user,target,offset )
	if offset == nil then
		offset = {x=1,y=1}
	end
	local diff = {x=target.scale.x*offset.x,y=target.scale.y*offset.y}
	if user.ui_type ~= nil then
		user:scaleSet({x=diff.x,y=diff.y})
		user:Draw()
	else
		print("ERROR| bindScale can ONLY used with uiComponent  <from tool_ui>")
	end
end
-- 遍历更改sets表		| cmd {x=nil,y=nil,width=nil,height=nil,r=nil,g=nil,b=nil,a=nil}
function tool_ui.setsCommand( sets, cmd )
	for i,set in pairs(sets) do
		for key,val in pairs(cmd) do
			if set[key] ~= nil then
				set[key] = val
			end
		end
	end
end
-- 遍历更改sets色彩		| color {r=!,g=!,b=!,a=!}
function tool_ui.setsColorSet( sets, color )
	for i,set in pairs(sets) do
		set.r = color.r
		set.g = color.g
		set.b = color.b
		set.a = color.a
	end
end
-- 数字型表格 取相反数	-> 返回相反数表
function tool_ui.oppoSet( table )
	local output = {}
	for i,num in pairs(table) do
		output[i] = -num
	end
	return output
end
-- 数字型表格 取倒数	-> 返回倒数表
function tool_ui.recipSet( table )
	local output = {}
	for i,num in pairs(table) do
		output[i] = 1/num
	end
	return output
end
-- 二维向量加减操作	例如{x=!,y=!}的类型
function tool_ui.vectorAdd( vectorA, vectorB )
	return {x=vectorA.x+vectorB.x, y=vectorA.y+vectorB.y}
end
-- 二维向量乘法
function tool_ui.vectorMultiply( vectorA, vectorB )
	return {x=vectorA.x*vectorB.x, y=vectorA.y*vectorB.y}
end
-- 二维向量欧几里得距离求取	->返回距离
function tool_ui.vectorLength( vector )
	return (vector.x^2+vector.y^2)^(0.5)
end
-- 色彩加减方法		| color {r=!,g=!,b=!,a=!}
function tool_ui.rgbAdd( rgbA, rgbB )
	return {r=(rgbA.r+rgbB.r)%256,
			g=(rgbA.g+rgbB.g)%256,
			b=(rgbA.b+rgbB.b)%256,
			a=(rgbA.a+rgbB.a)%256 }
end
-- 色彩乘除方法		| color {r=!,g=!,b=!,a=!}
function tool_ui.rgbMultiply( rgbA, rgbB )
	return {r=(rgbA.r*rgbB.r)%256,
			g=(rgbA.g*rgbB.g)%256,
			b=(rgbA.b*rgbB.b)%256,
			a=(rgbA.a*rgbB.a)%256 }
end