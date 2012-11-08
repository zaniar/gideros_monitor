--[[

 Bismillahirrahmanirrahim
 
 Gideros Monitor
 Show memory usage and frame rate
 By: Edwin Zaniar Putra (zaniar@nightspade.com)
 Version: 2012.11.0

 This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
 Copyright © 2012 Nightspade (http://nightspade.com).

--]]

local Monitor = Core.class(Sprite)

function Monitor:init()
	self:setPosition(leftBorder, topBorder)

	self.bg = Shape.new()
	self.bg:setFillStyle(Shape.SOLID, 0x000000, .3)
	self:addChild(self.bg)
	
	self.frameCount = 0
	self.tfFPS = TextField.new(nil, "0 FPS")
	self.tfFPS:setPosition(rightBorder-self.tfFPS:getWidth()-2, self.tfFPS:getHeight()+1)
	self.tfFPS:setTextColor(0xffffff)
	self:addChild(self.tfFPS)

	self.tfMemory = TextField.new(nil, "0 kB")
	self.tfMemory:setPosition(2, self.tfMemory:getHeight()+1)
	self.tfMemory:setTextColor(0xffffff)
	self:addChild(self.tfMemory)
	
	local bgHeight = self.tfMemory:getHeight()+4
	self.bg:beginPath()
	self.bg:moveTo(leftBorder,topBorder)
	self.bg:lineTo(rightBorder,topBorder)
	self.bg:lineTo(rightBorder,bgHeight)
	self.bg:lineTo(leftBorder,bgHeight)
	self.bg:closePath()
	self.bg:endPath()
	
	local timer = Timer.new(1000)
	timer:addEventListener(Event.TIMER, function(self)
		self.tfFPS:setText(self.frameCount.." FPS")
		self.tfFPS:setX(rightBorder-self.tfFPS:getWidth()-2)
		self.frameCount = 0
	end, self)
	timer:start()

	stage:addEventListener(Event.ENTER_FRAME, function()
		self.frameCount = self.frameCount + 1
		self.tfMemory:setText("luaMem: "..math.ceil(collectgarbage("count")).."kB textureMem: "..math.ceil(application:getTextureMemoryUsage()-64).."kB")
		stage:addChildAt(self, stage:getNumChildren()+1)
	end)
end

monitor = Monitor.new()