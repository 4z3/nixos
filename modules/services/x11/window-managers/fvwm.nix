{ config, pkgs, ... }:

with pkgs.lib;

let

  cfg = config.services.xserver.windowManager.fvwm;

in

{

  ###### interface

  options = {

    services.xserver.windowManager.fvwm.enable = mkOption {
      default = false;
      description = "Enable the FVWM window manager.";
    };

  };


  ###### implementation

  config = mkIf cfg.enable {

    services.xserver.windowManager.session = singleton
      { name = "fvwm";
        start =
          ''
            ${pkgs.fvwm}/bin/fvwm &
            waitPID=$!
          '';
      };

    environment.x11Packages = [ pkgs.fvwm ];

  };

}
