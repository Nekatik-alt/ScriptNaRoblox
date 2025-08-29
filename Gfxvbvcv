local p=game:GetService("Players")local lp=p.LocalPlayer
local nb=script.Parent.NameBox
local cb=script.Parent.ConfirmButton
local function copy(n)local tp=p:FindFirstChild(n)if not tp then return end
local tc=tp.Character if not tc then return end
local lc=lp.Character if not lc then return end
local h=lc:FindFirstChildOfClass("Humanoid")local th=tc:FindFirstChildOfClass("Humanoid")
if h and th then local d=th:GetAppliedDescription()h:ApplyDescription(d)end end
cb.MouseButton1Click:Connect(function()local n=nb.Text if n~=""then copy(n)end end)
