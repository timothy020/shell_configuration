--
-- ██╗    ██╗███████╗███████╗████████╗███████╗██████╗ ███╗   ███╗
-- ██║    ██║██╔════╝╚══███╔╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
-- ██║ █╗ ██║█████╗    ███╔╝    ██║   █████╗  ██████╔╝██╔████╔██║
-- ██║███╗██║██╔══╝   ███╔╝     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
-- ╚███╔███╔╝███████╗███████╗   ██║   ███████╗██║  ██║██║ ╚═╝ ██║
--  ╚══╝╚══╝ ╚══════╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
-- A GPU-accelerated cross-platform terminal emulator
-- https://wezfurlong.org/wezterm/

local k = require("utils/keys")
local wezterm = require("wezterm")

-- 设置启动时窗口位置居中，大小为屏幕的75%*85%
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	local gui_window = window:gui_window()
	
	-- 获取屏幕尺寸
	local screen = wezterm.gui.screens().active
	local screen_width = screen.width
	local screen_height = screen.height
	
	-- 计算窗口大小 (75% x 85%)
	local window_width = math.floor(screen_width * 0.75)
	local window_height = math.floor(screen_height * 0.85)
	
	-- 计算居中位置
	local x = math.floor((screen_width - window_width) / 2)
	local y = math.floor((screen_height - window_height) / 2)
	
	-- 设置窗口位置和大小
	gui_window:set_position(x, y)
	gui_window:set_inner_size(window_width, window_height)
end)

