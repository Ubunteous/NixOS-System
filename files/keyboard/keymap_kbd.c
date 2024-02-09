// Place this file in the colemak-dh directory
// Flash: dd if=qmk_firmware/kbdfans_kbd67_mkiirgb_v3_colemak-dh.bin of=/run/media/ubunteous/KBDFANS/FLASH.BIN bs=512 conv=notrunc oflag=direct,sync

// Place this in rules.mk
// TAP_DANCE_ENABLE = yes
// CAPS_WORD_ENABLE = yes
  
#include QMK_KEYBOARD_H

#include <keymap_french.h> // from quantum/keymap_extras/ do not use as changes QWM to AZ,
/* #include sendstring_french.h // also imports keymap-french */

/////////////////////
// CONFIGURATION  //
///////////////////

#define ONESHOT_TAP_TOGGLE 2
#define ____ _______ // shorter transparent keys

// Configure the global tapping term (default: 200ms)
#define TAPPING_TERM 200

// Enable rapid switch from tap to hold, disables double tap hold auto-repeat.
/* #define QUICK_TAP_TERM 0 */

/////////////////////
// HOME ROW MODS  //
///////////////////

// Left-hand home row mods
/* #define GUI_Z LGUI_T(KC_Z) */
// #define ALT_X LALT_T(KC_X)
/* #define SFT_C LSFT_T(KC_C) */
#define GUI_D LGUI_T(KC_D)

// Right-hand home row mods
/* #define CTL_V RCTL_T(KC_V) */
#define GUI_K RGUI_T(KC_K)
#define CTL_H RCTL_T(KC_H)

//////////////
// LAYERS  //
////////////

// layers, ordering is important!
enum layers {
  _BASE,
  _GB,
  _MOD,
  _NUM,
  _SPC,
  _FN,
};

/////////////////
// TAP DANCE  //
///////////////

// TAP_DANCE_ENABLE = yes // add this to rules.mk
// Tap Dance declarations
enum {
  TD_X,
};

// Tap Dance definitions
tap_dance_action_t tap_dance_actions[] = {
  // Tap once for X, twice for ALT-X
  [TD_X] = ACTION_TAP_DANCE_DOUBLE(KC_X, LALT(KC_X)),
};

