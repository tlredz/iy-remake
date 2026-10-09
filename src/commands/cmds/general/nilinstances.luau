return {
	action = "clearnilinstances|nonilinstances|cni",
	description = "Destroys every nil instance (needs getnilinstances)",
	run = function(self)
		if not getnilinstances then
			self:notify("Incompatible Exploit", "Your exploit does not support this command (missing getnilinstances)")
			return
		end
		
		for _, object in getnilinstances() do
			object:Destroy()
		end
	end
}
