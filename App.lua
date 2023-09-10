local _, Addon = ...;

Addon.APP = CreateFrame( 'Frame' );
Addon.APP:RegisterEvent( 'ADDON_LOADED' );
Addon.APP:SetScript( 'OnEvent',function( self,Event,AddonName )
    if( AddonName == 'jReadyCheck' ) then

        Addon.APP.Notify = function( self,... )
            local prefix = CreateColor(
                Addon.Theme.Notify.r,
                Addon.Theme.Notify.g,
                Addon.Theme.Notify.b
            ):WrapTextInColorCode( AddonName );

            _G[ 'DEFAULT_CHAT_FRAME' ]:AddMessage( string.join( ' ', prefix, ... ) );
        end

        --
        --  Module init
        --
        --  @return void
        Addon.APP.Init = function( self )
            self.Name = AddonName;
        end

        --
        --  Module run
        --
        --  @return void
        Addon.APP.Run = function( self )
            for Index = 1, 4 do
                local Frame = _G[ 'PartyMemberFrame'..Index ];
                Frame:SetScript( 'OnEvent',function( self,Event,... )
                    if( Event == 'READY_CHECK' ) then
                        MuteSoundFile( SOUNDKIT.READY_CHECK );
                        local MessageText = 'You responded ready to leader';
                        if( Index == 1 ) then
                            UIErrorsFrame:AddMessage( MessageText,
                                Addon.Theme.Text.r,
                                Addon.Theme.Text.g,
                                Addon.Theme.Text.b 
                            );
                            Addon.APP:Notify( MessageText );
                        end
                        ReadyCheckFrameYesButton:Click();
                        PlaySound( SOUNDKIT.RAID_WARNING );
                        --ConfirmReadyCheck( true );
                    end
                end );
            end
        end

        self:Init();
        self:Run();
        self:UnregisterEvent( 'ADDON_LOADED' );
    end
end );