import {
  type Feature,
  FeatureSliderInput,
} from '../../base';

export const sound_radio_noise: Feature<number> = {
  name: 'Radio noise volume',
  category: 'SOUND',
  description: 'Volume of the bloops that play when a radio message is said or received.',
  component: FeatureSliderInput,
};
