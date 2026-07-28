// THIS IS A NOVA SECTOR UI FILE
import {
  CheckboxInput,
  type Feature,
  FeatureColorInput,
  FeatureNumberInput,
  type FeatureToggle,
} from '../../base';

export const echolocation_outline: Feature<string> = {
  name: 'Echo outline color',
  component: FeatureColorInput,
};

export const echolocation_use_echo: FeatureToggle = {
  name: 'Display echo overlay',
  component: CheckboxInput,
};

// IRIS EDIT ADDITION BEGIN - SLOWER_ECHOLOCATION_PREF
export const echolocation_speed: Feature<number> = {
  name: 'Pulse frequency (in seconds)',
  component: FeatureNumberInput,
};

export const echolocation_mult: Feature<number> = {
  name: 'Render duration multiplier',
  component: FeatureNumberInput,
};
// IRIS EDIT ADDITION END
