AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:SpawnFunction( ply, tr, class )
    if ( !tr.Hit ) then return end
    local pos = tr.HitPos + tr.HitNormal * 4
    local ent = ents.Create( class )
    ent:SetPos( pos )
    ent:Spawn()
    ent:Activate()
    return ent
end

function ENT:Initialize()
	self:SetModel( self.foodModel )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Use( activator )
	if foodmod.mode == 1 then
		local health = activator:Health()
		activator:SetHealth( math.Clamp( ( health or 100 ) + foodmod.healthgain, 0, 100 ) )
	end
	
	if foodmod.mode == 2 then
		local energy = activator:getDarkRPVar("Energy")
		activator:setSelfDarkRPVar( "Energy", math.Clamp( (energy or 100) + foodmod.energygain, 0, 100 ) )
	end
	
	activator:EmitSound( self.foodSound, 50, 100 )
	self:Remove()
end