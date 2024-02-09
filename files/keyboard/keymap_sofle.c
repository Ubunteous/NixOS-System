#include QMK_KEYBOARD_H

extern MidiDevice midi_device;
int16_t encoder_val = 0;
static uint8_t midiKnobStep = 10;

#define ____ _______ // shorter transparent keys
#define XXXX XXXXXXX // non-keys

// independant RGB
/* #define SPLIT_LAYER_STATE_ENABLE */

#define ONESHOT_TAP_TOGGLE 2

// Configure the global tapping term (default: 200ms)
#define TAPPING_TERM 200

// Prevent normal rollover on alphas from accidentally triggering mods.
#define IGNORE_MOD_TAP_INTERRUPT

// Enable rapid switch from tap to hold, disables double tap hold auto-repeat.
#define TAPPING_FORCE_HOLD

// Auto Shift and Retro Shift (Auto Shift for Tap Hold).
#undef AUTO_SHIFT_TIMEOUT
#define AUTO_SHIFT_TIMEOUT TAPPING_TERM
#define RETRO_SHIFT 1000

// Enable rapid switch from tap to hold, disables double tap hold auto-repeat
/* #define QUICK_TAP_TERM 0 */

// add this to config.h
/* #define MIDI_BASIC */
/* #define MIDI_ADVANCED */

//////////////
// MOD TAP  //
//////////////

// Left-hand home row mods
#define GUI_A LGUI_T(KC_A)
#define ALT_R LALT_T(KC_R)
#define CTL_S LCTL_T(KC_S)
#define SHT_T LSFT_T(KC_T)

// Right-hand home row mods
#define SFT_N RSFT_T(KC_N)
#define CTL_E RCTL_T(KC_E)
#define ALT_I RALT_T(KC_I)
#define GUI_O RGUI_T(KC_O)

// layers
/* #define ESC_FUN LT(_FUN, KC_GESC) */
#define BSP_NUM LT(_NUM, KC_BSPC)
#define TAB_FUN LT(_FUN, KC_TAB)

#define ENT_SYM LT(_SYM, KC_ENT) // LM(_NUM, MOD_LSFT)
#define SPC_NAV LT(_NAV, KC_SPC)
/* #define DEL_FUN LT(_FUN, KC_DEL) */

/////////////////
// TAP DANCE  //
///////////////

enum {
  TD_X,
};

tap_dance_action_t tap_dance_actions[] = {
  // Tap once for X, twice for ALT-X
  [TD_X] = ACTION_TAP_DANCE_DOUBLE(KC_X, LALT(KC_X)),
};

/////////////
// LAYERS //
///////////

enum layers {
  _COLEMAK_HR,
  _COLEMAK,
  _MIDI,
  
  _FUN,
  _NUM,
  _SYM,
  _NAV,
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  /*
   * COLEMAK
   * ,-----------------------------------------.                    ,-----------------------------------------.
   * | ESC  |   1  |   2  |   3  |   4  |   5  |                    |   6  |   7  |   8  |   9  |   0  |  `   |
   * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
   * | TAB  |   Q  |   W  |   F  |   P  |   G  |                    |   J  |   L  |   U  |   Y  |   ;  | Bspc |
   * |------+------+------+------+------+------|                    |------+------+------+------+------+------|
   * | LCTR |   A  |   R  |   S  |   T  |   D  |-------.    ,-------|   H  |   N  |   E  |   I  |   O  |  '   |
   * |------+------+------+------+------+------|  XXXX |    | ????  |------+------+------+------+------+------|
   * |LShift|   Z  |   X  |   C  |   V  |   B  |-------|    |-------|   K  |   M  |   ,  |   .  |   /  |RShift|
   * `-----------------------------------------/       /     \      \-----------------------------------------'
   *            | LGUI | LAlt | LCTR | Bspc | /Enter  /       \Space \  |RAISE | RCTR | RAlt | RGUI |
   *            |      |      |      |      |/       /         \      \ |      |      |      |      |
   *            `----------------------------------'           '------''---------------------------'
   */
 
