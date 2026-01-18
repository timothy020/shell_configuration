--
-- ██╗  ██╗███████╗██╗   ██╗███████╗
-- ██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝
-- █████╔╝ █████╗   ╚████╔╝ ███████╗
-- ██╔═██╗ ██╔══╝    ╚██╔╝  ╚════██║
-- ██║  ██╗███████╗   ██║   ███████║
-- ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝
--
-- WezTerm 快捷键工具模块
-- 提供快捷键绑定的便捷函数和常用操作封装
--

local wt_action = require("wezterm").action
local h = require("utils/helpers")
local M = {}

-- 创建多个连续按键动作的组合
-- 将字符串中的每个字符转换为按键动作，最后添加回车键
-- @param keys string 要发送的按键序列字符串
-- @return action 组合的按键动作
-- 
-- 使用示例：multiple_actions(":w") 会发送 ':' 'w' 和回车键
M.multiple_actions = function(keys)
	local actions = {}
	-- 遍历字符串中的每个字符
	for key in keys:gmatch(".") do
		table.insert(actions, wt_action.SendKey({ key = key }))
	end
	-- 在最后添加回车键以执行命令
	table.insert(actions, wt_action.SendKey({ key = "\n" }))
	return wt_action.Multiple(actions)
end

-- 创建快捷键绑定的基础函数
-- @param mods string 修饰键组合 (如 "CMD", "CMD|CTRL")
-- @param key string 主按键
-- @param action action 要执行的动作
-- @return table 快捷键配置表
M.key_table = function(mods, key, action)
	return {
		mods = mods,    -- 修饰键
		key = key,      -- 主按键
		action = action, -- 执行动作
	}
end

-- 创建 Cmd + 按键的快捷键绑定
-- @param key string 主按键
-- @param action action 要执行的动作
-- @return table 快捷键配置表
M.cmd_key = function(key, action)
	return M.key_table("CMD", key, action)
end

-- 创建 Cmd + Ctrl + 按键的快捷键绑定
-- @param key string 主按键
-- @param action action 要执行的动作
-- @return table 快捷键配置表
M.cmd_ctrl_key = function(key, action)
	return M.key_table("CMD|CTRL", key, action)
end

-- 创建发送 tmux 前缀键组合的快捷键
-- tmux 前缀键设置为 Ctrl+Space，然后发送指定的 tmux 命令键
-- @param key string WezTerm 中的触发按键
-- @param tmux_key string tmux 中的命令按键
-- @return table 快捷键配置表
-- 
-- 使用示例：cmd_to_tmux_prefix("1", "1") 创建 Cmd+1 -> Ctrl+Space, 1 的映射
M.cmd_to_tmux_prefix = function(key, tmux_key)
	return M.cmd_key(
		key,
		wt_action.Multiple({
			-- 发送 tmux 前缀键 (Ctrl+Space)
			wt_action.SendKey({ mods = "CTRL", key = "b" }),
			-- 发送 tmux 命令键
			wt_action.SendKey({ key = tmux_key }),
		})
	)
end

-- 创建 WezTerm 标签页切换快捷键
-- 使用 Cmd+Shift+数字键来切换到指定的标签页
-- @param key string 数字键 ("1"-"9")
-- @param tab_index number 标签页索引 (1-9)
-- @return table 快捷键配置表
-- 
-- 注意：WezTerm 的标签页索引从 0 开始，所以需要减 1
M.wezterm_tab_switch = function(key, tab_index)
	return M.key_table("CMD|SHIFT", key, wt_action.ActivateTab(tab_index - 1))
end

return M