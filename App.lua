local _, Addon = ...;

Addon.APP = CreateFrame( 'Frame' );
Addon.APP:RegisterEvent( 'ADDON_LOADED' );
Addon.APP:SetScript( 'OnEvent',function( self,Event,AddonName )
    if( AddonName == 'jReadyCheck' ) then

        Addon.APP.Run = function( self )
            SOUNDKIT.READY_CHECK_OLD = SOUNDKIT.READY_CHECK;
            SOUNDKIT.READY_CHECK = SOUNDKIT.RAID_WARNING;
            for Index = 1, 4 do
                local Frame = _G[ 'PartyMemberFrame'..Index ];
                Frame:SetScript( 'OnEvent',function( self,Event,... )
                    if( Event == 'READY_CHECK' ) then
                        UIErrorsFrame:AddMessage( 'You responded ready to leader' );
                        ReadyCheckFrameYesButton:Click();
                        C_Timer.After( 2,function()
                            ConfirmReadyCheck( true );
                        end)
                    end
                end );
            end
        end

        self:Run();
        self:UnregisterEvent( 'ADDON_LOADED' );
    end
end );