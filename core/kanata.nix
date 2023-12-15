{ pkgs, ... }:

{
  services.kanata = {
    enable = true;

    # default: pkgs.kanata
    # package = pkgs.kanata-with-cmd;

    keyboards."laptop" = {
      # Paths to keyboard devices
      devices = [
        "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
      ];

      config = ''
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;;           KANATA : defsrc          ;;
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

          (defsrc
            grv  1    2    3    4    5    6    7    8    9    0
            tab  q    w    e    r    t    y    u    i    o    p
            caps a    s    d    f    g    h    j    k    l    ;
            lsft lsgt z    x    c    v    b    n    m    ,    .    /    rsft
            lctl lmet lalt           spc                 ralt rctl
          )

          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          ;;          KANATA : deflayer         ;;
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

          (deflayer colemak
            _    _    _    _    _    _    _    _    _    _    _
            _    q    w    f    p    b    j    l    u    y    lmet
            _    a    r    s    t    g    m    n    e    i    o
            @ols _    z    x    c    d    v    k    h    _    _    _    @lst
            lctl lmet lalt                _              ralt rctl
          )

          (deflayer colemak-tap
            _    _    _    _    _    _    _    _    _    _    _
            _    q    w    f    p    b    j    l    u    y    lmet
            _    @m_a @a_r @c_s @s_t g    m    @s_n @c_e @a_i @m_o
            @lsa _    z    x    c    d    v    k    h    _    _    _    @lsc
            @olc @olm @ola                _              @ora @orc
          )

          (deflayer azerty
            _    _    _    _    _    _    _    _    _    _    _
            _    a    z    e    r    t    y    u    i    o    p
            _    q    s    d    f    g    h    j    k    l    m
            @ols _    w    x    c    v    b    n    ,    ;    .    _    @lsc
            @olc @olm @ola                _              @ora @orc
          )

          ;;;;;;;;;;;;;;;
          ;; VARIABLES ;;
          ;;;;;;;;;;;;;;;

          ;; tap-timeout, tap-hold and sticky-time
          (defvar
                  tt 200
                  ht 200
                  st 200
          )
          
          (defalias

            ;;;;;;;;;;;;;;;;;;;
            ;; HOME ROW MODS ;;
            ;;;;;;;;;;;;;;;;;;;

            m_a (tap-hold-press $tt $ht a lmet)
            a_r (tap-hold-press $tt $ht r lalt)
            c_s (tap-hold-press $tt $ht s lctl)
            s_t (tap-hold-press $tt $ht t lsft)
                               
            s_n (tap-hold-press $tt $ht n rsft)
            c_e (tap-hold-press $tt $ht e rctl)
            a_i (tap-hold-press $tt $ht i lalt)
            m_o (tap-hold-press $tt $ht o rmet)

            ;;;;;;;;;;;;
            ;; STICKY ;;
            ;;;;;;;;;;;;

            olm (one-shot $st lmet)
            ;; orm (one-shot $st rmet)

            ola (one-shot $st lalt)
            ora (one-shot $st ralt)

            olc (one-shot $st lctl)
            orc (one-shot $st rctl)

            ols (one-shot $st lsft)
            ors (one-shot 500 rsft)

            ;;;;;;;;;;;;
            ;; LAYERS ;;
            ;;;;;;;;;;;;

            ;; ls (tap-dance 200 (z (layer-switch colemak) (layer-switch azerty)))
            lsa (tap-hold-press 200 1000 @ors (layer-switch azerty))
            lsc (tap-hold-press 200 1000 @ols (layer-switch colemak))
            lst (tap-hold-press 200 1000 @ors (layer-switch colemak-tap))
          )

          ;;;;;;;;;;;;;;
          ;;   MISC   ;;
          ;;;;;;;;;;;;;;

          ;; (defvar tap-timeout 100) => $tap-timeout

          ;; (defalias dvk (layer-switch dvorak))
          ;; (defalias nav (layer-while-held navigation))

          ;; XX is a no operation key
          ;; rpt or rpt-any to repeat a key or chord

          ;; (caps-word 2000)
          ;; (caps-word-custom 2000 (a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9)

          ;; (include other-file.kbd)

          ;; Advanced: live reload, sequences and fake keys (like vim leaders), chords and sequences, swich case

          ;;;;;;;;;;;;;;;;
          ;;   STICKY   ;;
          ;;;;;;;;;;;;;;;;

          ;; one-shot (alias for one-shot-press) => (one-shot 500 a)
          ;; one-shot-press/release: end on the first press/release of another key
          ;; one-shot-press/release-pcancel: ... or on re-press/release of another active one-shot key

          ;;;;;;;;;;;;;;;;;;
          ;;   TAP-HOLD   ;;
          ;;;;;;;;;;;;;;;;;;

          ;; tap-hold-press / tap-hold-press => activate on another key press
          ;; tap-hold-release => activate on key another release
          ;; tap-hold-press/release-timeout => fifth parameter to replace hold action on timeout
          ;; tap-hold-release-keys => specify early tap keys
          ;; (tap-hold 200 200 a @num) ;; tap: a hold: num

          ;; td (tap-dance 200 (a b c d)) => tap-dance-eager performs all functions sequentially
          ;; (fork 1 2 (lalt ralt) => trigger 1 (default) or 2 if keys in last parameter are held

          ;;;;;;;;;;;;;;;
          ;;   MACRO   ;;
          ;;;;;;;;;;;;;;;

          ;; (multi/macro ... ...) => call multiple functions simultaneously ;; macro is riskier
          ;; macro-release-cancel => interrupted if released
          ;; macro-repeat / macro-repeat-release-cancel => loop

          ;; dynamic-macro-record => dynamic-macro-record-stop-(truncate) => dynamic-macro-play

          ;;;;;;;;;;;;;;;;;;;;;;;;
          ;;   LINUX COMMANDS   ;;
          ;;;;;;;;;;;;;;;;;;;;;;;;

          ;; (cmd alacritty) ;; not executed in a shell
          ;; (cmd bash -c "echo hello world")
          ;; cmd-output-keys ;; read result as s-exp
        '';
      
      # defcfg conf other than linux-dev and linux-continue-if-no-devs-found (set to yes)
        extraDefCfg = ''
        danger-enable-cmd yes      
      '';
      # process-unmapped-keys yes
      # sequence-timeout 2000

      # visible-backspaced, hidden-suppressed or hidden-delay-type
      # sequence-input-mode visible-backspaced

      # sequence-backtrack-modcancel no
      # log-layer-changes no
      # delegate-to-first-layer yes
      
      # extraArgs = [ "..." ];
    };
  };
}