local act = wezterm.action
local opacity = 1.0
local config = {
	-- ╭─────────────────────────────────────────────────────────╮
	-- │                         GENERAL                         │
	-- ╰─────────────────────────────────────────────────────────╯
	check_for_updates = false,
	-- ╭─────────────────────────────────────────────────────────╮
	-- │                       APPEARANCE                        │
	-- ╰─────────────────────────────────────────────────────────╯
	-- FONT
	font_size = 15,
	-- font = wezterm.font("JetBrainsMonoNL Nerd Font Mono", { weight = "Regular" }),
	-- font = wezterm.font("Hack Nerd Font", { weight = "Regular" }),
	font = wezterm.font_with_fallback({
		-- { family = "FiraCode Nerd Font Mono", weight = "Regular" },
		-- { family = "Hack Nerd Font", weight = "Regular" },
		-- { family = "MesloLGL Nerd Font Mono", weight = "Regular" },
		{ family = "JetBrains Mono", weight = "Regular" },
		{ family = "Sarasa Term SC Nerd", weight = "Regular" },
		{ family = "SF Pro", weight = "Regular" },
	}),
	line_height = 1.1,

	-- COLOR SCHEME
	color_scheme = "Dracula",
	set_environment_variables = {
		BAT_THEME = "Dracula",
	},

	-- WINDOW
	window_padding = {
		left = 15,
		right = 15,
		top = 15,
		bottom = 15,
	},
	adjust_window_size_when_changing_font_size = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE | MACOS_FORCE_ENABLE_SHADOW",
	window_background_opacity = 0.9 ,
	macos_window_background_blur = 30,
	native_macos_fullscreen_mode = false,
	
	-- 背景图片设置
	-- background = {
	-- 	{
	-- 		source = {
	-- 			File = wezterm.config_dir .. "/pic1.png",  -- 背景图片路径
	-- 		},
	-- 		-- 图片显示设置
	-- 		repeat_x = "NoRepeat",          -- 水平方向不重复
	-- 		repeat_y = "NoRepeat",          -- 垂直方向不重复  
	-- 		width = "100%",                 -- 宽度占满窗口
	-- 		height = "100%",                -- 高度占满窗口
	-- 		horizontal_align = "Center",    -- 水平居中
	-- 		vertical_align = "Middle",      -- 垂直居中
	-- 		opacity = 0.3,                  -- 背景图片透明度 (0.0-1.0)
	-- 	},
	-- },

	-- TABS
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = false,
	show_new_tab_button_in_tab_bar = false,
	colors = {
		tab_bar = {
			background = "rgba(12%, 12%, 18%, 90%)",
			active_tab = {
				bg_color = "#cba6f7",
				fg_color = "rgba(12%, 12%, 18%, 0%)",
				intensity = "Bold",
			},
			inactive_tab = {
				fg_color = "#cba6f7",
				bg_color = "rgba(12%, 12%, 18%, 90%)",
				intensity = "Normal",
			},
			inactive_tab_hover = {
				fg_color = "#cba6f7",
				bg_color = "rgba(27%, 28%, 35%, 90%)",
				intensity = "Bold",
			},
			new_tab = {
				fg_color = "#808080",
				bg_color = "#1e1e2e",
			},
		},
	},

	-- ╭─────────────────────────────────────────────────────────╮
	-- │                          KEYS                           │
	-- ╰─────────────────────────────────────────────────────────╯
	keys = {
		-- ╭─────────────────────────────────────────────────────────╮
		-- │                    编辑器集成快捷键                        │  
		-- ╰─────────────────────────────────────────────────────────╯
		k.cmd_key("b", k.multiple_actions(":Neotree toggle")),              -- Cmd+B: 切换文件树显示/隐藏
		k.cmd_key("p", k.multiple_actions(":Telescope find_files")),        -- Cmd+P: 模糊搜索文件
		k.cmd_key("F", k.multiple_actions(":Telescope live_grep")),         -- Cmd+Shift+F: 全局文本搜索
		k.cmd_key("g", k.multiple_actions(":LazyGitCurrentFile")),          -- Cmd+G: 打开当前文件的Git操作界面
		k.cmd_key("G", k.multiple_actions(":Telescope git_submodules")),    -- Cmd+Shift+G: Git子模块管理
		k.cmd_key("R", k.multiple_actions(":OverseerRestartLast")),         -- Cmd+Shift+R: 重启上次执行的任务
		k.cmd_key("r", k.multiple_actions(":OverseerRun")),                 -- Cmd+R: 运行任务选择器
		k.cmd_ctrl_key("d", k.multiple_actions(":DiffviewFileHistory %")),  -- Cmd+Ctrl+D: 查看当前文件的Git历史差异
		
		-- 保存文件快捷键 (先退出插入模式，再保存)
		k.cmd_key(
			"s",
			act.Multiple({
				act.SendKey({ key = "\x1b" }), -- 发送ESC键退出插入模式
				k.multiple_actions(":w"),      -- 执行Vim保存命令
			})
		),

		-- ╭─────────────────────────────────────────────────────────╮
		-- │                    tmux session操作                      │
		-- ╰─────────────────────────────────────────────────────────╯
		k.cmd_to_tmux_prefix("d", "d"), -- Cmd+d: detach当前会话
		k.cmd_to_tmux_prefix("e", "K"), -- Cmd+e: 退出当前会话(前提是在 ~/.tmux.conf配置了"bind K kill-session")
		k.cmd_to_tmux_prefix("a", "w"), -- Cmd+a: 打开tmux-sessionx会话管理器
		
		-- ╭─────────────────────────────────────────────────────────╮
		-- │                    tmux windows操作                      │
		-- ╰─────────────────────────────────────────────────────────╯
		k.cmd_to_tmux_prefix("n", "c"),  -- Cmd+n: 创建新的tmux窗口
		k.cmd_to_tmux_prefix("w", "&"),  -- Cmd+w: 关闭当前tmux窗口
		k.cmd_to_tmux_prefix("H", "p"),  -- Cmd+j: 切换到上一个窗口
		k.cmd_to_tmux_prefix("L", "n"),  -- Cmd+k: 切换到下一个窗口
		k.cmd_to_tmux_prefix("0", "0"),  -- Cmd+0: 切换到tmux窗口0
		k.cmd_to_tmux_prefix("1", "1"),  -- Cmd+1: 切换到tmux窗口1
		k.cmd_to_tmux_prefix("2", "2"),  -- Cmd+2: 切换到tmux窗口2
		k.cmd_to_tmux_prefix("3", "3"),  -- Cmd+3: 切换到tmux窗口3
		k.cmd_to_tmux_prefix("4", "4"),  -- Cmd+4: 切换到tmux窗口4
		k.cmd_to_tmux_prefix("5", "5"),  -- Cmd+5: 切换到tmux窗口5
		k.cmd_to_tmux_prefix("6", "6"),  -- Cmd+6: 切换到tmux窗口6
		k.cmd_to_tmux_prefix("7", "7"),  -- Cmd+7: 切换到tmux窗口7
		k.cmd_to_tmux_prefix("8", "8"),  -- Cmd+8: 切换到tmux窗口8
		k.cmd_to_tmux_prefix("9", "9"),  -- Cmd+9: 切换到tmux窗口9

		-- ╭─────────────────────────────────────────────────────────╮
		-- │                    tmux panel操作                        │
		-- ╰─────────────────────────────────────────────────────────╯
		k.cmd_to_tmux_prefix("p", '"'), -- Cmd+p: tmux水平分割面板
		k.cmd_to_tmux_prefix("P", "%"), -- Cmd+Shift+p: tmux垂直分割面板
		k.cmd_to_tmux_prefix("x", "x"), -- Cmd+x: 关闭当前tmux面板
		-- Cmd+h/l/j/k: 切换到左一个/右一个/上一个/下一个面板
		k.cmd_to_tmux_prefix("h", "LeftArrow"),
		k.cmd_to_tmux_prefix("l", "RightArrow"),
		k.cmd_to_tmux_prefix("j", "UpArrow"),
		k.cmd_to_tmux_prefix("k", "DownArrow"),

		
		k.cmd_to_tmux_prefix("z", "z"), -- Cmd+Z: 缩放/取消缩放当前tmux面板
		
		-- ╭─────────────────────────────────────────────────────────╮
		-- │                 WezTerm 标签页切换                        │
		-- ╰─────────────────────────────────────────────────────────╯
		k.wezterm_tab_switch("1", 1),    -- Cmd+Shift+1: 切换到WezTerm标签页1
		k.wezterm_tab_switch("2", 2),    -- Cmd+Shift+2: 切换到WezTerm标签页2
		k.wezterm_tab_switch("3", 3),    -- Cmd+Shift+3: 切换到WezTerm标签页3
		k.wezterm_tab_switch("4", 4),    -- Cmd+Shift+4: 切换到WezTerm标签页4
		k.wezterm_tab_switch("5", 5),    -- Cmd+Shift+5: 切换到WezTerm标签页5
		k.wezterm_tab_switch("6", 6),    -- Cmd+Shift+6: 切换到WezTerm标签页6
		k.wezterm_tab_switch("7", 7),    -- Cmd+Shift+7: 切换到WezTerm标签页7
		k.wezterm_tab_switch("8", 8),    -- Cmd+Shift+8: 切换到WezTerm标签页8
		k.wezterm_tab_switch("9", 9),    -- Cmd+Shift+9: 切换到WezTerm标签页9
		
		
		-- ╭─────────────────────────────────────────────────────────╮
		-- │                  WezTerm 原生功能                         │
		-- ╰─────────────────────────────────────────────────────────╯
		{ key = "t", mods = "CMD|CTRL", action = wezterm.action.EmitEvent("toggle-opacity") }, -- Cmd+Ctrl+T: 切换窗口透明度
		
		-- ╭─────────────────────────────────────────────────────────╮
		-- │                  WezTerm 标签页管理                       │
		-- ╰─────────────────────────────────────────────────────────╯
		{ key = "t", mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") }, -- Cmd+t: 新建标签页
		{ key = "W", mods = "CMD", action = act.CloseCurrentTab({ confirm = true }) }, -- Cmd+Shift+w: 关闭当前标签页(需确认)
		
		-- Alt+A: 关闭除当前标签页外的所有其他标签页
		{ key = "a", mods = "ALT", action = wezterm.action_callback(function(window, pane)
				local mux_window = window:mux_window()
				local tabs = mux_window:tabs()
				local current_tab = window:active_tab()
				
				-- 遍历所有标签页，关闭除当前标签页外的其他标签页
				for _, tab in ipairs(tabs) do
					if tab:tab_id() ~= current_tab:tab_id() then
						tab:activate()                                                    -- 激活要关闭的标签页
						window:perform_action(act.CloseCurrentTab({ confirm = false }), pane) -- 关闭标签页(无需确认)
					end
				end
				-- 重新激活原来的标签页
				current_tab:activate()
			end),
		},
	},
}


return config
