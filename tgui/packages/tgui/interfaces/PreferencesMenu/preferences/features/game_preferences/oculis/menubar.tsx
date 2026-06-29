import { CheckboxInput, type FeatureToggle } from '../../base';

export const menubar_enabled: FeatureToggle = {
  name: 'Enable Menubar',
  category: 'UI',
  description: 'Toggles showing of the menu bar at the top.',
  component: CheckboxInput,
};