  [_COLEMAK_HR] = LAYOUT(
	   QK_GESC,   KC_1,   KC_2,   KC_3,   KC_4,   KC_5,                      KC_6,   KC_7,   KC_8,   KC_9,   KC_0,   KC_PSCR,
	    KC_TAB,   KC_Q,   KC_W,   KC_F,   KC_P,   KC_B,                      KC_J,   KC_L,   KC_U,   KC_Y,KC_SCLN,   KC_BSPC,
      OSM(KC_LCTL),  GUI_A,  ALT_R,  CTL_S,  SHT_T,   KC_G,                      KC_M,  SFT_N,  CTL_E,  ALT_I,  GUI_O,   KC_QUOT,
      OSM(KC_LSFT),   KC_Z,TD(TD_X),  KC_C,   KC_D,   KC_V, XXXX,      QK_BOOT,  KC_K,   KC_H,KC_COMM, KC_DOT,KC_SLSH,   OSM(KC_RSFT),
		   QK_BOOT,   XXXX,QK_GESC,SPC_NAV,TAB_FUN,                   ENT_SYM,BSP_NUM, KC_DEL,   XXXX,   XXXX),

  [_COLEMAK] = LAYOUT(
		  ____,   ____,   ____,   ____,   ____,   ____,                    ____,   ____,   ____,   ____,   ____,   ____,
		  ____,   ____,   ____,   ____,   ____,   ____,                    ____,   ____,   ____,   ____,   ____,   ____,
		  ____,   KC_A,   KC_R,   KC_S,   KC_T,   KC_G,                    KC_M,   KC_N,   KC_E,   KC_I,   KC_O,   KC_QUOT,
		  ____,  ____,    KC_X,   ____,   ____,   ____, ____,      KC_ESC, ____,   ____,   ____,   ____,   ____, OSM(KC_RSFT),
		 OSM(KC_LGUI),OSM(KC_LALT),OSM(KC_LCTL),____,KC_TAB,             KC_ENT,KC_BSPC, OSM(KC_RCTL),OSM(KC_RALT),OSM(KC_RGUI)),

  
  [_MIDI] = LAYOUT(
		   MI_C3,   MI_Cs3,   MI_D3,   MI_Ds3,   MI_E3,   MI_F3,                   MI_Fs3,   MI_G3,   MI_Gs3,   MI_A3,   MI_As3,   MI_B3,
		   MI_C2,   MI_Cs2,   MI_D2,   MI_Ds2,   MI_E2,   MI_F2,                   MI_Fs2,   MI_G2,   MI_Gs2,   MI_A2,   MI_As2,   MI_B2,
		   MI_C1,   MI_Cs1,   MI_D1,   MI_Ds1,   MI_E1,   MI_F1,                   MI_Fs1,   MI_G1,   MI_Gs1,   MI_A1,   MI_As1,   MI_B1,
		   MI_C,    MI_Cs,    MI_D,    MI_Ds,    MI_E,    MI_F, ____,       ____,  MI_Fs,    MI_G,    MI_Gs,    MI_A,    MI_As,    MI_B,
		   XXXX,   MI_ON,  MI_CHND, MI_CHNU,TG(_MIDI),                  KC_VOLD, KC_VOLU,     ____,    ____,     ____),  

  
  [_NUM] = LAYOUT(
	       QK_BOOT,   ____,   ____,   ____,   ____,   ____,                     ____,   ____,   ____,   ____,   ____,   ____,
		  ____,KC_LBRC,LSFT(KC_7),LSFT(KC_8),LSFT(KC_9),KC_RBRC,            ____,   ____,   ____,   ____,   ____,   ____,
		  ____,KC_SCLN,LSFT(KC_4),LSFT(KC_5),LSFT(KC_6),KC_EQL,             ____,KC_RSFT,KC_RCTL,KC_RALT,KC_RGUI,   ____,
		  ____, KC_GRV,LSFT(KC_1),LSFT(KC_2),LSFT(KC_3),KC_BSLS, ____,____, ____,   ____,   ____,   ____,   ____,   ____,
		  ____,  ____,KC_DOT,LSFT(KC_0),KC_MINS,                  ____,   ____,   ____,   ____,   ____),



  
  [_SYM] = LAYOUT(
		  QK_BOOT,   ____,   ____,   ____,   ____,   ____,                   ____,   ____,   ____,   ____,   ____,   ____,
		  ____,LSFT(KC_LBRC),KC_7, KC_8, KC_9,LSFT(KC_RBRC),              ____,   ____,   ____,   ____,   ____,   ____,
		  ____,LSFT(KC_SCLN),KC_4, KC_5, KC_6, LSFT(KC_EQL),              ____,KC_RSFT,KC_RCTL,KC_RALT,KC_RGUI,   ____,
		  ____, LSFT(KC_GRV),KC_1, KC_2, KC_3,LSFT(KC_PIPE), ____, ____,  ____,   ____,   ____,   ____,   ____,   ____,
	          ____,____, KC_9, KC_0,LSFT(KC_MINS),              ____,   ____,   ____,   ____,   ____),

  
  [_NAV] = LAYOUT(
		  QK_BOOT,   ____,   ____,   ____,   ____,   ____,                KC_BRID,KC_BRIU,KC_MUTE,KC_VOLD,KC_VOLU,   TG(_COLEMAK),
		  ____,   ____,   ____,   ____,   ____,   ____,                   ____,KC_BSPC, KC_SPC, KC_ENT,   ____,   TG(_MIDI),
		  ____,KC_LGUI,KC_LALT,KC_LCTL,KC_LSFT,  ____,                 CW_TOGG,KC_LEFT,KC_DOWN,  KC_UP,KC_RGHT,   ____,
		  ____,   ____,   ____,   ____,   ____,   ____, ____,      ____,KC_INS,KC_HOME,KC_PGUP,KC_PGDN, KC_END, KC_DEL,
		  ____,   ____,   ____,   ____,   ____,                   ____,   ____,   ____,   ____,   ____),

  
  [_FUN] = LAYOUT(
		  QK_BOOT,   ____,   ____,   ____,   ____,   ____,                   ____,   ____,   ____,   ____,   ____,   ____,
		  ____,   ____,   ____,   ____,   ____,   ____,                 KC_F12,  KC_F7,  KC_F8,  KC_F9,KC_PSCR,   ____,
		  ____,   ____,KC_RGUI,KC_RALT,KC_RCTL,KC_RSFT,                 KC_F11,  KC_F4,  KC_F5,  KC_F6,KC_SCRL,   ____,
		  ____,   ____,   ____,  ____,    ____,   ____,   ____,   ____, KC_F10,  KC_F1,  KC_F2,  KC_F3,KC_PAUS,   ____,
		  ____,   ____,   ____,   ____,   ____,                   ____,   ____,   ____,   ____,   ____),
  
  
  /* [_] = LAYOUT( */
  /*   ____,   ____,   ____,   ____,   ____,   ____,                   ____,   ____,   ____,   ____,   ____,   ____, */
  /*   ____,   ____,   ____,   ____,   ____,   ____,                   ____,   ____,   ____,   ____,   ____,   ____, */
  /*   ____,   ____,   ____,   ____,   ____,   ____,                   ____,   ____,   ____,   ____,   ____,   ____, */
  /*   ____,   ____,   ____,   ____,   ____,   ____, ____,      ____,  ____,   ____,   ____,   ____,   ____,   ____, */
  /*           ____,   ____,   ____,   ____,   ____,                   ____,   ____,   ____,   ____,   ____ */
  /* 		      ), */
  
};



