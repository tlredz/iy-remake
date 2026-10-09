

--[[local textBox = script.Parent

textBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		textBox.Text = textBox.Text .. "\n"
		
		task.defer(function()
			textBox:CaptureFocus()
		end)
	end
end)]]