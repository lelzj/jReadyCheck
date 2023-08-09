local _, Addon = ...;

Addon.APP = CreateFrame( 'Frame' );
Addon.APP:RegisterEvent( 'ADDON_LOADED' );
Addon.APP:SetScript( 'OnEvent',function( self,Event,AddonName )
    if( AddonName == 'jReadyCheck' ) then

        Addon.APP.Theme = {
            Text = {
                Hex = 'ffffff',
            },
            Notify = {
                Hex = '009bff',
            },
        };

        Addon.APP.Notify = function( self,... )
            local prefix = CreateColor(
                self.Theme.Notify.r,
                self.Theme.Notify.g,
                self.Theme.Notify.b
            ):WrapTextInColorCode( AddonName );

            _G[ 'DEFAULT_CHAT_FRAME' ]:AddMessage( string.join( ' ', prefix, ... ) );
        end

        --
        --  Module init
        --
        --  @return void
        Addon.APP.Init = function( self )

            self.Name = AddonName;

            for Key,Data in pairs( self.Theme ) do
                if( Key ~= 'Font' ) then
                    self.Theme[ Key ].r,self.Theme[ Key ].g,self.Theme[ Key ].b = Addon:Hex2RGB( Data.Hex );
                end
            end
        end

        --
        --  Module run
        --
        --  @return void
        Addon.APP.Run = function( self )
            SOUNDKIT.READY_CHECK_OLD = SOUNDKIT.READY_CHECK;
            SOUNDKIT.READY_CHECK = SOUNDKIT.RAID_WARNING;
            for Index = 1, 4 do
                local Frame = _G[ 'PartyMemberFrame'..Index ];
                Frame:SetScript( 'OnEvent',function( self,Event,... )
                    if( Event == 'READY_CHECK' ) then
                        local MessageText = 'You responded ready to leader';
                        if( Index == 1 ) then
                            UIErrorsFrame:AddMessage( MessageText,
                                Addon.APP.Theme.Text.r,
                                Addon.APP.Theme.Text.g,
                                Addon.APP.Theme.Text.b 
                            );
                            Addon.APP:Notify( MessageText );
                        end
                        ReadyCheckFrameYesButton:Click();
                        C_Timer.After( 2,function()
                            ConfirmReadyCheck( true );
                        end)
                    end
                end );
            end
        end

        self:Init();
        self:Run();
        self:UnregisterEvent( 'ADDON_LOADED' );
    end
end );