#ifdef ENCODER_ENABLE

bool encoder_update_user(uint8_t index, bool clockwise) {
  if (index == 0) {
    /* switch (biton32(layer_state)) { */
    /* case ! _MIDI: */
    if (clockwise) {
      /* tap_code(KC_VOLU); */
      tap_code(KC_PGUP);
    } else {
      /* tap_code(KC_VOLD); */
      tap_code(KC_PGDN);
    }
    /* break; */
    /* default: */
    /*   // midi 3 = undefined. use with midi learn */
    /*   if (clockwise) { */
    /*     encoder_val <= 127 - midiKnobStep ? (encoder_val += midiKnobStep) : (encoder_val = 127); */
    /*     midi_send_cc(&midi_device, 0, 3, encoder_val); */
    /*   } else { */
    /*     encoder_val >= midiKnobStep ? (encoder_val -= midiKnobStep) : (encoder_val = 0); */
    /*     midi_send_cc(&midi_device, 0, 3, encoder_val); */
    /*   } */
    /* } */
  }
 
  else if (index == 1) {
    switch (biton32(layer_state)) {
    case ! _MIDI:
      if (clockwise) {
	tap_code(KC_BRIU);
      } else {
	tap_code(KC_BRID);
      }
      break;
    default:
      // midi 1 = modwheel
      if (clockwise) {
	encoder_val <= 127 - midiKnobStep ? (encoder_val += midiKnobStep) : (encoder_val = 127);
	midi_send_cc(&midi_device, 0, 1, encoder_val);
      } else {
	encoder_val >= midiKnobStep ? (encoder_val -= midiKnobStep) : (encoder_val = 0);
	midi_send_cc(&midi_device, 0, 1, encoder_val);
      }
    }
  }
  return true;
}
  