//////////////
// LAYOUT  //
////////////

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

  /* Base layer
   * ,--------------------------------------------------------------------------------------------------.
   * | Esc |  1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  |  0  |  -  |  =  |  Backspace  | PScrn|
   * |-------------------------------------------------------------------------------------------+------+
   * | Tab    |  Q  |  W  |  F|  P  |  B  |  J  |  L  |  U  |  Y  |  ^    |  $    |       *      |  Del |
   * |-------------------------------------------------------------------------------------------+------+
   * | LCtrl    |  A  |  R  |  S  |  T  |  G  |  M  |  N  |  E  |  I  |  O  |  BKSP  |   Enter   | HOME |
   * |-------------------------------------------------------------------------------------------+------+
   * | Shift      |  Z  |  X  |  C  |  D  |  V  |  K  |  H  |  ,  |  .  |  /  |   Shift    | Up  |  END |
   * +-------------------------------------------------------------------------┬---┬-------------+------+
   * | LCtrl | LGUI | LAlt |               Space                 | RAlt |  FN  |   | Left  | Dn  | Rght |
   * `-------------------------------------------------------------------------┘   └-------------+------´
   */

  [_BASE] = LAYOUT_65_ansi_blocker( /* Base */
				    QK_GESC, KC_1,  KC_2,  KC_3,  KC_4,  KC_5,  KC_6,  KC_7,  KC_8,  KC_9,  KC_0,  KC_MINS,  KC_EQL,  KC_BSPC,  KC_PSCR,
	    
				    KC_TAB,  KC_Q,  KC_W,  KC_F,  KC_P,  KC_B,  KC_J,  KC_L,  KC_U,  KC_Y,  KC_LBRC,  KC_RBRC,  KC_BSLS, FR_LABK, KC_DEL,

				    OSM(MOD_LCTL),  KC_A,  KC_R,  KC_S,  KC_T,  KC_G,  KC_M,  KC_N,  KC_E,  KC_I,  KC_O,  KC_BSPC,  KC_ENT,  LCTL(KC_HOME),
  
				    OSM(MOD_LSFT),  KC_Z,  KC_X,  KC_C,  KC_D,  KC_V,  KC_K,  KC_H,  KC_COMM,  KC_DOT,  KC_SLSH,  OSM(MOD_RSFT),  KC_UP,  LCTL(KC_END),

				    OSM(MOD_LCTL),  OSM(MOD_LGUI),  OSM(MOD_LALT),  KC_SPC,  OSM(MOD_RALT),  MO(_FN),  KC_LEFT,  KC_DOWN,   KC_RIGHT),

  
  [_GB] = LAYOUT_65_ansi_blocker( /* GB */
				  ____,  LSFT(KC_1),  LSFT(KC_2),  LSFT(KC_3),  LSFT(KC_4),  LSFT(KC_5),  LSFT(KC_6),  LSFT(KC_7),  LSFT(KC_8),  LSFT(KC_9),  LSFT(KC_0),  ____,  ____,  ____,  ____,
      
				  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  KC_SCLN,  KC_QUOT,  KC_BSLS,

				  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,
	   
				  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  OSL(_SPC),  ____,  ____,

				  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____),
    

  [_MOD] = LAYOUT_65_ansi_blocker( /* MOD */
				   ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,

				   ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,

				   ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,
	   
				   ____,  ____,TD(TD_X),____,  GUI_D, ____,  GUI_K,  CTL_H, ____,  ____,  ____,  ____,  ____,  ____,

				   ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____),

  
  [_NUM] = LAYOUT_65_ansi_blocker( /* NUM */
				   ____,  LSFT(KC_1),  LSFT(KC_2),  LSFT(KC_3),  LSFT(KC_4),  LSFT(KC_5),  LSFT(KC_6),  LSFT(KC_7),  LSFT(KC_8),  LSFT(KC_9),  LSFT(KC_0),  ____,  ____,  ____,  ____,

				   ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,

				   ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,
	   
				   ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,

				   ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____),

  
  [_SPC] = LAYOUT_65_ansi_blocker( /* SPC */
				   ____,  KC_1,  KC_2,  KC_3,  KC_4,  KC_5,  KC_6,  KC_7,  KC_8,  KC_9,  KC_0,  ____,  ____,  ____,  ____,

				   ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,

				   ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,
	   
				   ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,

				   ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____),

  
  [_FN] = LAYOUT_65_ansi_blocker( /* FN */
				  QK_GESC,  KC_F1,  KC_F2,  KC_F3,  KC_F4,  KC_F5,  KC_F6,  KC_F7,  KC_F8,  KC_F9,  KC_F10,  KC_F11,  KC_F12,  KC_DEL,  TG(_MOD),

				  ____,   RGB_TOG,  RGB_MOD,  RGB_HUI,  RGB_HUD,  RGB_SAI,  RGB_SAD,  RGB_VAI,  RGB_VAD,  ____,  ____,  ____,  ____,  QK_BOOT,  KC_DEL,

				  CTL_T(KC_CAPS), RGB_SPI,  RGB_SPD,  ____,  ____,  ____,  ____,  TG(_NUM),  TG(_GB),  ____,  ____,  ____,  EE_CLR,  KC_PGDN,
	   
				  KC_LSFT,  ____,   ____,   CW_TOGG,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  ____,  KC_BRIU,  KC_MUTE,

				  ____,  QK_BOOT,   ____,  ____,  ____,  ____,  KC_VOLD,  KC_BRID,  KC_VOLU),
};
