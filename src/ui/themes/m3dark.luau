return {
	DisplayName = "M3 Dark",

	-- Material 3's dark scheme: surfaces are a family of grays, the primary is lavender, and the tonal colors
	-- (the BACK / NEXT buttons) are the secondary container of the scheme
	Font = {
		Normal = Enum.Font.BuilderSans,
		Medium = Enum.Font.BuilderSansMedium,
		Bold = Enum.Font.BuilderSansBold,
		ExtraBold = Enum.Font.BuilderSansExtraBold,
		MonoSpace = Enum.Font.RobotoMono,
	},
	Colors = {
		Background = Color3.fromRGB(20, 18, 24), -- surface
		Primary = Color3.fromRGB(208, 188, 255), -- primary
		OnPrimary = Color3.fromRGB(56, 30, 114), -- on primary
		Stroke = Color3.fromRGB(73, 69, 79), -- outline variant

		Error = Color3.fromRGB(242, 184, 181),
		Icons = Color3.fromRGB(230, 224, 233), -- on surface

		ScrollBar = {
			Thumb = Color3.fromRGB(73, 69, 79),
			Arrow = Color3.fromRGB(230, 224, 233),
			Background = Color3.fromRGB(33, 31, 38),
		},
		Buttons = {
			Holding = Color3.fromRGB(43, 41, 48), -- surface container high
			Default = Color3.fromRGB(33, 31, 38), -- surface container
		},
		Border = {
			Holding = Color3.fromRGB(54, 52, 59), -- surface container highest
			Default = Color3.fromRGB(27, 25, 31), -- surface container low
		},
		Tonal = {
			Default = Color3.fromRGB(74, 68, 88), -- secondary container
			Text = Color3.fromRGB(232, 222, 248), -- on secondary container
			Disabled = Color3.fromRGB(45, 43, 49), -- on surface at 12%
			DisabledText = Color3.fromRGB(100, 96, 103), -- on surface at 38%
		},
		Text = {
			Default = Color3.fromRGB(230, 224, 233),
			Dark = Color3.fromRGB(202, 196, 208), -- on surface variant
			Darker = Color3.fromRGB(147, 143, 153), -- outline
		},
		Slider = {
			SliderBar = Color3.fromRGB(208, 188, 255),
			SliderNumber = Color3.fromRGB(230, 224, 233),
		},
	},
}
