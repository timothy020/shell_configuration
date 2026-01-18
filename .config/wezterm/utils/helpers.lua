--
-- ██╗  ██╗███████╗██╗     ██████╗ ███████╗██████╗ ███████╗
-- ██║  ██║██╔════╝██║     ██╔══██╗██╔════╝██╔══██╗██╔════╝
-- ███████║█████╗  ██║     ██████╔╝█████╗  ██████╔╝███████╗
-- ██╔══██║██╔══╝  ██║     ██╔═══╝ ██╔══╝  ██╔══██╗╚════██║
-- ██║  ██║███████╗███████╗██║     ███████╗██║  ██║███████║
-- ╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝
-- 
-- WezTerm 助手工具模块
-- 提供系统主题检测和窗口透明度切换功能
--

local wezterm = require("wezterm")
local M = {}

-- 获取系统外观设置（用于检测深色/浅色模式）
local appearance = wezterm.gui.get_appearance()

-- 检测当前系统是否为深色模式
-- @return boolean 如果是深色模式返回true，否则返回false
M.is_dark = function()
	return appearance:find("Dark")
end

-- 注册窗口透明度切换事件处理器
-- 该函数在用户按下透明度切换快捷键时被调用
-- 功能：在完全不透明(1.0)和半透明(0.9)之间切换
wezterm.on("toggle-opacity", function(window, pane)
	-- 获取当前窗口的配置覆盖设置
	local overrides = window:get_config_overrides() or {}
	
	-- 检查当前透明度状态并切换
	if overrides.window_background_opacity == 1.0 then
		-- 当前是不透明状态，切换为半透明
		overrides.window_background_opacity = 0.9
		
		-- 设置半透明模式下的标签栏颜色
		overrides.colors = {
			tab_bar = {
				-- 标签栏背景色（半透明）
				background = "rgba(12%, 12%, 18%, 90%)",
				
				-- 活动标签样式
				active_tab = {
					bg_color = "#cba6f7",    -- 紫色背景
					fg_color = "rgba(12%, 12%, 18%, 0%)",  -- 深色文字
					intensity = "Bold",       -- 粗体
				},
				
				-- 非活动标签样式
				inactive_tab = {
					fg_color = "#cba6f7",    -- 紫色文字
					bg_color = "rgba(12%, 12%, 18%, 90%)", -- 半透明背景
					intensity = "Normal",     -- 正常字体粗细
				},
				
				-- 鼠标悬停时的非活动标签样式
				inactive_tab_hover = {
					fg_color = "#cba6f7",    -- 紫色文字
					bg_color = "rgba(27%, 28%, 35%, 90%)", -- 稍亮的半透明背景
					intensity = "Bold",       -- 粗体
				},
				
				-- 新建标签按钮样式
				new_tab = {
					fg_color = "#808080",    -- 灰色文字
					bg_color = "#1e1e2e",    -- 深色背景
				},
			},
		}
	else
		-- 当前是半透明状态，切换为完全不透明
		overrides.window_background_opacity = 1.0
		
		-- 设置不透明模式下的标签栏颜色
		overrides.colors = {
			tab_bar = {
				-- 标签栏背景色（完全不透明）
				background = "rgba(12%, 12%, 18%, 100%)",
				
				-- 活动标签样式
				active_tab = {
					bg_color = "#cba6f7",    -- 紫色背景
					fg_color = "rgba(12%, 12%, 18%, 100%)", -- 深色文字
					intensity = "Bold",       -- 粗体
				},
				
				-- 非活动标签样式
				inactive_tab = {
					fg_color = "#cba6f7",    -- 紫色文字
					bg_color = "rgba(12%, 12%, 18%, 100%)", -- 不透明背景
					intensity = "Normal",     -- 正常字体粗细
				},
				
				-- 鼠标悬停时的非活动标签样式
				inactive_tab_hover = {
					fg_color = "#cba6f7",    -- 紫色文字
					bg_color = "rgba(27%, 28%, 35%, 100%)", -- 稍亮的不透明背景
					intensity = "Bold",       -- 粗体
				},
				
				-- 新建标签按钮样式
				new_tab = {
					fg_color = "#808080",    -- 灰色文字
					bg_color = "#1e1e2e",    -- 深色背景
				},
			},
		}
	end
	
	-- 应用配置覆盖设置到当前窗口
	window:set_config_overrides(overrides)
end)

-- 数学工具函数
M.clamp = function(x, min, max)
  return x < min and min or (x > max and max or x)
end

M.round = function(x, increment)
  if increment then
    return M.round(x / increment) * increment
  end
  return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
end

return M