--- @since 25.2.7
--- @sync entry

return {
	---User arguments for the entry function
	---@class EntryArgs
	---@field action string of either "left", "right", "jump <val such as -50% or 5> <val such as the previous one but this one is for if you want a different preview seek jump>", "open"

	--- @param st table State
	--- @param args EntryArgs this cannot be nil
	entry = function(st, jobs)
		-- smart maximize preview w/ l/->
		-- smart seeking w/ up/down/j/k
		-- smart minimize w/ h/<-
		-- smart enter w/ enter (if needed)

		local is_preview_maximized = st.preview_maxed ~= nil

		local function maximize_preview()
			st.preview_maxed = true
			ya.mgr_emit("plugin", { "toggle-pane", "max-preview" })
		end

		local function minimize_preview()
			st.preview_maxed = nil -- unset it
			ya.mgr_emit("plugin", { "toggle-pane"," max-preview" })
		end

		local fns = {
			["left"] = function()
				-- either act as normal with left or minimize the preview
				if not is_preview_maximized then
					ya.mgr_emit("leave", {}) -- default action for left
				else
					-- The preview is maximized; exit it by toggling the other plugin
					minimize_preview()
				end
			end,
			["right"] = function()
				-- either act as normal with right or maximize the preview

				-- If directory, act normally
				-- otherwise, if preview is not maximized, then maximize it
				local h = cx.active.current.hovered
				if h and h.cha.is_dir then
					ya.mgr_emit("enter", { hovered = true })
				elseif not is_preview_maximized then
					-- otherwise, it is a file that is not maximized, so maximize it
					maximize_preview()
				else
					-- In the case that the preview IS maximized, do whatever here
					-- Nothing is likely for the best
				end
			end,
			["jump"] = function()
				-- jumping based on whether in preview or not
				local default_vec = jobs.args[2] -- string
				local preview_lines_vec = jobs.args[3] or default_vec

				if not is_preview_maximized then
					ya.mgr_emit("arrow", { default_vec })
				else
					ya.mgr_emit("seek", { preview_lines_vec })
				end
			end,
			["open"] = function()
				if is_preview_maximized then
					-- unmaximize before opening
					minimize_preview()
				end

				ya.mgr_emit("open", { hovered = true })
			end,
			["togglepreviewvisibility"] = function()
				-- only allow this if not maximized
				if not is_preview_maximized then
					ya.mgr_emit("plugin", { "toggle-pane", "min-preview" })
				end
			end,
		}

		-- Call the correct function
		fns[jobs.args[1]]()
	end,
}
