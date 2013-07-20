AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()
	self.Entity:SetModel("models/bacon01/bacon01.mdl")
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )

	self.Index = self.Entity:EntIndex()
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 1

	local ent = ents.Create( "food_bacon" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Use(activator)
	local healthamount = foodmod.healthgain
	local energyamount = foodmod.energygain
	
	if foodmod.mode == 1 then
		local health = activator:Health()
		activator:SetHealth(math.Clamp((health or 100) + healthamount, 0, 100))
	end
	
	if foodmod.mode == 2 then
		local energy = activator:getDarkRPVar("Energy")
		activator:SetSelfDarkRPVar("Energy", math.Clamp((energy or 100) + energyamount, 0, 100))
	end
	
	self.Entity:Remove()
	activator:EmitSound("foodmod/eating.wav", 50, 100)
end