#endif

// onboard led (needs RGBLIGHT_ENABLE rules and config.h settings)
#ifdef RGBLIGHT_ENABLE

void keyboard_post_init_user(void) {
  // Initialize RGB to static black
  rgblight_enable_noeeprom();
  rgblight_sethsv_noeeprom(HSV_BLACK);
  rgblight_mode_noeeprom(RGBLIGHT_MODE_STATIC_LIGHT);
}

void housekeeping_task_user(void) {
  rgblight_setrgb_at(255, 0, 255, 0);
  rgblight_setrgb_at(0, 255, 255, 1);
  /* sethsv(127, 0, 10, (LED_TYPE *)&led[1]); */
}

#endif

// turn off power led
void keyboard_pre_init_user(void) {
  // Set our LED pin as output
  setPinOutput(24);
  // Turn the LED off
  // (Due to technical reasons, high is off and low is on)
  writePinHigh(24);
}

// rules.mk
/* # convert to uf2 file */
/* CONVERT_TO=liatris */

/* # split keyboard features */
/*   SPLIT_KEYBOARD = yes */

/* # encoders */
/*   ENCODER_ENABLE = yes */

/* # audio and system control */
/*   EXTRAKEY_ENABLE = yes */

/* # liatris (led) */
/* # RGBLIGHT_ENABLE = yes # Enables QMK's RGB code */
/* # WS2812_DRIVER = vendor # Use the RP2040's PIO interface */

/*   TAP_DANCE_ENABLE = yes */
/*   CAPS_WORD_ENABLE = yes */
/*   AUTO_SHIFT_ENABLE = yes */
/*   MIDI_ENABLE = yes */

/* # macros: gives access to two macros */
/* # DYNAMIC_MACRO_ENABLE = yes */
/* # DM_REC1 / 2 => record/stop recording */
/* # DM_PLY1 / 2 => play */
/* # DM_RSTP => stop recording */

/* # From miryoku */
/* # MOUSEKEY_ENABLE = yes */
/* # EXTRAKEY_ENABLE = yes */
/* # AUTO_SHIFT_ENABLE = yes */
/* # TAP_DANCE_ENABLE = yes */
/* # CAPS_WORD_ENABLE = yes */
/* # KEY_OVERRIDE_ENABLE = yes */
