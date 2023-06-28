function SetColors(color)
		color = color or "kanagawa"
		vim.cmd.colorscheme(color)
end

SetColors()
