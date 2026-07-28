// THIS IS A OCULIS UI FILE
import {
  CheckboxInput,
  type Feature,
  type FeatureChoicedServerData,
  type FeatureToggle,
  type FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const ethereal_horns_toggle: FeatureToggle = {
  name: 'Ethereal Horns',
  component: CheckboxInput,
};

export const feature_ethereal_horns: Feature<string> = {
  name: 'Ethereal Horns Selection',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};
