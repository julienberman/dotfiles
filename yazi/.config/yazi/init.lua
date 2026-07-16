local documents = os.getenv("HOME") .. "/Documents"

ps.sub("ind-sort", function(options)
	if tostring(cx.active.current.cwd) == documents then
		options.by = "mtime"
		options.reverse = true
		options.dir_first = false
	else
		options.by = "alphabetical"
		options.reverse = false
		options.dir_first = true
	end

	return options
end)
